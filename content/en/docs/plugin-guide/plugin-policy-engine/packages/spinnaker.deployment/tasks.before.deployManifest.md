---
title: "spinnaker.deployment.tasks.before.deployManifest"
linkTitle: "spinnaker.deployment.tasks.before.deployManifest"
weight: 10
description: "WHO AM I?"
---


## Example Payload

<details><summary>Click to expand</summary>

```json
{
  "input": {
    "deploy": {
      "account": "spinnaker",
      "credentials": "spinnaker",
      "enableTraffic": true,
      "events": [],
      "manifest": null,
      "manifestArtifact": null,
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
        "cluster": "deployment hostname",
        "detail": null,
        "sequence": null,
        "stack": null
      },
      "namespaceOverride": null,
      "optionalArtifacts": [],
      "requiredArtifacts": [],
      "services": null,
      "source": "text",
      "strategy": null,
      "versioned": null
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
| `input.deploy.account` | `string` |
| `input.deploy.credentials` | `string` |
| `input.deploy.enableTraffic` | `boolean` |
| `input.deploy.manifest` | ` ` |
| `input.deploy.manifestArtifact` | ` ` |
| `input.deploy.manifests[].*` | `*` | The entire Kubernetest manifest that is to be deployed. |
| `input.deploy.moniker.app` | `string` |
| `input.deploy.moniker.cluster` | `string` |
| `input.deploy.moniker.detail` | ` ` |
| `input.deploy.moniker.sequence` | ` ` |
| `input.deploy.moniker.stack` | ` ` |
| `input.deploy.namespaceOverride` | ` ` |
| `input.deploy.services` | ` ` |
| `input.deploy.source` | `string` |
| `input.deploy.strategy` | ` ` |
| `input.deploy.versioned` | ` ` |
