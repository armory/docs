---
title: v0.8.57 Armory Agent Clouddriver Plugin (2022-04-28)
toc_hide: true
version: 00.08.57

---

### Changes

* Multiple Agent replicas are now supported for HA.
* Improved agent reconnection time to start caching sooner the cluster infrastructure.
* Accounts are now deleted after 10 minutes of not having any agent available to handle them. Previously, accounts were deleted within seconds after the communication between clouddrivers was failing.
* The response of clouddriver endpoint "/armory/agents" only includes live, valid assignments. Previously, it also included old assignments no longer valid, by using the field "clouddriverAlive" to differentiate between them. 

### Fixes

* Fixed an issue when having more than one agent replica, where multiple replicas could cache the infrastructure at the same time. Now only one does the caching (the first one that connects to clouddriver).

