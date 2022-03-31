---
title: v0.9.46 Armory Agent Clouddriver Plugin (2022-03-28)
toc_hide: true
version: 00.09.46

---

### Changes

* The clouddriver `/credentials` endpoint now reads agent accounts directly from the database. Previously, accounts were loaded in memory by a separate process running every 30 seconds, and then `/credentials` endpoint was reading from the in-memory cache. This change enables agent accounts to be available earlier, which fixes some `AccessDenied` errors happening when fiat is enabled and is out of sync with the latest list of accounts.

### Reported Issues

* Agent accounts are not visible in `/credentials` endpoint, preventing deployments to agent managed accounts.
