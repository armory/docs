---
title: Migrate Clouddriver database Accounts to Agent
linkTitle: Dynamic Accounts
description: >
  Learn how to dynamically migrate account definitions from Clouddriver to the Armory Scale Agent.
---
## What are Dynamic accounts?
Dynamic accounts are migrated from the Clouddriver to the Armory Scale Agent. The credential source and account storage endpoints, provided in the {{< linkWithTitle "dynamic-accounts.md" >}}), are used to migrate and manage the account lifecycle on the Agent in a dedicated table (`clouddriver.kubesvc_accounts`), without modifying or altering the information in `clouddriver.accounts`. 

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
  
> This feature is a limited availability release candidate and requires the use of custom agent and service plugins (available from your technical account manager).

## Configuration details
Dynamic Account configuration parameters are added to the Agent plugin deployment file. The required parameters must be updated as shown here:

``` yaml
- account:
  - storage:
    - enabled: true 
    - kubernetes: 
      - enabled: true
```

## Migrate accounts
Accounts can be migrated from the Clouddriver `kubesvc_account` table to the agent(s) manually or automatically. 

### Manual migration
Accounts can be pulled from the Clouddriver to the cluster Agents using the {{< linkWithTitle "dynamic-accounts.md" >}}).

> An account can only be successfully migrated if it has network connectivity to the cluster in the underlying configuration. 

For each account three requests are required to activate a migrated account on the Agent and set that account to `Active`:
1. First use a `GET /armory/accounts/{accountId}` request to scan for account data. You can also use the `GET /armory/accounts/{accountId}` endpoint to source a specific account.
2. Next, use the migrate `POST /armory/accounts` request to migrate the accounts to the Agent. This can be done as a batch process. Identified accounts are sent to the agent and set to an `INACTIVE` state.
3. Set the migrated account to `ACTIVE` using a `PATCH /armory/accounts` request, after the migration step is completed.

The initial request from the Agent to Clouddriver sets up the persistent connection, including the list of static accounts, defined in the agent configuration file `armory-agent.yml`, and by the optional `zoneId` flag. Where the flag is not applied migration still occurs. In this case accounts are polled at regular intervals and assigned to Agent pods. 

> Use of the `zoneId` flag is recommend for efficient migration. The `kubeconfig` file provides configuration details for connecting to the target clusters that are sent as part in a request. 

If the agent is not able to connect to the target clusters, the account is updated with a `FAILED` state. 

#### Interceptor option
An interceptor option is provided to ease onboarding and migration steps.

With this option the configuration steps are minimized for newly added accounts using the `POST /credentials` endpoint. New accounts can be enabled with only one request to to update from the initial `INACTIVE` state to `ACTIVE` active state.

> This endpoint does not allow batch requests.

### Automatic migration
Accounts can be automatically migrated and set to `ACTIVE` when autoscan is in enabled in the `kuconfig` file. Set the `dynamicAccounts` parameter with the following flags:

```yaml
kubesvc:
  dynamicAccounts:
    enabled: true
    scan: true
    scanBatchSize: 5
    scanFrequencySeconds: 60
    namePatterns: ['^apple.*','^.*depot.*']
  ```

When enabled the account name pattern is used to identify accounts for migration.  Autos scanning minimizes the manual effort and eliminates the `add` and `migrate` steps when the `namePatterns` flag is set to match a specified account naming pattern.

If the agent is not able to connect to the target clusters the Agent is notified and the Clouddriver sends the `SaveAccounts` operation to the Agent with a a unique `zoneId`.


