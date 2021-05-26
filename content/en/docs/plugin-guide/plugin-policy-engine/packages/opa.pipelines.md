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

## Example Policy

Requires a manual approval by the `qa` role, and a manual approval by the `infosec` role happen earlier in a pipeline than any deployment to a production account. Production accounts must have been loaded into the OPA data document in an array named `production_accounts`:

{{< prism lang="rego" line-numbers="true" >}}
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
    reachable := graph.reachable(stage_graph, {idx})[_]==i
}
lacksEarlierApprovalBy(role,idx) {
    not hasEarlierApprovalBy(role,idx) 
}
{{< /prism >}}

## Example Policy

Only allows applications to deploy to namespaces that are on a whitelist.

{{< prism lang="rego" line-numbers="true" >}}
package opa.pipelines

allowedNamespaces:=[{"app":"app1","ns": ["ns1","ns2"]},
                                     {"app":"app2", "ns":["ns3"]}]

deny["stage deploys to a namespace to which this application lacks access"]{
    ns :=object.get(input.stage.context.manifests[_].metadata,"namespace","default")
    application := input.pipeline.application
    not canDeploy(ns, application)
}

canDeploy(namespace, application){
    some i
    allowedNamespaces[i].app==application
    allowedNamespaces[i].ns[_]==namespace
}
{{< /prism >}}

## Keys

| Key                                                               | Type      | Description                                                                                                                                                          |
| :---------------------------------------------------------------- | :-------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `input.pipeline.application`                                      | `string`  | The name of the Spinnaker application to which this pipeline belongs.                                                                                                |
| `input.pipeline.expectedArtifacts[]`                              | `[array]` | See [artifacts]({{< ref "artifacts.md" >}}) for more information.                                                                                                    |
| `input.pipeline.id` | `string`   |  The unique ID of the pipeline |
| `input.pipeline.index`                                            | `number`  |                                                                                                                                                                      |
| `input.pipeline.keepWaitingPipelines`                             | `boolean` | If concurrent pipeline execution is disabled, then the pipelines that are in the waiting queue will get canceled when the next execution starts unless this is true. |
| `input.pipeline.lastModifiedBy`                                   | `string`  | The id of the user that last modified the pipeline.                                                                                                                  |
| `input.pipeline.limitConcurrent`                                  | `boolean` | True if only 1 concurrent execution of this pipeline be allowed.                                                                                                     |
| `input.pipeline.name`                                             | `string`  | The name of this pipeline.                                                                                                                                           |
| `input.pipeline.parameterConfig[].default`                        | `string`  | The default value associated with this parameter.                                                                                                                    |
| `input.pipeline.parameterConfig[].description`                    | `string`  | (Optional): If supplied, will be displayed to users as a tooltip when triggering the pipeline manually. You can include HTML in this field.                          |
| `input.pipeline.parameterConfig[].hasOptions`                     | `boolean` | True if the **Show Options** checkbox in the parameter is checked.                                                                                                   |
| `input.pipeline.parameterConfig[].label`                          | `string`  | The display name of the parameter.                                                                                                                                   |
| `input.pipeline.parameterConfig[].name`                           | `string`  | The parameter name that can be used in SpEL.                                                                                                                         |
| `input.pipeline.parameterConfig[].options[].value`                | `string`  | The value for this option in a multi-option parameter.                                                                                                               |
| `input.pipeline.parameterConfig[].pinned`                         | `boolean` | (Optional): if checked, this parameter will be always shown in a pipeline execution view, otherwise it’ll be collapsed by default.                                   |
| `input.pipeline.parameterConfig[].required`                       | `boolean` | True if this is this a required parameter.                                                                                                                           |
| `input.pipeline.spelEvaluator`                                    | `string`  | Which version of spring expression language is being used to evaluate SpEL.                                                                                          |
| `input.pipeline.stages[].account`                                 | `string`  | The account name to which the stage deploys.                                                                                                                         |
| `input.pipeline.stages[].app`                                     | `string`  | The name of the application.                                                                                                                                         |
| `input.pipeline.stages[].cloudProvider`                           | `string`  | The name of the cloud provider to which the dstage deploys.                                                                                                          |
| `input.pipeline.stages[].completeOtherBranchesThenFail`           | `boolean` | True if the pipeline should finish other branches, and then fail if this stage fails.                                                                                |
| `input.pipeline.stages[].continuePipeline`                        | `boolean` | True if the pipeline should continue if this stage fails.                                                                                                            |
| `input.pipeline.stages[].failPipeline`                            | `boolean` | True if the pipeline should fail if this stage fails                                                                                                                 |
| `input.pipeline.stages[].instructions`                            | `string`  |                                                                                                                                                                      |
| `input.pipeline.stages[].location`                                | `string`  |                                                                                                                                                                      |
| `input.pipeline.stages[].manifestArtifactId`                      | `string`  |                                                                                                                                                                      |
| `input.pipeline.stages[].manifestName`                            | `string`  |                                                                                                                                                                      |
| `input.pipeline.stages[].mode`                                    | `string`  |                                                                                                                                                                      |
| `input.pipeline.stages[].moniker.app`                             | `string`  |                                                                                                                                                                      |
| `input.pipeline.stages[].name`                                    | `string`  |                                                                                                                                                                      |
| `input.pipeline.stages[].refId`                                   | `string`  |                                                                                                                                                                      |
| `input.pipeline.stages[].replicas`                                | `string`  |                                                                                                                                                                      |
| `input.pipeline.stages[].requisiteStageRefIds.[]`                 | `string`  |                                                                                                                                                                      |
| `input.pipeline.stages[].skipExpressionEvaluation`                | `boolean` |                                                                                                                                                                      |
| `input.pipeline.stages[].source`                                  | `string`  |                                                                                                                                                                      |
| `input.pipeline.stages[].stageTimeoutMs`                          | `number`  |                                                                                                                                                                      |
| `input.pipeline.stages[].trafficManagement.enabled`               | `boolean` |                                                                                                                                                                      |
| `input.pipeline.stages[].trafficManagement.options.enableTraffic` | `boolean` |                                                                                                                                                                      |
| `input.pipeline.stages[].type`                                    | `string`  |                                                                                                                                                                      |
| `input.pipeline.updateTs`                                         | `string`  | The timestamp of the pipeline's last modification.                                                                                                                   |

### input.pipeline.trigger

See [input.pipeline.trigger]({{< ref "input.pipeline.trigger.md" >}}) for more information.
