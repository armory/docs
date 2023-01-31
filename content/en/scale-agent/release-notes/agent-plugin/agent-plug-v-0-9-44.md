---
title: v0.9.44 Armory Agent Clouddriver Plugin (2022-03-09)
toc_hide: true
version: 00.09.44
date: 2022-03-09
---

### Fixes

* Fixed an issue when having an agent deployment with more than one replica, where only the most recently connected agent was registered with clouddriver and the other replicas registration was lost. This can be verified in the clouddriver endpoint `/armory/agents`.

### Known Issues

* The plugin makes a request to fiat `/sync/roles` endpoint every time an agent connects or accounts are deleted. This can become an issue when having a large number of agents connected to a clouddriver pod that is restarted.
* When using more than one agent replica, if one of the replicas is disconnected its association with clouddriver is never deleted.
* When using more than one agent replica, the endpoint `/armory/agents` incorrectly shows all of them caching the infrastructure, while only one of them watches the cluster.
* When using more than one agent replica, operations are sent to only the most recently registered replica.
