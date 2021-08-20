---
title: Spinnaker Production Environments
---

# Architecture

- Use MySQL compatible database engine
  - Managed services like Aurora provide cross-region replication
- Kubernetes 1.13+ cluster
- Each service has at least 2 replicas to provide basic availability at the Kubernetes level
- Monitoring is optional but strongly recommended.
- Armory provides optional log Spinnaker aggregation for troubleshooting but we also recommend customers to have a log management solution in place.

![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/5yZjTFpEY0VZT_UmU429EI4q.png)





## Kubernetes Considerations

- The Kubernetes cluster sizing recommendations assume that only Spinnaker, its monitoring, and the Kubernetes operator run in the cluster. It also provides extra room for rolling deployments of Spinnaker itself.
- If available, use a cluster with nodes in different availability zones.
- It’s generally better to go with more smaller nodes than fewer larger nodes for the cluster to be more resilient to the loss of nodes. Make sure that nodes are still able to handle the largest pods in terms of CPU and memory.

## Database Considerations

- If available, use cross-region replication to ensure durability of the data stored.
  - Front50’s database contains pipeline definitions and needs to be properly backed up.
  - Orca’s database contains pipeline execution history that is displayed in Spinnaker’s UI.
  - Clouddriver’s database contain your infrastructure cache. If lost, it will need to be re-cached which depending on the size of your infrastructure may take a while. It doesn’t have long term value.
- Make sure the network latency between Spinnaker and the database cluster is reasonable. It often just means located in the same datacenter.
- Clouddriver, Orca, and Front50 services must each use a different database. They can be in different database clusters or in the same. A single cluster is easier to manage and more cost effective but the number of connections used by Spinnaker will be added across all services.
  - Your database cluster must support the number of open connections from Spinnaker and any other tool you need. For numbers refer to the database connections chart in the profiles below.
  - Clouddriver connection pools can be tuned via sql.connectionPools.cacheWriter.maxPoolSize and sql.connectionPools.default.maxPoolSize. Both values default to 20 and need to be increased to handle more tasks per Clouddriver.

## Redis Considerations

Most services rely on Redis for lightweight storage and/or task coordination. Spinnaker does not store many items in Redis as is reflected in the following recommendations. Redis being single threaded doesn’t need more than one CPU.

When available, a managed Redis (like ElastiCache) can be used. A shared Redis can be used for ease of management.



## Spinnaker Settings

To support a high number of API requests, we advise to set the following settings in gate and front50 profiles:

hystrix.threadpool.default.coreSize: x

Where x is given by: maximum API request per seconds * mean response time

We estimated the maximum API request per seconds in the tests below, refer to the Average API Response Time graph below. For instance for 30 request/sec, the coreSize value could be set to: 300 * 0.25 = 75.



# Recommendations

## Installation Types

Many factors come to sizing Spinnaker, for instance:

- Number of active users will impact how to size Gate service.
- Complex pipelines will impact the amount of work the Orca service has to do.
- Different providers (Kubernetes, GCP, AWS,…) come with very different execution profiles for the Clouddriver service.

This document makes the following assumptions:

- Pipelines used to evaluate Spinnaker are simple and made of a Deploy and 2 Wait stages for stage scheduling. If you expect your pipelines to be complex, divide the supported executions by the number of non-trivial expected stages (baking, deploying) in your pipelines.
- API requests simulate potential tool requests as well as user activity. We give number of concurrent users.
- All services run with at least 2 replicas for basic availability. It is possible to run with fewer replicas at the cost of potential outages.

# Base Profile - Kubernetes Deployments

## Recommendations

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







![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/AvnjWl3yr8uVjYIVAqxUA9tO.png)



![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/fsxfPQeuCgiJhboKV3OfKEqt.png)



![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/u5zZs-PXSfYvfik3_7txah4l.png)



### General Service Health



![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/XHv7qVK8jg0VLR_EKMbqcwIl.png)







### Database Connections

![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/8o4l647Z8AWbAPVy8FsxoCKH.png)







### Per Service CPU and Memory

![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/Pz4DysfFxgKmVcc3wxrcnP0i.png)

![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/f_46n1BQ9jo6uxATOO7R8Ip1.png)



![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/G5nSNh-7lTerZX65pGqkHWcS.png)



![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/lgjJ9T_sXPfMkhRL-4rRoTj-.png)



![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/qj52ReMAnwN9pmc1ccKI1VOV.png)

![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/PPbB1LQb209XoRFFTjQLGi8O.png)



![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/qVEF965v_reThDk-DWDIPCVi.png)



![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/_wRVKf-33g4zg7xrKFGRfpAc.png)



![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/6JRkA7jaQ3MPD4CPZ7NpJsD0.png)



![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/_r3q4b8iQX_TLloBK8WiiCy-.png)



![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/dxYui3ub0F_DvBtARCyj_cAU.png)



![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/g6iIiJIxG6xRFKI6BZa98Qrn.png)





### Clouddriver Health

![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/eZr7RBqofRwnJwgaKzUGk0T-.png)



![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/ga6jPqHX0DRK2pOseKjD7GY-.png)



![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/xOrRQYxB573Rh4JtwpIxe4Lj.png)





### Orca Health

![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/k1ABJWLWEyVljo3_jwL5zj_n.png)

![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/Q7oHBn987y0VQsRVECWj10Jb.png)



![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/1i75qNDXZ0W2kDMEZOqcpELt.png)



![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/hjJTYzTprYHBspF_zAEivLUu.png)

![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/v33Z76utuNV_KH-Lo28QF-Bk.png)



![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/zsSxsW7lSdih64XBeycfOzxl.png)



![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/x2ZDI51v058oBNHnUhp0vLBG.png)



![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/RAHCPBlY0TL_ljtFCbP5LC0z.png)





### Gate Health



![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/JwmHaKJq5s6s9lEuQqb-ST8A.png)



![](https://static.slab.com/prod/uploads/n4300ziu/posts/images/B4SlBof74V0_C960sWLrXH4g.png)
