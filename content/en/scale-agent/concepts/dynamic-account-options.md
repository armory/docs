---
title: Migrate Clouddriver accounts to the Agent
linkTitle: Dynamic accounts
description: >
  Learn how to migrate account definitions from Clouddriver to the Armory Agent dynamically.
---

## Dynamic accounts managed by the Armory Agent
The Agent, and all replicas with Agent credentials, can dynamically leverage account data sourced from the Clouddriver. Migrated accounts are dynamic and account migration does not result in duplicate database entries or inconsistent state. Dynamic Accounts can also be generated from the Agent. The account definitions are dynamic and newly created accounts, or account modifications, are automatically detected and sent to Agent pods, without requiring any cluster downtime.

Dynamic accounts accounts are are supported by the
{{< linkWithTitle "dynamic-accounts.md" >}} endpoints. The  `zoneId` flag is used to keep each account instance unique to the deployement. 

> Dynamic Accounts are only available on Agents that have network connectivity to the target clusters.

## Configuration details
This feature is a limited availability beta release and requires the use of  an agent and service custom plugin (available from your technical account manager).

Dynamic Account configuration parameters are added to the Agent plugin deployment file. The required parameters must be updated as shown here:

``` yaml
- account:
  - storage:
    - enabled: true 
    - kubernetes: 
      - enabled: true
```
With the the configuration in place you can begin migrating and managing accounts on the Agent. Dynamic accounts can be manually generated or automatically generated. 

### Manual
Accounts can be pulled from the Clouddriver to the cluster Agents using the {{< linkWithTitle "dynamic-accounts.md" >}}) to onboard a new account definition into the SQL database. 

For each account three requests are required to set the Dynamic Account to `Active`:
1. First use a `GET /armory/accounts/{accountId}` request to scan for account data. You can also use the `GET /armory/accounts/{accountId}` endpoint to source a specific account.
2. Next, use the migrate `POST /armory/accounts` request to migrate the accounts to the Agent. This can be done as a batch process. Identified accounts are sent to the agent and set to an `INACTIVE` state.
3. Set the migrated account to `ACTIVE` using a `PATCH /armory/accounts` request after the migration step is completed.

The initial request from the Agent to Clouddriver sets up the persistent connection, including the list of static accounts, defined in the agent configuration file `armory-agent.yml`, and by the optional `zoneId` flag. Where the flag is not applied migration still occurs. In this case accounts are polled at regular intervals and assigned to Agent pods. 

Use of the `zoneId` flag is recommend for efficient migration. The `kubeconfig` file provides configuration details for connecting to the target clusters that are sent as part in a request. 

If the agent is not able to connect to the target clusters, the Clouddriver sends the `SaveAccounts` operation to an Agent with a different zone identifier. On demand HTTP request indicate which accounts are removed from Agents and managed by Clouddriver.

#### Interceptor option
An interceptor option is also provided to ease the configuration steps with manual configuration. With this option the configuration steps are minimized and only the new account is enabled with one request to set it to `ACTIVE` from the initial `INACTIVE` state.

>This enpoint does not allow batch requests.

### Autoscan
The Autoscan configuration polls the connected database (SQL is supported for beta) for account activity at regular intervals. The default is two minutes and can be configured in the service plugin.  New accounts are identified with a customer defined prefix to the account name and requests are sent to the Clouddriver to migrate the account data to the Agent. In this case the type field is set to `kubernetes:agent` to indicate that the account is going to be managed by the Agent. When the type field is changed from `kubernetes` to `kubernetes:agent`, any field under `kubernetes.accounts`, in [Agent advanced config options](https://docs.armory.io/armory-enterprise/armory-agent/advanced-config/agent-options/), is monitored.

The initial request from `agent` to `clouddriver` sets up the persistent connection, including the list of static accounts defined in the Agent `armory-agent.yml` configuration file. The `clouddriver` notifies the agent about which accounts to monitor and manage, including new accounts details. 
The `kubeconfig` file target clusters connection configuration is also sent.  

If the agent is not able to connect to the target clusters the Agent is notificed and the Clouddriver sends the `SaveAccounts` operation to the Agent with a a unique `zoneId`.


