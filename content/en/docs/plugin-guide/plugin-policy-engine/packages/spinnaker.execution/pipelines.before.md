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
package spinnaker.execution.pipelines.before

deny["Kubernetes deployments can only be triggered by webhooks, docker, or manually."] { 
  stage := input.pipeline.stages[_]
  trigger := input.pipeline.trigger

  stage.type == "deployManifest"
  trigger.type != "docker"
  trigger.type != "webhook"
  trigger.type != "manual"
}
```

## Keys

### `input.pipeline`

| Key                                                | Type       | Description                                                                                                                                                          |
| -------------------------------------------------- | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `input.pipeline.application`                       | `string`   | The name of the Spinnaker application to which this pipeline belongs.                                                                                                |
| `input.pipeline.disabled`                          | `boolean`  | has execution of this pipeline been disables                                                                                                                                                                     |
| `input.pipeline.executionId`                       | `string`   | The unique ID of the execution                                                                                                                                       |
| `input.pipeline.expectedArtifacts[]`               | `{object}` | See [artifacts]({{< ref "artifacts.md" >}}) for more information.                                                                                                    |
| `input.pipeline.id`                                | `string`   |  The unique ID of the pipeline                                                                                                                                                                    |
| `input.pipeline.keepWaitingPipelines`              | `boolean`  | If concurrent pipeline execution is disabled, then the pipelines that are in the waiting queue will get canceled when the next execution starts unless this is true. |
| `input.pipeline.limitConcurrent`                   | `boolean`  | Disable concurrent pipeline executions (only run one at a time).                                                                                                     |
| `input.pipeline.name`                              | `string`   | The name of the pipeline                                                                                                                                             |
| `input.pipeline.parallel`                          | `boolean`  |                                                                                                                                                                      |
| `input.pipeline.parameterConfig[].default`         | `string`   | What is the default value of the parameter                                                                                                                           |
| `input.pipeline.parameterConfig[].description`     | `string`   | if supplied, will be displayed to users as a tooltip when triggering the pipeline manually. You can include HTML in this field.                                      |
| `input.pipeline.parameterConfig[].hasOptions`      | `boolean`  | Does this parameter require users to specify an option from a predefined list.                                                                                       |
| `input.pipeline.parameterConfig[].label`           | `string`   | a label to display when users are triggering the pipeline manually                                                                                                   |
| `input.pipeline.parameterConfig[].name`            | `string`   | The name of the parameter                                                                                                                                            |
| `input.pipeline.parameterConfig[].options[].value` | `string`   | What values exist in a picklist for the user to choose from for the parameter.                                                                                       |
| `input.pipeline.parameterConfig[].pinned`          | `boolean`  | if checked, this parameter will be always shown in a pipeline execution view, otherwise it'll be collapsed by default.                                               |
| `input.pipeline.parameterConfig[].required`        | `boolean`  | Must the user provide a value for this parameter when executing the pipeline.                                                                                        |
| `input.pipeline.plan`                              | `boolean`  |                                                                                                                                                                      |
| `input.pipeline.respectQuietPeriod`                | `boolean`  |                                                                                                                                                                      |
| `input.pipeline.spelEvaluator`                     | `string`   | Which version of SpEL should SpEL expressions be evaluated with.                                                                                                     |

### `input.pipeline.stages`

| Key                                                               | Type       | Description                                                                                                                                                                                                                                                                                                                                                                                                                   |
| ----------------------------------------------------------------- | ---------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `input.pipeline.stages[].account`                                 | `string`   | Which account does this stage deploy to.                                                                                                                                                                                                                                                                                                                                                                                      |
| `input.pipeline.stages[].artifactContents[].contents`             | `string`   | The contents of an artifact used by this stage.                                                                                                                                                                                                                                                                                                                                                                               |
| `input.pipeline.stages[].artifactContents[].id`                   | `string`   | The unique id of an artifact used by this stage.                                                                                                                                                                                                                                                                                                                                                                              |
| `input.pipeline.stages[].artifactContents[].name`                 | `string`   | The name of an artifact used by this stage.                                                                                                                                                                                                                                                                                                                                                                                   |
| `input.pipeline.stages[].cloudProvider`                           | `string`   | What type of cloud provider (AWSD, Kubernetes) does this stage deploy to.                                                                                                                                                                                                                                                                                                                                                     |
| `input.pipeline.stages[].expectedArtifacts[]`                     | `{object}` | See [artifacts]({{< ref "artifacts.md" >}}) for more information.                                                                                                                                                                                                                                                                                                                                                             |
| `input.pipeline.stages[].manifestArtifactId`                      | `string`   |                                                                                                                                                                                                                                                                                                                                                                                                                               |
| `input.pipeline.stages[].name`                                    | `string`   | The name of this stage                                                                                                                                                                                                                                                                                                                                                                                                        |
| `input.pipeline.stages[].refId`                                   | `string`   | This provides the unique identifier for this stage and can be used to generate a stage dependancy graph                                                                                                                                                                                                                                                                                                                       |
| `input.pipeline.stages[].requisiteStageRefIds[]`                  | `string`   | This specifies what stages in the pipeline ran before this stage, and can be used to generate a stage dependancy graph.                                                                                                                                                                                                                                                                                                       |
| `input.pipeline.stages[].skipExpressionEvaluation`                | `boolean`  |     Should this stage skip evaluating SpEl.                                                                                                                                                                                                                                                                                                                                                                                                                          |
| `input.pipeline.stages[].source`                                  | `string`   |                                                                                                                                                                                                                                                                                                                                                                                                                               |
| `input.pipeline.stages[].trafficManagement.enabled`               | `boolean`  |   Allow Spinnaker to associate each ReplicaSet deployed in this stage with one or more Services and manage traffic based on your selected rollout strategy options.                                                                                                                                                                                                                                                                                                                                                                                                                           |
| `input.pipeline.stages[].trafficManagement.options.enableTraffic` | `boolean`  |   is traffic management enabled                                                                                                                                                                                                                                                                                                                                                                                                                            |
| `input.pipeline.stages[].type`                                    | `string`   | That is the type of the stage                                                                                                                                                                                                                                                                                                                                                                                                 |
| `input.pipeline.stages[]`                                         | `string`   | The serialized configuration of your spinnaker stages. Fields within the stages relate to the field given in the spinnaker/execution/stages/before package for that stage type. In general, users are advised to wright policies that are specific to whether a single stage should execute against the stage execution, not the pipeline execution. This ensures stages referencing SpEL will have had their SpEL evaluated. |

### `input.pipeline.trigger`

| Key                                                                                  | Type      | Description                                                                                      |
| ------------------------------------------------------------------------------------ | --------- | ------------------------------------------------------------------------------------------------ |
| `input.pipeline.trigger.artifacts[].artifactAccount`                                 | `string`  | Specifies the account to read this triggers artifact from                                        |
| `input.pipeline.trigger.artifacts[].customKind`                                      | `boolean` |                                                                                                  |
| `input.pipeline.trigger.artifacts[].metadata.id`                                     | `string`  |                                                                                                  |
| `input.pipeline.trigger.artifacts[].name`                                            | `string`  | specifies a name for the artifact                                                                |
| `input.pipeline.trigger.artifacts[].reference`                                       | `string`  |                                                                                                  |
| `input.pipeline.trigger.artifacts[].type`                                            | `string`  | specifies the type of the artifact, for example 'git'.                                           |
| `input.pipeline.trigger.artifacts[].version`                                         | `string`  | what branch/version should the artifact be read from.                                            |
| `input.pipeline.trigger.dryRun`                                                      | `boolean` |                                                                                                  |
| `input.pipeline.trigger.enabled`                                                     | `boolean` | is the trigger enabled                                                                           |
| `input.pipeline.trigger.eventId`                                                     | `string`  |                                                                                                  |
| `input.pipeline.trigger.executionId`                                                 | `string`  |                                                                                                  |
| `input.pipeline.trigger.expectedArtifacts[].boundArtifact.artifactAccount`           | `string`  |                                                                                                  |
| `input.pipeline.trigger.expectedArtifacts[].boundArtifact.customKind`                | `boolean` |                                                                                                  |
| `input.pipeline.trigger.expectedArtifacts[].boundArtifact.metadata.id`               | `string`  |                                                                                                  |
| `input.pipeline.trigger.expectedArtifacts[].boundArtifact.name`                      | `string`  |                                                                                                  |
| `input.pipeline.trigger.expectedArtifacts[].boundArtifact.reference`                 | `string`  |                                                                                                  |
| `input.pipeline.trigger.expectedArtifacts[].boundArtifact.type`                      | `string`  |                                                                                                  |
| `input.pipeline.trigger.expectedArtifacts[].boundArtifact.version`                   | `string`  |                                                                                                  |
| `input.pipeline.trigger.expectedArtifacts[].defaultArtifact.artifactAccount`         | `string`  |                                                                                                  |
| `input.pipeline.trigger.expectedArtifacts[].defaultArtifact.customKind`              | `boolean` |                                                                                                  |
| `input.pipeline.trigger.expectedArtifacts[].defaultArtifact.metadata.id`             | `string`  |                                                                                                  |
| `input.pipeline.trigger.expectedArtifacts[].defaultArtifact.name`                    | `string`  |                                                                                                  |
| `input.pipeline.trigger.expectedArtifacts[].defaultArtifact.reference`               | `string`  |                                                                                                  |
| `input.pipeline.trigger.expectedArtifacts[].defaultArtifact.type`                    | `string`  |                                                                                                  |
| `input.pipeline.trigger.expectedArtifacts[].defaultArtifact.version`                 | `string`  |                                                                                                  |
| `input.pipeline.trigger.expectedArtifacts[].id`                                      | `string`  |                                                                                                  |
| `input.pipeline.trigger.expectedArtifacts[].matchArtifact.artifactAccount`           | `string`  |                                                                                                  |
| `input.pipeline.trigger.expectedArtifacts[].matchArtifact.customKind`                | `boolean` |                                                                                                  |
| `input.pipeline.trigger.expectedArtifacts[].matchArtifact.metadata.id`               | `string`  |                                                                                                  |
| `input.pipeline.trigger.expectedArtifacts[].matchArtifact.name`                      | `string`  |                                                                                                  |
| `input.pipeline.trigger.expectedArtifacts[].matchArtifact.type`                      | `string`  |                                                                                                  |
| `input.pipeline.trigger.expectedArtifacts[].useDefaultArtifact`                      | `boolean` |                                                                                                  |
| `input.pipeline.trigger.expectedArtifacts[].usePriorArtifact`                        | `boolean` |                                                                                                  |
| `input.pipeline.trigger.parameters.<parameterName>`                                     | `string`  |  The value that was specified for the parameter when triggering the pipeline.                                                                                                |
| `input.pipeline.trigger.preferred`                                                   | `boolean` |                                                                                                  |
| `input.pipeline.trigger.rebake`                                                      | `boolean` |                                                                                                  |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.artifactAccount`   | `string`  |                                                                                                  |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.customKind`        | `boolean` |                                                                                                  |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.metadata.id`       | `string`  |                                                                                                  |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.name`              | `string`  |                                                                                                  |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.reference`         | `string`  |                                                                                                  |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.type`              | `string`  |                                                                                                  |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.version`           | `string`  |                                                                                                  |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.artifactAccount` | `string`  |                                                                                                  |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.customKind`      | `boolean` |                                                                                                  |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.metadata.id`     | `string`  |                                                                                                  |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.name`            | `string`  |                                                                                                  |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.reference`       | `string`  |                                                                                                  |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.type`            | `string`  |                                                                                                  |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.version`         | `string`  |                                                                                                  |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].id`                              | `string`  |                                                                                                  |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.artifactAccount`   | `string`  |                                                                                                  |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.customKind`        | `boolean` |                                                                                                  |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.metadata.id`       | `string`  |                                                                                                  |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.name`              | `string`  |                                                                                                  |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.type`              | `string`  |                                                                                                  |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].useDefaultArtifact`              | `boolean` |                                                                                                  |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].usePriorArtifact`                | `boolean` |                                                                                                  |
| `input.pipeline.trigger.type`                                                        | `string`  |  What is the type of trigger                                                                                                |
| `input.pipeline.trigger.user`                                                        | `string`  | for triuggers of type 'git' what is the user or organization associated with the git repository. |
| `input.pipeline.triggers[].branch`                                                   | `string`  | what branch of the git repository triggers this pipeline                                         |
| `input.pipeline.triggers[].dryRun`                                                   | `boolean` |                                                                                                  |
| `input.pipeline.triggers[].enabled`                                                  | `boolean` | is the trigger enabled.                                                                          |
| `input.pipeline.triggers[].expectedArtifactIds[]`                                    | `string`  |                                                                                                  |
| `input.pipeline.triggers[].id`                                                       | `string`  |                                                                                                  |
| `input.pipeline.triggers[].preferred`                                                | `boolean` |                                                                                                  |
| `input.pipeline.triggers[].project`                                                  | `string`  |   a change in what project will trigger this pipeline                                                                                               |
| `input.pipeline.triggers[].rebake`                                                   | `boolean` |   should all baked artifacts be rebaked even if their inputs have not changed.                                                                                               |
| `input.pipeline.triggers[].secret`                                                   | `string`  |   the secret that the trigger uses to authenticate with spinnaker                                                                                               |
| `input.pipeline.triggers[].slug`                                                     | `string`  |   the triggers slug, for example with a github trigger this will be the project name.                                                                                               |
| `input.pipeline.triggers[].source`                                                   | `string`  | the type of the source for the trigger                                                                                                 |
| `input.pipeline.triggers[].type`                                                     | `string`  | the configured type of the trigger                                                                                                 |

### `input.user`

This object provides information about the user performing the action. This can be used to restrict actions by role. See [input.user]({{< ref "input.user.md" >}}) for more information.
