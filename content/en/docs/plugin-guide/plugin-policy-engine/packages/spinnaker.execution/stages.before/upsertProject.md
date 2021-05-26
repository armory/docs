---
title: "spinnaker.execution.stages.before.upsertProject"
linktitle: "upsertProject"
description: "fill me with delicious data, Stephen!"
---

## Example Payload

<details><summary>Click to expand</summary>

```json
{
  "input": {
    "pipeline": {
      "application": "spinnaker",
      "authentication": {
        "allowedAccounts": [
          "spinnaker",
          "staging",
          "staging-ecs"
        ],
        "user": "myUserName"
      },
      "buildTime": 1620752714800,
      "canceled": false,
      "canceledBy": null,
      "cancellationReason": null,
      "description": "Create project: testProjectName",
      "endTime": null,
      "id": "01F5E67K1GKAES5N7GAB34DG7D",
      "initialConfig": {},
      "keepWaitingPipelines": false,
      "limitConcurrent": false,
      "name": null,
      "notifications": [],
      "origin": "unknown",
      "partition": null,
      "paused": null,
      "pipelineConfigId": null,
      "source": null,
      "spelEvaluator": null,
      "stages": [
        "01F5E67K1GJEE109QR9X25M41V"
      ],
      "startTime": 1620752714851,
      "startTimeExpiry": null,
      "status": "RUNNING",
      "systemNotifications": [],
      "templateVariables": null,
      "trigger": {
        "artifacts": [],
        "correlationId": null,
        "isDryRun": false,
        "isRebake": false,
        "isStrategy": false,
        "notifications": [],
        "other": {
          "artifacts": [],
          "dryRun": false,
          "expectedArtifacts": [],
          "notifications": [],
          "parameters": {},
          "rebake": false,
          "resolvedExpectedArtifacts": [],
          "strategy": false,
          "type": "manual",
          "user": "myUserName"
        },
        "parameters": {},
        "resolvedExpectedArtifacts": [],
        "type": "manual",
        "user": "myUserName"
      },
      "type": "ORCHESTRATION"
    },
    "stage": {
      "context": {
        "project": {
          "config": {
            "applications": [
              "hostname"
            ],
            "clusters": [
              {
                "account": "spinnaker",
                "detail": "*",
                "stack": "*"
              }
            ],
            "pipelineConfigs": [
              {
                "application": "hostname",
                "pipelineConfigId": "7db1e350-dedb-4dc1-9976-e71f97b5f132"
              }
            ]
          },
          "email": "stephen.atwell@armory.io",
          "name": "testProjectName"
        },
        "user": "myUserName"
      },
      "endTime": null,
      "id": "01F5E67K1GJEE109QR9X25M41V",
      "lastModified": null,
      "name": "upsertProject",
      "outputs": {},
      "parentStageId": null,
      "refId": "0",
      "requisiteStageRefIds": [],
      "scheduledTime": null,
      "startTime": 1620752714863,
      "startTimeExpiry": null,
      "status": "RUNNING",
      "syntheticStageOwner": null,
      "tasks": [
        {
          "endTime": null,
          "id": "1",
          "implementingClass": "com.netflix.spinnaker.orca.applications.pipelines.UpsertProjectStage.UpsertProjectTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "upsertProject",
          "stageEnd": true,
          "stageStart": true,
          "startTime": 1620752714920,
          "status": "RUNNING"
        }
      ],
      "type": "upsertProject"
    },
    "user": {
      "isAdmin": false,
      "roles": [],
      "username": "myUserName"
    }
  }
}
```
</details>

## Example Policy

```rego

```

## Keys

Parameters related to the stage against which the policy is executing can be found in the [input.stage.context](#inputstagecontext) object.

### input.pipeline

| Key                                               | Type      | Description                                                           |
| ------------------------------------------------- | --------- | --------------------------------------------------------------------- |
| `input.pipeline.application`                      | `string`  | The name of the Spinnaker application to which this pipeline belongs. |
| `input.pipeline.authentication.allowedAccounts[]` | `string`  |                                                                       |
| `input.pipeline.authentication.user`              | `string`  |                                                                       |
| `input.pipeline.buildTime`                        | `number`  |                                                                       |
| `input.pipeline.canceled`                         | `boolean` |                                                                       |
| `input.pipeline.canceledBy`                       | ` `       |                                                                       |
| `input.pipeline.cancellationReason`               | ` `       |                                                                       |
| `input.pipeline.description`                      | `string`  |                                                                       |
| `input.pipeline.endTime`                          | ` `       |                                                                       |
| `input.pipeline.id`                               | `string`  |                                                                       |
| `input.pipeline.keepWaitingPipelines`             | `boolean` |                                                                       |
| `input.pipeline.limitConcurrent`                  | `boolean` |                                                                       |
| `input.pipeline.name`                             | ` `       |                                                                       |
| `input.pipeline.origin`                           | `string`  |                                                                       |
| `input.pipeline.partition`                        | ` `       |                                                                       |
| `input.pipeline.paused`                           | ` `       |                                                                       |
| `input.pipeline.pipelineConfigId`                 | ` `       |                                                                       |
| `input.pipeline.source`                           | ` `       |                                                                       |
| `input.pipeline.spelEvaluator`                    | ` `       |                                                                       |
| `input.pipeline.stages[]`                         | `[array]` | An array of the stages in the pipeline. Typically if you are writing a policy that examines multiple pipeline stages, it is better to write that policy against either the `opa.pipelines package`, or the `spinnaker.execution.pipelines.before` package. |
| `input.pipeline.startTime`                        | `number`  |                                                                       |
| `input.pipeline.startTimeExpiry`                  | ` `       |                                                                       |
| `input.pipeline.status`                           | `string`  |                                                                       |
| `input.pipeline.templateVariables`                | ` `       |                                                                       |
| `input.pipeline.type`                             | `string`  |                                                                       |

### input.pipeline.trigger

See [input.pipeline.trigger]({{< ref "input.pipeline.trigger.md" >}}) for more information.

### input.stage.context

| Key                                                                     | Type      | Description |
| ----------------------------------------------------------------------- | --------- | ----------- |
| `input.stage.context.project.config.applications[]`                     | `string`  |             |
| `input.stage.context.project.config.clusters[].account`                 | `string`  |             |
| `input.stage.context.project.config.clusters[].detail`                  | `string`  |             |
| `input.stage.context.project.config.clusters[].stack`                   | `string`  |             |
| `input.stage.context.project.config.pipelineConfigs[].application`      | `string`  |             |
| `input.stage.context.project.config.pipelineConfigs[].pipelineConfigId` | `string`  |             |
| `input.stage.context.project.createTs`                                  | `number`  |             |
| `input.stage.context.project.email`                                     | `string`  |             |
| `input.stage.context.project.id`                                        | `string`  |             |
| `input.stage.context.project.lastModifiedBy`                            | `string`  |             |
| `input.stage.context.project.name`                                      | `string`  |             |
| `input.stage.context.project.updateTs`                                  | `number`  |             |
| `input.stage.context.user`                                              | `string`  |             |

### input.stage
| Key                                     | Type      | Description |
| --------------------------------------- | --------- | ----------- |
| `input.stage.endTime`                   | ` `       |             |
| `input.stage.id`                        | `string`  |             |
| `input.stage.lastModified`              | ` `       |             |
| `input.stage.name`                      | `string`  |             |
| `input.stage.parentStageId`             | ` `       |             |
| `input.stage.refId`                     | `string`  |             |
| `input.stage.scheduledTime`             | ` `       |             |
| `input.stage.startTimeExpiry`           | ` `       |             |
| `input.stage.startTime`                 | `number`  |             |
| `input.stage.status`                    | `string`  |             |
| `input.stage.syntheticStageOwner`       | ` `       |             |
| `input.stage.tasks[].endTime`           | ` `       |             |
| `input.stage.tasks[].id`                | `string`  |             |
| `input.stage.tasks[].implementingClass` | `string`  |             |
| `input.stage.tasks[].loopEnd`           | `boolean` |             |
| `input.stage.tasks[].loopStart`         | `boolean` |             |
| `input.stage.tasks[].name`              | `string`  |             |
| `input.stage.tasks[].stageEnd`          | `boolean` |             |
| `input.stage.tasks[].stageStart`        | `boolean` |             |
| `input.stage.tasks[].startTime`         | `number`  |             |
| `input.stage.tasks[].status`            | `string`  |             |
| `input.stage.type`                      | `string`  |             |

### input.user

This object provides information about the user performing the action. This can be used to restrict actions by role. See [input.user]({{< ref "input.user.md" >}}) for more information.
