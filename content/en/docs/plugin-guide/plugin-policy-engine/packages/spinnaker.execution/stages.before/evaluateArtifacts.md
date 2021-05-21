---
title: "spinnaker.execution.stages.before.evaluateArtifacts"
linktitle: "evaluateArtifacts"
description: "fill me with delicious data, Stephen!"
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
        "user": "elfie2002"
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
            "artifactAccount": "stephenatwell",
            "customKind": false,
            "location": null,
            "metadata": {
              "id": "4aa85178-0618-46c4-b530-6883d393656d"
            },
            "name": "manifests/deploy-spinnaker.yaml",
            "provenance": null,
            "reference": "Https://api.github.com/repos/stephenatwell/hostname/contents/manifests/deploy-spinnaker.yaml",
            "type": "github/file",
            "uuid": null,
            "version": "master"
          },
          {
            "artifactAccount": "stephenatwell",
            "customKind": false,
            "location": null,
            "metadata": {
              "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
            },
            "name": "manifests/service-spinnaker.yaml",
            "provenance": null,
            "reference": "Https://api.github.com/repos/stephenatwell/hostname/contents/manifests/service-spinnaker.yaml",
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
              "artifactAccount": "stephenatwell",
              "customKind": false,
              "metadata": {
                "id": "4aa85178-0618-46c4-b530-6883d393656d"
              },
              "name": "manifests/deploy-spinnaker.yaml",
              "reference": "Https://api.github.com/repos/stephenatwell/hostname/contents/manifests/deploy-spinnaker.yaml",
              "type": "github/file",
              "version": "master"
            },
            {
              "artifactAccount": "stephenatwell",
              "customKind": false,
              "metadata": {
                "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
              },
              "name": "manifests/service-spinnaker.yaml",
              "reference": "Https://api.github.com/repos/stephenatwell/hostname/contents/manifests/service-spinnaker.yaml",
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
                "artifactAccount": "stephenatwell",
                "customKind": false,
                "metadata": {
                  "id": "4aa85178-0618-46c4-b530-6883d393656d"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/stephenatwell/hostname/contents/manifests/deploy-spinnaker.yaml",
                "type": "github/file",
                "version": "master"
              },
              "defaultArtifact": {
                "artifactAccount": "stephenatwell",
                "customKind": false,
                "metadata": {
                  "id": "4aa85178-0618-46c4-b530-6883d393656d"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/stephenatwell/hostname/contents/manifests/deploy-spinnaker.yaml",
                "type": "github/file",
                "version": "master"
              },
              "id": "0cf98032-1b0f-48db-9314-09c69293b3a6",
              "matchArtifact": {
                "artifactAccount": "stephenatwell",
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
                "artifactAccount": "stephenatwell",
                "customKind": false,
                "metadata": {
                  "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
                },
                "name": "manifests/service-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/stephenatwell/hostname/contents/manifests/service-spinnaker.yaml",
                "type": "github/file"
              },
              "defaultArtifact": {
                "artifactAccount": "stephenatwell",
                "customKind": false,
                "metadata": {
                  "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
                },
                "name": "manifests/service-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/stephenatwell/hostname/contents/manifests/service-spinnaker.yaml",
                "type": "github/file"
              },
              "id": "425d20a8-2942-4902-8d2b-277769a1492c",
              "matchArtifact": {
                "artifactAccount": "stephenatwell",
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
                "artifactAccount": "stephenatwell",
                "customKind": false,
                "metadata": {
                  "id": "4aa85178-0618-46c4-b530-6883d393656d"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/stephenatwell/hostname/contents/manifests/deploy-spinnaker.yaml",
                "type": "github/file",
                "version": "master"
              },
              "defaultArtifact": {
                "artifactAccount": "stephenatwell",
                "customKind": false,
                "metadata": {
                  "id": "4aa85178-0618-46c4-b530-6883d393656d"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/stephenatwell/hostname/contents/manifests/deploy-spinnaker.yaml",
                "type": "github/file",
                "version": "master"
              },
              "id": "0cf98032-1b0f-48db-9314-09c69293b3a6",
              "matchArtifact": {
                "artifactAccount": "stephenatwell",
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
                "artifactAccount": "stephenatwell",
                "customKind": false,
                "metadata": {
                  "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
                },
                "name": "manifests/service-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/stephenatwell/hostname/contents/manifests/service-spinnaker.yaml",
                "type": "github/file"
              },
              "defaultArtifact": {
                "artifactAccount": "stephenatwell",
                "customKind": false,
                "metadata": {
                  "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
                },
                "name": "manifests/service-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/stephenatwell/hostname/contents/manifests/service-spinnaker.yaml",
                "type": "github/file"
              },
              "id": "425d20a8-2942-4902-8d2b-277769a1492c",
              "matchArtifact": {
                "artifactAccount": "stephenatwell",
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
          "user": "elfie2002"
        },
        "parameters": {
          "moduleConfig": "{\"name\":\"test-deployment\",\"space\":\"test-space-param\"}"
        },
        "resolvedExpectedArtifacts": [
          {
            "boundArtifact": {
              "artifactAccount": "stephenatwell",
              "customKind": false,
              "location": null,
              "metadata": {
                "id": "4aa85178-0618-46c4-b530-6883d393656d"
              },
              "name": "manifests/deploy-spinnaker.yaml",
              "provenance": null,
              "reference": "Https://api.github.com/repos/stephenatwell/hostname/contents/manifests/deploy-spinnaker.yaml",
              "type": "github/file",
              "uuid": null,
              "version": "master"
            },
            "defaultArtifact": {
              "artifactAccount": "stephenatwell",
              "customKind": false,
              "location": null,
              "metadata": {
                "id": "4aa85178-0618-46c4-b530-6883d393656d"
              },
              "name": "manifests/deploy-spinnaker.yaml",
              "provenance": null,
              "reference": "Https://api.github.com/repos/stephenatwell/hostname/contents/manifests/deploy-spinnaker.yaml",
              "type": "github/file",
              "uuid": null,
              "version": "master"
            },
            "id": "0cf98032-1b0f-48db-9314-09c69293b3a6",
            "matchArtifact": {
              "artifactAccount": "stephenatwell",
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
              "artifactAccount": "stephenatwell",
              "customKind": false,
              "location": null,
              "metadata": {
                "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
              },
              "name": "manifests/service-spinnaker.yaml",
              "provenance": null,
              "reference": "Https://api.github.com/repos/stephenatwell/hostname/contents/manifests/service-spinnaker.yaml",
              "type": "github/file",
              "uuid": null,
              "version": null
            },
            "defaultArtifact": {
              "artifactAccount": "stephenatwell",
              "customKind": false,
              "location": null,
              "metadata": {
                "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
              },
              "name": "manifests/service-spinnaker.yaml",
              "provenance": null,
              "reference": "Https://api.github.com/repos/stephenatwell/hostname/contents/manifests/service-spinnaker.yaml",
              "type": "github/file",
              "uuid": null,
              "version": null
            },
            "id": "425d20a8-2942-4902-8d2b-277769a1492c",
            "matchArtifact": {
              "artifactAccount": "stephenatwell",
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
        "user": "elfie2002"
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
      "username": "elfie2002"
    }
  }
}
```
</details>

## Example Policy

```rego

```

## Keys

### `input.pipeline`

| Key                                                                                        | Type      | Description |
| ------------------------------------------------------------------------------------------ | --------- | ----------- |
| `input.pipeline.application`                                                               | `string`  |             |
| `input.pipeline.authentication.allowedAccounts[]`                                          | `string`  |             |
| `input.pipeline.authentication.user`                                                       | `string`  |             |
| `input.pipeline.buildTime`                                                                 | `number`  |             |
| `input.pipeline.canceled`                                                                  | `boolean` |             |
| `input.pipeline.canceledBy`                                                                | ` `       |             |
| `input.pipeline.cancellationReason`                                                        | ` `       |             |
| `input.pipeline.description`                                                               | ` `       |             |
| `input.pipeline.endTime`                                                                   | ` `       |             |
| `input.pipeline.id`                                                                        | `string`  |             |
| `input.pipeline.keepWaitingPipelines`                                                      | `boolean` |             |
| `input.pipeline.limitConcurrent`                                                           | `boolean` |             |
| `input.pipeline.name`                                                                      | `string`  |             |
| `input.pipeline.origin`                                                                    | `string`  |             |
| `input.pipeline.partition`                                                                 | ` `       |             |
| `input.pipeline.paused`                                                                    | ` `       |             |
| `input.pipeline.pipelineConfigId`                                                          | `string`  |             |
| `input.pipeline.source`                                                                    | ` `       |             |
| `input.pipeline.spelEvaluator`                                                             | `string`  |             |
| `input.pipeline.stages[]`                                                                  | `string`  |             |
| `input.pipeline.stages[].context.account`                                                  | `string`  |             |
| `input.pipeline.stages[].context.action`                                                   | `string`  |             |
| `input.pipeline.stages[].context.artifacts[].account`                                      | `string`  |             |
| `input.pipeline.stages[].context.artifacts[].id`                                           | `string`  |             |
| `input.pipeline.stages[].context.cloudProvider`                                            | `string`  |             |
| `input.pipeline.stages[].context.expectedArtifacts[].defaultArtifact.customKind`           | `boolean` |             |
| `input.pipeline.stages[].context.expectedArtifacts[].defaultArtifact.id`                   | `string`  |             |
| `input.pipeline.stages[].context.expectedArtifacts[].displayName`                          | `string`  |             |
| `input.pipeline.stages[].context.expectedArtifacts[].id`                                   | `string`  |             |
| `input.pipeline.stages[].context.expectedArtifacts[].matchArtifact.artifactAccount`        | `string`  |             |
| `input.pipeline.stages[].context.expectedArtifacts[].matchArtifact.id`                     | `string`  |             |
| `input.pipeline.stages[].context.expectedArtifacts[].matchArtifact.name`                   | `string`  |             |
| `input.pipeline.stages[].context.expectedArtifacts[].matchArtifact.type`                   | `string`  |             |
| `input.pipeline.stages[].context.expectedArtifacts[].useDefaultArtifact`                   | `boolean` |             |
| `input.pipeline.stages[].context.expectedArtifacts[].usePriorArtifact`                     | `boolean` |             |
| `input.pipeline.stages[].context.failPipeline`                                             | `boolean` |             |
| `input.pipeline.stages[].context.manifestArtifactId`                                       | `string`  |             |
| `input.pipeline.stages[].context.moniker.app`                                              | `string`  |             |
| `input.pipeline.stages[].context.planForDestroy`                                           | `boolean` |             |
| `input.pipeline.stages[].context.skipExpressionEvaluation`                                 | `boolean` |             |
| `input.pipeline.stages[].context.source`                                                   | `string`  |             |
| `input.pipeline.stages[].context.terraformVersion`                                         | `string`  |             |
| `input.pipeline.stages[].context.trafficManagement.enabled`                                | `boolean` |             |
| `input.pipeline.stages[].context.trafficManagement.options.enableTraffic`                  | `boolean` |             |
| `input.pipeline.stages[].endTime`                                                          | ` `       |             |
| `input.pipeline.stages[].id`                                                               | `string`  |             |
| `input.pipeline.stages[].lastModified`                                                     | ` `       |             |
| `input.pipeline.stages[].name`                                                             | `string`  |             |
| `input.pipeline.stages[].parentStageId`                                                    | ` `       |             |
| `input.pipeline.stages[].refId`                                                            | `string`  |             |
| `input.pipeline.stages[].requisiteStageRefIds[]`                                           | `string`  |             |
| `input.pipeline.stages[].scheduledTime`                                                    | ` `       |             |
| `input.pipeline.stages[].startTime`                                                        | ` `       |             |
| `input.pipeline.stages[].startTimeExpiry`                                                  | ` `       |             |
| `input.pipeline.stages[].status`                                                           | `string`  |             |
| `input.pipeline.stages[].syntheticStageOwner`                                              | ` `       |             |
| `input.pipeline.stages[].type`                                                             | `string`  |             |
| `input.pipeline.startTime`                                                                 | `number`  |             |
| `input.pipeline.startTimeExpiry`                                                           | ` `       |             |
| `input.pipeline.status`                                                                    | `string`  |             |
| `input.pipeline.templateVariables`                                                         | ` `       |             |
| `input.pipeline.trigger.artifacts[].artifactAccount`                                       | `string`  |             |
| `input.pipeline.trigger.artifacts[].customKind`                                            | `boolean` |             |
| `input.pipeline.trigger.artifacts[].location`                                              | ` `       |             |
| `input.pipeline.trigger.artifacts[].metadata.id`                                           | `string`  |             |
| `input.pipeline.trigger.artifacts[].name`                                                  | `string`  |             |
| `input.pipeline.trigger.artifacts[].provenance`                                            | ` `       |             |
| `input.pipeline.trigger.artifacts[].reference`                                             | `string`  |             |
| `input.pipeline.trigger.artifacts[].type`                                                  | `string`  |             |
| `input.pipeline.trigger.artifacts[].uuid`                                                  | ` `       |             |
| `input.pipeline.trigger.artifacts[].version`                                               | `string`  |             |
| `input.pipeline.trigger.artifacts[].version`                                               | ` `       |             |
| `input.pipeline.trigger.correlationId`                                                     | ` `       |             |
| `input.pipeline.trigger.isDryRun`                                                          | `boolean` |             |
| `input.pipeline.trigger.isRebake`                                                          | `boolean` |             |
| `input.pipeline.trigger.isStrategy`                                                        | `boolean` |             |
| `input.pipeline.trigger.other.artifacts[].artifactAccount`                                 | `string`  |             |
| `input.pipeline.trigger.other.artifacts[].customKind`                                      | `boolean` |             |
| `input.pipeline.trigger.other.artifacts[].metadata.id`                                     | `string`  |             |
| `input.pipeline.trigger.other.artifacts[].name`                                            | `string`  |             |
| `input.pipeline.trigger.other.artifacts[].reference`                                       | `string`  |             |
| `input.pipeline.trigger.other.artifacts[].type`                                            | `string`  |             |
| `input.pipeline.trigger.other.artifacts[].version`                                         | `string`  |             |
| `input.pipeline.trigger.other.dryRun`                                                      | `boolean` |             |
| `input.pipeline.trigger.other.enabled`                                                     | `boolean` |             |
| `input.pipeline.trigger.other.eventId`                                                     | `string`  |             |
| `input.pipeline.trigger.other.executionId`                                                 | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].boundArtifact.artifactAccount`           | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].boundArtifact.customKind`                | `boolean` |             |
| `input.pipeline.trigger.other.expectedArtifacts[].boundArtifact.metadata.id`               | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].boundArtifact.name`                      | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].boundArtifact.reference`                 | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].boundArtifact.type`                      | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].boundArtifact.version`                   | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].defaultArtifact.artifactAccount`         | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].defaultArtifact.customKind`              | `boolean` |             |
| `input.pipeline.trigger.other.expectedArtifacts[].defaultArtifact.metadata.id`             | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].defaultArtifact.name`                    | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].defaultArtifact.reference`               | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].defaultArtifact.type`                    | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].defaultArtifact.version`                 | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].id`                                      | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].matchArtifact.artifactAccount`           | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].matchArtifact.customKind`                | `boolean` |             |
| `input.pipeline.trigger.other.expectedArtifacts[].matchArtifact.metadata.id`               | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].matchArtifact.name`                      | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].matchArtifact.type`                      | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].useDefaultArtifact`                      | `boolean` |             |
| `input.pipeline.trigger.other.expectedArtifacts[].usePriorArtifact`                        | `boolean` |             |
| `input.pipeline.trigger.other.parameters.nameAndSpace`                                     | `string`  |             |
| `input.pipeline.trigger.other.parameters.replicas`                                         | `string`  |             |
| `input.pipeline.trigger.other.parameters.moduleConfig`                                     | `string`  |             |
| `input.pipeline.trigger.other.preferred`                                                   | `boolean` |             |
| `input.pipeline.trigger.other.rebake`                                                      | `boolean` |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].boundArtifact.artifactAccount`   | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].boundArtifact.customKind`        | `boolean` |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].boundArtifact.metadata.id`       | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].boundArtifact.name`              | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].boundArtifact.reference`         | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].boundArtifact.type`              | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].boundArtifact.version`           | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].defaultArtifact.artifactAccount` | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].defaultArtifact.customKind`      | `boolean` |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].defaultArtifact.metadata.id`     | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].defaultArtifact.name`            | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].defaultArtifact.reference`       | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].defaultArtifact.type`            | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].defaultArtifact.version`         | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].id`                              | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].matchArtifact.artifactAccount`   | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].matchArtifact.customKind`        | `boolean` |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].matchArtifact.metadata.id`       | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].matchArtifact.name`              | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].matchArtifact.type`              | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].useDefaultArtifact`              | `boolean` |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].usePriorArtifact`                | `boolean` |             |
| `input.pipeline.trigger.other.strategy`                                                    | `boolean` |             |
| `input.pipeline.trigger.other.type`                                                        | `string`  |             |
| `input.pipeline.trigger.other.user`                                                        | `string`  |             |
| `input.pipeline.trigger.parameters.nameAndSpace`                                           | `string`  |             |
| `input.pipeline.trigger.parameters.replicas`                                               | `string`  |             |
| `input.pipeline.trigger.parameters.moduleConfig`                                           | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.artifactAccount`         | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.customKind`              | `boolean` |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.location`                | ` `       |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.metadata.id`             | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.name`                    | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.provenance`              | ` `       |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.reference`               | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.type`                    | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.uuid`                    | ` `       |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.version`                 | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.version`                 | ` `       |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.artifactAccount`       | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.customKind`            | `boolean` |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.location`              | ` `       |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.metadata.id`           | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.name`                  | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.provenance`            | ` `       |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.reference`             | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.type`                  | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.uuid`                  | ` `       |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.version`               | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.version`               | ` `       |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].id`                                    | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.artifactAccount`         | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.customKind`              | `boolean` |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.location`                | ` `       |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.metadata.id`             | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.name`                    | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.provenance`              | ` `       |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.reference`               | ` `       |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.type`                    | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.uuid`                    | ` `       |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.version`                 | ` `       |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].useDefaultArtifact`                    | `boolean` |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].usePriorArtifact`                      | `boolean` |             |
| `input.pipeline.trigger.type`                                                              | `string`  |             |
| `input.pipeline.trigger.user`                                                              | `string`  |             |
| `input.pipeline.type`                                                                      | `string`  |             |

### `input.stage`

| Key                                                                     | Type      | Description |
| ----------------------------------------------------------------------- | --------- | ----------- |
| `input.stage.context.artifactContents[].contents`                       | `string`  |             |
| `input.stage.context.artifactContents[].name`                           | `string`  |             |
| `input.stage.context.expectedArtifacts[].defaultArtifact.customKind`    | `boolean` |             |
| `input.stage.context.expectedArtifacts[].defaultArtifact.metadata.id`   | `string`  |             |
| `input.stage.context.expectedArtifacts[].id`                            | `string`  |             |
| `input.stage.context.expectedArtifacts[].matchArtifact.artifactAccount` | `string`  |             |
| `input.stage.context.expectedArtifacts[].matchArtifact.customKind`      | `boolean` |             |
| `input.stage.context.expectedArtifacts[].matchArtifact.metadata.id`     | `string`  |             |
| `input.stage.context.expectedArtifacts[].matchArtifact.name`            | `string`  |             |
| `input.stage.context.expectedArtifacts[].matchArtifact.type`            | `string`  |             |
| `input.stage.context.expectedArtifacts[].useDefaultArtifact`            | `boolean` |             |
| `input.stage.context.expectedArtifacts[].usePriorArtifact`              | `boolean` |             |
| `input.stage.endTime`                                                   | ` `       |             |
| `input.stage.id`                                                        | `string`  |             |
| `input.stage.lastModified`                                              | ` `       |             |
| `input.stage.name`                                                      | `string`  |             |
| `input.stage.outputs.artifacts[].customKind`                            | `boolean` |             |
| `input.stage.outputs.artifacts[].name`                                  | `string`  |             |
| `input.stage.outputs.artifacts[].reference`                             | `string`  |             |
| `input.stage.outputs.artifacts[].type`                                  | `string`  |             |
| `input.stage.parentStageId`                                             | ` `       |             |
| `input.stage.refId`                                                     | `string`  |             |
| `input.stage.scheduledTime`                                             | ` `       |             |
| `input.stage.startTime`                                                 | `number`  |             |
| `input.stage.startTimeExpiry`                                           | ` `       |             |
| `input.stage.status`                                                    | `string`  |             |
| `input.stage.syntheticStageOwner`                                       | ` `       |             |
| `input.stage.tasks[].endTime`                                           | `number`  |             |
| `input.stage.tasks[].endTime`                                           | ` `       |             |
| `input.stage.tasks[].id`                                                | `string`  |             |
| `input.stage.tasks[].implementingClass`                                 | `string`  |             |
| `input.stage.tasks[].loopEnd`                                           | `boolean` |             |
| `input.stage.tasks[].loopStart`                                         | `boolean` |             |
| `input.stage.tasks[].name`                                              | `string`  |             |
| `input.stage.tasks[].stageEnd`                                          | `boolean` |             |
| `input.stage.tasks[].stageStart`                                        | `boolean` |             |
| `input.stage.tasks[].startTime`                                         | `number`  |             |
| `input.stage.tasks[].status`                                            | `string`  |             |
| `input.stage.type`                                                      | `string`  |             |


### `input.user`

| Key                   | Type      | Description |
| --------------------- | --------- | ----------- |
| `input.user.isAdmin`  | `boolean` |             |
| `input.user.username` | `string`  |             |







