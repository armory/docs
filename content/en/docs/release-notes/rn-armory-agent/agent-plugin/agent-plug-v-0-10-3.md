---
title: v0.10.3 Armory Agent Clouddriver Plugin (2021-10-22)
toc_hide: true
version: 00.10.03

---

## Changes

* When migrating from the Kubernetes V2 provider to the Agent, the cache for the V2 provider gets evicted now. You can tune this behavior with the following parameters:

  * `kubesvc.v2-cache-eviction.disable`: (Boolean) Set this to `true` if you want to disable the eviction of the V2 cache.
  * `kubesvc.v2-cache-eviction.batch-size`: (Integer) How many accounts to evict for each eviction event. (Default 5)
  * `kubesvc.v2-cache-eviction.millis`: (Integer) The time between evictions in milliseconds. (Default 200)