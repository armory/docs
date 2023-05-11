---
title: v1.0.52 Armory Agent Service (2023-04-11)
toc_hide: true
version: 01.00.52
---

Changes:

- Sends amount of replicas on registration; A service account with permissions to list pods, replicaSets, and deployments is required.
- Adds retry mechanism on 409 conflict errors on deploy operation; `kubernetes.retries.enabled` must be true and `kubernetes.retries.maxRetries` greater than 0.

