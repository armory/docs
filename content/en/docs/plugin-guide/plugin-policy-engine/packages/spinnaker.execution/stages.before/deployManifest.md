---
title: "spinnaker.execution.stages.before.deployManifest"
linktitle: "deployManifest"
description: "WHO AM I?"
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
      "buildTime": 1620752502018,
      "canceled": false,
      "canceledBy": null,
      "cancellationReason": null,
      "description": "Deploy manifest",
      "endTime": null,
      "id": "01F5E61382GF88N6R7JFBA9XA2",
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
        "01F5E613827GH96PMBS5PJVE50"
      ],
      "startTime": 1620752502041,
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
        "artifacts": [
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
          }
        ],
        "cloudProvider": "kubernetes",
        "deploy.account.name": "spinnaker",
        "deploy.server.groups": {},
        "failedManifests": [],
        "kato.last.task.id": {
          "id": "63e8305c-2251-4a83-9509-b8f5b3143cb3"
        },
        "kato.result.expected": true,
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
                "status": "Swapping out artifacts in deployment hostname from context..."
              },
              {
                "phase": "DEPLOY_KUBERNETES_MANIFEST",
                "status": "Finding deployer for deployment..."
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
                "status": "Deploy order is: deployment hostname"
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
            "id": "63e8305c-2251-4a83-9509-b8f5b3143cb3",
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
                    "type": "kubernetes/deployment",
                    "version": ""
                  }
                ],
                "manifestNamesByNamespace": {
                  "staging": [
                    "deployment hostname"
                  ]
                },
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
            ],
            "status": {
              "completed": true,
              "failed": false,
              "retryable": false
            }
          }
        ],
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
        "messages": [],
        "moniker": {
          "app": "hostname",
          "cluster": "deployment hostname"
        },
        "optionalArtifacts": [],
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
            "type": "kubernetes/deployment",
            "version": ""
          }
        ],
        "outputs.manifestNamesByNamespace": {
          "staging": [
            "deployment hostname"
          ]
        },
        "outputs.manifests": [
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
        ],
        "relationships": {
          "loadBalancers": [],
          "securityGroups": []
        },
        "requiredArtifacts": [],
        "source": "text",
        "stableManifests": [
          {
            "location": "staging",
            "manifestName": "deployment hostname"
          }
        ],
        "user": "myUserName"
      },
      "endTime": null,
      "id": "01F5E613827GH96PMBS5PJVE50",
      "lastModified": null,
      "name": "deployManifest",
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
            "type": "kubernetes/deployment",
            "version": ""
          }
        ],
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
        "optionalArtifacts": [],
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
            "type": "kubernetes/deployment",
            "version": ""
          }
        ],
        "outputs.manifestNamesByNamespace": {
          "staging": [
            "deployment hostname"
          ]
        },
        "outputs.manifests": [
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
        ],
        "requiredArtifacts": []
      },
      "parentStageId": null,
      "refId": "0",
      "requisiteStageRefIds": [],
      "scheduledTime": null,
      "startTime": 1620752502094,
      "startTimeExpiry": null,
      "status": "RUNNING",
      "syntheticStageOwner": null,
      "tasks": [
        {
          "endTime": 1620752502246,
          "id": "1",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.manifest.ResolveDeploySourceManifestTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "resolveDeploySourceManifest",
          "stageEnd": false,
          "stageStart": true,
          "startTime": 1620752502114,
          "status": "SUCCEEDED"
        },
        {
          "endTime": 1620752502738,
          "id": "2",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.manifest.DeployManifestTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "deployManifest",
          "stageEnd": false,
          "stageStart": false,
          "startTime": 1620752502265,
          "status": "SUCCEEDED"
        },
        {
          "endTime": 1620752508133,
          "id": "3",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.MonitorKatoTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "monitorDeploy",
          "stageEnd": false,
          "stageStart": false,
          "startTime": 1620752502764,
          "status": "SUCCEEDED"
        },
        {
          "endTime": 1620752508319,
          "id": "4",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.manifest.PromoteManifestKatoOutputsTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "promoteOutputs",
          "stageEnd": false,
          "stageStart": false,
          "startTime": 1620752508168,
          "status": "SUCCEEDED"
        },
        {
          "endTime": 1620752508606,
          "id": "5",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.manifest.WaitForManifestStableTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "waitForManifestToStabilize",
          "stageEnd": false,
          "stageStart": false,
          "startTime": 1620752508388,
          "status": "SUCCEEDED"
        },
        {
          "endTime": null,
          "id": "6",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.artifacts.CleanupArtifactsTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "cleanupArtifacts",
          "stageEnd": false,
          "stageStart": false,
          "startTime": 1620752508624,
          "status": "RUNNING"
        },
        {
          "endTime": null,
          "id": "7",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.MonitorKatoTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "monitorCleanup",
          "stageEnd": false,
          "stageStart": false,
          "startTime": null,
          "status": "NOT_STARTED"
        },
        {
          "endTime": null,
          "id": "8",
          "implementingClass": "com.netflix.spinnaker.orca.clouddriver.tasks.manifest.PromoteManifestKatoOutputsTask",
          "loopEnd": false,
          "loopStart": false,
          "name": "promoteOutputs",
          "stageEnd": false,
          "stageStart": false,
          "startTime": null,
          "status": "NOT_STARTED"
        },
        {
          "endTime": null,
          "id": "9",
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
      "type": "deployManifest"
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

| Key                                          | Type      | Description                                              |
|----------------------------------------------|-----------|----------------------------------------------------------|
| `input.pipeline.application` | `string` |
| `input.pipeline.authentication.allowedAccounts[]` | `string` |
| `input.pipeline.authentication.user` | `string` |
| `input.pipeline.buildTime` | `number` |
| `input.pipeline.canceled` | `boolean` |
| `input.pipeline.canceledBy` | ` ` |
| `input.pipeline.cancellationReason` | ` ` |
| `input.pipeline.description` | `string` |
| `input.pipeline.endTime` | ` ` |
| `input.pipeline.id` | `string` |
| `input.pipeline.keepWaitingPipelines` | `boolean` |
| `input.pipeline.limitConcurrent` | `boolean` |
| `input.pipeline.name` | ` ` |
| `input.pipeline.origin` | `string` |
| `input.pipeline.partition` | ` ` |
| `input.pipeline.paused` | ` ` |
| `input.pipeline.pipelineConfigId` | ` ` |
| `input.pipeline.source` | ` ` |
| `input.pipeline.spelEvaluator` | ` ` |
| `input.pipeline.stages[]` | `string` |
| `input.pipeline.startTime` | `number` |
| `input.pipeline.startTimeExpiry` | ` ` |
| `input.pipeline.status` | `string` |
| `input.pipeline.templateVariables` | ` ` |
| `input.pipeline.trigger.correlationId` | ` ` |
| `input.pipeline.trigger.isDryRun` | `boolean` |
| `input.pipeline.trigger.isRebake` | `boolean` |
| `input.pipeline.trigger.isStrategy` | `boolean` |
| `input.pipeline.trigger.other.dryRun` | `boolean` |
| `input.pipeline.trigger.other.rebake` | `boolean` |
| `input.pipeline.trigger.other.strategy` | `boolean` |
| `input.pipeline.trigger.other.type` | `string` |
| `input.pipeline.trigger.other.user` | `string` |
| `input.pipeline.trigger.type` | `string` |
| `input.pipeline.trigger.user` | `string` |
| `input.pipeline.type` | `string` |
| `input.stage.context.account` | `string` |
| `input.stage.context.artifacts[].customKind` | `boolean` |
| `input.stage.context.artifacts[].location` | `string` |
| `input.stage.context.artifacts[].metadata.account` | `string` |
| `input.stage.context.artifacts[].name` | `string` |
| `input.stage.context.artifacts[].reference` | `string` |
| `input.stage.context.artifacts[].type` | `string` |
| `input.stage.context.artifacts[].version` | `string` |
| `input.stage.context.cloudProvider` | `string` |
| `input.stage.context.deploy.account.name` | `string` |
| `input.stage.context.kato.last.task.id.id` | `string` |
| `input.stage.context.kato.result.expected` | `boolean` |
| `input.stage.context.kato.task.firstNotFoundRetry` | `number` |
| `input.stage.context.kato.task.lastStatus` | `string` |
| `input.stage.context.kato.task.notFoundRetryCount` | `number` |
| `input.stage.context.kato.task.terminalRetryCount` | `number` |
| `input.stage.context.kato.tasks[].history[].phase` | `string` |
| `input.stage.context.kato.tasks[].history[].status` | `string` |
| `input.stage.context.kato.tasks[].id` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].createdArtifacts[].customKind` | `boolean` |
| `input.stage.context.kato.tasks[].resultObjects[].createdArtifacts[].location` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].createdArtifacts[].metadata.account` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].createdArtifacts[].name` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].createdArtifacts[].reference` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].createdArtifacts[].type` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].createdArtifacts[].version` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifestNamesByNamespace.staging[]` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].apiVersion` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].kind` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].metadata.annotations.artifact.spinnaker.io/location` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].metadata.annotations.artifact.spinnaker.io/name` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].metadata.annotations.artifact.spinnaker.io/type` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].metadata.annotations.artifact.spinnaker.io/version` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].metadata.annotations.deployment.kubernetes.io/revision` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].metadata.annotations.kubectl.kubernetes.io/last-applied-configuration` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].metadata.annotations.moniker.spinnaker.io/application` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].metadata.annotations.moniker.spinnaker.io/cluster` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].metadata.creationTimestamp` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].metadata.generation` | `number` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].metadata.labels.app.kubernetes.io/managed-by` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].metadata.labels.app.kubernetes.io/name` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].metadata.managedFields[].apiVersion` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].metadata.managedFields[].fieldsType` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].metadata.managedFields[].manager` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].metadata.managedFields[].operation` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].metadata.managedFields[].time` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].metadata.name` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].metadata.namespace` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].metadata.resourceVersion` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].metadata.selfLink` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].metadata.uid` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.progressDeadlineSeconds` | `number` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.replicas` | `number` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.revisionHistoryLimit` | `number` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.selector.matchLabels.app` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.selector.matchLabels.version` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.strategy.rollingUpdate.maxSurge` | `number` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.strategy.rollingUpdate.maxUnavailable` | `number` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.strategy.type` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/location` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/name` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/type` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/version` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.metadata.annotations.moniker.spinnaker.io/application` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.metadata.annotations.moniker.spinnaker.io/cluster` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.metadata.annotations.prometheus.io/port` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.metadata.annotations.prometheus.io/scrape` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.metadata.labels.app` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.metadata.labels.app.kubernetes.io/managed-by` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.metadata.labels.app.kubernetes.io/name` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.metadata.labels.version` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.containers[].args[]` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.containers[].image` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.containers[].imagePullPolicy` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.containers[].name` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.containers[].ports[].containerPort` | `number` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.containers[].ports[].name` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.containers[].ports[].protocol` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.containers[].terminationMessagePath` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.containers[].terminationMessagePolicy` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.containers[].volumeMounts[].mountPath` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.containers[].volumeMounts[].name` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.containers[].volumeMounts[].readOnly` | `boolean` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.containers[].volumeMounts[].subPath` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.dnsPolicy` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.restartPolicy` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.schedulerName` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.terminationGracePeriodSeconds` | `number` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.volumes[].configMap.defaultMode` | `number` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.volumes[].configMap.name` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].spec.template.spec.volumes[].name` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].status.availableReplicas` | `number` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].status.conditions[].lastTransitionTime` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].status.conditions[].lastUpdateTime` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].status.conditions[].message` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].status.conditions[].reason` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].status.conditions[].status` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].status.conditions[].type` | `string` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].status.observedGeneration` | `number` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].status.readyReplicas` | `number` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].status.replicas` | `number` |
| `input.stage.context.kato.tasks[].resultObjects[].manifests[].status.updatedReplicas` | `number` |
| `input.stage.context.kato.tasks[].status.completed` | `boolean` |
| `input.stage.context.kato.tasks[].status.failed` | `boolean` |
| `input.stage.context.kato.tasks[].status.retryable` | `boolean` |
| `input.stage.context.manifestArtifactAccount` | `string` |
| `input.stage.context.manifests[].apiVersion` | `string` |
| `input.stage.context.manifests[].kind` | `string` |
| `input.stage.context.manifests[].metadata.annotations.artifact.spinnaker.io/location` | `string` |
| `input.stage.context.manifests[].metadata.annotations.artifact.spinnaker.io/name` | `string` |
| `input.stage.context.manifests[].metadata.annotations.artifact.spinnaker.io/type` | `string` |
| `input.stage.context.manifests[].metadata.annotations.artifact.spinnaker.io/version` | `string` |
| `input.stage.context.manifests[].metadata.annotations.moniker.spinnaker.io/application` | `string` |
| `input.stage.context.manifests[].metadata.annotations.moniker.spinnaker.io/cluster` | `string` |
| `input.stage.context.manifests[].metadata.labels.app.kubernetes.io/managed-by` | `string` |
| `input.stage.context.manifests[].metadata.labels.app.kubernetes.io/name` | `string` |
| `input.stage.context.manifests[].metadata.name` | `string` |
| `input.stage.context.manifests[].metadata.namespace` | `string` |
| `input.stage.context.manifests[].spec.replicas` | `number` |
| `input.stage.context.manifests[].spec.selector.matchLabels.app` | `string` |
| `input.stage.context.manifests[].spec.selector.matchLabels.version` | `string` |
| `input.stage.context.manifests[].spec.strategy.rollingUpdate.maxSurge` | `number` |
| `input.stage.context.manifests[].spec.strategy.rollingUpdate.maxUnavailable` | `number` |
| `input.stage.context.manifests[].spec.strategy.type` | `string` |
| `input.stage.context.manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/location` | `string` |
| `input.stage.context.manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/name` | `string` |
| `input.stage.context.manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/type` | `string` |
| `input.stage.context.manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/version` | `string` |
| `input.stage.context.manifests[].spec.template.metadata.annotations.moniker.spinnaker.io/application` | `string` |
| `input.stage.context.manifests[].spec.template.metadata.annotations.moniker.spinnaker.io/cluster` | `string` |
| `input.stage.context.manifests[].spec.template.metadata.annotations.prometheus.io/port` | `string` |
| `input.stage.context.manifests[].spec.template.metadata.annotations.prometheus.io/scrape` | `string` |
| `input.stage.context.manifests[].spec.template.metadata.labels.app` | `string` |
| `input.stage.context.manifests[].spec.template.metadata.labels.app.kubernetes.io/managed-by` | `string` |
| `input.stage.context.manifests[].spec.template.metadata.labels.app.kubernetes.io/name` | `string` |
| `input.stage.context.manifests[].spec.template.metadata.labels.version` | `string` |
| `input.stage.context.manifests[].spec.template.spec.containers[].args[]` | `string` |
| `input.stage.context.manifests[].spec.template.spec.containers[].image` | `string` |
| `input.stage.context.manifests[].spec.template.spec.containers[].imagePullPolicy` | `string` |
| `input.stage.context.manifests[].spec.template.spec.containers[].name` | `string` |
| `input.stage.context.manifests[].spec.template.spec.containers[].ports[].containerPort` | `number` |
| `input.stage.context.manifests[].spec.template.spec.containers[].ports[].name` | `string` |
| `input.stage.context.manifests[].spec.template.spec.containers[].ports[].protocol` | `string` |
| `input.stage.context.manifests[].spec.template.spec.containers[].volumeMounts[].mountPath` | `string` |
| `input.stage.context.manifests[].spec.template.spec.containers[].volumeMounts[].name` | `string` |
| `input.stage.context.manifests[].spec.template.spec.containers[].volumeMounts[].readOnly` | `boolean` |
| `input.stage.context.manifests[].spec.template.spec.containers[].volumeMounts[].subPath` | `string` |
| `input.stage.context.manifests[].spec.template.spec.restartPolicy` | `string` |
| `input.stage.context.manifests[].spec.template.spec.volumes[].configMap.defaultMode` | `number` |
| `input.stage.context.manifests[].spec.template.spec.volumes[].configMap.name` | `string` |
| `input.stage.context.manifests[].spec.template.spec.volumes[].name` | `string` |
| `input.stage.context.moniker.app` | `string` |
| `input.stage.context.moniker.cluster` | `string` |
| `input.stage.context.outputs.createdArtifacts[].customKind` | `boolean` |
| `input.stage.context.outputs.createdArtifacts[].location` | `string` |
| `input.stage.context.outputs.createdArtifacts[].metadata.account` | `string` |
| `input.stage.context.outputs.createdArtifacts[].name` | `string` |
| `input.stage.context.outputs.createdArtifacts[].reference` | `string` |
| `input.stage.context.outputs.createdArtifacts[].type` | `string` |
| `input.stage.context.outputs.createdArtifacts[].version` | `string` |
| `input.stage.context.outputs.manifestNamesByNamespace.staging[]` | `string` |
| `input.stage.context.outputs.manifests[].apiVersion` | `string` |
| `input.stage.context.outputs.manifests[].kind` | `string` |
| `input.stage.context.outputs.manifests[].metadata.annotations.artifact.spinnaker.io/location` | `string` |
| `input.stage.context.outputs.manifests[].metadata.annotations.artifact.spinnaker.io/name` | `string` |
| `input.stage.context.outputs.manifests[].metadata.annotations.artifact.spinnaker.io/type` | `string` |
| `input.stage.context.outputs.manifests[].metadata.annotations.artifact.spinnaker.io/version` | `string` |
| `input.stage.context.outputs.manifests[].metadata.annotations.deployment.kubernetes.io/revision` | `string` |
| `input.stage.context.outputs.manifests[].metadata.annotations.kubectl.kubernetes.io/last-applied-configuration` | `string` |
| `input.stage.context.outputs.manifests[].metadata.annotations.moniker.spinnaker.io/application` | `string` |
| `input.stage.context.outputs.manifests[].metadata.annotations.moniker.spinnaker.io/cluster` | `string` |
| `input.stage.context.outputs.manifests[].metadata.creationTimestamp` | `string` |
| `input.stage.context.outputs.manifests[].metadata.generation` | `number` |
| `input.stage.context.outputs.manifests[].metadata.labels.app.kubernetes.io/managed-by` | `string` |
| `input.stage.context.outputs.manifests[].metadata.labels.app.kubernetes.io/name` | `string` |
| `input.stage.context.outputs.manifests[].metadata.managedFields[].apiVersion` | `string` |
| `input.stage.context.outputs.manifests[].metadata.managedFields[].fieldsType` | `string` |
| `input.stage.context.outputs.manifests[].metadata.managedFields[].manager` | `string` |
| `input.stage.context.outputs.manifests[].metadata.managedFields[].operation` | `string` |
| `input.stage.context.outputs.manifests[].metadata.managedFields[].time` | `string` |
| `input.stage.context.outputs.manifests[].metadata.name` | `string` |
| `input.stage.context.outputs.manifests[].metadata.namespace` | `string` |
| `input.stage.context.outputs.manifests[].metadata.resourceVersion` | `string` |
| `input.stage.context.outputs.manifests[].metadata.selfLink` | `string` |
| `input.stage.context.outputs.manifests[].metadata.uid` | `string` |
| `input.stage.context.outputs.manifests[].spec.progressDeadlineSeconds` | `number` |
| `input.stage.context.outputs.manifests[].spec.replicas` | `number` |
| `input.stage.context.outputs.manifests[].spec.revisionHistoryLimit` | `number` |
| `input.stage.context.outputs.manifests[].spec.selector.matchLabels.app` | `string` |
| `input.stage.context.outputs.manifests[].spec.selector.matchLabels.version` | `string` |
| `input.stage.context.outputs.manifests[].spec.strategy.rollingUpdate.maxSurge` | `number` |
| `input.stage.context.outputs.manifests[].spec.strategy.rollingUpdate.maxUnavailable` | `number` |
| `input.stage.context.outputs.manifests[].spec.strategy.type` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/location` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/name` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/type` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/version` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.metadata.annotations.moniker.spinnaker.io/application` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.metadata.annotations.moniker.spinnaker.io/cluster` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.metadata.annotations.prometheus.io/port` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.metadata.annotations.prometheus.io/scrape` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.metadata.labels.app` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.metadata.labels.app.kubernetes.io/managed-by` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.metadata.labels.app.kubernetes.io/name` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.metadata.labels.version` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.spec.containers[].args[]` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.spec.containers[].image` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.spec.containers[].imagePullPolicy` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.spec.containers[].name` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.spec.containers[].ports[].containerPort` | `number` |
| `input.stage.context.outputs.manifests[].spec.template.spec.containers[].ports[].name` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.spec.containers[].ports[].protocol` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.spec.containers[].terminationMessagePath` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.spec.containers[].terminationMessagePolicy` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.spec.containers[].volumeMounts[].mountPath` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.spec.containers[].volumeMounts[].name` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.spec.containers[].volumeMounts[].readOnly` | `boolean` |
| `input.stage.context.outputs.manifests[].spec.template.spec.containers[].volumeMounts[].subPath` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.spec.dnsPolicy` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.spec.restartPolicy` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.spec.schedulerName` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.spec.terminationGracePeriodSeconds` | `number` |
| `input.stage.context.outputs.manifests[].spec.template.spec.volumes[].configMap.defaultMode` | `number` |
| `input.stage.context.outputs.manifests[].spec.template.spec.volumes[].configMap.name` | `string` |
| `input.stage.context.outputs.manifests[].spec.template.spec.volumes[].name` | `string` |
| `input.stage.context.outputs.manifests[].status.availableReplicas` | `number` |
| `input.stage.context.outputs.manifests[].status.conditions[].lastTransitionTime` | `string` |
| `input.stage.context.outputs.manifests[].status.conditions[].lastUpdateTime` | `string` |
| `input.stage.context.outputs.manifests[].status.conditions[].message` | `string` |
| `input.stage.context.outputs.manifests[].status.conditions[].reason` | `string` |
| `input.stage.context.outputs.manifests[].status.conditions[].status` | `string` |
| `input.stage.context.outputs.manifests[].status.conditions[].type` | `string` |
| `input.stage.context.outputs.manifests[].status.observedGeneration` | `number` |
| `input.stage.context.outputs.manifests[].status.readyReplicas` | `number` |
| `input.stage.context.outputs.manifests[].status.replicas` | `number` |
| `input.stage.context.outputs.manifests[].status.updatedReplicas` | `number` |
| `input.stage.context.source` | `string` |
| `input.stage.context.stableManifests[].location` | `string` |
| `input.stage.context.stableManifests[].manifestName` | `string` |
| `input.stage.context.user` | `string` |
| `input.stage.endTime` | ` ` |
| `input.stage.id` | `string` |
| `input.stage.lastModified` | ` ` |
| `input.stage.name` | `string` |
| `input.stage.outputs.artifacts[].customKind` | `boolean` |
| `input.stage.outputs.artifacts[].location` | `string` |
| `input.stage.outputs.artifacts[].metadata.account` | `string` |
| `input.stage.outputs.artifacts[].name` | `string` |
| `input.stage.outputs.artifacts[].reference` | `string` |
| `input.stage.outputs.artifacts[].type` | `string` |
| `input.stage.outputs.artifacts[].version` | `string` |
| `input.stage.outputs.manifests[].apiVersion` | `string` |
| `input.stage.outputs.manifests[].kind` | `string` |
| `input.stage.outputs.manifests[].metadata.annotations.artifact.spinnaker.io/location` | `string` |
| `input.stage.outputs.manifests[].metadata.annotations.artifact.spinnaker.io/name` | `string` |
| `input.stage.outputs.manifests[].metadata.annotations.artifact.spinnaker.io/type` | `string` |
| `input.stage.outputs.manifests[].metadata.annotations.artifact.spinnaker.io/version` | `string` |
| `input.stage.outputs.manifests[].metadata.annotations.moniker.spinnaker.io/application` | `string` |
| `input.stage.outputs.manifests[].metadata.annotations.moniker.spinnaker.io/cluster` | `string` |
| `input.stage.outputs.manifests[].metadata.labels.app.kubernetes.io/managed-by` | `string` |
| `input.stage.outputs.manifests[].metadata.labels.app.kubernetes.io/name` | `string` |
| `input.stage.outputs.manifests[].metadata.name` | `string` |
| `input.stage.outputs.manifests[].metadata.namespace` | `string` |
| `input.stage.outputs.manifests[].spec.replicas` | `number` |
| `input.stage.outputs.manifests[].spec.selector.matchLabels.app` | `string` |
| `input.stage.outputs.manifests[].spec.selector.matchLabels.version` | `string` |
| `input.stage.outputs.manifests[].spec.strategy.rollingUpdate.maxSurge` | `number` |
| `input.stage.outputs.manifests[].spec.strategy.rollingUpdate.maxUnavailable` | `number` |
| `input.stage.outputs.manifests[].spec.strategy.type` | `string` |
| `input.stage.outputs.manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/location` | `string` |
| `input.stage.outputs.manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/name` | `string` |
| `input.stage.outputs.manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/type` | `string` |
| `input.stage.outputs.manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/version` | `string` |
| `input.stage.outputs.manifests[].spec.template.metadata.annotations.moniker.spinnaker.io/application` | `string` |
| `input.stage.outputs.manifests[].spec.template.metadata.annotations.moniker.spinnaker.io/cluster` | `string` |
| `input.stage.outputs.manifests[].spec.template.metadata.annotations.prometheus.io/port` | `string` |
| `input.stage.outputs.manifests[].spec.template.metadata.annotations.prometheus.io/scrape` | `string` |
| `input.stage.outputs.manifests[].spec.template.metadata.labels.app` | `string` |
| `input.stage.outputs.manifests[].spec.template.metadata.labels.app.kubernetes.io/managed-by` | `string` |
| `input.stage.outputs.manifests[].spec.template.metadata.labels.app.kubernetes.io/name` | `string` |
| `input.stage.outputs.manifests[].spec.template.metadata.labels.version` | `string` |
| `input.stage.outputs.manifests[].spec.template.spec.containers[].args[]` | `string` |
| `input.stage.outputs.manifests[].spec.template.spec.containers[].image` | `string` |
| `input.stage.outputs.manifests[].spec.template.spec.containers[].imagePullPolicy` | `string` |
| `input.stage.outputs.manifests[].spec.template.spec.containers[].name` | `string` |
| `input.stage.outputs.manifests[].spec.template.spec.containers[].ports[].containerPort` | `number` |
| `input.stage.outputs.manifests[].spec.template.spec.containers[].ports[].name` | `string` |
| `input.stage.outputs.manifests[].spec.template.spec.containers[].ports[].protocol` | `string` |
| `input.stage.outputs.manifests[].spec.template.spec.containers[].volumeMounts[].mountPath` | `string` |
| `input.stage.outputs.manifests[].spec.template.spec.containers[].volumeMounts[].name` | `string` |
| `input.stage.outputs.manifests[].spec.template.spec.containers[].volumeMounts[].readOnly` | `boolean` |
| `input.stage.outputs.manifests[].spec.template.spec.containers[].volumeMounts[].subPath` | `string` |
| `input.stage.outputs.manifests[].spec.template.spec.restartPolicy` | `string` |
| `input.stage.outputs.manifests[].spec.template.spec.volumes[].configMap.defaultMode` | `number` |
| `input.stage.outputs.manifests[].spec.template.spec.volumes[].configMap.name` | `string` |
| `input.stage.outputs.manifests[].spec.template.spec.volumes[].name` | `string` |
| `input.stage.outputs.outputs.createdArtifacts[].customKind` | `boolean` |
| `input.stage.outputs.outputs.createdArtifacts[].location` | `string` |
| `input.stage.outputs.outputs.createdArtifacts[].metadata.account` | `string` |
| `input.stage.outputs.outputs.createdArtifacts[].name` | `string` |
| `input.stage.outputs.outputs.createdArtifacts[].reference` | `string` |
| `input.stage.outputs.outputs.createdArtifacts[].type` | `string` |
| `input.stage.outputs.outputs.createdArtifacts[].version` | `string` |
| `input.stage.outputs.outputs.manifestNamesByNamespace.staging[]` | `string` |
| `input.stage.outputs.outputs.manifests[].apiVersion` | `string` |
| `input.stage.outputs.outputs.manifests[].kind` | `string` |
| `input.stage.outputs.outputs.manifests[].metadata.annotations.artifact.spinnaker.io/location` | `string` |
| `input.stage.outputs.outputs.manifests[].metadata.annotations.artifact.spinnaker.io/name` | `string` |
| `input.stage.outputs.outputs.manifests[].metadata.annotations.artifact.spinnaker.io/type` | `string` |
| `input.stage.outputs.outputs.manifests[].metadata.annotations.artifact.spinnaker.io/version` | `string` |
| `input.stage.outputs.outputs.manifests[].metadata.annotations.deployment.kubernetes.io/revision` | `string` |
| `input.stage.outputs.outputs.manifests[].metadata.annotations.kubectl.kubernetes.io/last-applied-configuration` | `string` |
| `input.stage.outputs.outputs.manifests[].metadata.annotations.moniker.spinnaker.io/application` | `string` |
| `input.stage.outputs.outputs.manifests[].metadata.annotations.moniker.spinnaker.io/cluster` | `string` |
| `input.stage.outputs.outputs.manifests[].metadata.creationTimestamp` | `string` |
| `input.stage.outputs.outputs.manifests[].metadata.generation` | `number` |
| `input.stage.outputs.outputs.manifests[].metadata.labels.app.kubernetes.io/managed-by` | `string` |
| `input.stage.outputs.outputs.manifests[].metadata.labels.app.kubernetes.io/name` | `string` |
| `input.stage.outputs.outputs.manifests[].metadata.managedFields[].apiVersion` | `string` |
| `input.stage.outputs.outputs.manifests[].metadata.managedFields[].fieldsType` | `string` |
| `input.stage.outputs.outputs.manifests[].metadata.managedFields[].manager` | `string` |
| `input.stage.outputs.outputs.manifests[].metadata.managedFields[].operation` | `string` |
| `input.stage.outputs.outputs.manifests[].metadata.managedFields[].time` | `string` |
| `input.stage.outputs.outputs.manifests[].metadata.name` | `string` |
| `input.stage.outputs.outputs.manifests[].metadata.namespace` | `string` |
| `input.stage.outputs.outputs.manifests[].metadata.resourceVersion` | `string` |
| `input.stage.outputs.outputs.manifests[].metadata.selfLink` | `string` |
| `input.stage.outputs.outputs.manifests[].metadata.uid` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.progressDeadlineSeconds` | `number` |
| `input.stage.outputs.outputs.manifests[].spec.replicas` | `number` |
| `input.stage.outputs.outputs.manifests[].spec.revisionHistoryLimit` | `number` |
| `input.stage.outputs.outputs.manifests[].spec.selector.matchLabels.app` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.selector.matchLabels.version` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.strategy.rollingUpdate.maxSurge` | `number` |
| `input.stage.outputs.outputs.manifests[].spec.strategy.rollingUpdate.maxUnavailable` | `number` |
| `input.stage.outputs.outputs.manifests[].spec.strategy.type` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/location` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/name` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/type` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.metadata.annotations.artifact.spinnaker.io/version` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.metadata.annotations.moniker.spinnaker.io/application` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.metadata.annotations.moniker.spinnaker.io/cluster` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.metadata.annotations.prometheus.io/port` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.metadata.annotations.prometheus.io/scrape` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.metadata.labels.app` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.metadata.labels.app.kubernetes.io/managed-by` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.metadata.labels.app.kubernetes.io/name` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.metadata.labels.version` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.spec.containers[].args[]` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.spec.containers[].image` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.spec.containers[].imagePullPolicy` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.spec.containers[].name` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.spec.containers[].ports[].containerPort` | `number` |
| `input.stage.outputs.outputs.manifests[].spec.template.spec.containers[].ports[].name` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.spec.containers[].ports[].protocol` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.spec.containers[].terminationMessagePath` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.spec.containers[].terminationMessagePolicy` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.spec.containers[].volumeMounts[].mountPath` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.spec.containers[].volumeMounts[].name` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.spec.containers[].volumeMounts[].readOnly` | `boolean` |
| `input.stage.outputs.outputs.manifests[].spec.template.spec.containers[].volumeMounts[].subPath` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.spec.dnsPolicy` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.spec.restartPolicy` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.spec.schedulerName` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.spec.terminationGracePeriodSeconds` | `number` |
| `input.stage.outputs.outputs.manifests[].spec.template.spec.volumes[].configMap.defaultMode` | `number` |
| `input.stage.outputs.outputs.manifests[].spec.template.spec.volumes[].configMap.name` | `string` |
| `input.stage.outputs.outputs.manifests[].spec.template.spec.volumes[].name` | `string` |
| `input.stage.outputs.outputs.manifests[].status.availableReplicas` | `number` |
| `input.stage.outputs.outputs.manifests[].status.conditions[].lastTransitionTime` | `string` |
| `input.stage.outputs.outputs.manifests[].status.conditions[].lastUpdateTime` | `string` |
| `input.stage.outputs.outputs.manifests[].status.conditions[].message` | `string` |
| `input.stage.outputs.outputs.manifests[].status.conditions[].reason` | `string` |
| `input.stage.outputs.outputs.manifests[].status.conditions[].status` | `string` |
| `input.stage.outputs.outputs.manifests[].status.conditions[].type` | `string` |
| `input.stage.outputs.outputs.manifests[].status.observedGeneration` | `number` |
| `input.stage.outputs.outputs.manifests[].status.readyReplicas` | `number` |
| `input.stage.outputs.outputs.manifests[].status.replicas` | `number` |
| `input.stage.outputs.outputs.manifests[].status.updatedReplicas` | `number` |
| `input.stage.parentStageId` | ` ` |
| `input.stage.refId` | `string` |
| `input.stage.scheduledTime` | ` ` |
| `input.stage.startTime` | `number` |
| `input.stage.startTimeExpiry` | ` ` |
| `input.stage.status` | `string` |
| `input.stage.syntheticStageOwner` | ` ` |
| `input.stage.tasks[].endTime` | `number` |
| `input.stage.tasks[].endTime` | ` ` |
| `input.stage.tasks[].id` | `string` |
| `input.stage.tasks[].implementingClass` | `string` |
| `input.stage.tasks[].loopEnd` | `boolean` |
| `input.stage.tasks[].loopStart` | `boolean` |
| `input.stage.tasks[].name` | `string` |
| `input.stage.tasks[].stageEnd` | `boolean` |
| `input.stage.tasks[].stageStart` | `boolean` |
| `input.stage.tasks[].startTime` | `number` |
| `input.stage.tasks[].startTime` | ` ` |
| `input.stage.tasks[].status` | `string` |
| `input.stage.type` | `string` |
| `input.user.isAdmin` | `boolean` |
| `input.user.username` | `string` |
