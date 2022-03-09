---
title: v0.9.43 Armory Agent Clouddriver Plugin (2022-03-09)
toc_hide: true
version: 00.09.43

---

The change is returning a 404 on delete operations for objects that don’t exist; before it was returning a 200 with an empty manifest, which also doesn’t have any impact on functionality.
