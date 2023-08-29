---
title: v1.0.62 Armory Agent Service (2023-08-29)
toc_hide: true
version: 01.00.62
date: 2023-08-29
---

### Updates:
- Introduces an optional rate-limiting feature to minimize CPU strain during the initialization or expiration of watchers. This feature is off by default and can be activated by configuring both `kubernetes.cacheGroupSize` and `kubernetes.cacheGroupDelayMs`.


> **Note:** This feature is particularly useful for setups with a large number of accounts, where CPU resources may become a bottleneck in the DB and the service itself.
> 
> Adjust settings based on the number of accounts, for example  `kubernetes.cacheGroupSize: 5` and `kubernetes.cacheGroupDelayMs: 5000` waits 5 seconds between initializing the kubernetes watchers every 5 accounts. 
