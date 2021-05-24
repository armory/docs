---
title: "spinnaker.deployment.tasks.before.scaleManifest"
linkTitle: "scaleManifest"
description: "WHO AM I?"
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

```rego

```

## Keys

| Key                         | Type     | Description                                   |
| --------------------------- | -------- | --------------------------------------------- |
| `input.deploy.account`      | `string` | The spinnaker account being deployed to.      |
| `input.deploy.credentials`  | `string` | The credentials to use to access the account. |
| `input.deploy.location`     | `string` |                                               |
| `input.deploy.manifestName` | `string` |                                               |
| `input.deploy.replicas`     | `number` |                                               |
