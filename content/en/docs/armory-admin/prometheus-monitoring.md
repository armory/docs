---
title: Monitoring Spinnaker with Prometheus
description: >
  Monitoring Spinnaker using Prometheus and Grafana
aliases:
  - /docs/spinnaker-install-admin-guides/prometheus-monitoring/
---

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
* Spinnaker is deployed in the `spinnaker` namespace
* Prometheus and Grafana are deployed in the `monitoring` namespace

## Armory versions before 2.20. (OSS 1.20.x)

Armory 2.20 (OSS 1.20.x) introduced changes to metric names and the Monitoring Daemon. These changes are incompatiable with Armory 2.20.x (OSS 1.20.x) and later. If you are using one of those versions, see this page for [2.19.x](https://archive.docs.armory.io/docs/spinnaker-install-admin-guides/prometheus-monitoring/) and earlier.

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

## Configure monitoring using the Observability Plugin 

{{% alert title="Caution" color=warning %}} Before configuring monitoring, read and understand the following information about the security implications.
If any of your services, typically Gate, are exposed to the open internet, there is a
risk that you can publicly expose information. Armory recommends that you filter
these paths at your edge layer in some manner. Be aware of any endpoints you 
expose. Spring boot exposes the health endpoint by default though with some
restrictions on what information is exposed. When auth is enabled, Gate restricts 
access to the endpoints other than `/health`, preventing access to metric data.

For more information on Spring actuators, see the [Monitoring and Management](https://docs.spring.io/spring-boot/docs/current/reference/html/production-ready-features.html#production-ready-monitoring).  

<!-- Spinnaker issue discussing management endpoints: https://github.com/spinnaker/spinnaker/issues/3883--> 
{{% /alert %}}

Armory recommends that you monitor your systems by using the [Armory Observabililty Plugin](https://github.com/armory-plugins/armory-observability-plugin/). This is an open source solution for monitoring Spinnaker. The plugin currently supports the following:

* Adding Prometheus (OpenMetrics) endpoints So spinnaker pods (explained below).
* Sending data to NewRelic (documented on the plugin page). 

Note that the Observability Plugin removes the service name from the metric, which is incompatible with the behavior of the open source Spinnaker Monitoring daemon system. The standard dashboards have not translated at this time in any public repo. It is in constant development.

#### Install the plugin

To install the observability plugin, add a plugin configuration to the profiles
 of your running services:

* Add it for all services in `spinnaker-local.yml` (Halyard installs) or the `spinnaker` profile section (Operator installs).  
* Add it to the services you want to monitor. This local profile should contain the following to enable Prometheus:

```yaml
# These lines are spring-boot configuration to allow access to the metrics
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
        version: 1.1.3
        # This is the basic configuration for prometheus to be enabled
        config.metrics:
          prometheus:
            enabled: true
    repositories:
      armory-observability-plugin-releases:
        url: https://raw.githubusercontent.com/armory-plugins/armory-observability-plugin-releases/master/repositories.json
```

More options for management endpoints and the plugin are available on the [Plugin readme](https://github.com/armory-plugins/armory-observability-plugin).

#### Grant Prometheus permissions

Add permissions for Prometheus by applying the following configuration to your cluster. You can learn more about this process on the
[Prometheus Operator homepage](https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/rbac.md).  

Example config: 

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

Prometheus Operator uses a "ServiceMonitor" to add targets that get scraped for monitoring. The following example config shows how to monitor pods which are using the Observability Plugin to expose the `aop-prometheus` endpoint.  Note that the example contains 
  both the exclusion of certain services (such as Redis) and changes to the Gate endpoint to show you different options.  

These are ONLY examples of potential configurations. They work, but Armory recommends that you understand how 
they operate and find services. Adapt them to your environment.

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
      - spin-dinghy
    matchLabels:
      app: spin
    namespaceSelector:
      any: true

```

Note, the example excludes Gate, the API service, since Gate restricts access to the endpoints unless authenticated (excluding health).  

The following example is for a service monitor for Gate on a different path and using TLS.

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


