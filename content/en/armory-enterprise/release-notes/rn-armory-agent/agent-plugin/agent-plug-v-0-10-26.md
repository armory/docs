---
title: v0.10.26 Armory Agent Clouddriver Plugin (2022-03-07)
toc_hide: true
version: 00.10.26

---

### Changes

* The Kubernetes kinds that Agent caches are now configurable in `clouddriver.yml` for all accounts:

```
kubesvc:
  cache:
    cacheKinds: []      # (Default: "ReplicaSet", "Service", "Ingress", "DaemonSet", "Deployment", "Pod", "StatefulSet", "Job", "CronJob", "NetworkPolicy"): The list of kubernetes kinds to cache. Each entry uses the format {kind.group}, where group can be omitted for core kubernetes kinds.
    cacheOmitKinds: []  # (Default: empty list): Kinds in this list will not be cached, even if they are in the cacheKinds list.
```

### Fixes

* Fixed an issue where `NetworkPolicies` were not showing in Firewalls screen in Spinnaker UI.
