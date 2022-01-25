---
title: v0.8.40 Armory Agent Clouddriver Plugin (2022-01-21)
toc_hide: true
version: 00.08.40

---

### Fixes
* Fixed a race condition where accounts onboarded by agent were not available in clouddriver, which occured when an internal load balancing process ran exactly at the same time as the initial agent registration.
* Redis errors like "ERR wrong number of arguments for 'subscribe' command" or "class java.util.ArrayList cannot be cast to class java.lang.Long" don't appear anymore after separating redis pools from agent and redis scheduler.

### New
* Clouddriver REST endpoint "/armory/agents" outputs information about all registered agents, which accounts they have and to which clouddriver instance they are connected.
* Clouddriver REST endpoint "/armory/agent/operations/{opId}" outputs details about which pods processed the operation in question and at which times.
