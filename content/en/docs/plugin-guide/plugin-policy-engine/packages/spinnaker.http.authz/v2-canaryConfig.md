---
title: "spinnaker.http.authz.v2/canaryConfig"
linktitle: "v2/canaryConfig"
description: "fill me with delicious data, Stephen!"
---

## Example Payload

<details><summary>Click to expand</summary>

```json
{
  "input": {
    "method": "GET",
    "path": [
      "v2",
      "canaryConfig"
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

```rego

```

## Keys

| Key                         | Type      | Description |
| :-------------------------- | --------- | ----------- |
| `input.method`              | `string`  |             |
| `input.path[]`              | `string`  |             |
| `input.user.isAdmin`        | `boolean` |             |
| `input.user.username`       | `string`  |             |
| `input.user.roles[].name`   | `string`  |             |
| `input.user.roles[].source` | `string`  |             |
