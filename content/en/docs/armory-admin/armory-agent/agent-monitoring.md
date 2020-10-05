---
title: Monitoring
weight: 5
---

## Prometheus

If `prometheus.enabled` is true, the Agent exposes metrics on port 8008 (`prometheus.port`) on path `/metrics` or `/prometheus_metrics` like other Spinnaker services. Both paths serve the same data.

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

## Grafana

You can import [this Grafana dashboard definition](https://armory.jfrog.io/artifactory/manifests/kubesvc/armory-agent-dashboard.json) to use with Prometheus.
