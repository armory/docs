---
title: "spinnaker.deployment.tasks.before.undoRolloutManifest"
linkTitle: "undoRolloutManifest"
description: "Policy checks that run immediately before a task rolls back a spinnaker manifest."
---

## Example Payload

<details><summary>Click to expand</summary>

```json
{
  "input": {
    "deploy": {
      "account": "spinnaker",
      "credentials": "spinnaker",
      "events": [],
      "location": "staging",
      "manifestName": "deployment hostname",
      "numRevisionsBack": 1,
      "revision": null
    }
  }
}
```
</details>

## Example Policy

{{< prism lang="rego" line-numbers="true" >}}
package spinnaker.deployment.tasks.before.undoRolloutManifest

deny ["You may only rollback 1 revision at a time."]{
	input.deploy.numRevisionsBack!=1
}
{{< /prism >}}

## Keys

| Key                             | Type     | Description                                                   |
| ------------------------------- | -------- | ------------------------------------------------------------- |
| `input.deploy.account`          | `string` | The spinnaker account to which this stage is deploying.       |
| `input.deploy.credentials`      | `string` | The credentials to use to access the account.                 |
| `input.deploy.location`         | `string` | The name of the namespace the manifest is being deleted from. |
| `input.deploy.manifestName`     | `string` | The name of the manifest being deleted.                       |
| `input.deploy.numRevisionsBack` | `number` | How many revisions of the manifest should be rolled back.     |
| `input.deploy.revision`         | `number` | What revision the manifest should be rolled back to.          |
