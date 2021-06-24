---
title: Monitor the Armory Agent with Prometheus
linkTitle: Monitor
weight: 70
description: >
  Learn how to configure Prometheus to get metrics from the Armory Agent and display them in a Grafana dashboard.
---
![Proprietary](/images/proprietary.svg)

{{< include "early-access-feature.html" >}}

## Available metrics

| Name | Description |
|-----------|---------------|
|`container_cpu_usage_seconds_total` |  Container CPU usage |
|`container_memory_working_set_bytes` |  Container working set memory usage |
|`go_gc_duration_seconds` |  Amount of time spent in garbage collection |
|`go_goroutines` |  Number of go routines |
|`go_memstats_alloc_bytes` |  Amount of memory allocation used by Go  |
|`go_threads` |  Number of Go threads |
|`kubesvc_connection_count` | Number of connections |
|`kubesvc_disconnection_total` |  Number of disconnections |
|`kubesvc_events_bytes_sent_total` |  Amount of data sent by caching events |
|`kubesvc_events_sent_total` |   Number of caching events sent |
|`kubesvc_resource_agent_total` |  Number of watched/polled resources |

## Configure Prometheus

If `prometheus.enabled` is true in the Agent [configuration]({{< ref "agent-options" >}}), the Agent exposes metrics on port 8008 (`prometheus.port`) on path `/metrics` or `/prometheus_metrics` like other Armory Enterprise services. Both paths serve the same data.

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
