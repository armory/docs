---
title: v0.10.52 Armory Agent Clouddriver Plugin (2022-10-10)
toc_hide: true
version: 0.10.52
---

### Changes
Startup fails purposely at start when the endpoint discovery fails to get the clouddriver replicas. Turn off this behavior by setting `kubesvc.cluster-kubernetes.failFast: false`.