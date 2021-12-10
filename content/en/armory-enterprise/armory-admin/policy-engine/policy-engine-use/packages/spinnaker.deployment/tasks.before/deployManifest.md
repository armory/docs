---
title: "spinnaker.deployment.tasks.before.deployManifest"
linkTitle: "deployManifest"
description: "Policy checks that run immediately before a task deploys a Spinnaker manifest."
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

This example prevents deploying of pods, pod templates (deployments/jobs/replicasets) and services that use the following services: HTTP, FTP, TELNET, POP3, NNTP, IMAP, LDAP, SMTP

{{< prism lang="rego" line-numbers="true" >}}
package spinnaker.deployment.tasks.before.deployManifest

blockedPorts := [20,21,23,80,110,119,143,389,587,8080,8088,8888]

deny["A port typically used by an unencrypted protocol was detected."] {
    #Check for service
    ports := input.deploy.manifests[_].spec.ports[_]
    any([object.get(ports,"port",null) == blockedPorts[_], 
           object.get(ports,"targetPort",null) == blockedPorts[_]])
}{ 
    #Check for pod
    input.deploy.manifests[_].spec.containers[_].ports[_].containerPort=blockedPorts[_]
} { 
    #Check for pod template
    input.deploy.manifests[_].spec.template.spec.containers[_].ports[_].containerPort=blockedPorts[_]
    }
{{< /prism >}}

This example requires that the annotations 'owner' and 'app' are applied on all deployed infrastructure.

{{< prism lang="rego" line-numbers="true" >}}
package spinnaker.deployment.tasks.before.deployManifest

required_annotations:=["app","owner"]

deny["Manifest is missing a required annotation"] {
    annotations :=input.deploy.manifests[_].metadata.annotations 

    # Use object.get to check if data exists
    object.get(annotations,required_annotations[_],null)==null
}
{{< /prism >}}

## Keys

| Key                              | Type      | Description                                                                                                    |
| -------------------------------- | --------- | -------------------------------------------------------------------------------------------------------------- |
| `input.deploy.account`           | `string`  | The account being deployed to.                                                                       |
| `input.deploy.credentials`       | `string`  | The credentials to use to access the account.                                                                  |
| `input.deploy.enableTraffic`     | `boolean` | Allow Armory Enterprise to associate each ReplicaSet deployed in this stage with one or more services and manage traffic based on your selected rollout strategy options. |
| `input.deploy.manifest`          | `[array]` | An array of the manifests being deployed                                                                       |
| `input.deploy.manifestArtifact`  |           | The name of the artifact from which the manifest should be read.                                               |
| `input.deploy.manifests[].*`     | `*`       | The entire Kubernetes  manifest to be deployed.                                                                |
| `input.deploy.moniker.app`       | `string`  | The name of the application being deployed                                                                     |
| `input.deploy.moniker.cluster`   | `string`  | The name of the cluster you are deploying to.                                                                  |
| `input.deploy.moniker.detail`    |           |                                                                                                                |
| `input.deploy.moniker.sequence`  |           |                                                                                                                |
| `input.deploy.moniker.stack`     |           |                                                                                                                |
| `input.deploy.namespaceOverride` |           | The namespace the job should deploy to                                                                         |
| `input.deploy.services`          |           | The services that are having their traffic managed, if any.                                                    |
| `input.deploy.source`            | `string`  |                                                                                                                |
| `input.deploy.strategy`          |           | The rollout strategy tells Armory Enterprise what to do with the previous version(s) of the ReplicaSet in the cluster. |
| `input.deploy.versioned`         |           |                                                                                                                |
