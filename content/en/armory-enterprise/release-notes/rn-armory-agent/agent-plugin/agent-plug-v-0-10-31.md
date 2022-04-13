---
title: v0.10.31 Armory Agent Clouddriver Plugin (2022-04-13)
toc_hide: true
version: 00.10.31

---

### Fixes

* Fixed an issue where under some circumstances the clouddriver `/credentials` endpoint doesn’t return kubernetes accounts.

### Known Issues

* Clouddriver `/credentials` endpoint hits the database twice per account. When having a large number of accounts this can become an issue.
* The plugin makes a request to fiat `/sync/roles` endpoint every time an agent connects or accounts are deleted. This can become an issue when having a large number of agents and clouddriver restarts.
