---
title: v0.6.6 Armory Agent Service (2021-10-07)
toc_hide: true
version: 00.06.06

---

## Fixes
* Watch kubernetes kinds where agent has both "list" and "watch" permissions. Previously only "list" permission was verified, which resulted in repeated errors like "Failed to watch *unstructured.Unstructured: unknown" if a kind had list permission but didn't have watch permission.
