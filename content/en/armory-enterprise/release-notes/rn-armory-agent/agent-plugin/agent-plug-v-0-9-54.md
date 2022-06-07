---
title: v0.9.54 Armory Agent Clouddriver Plugin (2022-06-01)
toc_hide: true
version: 00.09.54

---

### Fixes
- removed start dependency on kubernetesCredentialsInitializerSynchronizable, this allows overriding the standard credentials repository such as when using account.storage.enabled: true and account.storage.kubernetes.enabled: true.
