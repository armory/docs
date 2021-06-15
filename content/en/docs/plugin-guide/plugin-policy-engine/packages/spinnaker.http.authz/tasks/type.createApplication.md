---
title: "Task Type: createApplication"
linktitle: "createApplication"
description: "A policy call is made for this type anytime a user attmpts to create a new application."
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
      "application": "aftest",
      "description": "Create Application: aftest",
      "job": [
        {
          "application": {
            "cloudProviders": "",
            "email": "af@test.com",
            "instancePort": 80,
            "name": "aftest"
          },
          "type": "createApplication",
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

- This policy disables the ability to create new applications for non-admin users unless their role is 'applicationCreators'.

  {{< prism lang="rego" line-numbers="true" >}}
  package spinnaker.http.authz
  default message=""
  allow = message==""
  message = "Your role lacks permissions to create new applications"{
        createsTaskOfType("createApplication")
        input.user.isAdmin!=true
        not hasRole("applicationCreators")
  }
  hasRole(role){
      input.user.roles[_].name=role
  }
  createsTaskOfType(tasktype){
      input.method="POST"
      input.path=["tasks"]
      input.body.job[_].type=tasktype
  }
  {{< /prism >}}

- This policy disables the ability to create new applications, or update existing applications unless the applications have specified at least 1 role with 'write' permissions.
  **Note:** The spinnaker UI is not currently able to display an error message when this policy denies the action.

  {{< prism lang="rego" line-numbers="true" >}}
  package spinnaker.http.authz

  allow = message==""

  default message=""
  message="You must provide at least 1 user with full execute permissions"{
    not(hasWritePermissions(input.body.job[0]))
    createsTaskOfType(["createApplication","updateApplication"][_])
  }

  hasWritePermissions(job) {
    count(job.application.permissions.WRITE)>0
  }

  createsTaskOfType(tasktype){
      input.method="POST"
      input.path=["tasks"]
      input.body.job[_].type=tasktype
  }
  {{< /prism >}}

## Keys

| Key                                                  |   Type   | Description                                                                             |
| :--------------------------------------------------- | :------: | --------------------------------------------------------------------------------------- |
| `input.body.application`                             | `string` | The name of the application being created.                                              |
| `input.body.description`                             | `string` | The description of the application being created.                                       |
| `input.body.job[].application.cloudProviders`        | `string` | The applications allowed cloud providers.                                               |
| `input.body.job[].application.email`                 | `string` | The email address of the owner of the application.                                      |
| `input.body.job[].application.instancePort`          | `number` |                                                                                         |
| `input.body.job[].application.name`                  | `string` | The name of the application being created.                                              |
| `input.body.job[].type`                              | `string` | The type of task being run, in this case `createApplication`                            |
| `input.body.job[].user`                              | `string` | The ID of the user to run the job as.                                                   |
| `input.method`                                       | `string` | The HTTP method by which the API is being called. When creating a task this is `POST`   |
| `input.path[]`                                       | `string` | The API path of the job. When creating a new task this is the array `["tasks"]`         |
| `input.body.job[].application.description`           | `string` | The description of the application being created.                                       |
| `input.body.job[].application.permissions.EXECUTE[]` | `string` | The list of roles that have execute permission to the application.                      |
| `input.body.job[].application.permissions.READ[]`    | `string` | The list of roles that have read permission to the application.                         |
| `input.body.job[].application.permissions.WRITE[]`   | `string` | The list of roles that have write permission to the application.                        |
| `input.body.job[].application.repoProjectKey`        | `string` | The unique ID of the project in source control.                                         |
| `input.body.job[].application.repoSlug`              | `string` | The slug for the source code repo. Typically the repository's owner or organization ID. |
| `input.body.job[].application.repoType`              | `string` | With what type of sourcecode repo is this application associated.                       |

### input.user

This object provides information about the user performing the action. This can be used to restrict actions by role. See [input.user]({{< ref "input.user.md" >}}) for more information.
