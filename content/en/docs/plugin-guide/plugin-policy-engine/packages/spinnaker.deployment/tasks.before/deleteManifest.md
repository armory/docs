---
title: "spinnaker.deployment.tasks.before.deleteManifest"
linkTitle: "deleteManifest"
description: "WHO AM I?"
---


## Example Payload

<details><summary>Click to expand</summary>

```json
{
  "input": {
    "deploy": {
      "account": "spinnaker",
      "allCoordinates": [],
      "credentials": "spinnaker",
      "events": [],
      "kinds": [],
      "labelSelectors": {
        "empty": true,
        "notEmpty": false,
        "selectors": []
      },
      "location": "staging",
      "manifestName": "deployment hostname",
      "options": {
        "apiVersion": null,
        "dryRun": null,
        "gracePeriodSeconds": 5,
        "kind": null,
        "orphanDependents": null,
        "preconditions": null,
        "propagationPolicy": null
      }
    }
  }
}
```
</details>

## Example Policy

```rego

```

## Keys

| Key                                       | Type      | Description                                   |
| ----------------------------------------- | --------- | --------------------------------------------- |
| `input.deploy.account`                    | `string`  | The spinnaker account being deployed to.      |
| `input.deploy.credentials`                | `string`  | The credentials to use to access the account. |
| `input.deploy.labelSelectors.empty`       | `boolean` |                                               |
| `input.deploy.labelSelectors.notEmpty`    | `boolean` |                                               |
| `input.deploy.location`                   | `string`  |                                               |
| `input.deploy.manifestName`               | `string`  |                                               |
| `input.deploy.options.apiVersion`         | ` `       |                                               |
| `input.deploy.options.dryRun`             | ` `       |                                               |
| `input.deploy.options.gracePeriodSeconds` | `number`  |                                               |
| `input.deploy.options.kind`               | ` `       |                                               |
| `input.deploy.options.orphanDependents`   | ` `       |                                               |
| `input.deploy.options.preconditions`      | ` `       |                                               |
| `input.deploy.options.propagationPolicy`  | ` `       |                                               |
