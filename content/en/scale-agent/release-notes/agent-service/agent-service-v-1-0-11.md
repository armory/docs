---
title: v1.0.11 Armory Agent Service (2022-02-14)
toc_hide: true
version: 01.00.11

---

## Improvements

> Requires Agent Plugin must be 0.10.23/0.9.39/0.8.47 or later.


The Agent Service now caches Kubernetes kinds when it registers itself. This can improve performance. 

The default kinds list includes the following:

- ReplicaSet
- Service
- Ingress
- DaemonSet
- Deployment
- Pod
- StatefulSet
- Job
- CronJob
- Event

You can remove kinds from the list with `kubernetes.accounts[].omitKinds` in the Agent configs.