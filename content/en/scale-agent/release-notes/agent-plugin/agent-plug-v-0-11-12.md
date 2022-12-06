---
title: v0.11.12 Armory Agent Clouddriver Plugin (2022-10-03)
toc_hide: true
version: 00.11.12

---

### Changes
- Adds support for using dns URLs for communication between clouddrivers. Disabled by default, enable it with `kubesvc.cluster-kubernetes.useDNS: true` and `kubesvc.cluster-kubernetes.domainName: <some-domain>` (defaults to cluster.local).
