---
title: v0.8.51 Armory Agent Clouddriver Plugin (2022-03-09)
toc_hide: true
version: 00.08.51

---

### Changes

* Clouddriver now returns 404 when requesting a non-existent manifest through agent, which matches the behavior of native Clouddriver accounts. Previously it was returning 200 with an empty response. This change doesn't have an impact in functionality because orca works on the returned object rather than on the response code.
