---
title: v1.0.70 Armory Agent Service (2023-11-08)
toc_hide: true
version: 01.00.70
date: 2023-11-08
---

### Fixes
- Fixes a problem preventing operations on k8s kinds that happened when onlyNamespacedResources = true and a custom resource with cluster scope of the same name exists. For example having batch/v1 Job and armory.runnable Job.
