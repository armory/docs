---
title: Communication With Clouddriver Instances in Kubernetes
linkTitle: Clouddriver Communication
weight: 50
description: >
  Learn how the Agent and Clouddriver instances communicate in a Kubernetes cluster.
---

## How the Agent plugin communicates with Clouddriver instances

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
1. Each entry should have a port named `http`, which is configurable. This is to be able to differentiate between the port that Clouddriver uses to receive REST requests and the port it uses to listen for gRPC connections from Agent.

Information about discovered Clouddriver instances is kept in memory on each Clouddriver pod and is automatically updated by the watch mechanism. No polling is needed.  The Kubernetes API server notifies the plugin when there are any changes.

## Operation request and response forwarding

When a Clouddriver instance receives an operation for an account or Agent that is registered to a different Clouddriver instance, the plugin uses a combination of a database table and an in-memory map to determine where to forward the operation. Forwarding is done via REST requests.

### Exposed endpoints

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

   Sample request body:

   ```json
   {
    "operation": "<toString() of protobuf Operation object>"
   }
   ```

1. `POST <clouddriver host:port>/armory/agent/operationresults`

   Sample request body:

   ```json
   {
    "result": "<toString() of protobuf OperationResult object>"
   }
   ```

