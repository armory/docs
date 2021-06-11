---
title: "Tasks"
linkTitle: "Tasks"
description: "Posts to the tasks api create new tasks in Spinnaker."
---

- **Path:** tasks
- **Method:** Post
- **Package:** `spinnaker.http.authz`

The following rego function can be leveraged in any task to determine what task type is being created:

{{< prism lang="rego" line-numbers="true" >}}
    createsTaskOfType(tasktype){
        input.method="POST"
        input.path=["tasks"]
        input.body.job[_].type=tasktype
    }
{{< /prism >}}

## Keys

| Key            |   Type   | Description                                                                             |
| :------------- | :------: | --------------------------------------------------------------------------------------- |
| `input.body`   | `object` | The contents of this field will depend on the task type. It corresponds to the payload body being posted to the spinnaker API for that task. If your policy needs to conditionally enable/disable a task based off a property being configured by that task, the value you need will likely be in this object. |
| `input.method` | `string` | The HTTP method by which the API is being called. When createing a task this is 'POST'. |
| `input.path[]` | `string` | The API path of the job. When creating a new task this is the array `["tasks"]`.        |


### input.user

This object provides information about the user performing the action. This can be used to restrict actions by role. See [input.user]({{< ref "input.user.md" >}}) for more information.

# Task Types
