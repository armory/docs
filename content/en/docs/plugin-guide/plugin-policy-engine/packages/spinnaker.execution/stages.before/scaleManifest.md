---
title: "spinnaker.execution.stages.before.scaleManifest"
linktitle: "scaleManifest"
description: "A policy targeting this object runs before executing each task in a scaleManifest stage."
weight: 10
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
      "buildTime": 1620752545407,
      "canceled": false,
      "canceledBy": null,
      "cancellationReason": null,
      "description": "Scale manifest",
      "endTime": null,
      "id": "01F5E62DKZH06TP0V627RBP4M2",
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
        "01F5E62DKZ1YANDNTZ9ZJY0QGE"
      ],
      "startTime": 1620752545426,
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
        "kato.last.task.id": {
          "id": "552a47bb-59ea-4f5b-aa58-9f28851a6bc6"
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
                "status": "Processing op: KubernetesScaleManifestOperation"
              },
              {
                "phase": "SCALE_KUBERNETES_MANIFEST",
                "status": "Starting scale operation..."
              },
              {
                "phase": "SCALE_KUBERNETES_MANIFEST",
                "status": "Looking up resource properties..."
              },
              {
                "phase": "SCALE_KUBERNETES_MANIFEST",
                "status": "Calling scale operation..."
              },
              {
                "phase": "ORCHESTRATION",
                "status": "Orchestration completed."
              }
            ],
            "id": "552a47bb-59ea-4f5b-aa58-9f28851a6bc6",
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
        "outputs.manifestNamesByNamespace": {
          "staging": [
            "deployment hostname"
          ]
        },
        "replicas": "5",
        "user": "myUserName"
      },
      "endTime": null,
      "id": "01F5E62DKZ1YANDNTZ9ZJY0QGE",
      "lastModified": null,
      "name": "scaleManifest",
      "outputs": {},
      "parentStageId": null,
      "refId": "0",
      "requisiteStageRefIds": [],
      "scheduledTime": null,
      "startTime": 1620752545489,
      "startTimeExpiry": null,
      "status": "RUNNING",
      "syntheticStageOwner": null,
      "tasks": [
        {
          "endTime": 1620752545644,
          "id": "1",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.manifest.ResolveTargetManifestTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "resolveTargetManifest",
          "stageEnd": false,
          "stageStart": true,
          "startTime": 1620752545521,
          "status": "SUCCEEDED"
        },
        {
          "endTime": 1620752545916,
          "id": "2",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.manifest.ScaleManifestTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "scaleManifest",
          "stageEnd": false,
          "stageStart": false,
          "startTime": 1620752545659,
          "status": "SUCCEEDED"
        },
        {
          "endTime": 1620752551162,
          "id": "3",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.MonitorKatoTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "monitorScale",
          "stageEnd": false,
          "stageStart": false,
          "startTime": 1620752545933,
          "status": "SUCCEEDED"
        },
        {
          "endTime": null,
          "id": "4",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.manifest.WaitForManifestStableTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "waitForManifestToStabilize",
          "stageEnd": true,
          "stageStart": false,
          "startTime": 1620752551183,
          "status": "RUNNING"
        }
      ],
      "type": "scaleManifest"
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

This policy prevents scaleManifest stages from running in a pipeline unless it is triggered by a webhook with a source of 'prometheus'

{{< prism lang="rego" line-numbers="true" >}}
package spinnaker.execution.stages.before.scaleManifest

deny ["scaling can only be run in pipelines that are triggered by monitoring, not by manually triggered pipelines"]{
	input.pipeline.trigger.type!="webhook"
    }{
	object.get(input.pipeline.trigger,"source","")!="prometheus"
}
{{< /prism >}}

## Keys

### input.pipeline

| Key                                                | Type      | Description                                                                                                                                       |
| -------------------------------------------------- | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| `input.pipeline.application`                       | `string`  | The name of the Spinnaker application to which this pipeline belongs.                                                                             |
| `input.pipeline.authentication.allowedAccounts.[]` | `string`  | The list of accounts that this pipeline execution has permissions to execute against.                                                             |
| `input.pipeline.authentication.user`               | `string`  | The Spinnaker user initiating the change.                                                                                                         |
| `input.pipeline.buildTime`                         | `number`  |                                                                                                                                                   |
| `input.pipeline.description`                       | `string`  | Description of the pipeline defined in the UI.                                                                                                    |
| `input.pipeline.id`                                | `string`  | The unique ID of the pipeline.                                                                                                                    |
| `input.pipeline.keepWaitingPipelines`              | `boolean` | If false and concurrent pipeline execution is disabled, then the pipelines in the waiting queue gets canceled when the next execution starts. |
| `input.pipeline.limitConcurrent`                   | `boolean` | True if only 1 concurrent execution of this pipeline is allowed.                                                                                  |
| `input.pipeline.name`                              | `string`  | The name of this pipeline.                                                                                                                        |
| `input.pipeline.origin`                            | `string`  |                                                                                                                                                   |
| `input.pipeline.partition`                         |           |                                                                                                                                                   |
| `input.pipeline.paused`                            |           |                                                                                                                                                   |
| `input.pipeline.pipelineConfigId`                  |           |                                                                                                                                                   |
| `input.pipeline.source`                            |           |                                                                                                                                                   |
| `input.pipeline.spelEvaluator`                     |           | Which version of spring expression language is being used to evaluate SpEL.                                                                       |
| `input.pipeline.stages[]`                          | `[array]` | An array of the stages in the pipeline. Typically if you are writing a policy that examines multiple pipeline stages, it is better to write that policy against either the `opa.pipelines package`, or the `spinnaker.execution.pipelines.before` package. |
| `input.pipeline.startTime`                         | `number`  | Timestamp from when the pipeline was started.                                                                                                     |
| `input.pipeline.startTimeExpiry`                   |           |                                                                                                                                                   |
| `input.pipeline.templateVariables`                 |           |                                                                                                                                                   |

### input.pipeline.trigger

See [input.pipeline.trigger]({{< ref "input.pipeline.trigger.md" >}}) for more information.

### input.stage

See [`input.stage`]({{< ref "input.stage.md" >}}) for more information.

### input.stage.context

| Key                                                                   | Type      | Description                                                           |
| --------------------------------------------------------------------- | --------- | --------------------------------------------------------------------- |
| `input.stage.context.account`                                         | `string`  | The name of the account containing the manifest that's scaled.        |
| `input.stage.context.cloudProvider`                                   | `string`  | The cloud provider of the account.                                    |
| `input.stage.context.kato.last.task.id.id`                            | `string`  |                                                                       |
| `input.stage.context.kato.result.expected`                            | `boolean` |                                                                       |
| `input.stage.context.kato.task.firstNotFoundRetry`                    | `number`  |                                                                       |
| `input.stage.context.kato.task.lastStatus`                            | `string`  |                                                                       |
| `input.stage.context.kato.task.notFoundRetryCount`                    | `number`  |                                                                       |
| `input.stage.context.kato.task.terminalRetryCount`                    | `number`  |                                                                       |
| `input.stage.context.kato.tasks.[].history.[].phase`                  | `string`  |                                                                       |
| `input.stage.context.kato.tasks.[].history.[].status`                 | `string`  |                                                                       |
| `input.stage.context.kato.tasks.[].id`                                | `string`  |                                                                       |
| `input.stage.context.kato.tasks.[].status.completed`                  | `boolean` |                                                                       |
| `input.stage.context.kato.tasks.[].status.failed`                     | `boolean` |                                                                       |
| `input.stage.context.kato.tasks.[].status.retryable`                  | `boolean` |                                                                       |
| `input.stage.context.location`                                        | `string`  | The namespace in which to scale the manifest.                         |
| `input.stage.context.manifest.account.name`                           | `string`  | The name of the account containing the manifest that's scaled.        |
| `input.stage.context.manifest.location`                               | `string`  | The namespace in which to scale the manifest.                         |
| `input.stage.context.manifest.name`                                   | `string`  | The type and name of the manifest to be scaled. This is the best field from which to reference the manifest name and namespace. |
| `input.stage.context.manifestName`                                    | `string`  | The type and name of the manifest to be scaled.                       |
| `input.stage.context.outputs.manifestNamesByNamespace.<manespace>.[]` | `string`  | The name and type of the output manifest.                             |
| `input.stage.context.replicas`                                        | `string`  | The number of pods desired to be running following the scaling event. |
| `input.stage.context.user`                                            | `string`  | The ID of the user as whom the stage runs.                            |

### input.stage

See [`input.stage`]({{< ref "input.stage.md" >}}) for more information.

### input.user

This object provides information about the user performing the action. This can be used to restrict actions by role. See [input.user]({{< ref "input.user.md" >}}) for more information.
