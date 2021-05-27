---
title: "spinnaker.ui.entitlements.isFeatureEnabled.projects"
linktitle: "projects"
description: "Can hide the 'configure projects' button in the spinnaker UI."
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
Disables the 'configure projects' button of the spinnaker UI for non-admin users.
```rego
package spinnaker.ui.entitlements.isFeatureEnabled

default allow=true
allow=false{
	count(input.path)==1
    input.path[0]=="projects"
    input.method=="GET"
    input.user.isAdmin!=true
}
```

## Keys

| Key                         | Type      | Description |
| --------------------------- | --------- | ----------- |
| `input.method`              | `string`  | The method of the API call for which we are hiding UI elements. This will be 'HTTP Get' to hide the projects UI.            |
| `input.path[]`              | `string`  | The path to the API call that UI elements will be hiden for. This is 'Projects'            |
| `input.user.isAdmin`        | `boolean` |             |
| `input.user.roles[].name`   | `string`  |             |
| `input.user.roles[].source` | `string`  |             |
| `input.user.username`       | `string`  |             |
