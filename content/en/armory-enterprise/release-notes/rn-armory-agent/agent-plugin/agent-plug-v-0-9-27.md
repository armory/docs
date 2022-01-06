---
title: v0.9.27 Armory Agent Clouddriver Plugin (2021-12-30)
toc_hide: true
version: 00.09.27
---

### Fixes

* Fixed an issue where old agent connection information was not properly released after the agent reconnected again, potentially leading to stale agents.
* Fixed an issue where the pub/sub subscription between clouddriver and redis sometimes couldn't be properly restored after a disconnection from redis.
