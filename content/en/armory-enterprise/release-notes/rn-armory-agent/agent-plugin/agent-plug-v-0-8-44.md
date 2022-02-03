---
title: v0.8.44 Armory Agent Clouddriver Plugin (2022-02-02)
toc_hide: true
version: 00.08.44

---

## Fixes

* Fixed an issue where some deployment pipelines timed out on the "WaitForManifestStable" task, which was caused by a stale cache. The status of the manifest is now read from a live call to the cluster.
* Fixed an issue where pod metrics, if available, were not shown in the UI when clicking on a pod on the **Clusters** page.
