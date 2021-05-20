---
title: "spinnaker.http.authz.tasks.createApplication"
linktitle: "createApplication"
description: "fill me with delicious data, Stephen!"
---

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
          "user": "stephenatwell"
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
      "username": "stephenatwell"
    }
  }
}
```
</details>

## Example Policy

```rego

```

## Keys

| Key                                                  |   Type    | Description |
| :--------------------------------------------------- | :-------: | ----------- |
| `input.body.application`                             | `string`  |             |
| `input.body.description`                             | `string`  |             |
| `input.body.job[].application.cloudProviders`        | `string`  |             |
| `input.body.job[].application.email`                 | `string`  |             |
| `input.body.job[].application.instancePort`          | `number`  |             |
| `input.body.job[].application.name`                  | `string`  |             |
| `input.body.job[].type`                              | `string`  |             |
| `input.body.job[].user`                              | `string`  |             |
| `input.method`                                       | `string`  |             |
| `input.path[]`                                       | `string`  |             |
| `input.user.isAdmin`                                 | `boolean` |             |
| `input.user.roles[].name`                            | `string`  |             |
| `input.user.roles[].source`                          | `string`  |             |
| `input.user.username`                                | `string`  |             |
| `input.body.job[].application.description`           | `string`  |             |
| `input.body.job[].application.permissions.EXECUTE[]` | `string`  |             |
| `input.body.job[].application.permissions.READ[]`    | `string`  |             |
| `input.body.job[].application.permissions.WRITE[]`   | `string`  |             |
| `input.body.job[].application.repoProjectKey`        | `string`  |             |
| `input.body.job[].application.repoSlug`              | `string`  |             |
| `input.body.job[].application.repoType`              | `string`  |             |
