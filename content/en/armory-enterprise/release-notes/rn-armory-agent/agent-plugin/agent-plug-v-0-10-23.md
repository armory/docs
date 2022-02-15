---
title: v0.10.23 Armory Agent Clouddriver Plugin (2022-02-14)
toc_hide: true
version: 00.10.23

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
