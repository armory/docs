---
title: v0.9.46 Armory Agent Clouddriver Plugin (2022-03-28)
toc_hide: true
version: 00.09.46

---

Remove the use of credentials cache, which was being updated according to the values under  properties.
For example to active this cache refresh every 3 seconds could have:

This change replace the cache functionality (the  properties are not useful anymore) by polling the information directly from database source. In this way we could have the credentials updated at time without waiting the poller to refresh it.
