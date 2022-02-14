---
title: v1.0.10 Armory Agent Service (2022-02-14)
toc_hide: true
version: 01.00.10

---

Fixes:

- Out of bounds index while performing operations (deploy, delete, ... etc manifest)
- Wait to the kubernetes resource to be deleted when delete manifest operation is performed; it just apply when gracePeriod is not set or greater than 0

