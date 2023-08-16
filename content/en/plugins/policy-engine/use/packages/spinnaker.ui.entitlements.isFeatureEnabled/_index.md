---
title: spinnaker.ui.entitlements.isFeatureEnabled
linkTitle: spinnaker.ui.entitlements.isFeatureEnabled
Description: Allows UI elements to be hidden from the UI entirely.
weight: 10
---

> **Note:** This package is only available if you are running policy engine version 0.1.2 or later.

When hiding an element from the UI via this package, Armory reccomends also disabling it in `spinnaker.http.authz`, which will prevent the same users from invoking it via API. `spinnaker.http.authz` can access the same fields as this package, but also contains more keys.

Note: this package only allows hiding functionality entirely. If you instead want to conditionally disable features based off property's pased to them, that can often be done in the `spinnaker.http.authz` package.

## Example Payload

<details><summary>Click to expand</summary>

```json
{
  "input": {
    "body": {
      "job": [
        {
          "type": "createApplication"
        }
      ]
    },
    "method": "POST",
    "path": [
      "tasks"
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

Disables the **Configure Application**, **Create Application**, and **Create Project** buttons in the UI for non-admin users unless they have a particular role.

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

| Key                     | Type     | Description                                                                                                 |
| ----------------------- | -------- | ----------------------------------------------------------------------------------------------------------- |
| `input.body.job[].type` | `string` | Only available if `input.path=[tasks].` Contains the type of the task being performed.                      |
| `input.method`          | `string` | The method of the API call for which we are hiding UI elements. This is 'HTTP Get' to hide the projects UI. |
| `input.path[]`          | `string` | The path to the API call that UI elements are hiden for. This is "Projects".                                |

### input.user

This object provides information about the user performing the action. This can be used to restrict actions by role. See [input.user]({{< ref "input.user.md" >}}) for more information.

## Supported UI Elements

The following table provides a summary of the values to check in the policy to enable/disable different UI elements.

| UI Element                       | input.path.    | input.method | input.body.job[].type  |
| -------------------------------- | -------------- | ------------ | ---------------------- |
| Create Application Button        | `["tasks"]`    | POST         | createApplication      |
| Application Configuration Button | `["tasks"]`    | POST         | updateApplication      |
| Create Project Button            | `["tasks"]`    | POST         | upsertProject          |
| Project Configuration Button     | `["projects"]` | GET          | n/a                    |