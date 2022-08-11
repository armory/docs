---
title: Migrate Clouddriver Accounts to the Agent
linkTitle: Dynamic Accounts
description: >
  Learn how to migrate account definitions from Clouddriver to the Armory Agent dynamically.
---

## Dynamic accounts managed by the Armory Agent
The Agent, and all Agent replicas, can dynamically leverage account data sourced from cluster Clouddriver plugin. Migrated accounts are dynamic and account migration does not result in duplicate database entries or inconsistent state. Dynamic Accounts can also be generated, modified, or deleted from the Agent. The account definitions are dynamic and any account activity on the Agent ise automatically detected and sent to Agent pods, without the impact of downtime.

Dynamic accounts accounts are are supported by the
{{< linkWithTitle "dynamic-accounts.md" >}} endpoints. The  `zoneId` flag is used to keep each account instance unique. 

> Dynamic Accounts are only available on Agents with network connectivity to the target clusters.

## Configuration details
This feature is a limited availability beta release and requires the use of custom agent and service plugins (available from your technical account manager).

Dynamic Account configuration parameters are added to the Agent plugin deployment file. The required parameters must be updated as shown here:

``` yaml
- account:
  - storage:
    - enabled: true 
    - kubernetes: 
      - enabled: true
```
With the the configuration in place you can begin migrating and managing accounts on the Agent. Dynamic accounts can be manually or automatically managed. 

### Manual configuration
Accounts can be pulled from the Clouddriver to the cluster Agents using the {{< linkWithTitle "dynamic-accounts.md" >}}).

For each account three requests are required to activate a migrated account on the Agent and set that account to `Active`:
1. First use a `GET /armory/accounts/{accountId}` request to scan for account data. You can also use the `GET /armory/accounts/{accountId}` endpoint to source a specific account.
2. Next, use the migrate `POST /armory/accounts` request to migrate the accounts to the Agent. This can be done as a batch process. Identified accounts are sent to the agent and set to an `INACTIVE` state.
3. Set the migrated account to `ACTIVE` using a `PATCH /armory/accounts` request, after the migration step is completed.

The initial request from the Agent to Clouddriver sets up the persistent connection, including the list of static accounts, defined in the agent configuration file `armory-agent.yml`, and by the optional `zoneId` flag. Where the flag is not applied migration still occurs. In this case accounts are polled at regular intervals and assigned to Agent pods. 

Use of the `zoneId` flag is recommend for efficient migration. The `kubeconfig` file provides configuration details for connecting to the target clusters that are sent as part in a request. 

If the agent is not able to connect to the target clusters, the Clouddriver sends the `SaveAccounts` operation to an Agent with a unique zone identifier. On demand HTTP requests indicate what accounts are removed from Agents and managed by Clouddriver.

#### Interceptor option
An interceptor option is provided to ease the configuration steps. With this option the configuration steps are minimized and the new account is enabled with only one request to set it to `ACTIVE` from the initial `INACTIVE` state.

>This endpoint does not allow batch requests.

### Autoscan
The Autoscan configuration polls the connected database (SQL is supported for beta) for account activity, at regular intervals. The default is 2 minutes, and can be modified in the service plugin.  New accounts are identified with a customer defined prefix to the account name and requests are sent to the Clouddriver to migrate the account data to the Agent. In this case the type field is set to `kubernetes:agent` to indicate that the account is migrated to the Agent. When the type field is changed from `kubernetes` to `kubernetes:agent`, any field under `kubernetes.accounts`, in [Agent advanced config options](https://docs.armory.io/armory-enterprise/armory-agent/advanced-config/agent-options/), is monitored.

The initial request from `agent` to `clouddriver` sets up the persistent connection, including the list of static accounts defined in the Agent `armory-agent.yml` configuration file. The Clouddriver notifies the agent about accounts that are configured for Agent monitoring and management, and provides any new accounts data. The `kubeconfig` file targets and cluster connection configuration is also sent.  

If the agent is not able to connect to the target clusters the Agent is notified and the Clouddriver sends the `SaveAccounts` operation to the Agent with a a unique `zoneId`.


