---
title: v0.9.54 Armory Agent Clouddriver Plugin (2022-06-01)
toc_hide: true
version: 00.09.54
date: 2022-06-01
---

### Fixes
- Removed start dependency on `kubernetesCredentialsInitializerSynchronizable`, this allows overriding the standard credentials repository such as when using `account.storage.enabled: true` and `account.storage.kubernetes.enabled: true`.
