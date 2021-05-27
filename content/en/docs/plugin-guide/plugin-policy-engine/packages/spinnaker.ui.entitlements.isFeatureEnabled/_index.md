---
title: spinnaker.ui.entitlements.isFeatureEnabled
linkTitle: spinnaker.ui.entitlements.isFeatureEnabled
Description: Allows UI elements to be hidden from the Spinnaker UI entirely.
weight: 10
---
IMPORTANT: This package is only available if you are running policy engine version 0.1.2 or later.

When hiding an element from the UI via this package, Armory reccomends also disabling it in spinnaker.http.authz, which will prevent the same users from invoking it via API. spinnaker.http.authz can access the same fields as this package, but also contains more keys.

Note: this package only allows hiding functionality entirely. If you instead want to conditionally disable features based off property's pased to them, that can often be done in the spinnaker.http.authz package.

## Example Payload

<details><summary>Click to expand</summary>

```json
{
  "input": {
    "body": {
      "job": [
        {
          "type": "createApplication"
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
| `input.body.job[].type`     | `string`  | Only available if input.path=`[tasks].` Contains the type of the task being performed.            |
| `input.method`              | `string`  | The method of the API call for which we are hiding UI elements. This will be 'HTTP Get' to hide the projects UI.            |
| `input.path[]`              | `string`  | The path to the API call that UI elements will be hiden for. This is 'Projects'            |
| `input.user.isAdmin`        | `boolean` |             |
| `input.user.roles[].name`   | `string`  |             |
| `input.user.roles[].source` | `string`  |             |
| `input.user.username`       | `string`  |             |
