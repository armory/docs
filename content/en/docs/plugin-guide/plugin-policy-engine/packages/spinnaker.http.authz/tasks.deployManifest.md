---
title: "spinnaker.http.authz.tasks.deployManifest"
linktitle: "tasks.deployManifest"
description: "fill me with delicious data, Stephen!"
---

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
          "user": "elfie2002",
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

| Key                                                    | Type      | Description |
| ------------------------------------------------------ | --------- | ----------- |
| `input.body.application`                               | `string`  |             |
| `input.body.description`                               | `string`  |             |
| `input.body.job[].account`                             | `string`  |             |
| `input.body.job[].cloudProvider`                       | `string`  |             |
| `input.body.job[].manifest`                            | ` `       |             |
| `input.body.job[].manifestArtifactAccount`             | `string`  |             |
| `input.body.job[].manifests[].*`                       | `*`       |             |
| `input.body.job[].moniker.app`                         | `string`  |             |
| `input.body.job[].moniker.cluster`                     | `string`  |             |
| `input.body.job[].source`                              | `string`  |             |
| `input.body.job[].type`                                | `string`  |             |
| `input.body.job[].user`                                | `string`  |             |
| `input.body.job[].versioned`                           | ` `       |             |
| `input.method`                                         | `string`  |             |
| `input.path[]`                                         | `string`  |             |
| `input.user.isAdmin`                                   | `boolean` |             |
| `input.user.username`                                  | `string`  |             |
| `input.body.job[].manifests[].metadata.labels.app`     | `string`  |             |
| `input.body.job[].manifests[].metadata.labels.test`    | `string`  |             |
| `input.body.job[].manifests[].spec.ports[].port`       | `number`  |             |
| `input.body.job[].manifests[].spec.ports[].protocol`   | `string`  |             |
| `input.body.job[].manifests[].spec.ports[].targetPort` | `number`  |             |
| `input.body.job[].manifests[].spec.selector.app`       | `string`  |             |
| `input.body.job[].manifests[].spec.sessionAffinity`    | `string`  |             |
| `input.body.job[].manifests[].spec.type`               | `string`  |             |
