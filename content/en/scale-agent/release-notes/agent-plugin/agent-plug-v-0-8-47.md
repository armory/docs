---
title: v0.8.47 Armory Agent Clouddriver Plugin (2022-02-14)
toc_hide: true
version: 00.08.47

---

## Improvements

> Requires Agent Service 1.0.11

The Agent Plugin now sends a list of Kubernetes kinds to get cached when the Armory Agent registers itself to save memory. The default kinds list includes the following:

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

You can remove kinds from the list with `kubernetes.accounts[].omitKinds` in the Armory Agent configs.

## Known Issues

* The plugin makes a request to fiat `/sync/roles` endpoint every time an agent connects or accounts are deleted. This can become an issue when having a large number of agents connected to a clouddriver pod that is restarted.
