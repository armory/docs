---
title: v0.8.39 Armory Agent Clouddriver Plugin (2022-01-11)
toc_hide: true
version: 00.08.39

---

## New features 

* You can now correlate information across different logs more easily. The Clouddriver identifier used in logs and the database that identify a replica is now the pod name. Previously, a UUID was used.

## Fixes

* Fixed an issue where `Timeout exceeded for operation` errors occurred when running pipelines. This was caused by the Agent Clouddriver Plugin not subscribing to the Redis pub/sub channel in which operation requests are published. The issue was introduced in plugin version 0.8.35.

## Known issues

## Known issues

{{< include "known-issues/ki-agent-restart.md" >}}

{{< include "known-issues/ki-agent-access-denied.md" >}}

{{< include "known-issues/ki-agent-redis-scheduler.md" >}}