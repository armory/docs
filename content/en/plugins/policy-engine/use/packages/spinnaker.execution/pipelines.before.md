---
title: "spinnaker.execution.pipelines.before"
linktitle: "pipelines.before"
description: "Policy that is evaluated when a pipeline starts executing, but before any stages attempt to run."
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

### input.pipeline

| Key                                                | Type       | Description                                                                                                                                                          |
| -------------------------------------------------- | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `input.pipeline.application`                       | `string`   | The name of the Spinnaker application to which this pipeline belongs.                                                                                                |
| `input.pipeline.disabled`                          | `boolean`  | True if execution of this pipeline is disabled.                                                                                                                      |
| `input.pipeline.executionId`                       | `string`   | The unique ID of the execution                                                                                                                                       |
| `input.pipeline.expectedArtifacts[]`               | `{object}` | See [artifacts]({{< ref "artifacts.md" >}}) for more information.                                                                                                    |
| `input.pipeline.id`                                | `string`   | The unique ID of the pipeline.                                                                                                                                       |
| `input.pipeline.keepWaitingPipelines`              | `boolean`  | If false and concurrent pipeline execution is disabled, then the pipelines in the waiting queue get canceled when the next execution starts.                         |
| `input.pipeline.limitConcurrent`                   | `boolean`  | Disable concurrent pipeline executions (only run one at a time).                                                                                                     |
| `input.pipeline.name`                              | `string`   | The name of the pipeline.                                                                                                                                            |
| `input.pipeline.parallel`                          | `boolean`  |                                                                                                                                                                      |
| `input.pipeline.parameterConfig[].default`         | `string`   | The default value associated with this parameter.                                                                                                                    |
| `input.pipeline.parameterConfig[].description`     | `string`   | if supplied, is displayed to users as a tooltip when triggering the pipeline manually. You can include HTML in this field.                                           |
| `input.pipeline.parameterConfig[].hasOptions`      | `boolean`  | True if the **Show Options** checkbox in the parameter is checked.                                                                                                   |
| `input.pipeline.parameterConfig[].label`           | `string`   | A label to display when users are triggering the pipeline manually.                                                                                                  |
| `input.pipeline.parameterConfig[].name`            | `string`   | The name of the parameter.                                                                                                                                           |
| `input.pipeline.parameterConfig[].options[].value` | `string`   | What values exist in a picklist for the user to choose from for the parameter.                                                                                       |
| `input.pipeline.parameterConfig[].pinned`          | `boolean`  | If checked, this parameter is always shown in a pipeline execution view, otherwise it's collapsed by default.                                                        |
| `input.pipeline.parameterConfig[].required`        | `boolean`  | If true, the user must provide a value for this parameter when executing the pipeline.                                                                               |
| `input.pipeline.plan`                              | `boolean`  |                                                                                                                                                                      |
| `input.pipeline.respectQuietPeriod`                | `boolean`  |                                                                                                                                                                      |
| `input.pipeline.spelEvaluator`                     | `string`   | Which version of SpEL should SpEL expressions be evaluated with.                                                                                                     |
| `input.pipeline.stages[]`                          | `[array]`  | An array of the stages in the pipeline. Typically if you are writing a policy that examines multiple pipeline stages, it is better to write that policy against either the `opa.pipelines package`, or the `spinnaker.execution.pipelines.before` package. |

### input.pipeline.trigger

See [input.pipeline.trigger]({{< ref "input.pipeline.trigger.md" >}}) for more information.

### input.user

This object provides information about the user performing the action. This can be used to restrict actions by role. See [input.user]({{< ref "input.user.md" >}}) for more information.
