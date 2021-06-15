---
title: "spinnaker.execution.stages.before.upsertProject"
linktitle: "upsertProject"
description: "A policy targeting this object runs before executing each task in a upsertProject stage."
weight: 10
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
          "email": "myUser@company.com",
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


## Keys

Parameters related to the stage against which the policy is executing can be found in the [input.stage.context](#inputstagecontext) object.

### input.pipeline

| Key                                               | Type      | Description                                                                                                                                       |
| ------------------------------------------------- | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| `input.pipeline.application`                      | `string`  | The name of the Spinnaker application to which this pipeline belongs.                                                                             |
| `input.pipeline.authentication.allowedAccounts[]` | `string`  | The list of accounts to which the user this stage runs as has access.                                                                       |
| `input.pipeline.authentication.user`              | `string`  | The Spinnaker user initiating the change.                                                                                                         |
| `input.pipeline.buildTime`                        | `number`  |                                                                                                                                                   |
| `input.pipeline.canceled`                         | `boolean` |                                                                                                                                                   |
| `input.pipeline.canceledBy`                       |           |                                                                                                                                                   |
| `input.pipeline.cancellationReason`               |           |                                                                                                                                                   |
| `input.pipeline.description`                      | `string`  | Description of the pipeline defined in the UI.                                                                                                    |
| `input.pipeline.endTime`                          |           |                                                                                                                                                   |
| `input.pipeline.id`                               | `string`  | The unique ID of the pipeline.                                                                                                                    |
| `input.pipeline.keepWaitingPipelines`             | `boolean` | If false and concurrent pipeline execution is disabled, then the pipelines in the waiting queue gets canceled when the next execution starts. |
| `input.pipeline.limitConcurrent`                  | `boolean` | True if only 1 concurrent execution of this pipeline is allowed.                                                                                  |
| `input.pipeline.name`                             | `string`  | The name of this pipeline.                                                                                                                        |
| `input.pipeline.origin`                           | `string`  |                                                                                                                                                   |
| `input.pipeline.partition`                        |           |                                                                                                                                                   |
| `input.pipeline.paused`                           |           |                                                                                                                                                   |
| `input.pipeline.pipelineConfigId`                 |           |                                                                                                                                                   |
| `input.pipeline.source`                           |           |                                                                                                                                                   |
| `input.pipeline.spelEvaluator`                    | `string`  | Which version of spring expression language is being used to evaluate SpEL.                                                                       |
| `input.pipeline.stages[]`                         | `[array]` | An array of the stages in the pipeline. Typically if you are writing a policy that examines multiple pipeline stages, it is better to write that policy against either the `opa.pipelines package`, or the `spinnaker.execution.pipelines.before` package. |
| `input.pipeline.startTime`                        | `number`  | Timestamp from when the pipeline was started.                                                                                                     |
| `input.pipeline.startTimeExpiry`                  | `date `   | Unix epoch date at which the pipeline expires.                                                                                                |
| `input.pipeline.status`                           | `string`  |                                                                                                                                                   |
| `input.pipeline.templateVariables`                |           |                                                                                                                                                   |
| `input.pipeline.type`                             | `string`  |                                                                                                                                                   |

### input.pipeline.trigger

See [input.pipeline.trigger]({{< ref "input.pipeline.trigger.md" >}}) for more information.

### input.stage.context

| Key                                                     | Type     | Description                                                   |
| ------------------------------------------------------- | -------- | ------------------------------------------------------------- |
| `input.stage.context.project.config.applications[]`     | `string` | The applications associated with the project.                 |
| `input.stage.context.project.config.clusters[].account` | `string` | The accounts associated with the project                      |
| `input.stage.context.project.config.clusters[].detail`  | `string` | The cluster details associated with the project.              |
| `input.stage.context.project.config.clusters[].stack`   | `string` | The stacks associated with the project's clusters.            |
| `input.stage.context.project.config.pipelineConfigs[]`  | `object` | The pipeline configurations associated with the project.      |
| `input.stage.context.project.createTs`                  | `number` | The time that the project was created.                        |
| `input.stage.context.project.email`                     | `string` | The email of the project's owner.                             |
| `input.stage.context.project.id`                        | `string` | The unique ID of the project.                                 |
| `input.stage.context.project.lastModifiedBy`            | `string` | The ID of the last user that modified the project definition. |
| `input.stage.context.project.name`                      | `string` | The name of the project.                                      |
| `input.stage.context.project.updateTs`                  | `number` | The timestamp of the last update to the project definition.   |
| `input.stage.context.user`                              | `string` |                                                               |

### input.stage

See [`input.stage`]({{< ref "input.stage.md" >}}) for more information.

### input.user

This object provides information about the user performing the action. This can be used to restrict actions by role. See [input.user]({{< ref "input.user.md" >}}) for more information.
