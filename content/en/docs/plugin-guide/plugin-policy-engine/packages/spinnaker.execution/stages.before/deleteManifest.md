---
title: "spinnaker.execution.stages.before.deleteManifest"
linktitle: "deleteManifest"
description: "A policy that is run before executing each task in a delete manifest stage.
"
---
 See [Deploy Applications to Kubernetes]({{< ref "kubernetes-v2#available-manifest-based-stages" >}}) for more information on this stage.
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

| Key                                       | Type      | Description                                   |
| ----------------------------------------- | --------- | --------------------------------------------- |
| `input.deploy.account`                    | `string`  | The spinnaker account being deployed to.      |
| `input.deploy.credentials`                | `string`  | The credentials to use to access the account. |
| `input.deploy.labelSelectors.empty`       | `boolean` |                                               |
| `input.deploy.labelSelectors.notEmpty`    | `boolean` |                                               |
| `input.deploy.location`                   | `string`  |                                               |
| `input.deploy.manifestName`               | `string`  |                                               |
| `input.deploy.options.apiVersion`         | `string`  |                                               |
| `input.deploy.options.dryRun`             | `boolean` |                                               |
| `input.deploy.options.gracePeriodSeconds` | `number`  |                                               |
| `input.deploy.options.kind`               | `string`  |                                               |
| `input.deploy.options.orphanDependents`   | ``        |                                               |
| `input.deploy.options.preconditions`      | ``        |                                               |
| `input.deploy.options.propagationPolicy`  | ``        |                                               |
| `path`                                    | `string`  |                                               |
| `subpath`                                 | ``        |                                               |
| `tasktype`                                | ``        |                                               |
