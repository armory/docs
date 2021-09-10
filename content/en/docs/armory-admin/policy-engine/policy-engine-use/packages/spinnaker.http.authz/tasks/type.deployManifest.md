---
title: "Task Type: deployManifest"
linktitle: "deployManifest"
description: "Policy controls whether or not a deployManifest that is triggered from outside a spinnaker pipeline (e.g. from the ‘Clusters’ tab of an application's 'edit' action) can run."
---

- **Path:** tasks
- **Method:** Post
- **Package:** `spinnaker.http.authz`
- 
{{< include "policy-engine/kubernetesAdHocInfraWritesEnabled.md" >}}

## Example Payload

<details><summary>Click to expand</summary>

```json
{
  "input": {
    "body": {
      "application": "hostname",
      "description": "Deploy manifest",
      "job": [
        {
          "account": "spinnaker",
          "cloudProvider": "kubernetes",
          "manifest": null,
          "manifestArtifactAccount": "embedded-artifact",
          "manifests": [
            {
              "apiVersion": "apps/v1",
              "kind": "Deployment",
              "metadata": {
                "annotations": {
                  "artifact.spinnaker.io/location": "staging",
                  "artifact.spinnaker.io/name": "hostname",
                  "artifact.spinnaker.io/type": "kubernetes/deployment",
                  "artifact.spinnaker.io/version": "",
                  "moniker.spinnaker.io/application": "hostname",
                  "moniker.spinnaker.io/cluster": "deployment hostname"
                },
                "labels": {
                  "app.kubernetes.io/managed-by": "spinnaker",
                  "app.kubernetes.io/name": "hostname"
                },
                "name": "hostname",
                "namespace": "staging"
              },
              "spec": {
                "replicas": 4,
                "selector": {
                  "matchLabels": {
                    "app": "hostname",
                    "version": "v1"
                  }
                },
                "strategy": {
                  "rollingUpdate": {
                    "maxSurge": 1,
                    "maxUnavailable": 1
                  },
                  "type": "RollingUpdate"
                },
                "template": {
                  "metadata": {
                    "annotations": {
                      "artifact.spinnaker.io/location": "staging",
                      "artifact.spinnaker.io/name": "hostname",
                      "artifact.spinnaker.io/type": "kubernetes/deployment",
                      "artifact.spinnaker.io/version": "",
                      "moniker.spinnaker.io/application": "hostname",
                      "moniker.spinnaker.io/cluster": "deployment hostname",
                      "prometheus.io/port": "9113",
                      "prometheus.io/scrape": "true"
                    },
                    "labels": {
                      "app": "hostname",
                      "app.kubernetes.io/managed-by": "spinnaker",
                      "app.kubernetes.io/name": "hostname",
                      "version": "v1"
                    }
                  },
                  "spec": {
                    "containers": [
                      {
                        "image": "rstarmer/hostname:v1",
                        "imagePullPolicy": "Always",
                        "name": "hostname",
                        "resources": {},
                        "volumeMounts": [
                          {
                            "mountPath": "/etc/nginx/conf.d/nginx-status.conf",
                            "name": "nginx-status-conf",
                            "readOnly": true,
                            "subPath": "nginx.status.conf"
                          }
                        ]
                      },
                      {
                        "args": [
                          "-nginx.scrape-uri=http://localhost:8090/nginx_status"
                        ],
                        "image": "nginx/nginx-prometheus-exporter:0.3.0",
                        "imagePullPolicy": "Always",
                        "name": "nginx-exporter",
                        "ports": [
                          {
                            "containerPort": 9113,
                            "name": "nginx-ex-port",
                            "protocol": "TCP"
                          }
                        ]
                      }
                    ],
                    "restartPolicy": "Always",
                    "volumes": [
                      {
                        "configMap": {
                          "defaultMode": 420,
                          "name": "nginx-status-conf-v000"
                        },
                        "name": "nginx-status-conf"
                      }
                    ]
                  }
                }
              }
            }
          ],
          "moniker": {
            "app": "hostname",
            "cluster": "deployment hostname"
          },
          "relationships": {
            "loadBalancers": [],
            "securityGroups": []
          },
          "source": "text",
          "type": "deployManifest",
          "user": "myUserName",
          "versioned": null
        }
      ]
    },
    "method": "POST",
    "path": [
      "tasks"
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

Prevents editing manifests from outside of a pipeline on production accounts.

{{< prism lang="rego" line-numbers="true" >}}
package spinnaker.http.authz
default message=""
allow = message==""

isProductionAccount(account){
	["prodAccount1","prodAccount2"][_]==account
}

message = "Manifests cannot be deployed outside of a pipeline in production accounts"{
      createsTaskOfType("deployManifest")
      isProductionAccount(input.body.job[_].account)
}
createsTaskOfType(tasktype){
    input.method="POST"
    input.path=["tasks"]
    input.body.job[_].type=tasktype
}
{{< /prism >}}

## Keys

| Key                                        | Type     | Description                                                                                                                   |
| ------------------------------------------ | -------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `input.body.application`                   | `string` | The name of the application for which a manifest is deployed.                                                                 |
| `input.body.description`                   | `string` | "Deploy Manifest".                                                                                                            |
| `input.body.job[].account`                 | `string` | The account to which the manifest is deployed.                                                                                |
| `input.body.job[].cloudProvider`           | `string` | The cloud provider for the account, typically 'kubernetes'.                                                                   |
| `input.body.job[].manifestArtifactAccount` | `string` | The account from which the manifest artifact should be read, if any.                                                          |
| `input.body.job[].manifests[].*`           | `*`      | The set of manifests that are deployed. Can be referenced to require certain conditions on manifests that are being deployed. |
| `input.body.job[].moniker.app`             | `string` | The name of the application for which a manifest is deployed.                                                                 |
| `input.body.job[].moniker.cluster`         | `string` | What existing resource cluster is having its manifest updated.                                                                |
| `input.body.job[].source`                  | `string` |                                                                                                                               |
| `input.body.job[].type`                    | `string` | "deployManifest"                                                                                                              |
| `input.body.job[].user`                    | `string` | The username of the user who is trying to deploy. More information is available under the `input.user` fields.                |
| `input.body.job[].versioned`               |          |                                                                                                                               |
| `input.method`                             | `string` | `POST`                                                                                                                        |
| `input.path[]`                             | `string` | `[tasks]`                                                                                                                     |

### input.user

This object provides information about the user performing the action. This can be used to restrict actions by role. See [input.user]({{< ref "input.user.md" >}}) for more information.
