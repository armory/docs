---
title: v0.10.56 Armory Agent Clouddriver Plugin (2022-10-21)
toc_hide: true
version: 00.10.56

---

Fix to delete logical cluster cache records only when the record is not associated with k8s objects related to the cache event received. This resolves an issue where if a deployment with replicasSets that had 0 pods associated was removed, the replica was dropped from the logical cluster record, and the deployment was not listed in the Spinnaker UI Cluster tab.
