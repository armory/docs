---
title: v0.8.45 Armory Agent Clouddriver Plugin (2022-02-08)
toc_hide: true
version: 00.08.45

---

This new feature apply only if Fiat is enable.

Before this when a new agent connection/disconnection happens and it brings the additions or deletion of accounts it never notify Fiat to sync its accounts, and because of it we could present "Access denied" or "Time out" errors while trying to perform an operation using one of the accounts that has been added or deleted.

With this feature each time that:
-  new agent connection is made and the plugin register new accounts
-  an agent get disconnected and the plugin delete the associated accounts
after it will notify Fiat to sync its accounts. It  improve to have zero downtime 
