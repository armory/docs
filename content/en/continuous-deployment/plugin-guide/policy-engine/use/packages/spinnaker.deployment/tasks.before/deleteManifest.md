---
title: "spinnaker.deployment.tasks.before.deleteManifest"
linkTitle: "deleteManifest"
description: "Policy checks that run immediate before a task deletes a spinnaker manifest."
---

If your policy is for controlling deletion from within a pipeline, more information is available in policies written against the [spinnaker.deployment.tasks.before.deployManifest]({{< ref "deployManifest.md" >}}) package.

If your policy is for controlling manual deletion triggers from within the Armory Continuous Deployment UI that are not triggered via a pipeline, more information is available in policies written against the [spinnaker.http.authz](/docs/plugin-guide/plugin-policy-engine/packages/spinnaker.http.authz/) package.

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
This example policy prevents deleteManifest tasks from running unless they provide a grace period of 30 seconds or more.

{{< prism lang="rego" line-numbers="true" >}}
package spinnaker.deployment.tasks.before.deleteManifest

deny["A minimum 30 second grace period must be given when deleting a kubernetes manifest"] { 
  input.deploy.options.gracePeriodSeconds<30
}
{{< /prism >}}

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
| `input.deploy.options.gracePeriodSeconds` | `number`  | How many seconds should the resource being deleted be given to shut down gracefully before being forcefully shut down.                    |
| `input.deploy.options.kind`               | `string`  | The kind of manifest that is being deleted.                                                                                       |
| `input.deploy.options.orphanDependents`   | `boolean` | When set, delete all resources managed by this resource as well (all pods owned by a replica set). When unset, this may orphan resources. |
| `input.deploy.options.preconditions`      |           |                                                                                                                                           |
| `input.deploy.options.propagationPolicy`  | `string`  | There are three different ways to delete a Kubernetes object:<br/> Foreground: The object itself cannot be deleted unless the objects that it owns have already been deleted.<br/> Background: The object itself is deleted, then the objects that it owned are automatically deleted.<br/> Orphan: The object itself is deleted. Any objects it owns are “orphaned.” |
