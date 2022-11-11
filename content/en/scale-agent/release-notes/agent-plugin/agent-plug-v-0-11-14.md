---
title: v0.11.14 Armory Agent Clouddriver Plugin (2022-10-10)
toc_hide: true
version: 00.11.14
---

### Changes
Startup fails purposely at start when the endpoint discovery fails to get the clouddriver replicas. Turn off this behavior by setting `kubesvc.cluster-kubernetes.failFast: false`.
