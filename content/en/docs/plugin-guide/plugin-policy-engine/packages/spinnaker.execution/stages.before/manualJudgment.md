---
title: "spinnaker.execution.stages.before.manualJudgment"
linktitle: "manualJudgment"
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
      "buildTime": 1620762127532,
      "canceled": false,
      "canceledBy": null,
      "cancellationReason": null,
      "description": null,
      "endTime": null,
      "id": "01F5EF6V1CTYQBD3HBNZXG0CTJ",
      "initialConfig": {},
      "keepWaitingPipelines": false,
      "limitConcurrent": true,
      "name": "scale deployments",
      "notifications": [],
      "origin": "api",
      "partition": null,
      "paused": null,
      "pipelineConfigId": "7db1e350-dedb-4dc1-9976-e71f97b5f132",
      "source": null,
      "spelEvaluator": "v4",
      "stages": [
        {
          "context": {
            "account": "spinnaker",
            "artifacts": [
              {
                "customKind": false,
                "location": "staging",
                "metadata": {
                  "account": "spinnaker"
                },
                "name": "nginx-status-conf",
                "reference": "nginx-status-conf-v000",
                "type": "kubernetes/configMap",
                "version": "v000"
              },
              {
                "customKind": false,
                "location": "staging",
                "metadata": {
                  "account": "spinnaker"
                },
                "name": "hostname",
                "reference": "hostname",
                "type": "kubernetes/deployment",
                "version": ""
              },
              {
                "customKind": false,
                "location": "",
                "metadata": {
                  "account": "spinnaker"
                },
                "name": "staging",
                "reference": "staging",
                "type": "kubernetes/namespace",
                "version": ""
              }
            ],
            "cloudProvider": "kubernetes",
            "deploy.account.name": "spinnaker",
            "deploy.server.groups": {},
            "failedManifests": [],
            "kato.last.task.id": {
              "id": "4661f622-1a8b-4c04-ac11-ec4cb5846854"
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
                    "status": "Processing op: KubernetesDeployManifestOperation"
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Beginning deployment of manifest..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Swapping out artifacts in namespace staging from context..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Finding deployer for namespace..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Swapping out artifacts in deployment hostname from context..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Finding deployer for deployment..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Swapping out artifacts in configMap nginx-status-conf from context..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Finding deployer for configMap..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Checking if all requested artifacts were bound..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Sorting manifests by priority..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Finding deployer for deployment..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Finding deployer for namespace..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Finding deployer for configMap..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Finding deployer for deployment..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Finding deployer for configMap..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Finding deployer for deployment..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Finding deployer for configMap..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Finding deployer for namespace..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Deploy order is: namespace staging, configMap nginx-status-conf, deployment hostname"
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Finding deployer for namespace..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Annotating manifest namespace staging with artifact, relationships & moniker..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Swapping out artifacts in namespace staging from other deployments..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Submitting manifest namespace staging to kubernetes master..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Finding deployer for configMap..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Annotating manifest configMap nginx-status-conf with artifact, relationships & moniker..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Swapping out artifacts in configMap nginx-status-conf-v000 from other deployments..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Submitting manifest configMap nginx-status-conf-v000 to kubernetes master..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Finding deployer for deployment..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Annotating manifest deployment hostname with artifact, relationships & moniker..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Swapping out artifacts in deployment hostname from other deployments..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Submitting manifest deployment hostname to kubernetes master..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Deploy manifest task completed successfully."
                  },
                  {
                    "phase": "ORCHESTRATION",
                    "status": "Orchestration completed."
                  }
                ],
                "id": "5998ffce-9261-489b-887f-97b069701a85",
                "resultObjects": [
                  {
                    "boundArtifacts": [
                      {
                        "customKind": false,
                        "location": "staging",
                        "metadata": {
                          "account": "spinnaker"
                        },
                        "name": "nginx-status-conf",
                        "reference": "nginx-status-conf-v000",
                        "type": "kubernetes/configMap",
                        "version": "v000"
                      }
                    ],
                    "createdArtifacts": [
                      {
                        "customKind": false,
                        "location": "staging",
                        "metadata": {
                          "account": "spinnaker"
                        },
                        "name": "nginx-status-conf",
                        "reference": "nginx-status-conf-v000",
                        "type": "kubernetes/configMap",
                        "version": "v000"
                      },
                      {
                        "customKind": false,
                        "location": "staging",
                        "metadata": {
                          "account": "spinnaker"
                        },
                        "name": "hostname",
                        "reference": "hostname",
                        "type": "kubernetes/deployment",
                        "version": ""
                      },
                      {
                        "customKind": false,
                        "location": "",
                        "metadata": {
                          "account": "spinnaker"
                        },
                        "name": "staging",
                        "reference": "staging",
                        "type": "kubernetes/namespace",
                        "version": ""
                      }
                    ],
                    "manifestNamesByNamespace": {
                      "": [
                        "namespace staging"
                      ],
                      "staging": [
                        "configMap nginx-status-conf-v000",
                        "deployment hostname"
                      ]
                    },
                    "manifests": [
                      {
                        "apiVersion": "v1",
                        "data": {
                          "nginx.status.conf": "server {\n    listen       8090 default_server;\n    location /nginx_status {\n        stub_status;\n        access_log off;\n    }\n}\n"
                        },
                        "kind": "ConfigMap",
                        "metadata": {
                          "annotations": {
                            "artifact.spinnaker.io/location": "staging",
                            "artifact.spinnaker.io/name": "nginx-status-conf",
                            "artifact.spinnaker.io/type": "kubernetes/configMap",
                            "artifact.spinnaker.io/version": "v000",
                            "kubectl.kubernetes.io/last-applied-configuration": "{\"apiVersion\":\"v1\",\"data\":{\"nginx.status.conf\":\"server {\\n    listen       8090 default_server;\\n    location /nginx_status {\\n        stub_status;\\n        access_log off;\\n    }\\n}\\n\"},\"kind\":\"ConfigMap\",\"metadata\":{\"annotations\":{\"artifact.spinnaker.io/location\":\"staging\",\"artifact.spinnaker.io/name\":\"nginx-status-conf\",\"artifact.spinnaker.io/type\":\"kubernetes/configMap\",\"artifact.spinnaker.io/version\":\"v000\",\"moniker.spinnaker.io/application\":\"hostname\",\"moniker.spinnaker.io/cluster\":\"configMap nginx-status-conf\",\"moniker.spinnaker.io/sequence\":\"0\"},\"labels\":{\"app.kubernetes.io/managed-by\":\"spinnaker\",\"app.kubernetes.io/name\":\"hostname\",\"moniker.spinnaker.io/sequence\":\"0\"},\"name\":\"nginx-status-conf-v000\",\"namespace\":\"staging\"}}\n",
                            "moniker.spinnaker.io/application": "hostname",
                            "moniker.spinnaker.io/cluster": "configMap nginx-status-conf",
                            "moniker.spinnaker.io/sequence": "0"
                          },
                          "creationTimestamp": "2021-04-30T20:39:49Z",
                          "labels": {
                            "app.kubernetes.io/managed-by": "spinnaker",
                            "app.kubernetes.io/name": "hostname",
                            "moniker.spinnaker.io/sequence": "0"
                          },
                          "managedFields": [
                            {
                              "apiVersion": "v1",
                              "fieldsType": "FieldsV1",
                              "fieldsV1": {
                                "f:data": {
                                  ".": {},
                                  "f:nginx.status.conf": {}
                                },
                                "f:metadata": {
                                  "f:annotations": {
                                    ".": {},
                                    "f:artifact.spinnaker.io/location": {},
                                    "f:artifact.spinnaker.io/name": {},
                                    "f:artifact.spinnaker.io/type": {},
                                    "f:artifact.spinnaker.io/version": {},
                                    "f:kubectl.kubernetes.io/last-applied-configuration": {},
                                    "f:moniker.spinnaker.io/application": {},
                                    "f:moniker.spinnaker.io/cluster": {},
                                    "f:moniker.spinnaker.io/sequence": {}
                                  },
                                  "f:labels": {
                                    ".": {},
                                    "f:app.kubernetes.io/managed-by": {},
                                    "f:app.kubernetes.io/name": {},
                                    "f:moniker.spinnaker.io/sequence": {}
                                  }
                                }
                              },
                              "manager": "kubectl",
                              "operation": "Update",
                              "time": "2021-04-30T20:39:49Z"
                            }
                          ],
                          "name": "nginx-status-conf-v000",
                          "namespace": "staging",
                          "resourceVersion": "22455936",
                          "selfLink": "/api/v1/namespaces/staging/configmaps/nginx-status-conf-v000",
                          "uid": "bc9f63b0-b8eb-4810-afac-16c0cd61736e"
                        }
                      },
                      {
                        "apiVersion": "apps/v1",
                        "kind": "Deployment",
                        "metadata": {
                          "annotations": {
                            "artifact.spinnaker.io/location": "staging",
                            "artifact.spinnaker.io/name": "hostname",
                            "artifact.spinnaker.io/type": "kubernetes/deployment",
                            "artifact.spinnaker.io/version": "",
                            "deployment.kubernetes.io/revision": "1",
                            "kubectl.kubernetes.io/last-applied-configuration": "{\"apiVersion\":\"apps/v1\",\"kind\":\"Deployment\",\"metadata\":{\"annotations\":{\"artifact.spinnaker.io/location\":\"staging\",\"artifact.spinnaker.io/name\":\"hostname\",\"artifact.spinnaker.io/type\":\"kubernetes/deployment\",\"artifact.spinnaker.io/version\":\"\",\"moniker.spinnaker.io/application\":\"hostname\",\"moniker.spinnaker.io/cluster\":\"deployment hostname\"},\"labels\":{\"app.kubernetes.io/managed-by\":\"spinnaker\",\"app.kubernetes.io/name\":\"hostname\"},\"name\":\"hostname\",\"namespace\":\"staging\"},\"spec\":{\"replicas\":2,\"selector\":{\"matchLabels\":{\"app\":\"hostname\",\"version\":\"v1\"}},\"strategy\":{\"rollingUpdate\":{\"maxSurge\":1,\"maxUnavailable\":1},\"type\":\"RollingUpdate\"},\"template\":{\"metadata\":{\"annotations\":{\"artifact.spinnaker.io/location\":\"staging\",\"artifact.spinnaker.io/name\":\"hostname\",\"artifact.spinnaker.io/type\":\"kubernetes/deployment\",\"artifact.spinnaker.io/version\":\"\",\"moniker.spinnaker.io/application\":\"hostname\",\"moniker.spinnaker.io/cluster\":\"deployment hostname\",\"prometheus.io/port\":\"9113\",\"prometheus.io/scrape\":\"true\"},\"labels\":{\"app\":\"hostname\",\"app.kubernetes.io/managed-by\":\"spinnaker\",\"app.kubernetes.io/name\":\"hostname\",\"version\":\"v1\"}},\"spec\":{\"containers\":[{\"image\":\"rstarmer/hostname:v1\",\"imagePullPolicy\":\"Always\",\"name\":\"hostname\",\"resources\":{},\"volumeMounts\":[{\"mountPath\":\"/etc/nginx/conf.d/nginx-status.conf\",\"name\":\"nginx-status-conf\",\"readOnly\":true,\"subPath\":\"nginx.status.conf\"}]},{\"args\":[\"-nginx.scrape-uri=http://localhost:8090/nginx_status\"],\"image\":\"nginx/nginx-prometheus-exporter:0.3.0\",\"imagePullPolicy\":\"Always\",\"name\":\"nginx-exporter\",\"ports\":[{\"containerPort\":9113,\"name\":\"nginx-ex-port\",\"protocol\":\"TCP\"}]}],\"restartPolicy\":\"Always\",\"volumes\":[{\"configMap\":{\"defaultMode\":420,\"name\":\"nginx-status-conf-v000\"},\"name\":\"nginx-status-conf\"}]}}}}\n",
                            "moniker.spinnaker.io/application": "hostname",
                            "moniker.spinnaker.io/cluster": "deployment hostname"
                          },
                          "creationTimestamp": "2021-05-11T17:03:31Z",
                          "generation": 2,
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
                              "time": "2021-05-11T17:03:31Z"
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
                              "time": "2021-05-11T17:03:35Z"
                            }
                          ],
                          "name": "hostname",
                          "namespace": "staging",
                          "resourceVersion": "25295972",
                          "selfLink": "/apis/apps/v1/namespaces/staging/deployments/hostname",
                          "uid": "ae6a47d3-c37a-4a60-b375-4ea6a7ef9795"
                        },
                        "spec": {
                          "progressDeadlineSeconds": 600,
                          "replicas": 2,
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
                          "availableReplicas": 5,
                          "conditions": [
                            {
                              "lastTransitionTime": "2021-05-11T17:03:34Z",
                              "lastUpdateTime": "2021-05-11T17:03:34Z",
                              "message": "Deployment has minimum availability.",
                              "reason": "MinimumReplicasAvailable",
                              "status": "True",
                              "type": "Available"
                            },
                            {
                              "lastTransitionTime": "2021-05-11T17:03:31Z",
                              "lastUpdateTime": "2021-05-11T17:03:35Z",
                              "message": "ReplicaSet \"hostname-f5b957cc\" has successfully progressed.",
                              "reason": "NewReplicaSetAvailable",
                              "status": "True",
                              "type": "Progressing"
                            }
                          ],
                          "observedGeneration": 1,
                          "readyReplicas": 5,
                          "replicas": 5,
                          "updatedReplicas": 5
                        }
                      },
                      {
                        "apiVersion": "v1",
                        "kind": "Namespace",
                        "metadata": {
                          "annotations": {
                            "artifact.spinnaker.io/location": "",
                            "artifact.spinnaker.io/name": "staging",
                            "artifact.spinnaker.io/type": "kubernetes/namespace",
                            "artifact.spinnaker.io/version": "",
                            "kubectl.kubernetes.io/last-applied-configuration": "{\"apiVersion\":\"v1\",\"kind\":\"Namespace\",\"metadata\":{\"annotations\":{\"artifact.spinnaker.io/location\":\"\",\"artifact.spinnaker.io/name\":\"staging\",\"artifact.spinnaker.io/type\":\"kubernetes/namespace\",\"artifact.spinnaker.io/version\":\"\",\"moniker.spinnaker.io/application\":\"hostname\",\"moniker.spinnaker.io/cluster\":\"namespace staging\"},\"labels\":{\"app.kubernetes.io/managed-by\":\"spinnaker\",\"app.kubernetes.io/name\":\"hostname\"},\"name\":\"staging\"},\"spec\":{\"finalizers\":[\"kubernetes\"]}}\n",
                            "moniker.spinnaker.io/application": "hostname",
                            "moniker.spinnaker.io/cluster": "namespace staging"
                          },
                          "creationTimestamp": "2021-02-11T00:11:46Z",
                          "labels": {
                            "app.kubernetes.io/managed-by": "spinnaker",
                            "app.kubernetes.io/name": "hostname"
                          },
                          "managedFields": [
                            {
                              "apiVersion": "v1",
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
                                  "f:finalizers": {}
                                },
                                "f:status": {
                                  "f:phase": {}
                                }
                              },
                              "manager": "kubectl",
                              "operation": "Update",
                              "time": "2021-02-17T22:41:50Z"
                            }
                          ],
                          "name": "staging",
                          "resourceVersion": "4990957",
                          "selfLink": "/api/v1/namespaces/staging",
                          "uid": "6fbe3041-1b24-4a8e-9ff5-527a41f2f441"
                        },
                        "spec": {
                          "finalizers": [
                            "kubernetes"
                          ]
                        },
                        "status": {
                          "phase": "Active"
                        }
                      }
                    ]
                  }
                ],
                "status": {
                  "completed": true,
                  "failed": false,
                  "retryable": false
                }
              },
              {
                "history": [
                  {
                    "phase": "ORCHESTRATION",
                    "status": "Initializing Orchestration Task"
                  },
                  {
                    "phase": "ORCHESTRATION",
                    "status": "Processing op: KubernetesCleanupArtifactsOperation"
                  },
                  {
                    "phase": "ORCHESTRATION",
                    "status": "Orchestration completed."
                  }
                ],
                "id": "4661f622-1a8b-4c04-ac11-ec4cb5846854",
                "resultObjects": [
                  {
                    "boundArtifacts": [],
                    "createdArtifacts": [],
                    "manifestNamesByNamespace": {}
                  }
                ],
                "status": {
                  "completed": true,
                  "failed": false,
                  "retryable": false
                }
              }
            ],
            "manifestArtifactId": "0cf98032-1b0f-48db-9314-09c69293b3a6",
            "manifests": [
              {
                "apiVersion": "v1",
                "kind": "Namespace",
                "metadata": {
                  "name": "staging"
                },
                "spec": {
                  "finalizers": [
                    "kubernetes"
                  ]
                }
              },
              {
                "apiVersion": "apps/v1",
                "kind": "Deployment",
                "metadata": {
                  "name": "hostname",
                  "namespace": "staging"
                },
                "spec": {
                  "replicas": 2,
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
                        "prometheus.io/port": "9113",
                        "prometheus.io/scrape": "true"
                      },
                      "labels": {
                        "app": "hostname",
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
                            "name": "nginx-status-conf"
                          },
                          "name": "nginx-status-conf"
                        }
                      ]
                    }
                  }
                }
              },
              {
                "apiVersion": "v1",
                "data": {
                  "nginx.status.conf": "server {\n    listen       8090 default_server;\n    location /nginx_status {\n        stub_status;\n        access_log off;\n    }\n}\n"
                },
                "kind": "ConfigMap",
                "metadata": {
                  "name": "nginx-status-conf",
                  "namespace": "staging"
                }
              }
            ],
            "messages": [],
            "moniker": {
              "app": "hostname"
            },
            "optionalArtifacts": [
              {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "4aa85178-0618-46c4-b530-6883d393656d"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
                "type": "github/file",
                "version": "master"
              },
              {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
                },
                "name": "manifests/service-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/service-spinnaker.yaml",
                "type": "github/file"
              }
            ],
            "outputs.boundArtifacts": [
              {
                "customKind": false,
                "location": "staging",
                "metadata": {
                  "account": "spinnaker"
                },
                "name": "nginx-status-conf",
                "reference": "nginx-status-conf-v000",
                "type": "kubernetes/configMap",
                "version": "v000"
              }
            ],
            "outputs.createdArtifacts": [
              {
                "customKind": false,
                "location": "staging",
                "metadata": {
                  "account": "spinnaker"
                },
                "name": "nginx-status-conf",
                "reference": "nginx-status-conf-v000",
                "type": "kubernetes/configMap",
                "version": "v000"
              },
              {
                "customKind": false,
                "location": "staging",
                "metadata": {
                  "account": "spinnaker"
                },
                "name": "hostname",
                "reference": "hostname",
                "type": "kubernetes/deployment",
                "version": ""
              },
              {
                "customKind": false,
                "location": "",
                "metadata": {
                  "account": "spinnaker"
                },
                "name": "staging",
                "reference": "staging",
                "type": "kubernetes/namespace",
                "version": ""
              }
            ],
            "outputs.manifestNamesByNamespace": {
              "": [
                "namespace staging"
              ],
              "staging": [
                "configMap nginx-status-conf-v000",
                "deployment hostname"
              ]
            },
            "outputs.manifests": [
              {
                "apiVersion": "v1",
                "data": {
                  "nginx.status.conf": "server {\n    listen       8090 default_server;\n    location /nginx_status {\n        stub_status;\n        access_log off;\n    }\n}\n"
                },
                "kind": "ConfigMap",
                "metadata": {
                  "annotations": {
                    "artifact.spinnaker.io/location": "staging",
                    "artifact.spinnaker.io/name": "nginx-status-conf",
                    "artifact.spinnaker.io/type": "kubernetes/configMap",
                    "artifact.spinnaker.io/version": "v000",
                    "kubectl.kubernetes.io/last-applied-configuration": "{\"apiVersion\":\"v1\",\"data\":{\"nginx.status.conf\":\"server {\\n    listen       8090 default_server;\\n    location /nginx_status {\\n        stub_status;\\n        access_log off;\\n    }\\n}\\n\"},\"kind\":\"ConfigMap\",\"metadata\":{\"annotations\":{\"artifact.spinnaker.io/location\":\"staging\",\"artifact.spinnaker.io/name\":\"nginx-status-conf\",\"artifact.spinnaker.io/type\":\"kubernetes/configMap\",\"artifact.spinnaker.io/version\":\"v000\",\"moniker.spinnaker.io/application\":\"hostname\",\"moniker.spinnaker.io/cluster\":\"configMap nginx-status-conf\",\"moniker.spinnaker.io/sequence\":\"0\"},\"labels\":{\"app.kubernetes.io/managed-by\":\"spinnaker\",\"app.kubernetes.io/name\":\"hostname\",\"moniker.spinnaker.io/sequence\":\"0\"},\"name\":\"nginx-status-conf-v000\",\"namespace\":\"staging\"}}\n",
                    "moniker.spinnaker.io/application": "hostname",
                    "moniker.spinnaker.io/cluster": "configMap nginx-status-conf",
                    "moniker.spinnaker.io/sequence": "0"
                  },
                  "creationTimestamp": "2021-04-30T20:39:49Z",
                  "labels": {
                    "app.kubernetes.io/managed-by": "spinnaker",
                    "app.kubernetes.io/name": "hostname",
                    "moniker.spinnaker.io/sequence": "0"
                  },
                  "managedFields": [
                    {
                      "apiVersion": "v1",
                      "fieldsType": "FieldsV1",
                      "fieldsV1": {
                        "f:data": {
                          ".": {},
                          "f:nginx.status.conf": {}
                        },
                        "f:metadata": {
                          "f:annotations": {
                            ".": {},
                            "f:artifact.spinnaker.io/location": {},
                            "f:artifact.spinnaker.io/name": {},
                            "f:artifact.spinnaker.io/type": {},
                            "f:artifact.spinnaker.io/version": {},
                            "f:kubectl.kubernetes.io/last-applied-configuration": {},
                            "f:moniker.spinnaker.io/application": {},
                            "f:moniker.spinnaker.io/cluster": {},
                            "f:moniker.spinnaker.io/sequence": {}
                          },
                          "f:labels": {
                            ".": {},
                            "f:app.kubernetes.io/managed-by": {},
                            "f:app.kubernetes.io/name": {},
                            "f:moniker.spinnaker.io/sequence": {}
                          }
                        }
                      },
                      "manager": "kubectl",
                      "operation": "Update",
                      "time": "2021-04-30T20:39:49Z"
                    }
                  ],
                  "name": "nginx-status-conf-v000",
                  "namespace": "staging",
                  "resourceVersion": "22455936",
                  "selfLink": "/api/v1/namespaces/staging/configmaps/nginx-status-conf-v000",
                  "uid": "bc9f63b0-b8eb-4810-afac-16c0cd61736e"
                }
              },
              {
                "apiVersion": "apps/v1",
                "kind": "Deployment",
                "metadata": {
                  "annotations": {
                    "artifact.spinnaker.io/location": "staging",
                    "artifact.spinnaker.io/name": "hostname",
                    "artifact.spinnaker.io/type": "kubernetes/deployment",
                    "artifact.spinnaker.io/version": "",
                    "deployment.kubernetes.io/revision": "1",
                    "kubectl.kubernetes.io/last-applied-configuration": "{\"apiVersion\":\"apps/v1\",\"kind\":\"Deployment\",\"metadata\":{\"annotations\":{\"artifact.spinnaker.io/location\":\"staging\",\"artifact.spinnaker.io/name\":\"hostname\",\"artifact.spinnaker.io/type\":\"kubernetes/deployment\",\"artifact.spinnaker.io/version\":\"\",\"moniker.spinnaker.io/application\":\"hostname\",\"moniker.spinnaker.io/cluster\":\"deployment hostname\"},\"labels\":{\"app.kubernetes.io/managed-by\":\"spinnaker\",\"app.kubernetes.io/name\":\"hostname\"},\"name\":\"hostname\",\"namespace\":\"staging\"},\"spec\":{\"replicas\":2,\"selector\":{\"matchLabels\":{\"app\":\"hostname\",\"version\":\"v1\"}},\"strategy\":{\"rollingUpdate\":{\"maxSurge\":1,\"maxUnavailable\":1},\"type\":\"RollingUpdate\"},\"template\":{\"metadata\":{\"annotations\":{\"artifact.spinnaker.io/location\":\"staging\",\"artifact.spinnaker.io/name\":\"hostname\",\"artifact.spinnaker.io/type\":\"kubernetes/deployment\",\"artifact.spinnaker.io/version\":\"\",\"moniker.spinnaker.io/application\":\"hostname\",\"moniker.spinnaker.io/cluster\":\"deployment hostname\",\"prometheus.io/port\":\"9113\",\"prometheus.io/scrape\":\"true\"},\"labels\":{\"app\":\"hostname\",\"app.kubernetes.io/managed-by\":\"spinnaker\",\"app.kubernetes.io/name\":\"hostname\",\"version\":\"v1\"}},\"spec\":{\"containers\":[{\"image\":\"rstarmer/hostname:v1\",\"imagePullPolicy\":\"Always\",\"name\":\"hostname\",\"resources\":{},\"volumeMounts\":[{\"mountPath\":\"/etc/nginx/conf.d/nginx-status.conf\",\"name\":\"nginx-status-conf\",\"readOnly\":true,\"subPath\":\"nginx.status.conf\"}]},{\"args\":[\"-nginx.scrape-uri=http://localhost:8090/nginx_status\"],\"image\":\"nginx/nginx-prometheus-exporter:0.3.0\",\"imagePullPolicy\":\"Always\",\"name\":\"nginx-exporter\",\"ports\":[{\"containerPort\":9113,\"name\":\"nginx-ex-port\",\"protocol\":\"TCP\"}]}],\"restartPolicy\":\"Always\",\"volumes\":[{\"configMap\":{\"defaultMode\":420,\"name\":\"nginx-status-conf-v000\"},\"name\":\"nginx-status-conf\"}]}}}}\n",
                    "moniker.spinnaker.io/application": "hostname",
                    "moniker.spinnaker.io/cluster": "deployment hostname"
                  },
                  "creationTimestamp": "2021-05-11T17:03:31Z",
                  "generation": 2,
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
                      "time": "2021-05-11T17:03:31Z"
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
                      "time": "2021-05-11T17:03:35Z"
                    }
                  ],
                  "name": "hostname",
                  "namespace": "staging",
                  "resourceVersion": "25295972",
                  "selfLink": "/apis/apps/v1/namespaces/staging/deployments/hostname",
                  "uid": "ae6a47d3-c37a-4a60-b375-4ea6a7ef9795"
                },
                "spec": {
                  "progressDeadlineSeconds": 600,
                  "replicas": 2,
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
                  "availableReplicas": 5,
                  "conditions": [
                    {
                      "lastTransitionTime": "2021-05-11T17:03:34Z",
                      "lastUpdateTime": "2021-05-11T17:03:34Z",
                      "message": "Deployment has minimum availability.",
                      "reason": "MinimumReplicasAvailable",
                      "status": "True",
                      "type": "Available"
                    },
                    {
                      "lastTransitionTime": "2021-05-11T17:03:31Z",
                      "lastUpdateTime": "2021-05-11T17:03:35Z",
                      "message": "ReplicaSet \"hostname-f5b957cc\" has successfully progressed.",
                      "reason": "NewReplicaSetAvailable",
                      "status": "True",
                      "type": "Progressing"
                    }
                  ],
                  "observedGeneration": 1,
                  "readyReplicas": 5,
                  "replicas": 5,
                  "updatedReplicas": 5
                }
              },
              {
                "apiVersion": "v1",
                "kind": "Namespace",
                "metadata": {
                  "annotations": {
                    "artifact.spinnaker.io/location": "",
                    "artifact.spinnaker.io/name": "staging",
                    "artifact.spinnaker.io/type": "kubernetes/namespace",
                    "artifact.spinnaker.io/version": "",
                    "kubectl.kubernetes.io/last-applied-configuration": "{\"apiVersion\":\"v1\",\"kind\":\"Namespace\",\"metadata\":{\"annotations\":{\"artifact.spinnaker.io/location\":\"\",\"artifact.spinnaker.io/name\":\"staging\",\"artifact.spinnaker.io/type\":\"kubernetes/namespace\",\"artifact.spinnaker.io/version\":\"\",\"moniker.spinnaker.io/application\":\"hostname\",\"moniker.spinnaker.io/cluster\":\"namespace staging\"},\"labels\":{\"app.kubernetes.io/managed-by\":\"spinnaker\",\"app.kubernetes.io/name\":\"hostname\"},\"name\":\"staging\"},\"spec\":{\"finalizers\":[\"kubernetes\"]}}\n",
                    "moniker.spinnaker.io/application": "hostname",
                    "moniker.spinnaker.io/cluster": "namespace staging"
                  },
                  "creationTimestamp": "2021-02-11T00:11:46Z",
                  "labels": {
                    "app.kubernetes.io/managed-by": "spinnaker",
                    "app.kubernetes.io/name": "hostname"
                  },
                  "managedFields": [
                    {
                      "apiVersion": "v1",
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
                          "f:finalizers": {}
                        },
                        "f:status": {
                          "f:phase": {}
                        }
                      },
                      "manager": "kubectl",
                      "operation": "Update",
                      "time": "2021-02-17T22:41:50Z"
                    }
                  ],
                  "name": "staging",
                  "resourceVersion": "4990957",
                  "selfLink": "/api/v1/namespaces/staging",
                  "uid": "6fbe3041-1b24-4a8e-9ff5-527a41f2f441"
                },
                "spec": {
                  "finalizers": [
                    "kubernetes"
                  ]
                },
                "status": {
                  "phase": "Active"
                }
              }
            ],
            "requiredArtifacts": [],
            "skipExpressionEvaluation": false,
            "source": "artifact",
            "stableManifests": [
              {
                "location": "",
                "manifestName": "namespace staging"
              },
              {
                "location": "staging",
                "manifestName": "configMap nginx-status-conf-v000"
              },
              {
                "location": "staging",
                "manifestName": "deployment hostname"
              }
            ],
            "trafficManagement": {
              "enabled": false,
              "options": {
                "enableTraffic": false,
                "services": []
              }
            }
          },
          "endTime": 1620762136450,
          "id": "01F5EF6V5C2ACQ1JS5EDRRJRSG",
          "lastModified": null,
          "name": "Deploy (Manifest) g",
          "outputs": {
            "artifacts": [
              {
                "customKind": false,
                "location": "staging",
                "metadata": {
                  "account": "spinnaker"
                },
                "name": "nginx-status-conf",
                "reference": "nginx-status-conf-v000",
                "type": "kubernetes/configMap",
                "version": "v000"
              },
              {
                "customKind": false,
                "location": "staging",
                "metadata": {
                  "account": "spinnaker"
                },
                "name": "hostname",
                "reference": "hostname",
                "type": "kubernetes/deployment",
                "version": ""
              },
              {
                "customKind": false,
                "location": "",
                "metadata": {
                  "account": "spinnaker"
                },
                "name": "staging",
                "reference": "staging",
                "type": "kubernetes/namespace",
                "version": ""
              }
            ],
            "manifests": [
              {
                "apiVersion": "v1",
                "kind": "Namespace",
                "metadata": {
                  "name": "staging"
                },
                "spec": {
                  "finalizers": [
                    "kubernetes"
                  ]
                }
              },
              {
                "apiVersion": "apps/v1",
                "kind": "Deployment",
                "metadata": {
                  "name": "hostname",
                  "namespace": "staging"
                },
                "spec": {
                  "replicas": 2,
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
                        "prometheus.io/port": "9113",
                        "prometheus.io/scrape": "true"
                      },
                      "labels": {
                        "app": "hostname",
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
                            "name": "nginx-status-conf"
                          },
                          "name": "nginx-status-conf"
                        }
                      ]
                    }
                  }
                }
              },
              {
                "apiVersion": "v1",
                "data": {
                  "nginx.status.conf": "server {\n    listen       8090 default_server;\n    location /nginx_status {\n        stub_status;\n        access_log off;\n    }\n}\n"
                },
                "kind": "ConfigMap",
                "metadata": {
                  "name": "nginx-status-conf",
                  "namespace": "staging"
                }
              }
            ],
            "optionalArtifacts": [
              {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "4aa85178-0618-46c4-b530-6883d393656d"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
                "type": "github/file",
                "version": "master"
              },
              {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
                },
                "name": "manifests/service-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/service-spinnaker.yaml",
                "type": "github/file"
              }
            ],
            "outputs.boundArtifacts": [
              {
                "customKind": false,
                "location": "staging",
                "metadata": {
                  "account": "spinnaker"
                },
                "name": "nginx-status-conf",
                "reference": "nginx-status-conf-v000",
                "type": "kubernetes/configMap",
                "version": "v000"
              }
            ],
            "outputs.createdArtifacts": [
              {
                "customKind": false,
                "location": "staging",
                "metadata": {
                  "account": "spinnaker"
                },
                "name": "nginx-status-conf",
                "reference": "nginx-status-conf-v000",
                "type": "kubernetes/configMap",
                "version": "v000"
              },
              {
                "customKind": false,
                "location": "staging",
                "metadata": {
                  "account": "spinnaker"
                },
                "name": "hostname",
                "reference": "hostname",
                "type": "kubernetes/deployment",
                "version": ""
              },
              {
                "customKind": false,
                "location": "",
                "metadata": {
                  "account": "spinnaker"
                },
                "name": "staging",
                "reference": "staging",
                "type": "kubernetes/namespace",
                "version": ""
              }
            ],
            "outputs.manifestNamesByNamespace": {
              "": [
                "namespace staging"
              ],
              "staging": [
                "configMap nginx-status-conf-v000",
                "deployment hostname"
              ]
            },
            "outputs.manifests": [
              {
                "apiVersion": "v1",
                "data": {
                  "nginx.status.conf": "server {\n    listen       8090 default_server;\n    location /nginx_status {\n        stub_status;\n        access_log off;\n    }\n}\n"
                },
                "kind": "ConfigMap",
                "metadata": {
                  "annotations": {
                    "artifact.spinnaker.io/location": "staging",
                    "artifact.spinnaker.io/name": "nginx-status-conf",
                    "artifact.spinnaker.io/type": "kubernetes/configMap",
                    "artifact.spinnaker.io/version": "v000",
                    "kubectl.kubernetes.io/last-applied-configuration": "{\"apiVersion\":\"v1\",\"data\":{\"nginx.status.conf\":\"server {\\n    listen       8090 default_server;\\n    location /nginx_status {\\n        stub_status;\\n        access_log off;\\n    }\\n}\\n\"},\"kind\":\"ConfigMap\",\"metadata\":{\"annotations\":{\"artifact.spinnaker.io/location\":\"staging\",\"artifact.spinnaker.io/name\":\"nginx-status-conf\",\"artifact.spinnaker.io/type\":\"kubernetes/configMap\",\"artifact.spinnaker.io/version\":\"v000\",\"moniker.spinnaker.io/application\":\"hostname\",\"moniker.spinnaker.io/cluster\":\"configMap nginx-status-conf\",\"moniker.spinnaker.io/sequence\":\"0\"},\"labels\":{\"app.kubernetes.io/managed-by\":\"spinnaker\",\"app.kubernetes.io/name\":\"hostname\",\"moniker.spinnaker.io/sequence\":\"0\"},\"name\":\"nginx-status-conf-v000\",\"namespace\":\"staging\"}}\n",
                    "moniker.spinnaker.io/application": "hostname",
                    "moniker.spinnaker.io/cluster": "configMap nginx-status-conf",
                    "moniker.spinnaker.io/sequence": "0"
                  },
                  "creationTimestamp": "2021-04-30T20:39:49Z",
                  "labels": {
                    "app.kubernetes.io/managed-by": "spinnaker",
                    "app.kubernetes.io/name": "hostname",
                    "moniker.spinnaker.io/sequence": "0"
                  },
                  "managedFields": [
                    {
                      "apiVersion": "v1",
                      "fieldsType": "FieldsV1",
                      "fieldsV1": {
                        "f:data": {
                          ".": {},
                          "f:nginx.status.conf": {}
                        },
                        "f:metadata": {
                          "f:annotations": {
                            ".": {},
                            "f:artifact.spinnaker.io/location": {},
                            "f:artifact.spinnaker.io/name": {},
                            "f:artifact.spinnaker.io/type": {},
                            "f:artifact.spinnaker.io/version": {},
                            "f:kubectl.kubernetes.io/last-applied-configuration": {},
                            "f:moniker.spinnaker.io/application": {},
                            "f:moniker.spinnaker.io/cluster": {},
                            "f:moniker.spinnaker.io/sequence": {}
                          },
                          "f:labels": {
                            ".": {},
                            "f:app.kubernetes.io/managed-by": {},
                            "f:app.kubernetes.io/name": {},
                            "f:moniker.spinnaker.io/sequence": {}
                          }
                        }
                      },
                      "manager": "kubectl",
                      "operation": "Update",
                      "time": "2021-04-30T20:39:49Z"
                    }
                  ],
                  "name": "nginx-status-conf-v000",
                  "namespace": "staging",
                  "resourceVersion": "22455936",
                  "selfLink": "/api/v1/namespaces/staging/configmaps/nginx-status-conf-v000",
                  "uid": "bc9f63b0-b8eb-4810-afac-16c0cd61736e"
                }
              },
              {
                "apiVersion": "apps/v1",
                "kind": "Deployment",
                "metadata": {
                  "annotations": {
                    "artifact.spinnaker.io/location": "staging",
                    "artifact.spinnaker.io/name": "hostname",
                    "artifact.spinnaker.io/type": "kubernetes/deployment",
                    "artifact.spinnaker.io/version": "",
                    "deployment.kubernetes.io/revision": "1",
                    "kubectl.kubernetes.io/last-applied-configuration": "{\"apiVersion\":\"apps/v1\",\"kind\":\"Deployment\",\"metadata\":{\"annotations\":{\"artifact.spinnaker.io/location\":\"staging\",\"artifact.spinnaker.io/name\":\"hostname\",\"artifact.spinnaker.io/type\":\"kubernetes/deployment\",\"artifact.spinnaker.io/version\":\"\",\"moniker.spinnaker.io/application\":\"hostname\",\"moniker.spinnaker.io/cluster\":\"deployment hostname\"},\"labels\":{\"app.kubernetes.io/managed-by\":\"spinnaker\",\"app.kubernetes.io/name\":\"hostname\"},\"name\":\"hostname\",\"namespace\":\"staging\"},\"spec\":{\"replicas\":2,\"selector\":{\"matchLabels\":{\"app\":\"hostname\",\"version\":\"v1\"}},\"strategy\":{\"rollingUpdate\":{\"maxSurge\":1,\"maxUnavailable\":1},\"type\":\"RollingUpdate\"},\"template\":{\"metadata\":{\"annotations\":{\"artifact.spinnaker.io/location\":\"staging\",\"artifact.spinnaker.io/name\":\"hostname\",\"artifact.spinnaker.io/type\":\"kubernetes/deployment\",\"artifact.spinnaker.io/version\":\"\",\"moniker.spinnaker.io/application\":\"hostname\",\"moniker.spinnaker.io/cluster\":\"deployment hostname\",\"prometheus.io/port\":\"9113\",\"prometheus.io/scrape\":\"true\"},\"labels\":{\"app\":\"hostname\",\"app.kubernetes.io/managed-by\":\"spinnaker\",\"app.kubernetes.io/name\":\"hostname\",\"version\":\"v1\"}},\"spec\":{\"containers\":[{\"image\":\"rstarmer/hostname:v1\",\"imagePullPolicy\":\"Always\",\"name\":\"hostname\",\"resources\":{},\"volumeMounts\":[{\"mountPath\":\"/etc/nginx/conf.d/nginx-status.conf\",\"name\":\"nginx-status-conf\",\"readOnly\":true,\"subPath\":\"nginx.status.conf\"}]},{\"args\":[\"-nginx.scrape-uri=http://localhost:8090/nginx_status\"],\"image\":\"nginx/nginx-prometheus-exporter:0.3.0\",\"imagePullPolicy\":\"Always\",\"name\":\"nginx-exporter\",\"ports\":[{\"containerPort\":9113,\"name\":\"nginx-ex-port\",\"protocol\":\"TCP\"}]}],\"restartPolicy\":\"Always\",\"volumes\":[{\"configMap\":{\"defaultMode\":420,\"name\":\"nginx-status-conf-v000\"},\"name\":\"nginx-status-conf\"}]}}}}\n",
                    "moniker.spinnaker.io/application": "hostname",
                    "moniker.spinnaker.io/cluster": "deployment hostname"
                  },
                  "creationTimestamp": "2021-05-11T17:03:31Z",
                  "generation": 2,
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
                      "time": "2021-05-11T17:03:31Z"
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
                      "time": "2021-05-11T17:03:35Z"
                    }
                  ],
                  "name": "hostname",
                  "namespace": "staging",
                  "resourceVersion": "25295972",
                  "selfLink": "/apis/apps/v1/namespaces/staging/deployments/hostname",
                  "uid": "ae6a47d3-c37a-4a60-b375-4ea6a7ef9795"
                },
                "spec": {
                  "progressDeadlineSeconds": 600,
                  "replicas": 2,
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
                  "availableReplicas": 5,
                  "conditions": [
                    {
                      "lastTransitionTime": "2021-05-11T17:03:34Z",
                      "lastUpdateTime": "2021-05-11T17:03:34Z",
                      "message": "Deployment has minimum availability.",
                      "reason": "MinimumReplicasAvailable",
                      "status": "True",
                      "type": "Available"
                    },
                    {
                      "lastTransitionTime": "2021-05-11T17:03:31Z",
                      "lastUpdateTime": "2021-05-11T17:03:35Z",
                      "message": "ReplicaSet \"hostname-f5b957cc\" has successfully progressed.",
                      "reason": "NewReplicaSetAvailable",
                      "status": "True",
                      "type": "Progressing"
                    }
                  ],
                  "observedGeneration": 1,
                  "readyReplicas": 5,
                  "replicas": 5,
                  "updatedReplicas": 5
                }
              },
              {
                "apiVersion": "v1",
                "kind": "Namespace",
                "metadata": {
                  "annotations": {
                    "artifact.spinnaker.io/location": "",
                    "artifact.spinnaker.io/name": "staging",
                    "artifact.spinnaker.io/type": "kubernetes/namespace",
                    "artifact.spinnaker.io/version": "",
                    "kubectl.kubernetes.io/last-applied-configuration": "{\"apiVersion\":\"v1\",\"kind\":\"Namespace\",\"metadata\":{\"annotations\":{\"artifact.spinnaker.io/location\":\"\",\"artifact.spinnaker.io/name\":\"staging\",\"artifact.spinnaker.io/type\":\"kubernetes/namespace\",\"artifact.spinnaker.io/version\":\"\",\"moniker.spinnaker.io/application\":\"hostname\",\"moniker.spinnaker.io/cluster\":\"namespace staging\"},\"labels\":{\"app.kubernetes.io/managed-by\":\"spinnaker\",\"app.kubernetes.io/name\":\"hostname\"},\"name\":\"staging\"},\"spec\":{\"finalizers\":[\"kubernetes\"]}}\n",
                    "moniker.spinnaker.io/application": "hostname",
                    "moniker.spinnaker.io/cluster": "namespace staging"
                  },
                  "creationTimestamp": "2021-02-11T00:11:46Z",
                  "labels": {
                    "app.kubernetes.io/managed-by": "spinnaker",
                    "app.kubernetes.io/name": "hostname"
                  },
                  "managedFields": [
                    {
                      "apiVersion": "v1",
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
                          "f:finalizers": {}
                        },
                        "f:status": {
                          "f:phase": {}
                        }
                      },
                      "manager": "kubectl",
                      "operation": "Update",
                      "time": "2021-02-17T22:41:50Z"
                    }
                  ],
                  "name": "staging",
                  "resourceVersion": "4990957",
                  "selfLink": "/api/v1/namespaces/staging",
                  "uid": "6fbe3041-1b24-4a8e-9ff5-527a41f2f441"
                },
                "spec": {
                  "finalizers": [
                    "kubernetes"
                  ]
                },
                "status": {
                  "phase": "Active"
                }
              }
            ],
            "requiredArtifacts": []
          },
          "parentStageId": null,
          "refId": "2",
          "requisiteStageRefIds": [],
          "scheduledTime": null,
          "startTime": 1620762127653,
          "startTimeExpiry": null,
          "status": "SUCCEEDED",
          "syntheticStageOwner": null,
          "tasks": [
            {
              "endTime": 1620762128270,
              "id": "1",
              "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.manifest.ResolveDeploySourceManifestTask",
              "loopEnd": false,
              "loopStart": false,
              "name": "resolveDeploySourceManifest",
              "stageEnd": false,
              "stageStart": true,
              "startTime": 1620762127728,
              "status": "SUCCEEDED"
            },
            {
              "endTime": 1620762128764,
              "id": "2",
              "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.manifest.DeployManifestTask",
              "loopEnd": false,
              "loopStart": false,
              "name": "deployManifest",
              "stageEnd": false,
              "stageStart": false,
              "startTime": 1620762128303,
              "status": "SUCCEEDED"
            },
            {
              "endTime": 1620762134083,
              "id": "3",
              "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.MonitorKatoTask",
              "loopEnd": false,
              "loopStart": false,
              "name": "monitorDeploy",
              "stageEnd": false,
              "stageStart": false,
              "startTime": 1620762128780,
              "status": "SUCCEEDED"
            },
            {
              "endTime": 1620762134309,
              "id": "4",
              "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.manifest.PromoteManifestKatoOutputsTask",
              "loopEnd": false,
              "loopStart": false,
              "name": "promoteOutputs",
              "stageEnd": false,
              "stageStart": false,
              "startTime": 1620762134144,
              "status": "SUCCEEDED"
            },
            {
              "endTime": 1620762135153,
              "id": "5",
              "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.manifest.WaitForManifestStableTask",
              "loopEnd": false,
              "loopStart": false,
              "name": "waitForManifestToStabilize",
              "stageEnd": false,
              "stageStart": false,
              "startTime": 1620762134334,
              "status": "SUCCEEDED"
            },
            {
              "endTime": 1620762135561,
              "id": "6",
              "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.artifacts.CleanupArtifactsTask",
              "loopEnd": false,
              "loopStart": false,
              "name": "cleanupArtifacts",
              "stageEnd": false,
              "stageStart": false,
              "startTime": 1620762135210,
              "status": "SUCCEEDED"
            },
            {
              "endTime": 1620762135869,
              "id": "7",
              "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.MonitorKatoTask",
              "loopEnd": false,
              "loopStart": false,
              "name": "monitorCleanup",
              "stageEnd": false,
              "stageStart": false,
              "startTime": 1620762135625,
              "status": "SUCCEEDED"
            },
            {
              "endTime": 1620762136088,
              "id": "8",
              "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.manifest.PromoteManifestKatoOutputsTask",
              "loopEnd": false,
              "loopStart": false,
              "name": "promoteOutputs",
              "stageEnd": false,
              "stageStart": false,
              "startTime": 1620762135894,
              "status": "SUCCEEDED"
            },
            {
              "endTime": 1620762136370,
              "id": "9",
              "implementingClass": "com.netflix.spinnaker.orca.pipeline.tasks.artifacts.BindProducedArtifactsTask",
              "loopEnd": false,
              "loopStart": false,
              "name": "bindProducedArtifacts",
              "stageEnd": true,
              "stageStart": false,
              "startTime": 1620762136156,
              "status": "SUCCEEDED"
            }
          ],
          "type": "deployManifest"
        },
        {
          "context": {
            "account": "spinnaker",
            "artifacts": [
              {
                "customKind": false,
                "location": "staging",
                "metadata": {
                  "account": "spinnaker"
                },
                "name": "hostname",
                "reference": "hostname",
                "type": "kubernetes/service",
                "version": ""
              },
              {
                "customKind": false,
                "location": "staging",
                "metadata": {
                  "account": "spinnaker"
                },
                "name": "hostname-metrics",
                "reference": "hostname-metrics",
                "type": "kubernetes/service",
                "version": ""
              }
            ],
            "cloudProvider": "kubernetes",
            "deploy.account.name": "spinnaker",
            "deploy.server.groups": {},
            "failedManifests": [],
            "kato.last.task.id": {
              "id": "c73aa1cd-4592-49d1-8ea9-f8ae984c73d4"
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
                    "status": "Processing op: KubernetesDeployManifestOperation"
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Beginning deployment of manifest..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Swapping out artifacts in service hostname from context..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Finding deployer for service..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Swapping out artifacts in service hostname-metrics from context..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Finding deployer for service..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Checking if all requested artifacts were bound..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Sorting manifests by priority..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Finding deployer for service..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Finding deployer for service..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Deploy order is: service hostname, service hostname-metrics"
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Finding deployer for service..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Annotating manifest service hostname with artifact, relationships & moniker..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Swapping out artifacts in service hostname from other deployments..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Submitting manifest service hostname to kubernetes master..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Finding deployer for service..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Annotating manifest service hostname-metrics with artifact, relationships & moniker..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Swapping out artifacts in service hostname-metrics from other deployments..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Submitting manifest service hostname-metrics to kubernetes master..."
                  },
                  {
                    "phase": "DEPLOY_KUBERNETES_MANIFEST",
                    "status": "Deploy manifest task completed successfully."
                  },
                  {
                    "phase": "ORCHESTRATION",
                    "status": "Orchestration completed."
                  }
                ],
                "id": "f811294a-09a9-4541-86bd-e749aa7c5e66",
                "resultObjects": [
                  {
                    "boundArtifacts": [],
                    "createdArtifacts": [
                      {
                        "customKind": false,
                        "location": "staging",
                        "metadata": {
                          "account": "spinnaker"
                        },
                        "name": "hostname",
                        "reference": "hostname",
                        "type": "kubernetes/service",
                        "version": ""
                      },
                      {
                        "customKind": false,
                        "location": "staging",
                        "metadata": {
                          "account": "spinnaker"
                        },
                        "name": "hostname-metrics",
                        "reference": "hostname-metrics",
                        "type": "kubernetes/service",
                        "version": ""
                      }
                    ],
                    "manifestNamesByNamespace": {
                      "staging": [
                        "service hostname-metrics",
                        "service hostname"
                      ]
                    },
                    "manifests": [
                      {
                        "apiVersion": "v1",
                        "kind": "Service",
                        "metadata": {
                          "annotations": {
                            "artifact.spinnaker.io/location": "staging",
                            "artifact.spinnaker.io/name": "hostname-metrics",
                            "artifact.spinnaker.io/type": "kubernetes/service",
                            "artifact.spinnaker.io/version": "",
                            "kubectl.kubernetes.io/last-applied-configuration": "{\"apiVersion\":\"v1\",\"kind\":\"Service\",\"metadata\":{\"annotations\":{\"artifact.spinnaker.io/location\":\"staging\",\"artifact.spinnaker.io/name\":\"hostname-metrics\",\"artifact.spinnaker.io/type\":\"kubernetes/service\",\"artifact.spinnaker.io/version\":\"\",\"moniker.spinnaker.io/application\":\"hostname\",\"moniker.spinnaker.io/cluster\":\"service hostname-metrics\"},\"labels\":{\"app\":\"hostname\",\"app.kubernetes.io/managed-by\":\"spinnaker\",\"app.kubernetes.io/name\":\"hostname\"},\"name\":\"hostname-metrics\",\"namespace\":\"staging\"},\"spec\":{\"ports\":[{\"name\":\"metrics\",\"port\":9113,\"protocol\":\"TCP\",\"targetPort\":9113}],\"selector\":{\"app\":\"hostname\"},\"sessionAffinity\":\"None\",\"type\":\"ClusterIP\"}}\n",
                            "moniker.spinnaker.io/application": "hostname",
                            "moniker.spinnaker.io/cluster": "service hostname-metrics"
                          },
                          "creationTimestamp": "2021-04-30T21:00:08Z",
                          "labels": {
                            "app": "hostname",
                            "app.kubernetes.io/managed-by": "spinnaker",
                            "app.kubernetes.io/name": "hostname"
                          },
                          "managedFields": [
                            {
                              "apiVersion": "v1",
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
                                    "f:app": {},
                                    "f:app.kubernetes.io/managed-by": {},
                                    "f:app.kubernetes.io/name": {}
                                  }
                                },
                                "f:spec": {
                                  "f:ports": {
                                    ".": {},
                                    "k:{\"port\":9113,\"protocol\":\"TCP\"}": {
                                      ".": {},
                                      "f:name": {},
                                      "f:port": {},
                                      "f:protocol": {},
                                      "f:targetPort": {}
                                    }
                                  },
                                  "f:selector": {
                                    ".": {},
                                    "f:app": {}
                                  },
                                  "f:sessionAffinity": {},
                                  "f:type": {}
                                }
                              },
                              "manager": "kubectl",
                              "operation": "Update",
                              "time": "2021-04-30T21:00:08Z"
                            }
                          ],
                          "name": "hostname-metrics",
                          "namespace": "staging",
                          "resourceVersion": "22460213",
                          "selfLink": "/api/v1/namespaces/staging/services/hostname-metrics",
                          "uid": "e691cbe4-652a-4ada-aba2-114887f0d8ee"
                        },
                        "spec": {
                          "clusterIP": "10.100.35.221",
                          "ports": [
                            {
                              "name": "metrics",
                              "port": 9113,
                              "protocol": "TCP",
                              "targetPort": 9113
                            }
                          ],
                          "selector": {
                            "app": "hostname"
                          },
                          "sessionAffinity": "None",
                          "type": "ClusterIP"
                        },
                        "status": {
                          "loadBalancer": {}
                        }
                      },
                      {
                        "apiVersion": "v1",
                        "kind": "Service",
                        "metadata": {
                          "annotations": {
                            "artifact.spinnaker.io/location": "staging",
                            "artifact.spinnaker.io/name": "hostname",
                            "artifact.spinnaker.io/type": "kubernetes/service",
                            "artifact.spinnaker.io/version": "",
                            "kubectl.kubernetes.io/last-applied-configuration": "{\"apiVersion\":\"v1\",\"kind\":\"Service\",\"metadata\":{\"annotations\":{\"artifact.spinnaker.io/location\":\"staging\",\"artifact.spinnaker.io/name\":\"hostname\",\"artifact.spinnaker.io/type\":\"kubernetes/service\",\"artifact.spinnaker.io/version\":\"\",\"moniker.spinnaker.io/application\":\"hostname\",\"moniker.spinnaker.io/cluster\":\"service hostname\"},\"labels\":{\"app\":\"hostname\",\"app.kubernetes.io/managed-by\":\"spinnaker\",\"app.kubernetes.io/name\":\"hostname\"},\"name\":\"hostname\",\"namespace\":\"staging\"},\"spec\":{\"ports\":[{\"port\":80,\"protocol\":\"TCP\",\"targetPort\":80}],\"selector\":{\"app\":\"hostname\"},\"sessionAffinity\":\"None\",\"type\":\"LoadBalancer\"}}\n",
                            "moniker.spinnaker.io/application": "hostname",
                            "moniker.spinnaker.io/cluster": "service hostname"
                          },
                          "creationTimestamp": "2021-02-11T04:00:54Z",
                          "finalizers": [
                            "service.kubernetes.io/load-balancer-cleanup"
                          ],
                          "labels": {
                            "app": "hostname",
                            "app.kubernetes.io/managed-by": "spinnaker",
                            "app.kubernetes.io/name": "hostname"
                          },
                          "managedFields": [
                            {
                              "apiVersion": "v1",
                              "fieldsType": "FieldsV1",
                              "fieldsV1": {
                                "f:metadata": {
                                  "f:finalizers": {
                                    ".": {},
                                    "v:\"service.kubernetes.io/load-balancer-cleanup\"": {}
                                  }
                                },
                                "f:status": {
                                  "f:loadBalancer": {
                                    "f:ingress": {}
                                  }
                                }
                              },
                              "manager": "kube-controller-manager",
                              "operation": "Update",
                              "time": "2021-02-11T04:00:55Z"
                            },
                            {
                              "apiVersion": "v1",
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
                                    "f:app": {},
                                    "f:app.kubernetes.io/managed-by": {},
                                    "f:app.kubernetes.io/name": {}
                                  }
                                },
                                "f:spec": {
                                  "f:externalTrafficPolicy": {},
                                  "f:ports": {
                                    ".": {},
                                    "k:{\"port\":80,\"protocol\":\"TCP\"}": {
                                      ".": {},
                                      "f:port": {},
                                      "f:protocol": {},
                                      "f:targetPort": {}
                                    }
                                  },
                                  "f:selector": {
                                    ".": {},
                                    "f:app": {}
                                  },
                                  "f:sessionAffinity": {},
                                  "f:type": {}
                                }
                              },
                              "manager": "kubectl",
                              "operation": "Update",
                              "time": "2021-05-11T19:42:09Z"
                            }
                          ],
                          "name": "hostname",
                          "namespace": "staging",
                          "resourceVersion": "25295962",
                          "selfLink": "/api/v1/namespaces/staging/services/hostname",
                          "uid": "531793b5-68db-46df-b6ed-59101472a1b3"
                        },
                        "spec": {
                          "clusterIP": "10.100.186.60",
                          "externalTrafficPolicy": "Cluster",
                          "ports": [
                            {
                              "nodePort": 31334,
                              "port": 80,
                              "protocol": "TCP",
                              "targetPort": 80
                            }
                          ],
                          "selector": {
                            "app": "hostname"
                          },
                          "sessionAffinity": "None",
                          "type": "LoadBalancer"
                        },
                        "status": {
                          "loadBalancer": {
                            "ingress": [
                              {
                                "hostname": "a531793b568db46dfb6ed59101472a1b-996363535.us-east-2.elb.amazonaws.com"
                              }
                            ]
                          }
                        }
                      }
                    ]
                  }
                ],
                "status": {
                  "completed": true,
                  "failed": false,
                  "retryable": false
                }
              },
              {
                "history": [
                  {
                    "phase": "ORCHESTRATION",
                    "status": "Initializing Orchestration Task"
                  },
                  {
                    "phase": "ORCHESTRATION",
                    "status": "Processing op: KubernetesCleanupArtifactsOperation"
                  },
                  {
                    "phase": "ORCHESTRATION",
                    "status": "Orchestration completed."
                  }
                ],
                "id": "c73aa1cd-4592-49d1-8ea9-f8ae984c73d4",
                "resultObjects": [
                  {
                    "boundArtifacts": [],
                    "createdArtifacts": [],
                    "manifestNamesByNamespace": {}
                  }
                ],
                "status": {
                  "completed": true,
                  "failed": false,
                  "retryable": false
                }
              }
            ],
            "manifestArtifactId": "425d20a8-2942-4902-8d2b-277769a1492c",
            "manifests": [
              {
                "apiVersion": "v1",
                "kind": "Service",
                "metadata": {
                  "labels": {
                    "app": "hostname"
                  },
                  "name": "hostname",
                  "namespace": "staging"
                },
                "spec": {
                  "ports": [
                    {
                      "port": 80,
                      "protocol": "TCP",
                      "targetPort": 80
                    }
                  ],
                  "selector": {
                    "app": "hostname"
                  },
                  "sessionAffinity": "None",
                  "type": "LoadBalancer"
                }
              },
              {
                "apiVersion": "v1",
                "kind": "Service",
                "metadata": {
                  "labels": {
                    "app": "hostname"
                  },
                  "name": "hostname-metrics",
                  "namespace": "staging"
                },
                "spec": {
                  "ports": [
                    {
                      "name": "metrics",
                      "port": 9113,
                      "protocol": "TCP",
                      "targetPort": 9113
                    }
                  ],
                  "selector": {
                    "app": "hostname"
                  },
                  "sessionAffinity": "None",
                  "type": "ClusterIP"
                }
              }
            ],
            "messages": [],
            "moniker": {
              "app": "hostname"
            },
            "optionalArtifacts": [
              {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "4aa85178-0618-46c4-b530-6883d393656d"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
                "type": "github/file",
                "version": "master"
              },
              {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
                },
                "name": "manifests/service-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/service-spinnaker.yaml",
                "type": "github/file"
              }
            ],
            "outputs.boundArtifacts": [],
            "outputs.createdArtifacts": [
              {
                "customKind": false,
                "location": "staging",
                "metadata": {
                  "account": "spinnaker"
                },
                "name": "hostname",
                "reference": "hostname",
                "type": "kubernetes/service",
                "version": ""
              },
              {
                "customKind": false,
                "location": "staging",
                "metadata": {
                  "account": "spinnaker"
                },
                "name": "hostname-metrics",
                "reference": "hostname-metrics",
                "type": "kubernetes/service",
                "version": ""
              }
            ],
            "outputs.manifestNamesByNamespace": {
              "staging": [
                "service hostname-metrics",
                "service hostname"
              ]
            },
            "outputs.manifests": [
              {
                "apiVersion": "v1",
                "kind": "Service",
                "metadata": {
                  "annotations": {
                    "artifact.spinnaker.io/location": "staging",
                    "artifact.spinnaker.io/name": "hostname-metrics",
                    "artifact.spinnaker.io/type": "kubernetes/service",
                    "artifact.spinnaker.io/version": "",
                    "kubectl.kubernetes.io/last-applied-configuration": "{\"apiVersion\":\"v1\",\"kind\":\"Service\",\"metadata\":{\"annotations\":{\"artifact.spinnaker.io/location\":\"staging\",\"artifact.spinnaker.io/name\":\"hostname-metrics\",\"artifact.spinnaker.io/type\":\"kubernetes/service\",\"artifact.spinnaker.io/version\":\"\",\"moniker.spinnaker.io/application\":\"hostname\",\"moniker.spinnaker.io/cluster\":\"service hostname-metrics\"},\"labels\":{\"app\":\"hostname\",\"app.kubernetes.io/managed-by\":\"spinnaker\",\"app.kubernetes.io/name\":\"hostname\"},\"name\":\"hostname-metrics\",\"namespace\":\"staging\"},\"spec\":{\"ports\":[{\"name\":\"metrics\",\"port\":9113,\"protocol\":\"TCP\",\"targetPort\":9113}],\"selector\":{\"app\":\"hostname\"},\"sessionAffinity\":\"None\",\"type\":\"ClusterIP\"}}\n",
                    "moniker.spinnaker.io/application": "hostname",
                    "moniker.spinnaker.io/cluster": "service hostname-metrics"
                  },
                  "creationTimestamp": "2021-04-30T21:00:08Z",
                  "labels": {
                    "app": "hostname",
                    "app.kubernetes.io/managed-by": "spinnaker",
                    "app.kubernetes.io/name": "hostname"
                  },
                  "managedFields": [
                    {
                      "apiVersion": "v1",
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
                            "f:app": {},
                            "f:app.kubernetes.io/managed-by": {},
                            "f:app.kubernetes.io/name": {}
                          }
                        },
                        "f:spec": {
                          "f:ports": {
                            ".": {},
                            "k:{\"port\":9113,\"protocol\":\"TCP\"}": {
                              ".": {},
                              "f:name": {},
                              "f:port": {},
                              "f:protocol": {},
                              "f:targetPort": {}
                            }
                          },
                          "f:selector": {
                            ".": {},
                            "f:app": {}
                          },
                          "f:sessionAffinity": {},
                          "f:type": {}
                        }
                      },
                      "manager": "kubectl",
                      "operation": "Update",
                      "time": "2021-04-30T21:00:08Z"
                    }
                  ],
                  "name": "hostname-metrics",
                  "namespace": "staging",
                  "resourceVersion": "22460213",
                  "selfLink": "/api/v1/namespaces/staging/services/hostname-metrics",
                  "uid": "e691cbe4-652a-4ada-aba2-114887f0d8ee"
                },
                "spec": {
                  "clusterIP": "10.100.35.221",
                  "ports": [
                    {
                      "name": "metrics",
                      "port": 9113,
                      "protocol": "TCP",
                      "targetPort": 9113
                    }
                  ],
                  "selector": {
                    "app": "hostname"
                  },
                  "sessionAffinity": "None",
                  "type": "ClusterIP"
                },
                "status": {
                  "loadBalancer": {}
                }
              },
              {
                "apiVersion": "v1",
                "kind": "Service",
                "metadata": {
                  "annotations": {
                    "artifact.spinnaker.io/location": "staging",
                    "artifact.spinnaker.io/name": "hostname",
                    "artifact.spinnaker.io/type": "kubernetes/service",
                    "artifact.spinnaker.io/version": "",
                    "kubectl.kubernetes.io/last-applied-configuration": "{\"apiVersion\":\"v1\",\"kind\":\"Service\",\"metadata\":{\"annotations\":{\"artifact.spinnaker.io/location\":\"staging\",\"artifact.spinnaker.io/name\":\"hostname\",\"artifact.spinnaker.io/type\":\"kubernetes/service\",\"artifact.spinnaker.io/version\":\"\",\"moniker.spinnaker.io/application\":\"hostname\",\"moniker.spinnaker.io/cluster\":\"service hostname\"},\"labels\":{\"app\":\"hostname\",\"app.kubernetes.io/managed-by\":\"spinnaker\",\"app.kubernetes.io/name\":\"hostname\"},\"name\":\"hostname\",\"namespace\":\"staging\"},\"spec\":{\"ports\":[{\"port\":80,\"protocol\":\"TCP\",\"targetPort\":80}],\"selector\":{\"app\":\"hostname\"},\"sessionAffinity\":\"None\",\"type\":\"LoadBalancer\"}}\n",
                    "moniker.spinnaker.io/application": "hostname",
                    "moniker.spinnaker.io/cluster": "service hostname"
                  },
                  "creationTimestamp": "2021-02-11T04:00:54Z",
                  "finalizers": [
                    "service.kubernetes.io/load-balancer-cleanup"
                  ],
                  "labels": {
                    "app": "hostname",
                    "app.kubernetes.io/managed-by": "spinnaker",
                    "app.kubernetes.io/name": "hostname"
                  },
                  "managedFields": [
                    {
                      "apiVersion": "v1",
                      "fieldsType": "FieldsV1",
                      "fieldsV1": {
                        "f:metadata": {
                          "f:finalizers": {
                            ".": {},
                            "v:\"service.kubernetes.io/load-balancer-cleanup\"": {}
                          }
                        },
                        "f:status": {
                          "f:loadBalancer": {
                            "f:ingress": {}
                          }
                        }
                      },
                      "manager": "kube-controller-manager",
                      "operation": "Update",
                      "time": "2021-02-11T04:00:55Z"
                    },
                    {
                      "apiVersion": "v1",
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
                            "f:app": {},
                            "f:app.kubernetes.io/managed-by": {},
                            "f:app.kubernetes.io/name": {}
                          }
                        },
                        "f:spec": {
                          "f:externalTrafficPolicy": {},
                          "f:ports": {
                            ".": {},
                            "k:{\"port\":80,\"protocol\":\"TCP\"}": {
                              ".": {},
                              "f:port": {},
                              "f:protocol": {},
                              "f:targetPort": {}
                            }
                          },
                          "f:selector": {
                            ".": {},
                            "f:app": {}
                          },
                          "f:sessionAffinity": {},
                          "f:type": {}
                        }
                      },
                      "manager": "kubectl",
                      "operation": "Update",
                      "time": "2021-05-11T19:42:09Z"
                    }
                  ],
                  "name": "hostname",
                  "namespace": "staging",
                  "resourceVersion": "25295962",
                  "selfLink": "/api/v1/namespaces/staging/services/hostname",
                  "uid": "531793b5-68db-46df-b6ed-59101472a1b3"
                },
                "spec": {
                  "clusterIP": "10.100.186.60",
                  "externalTrafficPolicy": "Cluster",
                  "ports": [
                    {
                      "nodePort": 31334,
                      "port": 80,
                      "protocol": "TCP",
                      "targetPort": 80
                    }
                  ],
                  "selector": {
                    "app": "hostname"
                  },
                  "sessionAffinity": "None",
                  "type": "LoadBalancer"
                },
                "status": {
                  "loadBalancer": {
                    "ingress": [
                      {
                        "hostname": "a531793b568db46dfb6ed59101472a1b-996363535.us-east-2.elb.amazonaws.com"
                      }
                    ]
                  }
                }
              }
            ],
            "requiredArtifacts": [],
            "skipExpressionEvaluation": false,
            "source": "artifact",
            "stableManifests": [
              {
                "location": "staging",
                "manifestName": "service hostname-metrics"
              },
              {
                "location": "staging",
                "manifestName": "service hostname"
              }
            ],
            "trafficManagement": {
              "enabled": false,
              "options": {
                "enableTraffic": false,
                "services": []
              }
            }
          },
          "endTime": 1620762136373,
          "id": "01F5EF6V5CB35AVTRBPMMGK3Z5",
          "lastModified": null,
          "name": "Deploy service (Manifest)",
          "outputs": {
            "artifacts": [
              {
                "customKind": false,
                "location": "staging",
                "metadata": {
                  "account": "spinnaker"
                },
                "name": "hostname",
                "reference": "hostname",
                "type": "kubernetes/service",
                "version": ""
              },
              {
                "customKind": false,
                "location": "staging",
                "metadata": {
                  "account": "spinnaker"
                },
                "name": "hostname-metrics",
                "reference": "hostname-metrics",
                "type": "kubernetes/service",
                "version": ""
              }
            ],
            "manifests": [
              {
                "apiVersion": "v1",
                "kind": "Service",
                "metadata": {
                  "labels": {
                    "app": "hostname"
                  },
                  "name": "hostname",
                  "namespace": "staging"
                },
                "spec": {
                  "ports": [
                    {
                      "port": 80,
                      "protocol": "TCP",
                      "targetPort": 80
                    }
                  ],
                  "selector": {
                    "app": "hostname"
                  },
                  "sessionAffinity": "None",
                  "type": "LoadBalancer"
                }
              },
              {
                "apiVersion": "v1",
                "kind": "Service",
                "metadata": {
                  "labels": {
                    "app": "hostname"
                  },
                  "name": "hostname-metrics",
                  "namespace": "staging"
                },
                "spec": {
                  "ports": [
                    {
                      "name": "metrics",
                      "port": 9113,
                      "protocol": "TCP",
                      "targetPort": 9113
                    }
                  ],
                  "selector": {
                    "app": "hostname"
                  },
                  "sessionAffinity": "None",
                  "type": "ClusterIP"
                }
              }
            ],
            "optionalArtifacts": [
              {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "4aa85178-0618-46c4-b530-6883d393656d"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
                "type": "github/file",
                "version": "master"
              },
              {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
                },
                "name": "manifests/service-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/service-spinnaker.yaml",
                "type": "github/file"
              }
            ],
            "outputs.boundArtifacts": [],
            "outputs.createdArtifacts": [
              {
                "customKind": false,
                "location": "staging",
                "metadata": {
                  "account": "spinnaker"
                },
                "name": "hostname",
                "reference": "hostname",
                "type": "kubernetes/service",
                "version": ""
              },
              {
                "customKind": false,
                "location": "staging",
                "metadata": {
                  "account": "spinnaker"
                },
                "name": "hostname-metrics",
                "reference": "hostname-metrics",
                "type": "kubernetes/service",
                "version": ""
              }
            ],
            "outputs.manifestNamesByNamespace": {
              "staging": [
                "service hostname-metrics",
                "service hostname"
              ]
            },
            "outputs.manifests": [
              {
                "apiVersion": "v1",
                "kind": "Service",
                "metadata": {
                  "annotations": {
                    "artifact.spinnaker.io/location": "staging",
                    "artifact.spinnaker.io/name": "hostname-metrics",
                    "artifact.spinnaker.io/type": "kubernetes/service",
                    "artifact.spinnaker.io/version": "",
                    "kubectl.kubernetes.io/last-applied-configuration": "{\"apiVersion\":\"v1\",\"kind\":\"Service\",\"metadata\":{\"annotations\":{\"artifact.spinnaker.io/location\":\"staging\",\"artifact.spinnaker.io/name\":\"hostname-metrics\",\"artifact.spinnaker.io/type\":\"kubernetes/service\",\"artifact.spinnaker.io/version\":\"\",\"moniker.spinnaker.io/application\":\"hostname\",\"moniker.spinnaker.io/cluster\":\"service hostname-metrics\"},\"labels\":{\"app\":\"hostname\",\"app.kubernetes.io/managed-by\":\"spinnaker\",\"app.kubernetes.io/name\":\"hostname\"},\"name\":\"hostname-metrics\",\"namespace\":\"staging\"},\"spec\":{\"ports\":[{\"name\":\"metrics\",\"port\":9113,\"protocol\":\"TCP\",\"targetPort\":9113}],\"selector\":{\"app\":\"hostname\"},\"sessionAffinity\":\"None\",\"type\":\"ClusterIP\"}}\n",
                    "moniker.spinnaker.io/application": "hostname",
                    "moniker.spinnaker.io/cluster": "service hostname-metrics"
                  },
                  "creationTimestamp": "2021-04-30T21:00:08Z",
                  "labels": {
                    "app": "hostname",
                    "app.kubernetes.io/managed-by": "spinnaker",
                    "app.kubernetes.io/name": "hostname"
                  },
                  "managedFields": [
                    {
                      "apiVersion": "v1",
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
                            "f:app": {},
                            "f:app.kubernetes.io/managed-by": {},
                            "f:app.kubernetes.io/name": {}
                          }
                        },
                        "f:spec": {
                          "f:ports": {
                            ".": {},
                            "k:{\"port\":9113,\"protocol\":\"TCP\"}": {
                              ".": {},
                              "f:name": {},
                              "f:port": {},
                              "f:protocol": {},
                              "f:targetPort": {}
                            }
                          },
                          "f:selector": {
                            ".": {},
                            "f:app": {}
                          },
                          "f:sessionAffinity": {},
                          "f:type": {}
                        }
                      },
                      "manager": "kubectl",
                      "operation": "Update",
                      "time": "2021-04-30T21:00:08Z"
                    }
                  ],
                  "name": "hostname-metrics",
                  "namespace": "staging",
                  "resourceVersion": "22460213",
                  "selfLink": "/api/v1/namespaces/staging/services/hostname-metrics",
                  "uid": "e691cbe4-652a-4ada-aba2-114887f0d8ee"
                },
                "spec": {
                  "clusterIP": "10.100.35.221",
                  "ports": [
                    {
                      "name": "metrics",
                      "port": 9113,
                      "protocol": "TCP",
                      "targetPort": 9113
                    }
                  ],
                  "selector": {
                    "app": "hostname"
                  },
                  "sessionAffinity": "None",
                  "type": "ClusterIP"
                },
                "status": {
                  "loadBalancer": {}
                }
              },
              {
                "apiVersion": "v1",
                "kind": "Service",
                "metadata": {
                  "annotations": {
                    "artifact.spinnaker.io/location": "staging",
                    "artifact.spinnaker.io/name": "hostname",
                    "artifact.spinnaker.io/type": "kubernetes/service",
                    "artifact.spinnaker.io/version": "",
                    "kubectl.kubernetes.io/last-applied-configuration": "{\"apiVersion\":\"v1\",\"kind\":\"Service\",\"metadata\":{\"annotations\":{\"artifact.spinnaker.io/location\":\"staging\",\"artifact.spinnaker.io/name\":\"hostname\",\"artifact.spinnaker.io/type\":\"kubernetes/service\",\"artifact.spinnaker.io/version\":\"\",\"moniker.spinnaker.io/application\":\"hostname\",\"moniker.spinnaker.io/cluster\":\"service hostname\"},\"labels\":{\"app\":\"hostname\",\"app.kubernetes.io/managed-by\":\"spinnaker\",\"app.kubernetes.io/name\":\"hostname\"},\"name\":\"hostname\",\"namespace\":\"staging\"},\"spec\":{\"ports\":[{\"port\":80,\"protocol\":\"TCP\",\"targetPort\":80}],\"selector\":{\"app\":\"hostname\"},\"sessionAffinity\":\"None\",\"type\":\"LoadBalancer\"}}\n",
                    "moniker.spinnaker.io/application": "hostname",
                    "moniker.spinnaker.io/cluster": "service hostname"
                  },
                  "creationTimestamp": "2021-02-11T04:00:54Z",
                  "finalizers": [
                    "service.kubernetes.io/load-balancer-cleanup"
                  ],
                  "labels": {
                    "app": "hostname",
                    "app.kubernetes.io/managed-by": "spinnaker",
                    "app.kubernetes.io/name": "hostname"
                  },
                  "managedFields": [
                    {
                      "apiVersion": "v1",
                      "fieldsType": "FieldsV1",
                      "fieldsV1": {
                        "f:metadata": {
                          "f:finalizers": {
                            ".": {},
                            "v:\"service.kubernetes.io/load-balancer-cleanup\"": {}
                          }
                        },
                        "f:status": {
                          "f:loadBalancer": {
                            "f:ingress": {}
                          }
                        }
                      },
                      "manager": "kube-controller-manager",
                      "operation": "Update",
                      "time": "2021-02-11T04:00:55Z"
                    },
                    {
                      "apiVersion": "v1",
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
                            "f:app": {},
                            "f:app.kubernetes.io/managed-by": {},
                            "f:app.kubernetes.io/name": {}
                          }
                        },
                        "f:spec": {
                          "f:externalTrafficPolicy": {},
                          "f:ports": {
                            ".": {},
                            "k:{\"port\":80,\"protocol\":\"TCP\"}": {
                              ".": {},
                              "f:port": {},
                              "f:protocol": {},
                              "f:targetPort": {}
                            }
                          },
                          "f:selector": {
                            ".": {},
                            "f:app": {}
                          },
                          "f:sessionAffinity": {},
                          "f:type": {}
                        }
                      },
                      "manager": "kubectl",
                      "operation": "Update",
                      "time": "2021-05-11T19:42:09Z"
                    }
                  ],
                  "name": "hostname",
                  "namespace": "staging",
                  "resourceVersion": "25295962",
                  "selfLink": "/api/v1/namespaces/staging/services/hostname",
                  "uid": "531793b5-68db-46df-b6ed-59101472a1b3"
                },
                "spec": {
                  "clusterIP": "10.100.186.60",
                  "externalTrafficPolicy": "Cluster",
                  "ports": [
                    {
                      "nodePort": 31334,
                      "port": 80,
                      "protocol": "TCP",
                      "targetPort": 80
                    }
                  ],
                  "selector": {
                    "app": "hostname"
                  },
                  "sessionAffinity": "None",
                  "type": "LoadBalancer"
                },
                "status": {
                  "loadBalancer": {
                    "ingress": [
                      {
                        "hostname": "a531793b568db46dfb6ed59101472a1b-996363535.us-east-2.elb.amazonaws.com"
                      }
                    ]
                  }
                }
              }
            ],
            "requiredArtifacts": []
          },
          "parentStageId": null,
          "refId": "3",
          "requisiteStageRefIds": [],
          "scheduledTime": null,
          "startTime": 1620762127654,
          "startTimeExpiry": null,
          "status": "SUCCEEDED",
          "syntheticStageOwner": null,
          "tasks": [
            {
              "endTime": 1620762128288,
              "id": "1",
              "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.manifest.ResolveDeploySourceManifestTask",
              "loopEnd": false,
              "loopStart": false,
              "name": "resolveDeploySourceManifest",
              "stageEnd": false,
              "stageStart": true,
              "startTime": 1620762127682,
              "status": "SUCCEEDED"
            },
            {
              "endTime": 1620762128767,
              "id": "2",
              "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.manifest.DeployManifestTask",
              "loopEnd": false,
              "loopStart": false,
              "name": "deployManifest",
              "stageEnd": false,
              "stageStart": false,
              "startTime": 1620762128348,
              "status": "SUCCEEDED"
            },
            {
              "endTime": 1620762134098,
              "id": "3",
              "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.MonitorKatoTask",
              "loopEnd": false,
              "loopStart": false,
              "name": "monitorDeploy",
              "stageEnd": false,
              "stageStart": false,
              "startTime": 1620762128792,
              "status": "SUCCEEDED"
            },
            {
              "endTime": 1620762134304,
              "id": "4",
              "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.manifest.PromoteManifestKatoOutputsTask",
              "loopEnd": false,
              "loopStart": false,
              "name": "promoteOutputs",
              "stageEnd": false,
              "stageStart": false,
              "startTime": 1620762134146,
              "status": "SUCCEEDED"
            },
            {
              "endTime": 1620762135138,
              "id": "5",
              "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.manifest.WaitForManifestStableTask",
              "loopEnd": false,
              "loopStart": false,
              "name": "waitForManifestToStabilize",
              "stageEnd": false,
              "stageStart": false,
              "startTime": 1620762134324,
              "status": "SUCCEEDED"
            },
            {
              "endTime": 1620762135560,
              "id": "6",
              "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.artifacts.CleanupArtifactsTask",
              "loopEnd": false,
              "loopStart": false,
              "name": "cleanupArtifacts",
              "stageEnd": false,
              "stageStart": false,
              "startTime": 1620762135210,
              "status": "SUCCEEDED"
            },
            {
              "endTime": 1620762135801,
              "id": "7",
              "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.MonitorKatoTask",
              "loopEnd": false,
              "loopStart": false,
              "name": "monitorCleanup",
              "stageEnd": false,
              "stageStart": false,
              "startTime": 1620762135632,
              "status": "SUCCEEDED"
            },
            {
              "endTime": 1620762136028,
              "id": "8",
              "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.manifest.PromoteManifestKatoOutputsTask",
              "loopEnd": false,
              "loopStart": false,
              "name": "promoteOutputs",
              "stageEnd": false,
              "stageStart": false,
              "startTime": 1620762135865,
              "status": "SUCCEEDED"
            },
            {
              "endTime": 1620762136298,
              "id": "9",
              "implementingClass": "com.netflix.spinnaker.orca.pipeline.tasks.artifacts.BindProducedArtifactsTask",
              "loopEnd": false,
              "loopStart": false,
              "name": "bindProducedArtifacts",
              "stageEnd": true,
              "stageStart": false,
              "startTime": 1620762136092,
              "status": "SUCCEEDED"
            }
          ],
          "type": "deployManifest"
        },
        "01F5EF6V5C94PAJ0JPEDAGV18W",
        {
          "context": {
            "account": "spinnaker",
            "app": "hostname",
            "cloudProvider": "kubernetes",
            "location": "staging",
            "manifestName": "deployment hostname",
            "mode": "static",
            "replicas": "10"
          },
          "endTime": null,
          "id": "01F5EF6V5CV4YFZZ2GDQ5CQ5NN",
          "lastModified": null,
          "name": "Scale (Manifest)",
          "outputs": {},
          "parentStageId": null,
          "refId": "5",
          "requisiteStageRefIds": [
            "4"
          ],
          "scheduledTime": null,
          "startTime": null,
          "startTimeExpiry": null,
          "status": "NOT_STARTED",
          "syntheticStageOwner": null,
          "tasks": [],
          "type": "scaleManifest"
        }
      ],
      "startTime": 1620762127602,
      "startTimeExpiry": null,
      "status": "RUNNING",
      "systemNotifications": [],
      "templateVariables": null,
      "trigger": {
        "artifacts": [
          {
            "artifactAccount": "myUserName",
            "customKind": false,
            "location": null,
            "metadata": {
              "id": "4aa85178-0618-46c4-b530-6883d393656d"
            },
            "name": "manifests/deploy-spinnaker.yaml",
            "provenance": null,
            "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
            "type": "github/file",
            "uuid": null,
            "version": "master"
          },
          {
            "artifactAccount": "myUserName",
            "customKind": false,
            "location": null,
            "metadata": {
              "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
            },
            "name": "manifests/service-spinnaker.yaml",
            "provenance": null,
            "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/service-spinnaker.yaml",
            "type": "github/file",
            "uuid": null,
            "version": null
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
                "id": "4aa85178-0618-46c4-b530-6883d393656d"
              },
              "name": "manifests/deploy-spinnaker.yaml",
              "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
              "type": "github/file",
              "version": "master"
            },
            {
              "artifactAccount": "myUserName",
              "customKind": false,
              "metadata": {
                "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
              },
              "name": "manifests/service-spinnaker.yaml",
              "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/service-spinnaker.yaml",
              "type": "github/file"
            }
          ],
          "dryRun": false,
          "enabled": false,
          "eventId": "ce0c7aa0-7c0e-463e-9074-84a1270a0e78",
          "executionId": "01F5EF6V1CTYQBD3HBNZXG0CTJ",
          "expectedArtifacts": [
            {
              "boundArtifact": {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "4aa85178-0618-46c4-b530-6883d393656d"
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
                  "id": "4aa85178-0618-46c4-b530-6883d393656d"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
                "type": "github/file",
                "version": "master"
              },
              "id": "0cf98032-1b0f-48db-9314-09c69293b3a6",
              "matchArtifact": {
                "artifactAccount": "myUserName",
                "customKind": true,
                "metadata": {
                  "id": "3f72ed8e-cb95-454f-9119-2323682121ff"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "type": "github/file"
              },
              "useDefaultArtifact": true,
              "usePriorArtifact": false
            },
            {
              "boundArtifact": {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
                },
                "name": "manifests/service-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/service-spinnaker.yaml",
                "type": "github/file"
              },
              "defaultArtifact": {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
                },
                "name": "manifests/service-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/service-spinnaker.yaml",
                "type": "github/file"
              },
              "id": "425d20a8-2942-4902-8d2b-277769a1492c",
              "matchArtifact": {
                "artifactAccount": "myUserName",
                "customKind": true,
                "metadata": {
                  "id": "d7ac7eca-0131-4d54-ab8f-880ff0041e4f"
                },
                "name": "manifests/service-spinnaker",
                "type": "github/file"
              },
              "useDefaultArtifact": true,
              "usePriorArtifact": false
            }
          ],
          "notifications": [],
          "parameters": {
            "namespace": "staging",
            "replicas": "2"
          },
          "preferred": false,
          "rebake": false,
          "resolvedExpectedArtifacts": [
            {
              "boundArtifact": {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "4aa85178-0618-46c4-b530-6883d393656d"
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
                  "id": "4aa85178-0618-46c4-b530-6883d393656d"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
                "type": "github/file",
                "version": "master"
              },
              "id": "0cf98032-1b0f-48db-9314-09c69293b3a6",
              "matchArtifact": {
                "artifactAccount": "myUserName",
                "customKind": true,
                "metadata": {
                  "id": "3f72ed8e-cb95-454f-9119-2323682121ff"
                },
                "name": "manifests/deploy-spinnaker.yaml",
                "type": "github/file"
              },
              "useDefaultArtifact": true,
              "usePriorArtifact": false
            },
            {
              "boundArtifact": {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
                },
                "name": "manifests/service-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/service-spinnaker.yaml",
                "type": "github/file"
              },
              "defaultArtifact": {
                "artifactAccount": "myUserName",
                "customKind": false,
                "metadata": {
                  "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
                },
                "name": "manifests/service-spinnaker.yaml",
                "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/service-spinnaker.yaml",
                "type": "github/file"
              },
              "id": "425d20a8-2942-4902-8d2b-277769a1492c",
              "matchArtifact": {
                "artifactAccount": "myUserName",
                "customKind": true,
                "metadata": {
                  "id": "d7ac7eca-0131-4d54-ab8f-880ff0041e4f"
                },
                "name": "manifests/service-spinnaker",
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
        "parameters": {
          "namespace": "staging",
          "replicas": "2"
        },
        "resolvedExpectedArtifacts": [
          {
            "boundArtifact": {
              "artifactAccount": "myUserName",
              "customKind": false,
              "location": null,
              "metadata": {
                "id": "4aa85178-0618-46c4-b530-6883d393656d"
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
                "id": "4aa85178-0618-46c4-b530-6883d393656d"
              },
              "name": "manifests/deploy-spinnaker.yaml",
              "provenance": null,
              "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/deploy-spinnaker.yaml",
              "type": "github/file",
              "uuid": null,
              "version": "master"
            },
            "id": "0cf98032-1b0f-48db-9314-09c69293b3a6",
            "matchArtifact": {
              "artifactAccount": "myUserName",
              "customKind": true,
              "location": null,
              "metadata": {
                "id": "3f72ed8e-cb95-454f-9119-2323682121ff"
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
          },
          {
            "boundArtifact": {
              "artifactAccount": "myUserName",
              "customKind": false,
              "location": null,
              "metadata": {
                "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
              },
              "name": "manifests/service-spinnaker.yaml",
              "provenance": null,
              "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/service-spinnaker.yaml",
              "type": "github/file",
              "uuid": null,
              "version": null
            },
            "defaultArtifact": {
              "artifactAccount": "myUserName",
              "customKind": false,
              "location": null,
              "metadata": {
                "id": "e79162ab-69cb-4ff7-acf4-a8f2875ef8ef"
              },
              "name": "manifests/service-spinnaker.yaml",
              "provenance": null,
              "reference": "Https://api.github.com/repos/myUserName/hostname/contents/manifests/service-spinnaker.yaml",
              "type": "github/file",
              "uuid": null,
              "version": null
            },
            "id": "425d20a8-2942-4902-8d2b-277769a1492c",
            "matchArtifact": {
              "artifactAccount": "myUserName",
              "customKind": true,
              "location": null,
              "metadata": {
                "id": "d7ac7eca-0131-4d54-ab8f-880ff0041e4f"
              },
              "name": "manifests/service-spinnaker",
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
        "completeOtherBranchesThenFail": false,
        "continuePipeline": true,
        "failPipeline": false,
        "instructions": "is the new service working?",
        "judgmentInputs": [],
        "judgmentStatus": "continue",
        "lastModifiedBy": "myUserName",
        "notifications": [],
        "stageTimeoutMs": 60000
      },
      "endTime": null,
      "id": "01F5EF6V5C94PAJ0JPEDAGV18W",
      "lastModified": {
        "allowedAccounts": [
          "spinnaker",
          "staging",
          "staging-ecs"
        ],
        "lastModifiedTime": 1620762143342,
        "user": "myUserName"
      },
      "name": "Manual Judgment",
      "outputs": {},
      "parentStageId": null,
      "refId": "4",
      "requisiteStageRefIds": [
        "2",
        "3"
      ],
      "scheduledTime": null,
      "startTime": 1620762136521,
      "startTimeExpiry": null,
      "status": "RUNNING",
      "syntheticStageOwner": null,
      "tasks": [
        {
          "endTime": null,
          "id": "1",
          "implementingClass": "com.netflix.spinnaker.orca.echo.pipeline.ManualJudgmentStage.WaitForManualJudgmentTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "waitForJudgment",
          "stageEnd": true,
          "stageStart": true,
          "startTime": 1620762136595,
          "status": "RUNNING"
        }
      ],
      "type": "manualJudgment"
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
| `input.pipeline.application` | `string`  | The name of the Spinnaker application to which this pipeline belongs. |
| `input.pipeline.authentication.allowedAccounts[]` | `string`  |             |
| `input.pipeline.authentication.user`              | `string`  |             |
| `input.pipeline.buildTime`                        | `number`  |             |
| `input.pipeline.canceled`                         | `boolean` |             |
| `input.pipeline.canceledBy`                       | ` `       |             |
| `input.pipeline.cancellationReason`               | ` `       |             |
| `input.pipeline.description`                      | ` `       |             |
| `input.pipeline.endTime`                          | ` `       |             |
| `input.pipeline.id`                               | `string`  |             |
| `input.pipeline.keepWaitingPipelines`             | `boolean` |             |
| `input.stage.lastModified`                        | ` `       |             |
| `input.pipeline.limitConcurrent`                  | `boolean` |             |
| `input.pipeline.name`                             | `string`  |             |
| `input.pipeline.origin`                           | `string`  |             |
| `input.pipeline.partition`                        | ` `       |             |
| `input.pipeline.paused`                           | ` `       |             |
| `input.pipeline.pipelineConfigId`                 | `string`  |             |
| `input.pipeline.source`                           | ` `       |             |
| `input.pipeline.spelEvaluator`                    | `string`  |             |
| `input.pipeline.startTime`                        | `number`  |             |
| `input.pipeline.startTimeExpiry`                  | ` `       |             |
| `input.pipeline.status`                           | `string`  |             |
| `input.pipeline.templateVariables`                | ` `       |             |

### `input.pipeline.stages`

| Key                                                                                                                                              | Type      | Description |
| ------------------------------------------------------------------------------------------------------------------------------------------------ | --------- | ----------- |
| `input.pipeline.stages[]`                                                                                                                        | `string`  |             |
| `input.pipeline.stages[].context.account`                                                                                                        | `string`  |             |
| `input.pipeline.stages[].context.action`                                                                                                         | `string`  |             |
| `input.pipeline.stages[].context.app`                                                                                                            | `string`  |             |
| `input.pipeline.stages[].context.artifactContents[].contents`                                                                                    | `string`  |             |
| `input.pipeline.stages[].context.artifactContents[].name`                                                                                        | `string`  |             |
| `input.pipeline.stages[].context.artifacts[].account`                                                                                            | `string`  |             |
| `input.pipeline.stages[].context.artifacts[].customKind`                                                                                         | `boolean` |             |
| `input.pipeline.stages[].context.artifacts[].id`                                                                                                 | `string`  |             |
| `input.pipeline.stages[].context.artifacts[].location`                                                                                           | `string`  |             |
| `input.pipeline.stages[].context.artifacts[].metadata.account`                                                                                   | `string`  |             |
| `input.pipeline.stages[].context.artifacts[].name`                                                                                               | `string`  |             |
| `input.pipeline.stages[].context.artifacts[].reference`                                                                                          | `string`  |             |
| `input.pipeline.stages[].context.artifacts[].type`                                                                                               | `string`  |             |
| `input.pipeline.stages[].context.artifacts[].version`                                                                                            | `string`  |             |
| `input.pipeline.stages[].context.cloudProvider`                                                                                                  | `string`  |             |
| `input.pipeline.stages[].context.deploy.account.name`                                                                                            | `string`  |             |
| `input.pipeline.stages[].context.expectedArtifacts[].defaultArtifact.customKind`                                                                 | `boolean` |             |
| `input.pipeline.stages[].context.expectedArtifacts[].defaultArtifact.id`                                                                         | `string`  |             |
| `input.pipeline.stages[].context.expectedArtifacts[].defaultArtifact.metadata.id`                                                                | `string`  |             |
| `input.pipeline.stages[].context.expectedArtifacts[].displayName`                                                                                | `string`  |             |
| `input.pipeline.stages[].context.expectedArtifacts[].id`                                                                                         | `string`  |             |
| `input.pipeline.stages[].context.expectedArtifacts[].matchArtifact.artifactAccount`                                                              | `string`  |             |
| `input.pipeline.stages[].context.expectedArtifacts[].matchArtifact.customKind`                                                                   | `boolean` |             |
| `input.pipeline.stages[].context.expectedArtifacts[].matchArtifact.id`                                                                           | `string`  |             |
| `input.pipeline.stages[].context.expectedArtifacts[].matchArtifact.metadata.id`                                                                  | `string`  |             |
| `input.pipeline.stages[].context.expectedArtifacts[].matchArtifact.name`                                                                         | `string`  |             |
| `input.pipeline.stages[].context.expectedArtifacts[].matchArtifact.type`                                                                         | `string`  |             |
| `input.pipeline.stages[].context.expectedArtifacts[].useDefaultArtifact`                                                                         | `boolean` |             |
| `input.pipeline.stages[].context.expectedArtifacts[].usePriorArtifact`                                                                           | `boolean` |             |
| `input.pipeline.stages[].context.kato.last.task.id.id`                                                                                           | `string`  |             |
| `input.pipeline.stages[].context.kato.result.expected`                                                                                           | `boolean` |             |
| `input.pipeline.stages[].context.kato.task.firstNotFoundRetry`                                                                                   | `number`  |             |
| `input.pipeline.stages[].context.kato.task.lastStatus`                                                                                           | `string`  |             |
| `input.pipeline.stages[].context.kato.task.notFoundRetryCount`                                                                                   | `number`  |             |
| `input.pipeline.stages[].context.kato.task.terminalRetryCount`                                                                                   | `number`  |             |
| `input.pipeline.stages[].context.kato.tasks[].history[].phase`                                                                                   | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].history[].status`                                                                                  | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].id`                                                                                                | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].boundArtifacts[].customKind`                                                       | `boolean` |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].boundArtifacts[].location`                                                         | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].boundArtifacts[].metadata.account`                                                 | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].boundArtifacts[].name`                                                             | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].boundArtifacts[].reference`                                                        | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].boundArtifacts[].type`                                                             | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].boundArtifacts[].version`                                                          | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].createdArtifacts[].customKind`                                                     | `boolean` |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].createdArtifacts[].location`                                                       | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].createdArtifacts[].metadata.account`                                               | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].createdArtifacts[].name`                                                           | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].createdArtifacts[].reference`                                                      | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].createdArtifacts[].type`                                                           | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].createdArtifacts[].version`                                                        | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifestNamesByNamespace.[]`                                                       | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifestNamesByNamespace.staging[]`                                                | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].apiVersion`                                                            | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].data.nginx.status.conf`                                                | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].kind`                                                                  | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].metadata.annotations.artifact.spinnaker.io/location`                   | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].metadata.annotations.artifact.spinnaker.io/name`                       | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].metadata.annotations.artifact.spinnaker.io/type`                       | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].metadata.annotations.artifact.spinnaker.io/version`                    | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].metadata.annotations.deployment.kubernetes.io/revision`                | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].metadata.annotations.kubectl.kubernetes.io/last-applied-configuration` | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].metadata.annotations.moniker.spinnaker.io/application`                 | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].metadata.annotations.moniker.spinnaker.io/cluster`                     | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].metadata.annotations.moniker.spinnaker.io/sequence`                    | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].metadata.creationTimestamp`                                            | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].metadata.finalizers[]`                                                 | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].metadata.generation`                                                   | `number`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].metadata.labels.app.kubernetes.io/managed-by`                          | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].metadata.labels.app.kubernetes.io/name`                                | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].metadata.labels.app`                                                   | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].metadata.labels.moniker.spinnaker.io/sequence`                         | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].metadata.managedFields[].apiVersion`                                   | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].metadata.managedFields[].fieldsType`                                   | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].metadata.managedFields[].manager`                                      | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].metadata.managedFields[].operation`                                    | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].metadata.managedFields[].time`                                         | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].metadata.name`                                                         | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].metadata.namespace`                                                    | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].metadata.resourceVersion`                                              | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].metadata.selfLink`                                                     | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].metadata.uid`                                                          | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.clusterIP`                                                        | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.externalTrafficPolicy`                                            | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.finalizers[]`                                                     | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.ports[].name`                                                     | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.ports[].nodePort`                                                 | `number`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.ports[].port`                                                     | `number`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.ports[].protocol`                                                 | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.ports[].targetPort`                                               | `number`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.progressDeadlineSeconds`                                          | `number`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.replicas`                                                         | `number`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.revisionHistoryLimit`                                             | `number`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.selector.app`                                                     | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.selector.matchLabels.app`                                         | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.selector.matchLabels.version`                                     | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.sessionAffinity`                                                  | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.strategy.rollingUpdate.maxSurge`                                  | `number`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.strategy.rollingUpdate.maxUnavailable`                            | `number`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.strategy.type`                                                    | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/location`     | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/name`         | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/type`         | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/version`      | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.metadata.annotations.moniker.spinnaker.io/application`   | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.metadata.annotations.moniker.spinnaker.io/cluster`       | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.metadata.annotations.prometheus.io/port`                 | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.metadata.annotations.prometheus.io/scrape`               | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.metadata.labels.app.kubernetes.io/managed-by`            | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.metadata.labels.app.kubernetes.io/name`                  | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.metadata.labels.app`                                     | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.metadata.labels.version`                                 | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.containers[].args[]`                                | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.containers[].imagePullPolicy`                       | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.containers[].image`                                 | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.containers[].name`                                  | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.containers[].ports[].containerPort`                 | `number`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.containers[].ports[].name`                          | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.containers[].ports[].protocol`                      | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.containers[].terminationMessagePath`                | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.containers[].terminationMessagePolicy`              | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.containers[].volumeMounts[].mountPath`              | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.containers[].volumeMounts[].name`                   | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.containers[].volumeMounts[].readOnly`               | `boolean` |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.containers[].volumeMounts[].subPath`                | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.dnsPolicy`                                          | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.restartPolicy`                                      | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.schedulerName`                                      | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.terminationGracePeriodSeconds`                      | `number`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.volumes[].configMap.defaultMode`                    | `number`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.volumes[].configMap.name`                           | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.volumes[].name`                                     | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].spec.type`                                                             | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].status.availableReplicas`                                              | `number`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].status.conditions[].lastTransitionTime`                                | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].status.conditions[].lastUpdateTime`                                    | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].status.conditions[].message`                                           | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].status.conditions[].reason`                                            | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].status.conditions[].status`                                            | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].status.conditions[].type`                                              | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].status.loadBalancer.ingress[].hostname`                                | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].status.observedGeneration`                                             | `number`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].status.phase`                                                          | `string`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].status.readyReplicas`                                                  | `number`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].status.replicas`                                                       | `number`  |             |
| `input.pipeline.stages[].context.kato.tasks[].resultObjects[].manifests[].status.updatedReplicas`                                                | `number`  |             |
| `input.pipeline.stages[].context.kato.tasks[].status.completed`                                                                                  | `boolean` |             |
| `input.pipeline.stages[].context.kato.tasks[].status.failed`                                                                                     | `boolean` |             |
| `input.pipeline.stages[].context.kato.tasks[].status.retryable`                                                                                  | `boolean` |             |
| `input.pipeline.stages[].context.location`                                                                                                       | `string`  |             |
| `input.pipeline.stages[].context.manifestArtifactId`                                                                                             | `string`  |             |
| `input.pipeline.stages[].context.manifestName`                                                                                                   | `string`  |             |
| `input.pipeline.stages[].context.manifests[].apiVersion`                                                                                         | `string`  |             |
| `input.pipeline.stages[].context.manifests[].data.nginx.status.conf`                                                                             | `string`  |             |
| `input.pipeline.stages[].context.manifests[].kind`                                                                                               | `string`  |             |
| `input.pipeline.stages[].context.manifests[].metadata.labels.app`                                                                                | `string`  |             |
| `input.pipeline.stages[].context.manifests[].metadata.name`                                                                                      | `string`  |             |
| `input.pipeline.stages[].context.manifests[].metadata.namespace`                                                                                 | `string`  |             |
| `input.pipeline.stages[].context.manifests[].spec.finalizers[]`                                                                                  | `string`  |             |
| `input.pipeline.stages[].context.manifests[].spec.ports[].name`                                                                                  | `string`  |             |
| `input.pipeline.stages[].context.manifests[].spec.ports[].port`                                                                                  | `number`  |             |
| `input.pipeline.stages[].context.manifests[].spec.ports[].protocol`                                                                              | `string`  |             |
| `input.pipeline.stages[].context.manifests[].spec.ports[].targetPort`                                                                            | `number`  |             |
| `input.pipeline.stages[].context.manifests[].spec.replicas`                                                                                      | `number`  |             |
| `input.pipeline.stages[].context.manifests[].spec.selector.app`                                                                                  | `string`  |             |
| `input.pipeline.stages[].context.manifests[].spec.selector.matchLabels.app`                                                                      | `string`  |             |
| `input.pipeline.stages[].context.manifests[].spec.selector.matchLabels.version`                                                                  | `string`  |             |
| `input.pipeline.stages[].context.manifests[].spec.sessionAffinity`                                                                               | `string`  |             |
| `input.pipeline.stages[].context.manifests[].spec.strategy.rollingUpdate.maxSurge`                                                               | `number`  |             |
| `input.pipeline.stages[].context.manifests[].spec.strategy.rollingUpdate.maxUnavailable`                                                         | `number`  |             |
| `input.pipeline.stages[].context.manifests[].spec.strategy.type`                                                                                 | `string`  |             |
| `input.pipeline.stages[].context.manifests[].spec.template.metadata.annotations.prometheus.io/port`                                              | `string`  |             |
| `input.pipeline.stages[].context.manifests[].spec.template.metadata.annotations.prometheus.io/scrape`                                            | `string`  |             |
| `input.pipeline.stages[].context.manifests[].spec.template.metadata.labels.app`                                                                  | `string`  |             |
| `input.pipeline.stages[].context.manifests[].spec.template.metadata.labels.version`                                                              | `string`  |             |
| `input.pipeline.stages[].context.manifests[].spec.template.spec.containers[].args[]`                                                             | `string`  |             |
| `input.pipeline.stages[].context.manifests[].spec.template.spec.containers[].imagePullPolicy`                                                    | `string`  |             |
| `input.pipeline.stages[].context.manifests[].spec.template.spec.containers[].image`                                                              | `string`  |             |
| `input.pipeline.stages[].context.manifests[].spec.template.spec.containers[].name`                                                               | `string`  |             |
| `input.pipeline.stages[].context.manifests[].spec.template.spec.containers[].ports[].containerPort`                                              | `number`  |             |
| `input.pipeline.stages[].context.manifests[].spec.template.spec.containers[].ports[].name`                                                       | `string`  |             |
| `input.pipeline.stages[].context.manifests[].spec.template.spec.containers[].ports[].protocol`                                                   | `string`  |             |
| `input.pipeline.stages[].context.manifests[].spec.template.spec.containers[].volumeMounts[].mountPath`                                           | `string`  |             |
| `input.pipeline.stages[].context.manifests[].spec.template.spec.containers[].volumeMounts[].name`                                                | `string`  |             |
| `input.pipeline.stages[].context.manifests[].spec.template.spec.containers[].volumeMounts[].readOnly`                                            | `boolean` |             |
| `input.pipeline.stages[].context.manifests[].spec.template.spec.containers[].volumeMounts[].subPath`                                             | `string`  |             |
| `input.pipeline.stages[].context.manifests[].spec.template.spec.restartPolicy`                                                                   | `string`  |             |
| `input.pipeline.stages[].context.manifests[].spec.template.spec.volumes[].configMap.defaultMode`                                                 | `number`  |             |
| `input.pipeline.stages[].context.manifests[].spec.template.spec.volumes[].configMap.name`                                                        | `string`  |             |
| `input.pipeline.stages[].context.manifests[].spec.template.spec.volumes[].name`                                                                  | `string`  |             |
| `input.pipeline.stages[].context.manifests[].spec.type`                                                                                          | `string`  |             |
| `input.pipeline.stages[].context.mode`                                                                                                           | `string`  |             |
| `input.pipeline.stages[].context.moniker.app`                                                                                                    | `string`  |             |
| `input.pipeline.stages[].context.optionalArtifacts[].artifactAccount`                                                                            | `string`  |             |
| `input.pipeline.stages[].context.optionalArtifacts[].customKind`                                                                                 | `boolean` |             |
| `input.pipeline.stages[].context.optionalArtifacts[].metadata.id`                                                                                | `string`  |             |
| `input.pipeline.stages[].context.optionalArtifacts[].name`                                                                                       | `string`  |             |
| `input.pipeline.stages[].context.optionalArtifacts[].reference`                                                                                  | `string`  |             |
| `input.pipeline.stages[].context.optionalArtifacts[].type`                                                                                       | `string`  |             |
| `input.pipeline.stages[].context.optionalArtifacts[].version`                                                                                    | `string`  |             |
| `input.pipeline.stages[].context.outputs.boundArtifacts[].customKind`                                                                            | `boolean` |             |
| `input.pipeline.stages[].context.outputs.boundArtifacts[].location`                                                                              | `string`  |             |
| `input.pipeline.stages[].context.outputs.boundArtifacts[].metadata.account`                                                                      | `string`  |             |
| `input.pipeline.stages[].context.outputs.boundArtifacts[].name`                                                                                  | `string`  |             |
| `input.pipeline.stages[].context.outputs.boundArtifacts[].reference`                                                                             | `string`  |             |
| `input.pipeline.stages[].context.outputs.boundArtifacts[].type`                                                                                  | `string`  |             |
| `input.pipeline.stages[].context.outputs.boundArtifacts[].version`                                                                               | `string`  |             |
| `input.pipeline.stages[].context.outputs.createdArtifacts[].customKind`                                                                          | `boolean` |             |
| `input.pipeline.stages[].context.outputs.createdArtifacts[].location`                                                                            | `string`  |             |
| `input.pipeline.stages[].context.outputs.createdArtifacts[].metadata.account`                                                                    | `string`  |             |
| `input.pipeline.stages[].context.outputs.createdArtifacts[].name`                                                                                | `string`  |             |
| `input.pipeline.stages[].context.outputs.createdArtifacts[].reference`                                                                           | `string`  |             |
| `input.pipeline.stages[].context.outputs.createdArtifacts[].type`                                                                                | `string`  |             |
| `input.pipeline.stages[].context.outputs.createdArtifacts[].version`                                                                             | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifestNamesByNamespace.[]`                                                                            | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifestNamesByNamespace.staging[]`                                                                     | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].apiVersion`                                                                                 | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].data.nginx.status.conf`                                                                     | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].kind`                                                                                       | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].metadata.annotations.artifact.spinnaker.io/location`                                        | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].metadata.annotations.artifact.spinnaker.io/name`                                            | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].metadata.annotations.artifact.spinnaker.io/type`                                            | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].metadata.annotations.artifact.spinnaker.io/version`                                         | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].metadata.annotations.deployment.kubernetes.io/revision`                                     | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].metadata.annotations.kubectl.kubernetes.io/last-applied-configuration`                      | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].metadata.annotations.moniker.spinnaker.io/application`                                      | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].metadata.annotations.moniker.spinnaker.io/cluster`                                          | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].metadata.annotations.moniker.spinnaker.io/sequence`                                         | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].metadata.creationTimestamp`                                                                 | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].metadata.finalizers[]`                                                                      | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].metadata.generation`                                                                        | `number`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].metadata.labels.app.kubernetes.io/managed-by`                                               | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].metadata.labels.app.kubernetes.io/name`                                                     | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].metadata.labels.app`                                                                        | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].metadata.labels.moniker.spinnaker.io/sequence`                                              | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].metadata.managedFields[].apiVersion`                                                        | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].metadata.managedFields[].fieldsType`                                                        | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].metadata.managedFields[].manager`                                                           | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].metadata.managedFields[].operation`                                                         | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].metadata.managedFields[].time`                                                              | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].metadata.name`                                                                              | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].metadata.namespace`                                                                         | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].metadata.resourceVersion`                                                                   | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].metadata.selfLink`                                                                          | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].metadata.uid`                                                                               | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.clusterIP`                                                                             | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.externalTrafficPolicy`                                                                 | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.finalizers[]`                                                                          | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.ports[].name`                                                                          | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.ports[].nodePort`                                                                      | `number`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.ports[].port`                                                                          | `number`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.ports[].protocol`                                                                      | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.ports[].targetPort`                                                                    | `number`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.progressDeadlineSeconds`                                                               | `number`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.replicas`                                                                              | `number`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.revisionHistoryLimit`                                                                  | `number`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.selector.app`                                                                          | `string`  |             |
| `input.pipeline.stages[].context.planForDestroy`                                                                                                 | `boolean` |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].boundArtifact.customKind`                                                           | `boolean` |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].boundArtifact.name`                                                                 | `string`  |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].boundArtifact.reference`                                                            | `string`  |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].boundArtifact.type`                                                                 | `string`  |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].defaultArtifact.customKind`                                                         | `boolean` |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].defaultArtifact.metadata.id`                                                        | `string`  |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].id`                                                                                 | `string`  |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].matchArtifact.artifactAccount`                                                      | `string`  |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].matchArtifact.customKind`                                                           | `boolean` |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].matchArtifact.metadata.id`                                                          | `string`  |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].matchArtifact.name`                                                                 | `string`  |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].matchArtifact.type`                                                                 | `string`  |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].useDefaultArtifact`                                                                 | `boolean` |             |
| `input.pipeline.stages[].context.resolvedExpectedArtifacts[].usePriorArtifact`                                                                   | `boolean` |             |
| `input.pipeline.stages[].context.terraformVersion`                                                                                               | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.selector.matchLabels.app`                                                              | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.selector.matchLabels.version`                                                          | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.sessionAffinity`                                                                       | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.strategy.rollingUpdate.maxSurge`                                                       | `number`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.strategy.rollingUpdate.maxUnavailable`                                                 | `number`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.strategy.type`                                                                         | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/location`                          | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/name`                              | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/type`                              | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/version`                           | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.metadata.annotations.moniker.spinnaker.io/application`                        | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.metadata.annotations.moniker.spinnaker.io/cluster`                            | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.metadata.annotations.prometheus.io/port`                                      | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.metadata.annotations.prometheus.io/scrape`                                    | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.metadata.labels.app`                                                          | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.metadata.labels.app.kubernetes.io/managed-by`                                 | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.metadata.labels.app.kubernetes.io/name`                                       | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.metadata.labels.version`                                                      | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.spec.containers[].args[]`                                                     | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.spec.containers[].image`                                                      | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.spec.containers[].imagePullPolicy`                                            | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.spec.containers[].name`                                                       | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.spec.containers[].ports[].containerPort`                                      | `number`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.spec.containers[].ports[].name`                                               | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.spec.containers[].ports[].protocol`                                           | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.spec.containers[].terminationMessagePath`                                     | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.spec.containers[].terminationMessagePolicy`                                   | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.spec.containers[].volumeMounts[].mountPath`                                   | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.spec.containers[].volumeMounts[].name`                                        | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.spec.containers[].volumeMounts[].readOnly`                                    | `boolean` |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.spec.containers[].volumeMounts[].subPath`                                     | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.spec.dnsPolicy`                                                               | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.spec.restartPolicy`                                                           | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.spec.schedulerName`                                                           | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.spec.terminationGracePeriodSeconds`                                           | `number`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.spec.volumes[].configMap.defaultMode`                                         | `number`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.spec.volumes[].configMap.name`                                                | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.template.spec.volumes[].name`                                                          | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].spec.type`                                                                                  | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].status.availableReplicas`                                                                   | `number`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].status.conditions[].lastTransitionTime`                                                     | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].status.conditions[].lastUpdateTime`                                                         | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].status.conditions[].message`                                                                | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].status.conditions[].reason`                                                                 | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].status.conditions[].status`                                                                 | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].status.conditions[].type`                                                                   | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].status.loadBalancer.ingress[].hostname`                                                     | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].status.observedGeneration`                                                                  | `number`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].status.phase`                                                                               | `string`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].status.readyReplicas`                                                                       | `number`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].status.replicas`                                                                            | `number`  |             |
| `input.pipeline.stages[].context.outputs.manifests[].status.updatedReplicas`                                                                     | `number`  |             |
| `input.pipeline.stages[].context.replicas`                                                                                                       | `string`  |             |
| `input.pipeline.stages[].context.skipExpressionEvaluation`                                                                                       | `boolean` |             |
| `input.pipeline.stages[].context.source`                                                                                                         | `string`  |             |
| `input.pipeline.stages[].context.stableManifests[].location`                                                                                     | `string`  |             |
| `input.pipeline.stages[].context.stableManifests[].manifestName`                                                                                 | `string`  |             |
| `input.pipeline.stages[].context.trafficManagement.enabled`                                                                                      | `boolean` |             |
| `input.pipeline.stages[].context.trafficManagement.options.enableTraffic`                                                                        | `boolean` |             |
| `input.pipeline.stages[].endTime`                                                                                                                | `number`  |             |
| `input.pipeline.stages[].endTime`                                                                                                                | ` `       |             |
| `input.pipeline.stages[].id`                                                                                                                     | `string`  |             |
| `input.pipeline.stages[].lastModified`                                                                                                           | ` `       |             |
| `input.pipeline.stages[].name`                                                                                                                   | `string`  |             |
| `input.pipeline.stages[].outputs.artifacts[].customKind`                                                                                         | `boolean` |             |
| `input.pipeline.stages[].outputs.artifacts[].location`                                                                                           | `string`  |             |
| `input.pipeline.stages[].outputs.artifacts[].metadata.account`                                                                                   | `string`  |             |
| `input.pipeline.stages[].outputs.artifacts[].name`                                                                                               | `string`  |             |
| `input.pipeline.stages[].outputs.artifacts[].reference`                                                                                          | `string`  |             |
| `input.pipeline.stages[].outputs.artifacts[].type`                                                                                               | `string`  |             |
| `input.pipeline.stages[].outputs.artifacts[].version`                                                                                            | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].apiVersion`                                                                                         | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].data.nginx.status.conf`                                                                             | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].kind`                                                                                               | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].metadata.labels.app`                                                                                | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].metadata.name`                                                                                      | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].metadata.namespace`                                                                                 | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.finalizers[]`                                                                                  | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.ports[].name`                                                                                  | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.ports[].port`                                                                                  | `number`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.ports[].protocol`                                                                              | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.ports[].targetPort`                                                                            | `number`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.replicas`                                                                                      | `number`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.selector.app`                                                                                  | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.selector.matchLabels.app`                                                                      | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.selector.matchLabels.version`                                                                  | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.sessionAffinity`                                                                               | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.strategy.rollingUpdate.maxSurge`                                                               | `number`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.strategy.rollingUpdate.maxUnavailable`                                                         | `number`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.strategy.type`                                                                                 | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.template.metadata.annotations.prometheus.io/port`                                              | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.template.metadata.annotations.prometheus.io/scrape`                                            | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.template.metadata.labels.app`                                                                  | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.template.metadata.labels.version`                                                              | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.template.spec.containers[].args[]`                                                             | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.template.spec.containers[].imagePullPolicy`                                                    | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.template.spec.containers[].image`                                                              | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.template.spec.containers[].name`                                                               | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.template.spec.containers[].ports[].containerPort`                                              | `number`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.template.spec.containers[].ports[].name`                                                       | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.template.spec.containers[].ports[].protocol`                                                   | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.template.spec.containers[].volumeMounts[].mountPath`                                           | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.template.spec.containers[].volumeMounts[].name`                                                | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.template.spec.containers[].volumeMounts[].readOnly`                                            | `boolean` |             |
| `input.pipeline.stages[].outputs.manifests[].spec.template.spec.containers[].volumeMounts[].subPath`                                             | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.template.spec.restartPolicy`                                                                   | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.template.spec.volumes[].configMap.defaultMode`                                                 | `number`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.template.spec.volumes[].configMap.name`                                                        | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.template.spec.volumes[].name`                                                                  | `string`  |             |
| `input.pipeline.stages[].outputs.manifests[].spec.type`                                                                                          | `string`  |             |
| `input.pipeline.stages[].outputs.optionalArtifacts[].artifactAccount`                                                                            | `string`  |             |
| `input.pipeline.stages[].outputs.optionalArtifacts[].customKind`                                                                                 | `boolean` |             |
| `input.pipeline.stages[].outputs.optionalArtifacts[].metadata.id`                                                                                | `string`  |             |
| `input.pipeline.stages[].outputs.optionalArtifacts[].name`                                                                                       | `string`  |             |
| `input.pipeline.stages[].outputs.optionalArtifacts[].reference`                                                                                  | `string`  |             |
| `input.pipeline.stages[].outputs.optionalArtifacts[].type`                                                                                       | `string`  |             |
| `input.pipeline.stages[].outputs.optionalArtifacts[].version`                                                                                    | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.boundArtifacts[].customKind`                                                                            | `boolean` |             |
| `input.pipeline.stages[].outputs.outputs.boundArtifacts[].location`                                                                              | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.boundArtifacts[].metadata.account`                                                                      | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.boundArtifacts[].name`                                                                                  | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.boundArtifacts[].reference`                                                                             | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.boundArtifacts[].type`                                                                                  | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.boundArtifacts[].version`                                                                               | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.createdArtifacts[].customKind`                                                                          | `boolean` |             |
| `input.pipeline.stages[].outputs.outputs.createdArtifacts[].location`                                                                            | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.createdArtifacts[].metadata.account`                                                                    | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.createdArtifacts[].name`                                                                                | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.createdArtifacts[].reference`                                                                           | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.createdArtifacts[].type`                                                                                | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.createdArtifacts[].version`                                                                             | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifestNamesByNamespace.[]`                                                                            | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifestNamesByNamespace.staging[]`                                                                     | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].apiVersion`                                                                                 | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].data.nginx.status.conf`                                                                     | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].kind`                                                                                       | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].metadata.annotations.artifact.spinnaker.io/location`                                        | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].metadata.annotations.artifact.spinnaker.io/name`                                            | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].metadata.annotations.artifact.spinnaker.io/type`                                            | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].metadata.annotations.artifact.spinnaker.io/version`                                         | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].metadata.annotations.deployment.kubernetes.io/revision`                                     | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].metadata.annotations.kubectl.kubernetes.io/last-applied-configuration`                      | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].metadata.annotations.moniker.spinnaker.io/application`                                      | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].metadata.annotations.moniker.spinnaker.io/cluster`                                          | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].metadata.annotations.moniker.spinnaker.io/sequence`                                         | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].metadata.creationTimestamp`                                                                 | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].metadata.finalizers[]`                                                                      | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].metadata.generation`                                                                        | `number`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].metadata.labels.app.kubernetes.io/managed-by`                                               | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].metadata.labels.app.kubernetes.io/name`                                                     | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].metadata.labels.app`                                                                        | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].metadata.labels.moniker.spinnaker.io/sequence`                                              | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].metadata.managedFields[].apiVersion`                                                        | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].metadata.managedFields[].fieldsType`                                                        | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].metadata.managedFields[].manager`                                                           | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].metadata.managedFields[].operation`                                                         | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].metadata.managedFields[].time`                                                              | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].metadata.name`                                                                              | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].metadata.namespace`                                                                         | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].metadata.resourceVersion`                                                                   | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].metadata.selfLink`                                                                          | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].metadata.uid`                                                                               | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.clusterIP`                                                                             | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.externalTrafficPolicy`                                                                 | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.finalizers[]`                                                                          | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.ports[].name`                                                                          | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.ports[].nodePort`                                                                      | `number`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.ports[].port`                                                                          | `number`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.ports[].protocol`                                                                      | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.ports[].targetPort`                                                                    | `number`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.progressDeadlineSeconds`                                                               | `number`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.replicas`                                                                              | `number`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.revisionHistoryLimit`                                                                  | `number`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.selector.app`                                                                          | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.selector.matchLabels.app`                                                              | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.selector.matchLabels.version`                                                          | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.sessionAffinity`                                                                       | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.strategy.rollingUpdate.maxSurge`                                                       | `number`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.strategy.rollingUpdate.maxUnavailable`                                                 | `number`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.strategy.type`                                                                         | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/location`                          | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/name`                              | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/type`                              | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/version`                           | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.metadata.annotations.moniker.spinnaker.io/application`                        | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.metadata.annotations.moniker.spinnaker.io/cluster`                            | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.metadata.annotations.prometheus.io/port`                                      | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.metadata.annotations.prometheus.io/scrape`                                    | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.metadata.labels.app.kubernetes.io/managed-by`                                 | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.metadata.labels.app.kubernetes.io/name`                                       | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.metadata.labels.app`                                                          | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.metadata.labels.version`                                                      | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.spec.containers[].args[]`                                                     | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.spec.containers[].imagePullPolicy`                                            | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.spec.containers[].image`                                                      | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.spec.containers[].name`                                                       | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.spec.containers[].ports[].containerPort`                                      | `number`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.spec.containers[].ports[].name`                                               | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.spec.containers[].ports[].protocol`                                           | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.spec.containers[].terminationMessagePath`                                     | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.spec.containers[].terminationMessagePolicy`                                   | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.spec.containers[].volumeMounts[].mountPath`                                   | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.spec.containers[].volumeMounts[].name`                                        | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.spec.containers[].volumeMounts[].readOnly`                                    | `boolean` |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.spec.containers[].volumeMounts[].subPath`                                     | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.spec.dnsPolicy`                                                               | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.spec.restartPolicy`                                                           | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.spec.schedulerName`                                                           | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.spec.terminationGracePeriodSeconds`                                           | `number`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.spec.volumes[].configMap.defaultMode`                                         | `number`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.spec.volumes[].configMap.name`                                                | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.template.spec.volumes[].name`                                                          | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].spec.type`                                                                                  | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].status.availableReplicas`                                                                   | `number`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].status.conditions[].lastTransitionTime`                                                     | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].status.conditions[].lastUpdateTime`                                                         | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].status.conditions[].message`                                                                | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].status.conditions[].reason`                                                                 | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].status.conditions[].status`                                                                 | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].status.conditions[].type`                                                                   | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].status.loadBalancer.ingress[].hostname`                                                     | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].status.observedGeneration`                                                                  | `number`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].status.phase`                                                                               | `string`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].status.readyReplicas`                                                                       | `number`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].status.replicas`                                                                            | `number`  |             |
| `input.pipeline.stages[].outputs.outputs.manifests[].status.updatedReplicas`                                                                     | `number`  |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].boundArtifact.customKind`                                                           | `boolean` |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].boundArtifact.name`                                                                 | `string`  |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].boundArtifact.reference`                                                            | `string`  |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].boundArtifact.type`                                                                 | `string`  |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].defaultArtifact.customKind`                                                         | `boolean` |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].defaultArtifact.metadata.id`                                                        | `string`  |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].id`                                                                                 | `string`  |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].matchArtifact.artifactAccount`                                                      | `string`  |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].matchArtifact.customKind`                                                           | `boolean` |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].matchArtifact.metadata.id`                                                          | `string`  |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].matchArtifact.name`                                                                 | `string`  |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].matchArtifact.type`                                                                 | `string`  |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].useDefaultArtifact`                                                                 | `boolean` |             |
| `input.pipeline.stages[].outputs.resolvedExpectedArtifacts[].usePriorArtifact`                                                                   | `boolean` |             |
| `input.pipeline.stages[].outputs.status.code`                                                                                                    | `number`  |             |
| `input.pipeline.stages[].outputs.status.error`                                                                                                   | `string`  |             |
| `input.pipeline.stages[].outputs.status.id`                                                                                                      | `string`  |             |
| `input.pipeline.stages[].outputs.status.logs.combined`                                                                                           | `string`  |             |
| `input.pipeline.stages[].outputs.status.logs.init_stderr`                                                                                        | `string`  |             |
| `input.pipeline.stages[].outputs.status.logs.init_stdout`                                                                                        | `string`  |             |
| `input.pipeline.stages[].outputs.status.logs.plan_stderr`                                                                                        | `string`  |             |
| `input.pipeline.stages[].outputs.status.logs.plan_stdout`                                                                                        | `string`  |             |
| `input.pipeline.stages[].outputs.status.outputs.artifacts[].customKind`                                                                          | `boolean` |             |
| `input.pipeline.stages[].outputs.status.outputs.artifacts[].kind`                                                                                | `string`  |             |
| `input.pipeline.stages[].outputs.status.outputs.artifacts[].name`                                                                                | `string`  |             |
| `input.pipeline.stages[].outputs.status.outputs.artifacts[].reference`                                                                           | `string`  |             |
| `input.pipeline.stages[].outputs.status.outputs.artifacts[].type`                                                                                | `string`  |             |
| `input.pipeline.stages[].outputs.status.state`                                                                                                   | `string`  |             |
| `input.pipeline.stages[].parentStageId`                                                                                                          | ` `       |             |
| `input.pipeline.stages[].refId`                                                                                                                  | `string`  |             |
| `input.pipeline.stages[].requisiteStageRefIds[]`                                                                                                 | `string`  |             |
| `input.pipeline.stages[].scheduledTime`                                                                                                          | ` `       |             |
| `input.pipeline.stages[].startTime`                                                                                                              | `number`  |             |
| `input.pipeline.stages[].startTime`                                                                                                              | ` `       |             |
| `input.pipeline.stages[].startTimeExpiry`                                                                                                        | ` `       |             |
| `input.pipeline.stages[].status`                                                                                                                 | `string`  |             |
| `input.pipeline.stages[].syntheticStageOwner`                                                                                                    | ` `       |             |
| `input.pipeline.stages[].tasks[].endTime`                                                                                                        | `number`  |             |
| `input.pipeline.stages[].tasks[].id`                                                                                                             | `string`  |             |
| `input.pipeline.stages[].tasks[].implementingClass`                                                                                              | `string`  |             |
| `input.pipeline.stages[].tasks[].loopEnd`                                                                                                        | `boolean` |             |
| `input.pipeline.stages[].tasks[].loopStart`                                                                                                      | `boolean` |             |
| `input.pipeline.stages[].tasks[].name`                                                                                                           | `string`  |             |
| `input.pipeline.stages[].tasks[].stageEnd`                                                                                                       | `boolean` |             |
| `input.pipeline.stages[].tasks[].stageStart`                                                                                                     | `boolean` |             |
| `input.pipeline.stages[].tasks[].startTime`                                                                                                      | `number`  |             |
| `input.pipeline.stages[].tasks[].status`                                                                                                         | `string`  |             |
| `input.pipeline.stages[].type`                                                                                                                   | `string`  |             |

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
| `input.pipeline.trigger.artifacts[].version`                                               | ` `       |             |
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
| `input.pipeline.trigger.other.parameters.namespace`                                        | `string`  |             |
| `input.pipeline.trigger.other.parameters.replicas`                                         | `string`  |             |
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
| `input.pipeline.trigger.parameters.namespace`                                              | `string`  |             |
| `input.pipeline.trigger.parameters.replicas`                                               | `string`  |             |
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
| `input.pipeline.trigger.resolvedExpectedArtifacts[].boundArtifact.version`                 | ` `       |             |
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
| `input.pipeline.trigger.resolvedExpectedArtifacts[].defaultArtifact.version`               | ` `       |             |
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
| `input.pipeline.type`                                                                      | `string`  |             |

### `input.stage`

| Key                                                 | Type      | Description |
| --------------------------------------------------- | --------- | ----------- |
| `input.stage.context.completeOtherBranchesThenFail` | `boolean` |             |
| `input.stage.context.continuePipeline`              | `boolean` |             |
| `input.stage.context.failPipeline`                  | `boolean` |             |
| `input.stage.context.instructions`                  | `string`  |             |
| `input.stage.context.judgmentStatus`                | `string`  |             |
| `input.stage.context.lastModifiedBy`                | `string`  |             |
| `input.stage.context.stageTimeoutMs`                | `number`  |             |
| `input.stage.endTime`                               | ` `       |             |
| `input.stage.id`                                    | `string`  |             |
| `input.stage.lastModified.allowedAccounts[]`        | `string`  |             |
| `input.stage.lastModified.lastModifiedTime`         | `number`  |             |
| `input.stage.lastModified.user`                     | `string`  |             |
| `input.stage.name`                                  | `string`  |             |
| `input.stage.parentStageId`                         | ` `       |             |
| `input.stage.refId`                                 | `string`  |             |
| `input.stage.requisiteStageRefIds[]`                | `string`  |             |
| `input.stage.scheduledTime`                         | ` `       |             |
| `input.stage.startTime`                             | `number`  |             |
| `input.stage.startTimeExpiry`                       | ` `       |             |
| `input.stage.status`                                | `string`  |             |
| `input.stage.syntheticStageOwner`                   | ` `       |             |
| `input.stage.tasks[].endTime`                       | ` `       |             |
| `input.stage.tasks[].id`                            | `string`  |             |
| `input.stage.tasks[].implementingClass`             | `string`  |             |
| `input.stage.tasks[].loopEnd`                       | `boolean` |             |
| `input.stage.tasks[].loopStart`                     | `boolean` |             |
| `input.stage.tasks[].name`                          | `string`  |             |
| `input.stage.tasks[].stageEnd`                      | `boolean` |             |
| `input.stage.tasks[].stageStart`                    | `boolean` |             |
| `input.stage.tasks[].startTime`                     | `number`  |             |
| `input.stage.tasks[].status`                        | `string`  |             |
| `input.stage.type`                                  | `string`  |             |

### `input.user`

This object provides information about the user performing the action. This can be used to restrict actions by role. See [input.user]({{< ref "input.user.md" >}}) for more information.