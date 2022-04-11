---
title: v0.8.54 Armory Agent Clouddriver Plugin (2022-03-28)
toc_hide: true
version: 00.08.54

---

### Changes

* The clouddriver `/credentials` endpoint now reads agent accounts directly from the database. Previously, accounts were loaded in memory by a separate process running every 30 seconds, and then `/credentials` endpoint was reading from the in-memory cache. This change enables agent accounts to be available earlier, which fixes some `AccessDenied` errors happening when fiat is enabled and is out of sync with the latest list of accounts.

### Known Issues

* `/credentials` endpoint hits the database twice per account. When having a large number of accounts this can become an issue.
* Agent accounts are not always visible in `/credentials` endpoint, preventing deployments to agent managed accounts.
