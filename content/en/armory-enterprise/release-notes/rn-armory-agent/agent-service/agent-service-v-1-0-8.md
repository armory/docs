---
title: v1.0.8 Armory Agent Service (2022-02-05)
toc_hide: true
version: 01.00.08

---

### Fixes
* Issue that prevented CRDs from being listed when the flag  was enabled. An accurate definition of CRDs under  is needed for it to work properly when this flag is turned on. e.g.

 If scope is unspecified it defaults to Cluster.
