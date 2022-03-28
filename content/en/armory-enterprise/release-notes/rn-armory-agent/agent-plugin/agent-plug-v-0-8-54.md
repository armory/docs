---
title: v0.8.54 Armory Agent Clouddriver Plugin (2022-03-28)
toc_hide: true
version: 00.08.54

---

Remove the use of credentials cache, which was being updated according to the values under  properties.
For example to active this cache refresh every 3 seconds could have:

This change replace the cache functionality (the  properties are not useful anymore) by polling the information directly from database source. In this way we could have the credentials updated at time without waiting the poller to refresh it.
