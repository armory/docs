---
title: "spinnaker.ui.entitlements.isFeatureEnabled.projects"
linktitle: "projects"
description: "Can hide UI Elements from Spinnaker"
---

## Example Payload

<details><summary>Click to expand</summary>

```json
{
  "input": {
    "body": {
      "": ""
    },
    "method": "GET",
    "path": [
      "projects"
    ],
    "user": {
      "isAdmin": false,
      "roles": [
        {
          "name": "armory-io",
          "source": "GITHUB_TEAMS"
        },
        {
          "name": "productmanagers",
          "source": "GITHUB_TEAMS"
        }
      ],
      "username": "myUserName"
    }
  }
}
```
</details>

## Example Policy
Disables the 'configure projects' button of the spinnaker UI for non-admin users.
```rego
package spinnaker.ui.entitlements.isFeatureEnabled

default allow=true
allow=false{
	count(input.path)==1
    input.path[0]=="projects"
    input.method=="GET"
    input.user.isAdmin!=true
}
```
## Example Policy
Disables the 'configure application' and 'create application' buttons of the spinnaker UI for non-admin users unless they have a particular role.
```rego
    package spinnaker.ui.entitlements.isFeatureEnabled
    default message=""
    allow = message==""
    message = "Your role lacks permissions to update application configuration"{
          createsTaskOfType(["updateApplication","createApplication"][_])
          input.user.isAdmin!=true
          not hasRole("applicationAdmins")
    }
    message = "Your role lacks permissions to create projects"{
          createsTaskOfType("upsertProject")
          input.user.isAdmin!=true
          not hasRole("qa")
    }
    hasRole(role){
        input.user.roles[_].name=role
    }
    createsTaskOfType(tasktype){
        input.method="POST"
        input.path=["tasks"]
        input.body.job[_].type=tasktype
    }
```
## Example Policy
Disables the 'create project' button of the spinnaker UI for non-admin users unless they have a particular role.
```rego
    package spinnaker.ui.entitlements.isFeatureEnabled
    default message=""
    allow = message==""
    message = "Your role lacks permissions to create projects"{
          createsTaskOfType("upsertProject")
          input.user.isAdmin!=true
          not hasRole("projectAdmin")
    }
    hasRole(role){
        input.user.roles[_].name=role
    }
    createsTaskOfType(tasktype){
        input.method="POST"
        input.path=["tasks"]
        input.body.job[_].type=tasktype
    }
```

## Keys

| Key                         | Type      | Description |
| --------------------------- | --------- | ----------- |
| `input.body.job[].type`     | `string`  | Only available if input.path=`[tasks].` Contains the type of the task being performed.            |
| `input.method`              | `string`  | The method of the API call for which we are hiding UI elements. This will be 'HTTP Get' to hide the projects UI.            |
| `input.path[]`              | `string`  | The path to the API call that UI elements will be hiden for. This is 'Projects'            |
| `input.user.isAdmin`        | `boolean` |             |
| `input.user.roles[].name`   | `string`  |             |
| `input.user.roles[].source` | `string`  |             |
| `input.user.username`       | `string`  |             |

## Supported UI Elements

| UI Element                         | path      | method |
| --------------------------- | --------- | ----------- |
| `input.method`              | `string`  | The method of the API call for which we are hiding UI elements. This will be 'HTTP Get' to hide the projects UI.            |
| `input.path[]`              | `string`  | The path to the API call that UI elements will be hiden for. This is 'Projects'            |
| `input.user.isAdmin`        | `boolean` |             |
| `input.user.roles[].name`   | `string`  |             |
| `input.user.roles[].source` | `string`  |             |
| `input.user.username`       | `string`  |             |
