---
title: "savePipeline"
linkTitle: "savePipeline"
weight: 10
description: "This package is checked before the execution of each task in a pipeline stage of type 'Save Pipeline'"
---

The full package name sent to OPA is `spinnaker.execution.stages.before.savePipeline`. The keys below are children of this path.

## Example Payload

```json
{
  key: "value",
}
```

## Example Policy

```rego

```

### Keys

> Note: All date values are in [Unix time](https://en.wikipedia.org/wiki/Unix_time).

### `input.pipeline`

| Key                                                        | Type       | Description                                              |
|------------------------------------------------------------|------------|----------------------------------------------------------|
| `input.pipeline.application`                               | `string`   | The name of the Spinnaker application for this pipeline. |
| `input.pipeline.authentication.allowedAccounts`            | `[array]`  | `[array]` of accounts Spinnaker is authorized to access. |
| `input.pipeline.authentication.user`                       | `string`   | The Spinnaker user initiating the change.                |
| `input.pipeline.description`                               | `string`   | Description of the pipeline defined in the UI |
| `input.pipeline.initialConfig`                             | `{object}` |    |
| `input.pipeline.keepWaitingPipelines`                      | `boolean`  |    |
| `input.pipeline.limitConcurrent`                           | `boolean`  | True if only 1 concurrent execution of this pipeline be allowed. |
| `input.pipeline.name`                                      | `string`   | The name of this pipeline. |
| `input.pipeline.notifications`                             | `{object}` |    |
| `input.pipeline.origin`                                    | `string`   |    |
| `input.pipeline.partition`                                 | ?          |    |
| `input.pipeline.paused`                                    | ?          |    |
| `input.pipeline.pipelineConfigId`                          | ?          |    |
| `input.pipeline.source`                                    | ?          |    |
| `input.pipeline.spelEvaluator`                             | `string`   | Which version of spring expression language is being used to evaluate SpEL. |
| `input.pipeline.startTime`                                 | `date`     | Timestamp from when the pipeline was started. |
| `input.pipeline.startTimeExpiry`                           | `date`     | Unix epoch date at which the pipeline will expire. |
| `input.pipeline.status`                                    | `string`   |    |
| `input.pipeline.systemNotifications[]`                     | `[array]`  |    |
| `input.pipeline.templateVariables`                         | ?          |    |
| `input.pipeline.trigger.artifacts[]`                       | `[array]`  |    |
| `input.pipeline.trigger.correlationId`                     | ?          |    |
| `input.pipeline.trigger.isDryRun`                          | `boolean`  |    |
| `input.pipeline.trigger.isRebake`                          | `boolean`  |    |
| `input.pipeline.trigger.isStrategy`                        | `boolean`  |    |
| `input.pipeline.trigger.notifications[]`                   | `[array]`  |    |
| `input.pipeline.trigger.other.artifacts[]`                 | `[array]`  |    |
| `input.pipeline.trigger.other.dryRun`                      | `boolean`  |    |
| `input.pipeline.trigger.other.expectedArtifacts[]`         | `[array]`  |    |
| `input.pipeline.trigger.other.notifications[]`             | `[array]`  |    |
| `input.pipeline.trigger.other.parameters`                  | `{object}` |    |
| `input.pipeline.trigger.other.rebake`                      | `boolean`  |    |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[]` | `[array]`  |    |
| `input.pipeline.trigger.other.strategy`                    | `boolean`  |    |
| `input.pipeline.trigger.other.type`                        | `string`   |    |
| `input.pipeline.trigger.other.user`                        | `string`   | The Spinnaker user initiating the change. |
| `input.pipeline.trigger.parameters`                        | `{object}` |    |
| `input.pipeline.trigger.resolvedExpectedArtifacts[]`       | `[array]`  |    |
| `input.pipeline.trigger.type`                              | `string`   |    |
| `input.pipeline.trigger.user`                              | `string`   | The Spinnaker user initiating the change. |
| `input.pipeline.type`                                      | `string`   |    |

### `input.stage`

| Key                                     | Type       | Description                                              |
|-----------------------------------------|------------|----------------------------------------------------------|
| `input.stage.context.application`       | `string`   | The name of the Spinnaker application for this pipeline. |
| `input.stage.context.notification.type` | `string`   | What type of spinnaker stage is this. |
| `input.stage.context.pipeline.name`     | `string`   | The name of this pipeline. |
| `input.stage.context.staleCheck`        | `boolean`  |    |
| `input.stage.context.user`              | `string`   | The Spinnaker user initiating the change. |
| `input.stage.lastModified`              | `date`     | |
| `input.stage.name`                      | `string`   | The name of a prticular stage.  |
| `input.stage.outputs`                   | `{object}` |     |
| `input.stage.parentStageId`             | ?          |     |
| `input.stage.refId`                     | `string`   |     |
| `input.stage.requisiteStageRefIds`      | `[array]`  |     |
| `input.stage.scheduledTime`             | `date`     |     |
| `input.stage.startTimeExpiry`           | `date`     | The current state of activity of the stage. |
| `input.stage.status`                    | `string`   |     |
| `input.stage.syntheticStageOwner`       | ?          |     |
| `input.stage.tasks.id`                  | `string`   |     |
| `input.stage.tasks.implementingClass`   | `string`   |     |
| `input.stage.tasks.loopEnd`             | `boolean`  |     |
| `input.stage.tasks.loopStart`           | `boolean`  |     |
| `input.stage.tasks.name`                | `string`   |     |
| `input.stage.tasks.stageEnd`            | `boolean`  |     |
| `input.stage.tasks.stageStart`          | `boolean`  |     |
| `input.stage.tasks.status`              | `string`   |     |
| `input.stage.type`                      | `string`   | The current state of activity of the stage. |

### `input.user`

| Key                   | Type      | Description                                      |
|-----------------------|-----------|--------------------------------------------------|
| `input.user.isAdmin`  | `boolean` | True if the Spinnaker user has admin privlidges. |
| `input.user.roles[]`  | `[array]` |  |
| `input.user.username` | `string`  | The Spinnaker user initiating the change. |
