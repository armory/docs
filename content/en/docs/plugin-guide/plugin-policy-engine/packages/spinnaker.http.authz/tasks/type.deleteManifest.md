---
title: "Task Type: deleteManifest"
linktitle: "deleteManifest"
description: "fill me with delicious data, Stephen!"
---

- **Path:** tasks
- **Method:** Post
- **Package:** `spinnaker.http.authz`

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
This example will prevent users from deleting deployed manifests from production accounts on the 'Clusters' tab of the spinnaker UI.
```rego
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
```

## Keys

| Key                                           | Type      | Description |
| :-------------------------------------------- | --------- | ----------- |
| `input.body.application`                      | `string`  | The name of the application that deployed the manifest that is being deleted.            |
| `input.body.description`                      | `string`  | The phrase "Delete Manifest"            |
| `input.body.job[].account`                    | `string`  | The spinnaker account that will delete the manifest            |
| `input.body.job[].cloudProvider`              | `string`  | The cloud provider running the manifest, typically 'kubernetes'            |
| `input.body.job[].location`                   | `string`  | The namespace from which the manifest will be deleted.            |
| `input.body.job[].manifestName`               | `string`  | The name of the manifest to delete            |
| `input.body.job[].options.gracePeriodSeconds` | `number`  | How many seconds the resource identified by the manifest will be given to shut down gracefully before being forcefully terminated.            |
| `input.body.job[].options.orphanDependants`   | `boolean` | if false dependant kubernetes resources will also be deleted, if false they will be orphaned.            |
| `input.body.job[].reason`                     | ` `       |             |
| `input.body.job[].type`                       | `string`  | deleteManifest            |
| `input.body.job[].user`                       | `string`  | The ID of the user who started the job. More information is available under the input.user fields.            |
| `input.method`                                | `string`  | POST            |
| `input.path[]`                                | `string`  | `[tasks]`            |
| `input.user.isAdmin`                          | `boolean` |             |
| `input.user.username`                         | `string`  |             |
