---
title: "spinnaker.execution.stages.before.deployManifest"
linktitle: "deployManifest"
description: "A policy targeting this object runs before executing each task in a deployManifest stage."
weight: 10
---
 See [Deploy Applications to Kubernetes]({{< ref "kubernetes-v2#available-manifest-based-stages" >}}) for more information on this stage.

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

- This policy requires that a set of annotations have been applied to any manifests that are being deployed. Specifically the annotations 'app' and 'owner' must have been applied.

  {{< prism lang="rego" line-numbers="true" >}}
    package spinnaker.execution.stages.before.deployManifest
    required_annotations:=["app","owner"]
    deny["Manifest is missing a required annotation"] {
        metadata :=input.stage.context.manifests[_].metadata
        annotations := object.get(metadata,"annotations",{})
        # Use object.get to check if data exists
        object.get(annotations,required_annotations[_],null)==null
    }{
        metadata :=input.stage.context.manifests[_].spec.template.metadata
        annotations := object.get(metadata,"annotations",{})
        # Use object.get to check if data exists
        object.get(annotations,required_annotations[_],null)==null
    }
  {{< /prism >}}

<br/>

- This policy requires prevents exposing a set of ports that are unencrypted buy have encrypted alternatives. Specifically this policy prevents exposing HTTP, FTP, TELNET, POP3, NNTP, IMAP, LDAP, and SMTP from a pod, deployment, or replicaset.

  {{< prism lang="rego" line-numbers="true" >}}
  package spinnaker.execution.stages.before.deployManifest

  blockedPorts := [20,21,23,80,110,119,143,389,587,8080,8088,8888]

  deny["A port typically used by an unencrypted protocol was detected."] {
      #Check for service
      ports := input.stage.context.manifests[_].spec.ports[_]
      any([object.get(ports,"port",null) == blockedPorts[_], 
            object.get(ports,"targetPort",null) == blockedPorts[_]])
  }{ 
      #Check for pod
      input.stage.context.manifests[_].spec.containers[_].ports[_].containerPort=blockedPorts[_]
  } { 
      #Check for pod template
      input.stage.context.manifests[_].spec.template.spec.containers[_].ports[_].containerPort=blockedPorts[_]
      }
  {{< /prism >}}

<br/>

- This policy checks whether or not the image being approved is on a list of imaged that are approved for deployment. The list of what images are approved must seperately be uploaded to the OPA data document

  {{< prism lang="rego" line-numbers="true" >}}
  package spinnaker.execution.stages.before.deployManifest

  deny["Manifest creates a pod from an image that is not approved by the security scanning process."] {
  #Check pod templates
      isImageUnApproved(input.stage.context.manifests[_].spec.template.spec.containers[_].image)
  } {#check pods
      isImageUnApproved(input.stage.context.manifests[_].spec.containers[_].image)
  }
  {#check pod template initContainers
      isImageUnApproved(input.stage.context.manifests[_].spec.template.spec.initContainers[_].image)
  }
  {#check pod initContainers
      isImageUnApproved(input.stage.context.manifests[_].spec.initContainers[_].image)
  }

  isImageUnApproved(image){    not isImageApproved(image) }
  isImageApproved(image){    image==data.approvedImages[_]}
  {{< /prism >}}

<br/>

- This policy prevents applications from deploying to namespaces that they are not whitelisted for.

  {{< prism lang="rego" line-numbers="true" >}}
  package spinnaker.execution.stages.before.deployManifest

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

Parameters related to the stage against which the policy is executing can be found in the [input.stage.context](#inputstagecontext) object.

### input.pipeline

| Key                                               | Type      | Description                                                                                                                                                          |
| ------------------------------------------------- | --------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `input.pipeline.application`                      | `string`  | The name of the application to which this pipeline belongs.                                                                                                          |
| `input.pipeline.authentication.allowedAccounts[]` | `string`  | The list of accounts to which the user this stage runs as has access.                                                                                          |
| `input.pipeline.authentication.user`              | `string`  | The Spinnaker user initiating the change.                                                                                                                            |
| `input.pipeline.buildTime`                        | `number`  |                                                                                                                                                                      |
| `input.pipeline.description`                      | `string`  | Description of the pipeline defined in the UI.                                                                                                                       |
| `input.pipeline.id`                               | `string`  | The unique ID of the pipeline.                                                                                                                                       |
| `input.pipeline.keepWaitingPipelines`             | `boolean` | If concurrent pipeline execution is disabled, then the pipelines that are in the waiting queue will get canceled when the next execution starts unless this is true. |
| `input.pipeline.limitConcurrent`                  | `boolean` | True if only 1 concurrent execution of this pipeline is allowed.                                                                                                     |
| `input.pipeline.name`                             | `string`  | The name of this pipeline.                                                                                                                                           |
| `input.pipeline.origin`                           | `string`  |                                                                                                                                                                      |
| `input.pipeline.partition`                        |           |                                                                                                                                                                      |
| `input.pipeline.paused`                           |           |                                                                                                                                                                      |
| `input.pipeline.pipelineConfigId`                 |           |                                                                                                                                                                      |
| `input.pipeline.source`                           |           |                                                                                                                                                                      |
| `input.pipeline.spelEvaluator`                    | `string`  | Which version of spring expression language is being used to evaluate SpEL.                                                                                          |
| `input.pipeline.stages[]`                         | `string`  | An array of the stages in the pipeline. Typically if you are writing a policy that examines multiple pipeline stages, it is better to write that policy against either the `opa.pipelines` package, or the `spinnaker.execution.pipelines.before package`. |
| `input.pipeline.startTime`                        | `number`  | Timestamp from when the pipeline was started.                                                                                                                        |
| `input.pipeline.startTimeExpiry`                  | `date `   | Unix epoch date at which the pipeline expires.                                                                                                                   |
| `input.pipeline.status`                           | `string`  | The status of the pipeline, typically 'RUNNING'.                                                                                                                     |
| `input.pipeline.templateVariables`                |           |                                                                                                                                                                      |
| `input.pipeline.type`                             | `string`  |                                                                                                                                                                      |

### input.pipeline.trigger

See [input.pipeline.trigger]({{< ref "input.pipeline.trigger.md" >}}) for more information.

### input.stage

See [`input.stage`]({{< ref "input.stage.md" >}}) for more information.

### input.stage.context

| Key                                                  | Type       | Description                                                                                                                                                                          |
| ---------------------------------------------------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `input.stage.context.account`                        | `string`   | What account is this stage deploying to. This is often used, for example, to check whether or not a policy applies to the given account.                                             |
| `input.stage.context.artifacts[]`                    | `array`    | See [artifacts]({{< ref "artifacts.md" >}}) for more information.                                                                                                                    |
| `input.stage.context.cloudProvider`                  | `string`   | The cloud provider for the account this is deploying to. Typically 'kubernetes'                                                                                                      |
| `input.stage.context.deploy.account.name`            | `string`   | The name of the account to which the stage is deploying.                                                                                                                             |
| `input.stage.context.kato.last.task.id.id`           | `string`   |                                                                                                                                                                                      |
| `input.stage.context.kato.result.expected`           | `boolean`  |                                                                                                                                                                                      |
| `input.stage.context.kato.task.firstNotFoundRetry`   | `number`   |                                                                                                                                                                                      |
| `input.stage.context.kato.task.lastStatus`           | `string`   |                                                                                                                                                                                      |
| `input.stage.context.kato.task.notFoundRetryCount`   | `number`   |                                                                                                                                                                                      |
| `input.stage.context.kato.task.terminalRetryCount`   | `number`   |                                                                                                                                                                                      |
| `input.stage.context.kato.tasks[]`                   | `string`   | This array contains the tasks that are executed during this stage. when each task finishes execution, the policy is rechecked with the status of each execution task updated.        |
| `input.stage.context.kato.tasks[].history[].phase`   | `string`   | The history of task phase changes.                                                                                                                                                   |
| `input.stage.context.kato.tasks[].history[].status`  | `string`   | The history of task status changes.                                                                                                                                                  |
| `input.stage.context.kato.tasks[].id`                | `string`   | The unique id of the task.                                                                                                                                                           |
| `input.stage.context.kato.tasks[].resultObjects[]`   | `{object}` | DO NOT USE. This contains numerous manifests/artifacts created by the execution of the stage. Typically policies should be written against the inputs to the stage, not its outputs. |
| `input.stage.context.kato.tasks[].status.completed`  | `boolean`  | True when the task has finished executing.                                                                                                                                           |
| `input.stage.context.kato.tasks[].status.failed`     | `boolean`  | Did the task attempt to execute and fail.                                                                                                                                            |
| `input.stage.context.kato.tasks[].status.retryable`  | `boolean`  | Can the task retry if execution fails.                                                                                                                                               |
| `input.stage.context.manifestArtifactAccount`        | `string`   | What artifact account are artifacts stored in.                                                                                                                                       |
| `input.stage.context.manifests[]`                    | `object`   | The raw kubernetes manifest being deployed. This is the element you should write policies against that involve the manifest.                                                         |
| `input.stage.context.moniker.app`                    | `string`   | The name of the application to which this pipeline belongs.                                                                                                                          |
| `input.stage.context.moniker.cluster`                | `string`   | The name of the cluster to which this stage is deploying.                                                                                                                            |
| `input.stage.context.outputs`                        | `object`   | DO NOT USE. This contains numerous manifests/artifacts created by the execution of the stage. Typically policies should be written against the inputs to the stage, not its outputs. |
| `input.stage.context.source`                         | `string`   | Specifies whether the manifest is coming from an artifact or was directly specified in the pipeline as text.                                                                         |
| `input.stage.context.stableManifests[].location`     | `string`   | The namespace of the stable manifest.                                                                                                                                                |
| `input.stage.context.stableManifests[].manifestName` | `string`   | The manifests name.                                                                                                                                                                  |
| `input.stage.context.user`                           | `string`   | the ID of the user that the stage runs as.                                                                                                                                           |

### input.user

This object provides information about the user performing the action. This can be used to restrict actions by role. See [input.user]({{< ref "input.user.md" >}}) for more information.
