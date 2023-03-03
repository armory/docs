---
title: v0.9.71 Armory Agent Clouddriver Plugin (2022-10-21)
toc_hide: true
version: 00.09.71
date: 2022-10-21
---

Fix to delete logical cluster cache records only when the record is not associated with Kubernetes objects related to the cache event received. This resolves an issue where if a deployment with replicasSets that had 0 pods associated was removed, the replica was dropped from the logical cluster record, and the deployment was not listed in the Spinnaker UI Cluster tab.
