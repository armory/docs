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

### Errors after a restart

After Clouddriver restarts, the following intermittent errors may happen when running pipelines:

* `Timeout exceeded for operation`: The cause of this instance of the error is different from the issue fixed in this release.
* `Credentials not found`

Both of these issues resolve themselves after a few minutes.

### Access denied error

You may encounter the following error intermittently: `Access denied to account`. To resolve the issue, restart CLouddriver or the Agent.