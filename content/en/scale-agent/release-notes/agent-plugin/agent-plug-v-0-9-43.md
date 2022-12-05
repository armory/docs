---
title: v0.9.43 Armory Agent Clouddriver Plugin (2022-03-09)
toc_hide: true
version: 00.09.43
date: 2022-03-09
---

### Changes

* Clouddriver now returns 404 when requesting a non-existent manifest through agent, which matches the behavior of native clouddriver accounts. Previously it was returning 200 with an empty response. This change doesn't have an impact in functionality because orca works on the returned object rather than on the response code.

## Known Issues

* The plugin makes a request to fiat `/sync/roles` endpoint every time an agent connects or accounts are deleted. This can become an issue when having a large number of agents connected to a clouddriver pod that is restarted.
