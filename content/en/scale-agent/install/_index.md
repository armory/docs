---
title: "Armory Scale Agent for Spinnaker and Kubernetes Installation"
linkTitle: "Installation"
description: >
  Learn how to install the Armory Scale Agent for Spinnaker and Kubernetes in your Kubernetes, Spinnaker, and Armory CD environments.
weight: 1
no_list: true
---

>This installation guide is designed for installing the Armory Agent in a test environment. It does not include [mTLS configuration]({{< ref "agent-mtls" >}}), so the Armory Agent service and plugin do not communicate securely.

## {{% heading "prereq" %}}

* You have read the Scale Agent [overview]({{< ref "scale-agent" >}}).
* You have configured Clouddriver to use MySQL or PostgreSQL. See the {{< linkWithTitle "clouddriver-sql-configure.md" >}} guide for instructions. The Scale Agent plugin uses the SQL database to store cache data.
* For Clouddriver pods, you have mounted a service account with permissions to `list` and `watch` the Kubernetes kind `Endpoint` in the namespace where Clouddriver is running.

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

* Verify that there is a Kubernetes Service with prefix name `spin-clouddriver` (configurable) routing HTTP traffic to Clouddriver pods, having a port with name `http` (configurable). This service is created automatically when installing Armory CD using the Armory Operator.

* You have an additional Kubernetes cluster to serve as your deployment target cluster.

### Networking requirements

Communication from the Scale Agent service to the Clouddriver plugin occurs over gRPC port 9091. Communication between the service and the plugin must be `http/2`. `http/1.1` is *not* compatible and causes communication issues between the Armory Agent service and Clouddriver plugin.  

Consult the {{< linkWithTitle "agent-k8s-clustering.md" >}} page for details on how the Scale Agent plugin communicates with Clouddriver instances in Kubernetes.

### Compatibility matrix

{{< include "agent/agent-compat-matrix.md" >}}

## Installation methods

There are a variety of ways to install the Scale Agent components in your Armory CD environment. Choose the method that best suits your process.

1. Use the Armory Operator with Kustomize to install the plugin. Use the provided manifests to install the service and apply with `kubectl`.
1. Use the Armory Operator with Kustomize to install the plugin. Use the Helm chart to install the service.
1. Use the Armory Operator with Kustomize to install both the plugin and the service.

If you are using open source Spinnaker, you have the following options:

1. Use Halyard (clouddriver-local.yaml) to install the plugin. Use the provided manifests to install the service and apply with `kubectl`.
1. Use Halyard (clouddriver-local.yaml) to install the plugin. Use the Helm chart to install the service.
1. Use the Spinnaker Operator and one of the Armory Operator methods, with slight modifications.

Regardless of method, you should install the plugin before installing the service.

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "scale-agent/install/install-agent-plugin.md" >}}.
</br>
</br>