---
title: "spinnaker.execution.stages.before.savePipeline"
linktitle: "savePipeline"
description: "A policy targeting this object runs before executing each task in a savePipeline stage."
weight: 10
---

This package contains a subset of the functionality found in opa.pipelines. Armory reccomends using the `opa.pipelines` package instead of this package for most usecases.

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
      "buildTime": 1620677310519,
      "canceled": false,
      "canceledBy": null,
      "cancellationReason": null,
      "description": "Save pipeline 'scale deployments'",
      "endTime": null,
      "id": "01F5BYAE1QTW4WBT6V3GWRE0KX",
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
      "stages": [],
      "startTime": 1620677310559,
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
        "application": "hostname",
        "notification.type": "savepipeline",
        "pipeline": "eyJhcHBsaWNhdGlvbiI6Imhvc3RuYW1lIiwiZXhwZWN0ZWRBcnRpZmFjdHMiOlt7ImRlZmF1bHRBcnRpZmFjdCI6eyJhcnRpZmFjdEFjY291bnQiOiJzdGVwaGVuYXR3ZWxsIiwiaWQiOiI0YWE4NTE3OC0wNjE4LTQ2YzQtYjUzMC02ODgzZDM5MzY1NmQiLCJuYW1lIjoibWFuaWZlc3RzL2RlcGxveS1zcGlubmFrZXIueWFtbCIsInJlZmVyZW5jZSI6Ikh0dHBzOi8vYXBpLmdpdGh1Yi5jb20vcmVwb3Mvc3RlcGhlbmF0d2VsbC9ob3N0bmFtZS9jb250ZW50cy9tYW5pZmVzdHMvZGVwbG95LXNwaW5uYWtlci55YW1sIiwidHlwZSI6ImdpdGh1Yi9maWxlIiwidmVyc2lvbiI6Im1hc3RlciJ9LCJkaXNwbGF5TmFtZSI6Imhvc3RuYW1lLWRlcGxveSIsImlkIjoiMGNmOTgwMzItMWIwZi00OGRiLTkzMTQtMDljNjkyOTNiM2E2IiwibWF0Y2hBcnRpZmFjdCI6eyJhcnRpZmFjdEFjY291bnQiOiJzdGVwaGVuYXR3ZWxsIiwiY3VzdG9tS2luZCI6dHJ1ZSwiaWQiOiIzZjcyZWQ4ZS1jYjk1LTQ1NGYtOTExOS0yMzIzNjgyMTIxZmYiLCJuYW1lIjoibWFuaWZlc3RzL2RlcGxveS1zcGlubmFrZXIueWFtbCIsInR5cGUiOiJnaXRodWIvZmlsZSJ9LCJ1c2VEZWZhdWx0QXJ0aWZhY3QiOnRydWUsInVzZVByaW9yQXJ0aWZhY3QiOmZhbHNlfSx7ImRlZmF1bHRBcnRpZmFjdCI6eyJhcnRpZmFjdEFjY291bnQiOiJzdGVwaGVuYXR3ZWxsIiwiaWQiOiJlNzkxNjJhYi02OWNiLTRmZjctYWNmNC1hOGYyODc1ZWY4ZWYiLCJuYW1lIjoibWFuaWZlc3RzL3NlcnZpY2Utc3Bpbm5ha2VyLnlhbWwiLCJyZWZlcmVuY2UiOiJIdHRwczovL2FwaS5naXRodWIuY29tL3JlcG9zL3N0ZXBoZW5hdHdlbGwvaG9zdG5hbWUvY29udGVudHMvbWFuaWZlc3RzL3NlcnZpY2Utc3Bpbm5ha2VyLnlhbWwiLCJ0eXBlIjoiZ2l0aHViL2ZpbGUifSwiZGlzcGxheU5hbWUiOiJzZXJ2aWNlLWhvc3RuYW1lIiwiaWQiOiI0MjVkMjBhOC0yOTQyLTQ5MDItOGQyYi0yNzc3NjlhMTQ5MmMiLCJtYXRjaEFydGlmYWN0Ijp7ImFydGlmYWN0QWNjb3VudCI6InN0ZXBoZW5hdHdlbGwiLCJjdXN0b21LaW5kIjp0cnVlLCJpZCI6ImQ3YWM3ZWNhLTAxMzEtNGQ1NC1hYjhmLTg4MGZmMDA0MWU0ZiIsIm5hbWUiOiJtYW5pZmVzdHMvc2VydmljZS1zcGlubmFrZXIiLCJ0eXBlIjoiZ2l0aHViL2ZpbGUifSwidXNlRGVmYXVsdEFydGlmYWN0Ijp0cnVlLCJ1c2VQcmlvckFydGlmYWN0IjpmYWxzZX1dLCJpZCI6IjdkYjFlMzUwLWRlZGItNGRjMS05OTc2LWU3MWY5N2I1ZjEzMiIsImluZGV4IjowLCJrZWVwV2FpdGluZ1BpcGVsaW5lcyI6ZmFsc2UsImxhc3RNb2RpZmllZEJ5Ijoic3RlcGhlbmF0d2VsbCIsImxpbWl0Q29uY3VycmVudCI6dHJ1ZSwibmFtZSI6InNjYWxlIGRlcGxveW1lbnRzIiwicGFyYW1ldGVyQ29uZmlnIjpbeyJkZWZhdWx0IjoiIiwiZGVzY3JpcHRpb24iOiIiLCJoYXNPcHRpb25zIjpmYWxzZSwibGFiZWwiOiIiLCJuYW1lIjoicmVwbGljYXMiLCJvcHRpb25zIjpbeyJ2YWx1ZSI6IiJ9XSwicGlubmVkIjpmYWxzZSwicmVxdWlyZWQiOmZhbHNlfSx7ImRlZmF1bHQiOiJzdGFnaW5nIiwiZGVzY3JpcHRpb24iOiIiLCJoYXNPcHRpb25zIjpmYWxzZSwibGFiZWwiOiIiLCJuYW1lIjoibmFtZXNwYWNlIiwib3B0aW9ucyI6W3sidmFsdWUiOiIifV0sInBpbm5lZCI6ZmFsc2UsInJlcXVpcmVkIjp0cnVlfV0sInNwZWxFdmFsdWF0b3IiOiJ2NCIsInN0YWdlcyI6W3siYWNjb3VudCI6InNwaW5uYWtlciIsImNsb3VkUHJvdmlkZXIiOiJrdWJlcm5ldGVzIiwibWFuaWZlc3RBcnRpZmFjdElkIjoiMGNmOTgwMzItMWIwZi00OGRiLTkzMTQtMDljNjkyOTNiM2E2IiwibW9uaWtlciI6eyJhcHAiOiJob3N0bmFtZSJ9LCJuYW1lIjoiRGVwbG95IChNYW5pZmVzdCkiLCJyZWZJZCI6IjIiLCJyZXF1aXNpdGVTdGFnZVJlZklkcyI6W10sInNraXBFeHByZXNzaW9uRXZhbHVhdGlvbiI6ZmFsc2UsInNvdXJjZSI6ImFydGlmYWN0IiwidHJhZmZpY01hbmFnZW1lbnQiOnsiZW5hYmxlZCI6ZmFsc2UsIm9wdGlvbnMiOnsiZW5hYmxlVHJhZmZpYyI6ZmFsc2UsInNlcnZpY2VzIjpbXX19LCJ0eXBlIjoiZGVwbG95TWFuaWZlc3QifSx7ImFjY291bnQiOiJzcGlubmFrZXIiLCJjbG91ZFByb3ZpZGVyIjoia3ViZXJuZXRlcyIsIm1hbmlmZXN0QXJ0aWZhY3RJZCI6IjQyNWQyMGE4LTI5NDItNDkwMi04ZDJiLTI3Nzc2OWExNDkyYyIsIm1vbmlrZXIiOnsiYXBwIjoiaG9zdG5hbWUifSwibmFtZSI6IkRlcGxveSBzZXJ2aWNlIChNYW5pZmVzdCkiLCJyZWZJZCI6IjMiLCJyZXF1aXNpdGVTdGFnZVJlZklkcyI6W10sInNraXBFeHByZXNzaW9uRXZhbHVhdGlvbiI6ZmFsc2UsInNvdXJjZSI6ImFydGlmYWN0IiwidHJhZmZpY01hbmFnZW1lbnQiOnsiZW5hYmxlZCI6ZmFsc2UsIm9wdGlvbnMiOnsiZW5hYmxlVHJhZmZpYyI6ZmFsc2UsInNlcnZpY2VzIjpbXX19LCJ0eXBlIjoiZGVwbG95TWFuaWZlc3QifSx7ImNvbXBsZXRlT3RoZXJCcmFuY2hlc1RoZW5GYWlsIjpmYWxzZSwiY29udGludWVQaXBlbGluZSI6dHJ1ZSwiZmFpbFBpcGVsaW5lIjpmYWxzZSwiaW5zdHJ1Y3Rpb25zIjoiaXMgdGhlIG5ldyBzZXJ2aWNlIHdvcmtpbmc/IiwianVkZ21lbnRJbnB1dHMiOltdLCJuYW1lIjoiTWFudWFsIEp1ZGdtZW50Iiwibm90aWZpY2F0aW9ucyI6W10sInJlZklkIjoiNCIsInJlcXVpc2l0ZVN0YWdlUmVmSWRzIjpbIjIiLCIzIl0sInN0YWdlVGltZW91dE1zIjo2MDAwMCwidHlwZSI6Im1hbnVhbEp1ZGdtZW50In0seyJhY2NvdW50Ijoic3Bpbm5ha2VyIiwiYXBwIjoiaG9zdG5hbWUiLCJjbG91ZFByb3ZpZGVyIjoia3ViZXJuZXRlcyIsImxvY2F0aW9uIjoic3RhZ2luZyIsIm1hbmlmZXN0TmFtZSI6ImRlcGxveW1lbnQgaG9zdG5hbWUiLCJtb2RlIjoic3RhdGljIiwibmFtZSI6IlNjYWxlIChNYW5pZmVzdCkiLCJyZWZJZCI6IjUiLCJyZXBsaWNhcyI6IjEwIiwicmVxdWlzaXRlU3RhZ2VSZWZJZHMiOlsiNCJdLCJ0eXBlIjoic2NhbGVNYW5pZmVzdCJ9XSwidHJpZ2dlcnMiOlt7ImJyYW5jaCI6Im1hc3RlciIsImVuYWJsZWQiOnRydWUsImV4cGVjdGVkQXJ0aWZhY3RJZHMiOlsiMGNmOTgwMzItMWIwZi00OGRiLTkzMTQtMDljNjkyOTNiM2E2IiwiNDI1ZDIwYTgtMjk0Mi00OTAyLThkMmItMjc3NzY5YTE0OTJjIl0sInByb2plY3QiOiJzdGVwaGVuYXR3ZWxsIiwic2VjcmV0Ijoic3Bpbm5ha2VyIiwic2x1ZyI6Imhvc3RuYW1lIiwic291cmNlIjoiZ2l0aHViIiwidHlwZSI6ImdpdCJ9XSwidXBkYXRlVHMiOiIxNjIwNDE5OTQ2MDAwIn0=",
        "pipeline.id": "7db1e350-dedb-4dc1-9976-e71f97b5f132",
        "pipeline.name": "scale deployments",
        "staleCheck": true,
        "user": "myUserName"
      },
      "endTime": null,
      "id": "01F5BYAE1Q1GFVPXQM49ZS0XXQ",
      "lastModified": null,
      "name": "savePipeline",
      "outputs": {},
      "parentStageId": null,
      "refId": "0",
      "requisiteStageRefIds": [],
      "scheduledTime": null,
      "startTime": 1620677310574,
      "startTimeExpiry": null,
      "status": "RUNNING",
      "syntheticStageOwner": null,
      "tasks": [
        {
          "endTime": 1620677311043,
          "id": "1",
          "implementingClass": "com.netflix.spinnaker.orca.front50.tasks.SavePipelineTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "savePipeline",
          "stageEnd": false,
          "stageStart": true,
          "startTime": 1620677310632,
          "status": "SUCCEEDED"
        },
        {
          "endTime": null,
          "id": "2",
          "implementingClass": "com.netflix.spinnaker.orca.front50.tasks.MonitorFront50Task",
          "loopEnd": false,
          "loopStart": false,
          "name": "waitForPipelineSave",
          "stageEnd": true,
          "stageStart": false,
          "startTime": 1620677311058,
          "status": "RUNNING"
        }
      ],
      "type": "savePipeline"
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

## Example policy

This policy allows you to restrict which named users can edit which pipelines for which applications. Any pipeline not explicitly specified in the policy is editable as usual.

```opa
package spinnaker.execution.stages.before.savePipeline
    
    # This map specifies the name of the app, the name of the pipeline, and a list of users that can edit it.
    allowed_editors:=[{"app":"myAppName","name": "myPipelineName","users":["myUsername"]},{"app":"app","name": "name1","users":[]}]
    
    deny["You do not have permission to edit this pipeline."]{
       not canEdit(input.user.username)      
    }   
      
    default allowedEditors=null
    
    allowedEditors = val{
      pipeline := json.unmarshal(base64.decode(input.stage.context.pipeline))
      some i
      pipeline.name==allowed_editors[i].name
      pipeline.application==allowed_editors[i].app
      val=allowed_editors[i].users    
    }
        
    canEdit(user){
    	allowedEditors[_]==user
    }{ #allow editing any apps/pipelines for which rules have not been defined.
        allowedEditors==null
    }
```

## Keys

Parameters related to the stage against which the policy is executing can be found in the [input.stage.context](#inputstagecontext) object.

### input.pipeline

| Key                                                | Type      | Description                                                                                                                                       |
| -------------------------------------------------- | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| `input.pipeline.application`                       | `string`  | The name of the Spinnaker application for this pipeline.                                                                                          |
| `input.pipeline.authentication.allowedAccounts.[]` | `string`  | `[array]` of accounts Spinnaker is authorized to access.                                                                                          |
| `input.pipeline.authentication.user`               | `string`  | The Spinnaker user initiating the change.                                                                                                         |
| `input.pipeline.buildTime`                         | `number`  |                                                                                                                                                   |
| `input.pipeline.canceled`                          | `boolean` |                                                                                                                                                   |
| `input.pipeline.canceledBy`                        |           |                                                                                                                                                   |
| `input.pipeline.cancellationReason`                |           |                                                                                                                                                   |
| `input.pipeline.description`                       | `string`  | Description of the pipeline defined in the UI.                                                                                                    |
| `input.pipeline.endTime`                           |           |                                                                                                                                                   |
| `input.pipeline.id`                                | `string`  | The unique ID of the pipeline.                                                                                                                    |
| `input.pipeline.keepWaitingPipelines`              | `boolean` | If false and concurrent pipeline execution is disabled, then the pipelines in the waiting queue gets canceled when the next execution starts. |
| `input.pipeline.limitConcurrent`                   | `boolean` | True if only 1 concurrent execution of this pipeline is allowed.                                                                                  |
| `input.pipeline.name`                              |           | The name of this pipeline.                                                                                                                        |
| `input.pipeline.origin`                            | `string`  |                                                                                                                                                   |
| `input.pipeline.partition`                         |           |                                                                                                                                                   |
| `input.pipeline.paused`                            |           |                                                                                                                                                   |
| `input.pipeline.pipelineConfigId`                  |           |                                                                                                                                                   |
| `input.pipeline.source`                            |           |                                                                                                                                                   |
| `input.pipeline.spelEvaluator`                     |           | Which version of spring expression language is being used to evaluate SpEL.                                                                       |
| `input.pipeline.stages[]`                          | `[array]` | An array of the stages in the pipeline. Typically if you are writing a policy that examines multiple pipeline stages, it is better to write that policy against either the `opa.pipelines package`, or the `spinnaker.execution.pipelines.before` package. |
| `input.pipeline.startTime`                         | `number`  | Timestamp from when the pipeline was started.                                                                                                     |
| `input.pipeline.startTimeExpiry`                   |           | Unix epoch date at which the pipeline expires.                                                                                                |
| `input.pipeline.status`                            | `string`  |                                                                                                                                                   |
| `input.pipeline.templateVariables`                 |           |                                                                                                                                                   |
| `input.pipeline.type`                              | `string`  |                                                                                                                                                   |

### input.pipeline.trigger

See [input.pipeline.trigger]({{< ref "input.pipeline.trigger.md" >}}) for more information.

### input.stage

See [`input.stage`]({{< ref "input.stage.md" >}}) for more information.

### input.stage.context

| Key                                     | Type      | Description                                                               |
| --------------------------------------- | --------- | ------------------------------------------------------------------------- |
| `input.stage.context.application`       | `string`  | The name of the Spinnaker application for this pipeline.                  |
| `input.stage.context.notification.type` | `string`  | What type of spinnaker stage is this.                                     |
| `input.stage.context.pipeline`          | `string`  | a base 64 encoded json represenation of the pipeline that is being saved. |
| `input.stage.context.pipeline.id`       | `string`  |                                                                           |
| `input.stage.context.pipeline.name`     | `string`  | The name of this pipeline.                                                |
| `input.stage.context.staleCheck`        | `boolean` |                                                                           |
| `input.stage.context.user`              | `string`  | The Spinnaker user initiating the change.                                 |

### input.user

This object provides information about the user performing the action. This can be used to restrict actions by role. See [input.user]({{< ref "input.user.md" >}}) for more information.

