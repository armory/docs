---
title: spinnaker.http.authz
linkTitle: spinnaker.http.authz
weight: 10
---

The following objects in `spinnaker.http.authz` all contain the same endpoints:

 - `applications`
 - `applications.<app>`
 - `projects`
 - `v2/canaryConfig`

## Example Payload

<details><summary>Click to expand</summary>

```json
{
  "input": {
    "method": "GET",
    "path": [
      "applications"
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
| :-------------------------- | --------- | ----------- |
| `input.method`              | `string`  |             |
| `input.path[]`              | `string`  |             |
| `input.user.isAdmin`        | `boolean` |             |
| `input.user.username`       | `string`  |             |
| `input.user.roles[].name`   | `string`  |             |
| `input.user.roles[].source` | `string`  |             |

Other objects are listed below: