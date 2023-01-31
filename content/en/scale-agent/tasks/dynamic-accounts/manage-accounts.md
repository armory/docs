---
title: Manage Accounts in the Armory Scale Agent
linkTitle: Manage Accounts
description: >
  Learn how to create, update, delete, and fetch accounts in the Armory Scale Agent for Spinnaker and Kubernetes.
---


# Deleting Accounts

Deleting an account will tell Agent to stop watching and managing the account and then will be effectively removed from kubesvc_accounts.

**Prerequisites:**

- Account must be of type **dynamic** in `kubesvc_accounts`. HOW DOES “DYNAMIC” GET SET IN THE TABLE?

**DELETE** <string[]> `/armory/accounts` NOT IN SWAGGER

```
["account-01","account-02"]
```

# Deactivating Accounts

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

# Creating a new Account

Besides migration, the dynamic accounts feature also supports creating a new account that didn’t exist before.

**POST**<Account[]> `/armory/accounts/**dynamic`** NOT IN SWAGGER

```jsx
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

- Only mandatory fields are  **`kubecongifContents** / **KubeconfigFile / serviceAccount: true**` and **`name.`**
- the definition supports any agent account setting see ****[https://docs.armory.io/scale-agent/reference/config/agent-options/](https://docs.armory.io/scale-agent/reference/config/agent-options/)

## Updating an Account

Updating an account is similar to creating a new one, the API will detect it by its name and perform the update, if the account is already in ACTIVE state it will propagate the changes immediately to the corresponding **k8s Agents**.
**PUT**<Account[]> `/armory/accounts/**dynamic`** NOT IN SWAGGER

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

# **Checking an account**

The status and definition of an account can be observed in 
**GET** `/agents/kubernetes/accounts/{account-name}` NOT IN SWAGGER
