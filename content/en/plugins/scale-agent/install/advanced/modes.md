---
title: Armory Scale Agent Service Deployment Modes
linkTitle: Service Deploy Modes
weight: 1
description: >
  Learn about Spinnaker Service mode, Agent mode, and Infrastructure mode - different approaches to deploying the Scale Agent service in your Kubernetes clusters.  
---

## Deployment modes

### Spinnaker Service mode

In this mode, you install the Armory Scale Agent service as a new Spinnaker service (`spin-armory-agent`), so you can configure it like other services.

{{< figure src="/images/scale-agent/in-cluster-mode.png" >}}

If you provision clusters automatically, the Armory Scale Agent service can dynamically reload accounts when `armory-agent.yaml` changes. You could, for example, configure accounts in a `ConfigMap` mounting to `/opt/armory/config/armory-agent-local.yaml`.  The Agent service reflects `ConfigMap` changes within seconds after [etcd](https://etcd.io/) sync.

**Pros**

- You do not have to configure external Network/Application Load Balancers to expose the Clouddriver gRPC port unless you want to use the Dynamic Accounts REST API.
- The Agent service can be managed centrally, so it is easy to get logs or configs and upgrade.

**Cons**

- You need to create kubeconfig file for each Kubernetes account.
- The API servers of the target clusters need to be accessible from the Armory CD (Spinnaker) cluster.

### Infrastructure mode

In infrastructure mode, multiple Agent service deployments handle different groups of Kubernetes clusters. Each service deployment is configured separately.

Keep the following pros and cons in mind when deciding if Infrastructure mode fits your use case:

**Pro**

- The Agent service can be managed centrally, so it is easy to get logs or configs and upgrade.

**Cons**

- You need to create a kubeconfig file for each Kubernetes account.
- The API servers of the target clusters need to be accessible from the Armory Scale Agent cluster.
- You need to expose gRPC port for Clouddriver through an external load balancer capable of handling HTTP/2 for gRPC communication.

{{< figure src="/images/scale-agent/agent-infra-mode.png" >}}

> Kubernetes account names must be unique across all your infrastructure. Clouddriver rejects new accounts with a name that matches a different cluster.

### Agent mode

In this mode, the Armory Scale Agent service acts as a piece of infrastructure. It authenticates  using a [service account token](https://kubernetes.io/docs/reference/access-authn-authz/authentication/#service-account-tokens). You use
[RBAC service account permissions](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#service-account-permissions) to configure what the Armory Scale Agent service is authorized to do.

If the Clouddriver plugin is unable to communicate with the Scale Agent service, the plugin attempts to reconnect during a defined grace period. If the plugin still can't communicate with the Scale Agent service after the grace period has expired, the plugin removes the cluster associated with that Scale Agent service from Armory CD.

In this mode, Armory CD never gets credentials, and Kubernetes account registration is dynamic.

Keep the following pros and cons in mind when deciding if Agent mode fits your use case:

**Pros**

- Agent mode is scalable because each agent only manages one Kubernetes account.
- Initial setup is easier because there's no need to create kubeconfig files.
- Target clusters can remain private or in separate VPCs from the Armory CD (Spinnaker) cluster because Scale Agents initiate the connection to Armory CD (Spinnaker).

**Cons**

- It is difficult to get agent logs, upgrade the Agent service, or check configurations because agents (often) run in third-party clusters that the DevOps team operating Armory CD (Spinnaker) doesn't have access.
- There is no authentication/authorization, so any team can start an Agent and register itself with Armory CD (Spinnaker). mTLS encryption can be used so that only agents with the right certificate can register. For information about how to configure mTLS, see {{< linkWithTitle "plugins/scale-agent/tasks/configure-mtls.md" >}}.
- You need to expose gRPC port for Clouddriver through an external load balancer capable of handling HTTP/2 for gRPC communication.

{{< figure src="/images/scale-agent/agent-mode.png" >}}



## Scalability

Each Agent can scale to hundreds of Kubernetes clusters. The more types of Kubernetes objects the Armory Scale Agent has to watch, the more memory it uses. Memory usage is bursty. You can control burst with `budget`. See [Agent options]({{< ref "plugins/scale-agent/reference/config/service-options#configuration-options" >}}) for configuration information.

Scaling the Armory Scale Agent can mean:

- Scaling the Kubernetes `Deployment` the Armory Scale Agent service is part of.
- Sharding Kubernetes clusters into groups that can in turn be scaled as described in [Infrastructure mode](#infrastructure-mode) above.

You can also mix deployment strategies if you have complex Kubernetes infrastructure and permissions:

- Run as a Spinnaker service
- Run in target clusters
- Run next to traditional Spinnaker Kubernetes accounts
