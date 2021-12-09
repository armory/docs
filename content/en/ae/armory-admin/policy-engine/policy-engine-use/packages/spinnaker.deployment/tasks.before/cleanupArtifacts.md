---
title: "spinnaker.deployment.tasks.before.cleanupArtifacts"
linkTitle: "cleanupArtifacts"
description: "Used by policies to affect the ‘Cleanup Artifacts’ task."
---

## Example Payload

<details><summary>Click to expand</summary>

```json
{
  "input": {
    "deploy": {
      "account": "spinnaker",
      "credentials": "spinnaker",
      "events": [],
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
              "deployment.kubernetes.io/revision": "4",
              "kubectl.kubernetes.io/last-applied-configuration": "{\"apiVersion\":\"apps/v1\",\"kind\":\"Deployment\",\"metadata\":{\"annotations\":{\"artifact.spinnaker.io/location\":\"staging\",\"artifact.spinnaker.io/name\":\"hostname\",\"artifact.spinnaker.io/type\":\"kubernetes/deployment\",\"artifact.spinnaker.io/version\":\"\",\"moniker.spinnaker.io/application\":\"hostname\",\"moniker.spinnaker.io/cluster\":\"deployment hostname\"},\"labels\":{\"app.kubernetes.io/managed-by\":\"spinnaker\",\"app.kubernetes.io/name\":\"hostname\"},\"name\":\"hostname\",\"namespace\":\"staging\"},\"spec\":{\"replicas\":4,\"selector\":{\"matchLabels\":{\"app\":\"hostname\",\"version\":\"v1\"}},\"strategy\":{\"rollingUpdate\":{\"maxSurge\":1,\"maxUnavailable\":1},\"type\":\"RollingUpdate\"},\"template\":{\"metadata\":{\"annotations\":{\"artifact.spinnaker.io/location\":\"staging\",\"artifact.spinnaker.io/name\":\"hostname\",\"artifact.spinnaker.io/type\":\"kubernetes/deployment\",\"artifact.spinnaker.io/version\":\"\",\"moniker.spinnaker.io/application\":\"hostname\",\"moniker.spinnaker.io/cluster\":\"deployment hostname\",\"prometheus.io/port\":\"9113\",\"prometheus.io/scrape\":\"true\"},\"labels\":{\"app\":\"hostname\",\"app.kubernetes.io/managed-by\":\"spinnaker\",\"app.kubernetes.io/name\":\"hostname\",\"version\":\"v1\"}},\"spec\":{\"containers\":[{\"image\":\"rstarmer/hostname:v1\",\"imagePullPolicy\":\"Always\",\"name\":\"hostname\",\"resources\":{},\"volumeMounts\":[{\"mountPath\":\"/etc/nginx/conf.d/nginx-status.conf\",\"name\":\"nginx-status-conf\",\"readOnly\":true,\"subPath\":\"nginx.status.conf\"}]},{\"args\":[\"-nginx.scrape-uri=http://localhost:8090/nginx_status\"],\"image\":\"nginx/nginx-prometheus-exporter:0.3.0\",\"imagePullPolicy\":\"Always\",\"name\":\"nginx-exporter\",\"ports\":[{\"containerPort\":9113,\"name\":\"nginx-ex-port\",\"protocol\":\"TCP\"}]}],\"restartPolicy\":\"Always\",\"volumes\":[{\"configMap\":{\"defaultMode\":420,\"name\":\"nginx-status-conf-v000\"},\"name\":\"nginx-status-conf\"}]}}}}\n",
              "moniker.spinnaker.io/application": "hostname",
              "moniker.spinnaker.io/cluster": "deployment hostname"
            },
            "creationTimestamp": "2021-04-30T21:19:15Z",
            "generation": 11,
            "labels": {
              "app.kubernetes.io/managed-by": "spinnaker",
              "app.kubernetes.io/name": "hostname"
            },
            "managedFields": [
              {
                "apiVersion": "apps/v1",
                "fieldsType": "FieldsV1",
                "fieldsV1": {
                  "f:metadata": {
                    "f:annotations": {
                      ".": {},
                      "f:artifact.spinnaker.io/location": {},
                      "f:artifact.spinnaker.io/name": {},
                      "f:artifact.spinnaker.io/type": {},
                      "f:artifact.spinnaker.io/version": {},
                      "f:kubectl.kubernetes.io/last-applied-configuration": {},
                      "f:moniker.spinnaker.io/application": {},
                      "f:moniker.spinnaker.io/cluster": {}
                    },
                    "f:labels": {
                      ".": {},
                      "f:app.kubernetes.io/managed-by": {},
                      "f:app.kubernetes.io/name": {}
                    }
                  },
                  "f:spec": {
                    "f:progressDeadlineSeconds": {},
                    "f:replicas": {},
                    "f:revisionHistoryLimit": {},
                    "f:selector": {
                      "f:matchLabels": {
                        ".": {},
                        "f:app": {},
                        "f:version": {}
                      }
                    },
                    "f:strategy": {
                      "f:rollingUpdate": {
                        ".": {},
                        "f:maxSurge": {},
                        "f:maxUnavailable": {}
                      },
                      "f:type": {}
                    },
                    "f:template": {
                      "f:metadata": {
                        "f:annotations": {
                          ".": {},
                          "f:artifact.spinnaker.io/location": {},
                          "f:artifact.spinnaker.io/name": {},
                          "f:artifact.spinnaker.io/type": {},
                          "f:artifact.spinnaker.io/version": {},
                          "f:moniker.spinnaker.io/application": {},
                          "f:moniker.spinnaker.io/cluster": {},
                          "f:prometheus.io/port": {},
                          "f:prometheus.io/scrape": {}
                        },
                        "f:labels": {
                          ".": {},
                          "f:app": {},
                          "f:app.kubernetes.io/managed-by": {},
                          "f:app.kubernetes.io/name": {},
                          "f:version": {}
                        }
                      },
                      "f:spec": {
                        "f:containers": {
                          "k:{\"name\":\"hostname\"}": {
                            ".": {},
                            "f:image": {},
                            "f:imagePullPolicy": {},
                            "f:name": {},
                            "f:resources": {},
                            "f:terminationMessagePath": {},
                            "f:terminationMessagePolicy": {},
                            "f:volumeMounts": {
                              ".": {},
                              "k:{\"mountPath\":\"/etc/nginx/conf.d/nginx-status.conf\"}": {
                                ".": {},
                                "f:mountPath": {},
                                "f:name": {},
                                "f:readOnly": {},
                                "f:subPath": {}
                              }
                            }
                          },
                          "k:{\"name\":\"nginx-exporter\"}": {
                            ".": {},
                            "f:args": {},
                            "f:image": {},
                            "f:imagePullPolicy": {},
                            "f:name": {},
                            "f:ports": {
                              ".": {},
                              "k:{\"containerPort\":9113,\"protocol\":\"TCP\"}": {
                                ".": {},
                                "f:containerPort": {},
                                "f:name": {},
                                "f:protocol": {}
                              }
                            },
                            "f:resources": {},
                            "f:terminationMessagePath": {},
                            "f:terminationMessagePolicy": {}
                          }
                        },
                        "f:dnsPolicy": {},
                        "f:restartPolicy": {},
                        "f:schedulerName": {},
                        "f:securityContext": {},
                        "f:terminationGracePeriodSeconds": {},
                        "f:volumes": {
                          ".": {},
                          "k:{\"name\":\"nginx-status-conf\"}": {
                            ".": {},
                            "f:configMap": {
                              ".": {},
                              "f:defaultMode": {},
                              "f:name": {}
                            },
                            "f:name": {}
                          }
                        }
                      }
                    }
                  }
                },
                "manager": "kubectl",
                "operation": "Update",
                "time": "2021-04-30T21:19:15Z"
              },
              {
                "apiVersion": "apps/v1",
                "fieldsType": "FieldsV1",
                "fieldsV1": {
                  "f:metadata": {
                    "f:annotations": {
                      "f:deployment.kubernetes.io/revision": {}
                    }
                  },
                  "f:status": {
                    "f:availableReplicas": {},
                    "f:conditions": {
                      ".": {},
                      "k:{\"type\":\"Available\"}": {
                        ".": {},
                        "f:lastTransitionTime": {},
                        "f:lastUpdateTime": {},
                        "f:message": {},
                        "f:reason": {},
                        "f:status": {},
                        "f:type": {}
                      },
                      "k:{\"type\":\"Progressing\"}": {
                        ".": {},
                        "f:lastTransitionTime": {},
                        "f:lastUpdateTime": {},
                        "f:message": {},
                        "f:reason": {},
                        "f:status": {},
                        "f:type": {}
                      }
                    },
                    "f:observedGeneration": {},
                    "f:readyReplicas": {},
                    "f:replicas": {},
                    "f:updatedReplicas": {}
                  }
                },
                "manager": "kube-controller-manager",
                "operation": "Update",
                "time": "2021-05-07T22:39:40Z"
              }
            ],
            "name": "hostname",
            "namespace": "staging",
            "resourceVersion": "25266763",
            "selfLink": "/apis/apps/v1/namespaces/staging/deployments/hostname",
            "uid": "e1d20734-60ea-44a0-a830-168f001b482f"
          },
          "spec": {
            "progressDeadlineSeconds": 600,
            "replicas": 4,
            "revisionHistoryLimit": 10,
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
                    "terminationMessagePath": "/dev/termination-log",
                    "terminationMessagePolicy": "File",
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
                    ],
                    "resources": {},
                    "terminationMessagePath": "/dev/termination-log",
                    "terminationMessagePolicy": "File"
                  }
                ],
                "dnsPolicy": "ClusterFirst",
                "restartPolicy": "Always",
                "schedulerName": "default-scheduler",
                "securityContext": {},
                "terminationGracePeriodSeconds": 30,
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
          },
          "status": {
            "availableReplicas": 10,
            "conditions": [
              {
                "lastTransitionTime": "2021-04-30T21:19:15Z",
                "lastUpdateTime": "2021-05-07T20:39:03Z",
                "message": "ReplicaSet \"hostname-f5b957cc\" has successfully progressed.",
                "reason": "NewReplicaSetAvailable",
                "status": "True",
                "type": "Progressing"
              },
              {
                "lastTransitionTime": "2021-05-07T22:39:40Z",
                "lastUpdateTime": "2021-05-07T22:39:40Z",
                "message": "Deployment has minimum availability.",
                "reason": "MinimumReplicasAvailable",
                "status": "True",
                "type": "Available"
              }
            ],
            "observedGeneration": 10,
            "readyReplicas": 10,
            "replicas": 10,
            "updatedReplicas": 10
          }
        }
      ]
    }
  }
}
```
</details>

## Example Policy
Prevents cleanupArtifacts tasks from running on any account in a predefined list.
{{< prism lang="rego" line-numbers="true" >}}
package spinnaker.deployment.tasks.before.cleanupArtifacts

productionAccounts :=["prod1","prod2"]

deny["Artifactss may not be cleaned up from production accounts"] { 
	input.deploy.account==productionAccounts[_]
}

{{< /prism >}}

## Keys

| Key                          | Type     | Description                                    |
| ---------------------------- | -------- | ---------------------------------------------- |
| `input.deploy.account`       | `string` | The account being deployed to.       |
| `input.deploy.credentials`   | `string` | The credentials to use to access the account.  |
| `input.deploy.manifests[].*` | `*`      | The entire Kubernetes manifest to be removed. |
