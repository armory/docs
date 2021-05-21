---
title: "spinnaker.execution.stages.before.undoRolloutManifest"
linktitle: "undoRolloutManifest"
description: "fill me with delicious data, Stephen!"
---

## Example Payload

<details><summary>Click to expand</summary>

```json
{
  "input": {
    "pipeline": {
      "application": "hostname",
      "authentication": {
        "allowedAccounts": [
          "spinnaker",
          "staging",
          "staging-ecs"
        ],
        "user": "myUserName"
      },
      "buildTime": 1620752523096,
      "canceled": false,
      "canceledBy": null,
      "cancellationReason": null,
      "description": "Undo rollout of manifest",
      "endTime": null,
      "id": "01F5E61QTRW9H5TPZSAK4D2WCV",
      "initialConfig": {},
      "keepWaitingPipelines": false,
      "limitConcurrent": false,
      "name": null,
      "notifications": [],
      "origin": "unknown",
      "partition": null,
      "paused": null,
      "pipelineConfigId": null,
      "source": null,
      "spelEvaluator": null,
      "stages": [
        "01F5E61QTRMYD2PV6Z5YHXXE4D"
      ],
      "startTime": 1620752523145,
      "startTimeExpiry": null,
      "status": "RUNNING",
      "systemNotifications": [],
      "templateVariables": null,
      "trigger": {
        "artifacts": [],
        "correlationId": null,
        "isDryRun": false,
        "isRebake": false,
        "isStrategy": false,
        "notifications": [],
        "other": {
          "artifacts": [],
          "dryRun": false,
          "expectedArtifacts": [],
          "notifications": [],
          "parameters": {},
          "rebake": false,
          "resolvedExpectedArtifacts": [],
          "strategy": false,
          "type": "manual",
          "user": "myUserName"
        },
        "parameters": {},
        "resolvedExpectedArtifacts": [],
        "type": "manual",
        "user": "myUserName"
      },
      "type": "ORCHESTRATION"
    },
    "stage": {
      "context": {
        "account": "spinnaker",
        "cloudProvider": "kubernetes",
        "deploy.server.groups": {},
        "failedManifests": [],
        "kato.last.task.id": {
          "id": "7891099a-c0da-4e1b-b14a-89592343293b"
        },
        "kato.result.expected": false,
        "kato.task.firstNotFoundRetry": -1,
        "kato.task.lastStatus": "SUCCEEDED",
        "kato.task.notFoundRetryCount": 0,
        "kato.task.terminalRetryCount": 0,
        "kato.tasks": [
          {
            "history": [
              {
                "phase": "ORCHESTRATION",
                "status": "Initializing Orchestration Task"
              },
              {
                "phase": "ORCHESTRATION",
                "status": "Processing op: KubernetesUndoRolloutManifestOperation"
              },
              {
                "phase": "UNDO_ROLLOUT_KUBERNETES_MANIFEST",
                "status": "Starting undo rollout operation..."
              },
              {
                "phase": "UNDO_ROLLOUT_KUBERNETES_MANIFEST",
                "status": "Looking up resource properties..."
              },
              {
                "phase": "UNDO_ROLLOUT_KUBERNETES_MANIFEST",
                "status": "Calling undo rollout operation..."
              },
              {
                "phase": "ORCHESTRATION",
                "status": "Orchestration completed."
              }
            ],
            "id": "7891099a-c0da-4e1b-b14a-89592343293b",
            "resultObjects": [],
            "status": {
              "completed": true,
              "failed": false,
              "retryable": false
            }
          }
        ],
        "location": "staging",
        "manifest.account.name": "spinnaker",
        "manifest.location": "staging",
        "manifest.name": "deployment hostname",
        "manifestName": "deployment hostname",
        "messages": [
          "'deployment hostname' in 'staging' for account spinnaker: waiting for manifest to stabilize"
        ],
        "outputs.manifestNamesByNamespace": {
          "staging": [
            "deployment hostname"
          ]
        },
        "reason": "someReason",
        "revision": "3",
        "stableManifests": [],
        "user": "myUserName"
      },
      "endTime": null,
      "id": "01F5E61QTRMYD2PV6Z5YHXXE4D",
      "lastModified": null,
      "name": "undoRolloutManifest",
      "outputs": {},
      "parentStageId": null,
      "refId": "0",
      "requisiteStageRefIds": [],
      "scheduledTime": null,
      "startTime": 1620752523160,
      "startTimeExpiry": null,
      "status": "RUNNING",
      "syntheticStageOwner": null,
      "tasks": [
        {
          "endTime": 1620752523449,
          "id": "1",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.manifest.UndoRolloutManifestTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "undoRolloutManifest",
          "stageEnd": false,
          "stageStart": true,
          "startTime": 1620752523216,
          "status": "SUCCEEDED"
        },
        {
          "endTime": 1620752528687,
          "id": "2",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.MonitorKatoTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "monitorUndoRollout",
          "stageEnd": false,
          "stageStart": false,
          "startTime": 1620752523464,
          "status": "SUCCEEDED"
        },
        {
          "endTime": null,
          "id": "3",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.manifest.WaitForManifestStableTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "waitForManifestToStabilize",
          "stageEnd": true,
          "stageStart": false,
          "startTime": 1620752528755,
          "status": "RUNNING"
        }
      ],
      "type": "undoRolloutManifest"
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

```

## Keys

### `input.pipeline`

| Key                                               | Type      | Description |
| ------------------------------------------------- | --------- | ----------- |
| `input.pipeline.application`                      | `string`  |             |
| `input.pipeline.authentication.allowedAccounts[]` | `string`  |             |
| `input.pipeline.authentication.user`              | `string`  |             |
| `input.pipeline.buildTime`                        | `number`  |             |
| `input.pipeline.canceledBy`                       | ` `       |             |
| `input.pipeline.canceled`                         | `boolean` |             |
| `input.pipeline.cancellationReason`               | ` `       |             |
| `input.pipeline.description`                      | ` `       |             |
| `input.pipeline.description`                      | `string`  |             |
| `input.pipeline.endTime`                          | ` `       |             |
| `input.pipeline.endTime`                          | `number`  |             |
| `input.pipeline.id`                               | `string`  |             |
| `input.pipeline.keepWaitingPipelines`             | `boolean` |             |
| `input.pipeline.limitConcurrent`                  | `boolean` |             |
| `input.pipeline.name`                             | ` `       |             |
| `input.pipeline.name`                             | `string`  |             |
| `input.pipeline.origin`                           | `string`  |             |
| `input.pipeline.partition`                        | ` `       |             |
| `input.pipeline.paused`                           | ` `       |             |
| `input.pipeline.pipelineConfigId`                 | ` `       |             |
| `input.pipeline.pipelineConfigId`                 | `string`  |             |
| `input.pipeline.source`                           | ` `       |             |
| `input.pipeline.spelEvaluator`                    | ` `       |             |
| `input.pipeline.spelEvaluator`                    | `string`  |             |
| `input.pipeline.startTimeExpiry`                  | ` `       |             |
| `input.pipeline.startTime`                        | `number`  |             |
| `input.pipeline.status`                           | `string`  |             |
| `input.pipeline.templateVariables`                | ` `       |             |
| `input.pipeline.type`                             | `string`  |             |

### `input.pipeline.stages`

| Key                                                                                                    | Type      | Description |
| ------------------------------------------------------------------------------------------------------ | --------- | ----------- |
| `input.pipeline.stages[].context.account`                                                              | `string`  |             |
| `input.pipeline.stages[].context.action`                                                               | `string`  |             |
| `input.pipeline.stages[].context.alias`                                                                | `string`  |             |
| `input.pipeline.stages[].context.allowDeleteActive`                                                    | `boolean` |             |
| `input.pipeline.stages[].context.allowScaleDownActive`                                                 | `boolean` |             |
| `input.pipeline.stages[].context.amiSuffix`                                                            | `string`  |             |
| `input.pipeline.stages[].context.analysisType`                                                         | `string`  |             |
| `input.pipeline.stages[].context.app`                                                                  | `string`  |             |
| `input.pipeline.stages[].context.application`                                                          | `string`  |             |
| `input.pipeline.stages[].context.artifacts[].customKind`                                               | `boolean` |             |
| `input.pipeline.stages[].context.artifacts[].location`                                                 | `string`  |             |
| `input.pipeline.stages[].context.artifacts[].metadata.account`                                         | `string`  |             |
| `input.pipeline.stages[].context.artifacts[].name`                                                     | `string`  |             |
| `input.pipeline.stages[].context.artifacts[].reference`                                                | `string`  |             |
| `input.pipeline.stages[].context.artifacts[].type`                                                     | `string`  |             |
| `input.pipeline.stages[].context.artifacts[].version`                                                  | `string`  |             |
| `input.pipeline.stages[].context.attempt`                                                              | `number`  |             |
| `input.pipeline.stages[].context.availabilityZones.us-east-2[]`                                        | `string`  |             |
| `input.pipeline.stages[].context.baseLabel`                                                            | `string`  |             |
| `input.pipeline.stages[].context.baseOs`                                                               | `string`  |             |
| `input.pipeline.stages[].context.beforeStagePlanningFailed`                                            | `boolean` |             |
| `input.pipeline.stages[].context.canaryConfig.metricsAccountName`                                      | `string`  |             |
| `input.pipeline.stages[].context.canaryConfig.scopes[].scopeName`                                      | `string`  |             |
| `input.pipeline.stages[].context.canaryConfig.storageAccountName`                                      | `string`  |             |
| `input.pipeline.stages[].context.capacity.desired`                                                     | `number`  |             |
| `input.pipeline.stages[].context.capacity.max`                                                         | `number`  |             |
| `input.pipeline.stages[].context.capacity.min`                                                         | `number`  |             |
| `input.pipeline.stages[].context.cloudProviderType`                                                    | `string`  |             |
| `input.pipeline.stages[].context.cloudProvider`                                                        | `string`  |             |
| `input.pipeline.stages[].context.cluster`                                                              | `string`  |             |
| `input.pipeline.stages[].context.clusters[].account`                                                   | `string`  |             |
| `input.pipeline.stages[].context.clusters[].application`                                               | `string`  |             |
| `input.pipeline.stages[].context.clusters[].availabilityZones.us-east-2[]`                             | `string`  |             |
| `input.pipeline.stages[].context.clusters[].capacity.desired`                                          | `number`  |             |
| `input.pipeline.stages[].context.clusters[].capacity.max`                                              | `number`  |             |
| `input.pipeline.stages[].context.clusters[].capacity.min`                                              | `number`  |             |
| `input.pipeline.stages[].context.clusters[].cloudProvider`                                             | `string`  |             |
| `input.pipeline.stages[].context.clusters[].cooldown`                                                  | `number`  |             |
| `input.pipeline.stages[].context.clusters[].copySourceCustomBlockDeviceMappings`                       | `boolean` |             |
| `input.pipeline.stages[].context.clusters[].ebsOptimized`                                              | `boolean` |             |
| `input.pipeline.stages[].context.clusters[].freeFormDetails`                                           | `string`  |             |
| `input.pipeline.stages[].context.clusters[].healthCheckGracePeriod`                                    | `number`  |             |
| `input.pipeline.stages[].context.clusters[].healthCheckType`                                           | `string`  |             |
| `input.pipeline.stages[].context.clusters[].iamRole`                                                   | `string`  |             |
| `input.pipeline.stages[].context.clusters[].instanceMonitoring`                                        | `boolean` |             |
| `input.pipeline.stages[].context.clusters[].instanceType`                                              | `string`  |             |
| `input.pipeline.stages[].context.clusters[].keyPair`                                                   | `string`  |             |
| `input.pipeline.stages[].context.clusters[].provider`                                                  | `string`  |             |
| `input.pipeline.stages[].context.clusters[].reason`                                                    | `string`  |             |
| `input.pipeline.stages[].context.clusters[].spotPrice`                                                 | `string`  |             |
| `input.pipeline.stages[].context.clusters[].stack`                                                     | `string`  |             |
| `input.pipeline.stages[].context.clusters[].strategy`                                                  | `string`  |             |
| `input.pipeline.stages[].context.clusters[].subnetType`                                                | `string`  |             |
| `input.pipeline.stages[].context.clusters[].targetHealthyDeployPercentage`                             | `number`  |             |
| `input.pipeline.stages[].context.clusters[].terminationPolicies[]`                                     | `string`  |             |
| `input.pipeline.stages[].context.clusters[].useAmiBlockDeviceMappings`                                 | `boolean` |             |
| `input.pipeline.stages[].context.consecutiveNotFound`                                                  | `number`  |             |
| `input.pipeline.stages[].context.continuePipeline`                                                     | `boolean` |             |
| `input.pipeline.stages[].context.cooldown`                                                             | `number`  |             |
| `input.pipeline.stages[].context.copySourceCustomBlockDeviceMappings`                                  | `boolean` |             |
| `input.pipeline.stages[].context.credentials`                                                          | `string`  |             |
| `input.pipeline.stages[].context.ebsOptimized`                                                         | `boolean` |             |
| `input.pipeline.stages[].context.entityRef.entityId`                                                   | `string`  |             |
| `input.pipeline.stages[].context.entityRef.entityType`                                                 | `string`  |             |
| `input.pipeline.stages[].context.exception.details.error`                                              | `string`  |             |
| `input.pipeline.stages[].context.exception.details.errors[]`                                           | `string`  |             |
| `input.pipeline.stages[].context.exception.details.kind`                                               | `string`  |             |
| `input.pipeline.stages[].context.exception.details.responseBody`                                       | `string`  |             |
| `input.pipeline.stages[].context.exception.details.stackTrace`                                         | `string`  |             |
| `input.pipeline.stages[].context.exception.details.status`                                             | `number`  |             |
| `input.pipeline.stages[].context.exception.details.url`                                                | `string`  |             |
| `input.pipeline.stages[].context.exception.exceptionType`                                              | `string`  |             |
| `input.pipeline.stages[].context.exception.operation`                                                  | `string`  |             |
| `input.pipeline.stages[].context.exception.shouldRetry`                                                | `boolean` |             |
| `input.pipeline.stages[].context.exception.timestamp`                                                  | `number`  |             |
| `input.pipeline.stages[].context.executionOptions.successful`                                          | `boolean` |             |
| `input.pipeline.stages[].context.expectedArtifacts[].defaultArtifact.customKind`                       | `boolean` |             |
| `input.pipeline.stages[].context.expectedArtifacts[].defaultArtifact.id`                               | `string`  |             |
| `input.pipeline.stages[].context.expectedArtifacts[].displayName`                                      | `string`  |             |
| `input.pipeline.stages[].context.expectedArtifacts[].id`                                               | `string`  |             |
| `input.pipeline.stages[].context.expectedArtifacts[].matchArtifact.artifactAccount`                    | `string`  |             |
| `input.pipeline.stages[].context.expectedArtifacts[].matchArtifact.customKind`                         | `boolean` |             |
| `input.pipeline.stages[].context.expectedArtifacts[].matchArtifact.id`                                 | `string`  |             |
| `input.pipeline.stages[].context.expectedArtifacts[].matchArtifact.name`                               | `string`  |             |
| `input.pipeline.stages[].context.expectedArtifacts[].matchArtifact.type`                               | `string`  |             |
| `input.pipeline.stages[].context.expectedArtifacts[].useDefaultArtifact`                               | `boolean` |             |
| `input.pipeline.stages[].context.expectedArtifacts[].usePriorArtifact`                                 | `boolean` |             |
| `input.pipeline.stages[].context.expressionEvaluationSummary.trigger.buildInfo.number[].description`   | `string`  |             |
| `input.pipeline.stages[].context.expressionEvaluationSummary.trigger.buildInfo.number[].exceptionType` | `string`  |             |
| `input.pipeline.stages[].context.expressionEvaluationSummary.trigger.buildInfo.number[].level`         | `string`  |             |
| `input.pipeline.stages[].context.expressionEvaluationSummary.trigger.buildInfo.number[].timestamp`     | `number`  |             |
| `input.pipeline.stages[].context.failOnFailedExpressions`                                              | `boolean` |             |
| `input.pipeline.stages[].context.failPipeline`                                                         | `boolean` |             |
| `input.pipeline.stages[].context.freeFormDetails`                                                      | `string`  |             |
| `input.pipeline.stages[].context.healthCheckGracePeriod`                                               | `number`  |             |
| `input.pipeline.stages[].context.healthCheckType`                                                      | `string`  |             |
| `input.pipeline.stages[].context.iamRole`                                                              | `string`  |             |
| `input.pipeline.stages[].context.inputArtifacts[].account`                                             | `string`  |             |
| `input.pipeline.stages[].context.inputArtifacts[].id`                                                  | `string`  |             |
| `input.pipeline.stages[].context.instanceMonitoring`                                                   | `boolean` |             |
| `input.pipeline.stages[].context.instanceType`                                                         | `string`  |             |
| `input.pipeline.stages[].context.interestingHealthProviderNames[]`                                     | `string`  |             |
| `input.pipeline.stages[].context.kato.last.task.id.id`                                                 | `string`  |             |
| `input.pipeline.stages[].context.kato.result.expected`                                                 | `boolean` |             |
| `input.pipeline.stages[].context.keyPair`                                                              | `string`  |             |
| `input.pipeline.stages[].context.lastException`                                                        | `string`  |             |
| `input.pipeline.stages[].context.location`                                                             | `string`  |             |
| `input.pipeline.stages[].context.manifestArtifactId`                                                   | `string`  |             |
| `input.pipeline.stages[].context.manifestName`                                                         | `string`  |             |
| `input.pipeline.stages[].context.mode`                                                                 | `string`  |             |
| `input.pipeline.stages[].context.name`                                                                 | `string`  |             |
| `input.pipeline.stages[].context.namespace`                                                            | `string`  |             |
| `input.pipeline.stages[].context.notification.type`                                                    | `string`  |             |
| `input.pipeline.stages[].context.onlyEnabled`                                                          | `boolean` |             |
| `input.pipeline.stages[].context.options.mergeStrategy`                                                | `string`  |             |
| `input.pipeline.stages[].context.options.record`                                                       | `boolean` |             |
| `input.pipeline.stages[].context.outputName`                                                           | `string`  |             |
| `input.pipeline.stages[].context.package`                                                              | `string`  |             |
| `input.pipeline.stages[].context.patchBody[].apiVersion`                                               | `string`  |             |
| `input.pipeline.stages[].context.patchBody[].kind`                                                     | `string`  |             |
| `input.pipeline.stages[].context.patchBody[].metadata.name`                                            | `string`  |             |
| `input.pipeline.stages[].context.patchBody[].metadata.namespace`                                       | `string`  |             |
| `input.pipeline.stages[].context.patchBody[].spec.replicas`                                            | `string`  |             |
| `input.pipeline.stages[].context.patchBody[].spec.selector.matchLabels.app`                            | `string`  |             |
| `input.pipeline.stages[].context.patchBody[].spec.selector.matchLabels.version`                        | `string`  |             |
| `input.pipeline.stages[].context.patchBody[].spec.strategy.rollingUpdate.maxSurge`                     | `number`  |             |
| `input.pipeline.stages[].context.patchBody[].spec.strategy.rollingUpdate.maxUnavailable`               | `number`  |             |
| `input.pipeline.stages[].context.patchBody[].spec.strategy.type`                                       | `string`  |             |
| `input.pipeline.stages[].context.patchBody[].spec.template.metadata.annotations.prometheus.io/port`    | `string`  |             |
| `input.pipeline.stages[].context.patchBody[].spec.template.metadata.annotations.prometheus.io/scrape`  | `string`  |             |
| `input.pipeline.stages[].context.patchBody[].spec.template.metadata.labels.app`                        | `string`  |             |
| `input.pipeline.stages[].context.patchBody[].spec.template.metadata.labels.version`                    | `string`  |             |
| `input.pipeline.stages[].context.patchBody[].spec.template.spec.containers[].args[]`                   | `string`  |             |
| `input.pipeline.stages[].context.patchBody[].spec.template.spec.containers[].imagePullPolicy`          | `string`  |             |
| `input.pipeline.stages[].context.patchBody[].spec.template.spec.containers[].image`                    | `string`  |             |
| `input.pipeline.stages[].context.patchBody[].spec.template.spec.containers[].name`                     | `string`  |             |
| `input.pipeline.stages[].context.patchBody[].spec.template.spec.containers[].ports[].containerPort`    | `number`  |             |
| `input.pipeline.stages[].context.patchBody[].spec.template.spec.containers[].ports[].name`             | `string`  |             |
| `input.pipeline.stages[].context.patchBody[].spec.template.spec.containers[].ports[].protocol`         | `string`  |             |
| `input.pipeline.stages[].context.patchBody[].spec.template.spec.containers[].volumeMounts[].mountPath` | `string`  |             |
| `input.pipeline.stages[].context.patchBody[].spec.template.spec.containers[].volumeMounts[].name`      | `string`  |             |
| `input.pipeline.stages[].context.patchBody[].spec.template.spec.containers[].volumeMounts[].readOnly`  | `boolean` |             |
| `input.pipeline.stages[].context.patchBody[].spec.template.spec.containers[].volumeMounts[].subPath`   | `string`  |             |
| `input.pipeline.stages[].context.patchBody[].spec.template.spec.restartPolicy`                         | `string`  |             |
| `input.pipeline.stages[].context.patchBody[].spec.template.spec.volumes[].configMap.defaultMode`       | `number`  |             |
| `input.pipeline.stages[].context.patchBody[].spec.template.spec.volumes[].configMap.name`              | `string`  |             |
| `input.pipeline.stages[].context.patchBody[].spec.template.spec.volumes[].name`                        | `string`  |             |
| `input.pipeline.stages[].context.pipeline`                                                             | `string`  |             |
| `input.pipeline.stages[].context.pipelinesArtifactId`                                                  | `string`  |             |
| `input.pipeline.stages[].context.preferLargerOverNewer`                                                | `string`  |             |
| `input.pipeline.stages[].context.provider`                                                             | `string`  |             |
| `input.pipeline.stages[].context.reason`                                                               | `string`  |             |
| `input.pipeline.stages[].context.rebake`                                                               | `boolean` |             |
| `input.pipeline.stages[].context.region`                                                               | `string`  |             |
| `input.pipeline.stages[].context.regions[]`                                                            | `string`  |             |
| `input.pipeline.stages[].context.remainingEnabledServerGroups`                                         | `number`  |             |
| `input.pipeline.stages[].context.remainingFullSizeServerGroups`                                        | `number`  |             |
| `input.pipeline.stages[].context.resizeType`                                                           | `string`  |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].boundArtifact.customKind`                 | `boolean` |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].boundArtifact.location`                   | `string`  |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].boundArtifact.metadata.account`           | `string`  |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].boundArtifact.name`                       | `string`  |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].boundArtifact.reference`                  | `string`  |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].boundArtifact.type`                       | `string`  |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].boundArtifact.version`                    | `string`  |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].defaultArtifact.customKind`               | `boolean` |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].defaultArtifact.metadata.id`              | `string`  |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].id`                                       | `string`  |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].matchArtifact.customKind`                 | `boolean` |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].matchArtifact.metadata.id`                | `string`  |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].useDefaultArtifact`                       | `boolean` |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].usePriorArtifact`                         | `boolean` |             |
| `input.pipeline.stages[].context.retainLargerOverNewer`                                                | `string`  |             |
| `input.pipeline.stages[].context.selectionStrategy`                                                    | `string`  |             |
| `input.pipeline.stages[].context.shrinkToSize`                                                         | `number`  |             |
| `input.pipeline.stages[].context.source`                                                               | `string`  |             |
| `input.pipeline.stages[].context.spotPrice`                                                            | `string`  |             |
| `input.pipeline.stages[].context.stackArtifactAccount`                                                 | `string`  |             |
| `input.pipeline.stages[].context.stackArtifactId`                                                      | `string`  |             |
| `input.pipeline.stages[].context.stackName`                                                            | `string`  |             |
| `input.pipeline.stages[].context.stack`                                                                | `string`  |             |
| `input.pipeline.stages[].context.statusUrlResolution`                                                  | `string`  |             |
| `input.pipeline.stages[].context.storeType`                                                            | `string`  |             |
| `input.pipeline.stages[].context.strategy`                                                             | `string`  |             |
| `input.pipeline.stages[].context.subnetType`                                                           | `string`  |             |
| `input.pipeline.stages[].context.tags.TEST`                                                            | `string`  |             |
| `input.pipeline.stages[].context.tags.test`                                                            | `string`  |             |
| `input.pipeline.stages[].context.tags[].name`                                                          | `string`  |             |
| `input.pipeline.stages[].context.tags[].namespace`                                                     | `string`  |             |
| `input.pipeline.stages[].context.tags[].value`                                                         | `string`  |             |
| `input.pipeline.stages[].context.targetCluster`                                                        | `string`  |             |
| `input.pipeline.stages[].context.targetHealthyDeployPercentage`                                        | `number`  |             |
| `input.pipeline.stages[].context.targetHealthyRollbackPercentage`                                      | `number`  |             |
| `input.pipeline.stages[].context.targetLocation.type`                                                  | `string`  |             |
| `input.pipeline.stages[].context.targetLocation.value`                                                 | `string`  |             |
| `input.pipeline.stages[].context.target`                                                               | `string`  |             |
| `input.pipeline.stages[].context.templateRenderer`                                                     | `string`  |             |
| `input.pipeline.stages[].context.terminationPolicies[]`                                                | `string`  |             |
| `input.pipeline.stages[].context.type`                                                                 | `string`  |             |
| `input.pipeline.stages[].context.useAmiBlockDeviceMappings`                                            | `boolean` |             |
| `input.pipeline.stages[].context.useSourceCapacity`                                                    | `boolean` |             |
| `input.pipeline.stages[].context.user`                                                                 | `string`  |             |
| `input.pipeline.stages[].context.variables[].key`                                                      | `string`  |             |
| `input.pipeline.stages[].context.variables[].sourceValue`                                              | `string`  |             |
| `input.pipeline.stages[].context.variables[].value`                                                    | `string`  |             |
| `input.pipeline.stages[].context.vmType`                                                               | `string`  |             |
| `input.pipeline.stages[].context.waitForCompletion`                                                    | `boolean` |             |
| `input.pipeline.stages[].context.waitTime`                                                             | `number`  |             |
| `input.pipeline.stages[].endTime`                                                                      | ` `       |             |
| `input.pipeline.stages[].endTime`                                                                      | `number`  |             |
| `input.pipeline.stages[].id`                                                                           | `string`  |             |
| `input.pipeline.stages[].lastModified`                                                                 | ` `       |             |
| `input.pipeline.stages[].name`                                                                         | `string`  |             |
| `input.pipeline.stages[].outputs.artifacts[].customKind`                                               | `boolean` |             |
| `input.pipeline.stages[].outputs.artifacts[].location`                                                 | `string`  |             |
| `input.pipeline.stages[].outputs.artifacts[].metadata.account`                                         | `string`  |             |
| `input.pipeline.stages[].outputs.artifacts[].name`                                                     | `string`  |             |
| `input.pipeline.stages[].outputs.artifacts[].reference`                                                | `string`  |             |
| `input.pipeline.stages[].outputs.artifacts[].type`                                                     | `string`  |             |
| `input.pipeline.stages[].outputs.artifacts[].version`                                                  | `string`  |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].boundArtifact.customKind`                 | `boolean` |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].boundArtifact.location`                   | `string`  |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].boundArtifact.metadata.account`           | `string`  |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].boundArtifact.name`                       | `string`  |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].boundArtifact.reference`                  | `string`  |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].boundArtifact.type`                       | `string`  |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].boundArtifact.version`                    | `string`  |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].defaultArtifact.customKind`               | `boolean` |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].defaultArtifact.metadata.id`              | `string`  |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].id`                                       | `string`  |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].matchArtifact.customKind`                 | `boolean` |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].matchArtifact.metadata.id`                | `string`  |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].useDefaultArtifact`                       | `boolean` |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].usePriorArtifact`                         | `boolean` |             |
| `input.pipeline.stages[].outputs.test`                                                                 | `string`  |             |
| `input.pipeline.stages[].parentStageId`                                                                | ` `       |             |
| `input.pipeline.stages[].parentStageId`                                                                | `string`  |             |
| `input.pipeline.stages[].refId`                                                                        | `string`  |             |
| `input.pipeline.stages[].requisiteStageRefIds[]`                                                       | `string`  |             |
| `input.pipeline.stages[].scheduledTime`                                                                | ` `       |             |
| `input.pipeline.stages[].startTimeExpiry`                                                              | ` `       |             |
| `input.pipeline.stages[].startTime`                                                                    | ` `       |             |
| `input.pipeline.stages[].startTime`                                                                    | `number`  |             |
| `input.pipeline.stages[].status`                                                                       | `string`  |             |
| `input.pipeline.stages[].syntheticStageOwner`                                                          | ` `       |             |
| `input.pipeline.stages[].syntheticStageOwner`                                                          | `string`  |             |
| `input.pipeline.stages[].tasks[].endTime`                                                              | ` `       |             |
| `input.pipeline.stages[].tasks[].endTime`                                                              | `number`  |             |
| `input.pipeline.stages[].tasks[].id`                                                                   | `string`  |             |
| `input.pipeline.stages[].tasks[].implementingClass`                                                    | `string`  |             |
| `input.pipeline.stages[].tasks[].loopEnd`                                                              | `boolean` |             |
| `input.pipeline.stages[].tasks[].loopStart`                                                            | `boolean` |             |
| `input.pipeline.stages[].tasks[].name`                                                                 | `string`  |             |
| `input.pipeline.stages[].tasks[].stageEnd`                                                             | `boolean` |             |
| `input.pipeline.stages[].tasks[].stageStart`                                                           | `boolean` |             |
| `input.pipeline.stages[].tasks[].startTime`                                                            | ` `       |             |
| `input.pipeline.stages[].tasks[].startTime`                                                            | `number`  |             |
| `input.pipeline.stages[].tasks[].status`                                                               | `string`  |             |
| `input.pipeline.stages[].type`                                                                         | `string`  |             |
| `input.pipeline.stages[]`                                                                              | `string`  |             |


### `input.pipeline.trigger`

| Key                                                                                        | Type      | Description |
| ------------------------------------------------------------------------------------------ | --------- | ----------- |
| `input.pipeline.trigger.artifacts[].artifactAccount`                                       | `string`  |             |
| `input.pipeline.trigger.artifacts[].customKind`                                            | `boolean` |             |
| `input.pipeline.trigger.artifacts[].location`                                              | ` `       |             |
| `input.pipeline.trigger.artifacts[].metadata.id`                                           | `string`  |             |
| `input.pipeline.trigger.artifacts[].name`                                                  | `string`  |             |
| `input.pipeline.trigger.artifacts[].provenance`                                            | ` `       |             |
| `input.pipeline.trigger.artifacts[].reference`                                             | `string`  |             |
| `input.pipeline.trigger.artifacts[].type`                                                  | `string`  |             |
| `input.pipeline.trigger.artifacts[].uuid`                                                  | ` `       |             |
| `input.pipeline.trigger.artifacts[].version`                                               | `string`  |             |
| `input.pipeline.trigger.correlationId`                                                     | ` `       |             |
| `input.pipeline.trigger.isDryRun`                                                          | `boolean` |             |
| `input.pipeline.trigger.isRebake`                                                          | `boolean` |             |
| `input.pipeline.trigger.isStrategy`                                                        | `boolean` |             |
| `input.pipeline.trigger.other.artifacts[].artifactAccount`                                 | `string`  |             |
| `input.pipeline.trigger.other.artifacts[].customKind`                                      | `boolean` |             |
| `input.pipeline.trigger.other.artifacts[].metadata.id`                                     | `string`  |             |
| `input.pipeline.trigger.other.artifacts[].name`                                            | `string`  |             |
| `input.pipeline.trigger.other.artifacts[].reference`                                       | `string`  |             |
| `input.pipeline.trigger.other.artifacts[].type`                                            | `string`  |             |
| `input.pipeline.trigger.other.artifacts[].version`                                         | `string`  |             |
| `input.pipeline.trigger.other.dryRun`                                                      | `boolean` |             |
| `input.pipeline.trigger.other.enabled`                                                     | `boolean` |             |
| `input.pipeline.trigger.other.eventId`                                                     | `string`  |             |
| `input.pipeline.trigger.other.executionId`                                                 | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].boundArtifact.artifactAccount`           | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].boundArtifact.customKind`                | `boolean` |             |
| `input.pipeline.trigger.other.expectedArtifacts[].boundArtifact.metadata.id`               | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].boundArtifact.name`                      | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].boundArtifact.reference`                 | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].boundArtifact.type`                      | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].boundArtifact.version`                   | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].defaultArtifact.artifactAccount`         | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].defaultArtifact.customKind`              | `boolean` |             |
| `input.pipeline.trigger.other.expectedArtifacts[].defaultArtifact.metadata.id`             | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].defaultArtifact.name`                    | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].defaultArtifact.reference`               | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].defaultArtifact.type`                    | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].defaultArtifact.version`                 | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].id`                                      | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].matchArtifact.artifactAccount`           | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].matchArtifact.customKind`                | `boolean` |             |
| `input.pipeline.trigger.other.expectedArtifacts[].matchArtifact.metadata.id`               | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].matchArtifact.name`                      | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].matchArtifact.type`                      | `string`  |             |
| `input.pipeline.trigger.other.expectedArtifacts[].useDefaultArtifact`                      | `boolean` |             |
| `input.pipeline.trigger.other.expectedArtifacts[].usePriorArtifact`                        | `boolean` |             |
| `input.pipeline.trigger.other.preferred`                                                   | `boolean` |             |
| `input.pipeline.trigger.other.rebake`                                                      | `boolean` |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].boundArtifact.artifactAccount`   | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].boundArtifact.customKind`        | `boolean` |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].boundArtifact.metadata.id`       | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].boundArtifact.name`              | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].boundArtifact.reference`         | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].boundArtifact.type`              | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].boundArtifact.version`           | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].defaultArtifact.artifactAccount` | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].defaultArtifact.customKind`      | `boolean` |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].defaultArtifact.metadata.id`     | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].defaultArtifact.name`            | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].defaultArtifact.reference`       | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].defaultArtifact.type`            | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].defaultArtifact.version`         | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].id`                              | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].matchArtifact.artifactAccount`   | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].matchArtifact.customKind`        | `boolean` |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].matchArtifact.metadata.id`       | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].matchArtifact.name`              | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].matchArtifact.type`              | `string`  |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].useDefaultArtifact`              | `boolean` |             |
| `input.pipeline.trigger.other.resolvedExpectedArtifacts[].usePriorArtifact`                | `boolean` |             |
| `input.pipeline.trigger.other.strategy`                                                    | `boolean` |             |
| `input.pipeline.trigger.other.type`                                                        | `string`  |             |
| `input.pipeline.trigger.other.user`                                                        | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.artifactAccount`         | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.customKind`              | `boolean` |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.location`                | ` `       |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.metadata.id`             | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.name`                    | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.provenance`              | ` `       |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.reference`               | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.type`                    | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.uuid`                    | ` `       |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.version`                 | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.artifactAccount`       | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.customKind`            | `boolean` |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.location`              | ` `       |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.metadata.id`           | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.name`                  | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.provenance`            | ` `       |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.reference`             | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.type`                  | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.uuid`                  | ` `       |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.version`               | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].id`                                    | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.artifactAccount`         | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.customKind`              | `boolean` |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.location`                | ` `       |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.metadata.id`             | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.name`                    | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.provenance`              | ` `       |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.reference`               | ` `       |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.type`                    | `string`  |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.uuid`                    | ` `       |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].matchArtifact.version`                 | ` `       |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].useDefaultArtifact`                    | `boolean` |             |
| `input.pipeline.trigger.resolvedExpectedArtifacts[].usePriorArtifact`                      | `boolean` |             |
| `input.pipeline.trigger.type`                                                              | `string`  |             |
| `input.pipeline.trigger.user`                                                              | `string`  |             |

### `input.stage`

| Key                                                              | Type      | Description |
| ---------------------------------------------------------------- | --------- | ----------- |
| `input.stage.context.account`                                    | `string`  |             |
| `input.stage.context.cloudProvider`                              | `string`  |             |
| `input.stage.context.kato.last.task.id.id`                       | `string`  |             |
| `input.stage.context.kato.result.expected`                       | `boolean` |             |
| `input.stage.context.kato.task.firstNotFoundRetry`               | `number`  |             |
| `input.stage.context.kato.task.lastStatus`                       | `string`  |             |
| `input.stage.context.kato.task.notFoundRetryCount`               | `number`  |             |
| `input.stage.context.kato.task.terminalRetryCount`               | `number`  |             |
| `input.stage.context.kato.tasks[].history[].phase`               | `string`  |             |
| `input.stage.context.kato.tasks[].history[].status`              | `string`  |             |
| `input.stage.context.kato.tasks[].id`                            | `string`  |             |
| `input.stage.context.kato.tasks[].status.completed`              | `boolean` |             |
| `input.stage.context.kato.tasks[].status.failed`                 | `boolean` |             |
| `input.stage.context.kato.tasks[].status.retryable`              | `boolean` |             |
| `input.stage.context.location`                                   | `string`  |             |
| `input.stage.context.manifest.account.name`                      | `string`  |             |
| `input.stage.context.manifest.location`                          | `string`  |             |
| `input.stage.context.manifest.name`                              | `string`  |             |
| `input.stage.context.manifestName`                               | `string`  |             |
| `input.stage.context.messages[]`                                 | `string`  |             |
| `input.stage.context.mode`                                       | `string`  |             |
| `input.stage.context.numRevisionsBack`                           | `number`  |             |
| `input.stage.context.outputs.manifestNamesByNamespace.staging[]` | `string`  |             |
| `input.stage.context.reason`                                     | `string`  |             |
| `input.stage.context.revision`                                   | `string`  |             |
| `input.stage.context.user`                                       | `string`  |             |
| `input.stage.endTime`                                            | ` `       |             |
| `input.stage.id`                                                 | `string`  |             |
| `input.stage.lastModified`                                       | ` `       |             |
| `input.stage.name`                                               | `string`  |             |
| `input.stage.parentStageId`                                      | ` `       |             |
| `input.stage.refId`                                              | `string`  |             |
| `input.stage.scheduledTime`                                      | ` `       |             |
| `input.stage.startTimeExpiry`                                    | ` `       |             |
| `input.stage.startTime`                                          | `number`  |             |
| `input.stage.status`                                             | `string`  |             |
| `input.stage.syntheticStageOwner`                                | ` `       |             |
| `input.stage.tasks[].endTime`                                    | ` `       |             |
| `input.stage.tasks[].endTime`                                    | `number`  |             |
| `input.stage.tasks[].id`                                         | `string`  |             |
| `input.stage.tasks[].implementingClass`                          | `string`  |             |
| `input.stage.tasks[].loopEnd`                                    | `boolean` |             |
| `input.stage.tasks[].loopStart`                                  | `boolean` |             |
| `input.stage.tasks[].name`                                       | `string`  |             |
| `input.stage.tasks[].stageEnd`                                   | `boolean` |             |
| `input.stage.tasks[].stageStart`                                 | `boolean` |             |
| `input.stage.tasks[].startTime`                                  | ` `       |             |
| `input.stage.tasks[].startTime`                                  | `number`  |             |
| `input.stage.tasks[].status`                                     | `string`  |             |
| `input.stage.type`                                               | `string`  |             |

### `input.user`

| Key                   | Type      | Description |
| --------------------- | --------- | ----------- |
| `input.user.isAdmin`  | `boolean` |             |
| `input.user.username` | `string`  |             |