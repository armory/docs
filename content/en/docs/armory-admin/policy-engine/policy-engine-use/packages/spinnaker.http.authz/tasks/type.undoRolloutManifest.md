---
title: "Task Type: undoRolloutManifest"
linktitle: "undoRolloutManifest"
description: "Policy controls whether or not a rollback that is triggered from outside a spinnaker pipeline (e.g. from the 'Clusters' tab of an application) can run."
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
      "description": "Undo rollout of manifest",
      "job": [
        {
          "account": "spinnaker",
          "cloudProvider": "kubernetes",
          "location": "staging",
          "manifestName": "deployment hostname",
          "reason": "someReason",
          "revision": "3",
          "type": "undoRolloutManifest",
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

## Keys

| Key                              | Type      | Description                                                         |
| -------------------------------- | --------- | ------------------------------------------------------------------- |
| `input.body.application`         | `string`  | The name of the application that is being rolled back.              |
| `input.body.description`         | `string`  | Always "Undo rollout of manifest".                                  |
| `input.body.job[].account`       | `string`  | The account in which the deployment is being rolled back.           |
| `input.body.job[].cloudProvider` | `string`  | The cloud provider of the account in which the rollback will occur. |
| `input.body.job[].location`      | `string`  | The namespace of the manifest being rolled back.                    |
| `input.body.job[].manifestName`  | `string`  | The type and name of the manifest being rolled back.                |
| `input.body.job[].reason`        | `string`  | The reason provided by the user for initiating the rollback.        |
| `input.body.job[].revision`      | `string`  | The revision to which the manifest should be rolled back.           |
| `input.body.job[].type`          | `string`  | Always "undoRolloutManifest"                                        |
| `input.body.job[].user`          | `string`  | the ID of the user who initiated the rollback.                      |
| `input.method`                   | `string`  | `POST`                                                              |
| `input.path[]`                   | `string`  | `["tasks"]`                                                         |
| `input.user.isAdmin`             | `boolean` |                                                                     |
| `input.user.username`            | `string`  |                                                                     |
