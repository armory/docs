---
title: "Task Type: scaleManifest"
linktitle: "scaleManifest"
description: "Policy controls whether or not a scaleManifest that is triggered from outside a spinnaker pipeline (e.g. from the ‘Clusters’ tab of an application’s ‘edit’ action) can run."
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
      "description": "Scale manifest",
      "job": [
        {
          "account": "spinnaker",
          "cloudProvider": "kubernetes",
          "location": "staging",
          "manifestName": "deployment hostname",
          "reason": null,
          "replicas": "5",
          "type": "scaleManifest",
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
This policy prevents non-admin users from initiating a scaleManifest from the 'clusters' tab of an application.
```rego
package spinnaker.http.authz
default message=""
allow = message==""
message = "Your role lacks permissions to scale applications outside of pipelines"{
      createsTaskOfType("scaleManifest")
      input.user.isAdmin!=true
}

createsTaskOfType(tasktype){
    input.method="POST"
    input.path=["tasks"]
    input.body.job[_].type=tasktype
}
```

## Keys

| Key                              | Type      | Description |
| -------------------------------- | --------- | ----------- |
| `input.body.application`         | `string`  | The name of the application for which the manifest is being scaled.            |
| `input.body.description`         | `string`  | Always `Scale Manifest`            |
| `input.body.job[].account`       | `string`  | The name of the account in which the manifest will be scaled            |
| `input.body.job[].cloudProvider` | `string`  | The name of the cloud provider in which the manifest is being scaled.           |
| `input.body.job[].location`      | `string`  | The namespace of the manifest beign scaled.            |
| `input.body.job[].manifestName`  | `string`  | The name of the manifest being scaled            |
| `input.body.job[].reason`        | ` `       | The reason the user enteres to explain the reason for this change            |
| `input.body.job[].replicas`      | `string`  | The desired number of running pods after scaling.            |
| `input.body.job[].type`          | `string`  | Always `scaleManifest`            |
| `input.body.job[].user`          | `string`  | The username of the user starting the task. It is reccomended to write rules using input.user instead.            |
| `input.method`                   | `string`  | POST            |
| `input.path[]`                   | `string`  | `["tasks"]`            |
| `input.user.isAdmin`             | `boolean` |             |
| `input.user.username`            | `string`  |             |
