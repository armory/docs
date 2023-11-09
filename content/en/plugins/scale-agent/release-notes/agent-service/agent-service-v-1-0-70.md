---
title: v1.0.70 Armory Agent Service (2023-11-08)
toc_hide: true
version: 01.00.70
date: 2023-11-08
---

### Fixes
- Fixes an issue with operations when `onlyNamespacedResources = true` and two kinds with the same name exist. For example having `batch/v1` Job and `armory.runnable` Job.
