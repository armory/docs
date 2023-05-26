---
title: Spinnaker Production Environments
toc_hide: true
hide_summary: true
exclude_search: true
---

## Architecture

- Use MySQL compatible database engine
  - Managed services like Aurora provide cross-region replication
- Kubernetes
  - See [System Requirements]({{< ref "continuous-deployment/installation/system-requirements" >}}) for more information
- Each service has at least 2 replicas to provide basic availability at the Kubernetes level
- Monitoring is optional but strongly recommended
- Armory provides optional log Spinnaker aggregation for troubleshooting but we also recommend customers to have a log management solution in place

{{< figure src="/images/prod-recommendations/prod-architecture.png" >}}


### Kubernetes Considerations

- The Kubernetes cluster sizing recommendations assume that only Spinnaker, its monitoring, and the Kubernetes operator run in the cluster. It also provides extra room for rolling deployments of Spinnaker itself.
- If available, use a cluster with nodes in different availability zones.
- It’s generally better to go with more smaller nodes than fewer larger nodes for the cluster to be more resilient to the loss of nodes. Make sure that nodes are still able to handle the largest pods in terms of CPU and memory.

### Database Considerations

- If available, use cross-region replication to ensure durability of the data stored.
  - Front50’s database contains pipeline definitions and needs to be properly backed up.
  - Orca’s database contains pipeline execution history that is displayed in Spinnaker’s UI.
  - Clouddriver’s database contain your infrastructure cache. If lost, it will need to be re-cached which depending on the size of your infrastructure may take a while. It doesn’t have long term value.
- Make sure the network latency between Spinnaker and the database cluster is reasonable. It often just means located in the same datacenter.
- Clouddriver, Orca, and Front50 services must each use a different database. They can be in different database clusters or in the same. A single cluster is easier to manage and more cost effective but the number of connections used by Spinnaker will be added across all services.
  - Your database cluster must support the number of open connections from Spinnaker and any other tool you need. For numbers refer to the database connections chart in the profiles below.
  - Clouddriver connection pools can be tuned via sql.connectionPools.cacheWriter.maxPoolSize and sql.connectionPools.default.maxPoolSize. Both values default to 20 and need to be increased to handle more tasks per Clouddriver.

### Redis Considerations

Most services rely on Redis for lightweight storage and/or task coordination. Spinnaker does not store many items in Redis as is reflected in the following recommendations. Redis being single threaded doesn’t need more than one CPU.

When available, a managed Redis (like ElastiCache) can be used. A shared Redis can be used for ease of management.



### Spinnaker Settings

To support a high number of API requests, we advise to set the following settings in gate and front50 profiles:

hystrix.threadpool.default.coreSize: x

Where x is given by: maximum API request per seconds * mean response time

We estimated the maximum API request per seconds in the tests below, refer to the Average API Response Time graph below. For instance for 30 request/sec, the coreSize value could be set to: 300 * 0.25 = 75.



## Recommendations

### Installation Types

Many factors come to sizing Spinnaker, for instance:

- Number of active users will impact how to size Gate service.
- Complex pipelines will impact the amount of work the Orca service has to do.
- Different providers (Kubernetes, GCP, AWS,…) come with very different execution profiles for the Clouddriver service.

This document makes the following assumptions:

- Pipelines used to evaluate Spinnaker are simple and made of a Deploy and 2 Wait stages for stage scheduling. If you expect your pipelines to be complex, divide the supported executions by the number of non-trivial expected stages (baking, deploying) in your pipelines.
- API requests simulate potential tool requests as well as user activity. We give number of concurrent users.
- All services run with at least 2 replicas for basic availability. It is possible to run with fewer replicas at the cost of potential outages.

## Base Profile - Kubernetes Deployments

### Base profile recommendations

A base deployment of Spinnaker targets organizations with:

- 50 applications
- 250 deployments per day over 5 hour window.
- 30 req/s coming from browser sessions or tools
- 10x burst for both pipelines and API calls.



| **Service** | **Replicas** | **CPU request** | **CPU limit** | **Memory request** | **Memory limits** |
| --- | --- | --- | --- | --- | --- |
| **Clouddriver** | 2 | 2000m | 3000m | 2.0Gi | 2.5Gi |
| **Deck** | 2 | 150m | 300m | 32Mi | 64Mi |
| **Dinghy** | 2 | 500m | 1000m | 0.5Gi | 1.0Gi |
| **Echo** | 2 | 500m | 1000m | 1.0Gi | 1.5Gi |
| **Fiat** | 2 | 500m | 1000m | 0.5Gi | 1.0Gi |
| **Front50** | 2 | 500m | 1000m | 1.0Gi | 1.5Gi |
| **Gate** | 2 | 750m | 1000m | 1.0Gi | 1.5Gi |
| **Kayenta** | 2 | 500m | 1000m | 0.5Gi | 1.0Gi |
| **Igor** | 2 | 500m | 1000m | 0.5Gi | 1.0Gi |
| **Orca** | 2 | 1000m | 1500m | 1.0Gi | 1.5Gi |
| **Rosco** | 2 | 500m | 1000m | 0.5Gi | 1.0Gi |
| **Terraformer** | 2 | 500m | 1000m | 0.5Gi | 1.0Gi |
| **Redis** | 1 | 500m | 1000m | 0.5Gi | 1.0Gi |
| **Total** |  | **16300m** | **28600m** | **18.56Gi** | **31.125Gi** |





##  Load Test: Base Profile (Kubernetes)

### Overview

| **Armory Spinnaker** | **API request/sec - baseline (burst)** | **Pipeline trigger/minute - baseline (burst)** |
| --- | --- | --- |
| **2.17.1** | 30 (300) | 0.834 (8.34) |



{{< figure src="/images/prod-recommendations/pipeline-api-calls.png" >}}
{{< figure src="/images/prod-recommendations/cpu-quota.png" >}}
{{< figure src="/images/prod-recommendations/total-memory.png" >}}

### General Service Health


{{< figure src="/images/prod-recommendations/general-service-health.png" >}}


### Database Connections

{{< figure src="/images/prod-recommendations/db-connections.png" >}}

### Per Service CPU and Memory
{{< figure src="/images/prod-recommendations/clouddriver-container-cpu.png" >}}
{{< figure src="/images/prod-recommendations/clouddriver-jvm-usage.png" >}}
{{< figure src="/images/prod-recommendations/echo-container-cpu.png" >}}
{{< figure src="/images/prod-recommendations/echo-jvm-usage.png" >}}
{{< figure src="/images/prod-recommendations/front50-container-cpu.png" >}}
{{< figure src="/images/prod-recommendations/front50-jvm-usage.png" >}}
{{< figure src="/images/prod-recommendations/gate-container-cpu.png" >}}
{{< figure src="/images/prod-recommendations/gate-jvm-usage" >}}
{{< figure src="/images/prod-recommendations/orca-container-cpu.png" >}}
{{< figure src="/images/prod-recommendations/orca-jvm-usage.png" >}}
{{< figure src="/images/prod-recommendations/redis-container-cpu.png" >}}
{{< figure src="/images/prod-recommendations/redis-jvm-usage.png" >}}





### Clouddriver Health
{{< figure src="/images/prod-recommendations/clouddriver-invocation-latency.png" >}}
{{< figure src="/images/prod-recommendations/kubectl-latency.png" >}}
{{< figure src="/images/prod-recommendations/avg-agent-time.png" >}}


### Orca Health
{{< figure src="/images/prod-recommendations/orca-queue-depth.png" >}}
{{< figure src="/images/prod-recommendations/orca-controller-latency.png" >}}
{{< figure src="/images/prod-recommendations/stages-started.png" >}}
{{< figure src="/images/prod-recommendations/orca-running-task-duration.png" >}}
{{< figure src="/images/prod-recommendations/orca-stage-status.png" >}}
{{< figure src="/images/prod-recommendations/spin-queue.png" >}}
{{< figure src="/images/prod-recommendations/message-lag.png" >}}
{{< figure src="/images/prod-recommendations/orca-active-executions.png" >}}


### Gate Health

{{< figure src="/images/prod-recommendations/gate-latency.png" >}}
{{< figure src="/images/prod-recommendations/front50-latency.png" >}}