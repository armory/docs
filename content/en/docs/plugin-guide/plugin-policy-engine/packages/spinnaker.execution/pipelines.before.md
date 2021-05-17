---
title: "spinnaker.execution.pipelines.before"
linktitle: "pipelines.before"
description: "Where are we going in this ocean of chaos?"
---

## Example Payload


<details><summary>Click to expand</summary>

```json
{
  "input": {
    "pipeline": {
      "application": "hostname",
      "disabled": false,
      "executionId": "01F5EF8JCVYM85FACGYSTF6S5G",
      "expectedArtifacts": [
        {
          "defaultArtifact": {
            "artifactAccount": "myUsername",
            "customKind": false,
            "metadata": {
              "id": "4aa85178-0618-46c4-b530-6883d393656d"
            },
            "name": "manifests/deploy-spinnaker.yaml",
            "reference": "Https://api.github.com/repos/myUsername/hostname/contents/manifests/deploy-spinnaker.yaml",
            "type": "github/file",
            "version": "master"
          },
          "id": "0cf98032-1b0f-48db-9314-09c69293b3a6",
          "matchArtifact": {
            "artifactAccount": "myUsername",
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
          "defaultArtifact": {
            "artifactAccount": "myUsername",
            "customKind": false,
            "metadata": {
              "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
            },
            "name": "manifests/service-spinnaker.yaml",
            "reference": "Https://api.github.com/repos/myUsername/hostname/contents/manifests/service-spinnaker.yaml",
            "type": "github/file"
          },
          "id": "425d20a8-2942-4902-8d2b-277769a1492c",
          "matchArtifact": {
            "artifactAccount": "myUsername",
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
      "id": "0cdf6df8-ceb1-490e-a7c9-de80e49b0866",
      "keepWaitingPipelines": false,
      "limitConcurrent": true,
      "name": "hostname w evaluate artifacts",
      "notifications": [],
      "parallel": false,
      "parameterConfig": [
        {
          "default": "",
          "description": "",
          "hasOptions": false,
          "label": "",
          "name": "moduleConfig",
          "options": [
            {
              "value": ""
            }
          ],
          "pinned": false,
          "required": false
        }
      ],
      "plan": false,
      "receivedArtifacts": [],
      "respectQuietPeriod": false,
      "spelEvaluator": "v4",
      "stages": [
        {
          "account": "spinnaker",
          "cloudProvider": "kubernetes",
          "manifestArtifactId": "65d24828-f858-4e6f-a2c8-82c2cdd79251",
          "moniker": {
            "app": "hostname"
          },
          "name": "Deploy (Manifest)",
          "refId": "2",
          "requisiteStageRefIds": [
            "7"
          ],
          "skipExpressionEvaluation": false,
          "source": "artifact",
          "trafficManagement": {
            "enabled": false,
            "options": {
              "enableTraffic": false,
              "services": []
            }
          },
          "type": "deployManifest"
        },
        {
          "artifactContents": [
            {
              "contents": "---\napiVersion: v1\nkind: Namespace\nmetadata:\n  name: '${#readJson(parameters['moduleConfig'])['ns']}'\nspec:\n  finalizers:\n  - kubernetes\n---\napiVersion: apps/v1\nkind: Deployment\nmetadata:\n  name: hostname\n  namespace: '${#readJson(parameters['moduleConfig'])['ns']}'\nspec:\n  replicas: '${#readJson(parameters['moduleConfig'])['replicas']}'\n  selector:\n    matchLabels:\n      app: hostname\n      version: v1\n  strategy:\n    rollingUpdate:\n      maxSurge: 1\n      maxUnavailable: 1\n    type: RollingUpdate\n  template:\n    metadata:\n      labels:\n        app: hostname\n        version: v1\n    spec:\n      containers:\n      - image: rstarmer/hostname:v1\n        imagePullPolicy: Always\n        name: hostname\n        resources: {}\n      restartPolicy: Always",
              "id": "65d24828-f858-4e6f-a2c8-82c2cdd79251",
              "name": "test"
            }
          ],
          "expectedArtifacts": [
            {
              "defaultArtifact": {
                "customKind": true,
                "id": "b9076063-d4ff-4ec5-81f6-599a1bb78bf3"
              },
              "displayName": "test",
              "id": "65d24828-f858-4e6f-a2c8-82c2cdd79251",
              "matchArtifact": {
                "artifactAccount": "embedded-artifact",
                "customKind": true,
                "id": "06e6f217-900e-4546-8370-8404255715c9",
                "name": "test",
                "type": "embedded/base64"
              },
              "useDefaultArtifact": false,
              "usePriorArtifact": false
            }
          ],
          "name": "Evaluate Artifacts5",
          "refId": "7",
          "requisiteStageRefIds": [],
          "type": "evaluateArtifacts"
        }
      ],
      "trigger": {
        "artifacts": [
          {
            "artifactAccount": "myUsername",
            "customKind": false,
            "metadata": {
              "id": "4aa85178-0618-46c4-b530-6883d393656d"
            },
            "name": "manifests/deploy-spinnaker.yaml",
            "reference": "Https://api.github.com/repos/myUsername/hostname/contents/manifests/deploy-spinnaker.yaml",
            "type": "github/file",
            "version": "master"
          },
          {
            "artifactAccount": "myUsername",
            "customKind": false,
            "metadata": {
              "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
            },
            "name": "manifests/service-spinnaker.yaml",
            "reference": "Https://api.github.com/repos/myUsername/hostname/contents/manifests/service-spinnaker.yaml",
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
              "artifactAccount": "myUsername",
              "customKind": false,
              "metadata": {
                "id": "4aa85178-0618-46c4-b530-6883d393656d"
              },
              "name": "manifests/deploy-spinnaker.yaml",
              "reference": "Https://api.github.com/repos/myUsername/hostname/contents/manifests/deploy-spinnaker.yaml",
              "type": "github/file",
              "version": "master"
            },
            "defaultArtifact": {
              "artifactAccount": "myUsername",
              "customKind": false,
              "metadata": {
                "id": "4aa85178-0618-46c4-b530-6883d393656d"
              },
              "name": "manifests/deploy-spinnaker.yaml",
              "reference": "Https://api.github.com/repos/myUsername/hostname/contents/manifests/deploy-spinnaker.yaml",
              "type": "github/file",
              "version": "master"
            },
            "id": "0cf98032-1b0f-48db-9314-09c69293b3a6",
            "matchArtifact": {
              "artifactAccount": "myUsername",
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
              "artifactAccount": "myUsername",
              "customKind": false,
              "metadata": {
                "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
              },
              "name": "manifests/service-spinnaker.yaml",
              "reference": "Https://api.github.com/repos/myUsername/hostname/contents/manifests/service-spinnaker.yaml",
              "type": "github/file"
            },
            "defaultArtifact": {
              "artifactAccount": "myUsername",
              "customKind": false,
              "metadata": {
                "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
              },
              "name": "manifests/service-spinnaker.yaml",
              "reference": "Https://api.github.com/repos/myUsername/hostname/contents/manifests/service-spinnaker.yaml",
              "type": "github/file"
            },
            "id": "425d20a8-2942-4902-8d2b-277769a1492c",
            "matchArtifact": {
              "artifactAccount": "myUsername",
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
        "parameters": {
          "moduleConfig": "{\"name\":\"test-deployment\",\"space\":\"test-space-param\"}"
        },
        "preferred": false,
        "rebake": false,
        "resolvedExpectedArtifacts": [
          {
            "boundArtifact": {
              "artifactAccount": "myUsername",
              "customKind": false,
              "metadata": {
                "id": "4aa85178-0618-46c4-b530-6883d393656d"
              },
              "name": "manifests/deploy-spinnaker.yaml",
              "reference": "Https://api.github.com/repos/myUsername/hostname/contents/manifests/deploy-spinnaker.yaml",
              "type": "github/file",
              "version": "master"
            },
            "defaultArtifact": {
              "artifactAccount": "myUsername",
              "customKind": false,
              "metadata": {
                "id": "4aa85178-0618-46c4-b530-6883d393656d"
              },
              "name": "manifests/deploy-spinnaker.yaml",
              "reference": "Https://api.github.com/repos/myUsername/hostname/contents/manifests/deploy-spinnaker.yaml",
              "type": "github/file",
              "version": "master"
            },
            "id": "0cf98032-1b0f-48db-9314-09c69293b3a6",
            "matchArtifact": {
              "artifactAccount": "myUsername",
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
              "artifactAccount": "myUsername",
              "customKind": false,
              "metadata": {
                "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
              },
              "name": "manifests/service-spinnaker.yaml",
              "reference": "Https://api.github.com/repos/myUsername/hostname/contents/manifests/service-spinnaker.yaml",
              "type": "github/file"
            },
            "defaultArtifact": {
              "artifactAccount": "myUsername",
              "customKind": false,
              "metadata": {
                "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
              },
              "name": "manifests/service-spinnaker.yaml",
              "reference": "Https://api.github.com/repos/myUsername/hostname/contents/manifests/service-spinnaker.yaml",
              "type": "github/file"
            },
            "id": "425d20a8-2942-4902-8d2b-277769a1492c",
            "matchArtifact": {
              "artifactAccount": "myUsername",
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
        "type": "manual",
        "user": "myUserName"
      },
      "triggers": [
        {
          "branch": "master",
          "dryRun": false,
          "enabled": true,
          "expectedArtifactIds": [
            "0cf98032-1b0f-48db-9314-09c69293b3a6",
            "425d20a8-2942-4902-8d2b-277769a1492c"
          ],
          "id": "873854a4-d068-3734-8e52-8c224bf127f2",
          "preferred": false,
          "project": "myUsername",
          "rebake": false,
          "secret": "spinnaker",
          "slug": "hostname",
          "source": "github",
          "type": "git"
        }
      ]
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

| Key                                          | Type      | Description                                              |
|----------------------------------------------|-----------|----------------------------------------------------------|
| `input.pipeline.application` | `string` |
| `input.pipeline.disabled` | `boolean` |
| `input.pipeline.executionId` | `string` |
| `input.pipeline.expectedArtifacts[].defaultArtifact.artifactAccount` | `string` |
| `input.pipeline.expectedArtifacts[].defaultArtifact.customKind` | `boolean` |
| `input.pipeline.expectedArtifacts[].defaultArtifact.metadata.id` | `string` |
| `input.pipeline.expectedArtifacts[].defaultArtifact.name` | `string` |
| `input.pipeline.expectedArtifacts[].defaultArtifact.reference` | `string` |
| `input.pipeline.expectedArtifacts[].defaultArtifact.type` | `string` |
| `input.pipeline.expectedArtifacts[].defaultArtifact.version` | `string` |
| `input.pipeline.expectedArtifacts[].id` | `string` |
| `input.pipeline.expectedArtifacts[].matchArtifact.artifactAccount` | `string` |
| `input.pipeline.expectedArtifacts[].matchArtifact.customKind` | `boolean` |
| `input.pipeline.expectedArtifacts[].matchArtifact.metadata.id` | `string` |
| `input.pipeline.expectedArtifacts[].matchArtifact.name` | `string` |
| `input.pipeline.expectedArtifacts[].matchArtifact.type` | `string` |
| `input.pipeline.expectedArtifacts[].useDefaultArtifact` | `boolean` |
| `input.pipeline.expectedArtifacts[].usePriorArtifact` | `boolean` |
| `input.pipeline.id` | `string` |
| `input.pipeline.keepWaitingPipelines` | `boolean` |
| `input.pipeline.limitConcurrent` | `boolean` |
| `input.pipeline.name` | `string` |
| `input.pipeline.parallel` | `boolean` |
| `input.pipeline.parameterConfig[].default` | `string` |
| `input.pipeline.parameterConfig[].description` | `string` |
| `input.pipeline.parameterConfig[].hasOptions` | `boolean` |
| `input.pipeline.parameterConfig[].label` | `string` |
| `input.pipeline.parameterConfig[].name` | `string` |
| `input.pipeline.parameterConfig[].options[].value` | `string` |
| `input.pipeline.parameterConfig[].pinned` | `boolean` |
| `input.pipeline.parameterConfig[].required` | `boolean` |
| `input.pipeline.plan` | `boolean` |
| `input.pipeline.respectQuietPeriod` | `boolean` |
| `input.pipeline.spelEvaluator` | `string` |
| `input.pipeline.stages[].account` | `string` |
| `input.pipeline.stages[].artifactContents[].contents` | `string` |
| `input.pipeline.stages[].artifactContents[].id` | `string` |
| `input.pipeline.stages[].artifactContents[].name` | `string` |
| `input.pipeline.stages[].cloudProvider` | `string` |
| `input.pipeline.stages[].expectedArtifacts[].defaultArtifact.customKind` | `boolean` |
| `input.pipeline.stages[].expectedArtifacts[].defaultArtifact.id` | `string` |
| `input.pipeline.stages[].expectedArtifacts[].displayName` | `string` |
| `input.pipeline.stages[].expectedArtifacts[].id` | `string` |
| `input.pipeline.stages[].expectedArtifacts[].matchArtifact.artifactAccount` | `string` |
| `input.pipeline.stages[].expectedArtifacts[].matchArtifact.customKind` | `boolean` |
| `input.pipeline.stages[].expectedArtifacts[].matchArtifact.id` | `string` |
| `input.pipeline.stages[].expectedArtifacts[].matchArtifact.name` | `string` |
| `input.pipeline.stages[].expectedArtifacts[].matchArtifact.type` | `string` |
| `input.pipeline.stages[].expectedArtifacts[].useDefaultArtifact` | `boolean` |
| `input.pipeline.stages[].expectedArtifacts[].usePriorArtifact` | `boolean` |
| `input.pipeline.stages[].manifestArtifactId` | `string` |
| `input.pipeline.stages[].moniker.app` | `string` |
| `input.pipeline.stages[].name` | `string` |
| `input.pipeline.stages[].refId` | `string` |
| `input.pipeline.stages[].requisiteStageRefIds[]` | `string` |
| `input.pipeline.stages[].skipExpressionEvaluation` | `boolean` |
| `input.pipeline.stages[].source` | `string` |
| `input.pipeline.stages[].trafficManagement.enabled` | `boolean` |
| `input.pipeline.stages[].trafficManagement.options.enableTraffic` | `boolean` |
| `input.pipeline.stages[].type` | `string` |
| `input.pipeline.trigger.artifacts[].artifactAccount` | `string` |
| `input.pipeline.trigger.artifacts[].customKind` | `boolean` |
| `input.pipeline.trigger.artifacts[].metadata.id` | `string` |
| `input.pipeline.trigger.artifacts[].name` | `string` |
| `input.pipeline.trigger.artifacts[].reference` | `string` |
| `input.pipeline.trigger.artifacts[].type` | `string` |
| `input.pipeline.trigger.artifacts[].version` | `string` |
| `input.pipeline.trigger.dryRun` | `boolean` |
| `input.pipeline.trigger.enabled` | `boolean` |
| `input.pipeline.trigger.eventId` | `string` |
| `input.pipeline.trigger.executionId` | `string` |
| `input.pipeline.trigger.expectedArtifacts[].boundArtifact.artifactAccount` | `string` |
| `input.pipeline.trigger.expectedArtifacts[].boundArtifact.customKind` | `boolean` |
| `input.pipeline.trigger.expectedArtifacts[].boundArtifact.metadata.id` | `string` |
| `input.pipeline.trigger.expectedArtifacts[].boundArtifact.name` | `string` |
| `input.pipeline.trigger.expectedArtifacts[].boundArtifact.reference` | `string` |
| `input.pipeline.trigger.expectedArtifacts[].boundArtifact.type` | `string` |
| `input.pipeline.trigger.expectedArtifacts[].boundArtifact.version` | `string` |
| `input.pipeline.trigger.expectedArtifacts[].defaultArtifact.artifactAccount` | `string` |
| `input.pipeline.trigger.expectedArtifacts[].defaultArtifact.customKind` | `boolean` |
| `input.pipeline.trigger.expectedArtifacts[].defaultArtifact.metadata.id` | `string` |
| `input.pipeline.trigger.expectedArtifacts[].defaultArtifact.name` | `string` |
| `input.pipeline.trigger.expectedArtifacts[].defaultArtifact.reference` | `string` |
| `input.pipeline.trigger.expectedArtifacts[].defaultArtifact.type` | `string` |
| `input.pipeline.trigger.expectedArtifacts[].defaultArtifact.version` | `string` |
| `input.pipeline.trigger.expectedArtifacts[].id` | `string` |
| `input.pipeline.trigger.expectedArtifacts[].matchArtifact.artifactAccount` | `string` |
| `input.pipeline.trigger.expectedArtifacts[].matchArtifact.customKind` | `boolean` |
| `input.pipeline.trigger.expectedArtifacts[].matchArtifact.metadata.id` | `string` |
| `input.pipeline.trigger.expectedArtifacts[].matchArtifact.name` | `string` |
| `input.pipeline.trigger.expectedArtifacts[].matchArtifact.type` | `string` |
| `input.pipeline.trigger.expectedArtifacts[].useDefaultArtifact` | `boolean` |
| `input.pipeline.trigger.expectedArtifacts[].usePriorArtifact` | `boolean` |
| `input.pipeline.trigger.parameters.moduleConfig` | `string` |
| `input.pipeline.trigger.preferred` | `boolean` |
| `input.pipeline.trigger.rebake` | `boolean` |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.artifactAccount` | `string` |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.customKind` | `boolean` |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.metadata.id` | `string` |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.name` | `string` |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.reference` | `string` |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.type` | `string` |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.version` | `string` |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.artifactAccount` | `string` |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.customKind` | `boolean` |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.metadata.id` | `string` |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.name` | `string` |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.reference` | `string` |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.type` | `string` |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.version` | `string` |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].id` | `string` |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.artifactAccount` | `string` |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.customKind` | `boolean` |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.metadata.id` | `string` |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.name` | `string` |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.type` | `string` |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].useDefaultArtifact` | `boolean` |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].usePriorArtifact` | `boolean` |
| `input.pipeline.trigger.type` | `string` |
| `input.pipeline.trigger.user` | `string` |
| `input.pipeline.triggers[].branch` | `string` |
| `input.pipeline.triggers[].dryRun` | `boolean` |
| `input.pipeline.triggers[].enabled` | `boolean` |
| `input.pipeline.triggers[].expectedArtifactIds[]` | `string` |
| `input.pipeline.triggers[].id` | `string` |
| `input.pipeline.triggers[].preferred` | `boolean` |
| `input.pipeline.triggers[].project` | `string` |
| `input.pipeline.triggers[].rebake` | `boolean` |
| `input.pipeline.triggers[].secret` | `string` |
| `input.pipeline.triggers[].slug` | `string` |
| `input.pipeline.triggers[].source` | `string` |
| `input.pipeline.triggers[].type` | `string` |
| `input.user.isAdmin` | `boolean` |
| `input.user.username` | `string` |
