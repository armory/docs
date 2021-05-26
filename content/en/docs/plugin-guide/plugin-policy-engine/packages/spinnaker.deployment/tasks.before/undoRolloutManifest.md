---
title: "spinnaker.deployment.tasks.before.undoRolloutManifest"
linkTitle: "undoRolloutManifest"
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
      "numRevisionsBack": 1,
      "revision": null
    }
  }
}
```
</details>

## Example Policy

```rego

```

## Keys

| Key                             | Type     | Description                                                         |
| ------------------------------- | -------- | ------------------------------------------------------------------- |
| `input.deploy.account`          | `string` | The spinnaker account being deployed to.                            |
| `input.deploy.credentials`      | `string` | The credentials to use to access the account.                       |
| `input.deploy.location`         | `string` | The name of the namespace from which the manifest is being deleted. |
| `input.deploy.manifestName`     | `string` | The name of the manifest being deleted.                             |
| `input.deploy.numRevisionsBack` | `number` |                                                                     |
| `input.deploy.revision`         | ` `      |                                                                     |
