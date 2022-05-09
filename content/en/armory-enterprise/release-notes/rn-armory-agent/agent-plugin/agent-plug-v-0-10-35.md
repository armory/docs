---
title: v0.10.35 Armory Agent Clouddriver Plugin (2022-05-09)
toc_hide: true
version: 00.10.35

---

### Fixes

* Fixed an issue when an exception being thrown during Agent registration would cause that Agent instance to not be able to register again. It also allows Agent to register again in cases that a reconnection is issued such as when using  and the token expires.
