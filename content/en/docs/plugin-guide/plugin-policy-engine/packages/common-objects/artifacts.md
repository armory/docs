---
title: "artifacts"
linkTitle: "artifacts"
description: "The objects and endpoints found in `expectedArtifacts` and `resolvedExpectedArtifacts` will be the same."
---

Tooltip copy goes here.

The table below continues the path from `expectedArtifacts[]` or `resolvedExpectedArtifacts[]`:

| Key                                                                  | Type      | Description                                                                                                                                                                                                      |
| -------------------------------------------------------------------- | --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `defaultArtifact.artifactAccount` | `string`  | If your artifact either wasn't supplied from a trigger, or it wasn't found in a prior execution, this account provides a default artifact.                                                                       |
| `defaultArtifact.customKind`      | `boolean` |                                                                                                                                                                                                                  |
| `defaultArtifact.metadata.id`     | `string`  | The unique ID of the default artifact                                                                                                                                                                            |
| `defaultArtifact.name`            | `string`  | The display name of the default artifact                                                                                                                                                                         |
| `defaultArtifact.reference`       | `string`  |                                                                                                                                                                                                                  |
| `defaultArtifact.type`            | `string`  |                                                                                                                                                                                                                  |
| `defaultArtifact.version`         | `string`  | what version/branch of the artifact should be read from the account.                                                                                                                                             |
| `id`                              | `string`  |                                                                                                                                                                                                                  |
| `matchArtifact.artifactAccount`   | `string`  | this account provides an artifact.                                                                                                                                                                               |
| `matchArtifact.customKind`        | `boolean` |                                                                                                                                                                                                                  |
| `matchArtifact.metadata.id`       | `string`  |                                                                                                                                                                                                                  |
| `matchArtifact.name`              | `string`  | The display name of the artifact                                                                                                                                                                                 |
| `matchArtifact.type`              | `string`  |                                                                                                                                                                                                                  |
| `useDefaultArtifact`              | `boolean` | If your artifact either wasn't supplied from a trigger, or it wasn't found in a prior execution, the artifact specified below will end up in your pipeline's execution context.                                  |
| `usePriorArtifact`                | `boolean` | Attempt to match against an artifact in the prior pipeline execution's context. This ensures that you will always be using the most recently supplied artifact to this pipeline, and is generally a safe choice. |