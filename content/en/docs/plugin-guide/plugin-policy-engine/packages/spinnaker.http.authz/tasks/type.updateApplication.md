---
title: "spinnaker.http.authz.tasks.type.updateApplication"
linktitle: "type.updateApplication"
description: "fill me with delicious data, Stephen!"
---

## Example Payload

<details><summary>Click to expand</summary>

```json
{
  "input": {
    "body": {
      "application": "aftest2",
      "description": "Update Application: aftest2",
      "job": [
        {
          "application": {
            "cloudProviders": "kubernetes",
            "dataSources": {
              "disabled": [],
              "enabled": []
            },
            "description": "description2",
            "email": "dasdasd@trest.com",
            "instancePort": 80,
            "lastModifiedBy": "myUserName",
            "name": "aftest2",
            "permissions": {
              "EXECUTE": [
                "productmanagers"
              ],
              "READ": [
                "productmanagers"
              ],
              "WRITE": [
                "productmanagers"
              ]
            },
            "repoProjectKey": "project",
            "repoSlug": "name",
            "repoType": "github",
            "trafficGuards": [],
            "updateTs": "1621444448000",
            "user": "myUserName"
          },
          "type": "updateApplication",
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

```rego

```

## Keys

| Key                                                  | Type      | Description |
| :--------------------------------------------------- | :-------- | ----------- |
| `input.body.application`                             | `string`  |             |
| `input.body.description`                             | `string`  |             |
| `input.body.job[].application.cloudProviders`        | `string`  |             |
| `input.body.job[].application.description`           | `string`  |             |
| `input.body.job[].application.email`                 | `string`  |             |
| `input.body.job[].application.instancePort`          | `number`  |             |
| `input.body.job[].application.lastModifiedBy`        | `string`  |             |
| `input.body.job[].application.name`                  | `string`  |             |
| `input.body.job[].application.permissions.EXECUTE[]` | `string`  |             |
| `input.body.job[].application.permissions.READ[]`    | `string`  |             |
| `input.body.job[].application.permissions.WRITE[]`   | `string`  |             |
| `input.body.job[].application.repoProjectKey`        | `string`  |             |
| `input.body.job[].application.repoSlug`              | `string`  |             |
| `input.body.job[].application.repoType`              | `string`  |             |
| `input.body.job[].application.updateTs`              | `string`  |             |
| `input.body.job[].application.user`                  | `string`  |             |
| `input.body.job[].type`                              | `string`  |             |
| `input.body.job[].user`                              | `string`  |             |
| `input.method`                                       | `string`  |             |
| `input.path[]`                                       | `string`  |             |
| `input.user.isAdmin`                                 | `boolean` |             |
| `input.user.roles[].name`                            | `string`  |             |
| `input.user.roles[].source`                          | `string`  |             |
| `input.user.username`                                | `string`  |             |
| `input.body.job[].application.createTs`              | `string`  |             |
| `input.body.job[].application.platformHealthOnly`    | `boolean` |             |
