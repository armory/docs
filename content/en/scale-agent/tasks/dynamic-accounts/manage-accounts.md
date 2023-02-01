---
title: Manage Accounts in the Armory Scale Agent
linkTitle: Manage Accounts
description: >
  Learn how to create, update, delete, and fetch accounts in the Armory Scale Agent for Spinnaker and Kubernetes.
---

## Manage accounts overview

The Scale Agent REST API provides endpoints to create, delete, get, and update Kubernetes accounts. Endpoints aren't directly accessible. If you don't have direct access to your cluster, you should [expose Clouddriver using a LoadBalancer service]({{< ref "scale-agent/install/install-agent-plugin#expose-clouddriver-as-a-loadbalancer" >}}). You can then call the API using the public `https://<clouddriver-loadbalancer-url>:<clouddriver-port>`. 

See {{< linkWithTitle "scale-agent/tasks/dynamic-accounts/migrate-accounts.md" >}} for details on how to manually or automatically migrate accounts from Clouddriver to the Scale Agent.

## Create accounts

Use this when you want to create an account that does not exist in Clouddriver or the Scale Agent.

**Endpoint**: `POST<Account[]> /armory/accounts/dynamic`

**Request body**:

```json
{
"name":	"acc2",
"type": "kubernetes",
"kubeconfigContents":"encryptedFile:k8s!n:kubeconfig-t!k:config!ns:spinnaker",
"metrics": false,
"kinds": [...],
"omitKinds": [...],
"namespaces": ["default", "spinnaker"],
"onlyNamespacedResources": false
}
```

Required fields:

You must supply `kubeconfigContents` or `kubeconfigFile` or `

- Only mandatory fields are  **`kubecongifContents** / **KubeconfigFile / serviceAccount: true**` and **`name.`**
- the definition supports any agent account setting see ****[https://docs.armory.io/scale-agent/reference/config/agent-options/](https://docs.armory.io/scale-agent/reference/config/agent-options/)


**Example**:

```bash
curl --request POST \
  --url http://localhost:7002/armory/accounts/dynamic \
  --header 'Content-Type: application/json' \
  --data '{
"name":	"acc2",
"type": "kubernetes",
"kubeconfigContents":"encryptedFile:k8s!n:kubeconfig-t!k:config!ns:spinnaker"
}'
```


**Response**:

- 202 Accepted: `[] empty array`
- 409 Conflict: `[] array containing already migrated accounts` (still processes valid ones)
- 400 Bad Request: in case the account array is empty
- 501 Not Implemented: if the dynamic accounts settings aren’t enabled with `kubesvc.dynamicAccounts.enabled=true`

## Deactivate accounts

Deactivating an account will not delete it but transfer it to an INACTIVE state, a.k.a only tells the k8s Agent to stop watching it.

**PATCH** <Account[]> `/armory/accounts` NOT IN SWAGGER

```
[
 {
  "name":  "account-01",
  "state": "INACTIVE"
 },
 {
  "name":   "account-02",
  "state": "INACTIVE"
 }
]
```

**Account object:**

- **name:** the name of the account matching the account in `clouddriver.accounts`
- **state**: the desired state of the account, can only be `ACTIVE | INACTIVE`

## Delete accounts

Deleting an account will tell Agent to stop watching and managing the account and then will be effectively removed from kubesvc_accounts.

**Prerequisites:**

- Account must be of type **dynamic** in `kubesvc_accounts`. HOW DOES “DYNAMIC” GET SET IN THE TABLE?

**DELETE** <string[]> `/armory/accounts` NOT IN SWAGGER

```
["account-01","account-02"]
```


## Get an account

The status and definition of an account can be observed in 
**GET** `/agents/kubernetes/accounts/{account-name}` NOT IN SWAGGER


## Update accounts

Updating an account is similar to creating a new one, the API will detect it by its name and perform the update, if the account is already in ACTIVE state it will propagate the changes immediately to the corresponding **k8s Agents**.
**PUT**<Account[]> `/armory/accounts/**dynamic`

```
{
"name": "demo-acc-02",
"type": "kubernetes",
"kubeconfigFile":"encryptedFile:k8s!n:kubeconfig-t!k:config!ns:spinnaker",
"kubeconfigAgent":"encryptedFile:k8s!n:kubeconfig-agent!k:config!ns:spinnaker",
"omitKinds": [],
"namespaces": [
    "dev",
    "spinnaker",
    "default"
]
}
```

**kubeconfigAgent** is only needed if the account is in an **ACTIVE** state and if the target agent needs a **different kubeconfig from the original one.**




## {{% heading "nextSteps" %}}

1. {{< linkWithTitle "scale-agent/tasks/dynamic-accounts/migrate-accounts.md" >}}
