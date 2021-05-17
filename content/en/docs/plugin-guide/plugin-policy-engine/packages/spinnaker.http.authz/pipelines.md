---
title: "spinnaker.http.authz.pipelines"
linktitle: "pipelines"
description: "fill me with delicious data, Stephen!"
---


## Example Payload

<details><summary>Click to expand</summary>

```json
{
  "input": {
    "body": {
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
    },
    "method": "POST",
    "path": [
      "pipelines"
    ],
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

| Key                                                                  | Type      | Description |
| :------------------------------------------------------------------- | --------- | ----------- |
| `input.body.application`                                             | `string`  |             |
| `input.body.expectedArtifacts[].defaultArtifact.artifactAccount`     | `string`  |             |
| `input.body.expectedArtifacts[].defaultArtifact.id`                  | `string`  |             |
| `input.body.expectedArtifacts[].defaultArtifact.name`                | `string`  |             |
| `input.body.expectedArtifacts[].defaultArtifact.reference`           | `string`  |             |
| `input.body.expectedArtifacts[].defaultArtifact.type`                | `string`  |             |
| `input.body.expectedArtifacts[].defaultArtifact.version`             | `string`  |             |
| `input.body.expectedArtifacts[].displayName`                         | `string`  |             |
| `input.body.expectedArtifacts[].id`                                  | `string`  |             |
| `input.body.expectedArtifacts[].matchArtifact.artifactAccount`       | `string`  |             |
| `input.body.expectedArtifacts[].matchArtifact.customKind`            | `boolean` |             |
| `input.body.expectedArtifacts[].matchArtifact.id`                    | `string`  |             |
| `input.body.expectedArtifacts[].matchArtifact.name`                  | `string`  |             |
| `input.body.expectedArtifacts[].matchArtifact.type`                  | `string`  |             |
| `input.body.expectedArtifacts[].useDefaultArtifact`                  | `boolean` |             |
| `input.body.expectedArtifacts[].usePriorArtifact`                    | `boolean` |             |
| `input.body.id`                                                      | `string`  |             |
| `input.body.index`                                                   | `number`  |             |
| `input.body.keepWaitingPipelines`                                    | `boolean` |             |
| `input.body.lastModifiedBy`                                          | `string`  |             |
| `input.body.limitConcurrent`                                         | `boolean` |             |
| `input.body.name`                                                    | `string`  |             |
| `input.body.parameterConfig[].default`                               | `string`  |             |
| `input.body.parameterConfig[].description`                           | `string`  |             |
| `input.body.parameterConfig[].hasOptions`                            | `boolean` |             |
| `input.body.parameterConfig[].label`                                 | `string`  |             |
| `input.body.parameterConfig[].name`                                  | `string`  |             |
| `input.body.parameterConfig[].options[].value`                       | `string`  |             |
| `input.body.parameterConfig[].pinned`                                | `boolean` |             |
| `input.body.parameterConfig[].required`                              | `boolean` |             |
| `input.body.spelEvaluator`                                           | `string`  |             |
| `input.body.stages[].account`                                        | `string`  |             |
| `input.body.stages[].app`                                            | `string`  |             |
| `input.body.stages[].cloudProvider`                                  | `string`  |             |
| `input.body.stages[].completeOtherBranchesThenFail`                  | `boolean` |             |
| `input.body.stages[].continuePipeline`                               | `boolean` |             |
| `input.body.stages[].failPipeline`                                   | `boolean` |             |
| `input.body.stages[].instructions`                                   | `string`  |             |
| `input.body.stages[].location`                                       | `string`  |             |
| `input.body.stages[].manifestArtifactId`                             | `string`  |             |
| `input.body.stages[].manifestName`                                   | `string`  |             |
| `input.body.stages[].mode`                                           | `string`  |             |
| `input.body.stages[].moniker.app`                                    | `string`  |             |
| `input.body.stages[].name`                                           | `string`  |             |
| `input.body.stages[].refId`                                          | `string`  |             |
| `input.body.stages[].replicas`                                       | `string`  |             |
| `input.body.stages[].requisiteStageRefIds[]`                         | `string`  |             |
| `input.body.stages[].skipExpressionEvaluation`                       | `boolean` |             |
| `input.body.stages[].source`                                         | `string`  |             |
| `input.body.stages[].stageTimeoutMs`                                 | `number`  |             |
| `input.body.stages[].trafficManagement.enabled`                      | `boolean` |             |
| `input.body.stages[].trafficManagement.options.enableTraffic`        | `boolean` |             |
| `input.body.stages[].type`                                           | `string`  |             |
| `input.body.triggers[].branch`                                       | `string`  |             |
| `input.body.triggers[].enabled`                                      | `boolean` |             |
| `input.body.triggers[].expectedArtifactIds[]`                        | `string`  |             |
| `input.body.triggers[].project`                                      | `string`  |             |
| `input.body.triggers[].secret`                                       | `string`  |             |
| `input.body.triggers[].slug`                                         | `string`  |             |
| `input.body.triggers[].source`                                       | `string`  |             |
| `input.body.triggers[].type`                                         | `string`  |             |
| `input.body.updateTs`                                                | `string`  |             |
| `input.method`                                                       | `string`  |             |
| `input.path[]`                                                       | `string`  |             |
| `input.user.isAdmin`                                                 | `boolean` |             |
| `input.user.username`                                                | `string`  |             |
| `input.body.stages[].baseAmi`                                        | `string`  |             |
| `input.body.stages[].baseLabel`                                      | `string`  |             |
| `input.body.stages[].baseOs`                                         | `string`  |             |
| `input.body.stages[].cloudProviderType`                              | `string`  |             |
| `input.body.stages[].clusters[].account`                             | `string`  |             |
| `input.body.stages[].clusters[].application`                         | `string`  |             |
| `input.body.stages[].clusters[].availabilityZones.us-east-2[]`       | `string`  |             |
| `input.body.stages[].clusters[].capacity.desired`                    | `number`  |             |
| `input.body.stages[].clusters[].capacity.max`                        | `number`  |             |
| `input.body.stages[].clusters[].capacity.min`                        | `number`  |             |
| `input.body.stages[].clusters[].cloudProvider`                       | `string`  |             |
| `input.body.stages[].clusters[].cooldown`                            | `number`  |             |
| `input.body.stages[].clusters[].copySourceCustomBlockDeviceMappings` | `boolean` |             |
| `input.body.stages[].clusters[].delayBeforeDisableSec`               | `number`  |             |
| `input.body.stages[].clusters[].delayBeforeScaleDownSec`             | `number`  |             |
| `input.body.stages[].clusters[].ebsOptimized`                        | `boolean` |             |
| `input.body.stages[].clusters[].freeFormDetails`                     | `string`  |             |
| `input.body.stages[].clusters[].healthCheckGracePeriod`              | `number`  |             |
| `input.body.stages[].clusters[].healthCheckType`                     | `string`  |             |
| `input.body.stages[].clusters[].iamRole`                             | `string`  |             |
| `input.body.stages[].clusters[].instanceMonitoring`                  | `boolean` |             |
| `input.body.stages[].clusters[].instanceType`                        | `string`  |             |
| `input.body.stages[].clusters[].keyPair`                             | `string`  |             |
| `input.body.stages[].clusters[].maxRemainingAsgs`                    | `number`  |             |
| `input.body.stages[].clusters[].provider`                            | `string`  |             |
| `input.body.stages[].clusters[].rollback.onFailure`                  | `boolean` |             |
| `input.body.stages[].clusters[].scaleDown`                           | `boolean` |             |
| `input.body.stages[].clusters[].spotPrice`                           | `string`  |             |
| `input.body.stages[].clusters[].stack`                               | `string`  |             |
| `input.body.stages[].clusters[].strategy`                            | `string`  |             |
| `input.body.stages[].clusters[].subnetType`                          | `string`  |             |
| `input.body.stages[].clusters[].tags.Name`                           | `string`  |             |
| `input.body.stages[].clusters[].targetHealthyDeployPercentage`       | `number`  |             |
| `input.body.stages[].clusters[].terminationPolicies[]`               | `string`  |             |
| `input.body.stages[].clusters[].useAmiBlockDeviceMappings`           | `boolean` |             |
| `input.body.stages[].region`                                         | `string`  |             |
| `input.body.stages[].regions[]`                                      | `string`  |             |
| `input.body.stages[].storeType`                                      | `string`  |             |
| `input.body.stages[].user`                                           | `string`  |             |
| `input.body.stages[].vmType`                                         | `string`  |             |
