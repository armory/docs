---
title: v0.8.59 Armory Agent Clouddriver Plugin (2022-05-09)
toc_hide: true
version: 00.08.59

---

### Fixes

* Fixed an issue of an Agent instance being unable to register again when an exception was thrown during the first registration. It also allows Agent to register again in cases that a reconnection is issued such as when using `tokenCommand` and the token expires.
