---
title: "savePipeline"
linkTitle: "savePipeline"
weight: 10
description: "I'm hungry for knowledge!"
---

The full package name
 sent to OPA is `spinnaker/execution/stages/before/savePipeline`. The keys below are children of this path.

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

### `input.pipeline`

| Key                                                      | Type    | Description                                              |
|----------------------------------------------------------|---------|----------------------------------------------------------|
| `input.pipeline.application`                             | string  | The name of the Spinnaker application for this pipeline. |
| `input.pipeline.authentication.allowedAccounts`          | array   | Array of accounts Spinnaker is authorized to access.     |
| `input.pipeline.authentication.user`                     | string  | The Spinnaker user initiating the change.                |
| `input.pipeline.description`                             | string  | Description of the pipeline defined in the UI |
| `input.pipeline.initialConfig`                           | object  |    |
| `input.pipeline.keepWaitingPipelines`                    | boolean |    |
| `input.pipeline.limitConcurrent`                         | boolean |    |
| `input.pipeline.name`                                    | string  |    |
| `input.pipeline.notifications`                           | object  |    |
| `input.pipeline.origin`                                  | string  |    |
| `input.pipeline.partition`                               | ?       |    |
| `input.pipeline.paused`                                  | ?       |    |
| `input.pipeline.pipelineConfigId`                        | ?       |    |
| `input.pipeline.source`                                  | ?       |    |
| `input.pipeline.spelEvaluator`                           | ?       |    |
| `input.pipeline.stages`                                  | array   |    |
| `input.pipeline.startTime`                               | date    |    |
| `input.pipeline.startTimeExpiry`                         | date    |    |
| `input.pipeline.status`                                  | string  |    |
| `input.pipeline.systemNotifications`                     | array   |    |
| `input.pipeline.templateVariables`                       | ?       |    |
| `input.pipeline.trigger.artifacts`                       | array   |    |
| `input.pipeline.trigger.correlationId`                   | ?       |    |
| `input.pipeline.trigger.isDryRun`                        | boolean |    |
| `input.pipeline.trigger.isRebake`                        | boolean |    |
| `input.pipeline.trigger.isStrategy`                      | boolean |    |
| `input.pipeline.trigger.notifications`                   | array   |    |
| `input.pipeline.trigger.other.artifacts`                 | array   |    |
| `input.pipeline.trigger.other.dryRun`                    | boolean |    |
| `input.pipeline.trigger.other.expectedArtifacts`         | array   |    |
| `input.pipeline.trigger.other.notifications`             | array   |    |
| `input.pipeline.trigger.other.parameters`                | object  |    |
| `input.pipeline.trigger.other.rebake`                    | boolean |    |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts` | array   |    |
| `input.pipeline.trigger.other.strategy`                  | boolean |    |
| `input.pipeline.trigger.other.type`                      | string  |    |
| `input.pipeline.trigger.other.user`                      | string  | The Spinnaker user initiating the change. |
| `input.pipeline.trigger.parameters`                      | object  |    |
| `input.pipeline.trigger.resolvedExpectedArtifacts`       | array   |    |
| `input.pipeline.trigger.type`                            | string  |    |
| `input.pipeline.trigger.user`                            | string  | The Spinnaker user initiating the change. |
| `input.pipeline.type`                                    | string  |    |

### `input.stage`

| Key                                                      | Type    | Description                                              |
|----------------------------------------------------------|---------|----------------------------------------------------------|
| `input.stage.context.application`                        | string  | The name of the Spinnaker application for this pipeline. |
| `input.stage.context.notification.type`                  | string  |    |
| `input.stage.context.pipeline.name`                      | string  |    |
| `input.stage.context.staleCheck`                         | boolean |    |
| `input.stage.context.user`                               | string  | The Spinnaker user initiating the change. |
| `input.stage.lastModified`                               | date    |     |
| `input.stage.name`                                       | string  |     |
| `input.stage.outputs`                                    | object  |     |
| `input.stage.parentStageId`                              | ?       |     |
| `input.stage.refId`                                      | string  |     |
| `input.stage.requisiteStageRefIds`                       | array   |     |
| `input.stage.scheduledTime`                              | date    |     |
| `input.stage.startTimeExpiry`                            | date    |     |
| `input.stage.status`                                     | string  |     |
| `input.stage.syntheticStageOwner`                        | ?       |     |
| `input.stage.tasks.id`                                   | string  |     |
| `input.stage.tasks.implementingClass`                    | string  |     |
| `input.stage.tasks.loopEnd`                              | boolean |     |
| `input.stage.tasks.loopStart`                            | boolean |     |
| `input.stage.tasks.name`                                 | string  |     |
| `input.stage.tasks.stageEnd`                             | boolean |     |
| `input.stage.tasks.stageStart`                           | boolean |     |
| `input.stage.tasks.status`                               | string  |     |
| `input.stage.type`                                       | string  |     |

### `input.user`

| Key                                                      | Type    | Description                                              |
|----------------------------------------------------------|---------|----------------------------------------------------------|
| `input.user.isAdmin`                                     | boolean |  |
| `input.user.roles`                                       | array   |  |
| `input.user.username`                                    | string  | The Spinnaker user initiating the change. |
