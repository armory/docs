---
title: "spinnaker.execution.stages.before.deleteManifest"
linktitle: "deleteManifest"
description: "A policy targeting this object runs before executing each task in a deleteManifest stage."
weight: 10
---

See [Deploy Applications to Kubernetes]({{< ref "kubernetes-v2#available-manifest-based-stages" >}}) for more information on this stage.

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

This example policy requires Delete Manifest stages to provide a minimum 2 minute grace period when run in production.

```rego
package spinnaker.execution.stages.before.deleteManifest

productionAccounts :=["prod1","prod2"]

deny["deletions in production accounts must allow a minimum of 2 minutes for graceful shutdown."]{
	input.deploy.account==productionAccounts[_]
    input.deploy.options.gracePeriodSeconds<120
}
```

## Keys

| Key                                       | Type      | Description                                                                                                                               |
| ----------------------------------------- | --------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| `input.deploy.account`                    | `string`  | The account being deployed to.                                                                                                  |
| `input.deploy.credentials`                | `string`  | The credentials to use to access the account.                                                                                             |
| `input.deploy.labelSelectors.empty`       | `boolean` |                                                                                                                                           |
| `input.deploy.labelSelectors.notEmpty`    | `boolean` |                                                                                                                                           |
| `input.deploy.location`                   | `string`  | The name of the namespace from which the manifest is being deleted.                                                                       |
| `input.deploy.manifestName`               | `string`  | The name of the manifest being deleted.                                                                                                   |
| `input.deploy.options.apiVersion`         | `string`  | The API version in which the manifest's kind is defined.                                                                                  |
| `input.deploy.options.dryRun`             | `boolean` | If true then the manifest is not actually deleted. if false it is.                                                                        |
| `input.deploy.options.gracePeriodSeconds` | `number`  | How many seconds the resource being deleted is given to shut down gracefully before being forcefully shut down.                           |
| `input.deploy.options.kind`               | `string`  | What is the kind of manifest that is being deleted.                                                                                       |
| `input.deploy.options.orphanDependents`   |           | When set, delete all resources managed by this resource as well (all pods owned by a replica set). When unset, this may orphan resources. |
| `input.deploy.options.preconditions`      |           |                                                                                                                                           |
| `input.deploy.options.propagationPolicy`  |           | There are three different ways to delete a Kubernetes object:<br/> Foreground: The object itself cannot be deleted unless the objects that it owns have already been deleted.<br/> Background: The object itself is deleted, then the objects that it owned are automatically deleted.<br/> Orphan: The object itself is deleted. Any objects it owns are “orphaned.” |
