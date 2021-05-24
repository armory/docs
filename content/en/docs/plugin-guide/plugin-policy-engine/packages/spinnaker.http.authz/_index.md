---
title: spinnaker.http.authz
linkTitle: spinnaker.http.authz
description: this policy allows you to write policies on spinnakers core APIs. This allows restricting many actions from the UI, or from custom API clients. Many paths in here have dedicated packages weritten for them, and in such cases it is reccomended to write your package against the dedicated package rather than spinnaker.http.authz. spinnaker.http.authz is available because it grants the ability to write policy on almost any UI event within spinnaker.
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
This policy simply grants all users access to all APIs. It is a goiod policy to put on spinnaker.,http.authz if you do not need a more complicated policy.
```rego
Grants full API access in spinnaker.
package spinnaker.http.authz
default allow = true
allow {
    input.user.isAdmin == true
}
```

Special considerations:
unlike most other packages, when writing policies against 'spinnaker.http.authz' you must return a single boolean value named 'allow'. If 'allow' is 'false' then access will be denied.
A second optional parameter named 'message' can be passed back, set to a string. If 'message' is returned and 'allow' is false, then the given message will bereturned to the API call, and in many cases displayed to the user if the UI made the API call.

 ## Keys

| Key                         | Type      | Description |
| :-------------------------- | --------- | ----------- |
| `input.method`              | `string`  | The HTTP method that is being used to call the API            |
| `input.path[]`              | `string`  | This array corresponds to the subpath of the API being invoked.            |
| `input.user.isAdmin`        | `boolean` |             |
| `input.user.username`       | `string`  |             |
| `input.user.roles[].name`   | `string`  |             |
| `input.user.roles[].source` | `string`  |             |

Other objects are listed below:
