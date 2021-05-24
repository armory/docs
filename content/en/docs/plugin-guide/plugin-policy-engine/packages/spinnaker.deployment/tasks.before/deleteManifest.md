---
title: "spinnaker.deployment.tasks.before.deleteManifest"
linkTitle: "deleteManifest"
description: "Policy checks that run immediate before a task deletes a spinnaker manifest"
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
| `input.deploy.location`                   | `string`  | The name of the namespace from which the manifest is being deleted                                              |
| `input.deploy.manifestName`               | `string`  | The name of the manifest being deleted                                              |
| `input.deploy.options.apiVersion`         | ` `       | The API version in which the manifest's kind is defined.                                              |
| `input.deploy.options.dryRun`             | ` `       | If true then the manifest will not actually be deleted. if false it will be.                                              |
| `input.deploy.options.gracePeriodSeconds` | `number`  |                                               |
| `input.deploy.options.kind`               | ` `       | What is the kind of manifest that is being deleted.                                              |
| `input.deploy.options.orphanDependents`   | ` `       |                                               |
| `input.deploy.options.preconditions`      | ` `       |                                               |
| `input.deploy.options.propagationPolicy`  | ` `       |                                               |
