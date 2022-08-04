---
title: v0.8.46 Armory Agent Clouddriver Plugin (2022-02-09)
toc_hide: true
version: 00.08.46

---

## Fixes

* Fixed an issue where CRD exceptions were cached, which prevented calls to the Armory Agent related to the same Kind.

## Known Issues

* The plugin makes a request to fiat `/sync/roles` endpoint every time an agent connects or accounts are deleted. This can become an issue when having a large number of agents connected to a clouddriver pod that is restarted.
