---
title: v1.0.10 Armory Agent Service (2022-02-14)
toc_hide: true
version: 01.00.10

---

Fixes:
- A crashing error due to out of bounds when deleting operations from memory when they already finished.
Adds:
- Wait for the kubernetes resource to be deleted when delete manifest operation is performed; This behavior only applies when  is not set or greater than 0 in the Spinnaker UI. If the grace period is set however, the delete operation will only wait as long as specified.

