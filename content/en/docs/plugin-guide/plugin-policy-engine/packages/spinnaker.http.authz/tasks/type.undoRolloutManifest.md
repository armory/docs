---
title: "Task Type: undoRolloutManifest"
linktitle: "undoRolloutManifest"
description: "fill me with delicious data, Stephen!"
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
      "application": "hostname",
      "description": "Undo rollout of manifest",
      "job": [
        {
          "account": "spinnaker",
          "cloudProvider": "kubernetes",
          "location": "staging",
          "manifestName": "deployment hostname",
          "reason": "someReason",
          "revision": "3",
          "type": "undoRolloutManifest",
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

| Key                                          | Type      | Description                                              |
|----------------------------------------------|-----------|----------------------------------------------------------|
| `input.body.application` | `string` |
| `input.body.description` | `string` |
| `input.body.job[].account` | `string` |
| `input.body.job[].cloudProvider` | `string` |
| `input.body.job[].location` | `string` |
| `input.body.job[].manifestName` | `string` |
| `input.body.job[].reason` | `string` |
| `input.body.job[].revision` | `string` |
| `input.body.job[].type` | `string` |
| `input.body.job[].user` | `string` |
| `input.method` | `string` |
| `input.path[]` | `string` |
| `input.user.isAdmin` | `boolean` |
| `input.user.username` | `string` |
