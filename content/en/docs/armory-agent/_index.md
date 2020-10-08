---
title: "Armory Agent for Kubernetes"
linkTitle: "Armory Agent for K8s"
weight: 95
description: >
  The Armory Agent is a lightweight, scaleable service that monitors your Kubernetes infrastructure and streams changes back to Clouddriver.
---

* Massive scale for Kubernetes
  * The Agent only streams changes to Spinnaker<sup>TM</sup> in real time over a single TCP connection per cluster.
  * Caching and deployment scales to thousands of Kubernetes clusters for your largest applications.
  * The Agent optimizes how infrastructure information is cached, resulting in optimal performance for your end users or your pipelines.

* Flexible deployment model
  * Use the Agent alongside Spinnaker and benefit from performance improvements.
  * Use the Agent in the target cluster and get Kubernetes accounts automatically registered.

* Enhanced security
  * Keep your Kubernetes API servers private from Spinnaker.
  * Control what Spinnaker can do directly in a service account. No need to change Spinnaker.
  * Use a service account or store your `kubeconfig` files in one of the supported [secret engines]({{< ref "secrets#supported-secret-engines" >}}) engines or provision them via the method of your choice as Kubernetes secrets.
  * Only the information Spinnaker needs leaves the cluster.

Check out the Quick Start [guide]({{< ref "armory-agent-quick" >}}) to deploy the Agent on your Kubernetes infrastructure.

## Deployment topologies

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

## Communication with Clouddriver

The Armory Agent does outbound calls only, except for a local health check, over a single [gPRC](https://grpc.io/) connection to Clouddriver. The connection can be over TLS or mTLS. You can terminate TLS:

1. On Clouddriver: in the case of running the Agent in Spinnaker Service mode or if declaring `spin-clouddriver-grpc` as a network load balancer.
2. On a gRPC proxy that directs request to the `spin-clouddriver-grpc` service.

Spinnaker will use the bidirectional communication channel to receive changes from Kubernetes accounts as well as send operations to the Agent.

### Information sent by the Agent

The Agent sends the following information about the cluster it is watching back to Spinnaker:

- Account properties as configured in `kubernetes.accounts[]`.
- Kubernetes API server host, certificate fingerprint, version.
- All the Kubernetes objects it is configured to watch and has permissions to access. You can ignore certain Kubernetes [kinds](https://kubernetes.io/docs/concepts/overview/working-with-objects/kubernetes-objects/). (`kubernetes.accounts[].omitKinds`) or configure specific kinds to watch (`kubernetes.accounts[].kinds`).

> The Agent always scrubs data from `Secret` in memory before it is sent and even before that data makes it onto the Agent's memory heap.

## Security

Since the Armory Agent does outbound calls only, you can have agents running on-premises or in public clouds such as AWS, GCP, Azure, Oracle, or Alibaba.

What Spinnaker can do in the target cluster is limited by what it is running as:

- a `serviceAccount` in Agent mode
- a `kubeconfig` setup for infrastructure or Spinnaker service mode

Communications are secured with TLS and optionally mTLS.

Furthermore, in [Agent mode](#agent-mode), Spinnaker never gets credentials and account registration is dynamic.


## Scalability

Each Agent can scale to 100s of Kubernetes clusters. The more types of Kubernetes objects the Agent has to watch, the more memory it uses. Memory usage is bursty. You can control burst with `budget`. See [Agent options]({{< ref "agent-options/#options" >}})) for configuration information.

Scaling the Agent can mean:

- Scaling the Kubernetes `Deployment` it is part of.
- Sharding Kubernetes clusters into groups that can in turn be scaled as described in [Infrastructure mode](#infrastructure-mode) above.

You can also mix deployment strategies if you have complex Kubernetes infrastructure and permissions:

- Run as a Spinnaker service
- Run in target clusters
- Run next to traditional Spinnaker Kubernetes accounts.

