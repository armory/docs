---
title: "input.pipeline.trigger"
linkTitle: "input.pipeline.trigger"
description: "Fields relating to external triggers that start a pipeline."
---

## Keys
| Key                                                        | Type      | Description                                                                              |
| ---------------------------------------------------------- | --------- | ---------------------------------------------------------------------------------------- |
| `input.pipeline.trigger.artifacts[]`                       | `[array]` | See [artifacts]({{< ref "artifacts.md" >}}) for more information.                        |
| `input.pipeline.trigger.correlationId`                     |           |                                                                                          |
| `input.pipeline.trigger.dryRun`                            | `boolean` |                                                                                          |
| `input.pipeline.trigger.enabled`                           | `boolean` | True if the trigger is enabled.                                                          |
| `input.pipeline.trigger.eventId`                           | `string`  |                                                                                          |
| `input.pipeline.trigger.executionId`                       | `string`  |                                                                                          |
| `input.pipeline.trigger.expectedArtifacts[]`               | `[array]` | See [artifacts]({{< ref "artifacts.md" >}}) for more information.                        |
| `input.pipeline.trigger.isDryRun`                          | `boolean` |                                                                                          |
| `input.pipeline.trigger.isRebake`                          | `boolean` |                                                                                          |
| `input.pipeline.trigger.isStrategy`                        | `boolean` |                                                                                          |
| `input.pipeline.trigger.other.artifacts[]`                 | `[array]` | See [artifacts]({{< ref "artifacts.md" >}}) for more information.                        |
| `input.pipeline.trigger.other.dryRun`                      | `boolean` |                                                                                          |
| `input.pipeline.trigger.other.enabled`                     | `boolean` |                                                                                          |
| `input.pipeline.trigger.other.eventId`                     | `string`  |                                                                                          |
| `input.pipeline.trigger.other.executionId`                 | `string`  |                                                                                          |
| `input.pipeline.trigger.other.expectedArtifacts[]`         | `[array]` | See [artifacts]({{< ref "artifacts.md" >}}) for more information.                        |
| `input.pipeline.trigger.other.preferred`                   | `boolean` |                                                                                          |
| `input.pipeline.trigger.other.rebake`                      | `boolean` |                                                                                          |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[]` | `[array]` | See [artifacts]({{< ref "artifacts.md" >}}) for more information.                        |
| `input.pipeline.trigger.other.strategy`                    | `boolean` |                                                                                          |
| `input.pipeline.trigger.other.type`                        | `string`  |                                                                                          |
| `input.pipeline.trigger.other.user`                        | `string`  |                                                                                          |
| `input.pipeline.trigger.parameters.<parameterName>`        | `string`  | The value specified for the parameter when triggering the pipeline.                      |
| `input.pipeline.trigger.preferred`                         | `boolean` |                                                                                          |
| `input.pipeline.trigger.rebake`                            | `boolean` |                                                                                          |
| `input.pipeline.trigger.resolvedExpectedArtifacts[]`       | `[array]` | See [artifacts]({{< ref "artifacts.md" >}}) for more information.                        |
| `input.pipeline.trigger.type`                              | `string`  | The type of trigger. See [Triggering Pipelines - Overview](https://spinnaker.io/guides/user/pipeline/triggers-with-artifactsrewrite/) for more information. |
| `input.pipeline.trigger.user`                              | `string`  | For triggers of type `git`, the user or organization associated with the git repository. |
| `input.pipeline.triggers[].branch`                         | `string`  | Which branch of the git repository triggers this pipeline.                               |
| `input.pipeline.triggers[].dryRun`                         | `boolean` |                                                                                          |
| `input.pipeline.triggers[].enabled`                        | `boolean` | True if the trigger is enabled.                                                          |
| `input.pipeline.triggers[].expectedArtifactIds[]`          | `string`  |                                                                                          |
| `input.pipeline.triggers[].id`                             | `string`  |                                                                                          |
| `input.pipeline.triggers[].preferred`                      | `boolean` |                                                                                          |
| `input.pipeline.triggers[].project`                        | `string`  | A change in what project triggers this pipeline.                                         |
| `input.pipeline.triggers[].rebake`                         | `boolean` | True if all baked artifacts should be rebaked, even if their inputs have not changed.    |
| `input.pipeline.triggers[].secret`                         | `string`  | The secret that the trigger uses to authenticate with Armory Enterprise.                         |
| `input.pipeline.triggers[].slug`                           | `string`  | The trigger's slug. For example, with a GitHub trigger this is the project name.         |
| `input.pipeline.triggers[].source`                         | `string`  | The type of the source for the trigger. For some trigger types this can be used to disambiguate amongst multiple trigger invokers. |
| `input.pipeline.triggers[].type`                           | `string`  | The configured type of the trigger.                                                      |
