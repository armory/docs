---
title: "spinnaker.execution.stages.before.deleteManifest"
linktitle: "stages.before.deleteManifest"
description: "fill me with delicious data, Stephen!"
---

The full package name sent to OPA is `spinnaker.execution.stages.before.deleteManifest`. The keys below are children of this path.

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

| Key                                       | Type      | Description |
| ----------------------------------------- | --------- | ----------- |
| `input.deploy.account`                    | `string`  |             |
| `input.deploy.credentials`                | `string`  |             |
| `input.deploy.labelSelectors.empty`       | `boolean` |             |
| `input.deploy.labelSelectors.notEmpty`    | `boolean` |             |
| `input.deploy.location`                   | `string`  |             |
| `input.deploy.manifestName`               | `string`  |             |
| `input.deploy.options.apiVersion`         | ``        |             |
| `input.deploy.options.dryRun`             | ``        |             |
| `input.deploy.options.gracePeriodSeconds` | `number`  |             |
| `input.deploy.options.kind`               | ``        |             |
| `input.deploy.options.orphanDependents`   | ``        |             |
| `input.deploy.options.preconditions`      | ``        |             |
| `input.deploy.options.propagationPolicy`  | ``        |             |
| `path`                                    | `string`  |             |
| `subpath`                                 | ``        |             |
| `tasktype`                                | ``        |             |