---
title: "spinnaker.execution.stages.before.bake"
linktitle: "bake"
description: "A policy targeting this object runs before executing each task in a bake stage."
weight: 10
---
More information about the bake stage can be found in [Bake Amazon Machine Images in a Spinnaker Pipeline]({{< ref "aws-baking-images" >}})

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
      "stages": [
        {
          "context": {
            "exception": {
              "details": {
                "error": "Internal Server Error",
                "errors": [
                  "Bake failed: Error: file '/tmp/rosco-2833166343726058950/f547ea98-52eb-4b6c-8c17-173d21535456' does not appear to be a gzipped archive; got 'text/plain; charset=utf-8'\n"
                ],
                "kind": "HTTP",
                "responseBody": "{\"timestamp\":\"2021-05-13T17:25:05.658+00:00\",\"status\":500,\"error\":\"Internal Server Error\",\"message\":\"Bake failed: Error: file '/tmp/rosco-2833166343726058950/f547ea98-52eb-4b6c-8c17-173d21535456' does not appear to be a gzipped archive; got 'text/plain; charset=utf-8'\\n\"}",
                "status": 500,
                "url": "http://spin-rosco.spinnaker:8087/api/v2/manifest/bake/HELM2"
              },
              "exceptionType": "RetrofitError",
              "operation": "createBake",
              "shouldRetry": false,
              "timestamp": 1620926705665
            },
            "expectedArtifacts": [
              {
                "defaultArtifact": {
                  "customKind": true,
                  "id": "f9275bbf-fef7-4339-88f4-b2a18ec7b0ab"
                },
                "displayName": "pink-dog-80",
                "id": "eb9e5a6c-e9d1-489b-9f3b-4d414ba33b73",
                "matchArtifact": {
                  "artifactAccount": "embedded-artifact",
                  "customKind": false,
                  "id": "301e50f0-2bc6-4d3e-894b-31dbf0b67bf0",
                  "name": "test",
                  "type": "embedded/base64"
                },
                "useDefaultArtifact": false,
                "usePriorArtifact": false
              }
            ],
            "inputArtifacts": [
              {
                "account": "",
                "id": "05ad020e-73a6-49f2-9988-2073831219e9"
              }
            ],
            "namespace": "testns",
            "outputName": "test",
            "overrides": {},
            "templateRenderer": "HELM2"
          },
          "endTime": null,
          "id": "01F5KC59VXSVC287E96M310EF5",
          "lastModified": null,
          "name": "Bake (Manifest)",
          "outputs": {},
          "parentStageId": null,
          "refId": "10",
          "requisiteStageRefIds": [],
          "scheduledTime": null,
          "startTime": 1620926703574,
          "startTimeExpiry": null,
          "status": "RUNNING",
          "syntheticStageOwner": null,
          "tasks": [
            {
              "endTime": null,
              "id": "1",
              "implementingClass": "com.netflix.spinnaker.orca.bakery.tasks.manifests.CreateBakeManifestTask",
              "loopEnd": false,
              "loopStart": false,
              "name": "createBake",
              "stageEnd": false,
              "stageStart": true,
              "startTime": 1620926703700,
              "status": "RUNNING"
            },
            {
              "endTime": null,
              "id": "2",
              "implementingClass": "com.netflix.spinnaker.orca.pipeline.tasks.artifacts.BindProducedArtifactsTask",
              "loopEnd": false,
              "loopStart": false,
              "name": "bindProducedArtifacts",
              "stageEnd": true,
              "stageStart": false,
              "startTime": null,
              "status": "NOT_STARTED"
            }
          ],
          "type": "bakeManifest"
        }
      ],
      "startTime": 1620926703525,
      "startTimeExpiry": null,
      "status": "TERMINAL",
      "systemNotifications": [],
      "templateVariables": null,
      "trigger": {
        "artifacts": [
          {
            "artifactAccount": "myUsername",
            "customKind": false,
            "location": null,
            "metadata": {
              "id": "d14e7e5b-247c-455d-8260-9e9b0a3ae936"
            },
            "name": "manifests/deploy-spinnaker.yaml",
            "provenance": null,
            "reference": "Https://api.github.com/repos/myUsername/hostname/contents/manifests/deploy-spinnaker.yaml",
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
              "artifactAccount": "myUsername",
              "customKind": false,
              "metadata": {
                "id": "d14e7e5b-247c-455d-8260-9e9b0a3ae936"
              },
              "name": "manifests/deploy-spinnaker.yaml",
              "reference": "Https://api.github.com/repos/myUsername/hostname/contents/manifests/deploy-spinnaker.yaml",
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
                "artifactAccount": "myUsername",
                "customKind": false,
                "metadata": {
                  "id": "d14e7e5b-247c-455d-8260-9e9b0a3ae936"
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
                  "id": "d14e7e5b-247c-455d-8260-9e9b0a3ae936"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUsername/hostname/contents/manifests/deploy-spinnaker.yaml",
                "type": "github/file",
                "version": "master"
              },
              "id": "05ad020e-73a6-49f2-9988-2073831219e9",
              "matchArtifact": {
                "artifactAccount": "myUsername",
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
                "artifactAccount": "myUsername",
                "customKind": false,
                "metadata": {
                  "id": "d14e7e5b-247c-455d-8260-9e9b0a3ae936"
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
                  "id": "d14e7e5b-247c-455d-8260-9e9b0a3ae936"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUsername/hostname/contents/manifests/deploy-spinnaker.yaml",
                "type": "github/file",
                "version": "master"
              },
              "id": "05ad020e-73a6-49f2-9988-2073831219e9",
              "matchArtifact": {
                "artifactAccount": "myUsername",
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
              "artifactAccount": "myUsername",
              "customKind": false,
              "location": null,
              "metadata": {
                "id": "d14e7e5b-247c-455d-8260-9e9b0a3ae936"
              },
              "name": "manifests/deploy-spinnaker.yaml",
              "provenance": null,
              "reference": "Https://api.github.com/repos/myUsername/hostname/contents/manifests/deploy-spinnaker.yaml",
              "type": "github/file",
              "uuid": null,
              "version": "master"
            },
            "defaultArtifact": {
              "artifactAccount": "myUsername",
              "customKind": false,
              "location": null,
              "metadata": {
                "id": "d14e7e5b-247c-455d-8260-9e9b0a3ae936"
              },
              "name": "manifests/deploy-spinnaker.yaml",
              "provenance": null,
              "reference": "Https://api.github.com/repos/myUsername/hostname/contents/manifests/deploy-spinnaker.yaml",
              "type": "github/file",
              "uuid": null,
              "version": "master"
            },
            "id": "05ad020e-73a6-49f2-9988-2073831219e9",
            "matchArtifact": {
              "artifactAccount": "myUsername",
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
        "amiSuffix": "20210513172504",
        "baseLabel": "release",
        "baseOs": "ubuntu",
        "cloudProviderType": "aws",
        "extendedAttributes": {},
        "name": "Bake in us-east-2",
        "package": "nginx vim",
        "rebake": true,
        "region": "us-east-2",
        "storeType": "ebs",
        "type": "bake",
        "user": "myUsername",
        "vmType": "hvm"
      },
      "endTime": null,
      "id": "01F5KC5AJECT88MA2PHYG6TT3G",
      "lastModified": null,
      "name": "Bake in us-east-2",
      "outputs": {},
      "parentStageId": "01F5KC59VXEMS65RNVKF5HJJ9S",
      "refId": "8<1",
      "requisiteStageRefIds": [],
      "scheduledTime": null,
      "startTime": 1620926704513,
      "startTimeExpiry": null,
      "status": "RUNNING",
      "syntheticStageOwner": "STAGE_BEFORE",
      "tasks": [
        {
          "endTime": null,
          "id": "1",
          "implementingClass": "com.netflix.spinnaker.orca.bakery.tasks.CreateBakeTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "createBake",
          "stageEnd": false,
          "stageStart": true,
          "startTime": 1620926705585,
          "status": "RUNNING"
        },
        {
          "endTime": null,
          "id": "2",
          "implementingClass": "com.netflix.spinnaker.orca.bakery.tasks.MonitorBakeTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "monitorBake",
          "stageEnd": false,
          "stageStart": false,
          "startTime": null,
          "status": "NOT_STARTED"
        },
        {
          "endTime": null,
          "id": "3",
          "implementingClass": "com.netflix.spinnaker.orca.bakery.tasks.CompletedBakeTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "completedBake",
          "stageEnd": false,
          "stageStart": false,
          "startTime": null,
          "status": "NOT_STARTED"
        },
        {
          "endTime": null,
          "id": "4",
          "implementingClass": "com.netflix.spinnaker.orca.pipeline.tasks.artifacts.BindProducedArtifactsTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "bindProducedArtifacts",
          "stageEnd": true,
          "stageStart": false,
          "startTime": null,
          "status": "NOT_STARTED"
        }
      ],
      "type": "bake"
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

Requires that baked images are of type `hvm`.

{{< prism lang="rego" line-numbers="true" >}}
package spinnaker.execution.stages.before.bake

deny["all baked images must be of type hvm"]{
	input.stage.context.vmType!="hvm"
}
{{< /prism >}}

## Keys

Parameters related to the stage against which the policy is executing can be found in the [input.stage.context](#inputstagecontext) object.

### input.pipeline

| Key                                               | Type      | Description                                                                                                                                       |
| ------------------------------------------------- | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| `input.pipeline.application`                      | `string`  | The name of the Spinnaker application to which this pipeline belongs.                                                                             |
| `input.pipeline.authentication.allowedAccounts[]` | `string`  | The list of accounts to which the user this stage runs as has access.                                                                             |
| `input.pipeline.authentication.user`              | `string`  | The Spinnaker user initiating the change.                                                                                                         |
| `input.pipeline.buildTime`                        | `number`  |                                                                                                                                                   |
| `input.pipeline.canceled`                         | `boolean` | Has the pipeline execution been cancelled. This is always false since the policy check requires that the pipeline is running.                     |
| `input.pipeline.canceledBy`                       | `string ` | The userID of the user that cancelled the pipeline.                                                                                               |
| `input.pipeline.cancellationReason`               |           |                                                                                                                                                   |
| `input.pipeline.description`                      | `string`  | Description of the pipeline defined in the UI.                                                                                                    |
| `input.pipeline.endTime`                          | `number`  |                                                                                                                                                   |
| `input.pipeline.id`                               | `string`  | The unique ID of the pipeline.                                                                                                                    |
| `input.pipeline.keepWaitingPipelines`             | `boolean` | If false and concurrent pipeline execution is disabled, then the pipelines in the waiting queue get canceled when the next execution starts.      |
| `input.pipeline.limitConcurrent`                  | `boolean` | True if only 1 concurrent execution of this pipeline is allowed.                                                                                  |
| `input.pipeline.name`                             | `string`  | The name of this pipeline.                                                                                                                        |
| `input.pipeline.origin`                           | `string`  |                                                                                                                                                   |
| `input.pipeline.partition`                        |           |                                                                                                                                                   |
| `input.pipeline.paused`                           |           |                                                                                                                                                   |
| `input.pipeline.pipelineConfigId`                 | `string`  |                                                                                                                                                   |
| `input.pipeline.source`                           |           |                                                                                                                                                   |
| `input.pipeline.spelEvaluator`                    | `string`  | Which version of spring expression language is being used to evaluate SpEL.                                                                       |
| `input.pipeline.stages[]`                         | `[array]` | An array of the stages in the pipeline. Typically if you are writing a policy that examines multiple pipeline stages, it is better to write that policy against either the `opa.pipelines package`, or the `spinnaker.execution.pipelines.before` package. |
| `input.pipeline.startTime`                        | `number`  | Timestamp from when the pipeline was started.                                                                                                     |
| `input.pipeline.startTimeExpiry`                  | `date `   | Unix epoch date at which the pipeline expires.                                                                                                |
| `input.pipeline.status`                           | `string`  |                                                                                                                                                   |
| `input.pipeline.templateVariables`                |           |                                                                                                                                                   |
| `input.pipeline.type`                             | `string`  |                                                                                                                                                   |

### input.pipeline.trigger

See [input.pipeline.trigger]({{< ref "input.pipeline.trigger.md" >}}) for more information.

### input.stage

See [`input.stage`]({{< ref "input.stage.md" >}}) for more information.

### input.stage.context

| Key                                     | Type      | Description                                                                              |
| --------------------------------------- | --------- | ---------------------------------------------------------------------------------------- |
| `input.stage.context.amiSuffix`         | `string`  | A suffix to apply to the ami. By default, a string of the date in format `YYYYMMDDHHmm`. |
| `input.stage.context.baseLabel`         | `string`  | A base label to use for the AMI.                                                         |
| `input.stage.context.baseOs`            | `string`  | What operating system should be used to find a baseAMI to base the AMI from.             |
| `input.stage.context.baseAmi`           | `string`  | If Base AMI is specified, this is used instead of the Base OS provided.             |
| `input.stage.context.cloudProviderType` | `string`  | The type of the cloud provider for which an image is baked.                         |
| `input.stage.context.name`              | `string`  |                                                                                          |
| `input.stage.context.package`           | `string`  | The package that should be installed in the new AMI.                                     |
| `input.stage.context.rebake`            | `boolean` | Rebake image without regard to the status of any existing bake.                          |
| `input.stage.context.region`            | `string`  | The region in which to perform the backe.                                                |
| `input.stage.context.storeType`         | `string`  | What type of storage the baked image will use.                                           |
| `input.stage.context.type`              | `string`  | Always `bake`.                                                                           |
| `input.stage.context.user`              | `string`  | The ID of the user that started the bake.                                                |
| `input.stage.context.vmType`            | `string`  | `HVM` or `PV`. The type of virtual machine for which the image should be baked.          |

### input.user

This object provides information about the user performing the action. This can be used to restrict actions by role. See [input.user]({{< ref "input.user.md" >}}) for more information.
