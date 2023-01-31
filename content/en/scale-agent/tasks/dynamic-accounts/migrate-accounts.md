---
title: Migrate Clouddriver Kubernetes Accounts to the Armory Scale Agent
linkTitle: Migrate Accounts
description: >
  Learn how to dynamically migrate accounts from Clouddriver to the Armory Scale Agent for Spinnaker and Kubernetes.
aliases:
  - /scale-agent/tasks/dynamic-account-options/
---

## Migration overview

You can migrate accounts from Clouddriver to the Scale Agent manually using the API or automatically by adding specific values to your plugin configuration. 


## {{% heading "prereq" %}}

* Familiarize yourself with {{< linkWithTitle "scale-agent/concepts/dynamic-accounts.md" >}}.
* [Enable the Dynamic Accounts API]({{< ref "scale-agent/tasks/dynamic-accounts/enable" >}}) in the Scale Agent plugin.
* You know how to fetch account data from Clouddriver. The accounts you want to migrate must exist in a Clouddriver credential source.

## Manual migration

Manually migrating Clouddriver accounts is a two-step process:
`
1. Migrate accounts as INACTIVE using `POST<Account[]> /armory/accounts`

   This fetches the specified accounts from a Clouddriver credential source and adds them to the Scale Agent (`clouddriver.kubesvc_accounts`) with an INACTIVE state.
   
   Payload array format:

   ```json
   [
    {
     "name":  "<account-name>",
     "zoneId": "<zone-id>",
     "kubeconfigFile": "<encrypted-kubeconfig>"
    }
   ]
   ```

   * **name**: (Required) the account's name
   * **zoneId**: (Optional) the `zoneId` for the targeted Agent service, which is by default deploymentName_namespace. This can optionally be supplied during the activation step.
   * **kubeconfigFile**: (Optional) the secret token for the `kubeconfig` path or file. This should be in [encrypted secret format](https://spinnaker.io/docs/reference/halyard/secrets/](https://spinnaker.io/docs/reference/halyard/secrets/); for example, `encryptedFile:k8s!n:kubeconfig!k:config!ns:spinnaker`. **`kubeconfigFile` is optional only if the native account's `kubeconfig` works for the targeted Agent service; otherwise you need to supply this parameter with a working value**.


1. Activate the migrated accounts using `PATCH <Account[]> /armory/accounts`
  
   This activates the specified accounts in the Scale Agent (changed state to ACTIVE in `clouddriver.kubesvc_accounts`) and sends the account data to the associated Scale Agent service. Each account must meet the following criteria:

      * Have a valid JSON object in the `definition` column of the `clouddriver.kubesvc_accounts` table
      * Be in an INACTIVE or FAILED state
      * Have an existing connection to a Scale Agent service running in a cluster

   Payload array format:

   ```json
   [
    {
     "name":  "<account-name>",
     "state": "<ACTIVE | FAILED>",
     "zoneId": "<zone-id>",
     "kubeconfigFile": "<encrypted-kubeconfig>"
    }
   ]
   ```

   * **name**: (Required) the account's name
   * **state**: (Required) the account state; valid values are ACTIVE or FAILED.
   * **zoneId**: (Optional) the `zoneId` for the targeted Agent service, which is by default deploymentName_namespace. This is not needed if you supplied this value in the previous step. 
   * **kubeconfigFile**: (Optional) the secret token for the `kubeconfig` path or file. This should be in [encrypted secret format](https://spinnaker.io/docs/reference/halyard/secrets/](https://spinnaker.io/docs/reference/halyard/secrets/); for example, `encryptedFile:k8s!n:kubeconfig!k:config!ns:spinnaker`. **`kubeconfigFile` is optional only if you supplied this value in the previous step or the native account's `kubeconfig` works for the targeted Agent service**.


>Note: If you do not include a `zoneId`, Clouddriver sends the request to every other Clouddriver instance that has a connected Scale Agent service. Each Clouddriver instance subsequently sends the request to all of its connected Agents in an attempt to find one that can process the request. 

If the Scale Agent plugin is not able to connect to the target Scale Agent service, the account state changes to FAILED.

#### Interceptor option

An interceptor option is provided to ease onboarding and migration steps.

With this option, the configuration steps are minimized for newly added accounts using the `POST /credentials` endpoint. New accounts can be enabled with only one request to to update from the initial `INACTIVE` state to `ACTIVE` active state.

> This endpoint does not allow batch requests.

## Automatic migration

This feature requires you to [enable the Clouddriver Account Management feature](https://spinnaker.io/docs/setup/other_config/accounts/#enabling-account-management) in Spinnaker. 

Accounts can be automatically migrated and set to `ACTIVE` when autoscanning is enabled in the `kuconfig` file. Configure the `dynamicAccounts` section with the following options:

```yaml
kubesvc:
  dynamicAccounts:
    enabled: true
    scan: true
    scanBatchSize: 5
    scanFrequencySeconds: 60
    namePatterns: ['^account1.*','^.*account2.*']
  ```

When enabled, the account name pattern is used to identify accounts for migration.  Autoscanning minimizes the manual effort and eliminates the `add` and `migrate` steps when the `namePatterns` flag is set to match a specified account naming pattern.

If the Agent is not able to connect to the target clusters, the Agent is notified and Clouddriver sends the `SaveAccounts` operation to the Agent with a a unique `zoneId`.


## {{% heading "nextSteps" %}}

* {{< linkWithTitle "scale-agent/reference/dynamic-accounts/_index.md" >}}