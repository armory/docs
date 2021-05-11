---
title: "opa.pipelines"
linkTitle: "opa.pipelines"
description: "This is a description"
weight: 10
---

## Example Payload

```json
{
  "input": {
    "pipeline": {
      "application": "hostname",
      "expectedArtifacts": [
        {
          "defaultArtifact": {
            "artifactAccount": "stephenatwell",
            "id": "4aa85178-0618-46c4-b530-6883d393656d",
            "name": "manifests/deploy-spinnaker.yaml",
            "reference": "Https://api.github.com/repos/stephenatwell/hostname/contents/manifests/deploy-spinnaker.yaml",
            "type": "github/file",
            "version": "master"
          },
          "displayName": "hostname-deploy",
          "id": "0cf98032-1b0f-48db-9314-09c69293b3a6",
          "matchArtifact": {
            "artifactAccount": "stephenatwell",
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
            "artifactAccount": "stephenatwell",
            "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef",
            "name": "manifests/service-spinnaker.yaml",
            "reference": "Https://api.github.com/repos/stephenatwell/hostname/contents/manifests/service-spinnaker.yaml",
            "type": "github/file"
          },
          "displayName": "service-hostname",
          "id": "425d20a8-2942-4902-8d2b-277769a1492c",
          "matchArtifact": {
            "artifactAccount": "stephenatwell",
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
      "lastModifiedBy": "stephenatwell",
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
          "project": "stephenatwell",
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

## Example Policy

```rego
package opa.pipelines
production_accounts := ["prod1","prod2"]
deny["deploy stage must immediately follow a manual judgement stage"] {
  some j
  input.pipeline.stages[j].type=="deployManifest"
  input.pipeline.stages[j].account==production_accounts[_]
  approvers := [i | input.pipeline.stages[i].type=="manualJudgment"; i<j]
  count(approvers)==0
}
```

## Keys

### `pipeline`

| Key                                                          | Type    | Description                                              |
|--------------------------------------------------------------|---------|----------------------------------------------------------|
| `pipeline.application`                                       | string  | The name of the Spinnaker application to which this pipeline belongs. |
| `pipeline.id`                                                | string  |
| `pipeline.index`                                             | number  |
| `pipeline.keepWaitingPipelines`                              | boolean |
| `pipeline.lastModifiedBy`                                    | string  | The id of the user that last modified the pipeline. |
| `pipeline.limitConcurrent`                                   | boolean | True if only 1 concurrent execution of this pipeline be allowed. |
| `pipeline.name`                                              | string  | The name of this pipeline
| `pipeline.parameterConfig[].default`                         | string  | the default value associated with this parameter
| `pipeline.parameterConfig[].description`                     | string  | (Optional): if supplied, will be displayed to users as a tooltip when triggering the pipeline manually. You can include HTML in this field.
| `pipeline.parameterConfig[].hasOptions`                      | boolean | if the 'Show Options' checkbox in the parameter checked
| `pipeline.parameterConfig[].label`                           | string  | What is the display name of the parameter
| `pipeline.parameterConfig[].name`                            | string  | What is the parameter name that can be used in SpEL
| `pipeline.parameterConfig[].options[].value`                 | string  | What is the value for this option in a multi-option parameter.
| `pipeline.parameterConfig[].pinned`                          | boolean | (Optional): if checked, this parameter will be always shown in a pipeline execution view, otherwise it'll be collapsed by default.
| `pipeline.parameterConfig[].required`                        | boolean | is this a required parameter.
| `pipeline.spelEvaluator`                                     | string  | which version of spring expression language is being used to evaluate SpEL.
| `pipeline.updateTs`                                          | date    | The timestamp of the pipelines last modification.

### `pipeline.expectedArtifacts`

| Key                                                          | Type    | Description                                              |
|--------------------------------------------------------------|---------|----------------------------------------------------------|
| `pipeline.expectedArtifacts[].defaultArtifact.artifactAccount` | string  | what account should the artifact be read from.
| `pipeline.expectedArtifacts[].defaultArtifact.id`              | string  | The unique ID of the artifact.
| `pipeline.expectedArtifacts[].defaultArtifact.name`            | string  | the name/path of the artifact
| `pipeline.expectedArtifacts[].defaultArtifact.reference`       | string  | 
| `pipeline.expectedArtifacts[].defaultArtifact.type`            | string  |
| `pipeline.expectedArtifacts[].defaultArtifact.version`         | string  |
| `pipeline.expectedArtifacts[].displayName`                     | string  |
| `pipeline.expectedArtifacts[].id`                              | string  |
| `pipeline.expectedArtifacts[].matchArtifact.artifactAccount`   | string  |
| `pipeline.expectedArtifacts[].matchArtifact.customKind`        | boolean |
| `pipeline.expectedArtifacts[].matchArtifact.id`                | string  |
| `pipeline.expectedArtifacts[].matchArtifact.name`              | string  |
| `pipeline.expectedArtifacts[].matchArtifact.type`              | string  |
| `pipeline.expectedArtifacts[].useDefaultArtifact`              | boolean |
| `pipeline.expectedArtifacts[].usePriorArtifact`                | boolean |

### `pipeline.stages`

| Key                                                          | Type    | Description                                              |
|--------------------------------------------------------------|---------|----------------------------------------------------------|
| `pipeline.stages.account`                                    | string  |
| `pipeline.stages.app`                                        | string  |
| `pipeline.stages.cloudProvider`                              | string  |
| `pipeline.stages.completeOtherBranchesThenFail`              | boolean |
| `pipeline.stages.continuePipeline`                           | boolean |
| `pipeline.stages.failPipeline`                               | boolean |
| `pipeline.stages.instructions`                               | string  |
| `pipeline.stages.judgmentInputs`                             | array   |
| `pipeline.stages.location`                                   | string  |
| `pipeline.stages.manifestArtifactId`                         | string  |
| `pipeline.stages.manifestName`                               | string  |
| `pipeline.stages.mode`                                       | string  |
| `pipeline.stages.moniker.app`                                | string  |
| `pipeline.stages.name`                                       | string  |
| `pipeline.stages.refdId`                                     | string  |
| `pipeline.stages.requisiteStageRefIds`                       | array   |
| `pipeline.stages.skipExpressionEvaluation`                   | boolean |
| `pipeline.stages.stageTimeoutMs`                             | number  |
| `pipeline.stages.source`                                     | string  |
| `pipeline.stages.trafficManagement.enabled`                  | boolean |
| `pipeline.stages.trafficManagement.options.enableTraffic`    | boolean |
| `pipeline.stages.trafficManagement.options.services`         | array   |
| `pipeline.stages.type`                                       | string  |

### `pipeline.triggers`

| Key                                                          | Type    | Description                                              |
|--------------------------------------------------------------|---------|----------------------------------------------------------|
| `pipeline.triggers.branch`                                   | string  |
| `pipeline.triggers.enabled`                                  | boolean |
| `pipeline.triggers.expectedArtifactIds`                      | array   |
| `pipeline.triggers.project`                                  | string  |
| `pipeline.triggers.secret`                                   | string  |
| `pipeline.triggers.slug`                                     | string  |
| `pipeline.triggers.source`                                   | string  |
| `pipeline.triggers.type`                                     | string  |
