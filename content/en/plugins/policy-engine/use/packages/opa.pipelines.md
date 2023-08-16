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

## Manual approval by role

Requires a manual approval by the `qa` role, and a manual approval by the `infosec` role happen earlier in a pipeline than any deployment to a production account. Production accounts must have been loaded into the OPA data document in an array named `production_accounts`:

  ```rego
  package opa.pipelines

  deny["production deploy stage must follow approval by 'qa' and 'infosec'"] {
    some j
    stage :=input.pipeline.stages[j]
    stage.type=="deployManifest"
    stage.account==data.production_accounts[_] 
    lacksEarlierApprovalBy(["qa","infosec"][_],j)  
  }

  stage_graph[idx]  = edges { #converts stage graph into the structure rego needs
    input.pipeline.stages[idx]
    edges := {neighbor | input.pipeline.stages[neighbor].refId ==   
                    input.pipeline.stages[idx].requisiteStageRefIds[_]}
  }

  hasEarlierApprovalBy(role, idx){
      stage := input.pipeline.stages[i]
      stage.type=="manualJudgment"
      stage.selectedStageRoles[0]==role; count(stage.selectedStageRoles)==1
      reachable := graph.reachable(stage_graph, {idx})[_]
      reachable ==i
  }
  lacksEarlierApprovalBy(role,idx) {
      not hasEarlierApprovalBy(role,idx) 
  }
  ```

## Allow list for target namespaces

Only allows applications to deploy to namespaces that are on an allow list.

  ```rego
  package opa.pipelines

  allowedNamespaces:=[{"app":"app1","ns": ["ns1","ns2"]},
                                      {"app":"app2", "ns":["ns3"]}]

  deny["Stage deploys to a namespace to which this application lacks access"]{
      ns :=object.get(input.stage.context.manifests[_].metadata,"namespace","default")
      application := input.pipeline.application
      not canDeploy(ns, application)
  }

  canDeploy(namespace, application){
      some i
      allowedNamespaces[i].app==application
      allowedNamespaces[i].ns[_]==namespace
  }
  ```

## Deployment window

The policy prevents a user from saving a pipeline that deploys to production accounts unless the first stage of the pipeline specifies a schedule that prevents it from starting executions between 2pm and 7pm Pacific Standard Time (PST). 

  ```rego
  package opa.pipelines
  
  productionAccounts:=["spinnaker"]
  
  deny ["Your first stage must configure a blackout window that prevents an execution from starting between 2pm and 7pm PST."] {
  # Restrict to just one app in my demo environment
  some i
  # Check whether or not this stage is at the beginning of the pipeline by verifying if it it depends on a  stage
      count(input.pipeline.stages[i].requisiteStageRefIds)==0
      input.pipeline.stages[_].account==productionAccounts[_]
      
      executionWindow := object.get(input.pipeline.stages[i],"restrictedExecutionWindow",null)
      
      # If no execution windoe is defined, or if a prohibited one is defined, then prevent execution.
      any([executionWindow ==null,
           isExecutionProhibitedDuringWindow(executionWindow)])
  }
  
  # Prevent the stage from executing between 2PM/14:00 and 7PM/19:00 PST by defining a window of time when deployments are allowed
      isExecutionProhibitedDuringWindow(window){
        some i
        # Window overlaps the start of the blackout window.
        window.whitelist[i].startHour<13
        window.whitelist[i].endHour>13
      }{
        some i
        # Window overlaps the end of the blackout window.
        window.whitelist[i].startHour<19
        window.whitelist[i].endHour>19
      }{ # Window overlaps the start of the blackout window starting on a prior day.
        window.whitelist[i].endHour<window.whitelist[i].startHour
        window.whitelist[i].endHour>13
      }{ # Window overlaps the start of the blackout window starting on a prior day.
        window.whitelist[i].endHour<window.whitelist[i].startHour
        window.whitelist[i].startHour<19
      }
      {
        count(window.whitelist)==0
      }
  ```


## Keys

| Key                                                               | Type      | Description                                                                                                                                                                                                             |
| :---------------------------------------------------------------- | :-------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `input.pipeline.application`                                      | `string`  | The name of the Spinnaker application to which this pipeline belongs.                                                                                                                                                   |
| `input.pipeline.expectedArtifacts[]`                              | `[array]` | See [artifacts]({{< ref "artifacts.md" >}}) for more information.                                                                                                                                                       |
| `input.pipeline.id`                                               | `string`  | The unique ID of the pipeline                                                                                                                                                                                           |
| `input.pipeline.index`                                            | `number`  |                                                                                                                                                                                                                         |
| `input.pipeline.keepWaitingPipelines`                             | `boolean` | If false and concurrent pipeline execution is disabled, then the pipelines in the waiting queue gets canceled when the next execution starts.                                                                       |
| `input.pipeline.lastModifiedBy`                                   | `string`  | The ID of the user that last modified the pipeline.                                                                                                                                                                     |
| `input.pipeline.limitConcurrent`                                  | `boolean` | True if only 1 concurrent execution of this pipeline is allowed.                                                                                                                                                        |
| `input.pipeline.name`                                             | `string`  | The name of this pipeline.                                                                                                                                                                                              |
| `input.pipeline.parameterConfig[].default`                        | `string`  | The default value associated with this parameter.                                                                                                                                                                       |
| `input.pipeline.parameterConfig[].description`                    | `string`  | (Optional): If supplied, is displayed to users as a tooltip when triggering the pipeline manually. You can include HTML in this field.                                                                             |
| `input.pipeline.parameterConfig[].hasOptions`                     | `boolean` | True if the **Show Options** checkbox in the parameter is checked.                                                                                                                                                      |
| `input.pipeline.parameterConfig[].label`                          | `string`  | The display name of the parameter.                                                                                                                                                                                      |
| `input.pipeline.parameterConfig[].name`                           | `string`  | The parameter name that can be used in SpEL.                                                                                                                                                                            |
| `input.pipeline.parameterConfig[].options[].value`                | `string`  | The value for this option in a multi-option parameter.                                                                                                                                                                  |
| `input.pipeline.parameterConfig[].pinned`                         | `boolean` | (Optional): If checked, this parameter is always shown in a pipeline execution view, otherwise it’ll be collapsed by default.                                                                                      |
| `input.pipeline.parameterConfig[].required`                       | `boolean` | True if this is this a required parameter.                                                                                                                                                                              |
| `input.pipeline.spelEvaluator`                                    | `string`  | Which version of the Spring Expression Language (SpEL) is being used to evaluate the SpEL expression.                                                                                            
| `input.pipeline.stages[].account`                                 | `string`  | The account the stage deploys to. Applies to the following stage types: `deployManifest`, `scaleManifest`, `deploy`.                                                                                                    |
| `input.pipeline.stages[].app`                                     | `string`  | The name of the application being deployed. Use `input.body.application` instead. Applies to the following stage types: `deployManifest`, `scaleManifest`.                                                              |
| `input.pipeline.stages[].cloudProvider`                           | `string`  | Which specific cloud provider is being used. Applies to the following stage types: `deployManifest`, `scaleManifest`, and `deploy`.                                                                                     |
| `input.pipeline.stages[].completeOtherBranchesThenFail`           | `boolean` | Prevents any stages that depend on this stage from running, but allows other branches of the pipeline to run. The pipeline is marked as failed once complete. Available for all stages.                            |
| `input.pipeline.stages[].continuePipeline`                        | `boolean` | Continues execution of downstream stages, marking this stage as failed/continuing. Available for all stages.                                                                                                            |
| `input.pipeline.stages[].failPipeline`                            | `boolean` | Immediately halts execution of all running stages and fails the entire execution if this stage fails. Available for all stages.                                                                                         |
| `input.pipeline.stages[].instructions`                            | `string`  | Only available on the `manual Judgement` stage.<br/> Instructions are shown to the user when making a manual judgment.                                                                                                  |
| `input.pipeline.stages[].location`                                | `string`  | Only available on the `scale manifest` stage.<br/> The namespace to scale the manifest in.                                                                                                                              |
| `input.pipeline.stages[].manifestArtifactId`                      | `string`  | Only available on the `deploy manifest` stage.<br/> The artifact ID to deploy.                                                                                                                                          |
| `input.pipeline.stages[].manifestName`                            | `string`  | Only available on the `scale manifest` stage.<br/> The name of the manifest to scale.                                                                                                                                   |
| `input.pipeline.stages[].mode`                                    | `string`  | Only available on the `scale manifest` stage.<br/> Determines whether the stage uses a static or a dynamic selector.                                                                                                    |
| `input.pipeline.stages[].moniker.app`                             | `string`  | The application being deployed.                                                                                                                                                                                         |
| `input.pipeline.stages[].name`                                    | `string`  | The name of the stage.                                                                                                                                                                                                  |
| `input.pipeline.stages[].refId`                                   | `string`  | The unique ID for the stage in the stage graph.                                                                                                                                                                         |
| `input.pipeline.stages[].replicas`                                | `string`  | Only applicable to the `scale manifest` stage.<br/> How many pods should be running after the scaling action.                                                                                                           |
| `input.pipeline.stages[].requisiteStageRefIds.[]`                 | `string`  | The unique IDs of other stages that must complete before this stage.                                                                                                                                                    |
| `input.pipeline.stages[].skipExpressionEvaluation`                | `boolean` | If true then SpEL is not evaluated in artifacts referenced by the stage.                                                                                                                                           |
| `input.pipeline.stages[].source`                                  | `string`  | Only applicable to the `deploy manifest` stage.<br/> Specifies whether the manifest should be read from an artifact, or provided as text in the pipeline definition.                                                    |
| `input.pipeline.stages[].stageTimeoutMs`                          | `number`  | Only applicable to the `manual judgement` stage.<br/> Specifies how long the user has to provide a judgement.                                                                                                           |
| `input.pipeline.stages[].trafficManagement.enabled`               | `boolean` | Only applicable to the `deploy manifest` stage.<br/> Allow Spinnaker to associate each ReplicaSet deployed in this stage with one or more Services, and manage traffic based on your selected rollout strategy options. |
| `input.pipeline.stages[].trafficManagement.options.enableTraffic` | `boolean` | Only applicable to the `deploy manifest` stage.<br/> Sends client requests to new pods when traffic management is enabled.                                                                                              |
| `input.pipeline.stages[].type`                                    | `string`  | The type of the stage.                                                                                                                                                                                                  |
| `input.pipeline.updateTs`                                         | `string`  | The timestamp of the pipeline's last modification.                                                                                                                                                                      |



### input.pipeline.trigger

See [input.pipeline.trigger]({{< ref "input.pipeline.trigger.md" >}}) for more information.
