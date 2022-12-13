---
title: "artifacts"
linkTitle: "artifacts"
description: Artifact arrays are common throughout Spinnaker, and are largely the same.
---

An [artifact](https://spinnaker.io/reference/artifacts/) is an object that references an external resource. 

The objects and endpoints found in:

- `artifacts`,
- `boundArtifact`,
- `createdArtifacts`,
- `expectedArtifacts`,
- `matchArtifact`,
- `optionalArtifacts`,
- and `resolvedExpectedArtifacts`,

are the same. Additionally:

- `boundArtifact`,
- `defaultArtifact`,
- and `matchArtifact`

can be found as sub-arrays of `expectedArtifacts` `resolvedExpectedArtifacts`.

The table below continues the path from the artifact array:

| Key                  | Type      | Description                                                                                                                                                                                                 |
| -------------------- | --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `artifactAccount`    | `string`  | If your artifact either was not supplied from a trigger, or it was not found in a prior execution, this account provides a default artifact.                                                                  |
| `customKind`         | `boolean` |                                                                                                                                                                                                             |
| `location`           |           |                                                                                                                                                                                                             |
| `metadata.account`   | `string`  |                                                                                                                                                                                                             |
| `metadata.id`        | `string`  | The unique ID of the default artifact                                                                                                                                                                       |
| `name`               | `string`  | The display name of the default artifact                                                                                                                                                                    |
| `provenance`         |           |                                                                                                                                                                                                             |
| `reference`          | `string`  |                                                                                                                                                                                                             |
| `type`               | `string`  |                                                                                                                                                                                                             |
| `version`            | `string`  | what version/branch of the artifact should be read from the account.                                                                                                                                        |
| `id`                 | `string`  |                                                                                                                                                                                                             |
| `useDefaultArtifact` | `boolean` | If your artifact either was not supplied from a trigger, or it was not found in a prior execution, the artifact specified below ends up in your pipeline's execution context.                                 |
| `usePriorArtifact`   | `boolean` | Attempt to match against an artifact in the prior pipeline execution's context. This ensures that you always be using the most recently supplied artifact to this pipeline and is generally a safe choice. |
| `uuid`               |           |                                                                                                                                                                                                             |