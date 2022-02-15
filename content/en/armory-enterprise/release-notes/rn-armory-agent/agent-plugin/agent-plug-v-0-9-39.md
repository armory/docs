---
title: v0.9.39 Armory Agent Clouddriver Plugin (2022-02-14)
toc_hide: true
version: 00.09.39

---

## Improvements

The Agent Plugin now sends a list of Kubernetes kinds to get cached when the Agent registers itself to save memory. The default kinds list includes the following:

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
