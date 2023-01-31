---
title: v0.8.62 Armory Agent Clouddriver Plugin (2022-06-01)
toc_hide: true
version: 00.08.62
date: 2022-06-01
---

### Fixes
- Removed start dependency on `kubernetesCredentialsInitializerSynchronizable`, this allows overriding the standard credentials repository such as when using `account.storage.enabled: true` and `account.storage.kubernetes.enabled: true`.
