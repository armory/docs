---
title: v0.9.56 Armory Agent Clouddriver Plugin (2022-08-30)
toc_hide: true
version: 00.09.57
date: 2022-08-30
---

### Fixes
Fixes infinite loop of errors when the clouddriver pod isn't found for relaying an operation result. The number of retries can be specified under `kubesvc.operations.retry.maxRetries` property.
