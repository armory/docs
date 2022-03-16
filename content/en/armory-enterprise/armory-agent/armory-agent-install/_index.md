---
title: "Armory Agent for Kubernetes Installation"
linkTitle: "Installation"
description: >
  Learn how to install the Armory Agent in your Kubernetes and Armory Enterprise environments.
weight: 30
no_list: true
aliases:
  - /armory-enterprise/armory-agent/armory-agent-quick/
  - /docs/armory-agent/armory-agent-quick/
---
![Proprietary](/images/proprietary.svg)

>This installation guide is designed for installing the Agent in a test environment. It does not include [mTLS configuration]({{< ref "agent-mtls" >}}), so the Agent service and plugin do not communicate securely.

## {{% heading "prereq" %}}

* You have read the Armory Agent [overview]({{< ref "armory-agent" >}}).
* You deployed Armory Enterprise using the [Armory Operator and Kustomize patches]({{< ref "op-config-kustomize" >}}).
* You have configured Clouddriver to use MySQL or PostgreSQL. See the {{< linkWithTitle "clouddriver-sql-configure.md" >}} guide for instructions. The Agent plugin uses the SQL database to store cache data.
* For Clouddriver pods, you have mounted a service account with permissions to `list` and `watch` the Kubernetes kind `Endpoint` in namespace where Clouddriver is running.
* Verify that there is a Kubernetes Service Account with prefix name `spin-clouddriver` (configurable) routing HTTP traffic to Clouddriver pods, having a port with name `HTTP` (configurable). This Service Account is created automatically when installing Armory Enterprise using the Armory Operator. If you need to create your own Service Account, ensure it has a minimum set of permissions needed to watch Endpoints:

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

* You have an additional Kubernetes cluster to serve as your deployment target cluster.

### Networking requirements

Communication from the Agent service to the Clouddriver plugin occurs over gRPC port 9091. Communication between the service and the plugin must be `http/2`. `http/1.1` is *not* compatible and causes communication issues between the Agent service and Clouddriver plugin.  

### Compatibility matrix

{{< include "agent/agent-compat-matrix.md" >}}

## How Kubernetes clustering works

{{< figure src="/images/armory-agent/k8s-clustering.png"  alt="Kubernetes clustering"  height="75%" width="75%" >}}

At startup, Clouddriver registers a watch for the kind `Endpoints` in the Kubernetes cluster where it is running for the namespace where Clouddriver is running. Objects of kind `Endpoints` are automatically generated based on a Kubernetes Service. The plugin knows that there's a Clouddriver Service for routing HTTP traffic to Clouddriver pods (usually named `spin-clouddriver`). This means that the Clouddriver pod needs to mount a Kubernetes Service Account that has permissions to list and watch the kind `Endpoints` in the current namespace. The Agent plugin does the equivalent of these calls at startup:

```bash
kubectl auth can-i list endpoints
kubectl auth can-i watch endpoints
```

If permissions are in place, the plugin then does the equivalent of this call:

```bash
kubectl get endpoints
```

From the returned collection, the plugin filters the entries based on these conditions:

1. The endpoint Name should have the prefix `spin-clouddriver`. This is configurable and is a prefix to be able to match several entries like the ones used in HA.
1. Each entry should have a port named `HTTP`, which is configurable. This is to be able to differentiate between the port that Clouddriver uses to receive REST requests and the port it uses to listen for gRPC connections from Agent.

Information about discovered Clouddriver instances is kept in memory on each Clouddriver pod and is automatically updated by the watch mechanism. No polling is needed.  The Kubernetes API server notifies the plugin when there are any changes.

#### Operation request and response forwarding

When a Clouddriver instance receives an operation for an account or Agent that is registered to a different Clouddriver instance, the plugin uses a combination of a database table and an in-memory map to determine where to forward the operation. Forwarding is done via REST requests.

#### Exposed endpoints

1. `GET <clouddriver host:port>/armory/clouddrivers`

   Sample response:

   ```json
   [
    {
     baseUrl: "http://10.0.15.246:7002",
     id: "spin-clouddriver-766c678c6c-scg68",
     lastUpdated: "2022-02-23T20:41:39.333Z",
     ready: true
    }
   ]
   ```

   The field `ready` matches the column `Ready` of `kubectl -n <spinnaker ns> get pods` for Clouddriver pods.

1. `POST <clouddriver host:port>/armory/agent/operations`

   Sample response:

   ```json
   {
    "operation": "<toString() of protobuf Operation object>"
   }
   ```

1. `POST <clouddriver host:port>/armory/agent/operationresults`

   Sample response:

   ```json
   {
    "result": "<toString() of protobuf OperationResult object>"
   }
   ```

## Installation overview

In this guide, you deploy the Agent service to your target cluster.

Installation steps:

1. Install the Clouddriver plugin. You do this in the cluster where you are running Armory Enterprise.

   1. Create the plugin manifest as a Kustomize patch.
   1. Create a LoadBalancer service Kustomize patch to expose the plugin on gRPC port `9091`.
   1. Apply the manifests.

1. Install the Agent service using a Helm chart or using `kubectl`.


## {{% heading "nextSteps" %}}

Install the Clouddriver plugin [using kubectl]({{< ref "install-agent-plugin" >}}).
</br>
</br>