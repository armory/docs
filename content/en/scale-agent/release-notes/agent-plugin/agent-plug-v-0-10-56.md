---
title: v0.10.56 Armory Agent Clouddriver Plugin (2022-10-21)
toc_hide: true
version: 00.10.56

---

Fix delete logical cluster cache record only when there are indeed not associated k8s objects to the cache event received. Before this change when we have a deployment with replicasSets that has 0 pods associated if we remove one of those replicas the logical cluster record on cache will be drop; making spinnaker UI to not show the deployment under cluster tab.
