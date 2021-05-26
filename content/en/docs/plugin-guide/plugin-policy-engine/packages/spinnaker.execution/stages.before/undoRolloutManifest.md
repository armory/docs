---
title: "spinnaker.execution.stages.before.undoRolloutManifest"
linktitle: "undoRolloutManifest"
description: "A policy that is run before executing each task in an Undo Rollout (manifest) stage."
---

 See [Deploy Applications to Kubernetes]({{< ref "kubernetes-v2#available-manifest-based-stages" >}}) for more information on this stage.
## Example Payload

<details><summary>Click to expand</summary>

```json
{
  "input": {
    "pipeline": {
      "application": "hostname",
      "authentication": {
        "allowedAccounts": [
          "spinnaker",
          "staging",
          "staging-ecs"
        ],
        "user": "myUserName"
      },
      "buildTime": 1620752523096,
      "canceled": false,
      "canceledBy": null,
      "cancellationReason": null,
      "description": "Undo rollout of manifest",
      "endTime": null,
      "id": "01F5E61QTRW9H5TPZSAK4D2WCV",
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
        "01F5E61QTRMYD2PV6Z5YHXXE4D"
      ],
      "startTime": 1620752523145,
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
        "account": "spinnaker",
        "cloudProvider": "kubernetes",
        "deploy.server.groups": {},
        "failedManifests": [],
        "kato.last.task.id": {
          "id": "7891099a-c0da-4e1b-b14a-89592343293b"
        },
        "kato.result.expected": false,
        "kato.task.firstNotFoundRetry": -1,
        "kato.task.lastStatus": "SUCCEEDED",
        "kato.task.notFoundRetryCount": 0,
        "kato.task.terminalRetryCount": 0,
        "kato.tasks": [
          {
            "history": [
              {
                "phase": "ORCHESTRATION",
                "status": "Initializing Orchestration Task"
              },
              {
                "phase": "ORCHESTRATION",
                "status": "Processing op: KubernetesUndoRolloutManifestOperation"
              },
              {
                "phase": "UNDO_ROLLOUT_KUBERNETES_MANIFEST",
                "status": "Starting undo rollout operation..."
              },
              {
                "phase": "UNDO_ROLLOUT_KUBERNETES_MANIFEST",
                "status": "Looking up resource properties..."
              },
              {
                "phase": "UNDO_ROLLOUT_KUBERNETES_MANIFEST",
                "status": "Calling undo rollout operation..."
              },
              {
                "phase": "ORCHESTRATION",
                "status": "Orchestration completed."
              }
            ],
            "id": "7891099a-c0da-4e1b-b14a-89592343293b",
            "resultObjects": [],
            "status": {
              "completed": true,
              "failed": false,
              "retryable": false
            }
          }
        ],
        "location": "staging",
        "manifest.account.name": "spinnaker",
        "manifest.location": "staging",
        "manifest.name": "deployment hostname",
        "manifestName": "deployment hostname",
        "messages": [
          "'deployment hostname' in 'staging' for account spinnaker: waiting for manifest to stabilize"
        ],
        "outputs.manifestNamesByNamespace": {
          "staging": [
            "deployment hostname"
          ]
        },
        "reason": "someReason",
        "revision": "3",
        "stableManifests": [],
        "user": "myUserName"
      },
      "endTime": null,
      "id": "01F5E61QTRMYD2PV6Z5YHXXE4D",
      "lastModified": null,
      "name": "undoRolloutManifest",
      "outputs": {},
      "parentStageId": null,
      "refId": "0",
      "requisiteStageRefIds": [],
      "scheduledTime": null,
      "startTime": 1620752523160,
      "startTimeExpiry": null,
      "status": "RUNNING",
      "syntheticStageOwner": null,
      "tasks": [
        {
          "endTime": 1620752523449,
          "id": "1",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.manifest.UndoRolloutManifestTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "undoRolloutManifest",
          "stageEnd": false,
          "stageStart": true,
          "startTime": 1620752523216,
          "status": "SUCCEEDED"
        },
        {
          "endTime": 1620752528687,
          "id": "2",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.MonitorKatoTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "monitorUndoRollout",
          "stageEnd": false,
          "stageStart": false,
          "startTime": 1620752523464,
          "status": "SUCCEEDED"
        },
        {
          "endTime": null,
          "id": "3",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.manifest.WaitForManifestStableTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "waitForManifestToStabilize",
          "stageEnd": true,
          "stageStart": false,
          "startTime": 1620752528755,
          "status": "RUNNING"
        }
      ],
      "type": "undoRolloutManifest"
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

| Key                                               | Type      | Description |
| ------------------------------------------------- | --------- | ----------- |
| `input.pipeline.application`                      | `string`  | The name of the Spinnaker application to which this pipeline belongs. |
| `input.pipeline.authentication.allowedAccounts[]` | `string`  |             |
| `input.pipeline.authentication.user`              | `string`  |             |
| `input.pipeline.buildTime`                        | `number`  |             |
| `input.pipeline.canceledBy`                       | ` `       |             |
| `input.pipeline.canceled`                         | `boolean` |             |
| `input.pipeline.cancellationReason`               | ` `       |             |
| `input.pipeline.description`                      | ` `       |             |
| `input.pipeline.description`                      | `string`  |             |
| `input.pipeline.endTime`                          | ` `       |             |
| `input.pipeline.endTime`                          | `number`  |             |
| `input.pipeline.id`                               | `string`  |             |
| `input.pipeline.keepWaitingPipelines`             | `boolean` |             |
| `input.pipeline.limitConcurrent`                  | `boolean` |             |
| `input.pipeline.name`                             | ` `       |             |
| `input.pipeline.name`                             | `string`  |             |
| `input.pipeline.origin`                           | `string`  |             |
| `input.pipeline.partition`                        | ` `       |             |
| `input.pipeline.paused`                           | ` `       |             |
| `input.pipeline.pipelineConfigId`                 | ` `       |             |
| `input.pipeline.pipelineConfigId`                 | `string`  |             |
| `input.pipeline.source`                           | ` `       |             |
| `input.pipeline.spelEvaluator`                    | ` `       |             |
| `input.pipeline.spelEvaluator`                    | `string`  |             |
| `input.pipeline.stages[]`                         | `[array]` | An array of the stages in the pipeline. Typically if you are writing a policy that examines multiple pipeline stages, it is better to write that policy against either the `opa.pipelines package`, or the `spinnaker.execution.pipelines.before` package. |
| `input.pipeline.startTimeExpiry`                  | ` `       |             |
| `input.pipeline.startTime`                        | `number`  |             |
| `input.pipeline.status`                           | `string`  |             |
| `input.pipeline.templateVariables`                | ` `       |             |
| `input.pipeline.type`                             | `string`  |             |

### input.pipeline.trigger

See [input.pipeline.trigger]({{< ref "input.pipeline.trigger.md" >}}) for more information.

### input.stage.context

| Key                                                              | Type      | Description |
| ---------------------------------------------------------------- | --------- | ----------- |
| `input.stage.context.account`                                    | `string`  |             |
| `input.stage.context.cloudProvider`                              | `string`  |             |
| `input.stage.context.kato.last.task.id.id`                       | `string`  |             |
| `input.stage.context.kato.result.expected`                       | `boolean` |             |
| `input.stage.context.kato.task.firstNotFoundRetry`               | `number`  |             |
| `input.stage.context.kato.task.lastStatus`                       | `string`  |             |
| `input.stage.context.kato.task.notFoundRetryCount`               | `number`  |             |
| `input.stage.context.kato.task.terminalRetryCount`               | `number`  |             |
| `input.stage.context.kato.tasks[].history[].phase`               | `string`  |             |
| `input.stage.context.kato.tasks[].history[].status`              | `string`  |             |
| `input.stage.context.kato.tasks[].id`                            | `string`  |             |
| `input.stage.context.kato.tasks[].status.completed`              | `boolean` |             |
| `input.stage.context.kato.tasks[].status.failed`                 | `boolean` |             |
| `input.stage.context.kato.tasks[].status.retryable`              | `boolean` |             |
| `input.stage.context.location`                                   | `string`  |             |
| `input.stage.context.manifest.account.name`                      | `string`  |             |
| `input.stage.context.manifest.location`                          | `string`  |             |
| `input.stage.context.manifest.name`                              | `string`  |             |
| `input.stage.context.manifestName`                               | `string`  |             |
| `input.stage.context.messages[]`                                 | `string`  |             |
| `input.stage.context.mode`                                       | `string`  |             |
| `input.stage.context.numRevisionsBack`                           | `number`  |             |
| `input.stage.context.outputs.manifestNamesByNamespace.staging[]` | `string`  |             |
| `input.stage.context.reason`                                     | `string`  |             |
| `input.stage.context.revision`                                   | `string`  |             |
| `input.stage.context.user`                                       | `string`  |             |

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
| `input.stage.tasks[].endTime`           | `number`  |             |
| `input.stage.tasks[].id`                | `string`  |             |
| `input.stage.tasks[].implementingClass` | `string`  |             |
| `input.stage.tasks[].loopEnd`           | `boolean` |             |
| `input.stage.tasks[].loopStart`         | `boolean` |             |
| `input.stage.tasks[].name`              | `string`  |             |
| `input.stage.tasks[].stageEnd`          | `boolean` |             |
| `input.stage.tasks[].stageStart`        | `boolean` |             |
| `input.stage.tasks[].startTime`         | ` `       |             |
| `input.stage.tasks[].startTime`         | `number`  |             |
| `input.stage.tasks[].status`            | `string`  |             |
| `input.stage.type`                      | `string`  |             |

### input.user

This object provides information about the user performing the action. This can be used to restrict actions by role. See [input.user]({{< ref "input.user.md" >}}) for more information.
