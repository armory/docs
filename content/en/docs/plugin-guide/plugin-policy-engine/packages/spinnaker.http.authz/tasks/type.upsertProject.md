---
title: "spinnaker.http.authz.tasks.type.upsertProject"
linktitle: "type.upsertProject"
description: "fill me with delicious data, Stephen!"
---

## Example Payload

<details><summary>Click to expand</summary>

```json
{
  "input": {
    "body": {
      "application": "spinnaker",
      "description": "Create project: testProjectName",
      "job": [
        {
          "project": {
            "config": {
              "applications": [
                "hostname"
              ],
              "clusters": [
                {
                  "account": "spinnaker",
                  "detail": "*",
                  "stack": "*"
                }
              ],
              "pipelineConfigs": [
                {
                  "application": "hostname",
                  "pipelineConfigId": "7db1e350-dedb-4dc1-9976-e71f97b5f132"
                }
              ]
            },
            "email": "stephen.atwell@armory.io",
            "name": "testProjectName"
          },
          "type": "upsertProject",
          "user": "elfie2002"
        }
      ],
      "project": "testProjectName"
    },
    "method": "POST",
    "path": [
      "tasks"
    ],
    "user": {
      "isAdmin": false,
      "roles": [],
      "username": "elfie2002"
    }
  }
}
```
</details>

## Example Policy

```rego

```

## Keys

| Key                                          | Type      | Description                                              |
|----------------------------------------------|-----------|----------------------------------------------------------|
| `input.body.application` | `string` |
| `input.body.description` | `string` |
| `input.body.job[].project.config.applications[]` | `string` |
| `input.body.job[].project.config.clusters[].account` | `string` |
| `input.body.job[].project.config.clusters[].detail` | `string` |
| `input.body.job[].project.config.clusters[].stack` | `string` |
| `input.body.job[].project.config.pipelineConfigs[].application` | `string` |
| `input.body.job[].project.config.pipelineConfigs[].pipelineConfigId` | `string` |
| `input.body.job[].project.email` | `string` |
| `input.body.job[].project.name` | `string` |
| `input.body.job[].type` | `string` |
| `input.body.job[].user` | `string` |
| `input.body.project` | `string` |
| `input.method` | `string` |
| `input.path[]` | `string` |
| `input.user.isAdmin` | `boolean` |
| `input.user.username` | `string` |
| `input.body.job[].project.config.clusters[].applications` | ` ` |
| `input.body.job[].project.createTs` | `number` |
| `input.body.job[].project.id` | `string` |
| `input.body.job[].project.lastModifiedBy` | `string` |
| `input.body.job[].project.updateTs` | `number` |
