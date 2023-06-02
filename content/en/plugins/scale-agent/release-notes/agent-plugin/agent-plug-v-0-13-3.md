---
title: v0.13.3 Armory Agent Clouddriver Plugin (2023-06-01)
toc_hide: true
version: 00.13.03
date: 2023-06-01
---

The following changes were applied for unify just one version of plugin that could work for
the last three spinnaker/armory versions x.28.x, x.29.x, and x.30.x

Changes:
- Use reflection to discover the right KubectlJobExecutor constructor when building KubesvcJobExecutor
- Overload kubesvc operations method to support new and old parameters accros spin/armory versions
