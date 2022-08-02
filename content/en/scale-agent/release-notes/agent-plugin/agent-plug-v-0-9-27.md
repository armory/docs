---
title: v0.9.27 Armory Agent Clouddriver Plugin (2021-12-30)
toc_hide: true
version: 00.09.27
---

### Fixes

* Fixed an issue where old Agent connection information was not released after the Armory Agent reconnected, potentially leading to stale Agents.
* Fixed an issue where the pub/sub subscription between Clouddriver and Redis couldn't be restored after a disconnection from Redis.
