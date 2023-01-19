---
title: Dynamic Accounts API
description: >
  Learn about the Dynamic Accounts feature in the Armory Scale Agent for Spinnaker and Kubernetes.
---

## Overview of the Dynamic Accounts API

This API gives you the ability to migrate Clouddriver accounts to the Scale Agent. You can use the API to add new accounts as well as modify and delete existing accounts that are managed by the Scale Agent.


## Dynamic Accounts glossary

- **Endpoint**: the URL segment after the Clouddriver root
- **Migrate an account**: move a Clouddriver-managed account to the Scale Agent for management
- **Account**: an abstraction of a target cluster or target set of namespaces within a cluster
- **Credential source**: any source from which credentials/accounts are read
- **Request**: an instruction that isn’t been fulfilled immediately and can have different outcomes; a request can be done through HTTP by the admin or internally by one of the services.

The feature can be turned on or off with boolean values ****`kubesvc.dynamic-accounts.enabled` in clouddriver and `dynamicAccountsEnabled` in k8s Agent config file.
Since these APIs are internal (apart from /credentials) they aren’t exposed through gate, so a tunnel to clouddriver’s service (by default on port 7002) is needed to call these endpoints.



The account lifecycle is represented by the following states:

- Non transient:
  - `INACTIVE`: the initial state, the account is provided but waiting for a migrate operation.
  - `ACTIVE`: the account is being managed and watched by Agent.
  - `FAILED`: indicates a failure when adding or deleting the account.
  - `ORPHANED`: the account is no longer  managed by online agents (this state is usually seen when restarting or bringing down all of the replicas managing that account).
- Transient
  - `TO_MIGRATE`: indicates there was an instruction to migrate such account.
  - `ACTIVATING`: the account has been processed and sent to Agent.
  - `TO_DEACTIVATE`: indicates there was an instruction to deactivate such account.
  - `DEACTIVATING`: the request to stop watching the account has ben sent to Agent.
