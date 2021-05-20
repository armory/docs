---
title: "spinnaker.http.authz.projects"
linktitle: "projects"
description: "fill me with delicious data, Stephen!"
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

| Key                         | Type      | Description |
| --------------------------- | --------- | ----------- |
| `input.body.`               | `string`  |             |
| `input.method`              | `string`  |             |
| `input.path[]`              | `string`  |             |
| `input.user.isAdmin`        | `boolean` |             |
| `input.user.username`       | `string`  |             |
| `input.user.roles[].name`   | `string`  |             |
| `input.user.roles[].source` | `string`  |             |
