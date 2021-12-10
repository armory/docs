---
title: "Task Type: deleteManifest"
linktitle: "deleteManifest"
description: "Policy controls whether or not a deleteManifest that is triggered from outside a spinnaker pipeline (e.g. from the 'Clusters' tab of an application) can run."
---

- **Path:** tasks
- **Method:** Post
- **Package:** `spinnaker.http.authz`

{{< include "policy-engine/kubernetesAdHocInfraWritesEnabled.md" >}}

## Example Payload

<details><summary>Click to expand</summary>

```json
{
  "input": {
    "body": {
      "application": "hostname",
      "description": "Delete manifest",
      "job": [
        {
          "account": "spinnaker",
          "cloudProvider": "kubernetes",
          "location": "staging",
          "manifestName": "deployment hostname",
          "options": {
            "gracePeriodSeconds": 5,
            "orphanDependants": false
          },
          "reason": null,
          "type": "deleteManifest",
          "user": "myUserName"
        }
      ]
    },
    "method": "POST",
    "path": [
      "tasks"
    ],
    "user": {
      "isAdmin": false,
      "roles": [],
      "username": "myUserName"
    }
  }
}
```
</details>

## Example Policy

This example prevents users from deleting deployed manifests from production accounts on the 'Clusters' tab of the spinnaker UI.

{{< prism lang="rego" line-numbers="true" >}}
package spinnaker.http.authz
default message=""
allow = message==""

isProductionAccount(account){
	["prodAccount1","prodAccount2"][_]==account
}

message = "Manifests cannot be deleted outside of a pipeline in production accounts"{
      createsTaskOfType("deleteManifest")
      isProductionAccount(input.body.job[_].account)
}
createsTaskOfType(tasktype){
    input.method="POST"
    input.path=["tasks"]
    input.body.job[_].type=tasktype
}
{{< /prism >}}

## Keys

| Key                                           | Type      | Description                                                                                                                   |
| :-------------------------------------------- | --------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `input.body.application`                      | `string`  | The name of the application that deployed the manifest being deleted.                                                         |
| `input.body.description`                      | `string`  | The phrase "Delete Manifest".                                                                                                 |
| `input.body.job[].account`                    | `string`  | The spinnaker account that will delete the manifest.                                                                          |
| `input.body.job[].cloudProvider`              | `string`  | The cloud provider running the manifest, typically "kubernetes".                                                              |
| `input.body.job[].location`                   | `string`  | The namespace from which the manifest is deleted.                                                                             |
| `input.body.job[].manifestName`               | `string`  | The name of the manifest to delete.                                                                                           |
| `input.body.job[].options.gracePeriodSeconds` | `number`  | How many seconds the resource identified by the manifest is given to shut down gracefully before being forcefully terminated. |
| `input.body.job[].options.orphanDependants`   | `boolean` | If `false` dependant kubernetes resources will also be deleted, if `true` they are orphaned.                                  |
| `input.body.job[].reason`                     |           |                                                                                                                               |
| `input.body.job[].type`                       | `string`  | "deleteManifest"                                                                                                              |
| `input.body.job[].user`                       | `string`  | The ID of the user who started the job. More information is available under the `input.user` fields.                          |
| `input.method`                                | `string`  | `POST`                                                                                                                        |
| `input.path[]`                                | `string`  | `[tasks]`                                                                                                                     |

### input.user

This object provides information about the user performing the action. This can be used to restrict actions by role. See [input.user]({{< ref "input.user.md" >}}) for more information.
