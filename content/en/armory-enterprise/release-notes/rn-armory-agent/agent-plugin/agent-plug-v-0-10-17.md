---
title: v0.10.17 Armory Agent Clouddriver Plugin (2022-01-25)
toc_hide: true
version: 00.10.17

---

### Changes
* The initial list of namespaces of each account is received from agent upon initial registration. Previously, they were received after the watching mechanism in agent was finished, which now allows to have the list of namespaces available sooner. This change only works when using agent versions 1.0.3 or 0.6.14 and newer.
