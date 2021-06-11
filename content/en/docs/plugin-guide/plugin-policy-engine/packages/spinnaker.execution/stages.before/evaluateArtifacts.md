---
title: "spinnaker.execution.stages.before.evaluateArtifacts"
linktitle: "evaluateArtifacts"
description: "A policy targeting this object runs before executing each task in a evaluateArtifacts stage."
weight: 10
---

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
      "buildTime": 1620762184206,
      "canceled": false,
      "canceledBy": null,
      "cancellationReason": null,
      "description": null,
      "endTime": null,
      "id": "01F5EF8JCVYM85FACGYSTF6S5G",
      "initialConfig": {},
      "keepWaitingPipelines": false,
      "limitConcurrent": true,
      "name": "hostname w evaluate artifacts",
      "notifications": [],
      "origin": "api",
      "partition": null,
      "paused": null,
      "pipelineConfigId": "0cdf6df8-ceb1-490e-a7c9-de80e49b0866",
      "source": null,
      "spelEvaluator": "v4",
      "stages": [
        {
          "context": {
            "account": "spinnaker",
            "cloudProvider": "kubernetes",
            "manifestArtifactId": "65d24828-f858-4e6f-a2c8-82c2cdd79251",
            "moniker": {
              "app": "hostname"
            },
            "skipExpressionEvaluation": false,
            "source": "artifact",
            "trafficManagement": {
              "enabled": false,
              "options": {
                "enableTraffic": false,
                "services": []
              }
            }
          },
          "endTime": null,
          "id": "01F5EF8JGER6TTNSNWAF184KKH",
          "lastModified": null,
          "name": "Deploy (Manifest)",
          "outputs": {},
          "parentStageId": null,
          "refId": "2",
          "requisiteStageRefIds": [
            "7"
          ],
          "scheduledTime": null,
          "startTime": null,
          "startTimeExpiry": null,
          "status": "NOT_STARTED",
          "syntheticStageOwner": null,
          "tasks": [],
          "type": "deployManifest"
        },
        "01F5EF8JGEQ3X1FGVCC78SFNFS"
      ],
      "startTime": 1620762184271,
      "startTimeExpiry": null,
      "status": "RUNNING",
      "systemNotifications": [],
      "templateVariables": null,
      "trigger": {
        "artifacts": [
          {
            "artifactAccount": "myUserName",
            "customKind": false,
            "location": null,
            "metadata": {
              "id": "4aa85178-0618-46c4-b530-6883d393656d"
            },
            "name": "manifests/deploy-spinnaker.yaml",
            "provenance": null,
            "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
            "type": "github/file",
            "uuid": null,
            "version": "master"
          },
          {
            "artifactAccount": "myUserName",
            "customKind": false,
            "location": null,
            "metadata": {
              "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
            },
            "name": "manifests/service-spinnaker.yaml",
            "provenance": null,
            "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/service-spinnaker.yaml",
            "type": "github/file",
            "uuid": null,
            "version": null
          }
        ],
        "correlationId": null,
        "isDryRun": false,
        "isRebake": false,
        "isStrategy": false,
        "notifications": [],
        "other": {
          "artifacts": [
            {
              "artifactAccount": "myUserName",
              "customKind": false,
              "metadata": {
                "id": "4aa85178-0618-46c4-b530-6883d393656d"
              },
              "name": "manifests/deploy-spinnaker.yaml",
              "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
              "type": "github/file",
              "version": "master"
            },
            {
              "artifactAccount": "myUserName",
              "customKind": false,
              "metadata": {
                "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
              },
              "name": "manifests/service-spinnaker.yaml",
              "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/service-spinnaker.yaml",
              "type": "github/file"
            }
          ],
          "dryRun": false,
          "enabled": false,
          "eventId": "0442458c-eeed-41a6-83f4-dbf0110076e1",
          "executionId": "01F5EF8JCVYM85FACGYSTF6S5G",
          "expectedArtifacts": [
            {
              "boundArtifact": {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "4aa85178-0618-46c4-b530-6883d393656d"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
                "type": "github/file",
                "version": "master"
              },
              "defaultArtifact": {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "4aa85178-0618-46c4-b530-6883d393656d"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
                "type": "github/file",
                "version": "master"
              },
              "id": "0cf98032-1b0f-48db-9314-09c69293b3a6",
              "matchArtifact": {
                "artifactAccount": "myUserName",
                "customKind": true,
                "metadata": {
                  "id": "3f72ed8e-cb95-454f-9119-2323682121ff"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "type": "github/file"
              },
              "useDefaultArtifact": true,
              "usePriorArtifact": false
            },
            {
              "boundArtifact": {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
                },
                "name": "manifests/service-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/service-spinnaker.yaml",
                "type": "github/file"
              },
              "defaultArtifact": {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
                },
                "name": "manifests/service-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/service-spinnaker.yaml",
                "type": "github/file"
              },
              "id": "425d20a8-2942-4902-8d2b-277769a1492c",
              "matchArtifact": {
                "artifactAccount": "myUserName",
                "customKind": true,
                "metadata": {
                  "id": "d7ac7eca-0131-4d54-ab8f-880ff0041e4f"
                },
                "name": "manifests/service-spinnaker",
                "type": "github/file"
              },
              "useDefaultArtifact": true,
              "usePriorArtifact": true
            }
          ],
          "notifications": [],
          "parameters": {
            "moduleConfig": "{\"name\":\"test-deployment\",\"space\":\"test-space-param\"}"
          },
          "preferred": false,
          "rebake": false,
          "resolvedExpectedArtifacts": [
            {
              "boundArtifact": {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "4aa85178-0618-46c4-b530-6883d393656d"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
                "type": "github/file",
                "version": "master"
              },
              "defaultArtifact": {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "4aa85178-0618-46c4-b530-6883d393656d"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
                "type": "github/file",
                "version": "master"
              },
              "id": "0cf98032-1b0f-48db-9314-09c69293b3a6",
              "matchArtifact": {
                "artifactAccount": "myUserName",
                "customKind": true,
                "metadata": {
                  "id": "3f72ed8e-cb95-454f-9119-2323682121ff"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "type": "github/file"
              },
              "useDefaultArtifact": true,
              "usePriorArtifact": false
            },
            {
              "boundArtifact": {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
                },
                "name": "manifests/service-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/service-spinnaker.yaml",
                "type": "github/file"
              },
              "defaultArtifact": {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
                },
                "name": "manifests/service-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/service-spinnaker.yaml",
                "type": "github/file"
              },
              "id": "425d20a8-2942-4902-8d2b-277769a1492c",
              "matchArtifact": {
                "artifactAccount": "myUserName",
                "customKind": true,
                "metadata": {
                  "id": "d7ac7eca-0131-4d54-ab8f-880ff0041e4f"
                },
                "name": "manifests/service-spinnaker",
                "type": "github/file"
              },
              "useDefaultArtifact": true,
              "usePriorArtifact": true
            }
          ],
          "strategy": false,
          "type": "manual",
          "user": "myUserName"
        },
        "parameters": {
          "moduleConfig": "{\"name\":\"test-deployment\",\"space\":\"test-space-param\"}"
        },
        "resolvedExpectedArtifacts": [
          {
            "boundArtifact": {
              "artifactAccount": "myUserName",
              "customKind": false,
              "location": null,
              "metadata": {
                "id": "4aa85178-0618-46c4-b530-6883d393656d"
              },
              "name": "manifests/deploy-spinnaker.yaml",
              "provenance": null,
              "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
              "type": "github/file",
              "uuid": null,
              "version": "master"
            },
            "defaultArtifact": {
              "artifactAccount": "myUserName",
              "customKind": false,
              "location": null,
              "metadata": {
                "id": "4aa85178-0618-46c4-b530-6883d393656d"
              },
              "name": "manifests/deploy-spinnaker.yaml",
              "provenance": null,
              "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
              "type": "github/file",
              "uuid": null,
              "version": "master"
            },
            "id": "0cf98032-1b0f-48db-9314-09c69293b3a6",
            "matchArtifact": {
              "artifactAccount": "myUserName",
              "customKind": true,
              "location": null,
              "metadata": {
                "id": "3f72ed8e-cb95-454f-9119-2323682121ff"
              },
              "name": "manifests/deploy-spinnaker.yaml",
              "provenance": null,
              "reference": null,
              "type": "github/file",
              "uuid": null,
              "version": null
            },
            "useDefaultArtifact": true,
            "usePriorArtifact": false
          },
          {
            "boundArtifact": {
              "artifactAccount": "myUserName",
              "customKind": false,
              "location": null,
              "metadata": {
                "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
              },
              "name": "manifests/service-spinnaker.yaml",
              "provenance": null,
              "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/service-spinnaker.yaml",
              "type": "github/file",
              "uuid": null,
              "version": null
            },
            "defaultArtifact": {
              "artifactAccount": "myUserName",
              "customKind": false,
              "location": null,
              "metadata": {
                "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
              },
              "name": "manifests/service-spinnaker.yaml",
              "provenance": null,
              "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/service-spinnaker.yaml",
              "type": "github/file",
              "uuid": null,
              "version": null
            },
            "id": "425d20a8-2942-4902-8d2b-277769a1492c",
            "matchArtifact": {
              "artifactAccount": "myUserName",
              "customKind": true,
              "location": null,
              "metadata": {
                "id": "d7ac7eca-0131-4d54-ab8f-880ff0041e4f"
              },
              "name": "manifests/service-spinnaker",
              "provenance": null,
              "reference": null,
              "type": "github/file",
              "uuid": null,
              "version": null
            },
            "useDefaultArtifact": true,
            "usePriorArtifact": true
          }
        ],
        "type": "manual",
        "user": "myUserName"
      },
      "type": "PIPELINE"
    },
    "stage": {
      "context": {
        "artifactContents": [],
        "expectedArtifacts": [
          {
            "defaultArtifact": {
              "customKind": true,
              "metadata": {
                "id": "b9076063-d4ff-4ec5-81f6-599a1bb78bf3"
              }
            },
            "id": "65d24828-f858-4e6f-a2c8-82c2cdd79251",
            "matchArtifact": {
              "artifactAccount": "embedded-artifact",
              "customKind": true,
              "metadata": {
                "id": "06e6f217-900e-4546-8370-8404255715c9"
              },
              "name": "test",
              "type": "embedded/base64"
            },
            "useDefaultArtifact": false,
            "usePriorArtifact": false
          }
        ],
        "expressionEvaluationSummary": {
          "---\napiVersion: v1\nkind: Namespace\nmetadata:\n  name: '#readJson(parameters['moduleConfig'])['ns']'\nspec:\n  finalizers:\n  - kubernetes\n---\napiVersion: apps/v1\nkind: Deployment\nmetadata:\n  name: hostname\n  namespace: '#readJson(parameters['moduleConfig'])['ns']'\nspec:\n  replicas: '#readJson(parameters['moduleConfig'])['replicas']'\n  selector:\n    matchLabels:\n      app: hostname\n      version: v1\n  strategy:\n    rollingUpdate:\n      maxSurge: 1\n      maxUnavailable: 1\n    type: RollingUpdate\n  template:\n    metadata:\n      labels:\n        app: hostname\n        version: v1\n    spec:\n      containers:\n      - image: rstarmer/hostname:v1\n        imagePullPolicy: Always\n        name: hostname\n        resources: {}\n      restartPolicy: Always": [
            {
              "description": "Failed to evaluate [content] : ---\napiVersion: v1\nkind: Namespace\nmetadata:\n  name: '#readJson(parameters['moduleConfig'])['ns']'\nspec:\n  finalizers:\n  - kubernetes\n---\napiVersion: apps/v1\nkind: Deployment\nmetadata:\n  name: hostname\n  namespace: '#readJson(parameters['moduleConfig'])['ns']'\nspec:\n  replicas: '#readJson(parameters['moduleConfig'])['replicas']'\n  selector:\n    matchLabels:\n      app: hostname\n      version: v1\n  strategy:\n    rollingUpdate:\n      maxSurge: 1\n      maxUnavailable: 1\n    type: RollingUpdate\n  template:\n    metadata:\n      labels:\n        app: hostname\n        version: v1\n    spec:\n      containers:\n      - image: rstarmer/hostname:v1\n        imagePullPolicy: Always\n        name: hostname\n        resources: {}\n      restartPolicy: Always not found",
              "level": "INFO",
              "timestamp": 1620762184544
            }
          ]
        }
      },
      "endTime": null,
      "id": "01F5EF8JGEQ3X1FGVCC78SFNFS",
      "lastModified": null,
      "name": "Evaluate Artifacts5",
      "outputs": {
        "artifacts": []
      },
      "parentStageId": null,
      "refId": "7",
      "requisiteStageRefIds": [],
      "scheduledTime": null,
      "startTime": 1620762184539,
      "startTimeExpiry": null,
      "status": "RUNNING",
      "syntheticStageOwner": null,
      "tasks": [
        {
          "endTime": 1620762184698,
          "id": "1",
          "implementingClass": "io.armory.plugin.stage.artifacts.pipeline.task.EvaluateArtifactsTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "evaluateArtifacts",
          "stageEnd": false,
          "stageStart": true,
          "startTime": 1620762184564,
          "status": "SUCCEEDED"
        },
        {
          "endTime": null,
          "id": "2",
          "implementingClass": "com.netflix.spinnaker.orca.pipeline.tasks.artifacts.BindProducedArtifactsTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "bindArtifacts",
          "stageEnd": true,
          "stageStart": false,
          "startTime": 1620762184714,
          "status": "RUNNING"
        }
      ],
      "type": "evaluateArtifacts"
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
| `input.pipeline.pipelineConfigId`                 | `string`  |                                                                                                                                                   |
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

### input.stage

See [`input.stage`]({{< ref "input.stage.md" >}}) for more information.

### input.stage.context

| Key                                               | Type      | Description                                                       |
| ------------------------------------------------- | --------- | ----------------------------------------------------------------- |
| `input.stage.context.artifactContents[].contents` | `string`  | The contents of the artifact that is evaluated.                   |
| `input.stage.context.artifactContents[].name`     | `string`  | The name under which to store the newly evaluated artifact.       |
| `input.stage.context.expectedArtifacts[]`         | `[array]` | See [artifacts]({{< ref "artifacts.md" >}}) for more information. |

### input.user

This object provides information about the user performing the action. This can be used to restrict actions by role. See [input.user]({{< ref "input.user.md" >}}) for more information.
