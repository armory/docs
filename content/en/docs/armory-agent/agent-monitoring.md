---
title: Monitor the Armory Agent with Prometheus
linkTitle: Monitor
weight: 70
tags: ["Kubernetes", "Spinnaker", "Monitoring"]
categories: ["Agent"]
description: >
  Learn how to configure Prometheus to get metrics from the Armory Agent and display them in a Grafana dashboard.
---
![Proprietary](/images/proprietary.svg)

{{< include "early-access-feature.html" >}}

## Available metrics

If `prometheus.enabled` is true in the Agent [configuration]({{< ref "agent-options" >}}), the Agent exposes metrics on port 8008 (`prometheus.port`) on path `/metrics` or `/prometheus_metrics` like other Armory Enterprise services. Both paths serve the same data.

{{% csv-table ";" "/static/csv/agent/monitor-metrics.csv" %}}

## Configure Prometheus

If you are using the Prometheus operator, you can scrape metrics with:

```yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  labels:
    app: spin
  name: armory-agent-service-monitor
spec:
  endpoints:
    - path: /prometheus_metrics
      port: metrics
#    - path: /metrics
#      port: metrics
  selector:
    app: spin
```

## Import a Grafana dashboard

You can import [this Grafana dashboard definition](https://armory.jfrog.io/artifactory/manifests/kubesvc/armory-agent-dashboard.json) to use with Prometheus.
