---
title: spinnaker.http.authz
linkTitle: spinnaker.http.authz
weight: 10
---

This policy allows you to write policies on Spinnakers core APIs. This allows restricting many actions from the UI, or from custom API clients. Many paths in `http.authz` have dedicated packages written for them, and in such cases it is reccomended to write your package against the dedicated package rather than `spinnaker.http.authz`. `spinnaker.http.authz` is available because it grants the ability to write policy on almost any UI event within spinnaker.

The following paths in `spinnaker.http.authz` all contain the same keys:

 - `applications`
 - `applications.<app>`
 - `projects`
 - `v2/canaryConfig`

Other paths contain additional keys/data that can be used when writing policies.

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

This policy simply grants all users access to all APIs. It is a good policy to enable on `spinnaker.http.authz` if you do not need a more complicated policy.

```rego
package spinnaker.http.authz
default allow = true
allow {
    input.user.isAdmin == true
}
```

## Special considerations

Unlike most other packages, when writing policies against `spinnaker.http.authz` you must return a single boolean value named `allow`. If `allow` is `false` then access is denied.

A second optional parameter named `message` can be passed back, and set to a string. If `message` is returned and `allow` is false, then the given message is returned to the API call, and in many cases displayed to the user if the UI made the API call.

 ## Keys

| Key                         | Type      | Description                                                     |
| :-------------------------- | --------- | --------------------------------------------------------------- |
| `input.method`              | `string`  | The HTTP method being used to call the API.                     |
| `input.path[]`              | `string`  | This array corresponds to the subpath of the API being invoked. |

### input.user

This object provides information about the user performing the action. This can be used to restrict actions by role. See [input.user]({{< ref "input.user.md" >}}) for more information.

<hr/>

Other objects are listed below:
