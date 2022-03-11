---
title: v0.10.28 Armory Agent Clouddriver Plugin (2022-03-09)
toc_hide: true
version: 00.10.28

---

### Fixes

* Fixed an issue when having an agent deployment with more than one replica, where only the most recently connected agent was registered with clouddriver and the other replicas registration was lost. This can be verified in the clouddriver endpoint `/armory/agents`.
