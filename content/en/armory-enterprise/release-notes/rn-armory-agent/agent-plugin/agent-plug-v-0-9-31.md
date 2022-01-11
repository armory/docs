---
title: v0.9.31 Armory Agent Clouddriver Plugin (2022-01-11)
toc_hide: true
version: 00.09.31

---

## New

* The clouddriver identifier used in logs and database that uniquely identifies a replica is now the pod name instead of a UUID. This facilitates correlating logs across different replicas to the right instance.

## Fixes

* This release fixes "Timeout exceeded for operation" errors seeing when running pipelines, which was caused by cloudriver plugin not subscribing to the redis pubsub channel in which operation requests are published. This bug was introduced in plugin version 0.9.27.

## Known issues

After clouddriver restarts the following intermittent errors may happen when running pipelines, which get healed after a few minutes:
* "Timeout exceeded for operation": The cause is different from the cause fixed in this release.
* "Credentials not found"


This error also happens intermittently but is not healed automatically, instead a clouddriver or agent restart can fix it:
* "Access denied to account"
