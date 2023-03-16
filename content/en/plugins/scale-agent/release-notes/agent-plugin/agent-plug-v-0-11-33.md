---
title: v0.11.33 Armory Agent Clouddriver Plugin (2023-03-13)
toc_hide: true
version: 00.11.33
date: 2023-03-13
---

### Features:
- Automatically migrates account to Scale Agent when doing a POST request on `/credentials`.
- If account existis in Scale-Agent it can also be deleted and updated using DELETE `/credentias/{account}` and PUT `/credentials` respectively.
- Can be turned on or off with:
```yml
kubesvc:
  dynamicAccounts:
    interceptor:
      enabled: true
```

> Note: This change is compatible with Spinnaker versions >= 1.28.
> See https://spinnaker.io/docs/setup/other_config/accounts/#enabling-account-management for more information.