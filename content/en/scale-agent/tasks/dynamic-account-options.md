---
title: Migrate Clouddriver Kubernetes Accounts to the Armory Scale Agent
linkTitle: Migrate Accounts
description: >
  Learn how to dynamically migrate accounts from Clouddriver to the Armory Scale Agent for Spinnaker and Kubernetes.
---

{{% alert title="Attention" color="warning" %}}
This feature is a limited availability release candidate and requires the use of custom builds for the Scale Agent service and plugin. Contact your Account Manager if you are interested in using this feature.
<b>Do not use release candidate features in production environments.</b>
{{% /alert %}}


## {{% heading "prereq" %}}

* Familiarize yourself with {{< linkWithTitle "scale-agent/concepts/dynamic-accounts.md" >}}.
* Enable the Dynamic Accounts API:

   * In your Clouddriver config, set `kubesvc.dynamic-accounts.enabled: true`.
   * In your Scale Agent config, set `dynamicAccountsEnabled: true`.

* Make sure you expose your Clouddriver service. The Dynamic Accounts API endpoints are not directly accessible, so you call the endpoints using the Clouddriver API. 


Dynamic accounts are accounts that you migrate from Clouddriver to the Armory Agent. You use the credential source and account storage endpoints, provided in the {{< linkWithTitle "dynamic-accounts.md" >}}, to migrate and manage the account lifecycle on the Agent in a dedicated table (`clouddriver.kubesvc_accounts`), without modifying or altering the information in `clouddriver.accounts`.

The accounts you want to migrate must exist in the `clouddriver.accounts` table.

## Configuration details

You add dynamic account configuration parameters to the Agent plugin deployment file. The required parameters must be updated as shown here:

``` yaml
- account:
  - storage:
    - enabled: true
    - kubernetes:
      - enabled: true
```

## Migrate accounts

You can migrate accounts can be migrated from Clouddriver `kubesvc_account` table to the agent(s) manually or automatically.

### Manual migration

Accounts can be pulled from Clouddriver to the cluster Agents using the {{< linkWithTitle "scale-agent/reference/api/dynamic-accounts.md" >}}.

> An account can only be successfully migrated if it has network connectivity to the cluster in the underlying configuration.

Migrate accounts using the following requests:

1. (Optional) Use a `GET /armory/accounts/{accountId}` request to scan for account data. You can also use the `GET /armory/accounts/{accountId}` endpoint to source a specific account.
1. Use the `POST /armory/accounts` request to send the accounts to the Agent. This can be done as a batch process. The Agent sets the accounts to an `INACTIVE` state.
1. Use the `PATCH /armory/accounts` request to set the accounts to an `ACTIVE` state.

> Use of the `zoneId` flag is recommend for efficient migration. The `kubeconfig` file provides configuration details for connecting to the target clusters that are sent as part in a request.

If the Agent is not able to connect to the target clusters, the account is updated with a `FAILED` state.

#### Interceptor option

An interceptor option is provided to ease onboarding and migration steps.

With this option, the configuration steps are minimized for newly added accounts using the `POST /credentials` endpoint. New accounts can be enabled with only one request to to update from the initial `INACTIVE` state to `ACTIVE` active state.

> This endpoint does not allow batch requests.

### Automatic migration

Accounts can be automatically migrated and set to `ACTIVE` when autoscanning is enabled in the `kuconfig` file. Configure the `dynamicAccounts` section with the following options:

```yaml
kubesvc:
  dynamicAccounts:
    enabled: true
    scan: true
    scanBatchSize: 5
    scanFrequencySeconds: 60
    namePatterns: ['^apple.*','^.*depot.*']
  ```

When enabled, the account name pattern is used to identify accounts for migration.  Autoscanning minimizes the manual effort and eliminates the `add` and `migrate` steps when the `namePatterns` flag is set to match a specified account naming pattern.

If the Agent is not able to connect to the target clusters, the Agent is notified and Clouddriver sends the `SaveAccounts` operation to the Agent with a a unique `zoneId`.
