---
title: "spinnaker.execution.stages.before.manualJudgment"
linktitle: "manualJudgment"
description: "A policy targeting this object is run before executing each task in a manualJudgment stage."
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

Parameters related to the stage against which the policy is executing can be found in the [input.stage.context](#inputstagecontext) object.

### input.pipeline

| Key                                               | Type      | Description                                                                                                                                                                                                                                                |
| ------------------------------------------------- | --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `input.pipeline.application`                      | `string`  | The name of the Spinnaker application to which this pipeline belongs.                                                                                                                                                                                      |
| `input.pipeline.authentication.allowedAccounts[]` | `string`  | The list of accounts to which the user this stage is running as has access.                                                                                                                                                                                |
| `input.pipeline.authentication.user`              | `string`  | The Spinnaker user initiating the change.                                                                                                                                                                                                                  |
| `input.pipeline.buildTime`                        | `number`  |                                                                                                                                                                                                                                                            |
| `input.pipeline.canceled`                         | `boolean` |                                                                                                                                                                                                                                                            |
| `input.pipeline.canceledBy`                       | ` `       |                                                                                                                                                                                                                                                            |
| `input.pipeline.cancellationReason`               | ` `       |                                                                                                                                                                                                                                                            |
| `input.pipeline.description`                      | `string`  | Description of the pipeline defined in the UI                                                                                                                                                                                                              |
| `input.pipeline.endTime`                          | ` `       |                                                                                                                                                                                                                                                            |
| `input.pipeline.id`                               | `string`  | The unique ID of the pipeline                                                                                                                                                                                                                              |
| `input.pipeline.keepWaitingPipelines`             | `boolean` | If concurrent pipeline execution is disabled, then the pipelines that are in the waiting queue will get canceled when the next execution starts unless this is true.                                                                                       |
| `input.pipeline.limitConcurrent`                  | `boolean` | True if only 1 concurrent execution of this pipeline be allowed.                                                                                                                                                                                           |
| `input.pipeline.name`                             | `string`  | The name of this pipeline.                                                                                                                                                                                                                                 |
| `input.pipeline.origin`                           | `string`  |                                                                                                                                                                                                                                                            |
| `input.pipeline.partition`                        | ` `       |                                                                                                                                                                                                                                                            |
| `input.pipeline.paused`                           | ` `       |                                                                                                                                                                                                                                                            |
| `input.pipeline.pipelineConfigId`                 | `string`  |                                                                                                                                                                                                                                                            |
| `input.pipeline.source`                           | ` `       |                                                                                                                                                                                                                                                            |
| `input.pipeline.spelEvaluator`                    | `string`  | Which version of spring expression language is being used to evaluate SpEL.                                                                                                                                                                                |
| `input.pipeline.stages[]`                         | `[array]` | An array of the stages in the pipeline. Typically if you are writing a policy that examines multiple pipeline stages, it is better to write that policy against either the `opa.pipelines package`, or the `spinnaker.execution.pipelines.before` package. |
| `input.pipeline.startTime`                        | `number`  | Timestamp from when the pipeline was started.                                                                                                                                                                                                              |
| `input.pipeline.startTimeExpiry`                  | `date `   | Unix epoch date at which the pipeline will expire.                                                                                                                                                                                                         |
| `input.pipeline.status`                           | `string`  |                                                                                                                                                                                                                                                            |
| `input.pipeline.templateVariables`                | ` `       |                                                                                                                                                                                                                                                            |

### input.pipeline.trigger

See [input.pipeline.trigger]({{< ref "input.pipeline.trigger.md" >}}) for more information.

### input.stage.context

| Key                                                 | Type      | Description |
| --------------------------------------------------- | --------- | ----------- |
| `input.stage.context.completeOtherBranchesThenFail` | `boolean` |             |
| `input.stage.context.continuePipeline`              | `boolean` |             |
| `input.stage.context.failPipeline`                  | `boolean` |             |
| `input.stage.context.instructions`                  | `string`  |             |
| `input.stage.context.judgmentStatus`                | `string`  |             |
| `input.stage.context.lastModifiedBy`                | `string`  |             |
| `input.stage.context.stageTimeoutMs`                | `number`  |             |

### input.stage

See [`input.stage`]({{< ref "input.stage.md" >}}) for more information.

### input.user

This object provides information about the user performing the action. This can be used to restrict actions by role. See [input.user]({{< ref "input.user.md" >}}) for more information.