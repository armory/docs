---
title: v1.0.10 Armory Agent Service (2022-02-14)
toc_hide: true
version: 01.00.10

---

## Changes
- The Agent Service now waits for Kubernetes resources to be deleted when a delete manifest operation is performed if you do not set a grace period greater than 0 in the UI.

## Fixes

- Fixed an issue where crashes occurred due to out of bounds index errors that occurred while performing operations on manifests, such as deploy or delete.
