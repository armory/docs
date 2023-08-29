---
title: v1.0.62 Armory Agent Service (2023-08-29)
toc_hide: true
version: 01.00.62
date: 2023-08-29
---

### Updates:
- Introduces an optional rate-limiting feature to minimize CPU strain during the initialization or expiration of watchers. This feature is off by default and can be activated by configuring both kubernetes.cacheGroupSize and kubernetes.cacheGroupDelayMs.
