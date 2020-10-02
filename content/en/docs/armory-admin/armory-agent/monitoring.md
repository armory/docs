---
title: Monitoring
weight: 5
---

## Prometheus
The Agent can be instrumented with Prometheus if `prometheus.enabled`. It will expose metrics on port 8008 (`prometheus.port`) on path `/metrics` or `/prometheus_metrics` like other Spinnaker services. Both paths serve the same data.

If using the Prometheus operator, you can scrape metrics with:

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
You can also import the following Grafana dashboard definition at [https://armory.jfrog.io/artifactory/manifests/kubesvc/armory-agent-dashboard.json](https://armory.jfrog.io/artifactory/manifests/kubesvc/armory-agent-dashboard.json).
