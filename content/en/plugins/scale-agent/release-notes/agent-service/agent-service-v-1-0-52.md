---
title: v1.0.52 Armory Agent Service (2023-04-11)
toc_hide: true
version: 01.00.52
---

Changes:

- Send amount of replicas on registration; this need a service account with permissions to list pods, replicaSets, and deployments attached to agent pod
- Add retry mechanism when 409 conflict error on deploy operation; it is enable just if  is set to true and  is greater than 0

