---
title: "spinnaker.deployment.tasks.before.scaleManifest"
linkTitle: "scaleManifest"
description: "A policy that runs before executing each task in a Scale Manifest stage."

---

## Example Payload

<details><summary>Click to expand</summary>

```json
{
  "input": {
    "deploy": {
      "account": "spinnaker",
      "credentials": "spinnaker",
      "events": [],
      "location": "staging",
      "manifestName": "deployment hostname",
      "replicas": 10
    }
  }
}
```
</details>

## Example Policy

This policy prevents scaling a deployment or replicaset in a production account to have <2 replicas.

```rego
package spinnaker.deployment.tasks.before.scaleManifest

productionAccounts :=["prod1","prod2"]

deny["production accounts require >1 replicas to avoid a single point of failure."]{
	input.deploy.location==productionAccounts[_]
    input.deploy.replicas<2
}
```

## Keys

| Key                         | Type     | Description                                                   |
| --------------------------- | -------- | ------------------------------------------------------------- |
| `input.deploy.account`      | `string` | The account being deployed to.                      |
| `input.deploy.credentials`  | `string` | The credentials used to access the account.                   |
| `input.deploy.location`     | `string` | The name of the namespace the manifest is being deleted from. |
| `input.deploy.manifestName` | `string` | The name of the manifest being deleted.                       |
| `input.deploy.replicas`     | `number` | How many pods should be running after the scaling action.     |
