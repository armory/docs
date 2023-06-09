---
title: Monitor Armory Continuous Deployment with Prometheus
linkTitle: Monitor with Prometheus
description: >
  Monitor Armory Continuous Deployment using Prometheus and Grafana.
---

## Overview

Armory recommends monitoring the health of Armory Continuous Deployment in every
production instance. This document describes how to set up a basic
[Prometheus](https://prometheus.io/) and [Grafana](https://grafana.com/) stack
as well as enable monitoring for the Armory Continuous Deployment services.

Additional Prometheus and Grafana configuration is necessary to make them
production-grade, and this configuration is not a part of this document. Also
note that monitoring the Pipelines-as-Code service (Dinghy) and the Terraform
Integration service (Terraformer) are not discussed on this page.

## {{% heading "prereq" %}}

* You are familiar with Prometheus and Grafana
* Armory Continuous Deployment is deployed in the `spinnaker` namespace
* Prometheus and Grafana are deployed in the `monitoring` namespace
* You have [configured monitoring using the Observability Plugin]({{< ref "observability-configure.md" >}}).

## Use `kube-prometheus` to create a monitoring stack

You can skip this section if you already have a monitoring stack.

A quick and easy way to configure a cluster monitoring solution is to use `kube-prometheus`. This project creates a monitoring stack that includes cluster monitoring with Prometheus and dashboards with Grafana.

To create the stack, follow the [kube-prometheus quick start](https://github.com/coreos/kube-prometheus#kubernetes-compatibility-matrix) instructions beginning with the _Compatibility Matrix_ section.

After you complete the instructions, you have pods running in the `monitoring` namespace:

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

Access the Prometheus web interface by using the `kubectl port-forward` command. If you want to expose this interface for others to use, create an ingress service. Make sure you nable security controls that follow Prometheus best practices.

```bash
% kubectl --namespace monitoring port-forward svc/prometheus-k8s 9090 &
```

Navigate to `http://localhost:9090/targets`.

## Grant Prometheus RBAC permissions

There are two steps to configure Prometheus to monitor Armory Continuous Deployment:

- Add permissions for Prometheus to talk to the Spinnaker namespace
- Configure Prometheus to discover the Armory Continuous Deployment endpoints

Add permissions for Prometheus by applying the following configuration to your cluster. You can learn more about this process on the
[Prometheus Operator homepage](https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/rbac.md).  

Example config:

```yaml
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  # name can be either prometheus or prometheus-k8s depending on the version of the prometheus-operator
  name: prometheus
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  # name can be either prometheus or prometheus-k8s depending on the version of the prometheus-operator
  name: prometheus
subjects:
  - kind: ServiceAccount
    # name can be either prometheus or prometheus-k8s depending on the version of the prometheus-operator
    name: prometheus-k8s
    namespace: monitoring
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRole
metadata:
  # name can be either prometheus or prometheus-k8s depending on the version of the prometheus-operator
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
  # name can be either prometheus or prometheus-k8s depending on the version of the prometheus-operator
  name: prometheus-k8s
```

### Add the ServiceMonitor

Prometheus Operator uses a "ServiceMonitor" to add targets that get scraped for monitoring. The following example config shows how to monitor pods that are using the Observability Plugin to expose the `aop-prometheus` endpoint. Note that the example contains both the exclusion of certain services (such as Redis) and changes to the Gate endpoint to show you different options.  

These are examples of potential configurations. Use them as a starting point. Armory recommends that you understand how they operate and find services. Adapt them to your environment.

```yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  labels:
    app: spin
    # This label is here to match the prometheus operator serviceMonitorSelector attribute
    # prometheus.prometheusSpec.serviceMonitorSelector. For more information, see
    # https://github.com/helm/charts/tree/master/stable/prometheus-operator
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
```

The example excludes Gate, the API service since Gate restricts access to the endpoints unless authenticated (excluding health).  

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
    # This label is here to match the prometheus operator serviceMonitorSelector attribute
    # prometheus.prometheusSpec.serviceMonitorSelector
    # https://github.com/helm/charts/tree/master/stable/prometheus-operator
    release: prometheus-operator
spec:
  selector:
    matchLabels:
      cluster: spin-gate
  endpoints:
  - interval: 10s
    path: "/api/v1/aop-prometheus"
    # If Prometheus returns the error "http: server gave HTTP response to HTTPS client" then
    # replace scheme with targetPort:
    # Note that "port" is string only. "targetPort" is integer or string.
    # For example, targetPort: 8084
    scheme: "https"
    tlsConfig:
      insecureSkipVerify: true
```
## Check for Armory Continuous Deployment targets in Prometheus

After applying these changes, you should be able to see  Armory Continuous Deployment targets in Prometheus. It may take 3 to 5 minutes for this to show up depending on where Prometheus is in its config polling interval.

![Prometheus Targets](/images/prometheus-2.png)

## Access Grafana

Configure port forwarding for Grafana:

```bash
$ kubectl --namespace monitoring port-forward svc/grafana 3000
```

Access the Grafana web interface via http://localhost:3000 and use the default Grafana username and password of `admin:admin`.

## Add Armory dashboards to Grafana

Armory provides some sample dashboards (in JSON format) that you can import into Grafana as a starting point for metrics to graph for monitoring. Armory has additional dashboards that are available to Armory customers. You can skip this section if you are a Grafana expert.

To import the sample dashboards, perform the following steps:

1. Git clone this repo to your local workstation: (https://github.com/uneeq-oss/spinnaker-mixin)
2. Access the Grafana web interface (as shown above)
3. Navigate to Dashboards then Manage
4. Click on the _Import_ button
5. Upload the one or more of the sample dashboard files from the repo you cloned

After importing the dashboards, you can explore graphs for each service by clicking on **Dashboards > Manage > Spinnaker Kubernetes Details**.

![Grafana Dashboard](/images/grafana-2.png)


## Available metrics by service

>Disclaimer: the following tables may not contain every available metric for each service.

### Clouddriver

{{% csv-table "|" "/static/csv/metrics/metrics-clouddriver.csv" %}}

### Echo

{{% csv-table "|" "/static/csv/metrics/metrics-echo.csv" %}}

### Fiat

{{% csv-table "|" "/static/csv/metrics/metrics-fiat.csv" %}}

### Front50

{{% csv-table "|" "/static/csv/metrics/metrics-front50.csv" %}}

### Gate

{{% csv-table "|" "/static/csv/metrics/metrics-gate.csv" %}}

### Igor

{{% csv-table "|" "/static/csv/metrics/metrics-igor.csv" %}}

### Kayenta

{{% csv-table "|" "/static/csv/metrics/metrics-kayenta.csv" %}}

### Orca

{{% csv-table "|" "/static/csv/metrics/metrics-orca.csv" %}}

### Rosco

{{% csv-table "|" "/static/csv/metrics/metrics-rosco.csv" %}}
