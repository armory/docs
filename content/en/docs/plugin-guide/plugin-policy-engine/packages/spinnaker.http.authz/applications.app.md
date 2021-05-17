---
title: "spinnaker.http.authz.applications.<app>"
linktitle: "applications.<app>"
description: "fill me with delicious data, Stephen!"
---

`<app>` is a placeholder value for the application name defined in your Spinnaker instance.

## Example Payload

<details><summary>Click to expand</summary>

```json
{
  "input": {
    "method": "GET",
    "path": [
      "applications",
      "anotherAppName",
      "clusters"
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

| Key                         | Type      | Description |
| --------------------------- | --------- | ----------- |
| `input.method`              | `string`  |             |
| `input.path[]`              | `string`  |             |
| `input.user.isAdmin`        | `boolean` |             |
| `input.user.roles[].name`   | `string`  |             |
| `input.user.roles[].source` | `string`  |             |
| `input.user.username`       | `string`  |             |
