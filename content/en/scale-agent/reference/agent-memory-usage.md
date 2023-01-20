---
title: Armory Scale Agent Resource Usage
linkTitle: Agent Memory Usage
description: "Agent memory usage reference"
---
Consider the following tested resource usage metrics for the Armory Scale Agent. This data is derived from testing five agent instances, with an 100 account load, and 100 pipelines per account. The instances were tested with 4 vCPUs and 8 GB of memory configured.

## Test case details
* 5 Agent instances (v1.0.18):
  * Accounts: 100 per agent
  * Kubernetes kinds:
    * DaemonSet
    * Deployment
    * Job
    * Pod
    * ReplicaSet
    * Service
    * StatefulSet
    * CronJob
    * NetworkPolicy
    * Ingress
  * Dynamic namespaces: 50
  * 8 Clouddriver instances:
    * 1 deployment per account every minute
    * 1 deletion per account every minute

## Resource usage
### Memory
| Time Lapse         | Max    | Min    |
| ------------------ | ------ | ------ |
| 0 - 1h             | 7.5 Gb | 6 Gb   |
| ~1h -168h (7 days) | 4.5 Gb | 3.4 Gb |

 ### CPU 
| Time Lapse          | Max       | Min      |
| ------------------- | --------- | -------- |
| 0 - 20m             | 1000 mCPU | 750 mCPU |
| ~20m -168h (7 days) | 260 mCPU  | 110 mCPU |