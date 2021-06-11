---
title: "Pipelines"
linktitle: "pipelines"
description: "Controls access to the Spinnaker pipelines API. Can be used to prevent a user from creating a pipeline."
---

 Most usecases for this API call are better authored against the [opa.pipelines]({{< ref "opa.pipelines.md" >}}) package.

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

| Key            | Type     | Description     |
| :------------- | -------- | --------------- |
| `input.method` | `string` | Post            |
| `input.path[]` | `string` | `["pipelines"]` |

### input.body

| Key                                            | Type      | Description                                                                                           |
| :--------------------------------------------- | --------- | ----------------------------------------------------------------------------------------------------- |
| `input.body.application`                       | `string`  | The application for which a pipeline is being saved.                                                  |
| `input.body.expectedArtifacts[]`               | `array`   | See [artifacts]({{< ref "artifacts.md" >}}) for more information.                                     |
| `input.body.id`                                | `string`  | The unique ID of the pipeline.                                                                        |
| `input.body.index`                             | `number`  |                                                                                                       |
| `input.body.keepWaitingPipelines`              | `boolean` |                                                                                                       |
| `input.body.lastModifiedBy`                    | `string`  | The ID of the last user that modified the pipeline, should match the user in the `input.users` field. |
| `input.body.limitConcurrent`                   | `boolean` |                                                                                                       |
| `input.body.name`                              | `string`  |                                                                                                       |
| `input.body.parameterConfig[].default`         | `string`  |                                                                                                       |
| `input.body.parameterConfig[].description`     | `string`  |                                                                                                       |
| `input.body.parameterConfig[].hasOptions`      | `boolean` |                                                                                                       |
| `input.body.parameterConfig[].label`           | `string`  |                                                                                                       |
| `input.body.parameterConfig[].name`            | `string`  |                                                                                                       |
| `input.body.parameterConfig[].options[].value` | `string`  |                                                                                                       |
| `input.body.parameterConfig[].pinned`          | `boolean` |                                                                                                       |
| `input.body.parameterConfig[].required`        | `boolean` |                                                                                                       |
| `input.body.spelEvaluator`                     | `string`  |                                                                                                       |
| `input.body.updateTs`                          | `string`  |                                                                                                       |

### input.body.stages

These fields are all stage specific, and may or may not be present depending on the stage type.

| Key                                                                  | Type      | Description                                                                                                                                                                                                                                              |
| :------------------------------------------------------------------- | --------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `input.body.stages[].account`                                        | `string`  | The account the stage deploys to. Applies to the following stage types: `deployManifest`, `scaleManifest`, `deploy`.                                                                                                                                     |
| `input.body.stages[].app`                                            | `string`  | The name of the application being deployed. Use `input.body.application` instead. Applies to the following stage types: `deployManifest`, `scaleManifest`.                                                                                               |
| `input.body.stages[].baseAmi`                                        | `string`  | Only available for the `bake` stage.<br/> If Base AMI is specified, this is used instead of the Base OS provided.                                                                                                                                   |
| `input.body.stages[].baseLabel`                                      | `string`  | Only available for the `bake` stage.<br/> Possible values are `release`, `candidate`, `previous`, or `unstable`.                                                                                                                                         |
| `input.body.stages[].baseOs`                                         | `string`  | Only available for the `bake` stage.<br/> Defines what OS should be used to identify a Base AMI if none is specified.                                                                                                                                    |
| `input.body.stages[].cloudProviderType`                              | `string`  | Only available for the `bake` stage.<br/> Defines what cloud provider type is being used.                                                                                                                                                                |
| `input.body.stages[].cloudProvider`                                  | `string`  | Which specific cloud provider is being used. Applies to the following stage types: `deployManifest`, `scaleManifest`, and `deploy`.                                                                                                                      |
| `input.body.stages[].clusters[].account`                             | `string`  | Only available on the `deploy` stage.<br/> This is the cluster the stage will deploy to.                                                                                                                                                                 |
| `input.body.stages[].clusters[].application`                         | `string`  | Only available on the `deploy` stage.<br/> This is the application being deployed.                                                                                                                                                                       |
| `input.body.stages[].clusters[].availabilityZones.<Region>[]`        | `string`  | Only available on the `deploy` stage.<br/> Specifies what availability zones to deploy to.                                                                                                                                                               |
| `input.body.stages[].clusters[].capacity.desired`                    | `number`  | Only available on the `deploy` stage.<br/> The desired number of instances in the autoscaling group.                                                                                                                                                     |
| `input.body.stages[].clusters[].capacity.max`                        | `number`  | Only available on the `deploy` stage.<br/> The maximum number of instances in the autoscaling group.                                                                                                                                                     |
| `input.body.stages[].clusters[].capacity.min`                        | `number`  | Only available on the `deploy` stage.<br/> The minimum number of instances in the autoscaling group.                                                                                                                                                     |
| `input.body.stages[].clusters[].cloudProvider`                       | `string`  | Only available on the `deploy` stage.<br/> Which cloud provider is being used.                                                                                                                                                                           |
| `input.body.stages[].clusters[].cooldown`                            | `number`  | Only available on the `deploy` stage.<br/> A scaling cooldown helps you prevent your Auto Scaling group from launching or terminating additional instances before the effects of previous activities are visible.                                        |
| `input.body.stages[].clusters[].copySourceCustomBlockDeviceMappings` | `boolean` | Only available on the `deploy` stage.<br/> If true, Spinnaker will use the block device mappings of the existing server group when deploying a new server group.                                                                                         |
| `input.body.stages[].clusters[].delayBeforeDisableSec`               | `number`  | Only available on the `deploy` stage.<br/>                                                                                                                                                                                                               |
| `input.body.stages[].clusters[].delayBeforeScaleDownSec`             | `number`  | Only available on the `deploy` stage.<br/>                                                                                                                                                                                                               |
| `input.body.stages[].clusters[].ebsOptimized`                        | `boolean` | Only available on the `deploy` stage.<br/> True if instances are optomized for EBS.                                                                                                                                                                      |
| `input.body.stages[].clusters[].freeFormDetails`                     | `string`  | Only available on the `deploy` stage.<br/> A string of free-form alphanumeric characters and hyphens to describe any other variables in naming a cluster.                                                                                                |
| `input.body.stages[].clusters[].healthCheckGracePeriod`              | `number`  | Only available on the `deploy` stage.<br/> When an instance launches, Amazon EC2 Auto Scaling uses the value of the `healthCheckGracePeriod` for the Auto Scaling group to determine how long to wait before checking the health status of the instance. |
| `input.body.stages[].clusters[].healthCheckType`                     | `string`  | Only available on the `deploy` stage.<br/> The value can be either `ELB` or `EC2`.                                                                                                                                                                       |
| `input.body.stages[].clusters[].iamRole`                             | `string`  | Only available on the `deploy` stage.<br/> What role is being used to run the instances.                                                                                                                                                                 |
| `input.body.stages[].clusters[].instanceMonitoring`                  | `boolean` | Only available on the `deploy` stage.<br/> Determines whether to enable detailed monitoring of instances.                                                                                                                                                |
| `input.body.stages[].clusters[].instanceType`                        | `string`  | Only available on the `deploy` stage.<br/> The type of instances to deploy to.                                                                                                                                                                           |
| `input.body.stages[].clusters[].keyPair`                             | `string`  | Only available on the `deploy` stage.<br/> The set of security credentials that can be used to connect to this instance.                                                                                                                                 |
| `input.body.stages[].clusters[].maxRemainingAsgs`                    | `number`  | Only available on the `deploy` stage.<br/> How many auto scaling groups from prior deployments for this application should be left up and running once the new deployment is complete.                                                                   |
| `input.body.stages[].clusters[].provider`                            | `string`  | Only available on the `deploy` stage.<br/> Defines the cloud provider.                                                                                                                                                                                   |
| `input.body.stages[].clusters[].rollback.onFailure`                  | `boolean` | Only available on the `deploy` stage.<br/> True if the deploy should be automatically rolled back on failure.                                                                                                                                            |
| `input.body.stages[].clusters[].scaleDown`                           | `boolean` | Only available on the `deploy` stage.<br/>                                                                                                                                                                                                               |
| `input.body.stages[].clusters[].spotPrice`                           | `string`  | Only available on the `deploy` stage.<br/>                                                                                                                                                                                                               |
| `input.body.stages[].clusters[].stack`                               | `string`  | Only available on the `deploy` stage.<br/>                                                                                                                                                                                                               |
| `input.body.stages[].clusters[].strategy`                            | `string`  | Only available on the `deploy` stage.<br/> The deployment strategy tells Spinnaker what to do with the previous version of the server group.                                                                                                             |
| `input.body.stages[].clusters[].subnetType`                          | `string`  | Only available on the `deploy` stage.<br/> The subnet selection determines the VPC in which your server group will run. Options vary by account and region.                                                                                              |
| `input.body.stages[].clusters[].tags.Name`                           | `string`  | Only available on the `deploy` stage.<br/> Tags are propagated to the instances in this cluster.                                                                                                                                                         |
| `input.body.stages[].clusters[].targetHealthyDeployPercentage`       | `number`  | Only available on the `deploy` stage.<br/>                                                                                                                                                                                                               |
| `input.body.stages[].clusters[].terminationPolicies[]`               | `string`  | Only available on the `deploy` stage.<br/> The name of the policy to determine how old instances are terminated.                                                                                                                                         |
| `input.body.stages[].clusters[].useAmiBlockDeviceMappings`           | `boolean` | Only available on the `deploy` stage.<br/> If true, Spinnaker will use the block device mappings from the selected AMI when deploying a new server group.                                                                                                |
| `input.body.stages[].completeOtherBranchesThenFail`                  | `boolean` | Prevents any stages that depend on this stage from running, but allows other branches of the pipeline to run. The pipeline is marked as failed once complete. Available for all stages.                                                             |
| `input.body.stages[].continuePipeline`                               | `boolean` | Continues execution of downstream stages, marking this stage as failed/continuing. Available for all stages.                                                                                                                                             |
| `input.body.stages[].failPipeline`                                   | `boolean` | Immediately halts execution of all running stages and fails the entire execution if this stage fails. Available for all stages.                                                                                                                          |
| `input.body.stages[].instructions`                                   | `string`  | Only available on the `manual judgement` stage.<br/> Instructions are shown to the user when making a manual judgment.                                                                                                                                   |
| `input.body.stages[].location`                                       | `string`  | Only available on the `scale manifest` stage.<br/> The namespace to scale the manifest in.                                                                                                                                                               |
| `input.body.stages[].manifestArtifactId`                             | `string`  | Only available on the `deploy manifest` stage.<br/> The artifact ID to deploy.                                                                                                                                                                           |
| `input.body.stages[].manifestName`                                   | `string`  | Only available on the `scale manifest` stage.<br/> The name of the manifest to scale.                                                                                                                                                                    |
| `input.body.stages[].mode`                                           | `string`  | Only available on the `scale manifest` stage.<br/> Determines whether the stage uses a static or a dynamic selector.                                                                                                                                     |
| `input.body.stages[].moniker.app`                                    | `string`  | The application being deployed.                                                                                                                                                                                                                          |
| `input.body.stages[].name`                                           | `string`  | The name of the stage.                                                                                                                                                                                                                                   |
| `input.body.stages[].refId`                                          | `string`  | The unique ID for the stage in the stage graph.                                                                                                                                                                                                          |
| `input.body.stages[].region`                                         | `string`  | The region in which to bake, only available on the `bake` stage.                                                                                                                                                                                         |
| `input.body.stages[].regions[]`                                      | `string`  | The regions in which to bake, only available on the `bake` stage.                                                                                                                                                                                        |
| `input.body.stages[].replicas`                                       | `string`  |                                                                                                                                                                                                                                                          |
| `input.body.stages[].requisiteStageRefIds[]`                         | `string`  | The unique IDs of other stages that must complete before this stage.                                                                                                                                                                                     |
| `input.body.stages[].skipExpressionEvaluation`                       | `boolean` | If true then SpEL is not evaluated in artifacts referenced by the stage.                                                                                                                                                                            |
| `input.body.stages[].source`                                         | `string`  | Only applicable to the `deploy manifest` stage.<br/> Specifies whether the manifest should be read from an artifact, or provided as text in the pipeline definition.                                                                                     |
| `input.body.stages[].stageTimeoutMs`                                 | `number`  | Only applicable to the `manual judgement` stage.<br/> Specifies how long the user has to provide a judgement.                                                                                                                                            |
| `input.body.stages[].storeType`                                      | `string`  | Only applicable in the `bake` stage.                                                                                                                                                                                                                     |
| `input.body.stages[].trafficManagement.enabled`                      | `boolean` | Only applicable to the `deploy manifest` stage.<br/> Allow Spinnaker to associate each ReplicaSet deployed in this stage with one or more Services, and manage traffic based on your selected rollout strategy options.                                  |
| `input.body.stages[].trafficManagement.options.enableTraffic`        | `boolean` | Only applicable to the `deploy manifest` stage.<br/> Sends client requests to new pods when traffic management is enabled.                                                                                                                               |
| `input.body.stages[].type`                                           | `string`  | The type of the stage.                                                                                                                                                                                                                                   |
| `input.body.stages[].user`                                           | `string`  | Only applicable in the `bake` stage.                                                                                                                                                                                                                     |
| `input.body.stages[].vmType`                                         | `string`  | Only applicable in the `bake` stage.                                                                                                                                                                                                                     |

### input.body.triggers

| Key                                           | Type      | Description                                                                                                                        |
| :-------------------------------------------- | --------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| `input.body.triggers[].branch`                | `string`  | Which branch of the git repository triggers this pipeline.                                                                         |
| `input.body.triggers[].enabled`               | `boolean` | True if the trigger is enabled.                                                                                                    |
| `input.body.triggers[].expectedArtifactIds[]` | `string`  |                                                                                                                                    |
| `input.body.triggers[].project`               | `string`  | A change in what project will trigger this pipeline.                                                                               |
| `input.body.triggers[].secret`                | `string`  | The secret that the trigger uses to authenticate with Spinnaker.                                                                   |
| `input.body.triggers[].slug`                  | `string`  | The trigger’s slug. For example, with a GitHub trigger this is the project name.                                              |
| `input.body.triggers[].source`                | `string`  | The type of the source for the trigger. For some trigger types this can be used to disambiguate amongst multiple trigger invokers. |
| `input.body.triggers[].type`                  | `string`  | The configured type of the trigger.                                                                                                |

### input.user

This object provides information about the user performing the action. This can be used to restrict actions by role. See [input.user]({{< ref "input.user.md" >}}) for more information.
