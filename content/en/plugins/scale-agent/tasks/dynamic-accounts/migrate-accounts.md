---
title: Migrate Clouddriver Kubernetes Accounts to the Armory Scale Agent
linkTitle: Migrate Accounts
description: >
  Learn how to dynamically migrate accounts from Clouddriver to the Armory Scale Agent for Spinnaker and Kubernetes.
---

## Migration overview

{{< include "scale-agent/api-overview" >}}


## {{% heading "prereq" %}}

* Familiarize yourself with {{< linkWithTitle "plugins/scale-agent/concepts/dynamic-accounts.md" >}}.
* [Enable the Dynamic Accounts feature]({{< ref "plugins/scale-agent/tasks/dynamic-accounts/enable" >}}) in the Scale Agent plugin.
* You know how to fetch account data from Clouddriver.
* The accounts you want to migrate must exist in a Clouddriver credential definition source such as `clouddriver-local.yaml` or the `clouddriver.accounts` table.

## Manual migration

Manually migrating Clouddriver accounts is a two-step process:

1. Migrate accounts using `POST<Account[]> /armory/accounts`

   This fetches the specified accounts from a Clouddriver credential source and adds them to the Scale Agent (`clouddriver.kubesvc_accounts`) with an INACTIVE state.

   Request data array format:

   ```json
   [
    {
     "name":  "<account-name>",
     "zoneId": "<zone-id>",
     "kubeconfigFile": "<encrypted-kubeconfig>"
    }
   ]
   ```

   * `name`: (Required) the account's name
   * `zoneId`: (Optional) the `zoneId` for the targeted Agent service, which is by default deploymentName_namespace. This can optionally be supplied during the activation step.
   * `kubeconfigFile`: (Optional) the secret token for the `kubeconfig` path or file. This should be in [encrypted secret format](https://spinnaker.io/docs/reference/halyard/secrets/](https://spinnaker.io/docs/reference/halyard/secrets/); for example, `encryptedFile:k8s!n:kubeconfig!k:config!ns:spinnaker`. **`kubeconfigFile` is optional only if the native account's `kubeconfig` works for the targeted Agent service; otherwise you need to supply this parameter with a working value**.


   Example:

   {{< include "scale-agent/curl/post-armory-accounts" >}}

   Responses:

      - 202 Accepted: `[] empty array`
      - 409 Conflict: `[] array containing already migrated accounts` (still processes valid ones)
      - 400 Bad Request: the account array is empty
      - 5501 Not Implemented: if the Dynamic Accounts feature isn't enabled


1. Activate the migrated accounts using `PATCH <Account[]> /armory/accounts`

   This activates the specified accounts in the Scale Agent (changed state to ACTIVE in `clouddriver.kubesvc_accounts`) and sends the account data to the associated Scale Agent service. Each account must meet the following criteria:

      * Have a valid JSON object in the `definition` column of the `clouddriver.kubesvc_accounts` table
      * Be in an INACTIVE or FAILED state
      * Have an existing connection to a Scale Agent service running in a cluster

   Request data array format:

   ```json
   [
    {
     "name":  "<account-name>",
     "state": "<INACTIVE | FAILED>",
     "zoneId": "<zone-id>",
     "kubeconfigFile": "<encrypted-kubeconfig>"
    }
   ]
   ```

   * `name`: (Required) the account's name
   * `state`: (Required) the account state; valid values are INACTIVE or FAILED.
   * `zoneId`: (Optional) the `zoneId` for the targeted Agent service, which is by default deploymentName_namespace. This is not needed if you supplied this value in the previous step.

       If you do not include a `zoneId`, Clouddriver sends the request to every other Clouddriver instance that has a connected Scale Agent service. Each Clouddriver instance subsequently sends the request to all of its connected Agents in an attempt to find one that can process the request. This is resource intensive, so be sure to include a `zoneId`.

   * `kubeconfigFile`: (Optional) the secret token for the `kubeconfig` path or file. This should be in [encrypted secret format](https://spinnaker.io/docs/reference/halyard/secrets/](https://spinnaker.io/docs/reference/halyard/secrets/); for example, `encryptedFile:k8s!n:kubeconfig!k:config!ns:spinnaker`.

      `kubeconfigFile` is optional only if you supplied this value in the previous step or the native account's `kubeconfig` works for the targeted Agent service.

   Example:

   {{< include "scale-agent/curl/patch-armory-accounts" >}}

   Response:

      - 202 Accepted
      - 501 Not Implemented: if the Dynamic Accounts feature isn't enabled


   The account state changes to FAILED if the Scale Agent plugin is not able to connect to the target Scale Agent service. The plugin does not inform you of the operation results. Check for an ACTIVE account state in the `clouddriver.kubesvc_accounts` table by querying the database directly or by calling `/agents/kubernetes/accounts/{accountName}`.


## Automatic migration

>This feature requires you to [enable the Clouddriver Account Management feature](https://spinnaker.io/docs/setup/other_config/accounts/#enabling-account-management) in Spinnaker.

### Scan for new accounts

The Scale Agent can automatically migrate accounts and set them to `ACTIVE` when you enable the automatic scanning mechanism in the plugin configuration.

Add the following to your plugin configuration:

```yaml
kubesvc:
  dynamicAccounts:
    enabled: true
    scanBatchSize: <int>
    scanFrequencySeconds: <int>
    namePatterns: ['^account1.*','^.*account2.*']
  ```

This feature is enabled when `namePatterns` has at least one value. The Scale Agent uses the account name pattern to identify accounts for migration.  Autoscanning minimizes the manual effort and eliminates the `add` and `migrate` steps when the `namePatterns` flag is set to match a specified account naming pattern.

### Intercept Clouddriver account creation request

When you enable this option, the Scale Agent plugin intercepts any new account creation request that is sent to Clouddriver's `credentials` endpoint (`POST <GATE_URL>/credentials`).  The Scale Agent plugin automatically migrates the new account and sets the account state to ACTIVE.

Add the following to your plugin configuration:

```yaml
kubesvc:
  dynamicAccounts:
    interceptor:
      enabled: true
```

## {{% heading "nextSteps" %}}

1. {{< linkWithTitle "plugins/scale-agent/tasks/dynamic-accounts/manage-accounts.md" >}}}