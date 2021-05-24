---
title: "spinnaker.deployment.tasks.before.deleteManifest"
linkTitle: "deleteManifest"
description: "Policy checks that run immediate before a task deletes a spinnaker manifest"
---
Note: If your policy is for controlling deletion from within a pipeline, more information is available in policies written against the spinnaker.deployment.tasks.before.deployManifest package.
Note: If your policy is for controlling manual deletion triggers from within the spinnaker UI that are not triggered via a pipeline, more information is available in policies written against the spinnaker.http.authz package.

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
This example policy will prevent deleteMAnifest tasks from running unless they provide a grasce period of >= 30 seconds.
```rego
package spinnaker.deployment.tasks.before.deleteManifest

deny["A minimum 30 second grace period must be given when deleting a kubernetes manifest"] { 
  input.deploy.options.gracePeriodSeconds<30
}

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
| `input.deploy.options.propagationPolicy`  | ` `       |      There are three different ways to delete a Kubernetes object:

Foreground: The object itself cannot be deleted unless the objects that it owns have already been deleted.
Background: The object itself is deleted, then the objects that it owned are automatically deleted.
Orphan: The object itself is deleted. Any objects it owns are “orphaned.”                                  |
