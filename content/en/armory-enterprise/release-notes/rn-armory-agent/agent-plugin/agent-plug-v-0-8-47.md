---
title: v0.8.47 Armory Agent Clouddriver Plugin (2022-02-14)
toc_hide: true
version: 00.08.47

---

A default list of kubernetes kinds to be cached is sent to the agent on registration to save memory. The kinds list is:
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
