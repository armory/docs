---
title: "opa.pipelines"
linkTitle: "opa.pipelines"
description: "Package that supports pipeline analysis when pipelines are saved."
weight: 10
---

## Example Payload

<details><summary>Click to expand</summary>

```json
{
  "input": {
    "pipeline": {
      "application": "hostname",
      "expectedArtifacts": [
        {
          "defaultArtifact": {
            "artifactAccount": "myUsername",
            "id": "4aa85178-0618-46c4-b530-6883d393656d",
            "name": "manifests/deploy-spinnaker.yaml",
            "reference": "Https://api.github.com/repos/myUsername/hostname/contents/manifests/deploy-spinnaker.yaml",
            "type": "github/file",
            "version": "master"
          },
          "displayName": "hostname-deploy",
          "id": "0cf98032-1b0f-48db-9314-09c69293b3a6",
          "matchArtifact": {
            "artifactAccount": "myUsername",
            "customKind": true,
            "id": "3f72ed8e-cb95-454f-9119-2323682121ff",
            "name": "manifests/deploy-spinnaker.yaml",
            "type": "github/file"
          },
          "useDefaultArtifact": true,
          "usePriorArtifact": false
        },
        {
          "defaultArtifact": {
            "artifactAccount": "myUsername",
            "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef",
            "name": "manifests/service-spinnaker.yaml",
            "reference": "Https://api.github.com/repos/myUsername/hostname/contents/manifests/service-spinnaker.yaml",
            "type": "github/file"
          },
          "displayName": "service-hostname",
          "id": "425d20a8-2942-4902-8d2b-277769a1492c",
          "matchArtifact": {
            "artifactAccount": "myUsername",
            "customKind": true,
            "id": "d7ac7eca-0131-4d54-ab8f-880ff0041e4f",
            "name": "manifests/service-spinnaker",
            "type": "github/file"
          },
          "useDefaultArtifact": true,
          "usePriorArtifact": false
        }
      ],
      "id": "7db1e350-dedb-4dc1-9976-e71f97b5f132",
      "index": 0,
      "keepWaitingPipelines": false,
      "lastModifiedBy": "myUsername",
      "limitConcurrent": true,
      "name": "scale deployments",
      "parameterConfig": [
        {
          "default": "",
          "description": "",
          "hasOptions": false,
          "label": "",
          "name": "replicas",
          "options": [
            {
              "value": ""
            }
          ],
          "pinned": false,
          "required": false
        },
        {
          "default": "staging",
          "description": "",
          "hasOptions": false,
          "label": "",
          "name": "namespace",
          "options": [
            {
              "value": ""
            }
          ],
          "pinned": false,
          "required": true
        }
      ],
      "spelEvaluator": "v4",
      "stages": [
        {
          "account": "spinnaker",
          "cloudProvider": "kubernetes",
          "manifestArtifactId": "0cf98032-1b0f-48db-9314-09c69293b3a6",
          "moniker": {
            "app": "hostname"
          },
          "name": "Deploy (Manifest) g",
          "refId": "2",
          "requisiteStageRefIds": [],
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
          "account": "spinnaker",
          "cloudProvider": "kubernetes",
          "manifestArtifactId": "425d20a8-2942-4902-8d2b-277769a1492c",
          "moniker": {
            "app": "hostname"
          },
          "name": "Deploy service (Manifest)",
          "refId": "3",
          "requisiteStageRefIds": [],
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
          "completeOtherBranchesThenFail": false,
          "continuePipeline": true,
          "failPipeline": false,
          "instructions": "is the new service working?",
          "judgmentInputs": [],
          "name": "Manual Judgment",
          "notifications": [],
          "refId": "4",
          "requisiteStageRefIds": [
            "2",
            "3"
          ],
          "stageTimeoutMs": 60000,
          "type": "manualJudgment"
        },
        {
          "account": "spinnaker",
          "app": "hostname",
          "cloudProvider": "kubernetes",
          "location": "staging",
          "manifestName": "deployment hostname",
          "mode": "static",
          "name": "Scale (Manifest)",
          "refId": "5",
          "replicas": "10",
          "requisiteStageRefIds": [
            "4"
          ],
          "type": "scaleManifest"
        }
      ],
      "triggers": [
        {
          "branch": "master",
          "enabled": true,
          "expectedArtifactIds": [
            "0cf98032-1b0f-48db-9314-09c69293b3a6",
            "425d20a8-2942-4902-8d2b-277769a1492c"
          ],
          "project": "myUsername",
          "secret": "spinnaker",
          "slug": "hostname",
          "source": "github",
          "type": "git"
        }
      ],
      "updateTs": "1620677311000"
    }
  }
}
```
</details>

## Example Policy

```rego
package opa.pipelines
production_accounts := ["prod1","prod2"]
deny["deploy stage must follow a manual judgement stage for production accounts"] {
  some j
  input.pipeline.stages[j].type=="deployManifest"
  input.pipeline.stages[j].account==production_accounts[_]
  approvers := [i | input.pipeline.stages[i].type=="manualJudgment"; i<j]
  count(approvers)==0
}
```

## Keys

| Key                                                               | Type       | Description                                                                                                                                 |
| :---------------------------------------------------------------- | :--------- | :------------------------------------------------------------------------------------------------------------------------------------------ |
| `input.pipeline.application`                                      | `string`   | The name of the Spinnaker application to which this pipeline belongs.                                                                       |
| `input.pipeline.expectedArtifacts[]`                              | `[array]`  | See [artifacts]({{< ref "artifacts.md" >}}) for more information.                                                                           |
| `input.pipeline.id`                                               | `string`   |                                                                                                                                             |
| `input.pipeline.index`                                            | `number`   |                                                                                                                                             |
| `input.pipeline.keepWaitingPipelines`                             | `boolean`  |                                                                                                                                             |
| `input.pipeline.lastModifiedBy`                                   | `string`   | The id of the user that last modified the pipeline.                                                                                         |
| `input.pipeline.limitConcurrent`                                  | `boolean`  | True if only 1 concurrent execution of this pipeline be allowed.                                                                            |
| `input.pipeline.name`                                             | `string`   | The name of this pipeline.                                                                                                                  |
| `input.pipeline.parameterConfig[].default`                        | `string`   | The default value associated with this parameter.                                                                                           |
| `input.pipeline.parameterConfig[].description`                    | `string`   | (Optional): If supplied, will be displayed to users as a tooltip when triggering the pipeline manually. You can include HTML in this field. |
| `input.pipeline.parameterConfig[].hasOptions`                     | `boolean`  | If the ‘Show Options’ checkbox in the parameter checked                                                                                     |
| `input.pipeline.parameterConfig[].label`                          | `string`   | What is the display name of the parameter.                                                                                                  |
| `input.pipeline.parameterConfig[].name`                           | `string`   | What is the parameter name that can be used in SpEL.                                                                                        |
| `input.pipeline.parameterConfig[].options[].value`                | `string`   | What is the value for this option in a multi-option parameter.                                                                              |
| `input.pipeline.parameterConfig[].pinned`                         | `boolean`  | (Optional): if checked, this parameter will be always shown in a pipeline execution view, otherwise it’ll be collapsed by default.          |
| `input.pipeline.parameterConfig[].required`                       | `boolean`  | Is this a required parameter.                                                                                                               |
| `input.pipeline.spelEvaluator`                                    | `string`   | Which version of spring expression language is being used to evaluate SpEL.                                                                 |
| `input.pipeline.stages[].account`                                 | `string`   |                                                                                                                                             |
| `input.pipeline.stages[].app`                                     | `string`   |                                                                                                                                             |
| `input.pipeline.stages[].cloudProvider`                           | `string`   |                                                                                                                                             |
| `input.pipeline.stages[].completeOtherBranchesThenFail`           | `boolean`  |                                                                                                                                             |
| `input.pipeline.stages[].continuePipeline`                        | `boolean`  |                                                                                                                                             |
| `input.pipeline.stages[].failPipeline`                            | `boolean`  |                                                                                                                                             |
| `input.pipeline.stages[].instructions`                            | `string`   |                                                                                                                                             |
| `input.pipeline.stages[].location`                                | `string`   |                                                                                                                                             |
| `input.pipeline.stages[].manifestArtifactId`                      | `string`   |                                                                                                                                             |
| `input.pipeline.stages[].manifestName`                            | `string`   |                                                                                                                                             |
| `input.pipeline.stages[].mode`                                    | `string`   |                                                                                                                                             |
| `input.pipeline.stages[].moniker.app`                             | `string`   |                                                                                                                                             |
| `input.pipeline.stages[].name`                                    | `string`   |                                                                                                                                             |
| `input.pipeline.stages[].refId`                                   | `string`   |                                                                                                                                             |
| `input.pipeline.stages[].replicas`                                | `string`   |                                                                                                                                             |
| `input.pipeline.stages[].requisiteStageRefIds.[]`                 | `string`   |                                                                                                                                             |
| `input.pipeline.stages[].skipExpressionEvaluation`                | `boolean`  |                                                                                                                                             |
| `input.pipeline.stages[].source`                                  | `string`   |                                                                                                                                             |
| `input.pipeline.stages[].stageTimeoutMs`                          | `number`   |                                                                                                                                             |
| `input.pipeline.stages[].trafficManagement.enabled`               | `boolean`  |                                                                                                                                             |
| `input.pipeline.stages[].trafficManagement.options.enableTraffic` | `boolean`  |                                                                                                                                             |
| `input.pipeline.stages[].type`                                    | `string`   |                                                                                                                                             |
| `input.pipeline.triggers[].branch`                                | `string`   |                                                                                                                                             |
| `input.pipeline.triggers[].enabled`                               | `boolean`  |                                                                                                                                             |
| `input.pipeline.triggers[].expectedArtifactIds.[]`                | `string`   |                                                                                                                                             |
| `input.pipeline.triggers[].project`                               | `string`   |                                                                                                                                             |
| `input.pipeline.triggers[].secret`                                | `string`   |                                                                                                                                             |
| `input.pipeline.triggers[].slug`                                  | `string`   |                                                                                                                                             |
| `input.pipeline.triggers[].source`                                | `string`   |                                                                                                                                             |
| `input.pipeline.triggers[].type`                                  | `string`   |                                                                                                                                             |
| `input.pipeline.updateTs`                                         | `string`   | The timestamp of the pipelines last modification.                                                                                           |
