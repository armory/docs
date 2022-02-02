---
title: v1.0.6 Armory Agent Service (2022-02-02)
toc_hide: true
version: 01.00.06

---

## Fixes

* Fixed an issue where non-namespaced resources had `default` instead of an empty one. This prevented operations on them or related to those kinds, such as deploying `CustomResources`.
