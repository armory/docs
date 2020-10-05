---
title: "Armory Agent for Kubernetes"
linkTitle: "Armory Agent"
weight: 4
description: >
  How the Armory Agent works
---

The Armory Agent is a lightweight service that connects back to Spinnaker's Clouddriver service and streams changes from the Kubernetes clusters it is configured to watch.

> The Agent connects back to a new port opened on Clouddriver using gRPC.


## Topologies

### Spinnaker service mode

In this mode, the Agent is installed as a new Spinnaker service (`spin-kubesvc`) and can be configured like other services.

![Spinnaker service mode](/images/armory-agent/in-cluster-mode.png)

If you provision clusters automatically, the Agent can dynamically reload accounts when `kubesvc.yaml` changes. You could, for example, configure accounts in a `configMap` mounting to `/opt/spinnaker/config/kubesvc-local.yaml`.  The Agent reflects `configMap` within seconds after [etcd](https://etcd.io/) sync.

### Infrastructure mode

In infrastructure mode, multiple Agent deployments handle different groups of Kubernetes clusters. Each deployment is configured separately.

![Infra mode](/images/armory-agent/agent-infra-mode.png)

> Account name must still be unique across all your infrastructure. Clouddriver will reject new accounts with a name that matches a different cluster.

### Agent mode

In this mode, the Agent acts as a piece of infrastructure. It is provisioned with a `serviceAccount` properly scoped to what you want Spinnaker to do. The cluster will disappear from Spinnaker after a grace period when the cluster is deleted or when the Agent is stopped.

![Agent mode](/images/armory-agent/agent-mode.png)


## Security

The first security principle is that the Armory Agent does outbound calls only, except for a local health check. This also means that you can have agents running on premise or in public clouds such as AWS, GCP, Azure, Oracle, or Alibaba.

What Spinnaker can do in the target cluster is limited by what it is running as:

- a `serviceAccount` in agent mode
- a `kubeconfig` setup for infrastructure or Spinnaker service mode

Communications are secured with TLS and optionally mTLS.

Furthermore, in **agent mode**, Spinnaker never gets credentials and account registration is dynamic.


## Communication with Clouddriver

The Agent communicates with Clouddriver over a single [gPRC](https://grpc.io/) connection. The connection can be over TLS (optionally mTLS). You can terminate TLS:

1. On Clouddriver: in the case of running the Agent in Spinnaker Service mode or if declaring `spin-clouddriver-grpc` as a network load balancer.
2. On a gRPC proxy that directs request to the `spin-clouddriver-grpc` service.

Spinnaker will use the bidirectional communication channel to receive changes from Kubernetes accounts as well as send operations to the Agent.

### Information sent by the Agent

The Agent will send the following information about the cluster it is watching back to Spinnaker:

- Account properties as configured in `kubernetes.accounts[]`.
- Kubernetes API server host, certificate fingerprint, version.
- All the Kubernetes objects it 1) is configured to do; and 2) has permissions to access. You can ignore certain Kubernetes kinds. (`kubernetes.accounts[].omitKinds`) or whitelist kinds to watch (`kubernetes.accounts[].kinds`).

> The Agent always scrubs data from `Secret` in memory before it is sent and even before that data makes it onto the Agent's memory heap.


## Scalability

Each Agent can scale to 100s of Kubernetes clusters. The more types of Kubernetes objects the Agent has to watch, the more memory it uses. Memory usage is bursty. You can control burst with `budget`. See [Agent options]({{< ref "agent-options/#options" >}})) for configuration information.

Scaling the Agent can mean:

- Scaling the Kubernetes `Deployment` it is part of.
- Sharding Kubernetes clusters into groups that can in turn be scaled (Infrastructure mode above).

You can also mix deployment strategies:

- Run as a Spinnaker service
- Run in target clusters
- Run next to traditional Spinnaker Kubernetes accounts.



