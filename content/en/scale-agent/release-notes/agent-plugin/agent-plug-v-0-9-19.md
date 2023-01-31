---
title: v0.9.19 Armory Agent Clouddriver Plugin (2021-10-22)
toc_hide: true
version: 00.09.19
date: 2021-10-22
---

## Changes
* When migrating accounts from the Kubernetes V2 provider to the Armory Agent, the cache for the V2 provider gets evicted now. The eviction happens in batches. You can tune this behavior with the following parameters:

  * `kubesvc.v2-cache-eviction.disable`: (Boolean) Set this to `true` if you want to turn off the eviction of the V2 cache.
  * `kubesvc.v2-cache-eviction.batch-size`: (Integer) How many Kubernetes kinds to evict for each eviction event. (Default 5)
  * `kubesvc.v2-cache-eviction.millis`: (Integer) The time between evictions in milliseconds. Using a low value can lead to a spike in resource usage when migration occurs. (Default 200)
