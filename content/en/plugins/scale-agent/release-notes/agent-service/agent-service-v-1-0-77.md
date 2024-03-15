---
title: v1.0.77 Armory Agent Service (2024-01-29)
toc_hide: true
version: 01.00.77
date: 2024-01-29
---

### Fixes:
- Better REST mapping search when discovery had misses.

> This fix prevents an agent restart in the case of discovery (during start) missing one k8s kind.
