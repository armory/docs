---
title: v0.9.37 Armory Agent Clouddriver Plugin (2022-02-08)
toc_hide: true
version: 00.09.37

---

## Changes

> This change only affects instances where Fiat is enabled.

Agent now notifies Fiat to sync accounts when one of the following occurs:

- A new agent connects, and the plugin registers new accounts.
- An agent disconnects, and the plugin deletes the associated accounts.

This reduces downtime.

Prior to this change, Agent did not notify Fiat to sync accounts when a new agent connects (adding an account) or an existing agent disconnects (deleting an account). This led to situations where an `Access denied` or `Time out` error occurred while trying to perform an operation using one of the accounts that had been added or deleted. Intermittent `Access denied` errors may still occur if Armory Enterprise (Spinnaker™) does not have at least one role configured.