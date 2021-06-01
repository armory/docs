---
title: "spinnaker.execution.stages.before.createServerGroup"
linktitle: "createServerGroup"
description: "A policy that is run before executing each task in a Create Server Group stage."
---

## Example Payload

<details><summary>Click to expand</summary>

```json
{
  "input": {
    "pipeline": {
      "application": "test",
      "authentication": {
        "allowedAccounts": [
          "spinnaker",
          "staging",
          "staging-ecs"
        ],
        "user": "myUserName"
      },
      "buildTime": 1620926703486,
      "canceled": false,
      "canceledBy": null,
      "cancellationReason": null,
      "description": null,
      "endTime": 1620926705283,
      "id": "01F5KC59TRGWKCP31C4N51CDSB",
      "initialConfig": {},
      "keepWaitingPipelines": false,
      "limitConcurrent": true,
      "name": "test",
      "notifications": [],
      "origin": "api",
      "partition": null,
      "paused": null,
      "pipelineConfigId": "6a4cff2e-8265-4584-8993-2da2eb6254f5",
      "source": null,
      "spelEvaluator": "v4",
      "stages": [],
      "startTime": 1620926703525,
      "startTimeExpiry": null,
      "status": "TERMINAL",
      "systemNotifications": [],
      "templateVariables": null,
      "trigger": {
        "artifacts": [
          {
            "artifactAccount": "myUserName",
            "customKind": false,
            "location": null,
            "metadata": {
              "id": "d14e7e5b-247c-455d-8260-9e9b0a3ae936"
            },
            "name": "manifests/deploy-spinnaker.yaml",
            "provenance": null,
            "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
            "type": "github/file",
            "uuid": null,
            "version": "master"
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
              "artifactAccount": "myUserName",
              "customKind": false,
              "metadata": {
                "id": "d14e7e5b-247c-455d-8260-9e9b0a3ae936"
              },
              "name": "manifests/deploy-spinnaker.yaml",
              "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
              "type": "github/file",
              "version": "master"
            }
          ],
          "dryRun": false,
          "enabled": false,
          "eventId": "c1090782-f485-490e-a2d7-31763b3bd4d8",
          "executionId": "01F5KC59TRGWKCP31C4N51CDSB",
          "expectedArtifacts": [
            {
              "boundArtifact": {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "d14e7e5b-247c-455d-8260-9e9b0a3ae936"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
                "type": "github/file",
                "version": "master"
              },
              "defaultArtifact": {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "d14e7e5b-247c-455d-8260-9e9b0a3ae936"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
                "type": "github/file",
                "version": "master"
              },
              "id": "05ad020e-73a6-49f2-9988-2073831219e9",
              "matchArtifact": {
                "artifactAccount": "myUserName",
                "customKind": true,
                "metadata": {
                  "id": "f7a9b229-0a23-42ab-82de-9990d77084df"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "type": "github/file"
              },
              "useDefaultArtifact": true,
              "usePriorArtifact": false
            }
          ],
          "notifications": [],
          "parameters": {},
          "preferred": false,
          "rebake": false,
          "resolvedExpectedArtifacts": [
            {
              "boundArtifact": {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "d14e7e5b-247c-455d-8260-9e9b0a3ae936"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
                "type": "github/file",
                "version": "master"
              },
              "defaultArtifact": {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "d14e7e5b-247c-455d-8260-9e9b0a3ae936"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
                "type": "github/file",
                "version": "master"
              },
              "id": "05ad020e-73a6-49f2-9988-2073831219e9",
              "matchArtifact": {
                "artifactAccount": "myUserName",
                "customKind": true,
                "metadata": {
                  "id": "f7a9b229-0a23-42ab-82de-9990d77084df"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "type": "github/file"
              },
              "useDefaultArtifact": true,
              "usePriorArtifact": false
            }
          ],
          "strategy": false,
          "type": "manual",
          "user": "myUserName"
        },
        "parameters": {},
        "resolvedExpectedArtifacts": [
          {
            "boundArtifact": {
              "artifactAccount": "myUserName",
              "customKind": false,
              "location": null,
              "metadata": {
                "id": "d14e7e5b-247c-455d-8260-9e9b0a3ae936"
              },
              "name": "manifests/deploy-spinnaker.yaml",
              "provenance": null,
              "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
              "type": "github/file",
              "uuid": null,
              "version": "master"
            },
            "defaultArtifact": {
              "artifactAccount": "myUserName",
              "customKind": false,
              "location": null,
              "metadata": {
                "id": "d14e7e5b-247c-455d-8260-9e9b0a3ae936"
              },
              "name": "manifests/deploy-spinnaker.yaml",
              "provenance": null,
              "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
              "type": "github/file",
              "uuid": null,
              "version": "master"
            },
            "id": "05ad020e-73a6-49f2-9988-2073831219e9",
            "matchArtifact": {
              "artifactAccount": "myUserName",
              "customKind": true,
              "location": null,
              "metadata": {
                "id": "f7a9b229-0a23-42ab-82de-9990d77084df"
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
          }
        ],
        "type": "manual",
        "user": "myUserName"
      },
      "type": "PIPELINE"
    },
    "stage": {
      "context": {
        "account": "staging",
        "application": "test",
        "availabilityZones": {
          "us-east-2": [
            "us-east-2a",
            "us-east-2b",
            "us-east-2c"
          ]
        },
        "capacity": {
          "desired": 1,
          "max": 1,
          "min": 1
        },
        "cloudProvider": "aws",
        "cooldown": 10,
        "copySourceCustomBlockDeviceMappings": false,
        "ebsOptimized": false,
        "enabledMetrics": [],
        "freeFormDetails": "",
        "healthCheckGracePeriod": 600,
        "healthCheckType": "EC2",
        "iamRole": "BaseIAMRole",
        "instanceMonitoring": false,
        "instanceType": "t3.nano",
        "keyPair": "Demo",
        "loadBalancers": [],
        "name": "Deploy in us-east-2",
        "provider": "aws",
        "reason": "sad",
        "securityGroups": [],
        "source": {},
        "spotPrice": "",
        "stack": "",
        "strategy": "",
        "subnetType": "",
        "suspendedProcesses": [],
        "tags": {},
        "targetGroups": [],
        "targetHealthyDeployPercentage": 100,
        "terminationPolicies": [
          "Default"
        ],
        "type": "createServerGroup",
        "useAmiBlockDeviceMappings": false
      },
      "endTime": null,
      "id": "01F5KC59ZVHCFYZPQ9851X0D3X",
      "lastModified": null,
      "name": "Deploy in us-east-2",
      "outputs": {},
      "parentStageId": "01F5KC59VX6DZFTP10F521J3G2",
      "refId": "15<1",
      "requisiteStageRefIds": [],
      "scheduledTime": null,
      "startTime": 1620926703698,
      "startTimeExpiry": null,
      "status": "RUNNING",
      "syntheticStageOwner": "STAGE_BEFORE",
      "tasks": [
        {
          "endTime": 1620926706124,
          "id": "1",
          "implementingClass": "com.netflix.spinnaker.orca.kato.pipeline.strategy.DetermineSourceServerGroupTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "determineSourceServerGroup",
          "stageEnd": false,
          "stageStart": true,
          "startTime": 1620926703970,
          "status": "SUCCEEDED"
        },
        {
          "endTime": null,
          "id": "2",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.DetermineHealthProvidersTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "determineHealthProviders",
          "stageEnd": false,
          "stageStart": false,
          "startTime": 1620926706454,
          "status": "RUNNING"
        },
        {
          "endTime": null,
          "id": "3",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.pipeline.providers.aws.CaptureSourceServerGroupCapacityTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "snapshotSourceServerGroup",
          "stageEnd": false,
          "stageStart": false,
          "startTime": null,
          "status": "NOT_STARTED"
        },
        {
          "endTime": null,
          "id": "4",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.servergroup.CreateServerGroupTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "createServerGroup",
          "stageEnd": false,
          "stageStart": false,
          "startTime": null,
          "status": "NOT_STARTED"
        },
        {
          "endTime": null,
          "id": "5",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.MonitorKatoTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "monitorDeploy",
          "stageEnd": false,
          "stageStart": false,
          "startTime": null,
          "status": "NOT_STARTED"
        },
        {
          "endTime": null,
          "id": "6",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.servergroup.ServerGroupCacheForceRefreshTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "forceCacheRefresh",
          "stageEnd": false,
          "stageStart": false,
          "startTime": null,
          "status": "NOT_STARTED"
        },
        {
          "endTime": null,
          "id": "7",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.instance.WaitForUpInstancesTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "waitForUpInstances",
          "stageEnd": false,
          "stageStart": false,
          "startTime": null,
          "status": "NOT_STARTED"
        },
        {
          "endTime": null,
          "id": "8",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.servergroup.ServerGroupCacheForceRefreshTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "forceCacheRefresh",
          "stageEnd": false,
          "stageStart": false,
          "startTime": null,
          "status": "NOT_STARTED"
        },
        {
          "endTime": null,
          "id": "9",
          "implementingClass": "com.netflix.spinnaker.orca.igor.tasks.GetCommitsTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "getCommits",
          "stageEnd": true,
          "stageStart": false,
          "startTime": null,
          "status": "NOT_STARTED"
        }
      ],
      "type": "createServerGroup"
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
Prevent server groups from being created in production with fewer than 1 instance.
```rego
package spinnaker.execution.stages.before.createServerGroup

productionAccounts :=["prod1","prod2"]

deny["ASGs running in production must have a minimum of 2 instances to avoid having a single point of failure."]{
	input.stage.context.account==productionAccounts[_]
    object.get(input.stage.context.capacity,"min",0)<2
}
```

## Keys

Parameters related to the stage against which the policy is executing can be found in the [input.stage.context](#inputstagecontext) object.

### input.pipeline

| Key                                               | Type      | Description                                                           |
| ------------------------------------------------- | --------- | --------------------------------------------------------------------- |
| `input.pipeline.application`                      | `string`  | The name of the Spinnaker application to which this pipeline belongs. |
| `input.pipeline.authentication.allowedAccounts[]` | `string`  | The list of accounts to which the user this stage is running as has access. |
| `input.pipeline.authentication.user` | `string`  | The Spinnaker user initiating the change. |
| `input.pipeline.buildTime`                        | `number`  |                                                                       |
| `input.pipeline.canceled`                         | `boolean` |                                                                       |
| `input.pipeline.canceledBy`                       | ` `       |                                                                       |
| `input.pipeline.cancellationReason`               | ` `       |                                                                       |
| `input.pipeline.description` | `string`  | Description of the pipeline defined in the UI |
| `input.pipeline.endTime`                          | `number`  |                                                                       |
| `input.pipeline.id` | `string`   |  The unique ID of the pipeline |
| `input.pipeline.keepWaitingPipelines`              | `boolean`  | If concurrent pipeline execution is disabled, then the pipelines that are in the waiting queue will get canceled when the next execution starts unless this is true. |
| `input.pipeline.limitConcurrent` | `boolean` | True if only 1 concurrent execution of this pipeline be allowed. |
| `input.pipeline.name` | `string`  | The name of this pipeline. |
| `input.pipeline.origin`                           | `string`  |                                                                       |
| `input.pipeline.partition`                        | ` `       |                                                                       |
| `input.pipeline.paused`                           | ` `       |                                                                       |
| `input.pipeline.pipelineConfigId`                 | `string`  |                                                                       |
| `input.pipeline.source`                           | ` `       |                                                                       |
| `input.pipeline.spelEvaluator` | `string`  | Which version of spring expression language is being used to evaluate SpEL. |
| `input.pipeline.stages[]`                         | `[array]` | An array of the stages in the pipeline. Typically if you are writing a policy that examines multiple pipeline stages, it is better to write that policy against either the `opa.pipelines package`, or the `spinnaker.execution.pipelines.before` package. |
| `input.pipeline.startTime` | `number`  | Timestamp from when the pipeline was started. |
| `input.pipeline.startTimeExpiry` | `date `   | Unix epoch date at which the pipeline will expire. |
| `input.pipeline.status`                           | `string`  |                                                                       |
| `input.pipeline.templateVariables`                | ` `       |                                                                       |
| `input.pipeline.type`                             | `string`  |                                                                       |

### input.pipeline.trigger

See [input.pipeline.trigger]({{< ref "input.pipeline.trigger.md" >}}) for more information.

### input.stage.context

| Key                                                       | Type      | Description |
| --------------------------------------------------------- | --------- | ----------- |
| `input.stage.context.account`                             | `string`  |             |
| `input.stage.context.application` | `string`  | The name of the Spinnaker application for this pipeline. |
| `input.stage.context.availabilityZones.us-east-2[]`       | `string`  |             |
| `input.stage.context.capacity.desired`                    | `number`  |             |
| `input.stage.context.capacity.max`                        | `number`  |             |
| `input.stage.context.capacity.min`                        | `number`  |             |
| `input.stage.context.cloudProvider`                       | `string`  |             |
| `input.stage.context.cooldown`                            | `number`  |             |
| `input.stage.context.copySourceCustomBlockDeviceMappings` | `boolean` |             |
| `input.stage.context.ebsOptimized`                        | `boolean` |             |
| `input.stage.context.freeFormDetails`                     | `string`  |             |
| `input.stage.context.healthCheckGracePeriod`              | `number`  |             |
| `input.stage.context.healthCheckType`                     | `string`  |             |
| `input.stage.context.iamRole`                             | `string`  |             |
| `input.stage.context.instanceMonitoring`                  | `boolean` |             |
| `input.stage.context.instanceType`                        | `string`  |             |
| `input.stage.context.keyPair`                             | `string`  |             |
| `input.stage.context.name`                                | `string`  |             |
| `input.stage.context.provider`                            | `string`  |             |
| `input.stage.context.reason`                              | `string`  |             |
| `input.stage.context.spotPrice`                           | `string`  |             |
| `input.stage.context.stack`                               | `string`  |             |
| `input.stage.context.strategy`                            | `string`  |             |
| `input.stage.context.subnetType`                          | `string`  |             |
| `input.stage.context.targetHealthyDeployPercentage`       | `number`  |             |
| `input.stage.context.terminationPolicies[]`               | `string`  |             |
| `input.stage.context.type`                                | `string`  |             |
| `input.stage.context.useAmiBlockDeviceMappings`           | `boolean` |             |

### input.stage

See [`input.stage`]({{< ref "input.stage.md" >}}) for more information.


### input.user

This object provides information about the user performing the action. This can be used to restrict actions by role. See [input.user]({{< ref "input.user.md" >}}) for more information.
