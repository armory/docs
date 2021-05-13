---
title: "opa.pipelines"
linkTitle: "opa.pipelines"
description: "Package that supports pipeline analysis when pipelines are saved"
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
            "artifactAccount": "myUserName",
            "id": "4aa85178-0618-46c4-b530-6883d393656d",
            "name": "manifests/deploy-spinnaker.yaml",
            "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
            "type": "github/file",
            "version": "master"
          },
          "displayName": "hostname-deploy",
          "id": "0cf98032-1b0f-48db-9314-09c69293b3a6",
          "matchArtifact": {
            "artifactAccount": "myUserName",
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
            "artifactAccount": "myUserName",
            "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef",
            "name": "manifests/service-spinnaker.yaml",
            "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/service-spinnaker.yaml",
            "type": "github/file"
          },
          "displayName": "service-hostname",
          "id": "425d20a8-2942-4902-8d2b-277769a1492c",
          "matchArtifact": {
            "artifactAccount": "myUserName",
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
      "lastModifiedBy": "myUserName",
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
          "project": "myUserName",
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

| Key                                          | Type      | Description                                              |
|----------------------------------------------|-----------|----------------------------------------------------------|
| `pipeline.application`                       | `string`  | The name of the Spinnaker application to which this pipeline belongs. |
| `pipeline.id`                                | `string`  |  |
| `pipeline.index`                             | `num`     |  |
| `pipeline.keepWaitingPipelines`              | `boolean` |  |
| `pipeline.lastModifiedBy`                    | `string`  | The id of the user that last modified the pipeline. |
| `pipeline.limitConcurrent`                   | `boolean` | True if only 1 concurrent execution of this pipeline be allowed. |
| `pipeline.name`                              | `string`  | The name of this pipeline. |
| `pipeline.parameterConfig[].default`         | `string`  | the default value associated with this parameter. |
| `pipeline.parameterConfig[].description`     | `string`  | (Optional): If supplied, will be displayed to users as a tooltip when triggering the pipeline manually. You can include HTML in this field. |
| `pipeline.parameterConfig[].hasOptions`      | `boolean` | If the 'Show Options' checkbox in the parameter checked |
| `pipeline.parameterConfig[].label`           | `string`  | What is the display name of the parameter. |
| `pipeline.parameterConfig[].name`            | `string`  | What is the parameter name that can be used in SpEL. |
| `pipeline.parameterConfig[].options[].value` | `string`  | What is the value for this option in a multi-option parameter. |
| `pipeline.parameterConfig[].pinned`          | `boolean` | (Optional): if checked, this parameter will be always shown in a pipeline execution view, otherwise it'll be collapsed by default. |
| `pipeline.parameterConfig[].required`        | `boolean` | Is this a required parameter. |
| `pipeline.spelEvaluator`                     | `string`  | Which version of spring expression language is being used to evaluate SpEL. |
| `pipeline.updateTs`                          | `date`    | The timestamp of the pipelines last modification. |

### `pipeline.expectedArtifacts`

| Key                                                            | Type    | Description                                              |
|----------------------------------------------------------------|---------|----------------------------------------------------------|
| `pipeline.expectedArtifacts[].defaultArtifact.artifactAccount` | `string`  | What account should the default artifact be read from. |
| `pipeline.expectedArtifacts[].defaultArtifact.id`              | `string`  | The unique ID of the artifact. |
| `pipeline.expectedArtifacts[].defaultArtifact.name`            | `string`  | The name/path of the artifact. |
| `pipeline.expectedArtifacts[].defaultArtifact.reference`       | `string`  | A full reference to the artifact, often a URL. |
| `pipeline.expectedArtifacts[].defaultArtifact.type`            | `string`  | What is the type of the artifact. For example, a github artifact will be 'github/file'. |
| `pipeline.expectedArtifacts[].defaultArtifact.version`         | `string`  | What version of the artifact should be used. For example, if the artifact is coming from a source control system this will be the branch name. |
| `pipeline.expectedArtifacts[].displayName`                     | `string`  | What name should be displayed to the user for the artifact. |
| `pipeline.expectedArtifacts[].id`                              | `string`  | A unique id for the artifact. |
| `pipeline.expectedArtifacts[].matchArtifact.artifactAccount`   | `string`  | What account should the match artifact be read from. |
| `pipeline.expectedArtifacts[].matchArtifact.customKind`        | `boolean` |  |
| `pipeline.expectedArtifacts[].matchArtifact.id`                | `string`  |  |
| `pipeline.expectedArtifacts[].matchArtifact.name`              | `string`  | The name/path of the artifact |
| `pipeline.expectedArtifacts[].matchArtifact.type`              | `string`  | What is the type of the artifact. For example, a github artifact will be `github/file`. |
| `pipeline.expectedArtifacts[].useDefaultArtifact`              | `boolean` | If your artifact either wasn't supplied from a trigger, or it wasn't found in a prior execution, the artifact specified below will end up in your pipeline's execution context. |
| `pipeline.expectedArtifacts[].usePriorArtifact`                | `boolean` | Attempt to match against an artifact in the prior pipeline execution's context. This ensures that you will always be using the most recently supplied artifact to this pipeline, and is generally a safe choice. |

### `pipeline.stages`

| Key                                                          | Type      | Description                                              |
|--------------------------------------------------------------|-----------|----------------------------------------------------------|
| `pipeline.stages.account`                                    | `string`  | A Spinnaker account corresponds to a physical Kubernetes cluster or cloud provider account. |
| `pipeline.stages[].app`                                      | `string`  | Available in some stages, the name of the spinnaker application the stage refers to. |
| `pipeline.stages[].cloudProvider`                            | `string`  | The name of the stages cloud provider. kubernetes, aws, etc. |
| `pipeline.stages[].completeOtherBranchesThenFail`            | `boolean` | Prevents any stages that depend on this stage from running, but allows other branches of the pipeline to run. The pipeline will be marked as failed once complete if the stage fails. |
| `pipeline.stages[].continuePipeline`                         | `boolean` | Prevents any stages that depend on this stage from running, but allows other branches of the pipeline to run. The pipeline will be marked as failed once complete if the stage fails. |
| `pipeline.stages[].failPipeline`                             | `boolean` | Immediately halts execution of all running stages and fails the entire execution if the stage fails. |
| `pipeline.stages[].instructions`                             | `string`  | This field exists only for the 'manual judgement' stage, and specifies what message is displayed to the user. |
| `pipeline.stages[].judgmentInputs`                           | `[array]` | Entries populate a dropdown displayed when performing a manual judgment. |
| `pipeline.stages[].location`                                 | `string`  | Some stages store the 'namespace' that they affect in this property. |
| `pipeline.stages[].manifestArtifactId`                       | `string`  | Stage specific. The artifact that is to be applied to the Kubernetes account for this stage. The artifact should represent a valid Kubernetes manifest. |
| `pipeline.stages[].manifestName`                             | `string`  | Stage specific. The artifact name that is to be applied to the Kubernetes account for this stage. The artifact should represent a valid Kubernetes manifest. |
| `pipeline.stages[].mode`                                     | `string`  | |
| `pipeline.stages[].moniker.app`                              | `string`  | The name of the application associated with this application. |
| `pipeline.stages[].name`                                     | `string`  | The name of the pipeline stage. |
| `pipeline.stages[].refdId`                                   | `string`  | |
| `pipeline.stages[].requisiteStageRefIds`                     | `[array]` | |
| `pipeline.stages[].skipExpressionEvaluation`                 | `boolean` | Should SpEL expression evaluation be skipped. |
| `pipeline.stages[].stageTimeoutMs`                           | `num`     | After how long will the stage timeout in milliseconds. |
| `pipeline.stages[].source`                                   | `string`  | Certain stages use this to state what they are deploying. |
| `pipeline.stages[].trafficManagement.enabled`                | `boolean` | |
| `pipeline.stages[].trafficManagement.options.enableTraffic`  | `boolean` | |
| `pipeline.stages[].trafficManagement.options.services`       | `[array]` | |
| `pipeline.stages[].type`                                     | `string`  | what type of spinnaker stage is this.

### `pipeline.triggers`

| Key                                                          | Type    | Description                                              |
|--------------------------------------------------------------|---------|----------------------------------------------------------|
| `pipeline.triggers.branch`                                   | `string`  | what branch should be watched for changes to trigger this pipeline
| `pipeline.triggers.enabled`                                  | `boolean` | is this trigger enabled
| `pipeline.triggers.expectedArtifactIds`                      | `[array]`   | the IDs of any artifacts that this trigger provides.
| `pipeline.triggers.project`                                  | `string`  | the project in the trigger.
| `pipeline.triggers.secret`                                   | `string`  | If specified, verifies the trigger source is correct. Only supported by some triggers.
| `pipeline.triggers.slug`                                     | `string`  | what is the name of the trigger's project.
| `pipeline.triggers.source`                                   | `string`  | what is the source system for the trigger.
| `pipeline.triggers.type`                                     | `string`  | what type of trigger is this.
