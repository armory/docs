---
title: Manage Kubernetes Accounts in the Armory Scale Agent
linkTitle: Manage Accounts
description: >
  Learn how to create, update, delete, and fetch accounts in the Armory Scale Agent for Spinnaker and Kubernetes.
---

## Manage accounts overview

{{< include "plugins/scale-agent/api-overview" >}}

See {{< linkWithTitle "plugins/scale-agent/tasks/dynamic-accounts/migrate-accounts.md" >}} for details on how to manually or automatically migrate accounts from Clouddriver to the Scale Agent using the Dynamic Accounts API.

## Create accounts

Like migrating accounts, creating new accounts is a two-step process:

1. POST new account data; this adds the new accounts in an INACTIVE state
1. PATCH to change state to ACTIVE and begin using the account.

### Provision accounts

**Endpoint**: POST<Account[]> `/armory/accounts/dynamic`

**Request body**:

```json
{
"name":	"<account-name>",
"zoneId": "<zone-id>",
"kubeconfigContents": "encryptedFile:k8s!n:kubeconfig-t!k:config!ns:spinnaker"
}
```

Required fields:

* `name`: the account name

and **one** of the following:

* `kubeconfigContents`: encrypted contents of the `kubeconfig` file
* `kubeconfigFile`: Path to the `kubeconfig` file if not using `serviceAccount`.
* `serviceAccount`: true or false; if true, use the current service account to call to the current API server. In this mode, you don’t need to provide a `kubeconfig` file.

Optional fields:

* `zoneId`: (Optional) the `zoneId` for the targeted Agent service, which is by default deploymentName_namespace. This can optionally be supplied during the activation step.
* You can include any `kubernetes.accounts[]` attribute from the Scale Agent service [config options list]({{< ref "plugins/scale-agent/reference/config/service-options#configuration-options" >}}).

**Example**:

{{< include "plugins/scale-agent/curl/post-armory-accounts" >}}

**Response**:

- 202 Accepted: `[] empty array`
- 409 Conflict: `[] array containing already migrated accounts` (still processes valid ones)
- 400 Bad Request: in case the account array is empty
- 501 Not Implemented: if the Dynamic Accounts feature isn't enabled

### Activate accounts

**Endpoint**: PATCH<Account[]> `/armory/accounts/dynamic`

**Request body**:

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

Required fields:

* `name`: the account name
* `state`: the account state; valid values are INACTIVE or FAILED.

and **one** of the following: `kubeconfigContents`, `kubeconfigFile`, or `serviceAccount` (whichever one you used in the POST request).

`zoneId` is optional if you included one in the provision step.

**Example**:

{{< include "plugins/scale-agent/curl/patch-armory-accounts" >}}

**Response**:

- 202 Accepted
- 501 Not Implemented: if the Dynamic Accounts feature isn't enabled


## Deactivate accounts

This action changes the state to INACTIVE and instructs the Scale Agent service to stop watching the account(s).

**Endpoint**: PATCH <Account[]> `/armory/accounts`

**Request body**:

```json
[
 {
  "name":  "<account-name>",
  "state": "INACTIVE"
 },
 {
  "name":   "<account-name>",
  "state": "INACTIVE"
 }
]
```

**Example**:

```bash
curl --request PATCH \
  --url http://localhost:7002/armory/accounts \
  --header 'Content-Type: application/json' \
  --data '[
	{
	"name":	"account-01",
	"state": "INACTIVE"
	},
	{
	"name":	"account-02",
	"state": "INACTIVE"
	}
]'
```

**Response**:

- 202 Accepted - no body.
- 501 Not Implemented: if the Dynamic Accounts feature isn't enabled

## Delete accounts

This action removes the account from the Scale Agent service that watches it. Then the plugin removes the account from the `clouddriver.kubesvc_accounts` table.

>Account must be of type **dynamic** in `clouddriver.kubesvc_accounts`.

**Endpoint**: DELETE <string[]> `/armory/accounts`

**Request body**:

```json
["account-01","account-02"]
```

**Example**:

```bash
curl --request DELETE \
  --url http://localhost:7002/armory/accounts \
  --header 'Content-Type: application/json' \
  --data '["account-01","account-02"]'
```

**Response:**

- 202 Accepted - no body.
- 501 Not Implemented: if the Dynamic Accounts feature isn't enabled

## Get an account

Use this to fetch the status and definition of an account.

**Endpoint**: GET `/agents/kubernetes/accounts/{account-name}`

**Example**:

```bash
curl --request GET \
  --url http://localhost:7002/agents/kubernetes/accounts/account-01
```

**Response**:

- 200 Accepted: `{name:..., kubeconfigContents:..., ... } account object found` or empty object if none.
- 501 Not Implemented: if the Dynamic Accounts feature isn't enabled

**Example response**:

``` json
{
   "name":"my-account-1",
   "type":"kubernetes",
   "source":"clouddriver",
   "config":{

   },
   "zoneId":"agent-private-network-1",
   "agents":{
      {
         "agentId":"agent-private-network-1-54865d798c-cpqgm",
         "caching":true
      },
      {
         "agentId":"agent-private-network-1-54865d798c-tdfvw",
         "caching":false
      }
   },
   "status": "ACTIVE",
   "lastAssignmentMsg": "successfully assigned to Agent agent-private-network-1-54865d798c-tdfvw for executing operations"
}
```

## Update a single account

Updating an account is similar to [creating a new one](#create-accounts). The API detects it by its name and performs the update. If the account is already ACTIVE, the plugin immediately propagates the changes to the corresponding Scale Agent services.

**Endpoint**: PUT <Account> `/armory/accounts/dynamic`

**Request body**:

```json
{
"name": "<account-name>",
"type": "kubernetes",
"kubeconfigFile":"encryptedFile:k8s!n:kubeconfig-t!k:config!ns:spinnaker",
"kubeconfigAgent":"encryptedFile:k8s!n:kubeconfig-agent!k:config!ns:spinnaker"
}
```

Required fields:

* `name`: the account name

Optional fields:

* `kubeconfigAgent`: you only need to include this if the account is in an **ACTIVE** state and if the target Scale Agent service needs a **different kubeconfig from the original one.**
* You can include any `kubernetes.accounts[]` attribute from the Scale Agent service [config options list]({{< ref "plugins/scale-agent/reference/config/service-options#configuration-options" >}}).


**Example**:

```bash
curl --request PUT \
  --url http://localhost:7002/armory/accounts/dynamic \
  --header 'Content-Type: application/json' \
  --data '{
"name":	"demo-acc-02",
"type": "kubernetes",
"kubeconfigContents":"encryptedFile:k8s!n:kubeconfig-t!k:config!ns:spinnaker",
"metrics": false,
"kinds": [],
"omitKinds": [],
"onlyNamespacedResources": false,
"namespaces": [
    "dev",
    "spinnaker",
    "default"
]
}'
```

**Response**:

- 202 Accepted: `[] empty array`
- 400 Bad Request: in case the request is empty or body is an array.
- 501 Not Implemented: if the Dynamic Accounts feature isn't enabled


## {{% heading "nextSteps" %}}

1. {{< linkWithTitle "plugins/scale-agent/tasks/dynamic-accounts/migrate-accounts.md" >}}
