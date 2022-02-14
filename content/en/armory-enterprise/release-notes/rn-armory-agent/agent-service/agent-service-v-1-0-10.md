---
title: v1.0.10 Armory Agent Service (2022-02-14)
toc_hide: true
version: 01.00.10

---

## Fixes

- Fixed an issue where out of bounds index errors occurred while performing operations on manifests, such as deploy or delete.
- Fixed an issue with how the Agent Service waits for Kubernetes resources to be deleted when a delete manifest operation is performed. The Agent Service now only waits until the manifest is deleted if the grace period is not set to a value greater than 0 in the UI.


