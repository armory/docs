---
title: "Armory Scale Agent for Spinnaker and Kubernetes Installation"
linkTitle: "Installation"
description: >
  Learn how to install the Armory Scale Agent for Spinnaker and Kubernetes in your Kubernetes, Spinnaker, and Armory Enterprise environments.
weight: 1
no_list: true
aliases:
  - /armory-enterprise/armory-agent/armory-agent-quick/
  - /docs/armory-agent/armory-agent-quick/
---

>This installation guide is designed for installing the Agent in a test environment. It does not include [mTLS configuration]({{< ref "agent-mtls" >}}), so the Agent service and plugin do not communicate securely.

## {{% heading "prereq" %}}

* You have read the Scale Agent [overview]({{< ref "scale-agent" >}}).
* You deployed Armory Enterprise using the [Armory Operator and Kustomize patches]({{< ref "op-config-kustomize" >}}).
* You have configured Clouddriver to use MySQL or PostgreSQL. See the {{< linkWithTitle "clouddriver-sql-configure.md" >}} guide for instructions. The Agent plugin uses the SQL database to store cache data.
* For Clouddriver pods, you have mounted a service account with permissions to `list` and `watch` the Kubernetes kind `Endpoint` in namespace where Clouddriver is running.

   ```yaml
   apiVersion: rbac.authorization.k8s.io/v1
   kind: Role
   metadata:
     name: spin-sa
   rules:
     - apiGroups:
         - ""
       resources:
         - endpoints
       verbs:
         - list
         - watch
    ```

* Verify that there is a Kubernetes Service with prefix name `spin-clouddriver` (configurable) routing HTTP traffic to Clouddriver pods, having a port with name `http` (configurable). This Service is created automatically when installing Armory Enterprise using the Armory Operator.

* You have an additional Kubernetes cluster to serve as your deployment target cluster.

### Networking requirements

Communication from the Agent service to the Clouddriver plugin occurs over gRPC port 9091. Communication between the service and the plugin must be `http/2`. `http/1.1` is *not* compatible and causes communication issues between the Agent service and Clouddriver plugin.  

Consult the {{< linkWithTitle "agent-k8s-clustering.md" >}} page for details on how the Agent plugin communicates with Clouddriver instances in Kubernetes.

### Compatibility matrix

{{< include "agent/agent-compat-matrix.md" >}}

## Installation overview

In this guide, you deploy the Agent service to your target cluster.

Installation steps:

1. Install the Clouddriver plugin. You do this in the cluster where you are running Armory Enterprise.

   1. Create the plugin manifest as a Kustomize patch.
   1. Create a LoadBalancer service Kustomize patch to expose the plugin on gRPC port `9091`.
   1. Apply the manifests.

1. Install the Agent service using a Helm chart or using `kubectl`.


## {{% heading "nextSteps" %}}

Install the Clouddriver plugin [using kubectl]({{< ref "scale-agent/install/install-agent-plugin" >}}).
</br>
</br>