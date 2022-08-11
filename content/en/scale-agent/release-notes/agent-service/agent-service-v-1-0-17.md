---
title: v1.0.17 Armory Agent Service (2022-03-07)
toc_hide: true
version: 01.00.17

---

### Changes

* Delete operations processed by agent now return the names of all the Kubernetes objects that were deleted. This doesn’t have impact on existing functionality, and is used to better mimic how native clouddriver Kubernetes accounts work.
