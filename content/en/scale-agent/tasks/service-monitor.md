---
title: Integrate Prometheus
description: >
  Learn how to configure Prometheus to get metrics from the Armory Scale Agent service and display them in a Grafana dashboard.
aliases:
  - /scale-agent/tasks/service-monitor/
---

## Available metrics

If `prometheus.enabled` is true in the Armory Scale Agent service [configuration]({{< ref "scale-agent/reference/config/service-options" >}}), the Armory Scale Agent exposes metrics on port 8008 (`prometheus.port`) on path `/metrics` or `/prometheus_metrics` like other Armory CD services. Both paths serve the same data.

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
