---
title: "Pipelines"
linktitle: "Pipelines"
description: "Controls access to the spinnaker pipelines api. Can be used to prevent a user from creating a pipeline. Many usecases for this API call are better authored against the opa.pipelines package."
---
- **Path:** pipelines
- **Method:** Post
- **Package:** `spinnaker.http.authz`

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
    },
    "method": "POST",
    "path": [
      "pipelines"
    ],
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

{{< prism lang="rego" line-numbers="true" >}}

package spinnaker.http.authz
default message=""
allow=message==""

message="Only admins can save pipelines"{
    input.path[0]!="pipelines"
    input.method="POST"
    input.user.isAdmin!=true
}

{{< /prism >}}

## Keys

### input

| Key            | Type     | Description |
| :------------- | -------- | ----------- |
| `input.method` | `string` | Post            |
| `input.path[]` | `string` | `["pipelines"]`            |

### input.body

| Key                                            | Type      | Description                                                       |
| :--------------------------------------------- | --------- | ----------------------------------------------------------------- |
| `input.body.application`                       | `string`  | The application for which a pipeline is being saved.              |
| `input.body.expectedArtifacts[]`               | `array`   | See [artifacts]({{< ref "artifacts.md" >}}) for more information. |
| `input.body.id`                                | `string`  | The unique ID of the pipeline.                                    |
| `input.body.index`                             | `number`  |                                                                   |
| `input.body.keepWaitingPipelines`              | `boolean` |                                                                   |
| `input.body.lastModifiedBy`                    | `string`  | The id of the last user that modified the pipeline, should match the user in the input.users field.                                            |
| `input.body.limitConcurrent`                   | `boolean` |                                                                   |
| `input.body.name`                              | `string`  |                                                                   |
| `input.body.parameterConfig[].default`         | `string`  |                                                                   |
| `input.body.parameterConfig[].description`     | `string`  |                                                                   |
| `input.body.parameterConfig[].hasOptions`      | `boolean` |                                                                   |
| `input.body.parameterConfig[].label`           | `string`  |                                                                   |
| `input.body.parameterConfig[].name`            | `string`  |                                                                   |
| `input.body.parameterConfig[].options[].value` | `string`  |                                                                   |
| `input.body.parameterConfig[].pinned`          | `boolean` |                                                                   |
| `input.body.parameterConfig[].required`        | `boolean` |                                                                   |
| `input.body.spelEvaluator`                     | `string`  |                                                                   |
| `input.body.updateTs`                          | `string`  |                                                                   |

### input.body.stages
These fields are all stage specific, and may or may not be present depending on the stage type.

| Key                                                                  | Type      | Description |
| :------------------------------------------------------------------- | --------- | ----------- |
| `input.body.stages[].account`                                        | `string`  | The account to which the stage deploys. Applies to the following stage types: deployManifest, scaleManifest,deploy            |
| `input.body.stages[].app`                                            | `string`  | The name of the application being deployed. Use input.body.application instead. Applies to the following stage types: deployManifest, scaleManifest            |
| `input.body.stages[].baseAmi`                                        | `string`  | Only available for the 'bake' stage. If Base AMI is specified, this will be used instead of the Base OS provided            |
| `input.body.stages[].baseLabel`                                      | `string`  | Only available for the 'bake' stage. either 'release','candidate','previous' or 'unstable'            |
| `input.body.stages[].baseOs`                                         | `string`  | Only available for the 'bake' stage. What OS should be used to identify a base ami if none is specified.            |
| `input.body.stages[].cloudProviderType`                              | `string`  | Only available for the 'bake' stage. What cloud provider type is being used.            |
| `input.body.stages[].cloudProvider`                                  | `string`  | Which specific cloud provider is being used. Applies to the following stage types: deployManifest, scaleManifest,deploy            |
| `input.body.stages[].clusters[].account`                             | `string`  | Only available on the 'deploy' stage. This is the cluster to which the stage will deploy            |
| `input.body.stages[].clusters[].application`                         | `string`  | Only available on the 'deploy' stage. This is the application being deployed            |
| `input.body.stages[].clusters[].availabilityZones.<Region>[]`       | `string`  | Only available on the 'deploy' stage, specified what availability zones should be deployed to.            |
| `input.body.stages[].clusters[].capacity.desired`                    | `number`  | Only available on the 'deploy' stage. The desired number of instances in the autoscaling group.            |
| `input.body.stages[].clusters[].capacity.max`                        | `number`  | Only available on the 'deploy' stage. The maximum number of instances in the autoscaling group.            |
| `input.body.stages[].clusters[].capacity.min`                        | `number`  | Only available on the 'deploy' stage. The minimum number of instances in the autoscaling group.            |
| `input.body.stages[].clusters[].cloudProvider`                       | `string`  | Only available on the 'deploy' stage. Which cloud provider is being used.            |
| `input.body.stages[].clusters[].cooldown`                            | `number`  | Only available on the 'deploy' stage. A scaling cooldown helps you prevent your Auto Scaling group from launching or terminating additional instances before the effects of previous activities are visible.             |
| `input.body.stages[].clusters[].copySourceCustomBlockDeviceMappings` | `boolean` | Only available on the 'deploy' stage. If true Spinnaker will use the block device mappings of the existing server group when deploying a new server group.            |
| `input.body.stages[].clusters[].delayBeforeDisableSec`               | `number`  | Only available on the 'deploy' stage.             |
| `input.body.stages[].clusters[].delayBeforeScaleDownSec`             | `number`  | Only available on the 'deploy' stage.             |
| `input.body.stages[].clusters[].ebsOptimized`                        | `boolean` | Only available on the 'deploy' stage. Are instances optomized for EBS           |
| `input.body.stages[].clusters[].freeFormDetails`                     | `string`  | Only available on the 'deploy' stage. a string of free-form alphanumeric characters and hyphens to describe any other variables in naming a cluster.            |
| `input.body.stages[].clusters[].healthCheckGracePeriod`              | `number`  | Only available on the 'deploy' stage. When an instance launches, Amazon EC2 Auto Scaling uses the value of the HealthCheckGracePeriod for the Auto Scaling group to determine how long to wait before checking the health status of the instance.            |
| `input.body.stages[].clusters[].healthCheckType`                     | `string`  | Only available on the 'deploy' stage. Either 'ELB' or 'EC2'            |
| `input.body.stages[].clusters[].iamRole`                             | `string`  | Only available on the 'deploy' stage. What role is being used to run the instances            |
| `input.body.stages[].clusters[].instanceMonitoring`                  | `boolean` | Only available on the 'deploy' stage. whether to enable detailed monitoring of instances.             |
| `input.body.stages[].clusters[].instanceType`                        | `string`  | Only available on the 'deploy' stage. The type of instances to which to deploy.            |
| `input.body.stages[].clusters[].keyPair`                             | `string`  | Only available on the 'deploy' stage. The set of security credentials that can be used to connect to this instance.            |
| `input.body.stages[].clusters[].maxRemainingAsgs`                    | `number`  | Only available on the 'deploy' stage. How many auto scaling groups from prior deploys for this application should be left up and running once the new deploy is complete.            |
| `input.body.stages[].clusters[].provider`                            | `string`  | Only available on the 'deploy' stage. The cloud provider            |
| `input.body.stages[].clusters[].rollback.onFailure`                  | `boolean` | Only available on the 'deploy' stage. Should the deploy be automatically rolled back on failure.            |
| `input.body.stages[].clusters[].scaleDown`                           | `boolean` | Only available on the 'deploy' stage.             |
| `input.body.stages[].clusters[].spotPrice`                           | `string`  | Only available on the 'deploy' stage.             |
| `input.body.stages[].clusters[].stack`                               | `string`  | Only available on the 'deploy' stage.             |
| `input.body.stages[].clusters[].strategy`                            | `string`  | Only available on the 'deploy' stage. The deployment strategy tells Spinnaker what to do with the previous version of the server group.            |
| `input.body.stages[].clusters[].subnetType`                          | `string`  | Only available on the 'deploy' stage. The subnet selection determines the VPC in which your server group will run. Options vary by account and region; the most common ones are:

    None (EC2 Classic): instances will not run in a VPC
    internal instances will be restricted to internal clients (i.e. require VPN access)
    external instances will be publicly accessible and running in VPC
            |
| `input.body.stages[].clusters[].tags.Name`                           | `string`  | Only available on the 'deploy' stage. Tags are propagated to the instances in this cluster.           |
| `input.body.stages[].clusters[].targetHealthyDeployPercentage`       | `number`  | Only available on the 'deploy' stage.             |
| `input.body.stages[].clusters[].terminationPolicies[]`               | `string`  | Only available on the 'deploy' stage. The name of the policy to determine how old instances are terminated.            |
| `input.body.stages[].clusters[].useAmiBlockDeviceMappings`           | `boolean` | Only available on the 'deploy' stage. If true Spinnaker will use the block device mappings from the selected AMI when deploying a new server group.            |
| `input.body.stages[].completeOtherBranchesThenFail`                  | `boolean` | Prevents any stages that depend on this stage from running, but allows other branches of the pipeline to run. The pipeline will be marked as failed once complete. Available for all stages.             |
| `input.body.stages[].continuePipeline`                               | `boolean` | Continues execution of downstream stages, marking this stage as failed/continuing. Available for all stages.            |
| `input.body.stages[].failPipeline`                                   | `boolean` |              |
| `input.body.stages[].instructions`                                   | `string`  |             |
| `input.body.stages[].location`                                       | `string`  |             |
| `input.body.stages[].manifestArtifactId`                             | `string`  |             |
| `input.body.stages[].manifestName`                                   | `string`  |             |
| `input.body.stages[].mode`                                           | `string`  |             |
| `input.body.stages[].moniker.app`                                    | `string`  |             |
| `input.body.stages[].name`                                           | `string`  |             |
| `input.body.stages[].refId`                                          | `string`  |             |
| `input.body.stages[].region`                                         | `string`  |             |
| `input.body.stages[].regions[]`                                      | `string`  |             |
| `input.body.stages[].replicas`                                       | `string`  |             |
| `input.body.stages[].requisiteStageRefIds[]`                         | `string`  |             |
| `input.body.stages[].skipExpressionEvaluation`                       | `boolean` |             |
| `input.body.stages[].source`                                         | `string`  |             |
| `input.body.stages[].stageTimeoutMs`                                 | `number`  |             |
| `input.body.stages[].storeType`                                      | `string`  |             |
| `input.body.stages[].trafficManagement.enabled`                      | `boolean` |             |
| `input.body.stages[].trafficManagement.options.enableTraffic`        | `boolean` |             |
| `input.body.stages[].type`                                           | `string`  |             |
| `input.body.stages[].user`                                           | `string`  |             |
| `input.body.stages[].vmType`                                         | `string`  |             |

### input.body.triggers

| Key                                           | Type      | Description |
| :-------------------------------------------- | --------- | ----------- |
| `input.body.triggers[].branch`                | `string`  |             |
| `input.body.triggers[].enabled`               | `boolean` |             |
| `input.body.triggers[].expectedArtifactIds[]` | `string`  |             |
| `input.body.triggers[].project`               | `string`  |             |
| `input.body.triggers[].secret`                | `string`  |             |
| `input.body.triggers[].slug`                  | `string`  |             |
| `input.body.triggers[].source`                | `string`  |             |
| `input.body.triggers[].type`                  | `string`  |             |

### input.user

This object provides information about the user performing the action. This can be used to restrict actions by role. See [input.user]({{< ref "input.user.md" >}}) for more information.
