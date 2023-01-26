---
title: Armory Scale Agent Architecture
linkTitle: Architecture
description: >
  Learn about the key components that comprise the Armory Scale Agent for Spinnaker and Kubernetes. 
weight: 10
---

<!-- the purpose is to list the bare minimum IT security needs to know to approve use in a corporate env; modeled after the CDaaS arch page-->

## Key Components

### Scale Agent plugin for Clouddriver

The Scale Agent plugin runs inside Clouddriver and manages migrated accounts. The plugin does not engage in outbound communication. Through Clouddriver, the plugin exposes a REST API that you can use to dynamically migrate and manage Kubernetes accounts.

### Scale Agent service for Kubernetes

You Scale Agent service monitors your Kubernetes clusters and sends information to the Scale Agent plugin running inside Clouddriver.

The Agent service sends the following information about the cluster it is watching to the Clouddriver plugin:

- Account properties as configured in `kubernetes.accounts[]`.
- Kubernetes API server host, certificate fingerprint, version.
- All the Kubernetes objects it is configured to watch and has permissions to access. You can ignore certain Kubernetes [kinds](https://kubernetes.io/docs/concepts/overview/working-with-objects/kubernetes-objects/) (`kubernetes.accounts[].omitKinds`) or configure specific kinds to watch (`kubernetes.accounts[].kinds`).

> The Agent service always scrubs data from `Secret` in memory before it is sent and even before that data makes it onto the Armory Scale Agent's memory heap.


#### Kubernetes permissions for the service

The Agent service should have `ClusterRole` authorization if you need to deploy pods across your cluster. If you only deploy pods only to a single namespace, the service needs `Role` authorization. See {{< linkWithTitle "scale-agent/concepts/agent-permissions.md" >}} for detailed information.

## Communication and networking

Communication from the Scale Agent service to the Clouddriver plugin occurs over gRPC port 9091. Communication between the service and the plugin must be `http/2`. `http/1.1` is *not* compatible and causes communication issues between the Armory Agent service and Clouddriver plugin.  

Except for a local health check, the Agent service makes outbound calls only to the Clouddriver plugin over a single [gPRC](https://grpc.io/) connection. The connection can be over TLS or mTLS. You can terminate TLS:

1. On Clouddriver: in the case of running the Armory Scale Agent in Spinnaker Service mode or if declaring `spin-clouddriver-grpc` as a network load balancer.
2. On a gRPC proxy that directs request to the `spin-clouddriver-grpc` service.

The Clouddriver plugin uses the bidirectional communication channel to receive changes from Kubernetes accounts as well as send operations to the Armory Scale Agent service.

See the {{< linkWithTitle "agent-k8s-clustering.md" >}} page for detailed information.

## Security

Since the Armory Scale Agent service does outbound calls only, you can have Agent services running on-premises or in public clouds such as AWS, GCP, Azure, Oracle, or Alibaba.

What the Scale Agent service can do in the target cluster is limited by what it is running as:

- a `serviceAccount` in Agent mode
- a `kubeconfig` setup for infrastructure or Spinnaker service mode

Communications are secured with TLS and optionally mTLS.

## {{% heading "nextSteps" %}}

* [Quick Start]({{< ref "scale-agent/install/quickstart" >}})
* [Advanced Installation]({{< ref "scale-agent/install/advanced/_index.md" >}})


