---
title: "Task Type: scaleManifest"
linktitle: "scaleManifest"
description: "Policy controls whether or not a scaleManifest that is triggered from outside a spinnaker pipeline (e.g. from the ‘Clusters’ tab of an application’s ‘edit’ action) can run."
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

- This policy prevents requires users to enter a reason when performing a scale from outside or a pipeline.

  {{< prism lang="rego" line-numbers="true" >}}
  package spinnaker.http.authz
  default message=""
  allow = message==""
  message = "You must provide a reason when scaling a manifest outside of a pipeline."{
        createsTaskOfType("scaleManifest")
        object.get(input.body.job[_],"reason",null)==null
  }

  createsTaskOfType(tasktype){
      input.method="POST"
      input.path=["tasks"]
      input.body.job[_].type=tasktype
  }
  {{< /prism >}}

- This policy prevents non-admin users from initiating a scaleManifest from the 'clusters' tab of an application.

  {{< prism lang="rego" line-numbers="true" >}}
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
  {{< /prism >}}

## Keys

| Key                              | Type     | Description                                                                                              |
| -------------------------------- | -------- | -------------------------------------------------------------------------------------------------------- |
| `input.body.application`         | `string` | The name of the application for which the manifest is being scaled.                                      |
| `input.body.description`         | `string` | Always "Scale Manifest".                                                                                 |
| `input.body.job[].account`       | `string` | The name of the account in which the manifest is scaled.                                                 |
| `input.body.job[].cloudProvider` | `string` | The name of the cloud provider in which the manifest is being scaled.                                    |
| `input.body.job[].location`      | `string` | The namespace of the manifest beign scaled.                                                              |
| `input.body.job[].manifestName`  | `string` | The name of the manifest being scaled.                                                                   |
| `input.body.job[].reason`        | `string` | The reason the user entered to explain the change.                                                       |
| `input.body.job[].replicas`      | `string` | The desired number of running pods after scaling.                                                        |
| `input.body.job[].type`          | `string` | Always "scaleManifest"                                                                                   |
| `input.body.job[].user`          | `string` | The username of the user starting the task. It is reccomended to write rules using `input.user` instead. |
| `input.method`                   | `string` | `POST`                                                                                                   |
| `input.path[]`                   | `string` | `["tasks"]`                                                                                              |

### input.user

This object provides information about the user performing the action. This can be used to restrict actions by role. See [input.user]({{< ref "input.user.md" >}}) for more information.
