---
title: v0.12.9 Armory Agent Clouddriver Plugin (2023-07-20)
toc_hide: true
version: 00.12.09
date: 2023-07-20
---

### Changes
- Allows the option to cache namespaces to reduce calls to the database on account health-checks. Set a value greater than 0 for `kubesvc.cache.namespaceExpiryMinutes` to enable it.
