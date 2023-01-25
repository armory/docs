---
title: "Armory Scale Agent for Spinnaker and Kubernetes"
weight: 1
no_list: true
description: >
  The Armory Scale Agent for Spinnaker and Kubernetes is a lightweight, scalable service that monitors your Kubernetes infrastructure and streams changes back to Spinnaker's Clouddriver service.
---
![Proprietary](/images/proprietary.svg)

## What is the Scale Agent?

The Armory Scale Agent for Spinnaker and Kubernetes consists of a lightweight service that you deploy on Kubernetes and a plugin that you install into Clouddriver.

The Armory Scale Agent is compatible with Armory CD and open source Spinnaker.

### Advantages of using the Armory Scale Agent

* Scalability
  * Caching and deployment scales to thousands of Kubernetes clusters for your largest applications.
  * By leveraging the Kubernetes `watch` mechanism, the Armory Scale Agent detects changes to Kubernetes and streams them in real time over a single TCP connection per cluster to Spinnaker<sup>TM</sup>.
  * The Agent optimizes how infrastructure information is cached, making _Force Cache Refresh_ almost instantaneous. This means optimal performance for your end users and your pipeline executions.

* Security
  * Keep your Kubernetes API servers private from Spinnaker.
  * Only the information Armory CD needs leaves the cluster.
  * Decentralize your account management. Using Kubernetes Service Accounts, teams control what Spinnaker can do. Add or remove accounts in real time. and then use them without restarting Spinnaker.
  * Use Kubernetes Service Accounts or store your `kubeconfig` files in one of the supported [secret engines]({{< ref "continuous-deployment/armory-admin/secrets" >}}), or provision them via the method of your choice as Kubernetes secrets.


* Usability
  * Use the Armory Scale Agent alongside Armory CD and benefit from performance improvements.
  * Use the Armory Scale Agent in a target cluster and get Kubernetes accounts automatically registered.
  * Use YAML, a HELM chart, or a Kustomize template to inject the Armory Scale Agent into newly provisioned Kubernetes clusters, and immediately make those clusters software deployment targets.
  * Use the Armory Scale Agent with little operational overhead or changes in the way you currently manage Armory CD.

Check out the installation [guide]({{< ref "scale-agent/install" >}}) for how to deploy the Armory Scale Agent components in Armory CD and in your Kubernetes infrastructure.

## Deployment modes

### Agent mode

In this mode, the Armory Scale Agent service acts as a piece of infrastructure. It authenticates  using a [service account token](https://kubernetes.io/docs/reference/access-authn-authz/authentication/#service-account-tokens). You use
[RBAC service account permissions](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#service-account-permissions) to configure what the Armory Scale Agent service is authorized to do.

If the Clouddriver plugin is unable to communicate with the Armory Scale Agent service, the plugin attempts to reconnect during a defined grace period. If the plugin still can't communicate with the Armory Scale Agent service after the grace period has expired, the cluster associated with the Armory Scale Agent service is removed from Armory CD.

Keep the following pros and cons in mind when deciding if Agent mode fits your use case:

**Pros**

- Agent mode is scalable because each agent only manages one Kubernetes account.
- Initial setup is easier because there's no need to create kubeconfig files.
- Target clusters can remain private or in separate VPCs from the Armory CD (Spinnaker) cluster because agents initiate the connection to Armory CD (Spinnaker).

**Cons**

- It is difficult to get agent logs, upgrade Agent, or check configurations because agents (often) run in third-party clusters that the DevOps team operating Armory CD (Spinnaker) doesn't have access.
- There is no authentication/authorization, so any team can start an Agent and register itself with Armory CD (Spinnaker). mTLS encryption can be used so that only agents with the right certificate can register. For information about how to configure mTLS, see {{< linkWithTitle "scale-agent/tasks/agent-mtls.md" >}}.
- You need to expose gRPC port for Clouddriver through an external load balancer capable of handling HTTP/2 for gRPC communication.

![Agent mode](/images/armory-agent/agent-mode.png)

### Infrastructure mode

In infrastructure mode, multiple Agent service deployments handle different groups of Kubernetes clusters. Each service deployment is configured separately.

Keep the following pros and cons in mind when deciding if Infrastructure mode fits your use case:

**Pro**

- Agent can be managed centrally, so it is easy to get logs or configs and upgrade.

**Cons**

- You need to create kubeconfig file for each account.
- The API servers of the target clusters need to be accessible from the Armory Scale Agent cluster.
- You need to expose gRPC port for Clouddriver through an external load balancer capable of handling HTTP/2 for gRPC communication.

![Infra mode](/images/armory-agent/agent-infra-mode.png)

> Account name must still be unique across all your infrastructure. Clouddriver will reject new accounts with a name that matches a different cluster.

### Spinnaker service mode

In this mode, the Armory Scale Agent is installed as a new Spinnaker service (`spin-armory-agent`) and can be configured like other services.

![Spinnaker service mode](/images/armory-agent/in-cluster-mode.png)

If you provision clusters automatically, the Armory Scale Agent service can dynamically reload accounts when `armory-agent.yaml` changes. You could, for example, configure accounts in a `ConfigMap` mounting to `/opt/armory/config/armory-agent-local.yaml`.  The Agent service reflects `ConfigMap` changes within seconds after [etcd](https://etcd.io/) sync.

**Pros**

- You do not have to configure external Network/Application Load Balancers to expose the Clouddriver gRPC port.
- Agent can be managed centrally, so it is easy to get logs or configs and upgrade.

**Cons**

- You need to create kubeconfig file for each account.
- The API servers of the target clusters need to be accessible from the Armory CD (Spinnaker) cluster.


## Communication with Clouddriver

The Agent service does outbound calls only, except for a local health check, over a single [gPRC](https://grpc.io/) connection to the Clouddriver plugin. The connection can be over TLS or mTLS. You can terminate TLS:

1. On Clouddriver: in the case of running the Armory Scale Agent in Spinnaker Service mode or if declaring `spin-clouddriver-grpc` as a network load balancer.
2. On a gRPC proxy that directs request to the `spin-clouddriver-grpc` service.

The Clouddriver plugin uses the bidirectional communication channel to receive changes from Kubernetes accounts as well as send operations to the Armory Scale Agent service.

### Information sent by the Armory Scale Agent service

The Agent service sends the following information about the cluster it is watching to the Clouddriver plugin:

- Account properties as configured in `kubernetes.accounts[]`.
- Kubernetes API server host, certificate fingerprint, version.
- All the Kubernetes objects it is configured to watch and has permissions to access. You can ignore certain Kubernetes [kinds](https://kubernetes.io/docs/concepts/overview/working-with-objects/kubernetes-objects/) (`kubernetes.accounts[].omitKinds`) or configure specific kinds to watch (`kubernetes.accounts[].kinds`).

> The Agent service always scrubs data from `Secret` in memory before it is sent and even before that data makes it onto the Armory Scale Agent's memory heap.

## Security

Since the Armory Scale Agent service does outbound calls only, you can have Agent services running on-premises or in public clouds such as AWS, GCP, Azure, Oracle, or Alibaba.

What Armory CD can do in the target cluster is limited by what it is running as:

- a `serviceAccount` in Agent mode
- a `kubeconfig` setup for infrastructure or Spinnaker service mode

Communications are secured with TLS and optionally mTLS.

Furthermore, in [Agent mode](#agent-mode), Armory CD never gets credentials, and account registration is dynamic.

## Scalability

Each Agent can scale to hundreds of Kubernetes clusters. The more types of Kubernetes objects the Armory Scale Agent has to watch, the more memory it uses. Memory usage is bursty. You can control burst with `budget`. See [Agent options]({{< ref "scale-agent/reference/config/agent-options#configuration-options" >}})) for configuration information.

Scaling the Armory Scale Agent can mean:

- Scaling the Kubernetes `Deployment` the Armory Scale Agent service is part of.
- Sharding Kubernetes clusters into groups that can in turn be scaled as described in [Infrastructure mode](#infrastructure-mode) above.

You can also mix deployment strategies if you have complex Kubernetes infrastructure and permissions:

- Run as a Spinnaker service
- Run in target clusters
- Run next to traditional Spinnaker Kubernetes accounts

## Supported Spinnaker and Armory CD versions

{{< include "agent/agent-compat-matrix.md" >}}

You can find a full list of previous releases in the [artifactory](https://armory.jfrog.io/artifactory/manifests/).

## Docs organization

If you're familiar with the Kubernetes docs, you may notice that the Armory Scale Agent docs are organized in a similar fashion:

* [Installation]({{< ref "scale-agent/install" >}}): This section contains guides for installing and uninstalling the Armory Scale Agent.
* [Concepts]({{< ref "scale-agent/concepts" >}}): These pages explain aspects of the Armory Scale Agent. The content is objective, containing architecture, definitions, rules, and guidelines. Rather than containing a sequence of steps, these pages link to related tasks and tutorials.
* [Tasks]({{< ref "scale-agent/tasks" >}}): Task pages show you how to do a single procedure by following a short series of steps that produce an intended outcome. Task content expects a minimum level of background knowledge, and each page links to conceptual content that you should be familiar with before you begin the task.
* [Reference]({{< ref "scale-agent/reference" >}}): This section contains both manually maintained and autogenerated reference material for configuring the plugin and service and using the APIs.
* [Release Notes]({{< ref "scale-agent/release-notes" >}})


</br>
</br>
