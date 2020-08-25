---
title: Monitoring Spinnaker with Prometheus
order: 920
description: >
  Monitoring Spinnaker using Prometheus and Grafana
---

{{% alert title="Warning" color="warning" %}}There is a known issue with metric names in version 2.20.x. Until this issue is resolved, any dashboards created from the instructions on this page will not work. For more information, see the release notes for your version, such as [2.20.5]({{< ref "armoryspinnaker_v2-20-5#spinnaker-metrics" >}}). {{% /alert %}}

## Overview

Armory recommends using a monitoring solution to confirm the health of Spinnaker for every production instance. This
 document describes how to set up a basic [Prometheus](https://prometheus.io/) and [Grafana](https://grafana.com/) stack 
 along with enabling monitoring for the Spinnaker microservices. 
 
 Spinnaker has traditionally used a monitoring daemon sidecar to translate Netflix specific
 metric data into a format for other monitoring platforms.  This project seems to be abandoned at this time
 in favor of plugins for micrometer.  For legacy use, these sidecar pods provide a metrics endpoint 
 that Prometheus reads and Grafana graphs. Additional Prometheus and Grafana configuration is necessary to make them 
 production-grade, and this configuration is not a part of this document.

## Assumptions

* You are familiar with Prometheus and Grafana
* Spinnaker is deployed in the spinnaker namespace
* Prometheus and Grafana are (or will be) deployed in the monitoring namespace


## Use `kube-prometheus` to create a monitoring stack

You can skip this section if you already have a monitoring stack.

A quick and easy way to configure a cluster monitoring solution is to use `kube-prometheus`. This project creates a monitoring stack that includes cluster monitoring with Prometheus and dashboards with Grafana.

To create the stack, follow the [kube-prometheus quick start](https://github.com/coreos/kube-prometheus#kubernetes-compatibility-matrix) instructions beginning with the _Compatibility Matrix_ section.

After you complete the instructions, you have pods running in the `monitoring` namespace.

```bash
% kubectl get pods --namespace monitoring

NAME                                  READY   STATUS    RESTARTS   AGE
alertmanager-main-0                   2/2     Running   0          44s
alertmanager-main-1                   2/2     Running   0          44s
alertmanager-main-2                   2/2     Running   0          44s
grafana-77978cbbdc-x5rsq              1/1     Running   0          40s
kube-state-metrics-7f6d7b46b4-crzx2   3/3     Running   0          40s
node-exporter-nrc88                   2/2     Running   0          41s
prometheus-adapter-68698bc948-bl7p8   1/1     Running   0          40s
prometheus-k8s-0                      3/3     Running   1          39s
prometheus-k8s-1                      3/3     Running   1          39s
prometheus-operator-6685db5c6-qfpbj   1/1     Running   0          106s

```

Access the Prometheus web interface by using the `kubectl port-forward` command. NOTE: if you want to expose this interface for others to use, create an ingress service. Before doing that, enable security controls following Prometheus best practices.

```bash
% kubectl --namespace monitoring port-forward svc/prometheus-k8s 9090 &
```

Navigate to `http://localhost:9090/targets`.

## Configure monitoring using the Observability Plugin (recommended)

*CAUTION!!  You should be aware of a security impact of these settings*
> IF any of your services, typically gate, are exposed to the open internet, there is a
> risk that you can publicly expose information.  It's recommended that you filter
> these paths at your edge layer in some manner.  Be very aware of any endpoints you 
> expose.  Spring boot already exposes the health endpoint by default though with some
> restrictions on what information is exposed.  When auth is enabled gate restricts 
> access to the endpoints other than /health preventing access to metric data.
> There is an issue on the plugin to expose metrics without security allowing scraping, but will
> also increase a risk of exposure.
>  >
> * For more information on spring actuators 
> and information, see the [Monitoring and Management](https://docs.spring.io/spring-boot/docs/current/reference/html/production-ready-features.html#production-ready-monitoring)
> page on springs documentation site.  
> * Plugin issue discussing auth endpoint issues: https://github.com/armory-plugins/armory-observability-plugin/issues/20
> * Spinnaker issue discussing management endpoints: https://github.com/spinnaker/spinnaker/issues/3883

We recommend that you monitor your systems by using the [Armory Observabililty Plugin](https://github.com/armory-plugins/armory-observability-plugin/)
 This is an open source solution to provide monitoring of spinnaker.  It currently supports
 * Adding Prometheus (OpenMetrics) endpoints to spinnaker pods (explained below)
 * Sending data to NewRelic (documented on the plugin page). 

> though we recommend this plugin, the plugin removes the service name from the metric vs. the OSS daemon system.  The standard dashboards have not translated at this time in any public repo.  It's in constant development
> so continue to check back!

#### Install the plugin

To install the observability plugin you'll need to add a plugin configuration to the profiles
 of your running services.  This can be done by adding a global "spinnaker-local.yml" 
 file in halyard or by adding it to the spinnaker operator "spinnaker" profile.  It can also be set per
 service directly as needed.  This local profile should contain the following to enable prometheus:
 
```yaml
#These lines are spring-boot configuration to allow access to the metrics
# endpoints.  This plugin adds the "aop-prometheus" endpoint on the 
# "<service>:<port>/aop-prometheus" path. 

management:
  endpoints:
    web:
      # READ THE SECURITY WARNING ABOVE ON THIS!
      exposure.include: health,info,aop-prometheus
spinnaker:
  extensibility:
    plugins:
      Armory.ObservabilityPlugin:
        # THIS Is absolutely required, though potentially redundant, otherwise the plugin won't start
        enabled: true
        version: 1.0.0
        # This is the basic configuration for prometheus to be enabled
        config.metrics:
          prometheus:
            enabled: true
    repositories:
      armory-observability-plugin-releases:
        url: https://raw.githubusercontent.com/armory-plugins/armory-observability-plugin-releases/master/repositories.json
```
More options for management endpoints and the plugin are available on the plugin homepage.


####  Grant prometheus permissions 
Add permissions for Prometheus by applying the following configuration to your cluster.  This is documented
in more depth at the [Prometheus Operator homepage](https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/rbac.md).  

```yaml
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: prometheus
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: prometheus
subjects:
  - kind: ServiceAccount
    name: prometheus
    namespace: monitoring
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRole
metadata:
  name: prometheus
rules:
- apiGroups: [""]
  resources:
  - nodes
  - nodes/metrics
  - services
  - endpoints
  - pods
  verbs: ["get", "list", "watch"]
- apiGroups: [""]
  resources:
  - configmaps
  verbs: ["get"]
- nonResourceURLs: ["/metrics"]
  verbs: ["get"]
---
apiVersion: v1
kind: ServiceAccount
metadata:
  namespace: monitoring
  name: prometheus
```

#### Add the ServiceMonitor
Prometheus Operator uses a "ServiceMonitor" to add targets to be scraped for monitoring.  Below is a sample
 showing how to monitor pods which are using the plugin to expose the aop-prometheus endpoint.  Note this has
  both exclusion of certain services (aka redis) and changes the gate endpoint to show different options.  

These are ONLY examples of potential configurations and though they work it is recommended that you understand how 
they operate and find services.  You'll want to change these settings and adapt them to your environment.

```yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  labels:
    app: spin
    release: prometheus-operator
  name: spinnaker-all-metrics
  namespace: spinnaker
spec:
  endpoints:
  - interval: 10s
    path: /aop-prometheus
  selector:
    matchExpressions:
    - key: cluster
      operator: NotIn
      values:
      - spin-gate
      - spin-gate-api
      - spin-gate-custom
      - spin-deck
      - spin-deck-custom
      - spin-redis
      - spin-terraformer
    matchLabels:
      app: spin
    namespaceSelector:
      any: true

```

Note, we exclude gate in the above as gate restricts access to the endpoints unless authenticated (excluding health).  
There is work being done to find a work-around to allow metrics to be scraped on gate.  Below is an example 
service monitor for gate on a different path and using TLS.

Once these are applied, you can port forward prometheus and validate that prometheus
has discovered and scraped targets as appropriate.


```yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: spinnaker-internal-metrics
  namespace: spinnaker
  labels:
    app: spin
    # this label is here to match the prometheus operator serviceMonitorSelector attribute
    # prometheus.prometheusSpec.serviceMonitorSelector
    # https://github.com/helm/charts/tree/master/stable/prometheus-operator
    release: prometheus-operator
spec:
  selector:
    matchLabels:
      cluster: spin-gate
      app.kubernetes.io/name: gate
    namespaceSelector:
      any: true
  endpoints:
  # "port" is string only. "targetPort" is integer or string.
  - interval: 10s
    path: "/api/v1/aop-prometheus"
    scheme: "https"
    tlsConfig:
      insecureSkipVerify: true
```


## Configure monitoring in Spinnaker using the legacy implementation

To enable monitoring of Spinnaker by Prometheus, enable the `metric-stores` configuration.

**Halyard**

Issue these halyard commands from within your hal directory or within your halyard container:

```bash
halyard-0:~ $ hal config metric-stores prometheus enable

+ Get current deployment
  Success
+ Edit prometheus metric store
  Success
+ Successfully enabled prometheus

halyard-0:~ $ hal deploy apply
```

**Operator**
```yaml
  apiVersion: spinnaker.armory.io/v1alpha2
  kind: SpinnakerService
  metadata:
    name: spinnaker
  spec:
    spinnakerConfig:  
      config:
        metricStores:
          prometheus:
            enabled: true
            add_source_metalabels: true          
```

Wait for all of the Spinnaker pods to be ready before proceeding to the next step. You can check the status by running the `kubectl get pods` command.  Because you are adding a sidecar to each pod, you may need to ensure you have enough capacity in your Kubernetes cluster to be able to support the additional resource requirements.

##  Configure Prometheus to monitor Spinnaker (legacy)

There are two steps to configure Prometheus to monitor Spinnaker:

- Add permissions for Prometheus to talk to the Spinnaker namespace
- Configure Prometheus to find the Spinnaker endpoints

Add permissions for Prometheus by applying the following configuration to your cluster:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: prometheus-k8s
  namespace: spinnaker
rules:
- apiGroups:
  - ""
  resources:
  - services
  - endpoints
  - pods
  verbs:
  - get
  - list
  - watch
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: prometheus-k8s
  namespace: spinnaker
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: prometheus-k8s
subjects:
- kind: ServiceAccount
  name: prometheus-k8s
  namespace: monitoring
```

Configure Prometheus to find the Spinnaker metrics endpoints by applying this to your spinnaker namespace:

```yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: spinnaker-all-metrics
  labels:
    app: spin
    # this label is here to match the prometheus operator serviceMonitorSelector attribute
    # prometheus.prometheusSpec.serviceMonitorSelector
    # https://github.com/helm/charts/tree/master/stable/prometheus-operator
    release: prometheus-operator
spec:
  selector:
    matchLabels:
      app: spin
    namespaceSelector:
      any: true
  endpoints:
  # "port" is string only. "targetPort" is integer or string.
  - targetPort: 8008
    interval: 10s
    path: "/prometheus_metrics"
```

## Check for Spinnaker targets in Prometheus

After applying these changes, you should be able to see  Spinnaker targets in Prometheus. It may take 3 to 5 minutes for this to show up depending on where Prometheus is in its config polling interval.

![Prometheus Targets](/images/install-admin/prometheus.png)

## Access Grafana

Configure port forwarding for Grafana:

```bash
$ kubectl --namespace monitoring port-forward svc/grafana 3000
```

Access the Grafana web interface via http://localhost:3000 and use the default grafana user:password of `admin:admin`.

## Add Armory dashboards to Grafana

Armory provides some sample dashboards (in JSON format) that you can import into Grafana as a starting point for metrics to graph for monitoring. 
Armory has additional dashboards that are availabe to Armory customers. You can skip this section if you are a Grafana expert.

To import the sample dashboards, perform the following steps: 

1. Git clone this repo to your local workstation: (https://github.com/spinnaker/spinnaker-monitoring)
2. Access the Grafana web interface (as shown above)
3. Navigate to Dashboards then Manage
4. Click on the _Import_ button
5. Upload the one or more of the sample dashboard files from the repo you cloned

After importing the dashboards, you can explore graphs for each service by clicking on _Dashboards_, _Manage_, and then _Spinnaker-main_.

![Grafana Dashboard](/images/install-admin/grafana.png)

> A word of caution.  Metric names changed recently (with 2.20) and OSS grafana dashboards often don't work.
> The entire monitoring project is "deprecated" in favor of using plugins to inject micrometer libarries.  
> As such, to use "updated" dashboards that work in 2.20+, you'll want to look at this [PR](https://github.com/spinnaker/spinnaker-monitoring/pull/247)
> The dashboards are available in an armory fork here: https://github.com/armory-io/spinnaker-monitoring/tree/UpdatedDashboards/spinnaker-monitoring-third-party/third_party/prometheus