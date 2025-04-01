---
title: Overview and Use Cases
linkTitle: Overview & Use Cases
weight: 1
description: >
  TBD
---

![Proprietary](/images/proprietary.svg)

## Overview of the Scale Agent

The [Scale Agent for Spinnaker and Kubernetes](https://www.armory.io/products/scale-agent-for-spinnaker-kubernetes/) consists of a lightweight service that you deploy on Kubernetes and a plugin that you install into Clouddriver. With these, you can scale Kubernetes deployments to limitless clusters and namespaces with minimal latency, accelerating your pipeline execution times.

The Scale Agent works with Armory Continuous Deployment v2.26+ and Spinnaker v1.26+. The following Scale Agent features require Spinnaker 1.28+/Armory CD 2.28+ with [Clouddriver Account Management]() enabled:

* [Automated scanning]({{< ref "plugins/scale-agent/concepts/dynamic-accounts#automatic-account-migration" >}}) for newly created accounts in Clouddriver and migrating those accounts to Scale Agent management
* [Intercepting and processing requests]({{< ref "plugins/scale-agent/concepts/dynamic-accounts#clouddriver-account-management-api-request-interception" >}}) sent to Clouddriver's `<GATE-URL>/credentials` endpoint

## Use cases

{{% cardpane %}}
{{% card header="**High Scale Kubernetes Deployment to Match Your Architecture**" %}}

{{< figure src="armory-k8s.png" caption="<center><strong>Deployment Modes</strong></center>">}}

Flexible modes that suit your platform and infrastructure: centralized, distributed in the target clusters, or within the Spinnaker cluster. [Learn more]().

Control whether your account management agent operates in a performant failover or more stable distributed operations.

{{% /card %}}

{{% card header="**Self-Serve Kubernetes Infrastructure**" %}}

{{< figure src="dynamic-accounts.webp" caption="<center><strong>Dynamic Accounts</strong></center>" >}}

Empower your users and their teams by enabling account management at the team level as well as the ability to add new accounts, on the fly, without restarting your Spinnaker services.

<table width="100%">
<tr>
<td>
Try it out
</td>
<td>
Learn more
</td>
</tr>
</table>
{{% /card %}}
{{% /cardpane %}}



### Advantages of using the Armory Scale Agent

**Scalability**
* Caching and deployment scales to thousands of Kubernetes clusters for your largest applications.
* By leveraging the Kubernetes `watch` mechanism, the Armory Scale Agent detects changes to Kubernetes and streams them in real time over a single TCP connection per cluster to Spinnaker<sup>TM</sup>.
* The Agent optimizes how infrastructure information is cached, making _Force Cache Refresh_ almost instantaneous. This means optimal performance for your end users and your pipeline executions.

**Security**
* Keep your Kubernetes API servers private from Spinnaker.
* Only the information Spinnaker needs leaves the cluster.
* Decentralize your account management. Using Kubernetes Service Accounts, teams control what Spinnaker can do. Add or remove accounts in real time, and then use them without restarting Spinnaker.
* Use Kubernetes Service Accounts or store your `kubeconfig` files in one of the supported [secret engines]({{< ref "continuous-deployment/armory-admin/secrets" >}}), or provision them via the method of your choice as Kubernetes secrets.
* Secure plugin-service communication by [configuring mTLS]({{< ref "plugins/scale-agent/tasks/configure-mtls" >}}).

**Usability**
* Use the Armory Scale Agent alongside Spinnaker and benefit from performance improvements.
* Use YAML, a HELM chart, or a Kustomize template to inject the Armory Scale Agent into newly provisioned Kubernetes clusters and immediately make those clusters software deployment targets.
* Use the Armory Scale Agent with little operational overhead or changes in the way you currently manage Spinnaker.
* Integrate [Prometheus]({{< ref "plugins/scale-agent/tasks/service-monitor" >}}) and [Vault]({{< ref "plugins/scale-agent/tasks/service-vault" >}}).

**Kubernetes Account Management**
* [Configure accounts statically]({{< ref "plugins/scale-agent/install/advanced/config-service" >}}) in the Scale Agent service before deployment either in a ConfigMap or in an `armory-agent.yml` file in the pod. If you provision clusters automatically, the Armory Scale Agent service can dynamically reload accounts when the ConfigMap or `armory-agent.yaml` changes. You could, for example, configure accounts in a `ConfigMap` mounting to `/opt/armory/config/armory-agent-local.yaml`.  The Scale Agent service reflects `ConfigMap` changes within seconds after etcd sync.
* Get Kubernetes accounts automatically registered when you deploy the Armory Scale Agent in a target cluster.
* [Manually or automatically migrate Clouddriver Kubernetes accounts]({{< ref "plugins/scale-agent/concepts/dynamic-accounts" >}}) to the Scale Agent using _Dynamic Accounts_.

## How to get started using the Scale Agent

* **New Spinnaker instance**: {{< linkWithTitle "plugins/scale-agent/install/quickstart.md" >}} shows you how to use the Spinnaker Operator and Kustomize to install Spinnaker and the Scale Agent in the same Kubernetes cluster and namespace for testing the Scale Agent's features.
* **Existing Spinnaker instance**: {{< linkWithTitle "plugins/scale-agent/install/install-spin.md" >}} shows how to use Halyard to install the plugin and `kubectl` to apply the service's manifests. You deploy the Scale Agent service to the same cluster and namespace as Spinnaker.
* **Existing Armory Continuous Deployment instance**: {{< linkWithTitle "plugins/scale-agent/install/install-armory" >}} shows you how to use the Armory Operator and Kustomize to install the Scale Agent components. You deploy the Scale Agent service to the same cluster and namespace as Armory CD.

>For installation into existing instances, note that your Clouddriver service must use a MySQL-compatible database. If yours doesn't, see the {{< linkWithTitle "clouddriver-sql-configure.md" >}} guide for instructions.


## Supported Spinnaker and Armory CD versions

{{< include "plugins/scale-agent/agent-compat-matrix.md" >}}

You can find a full list of previous releases in the [artifactory](https://armory.jfrog.io/artifactory/manifests/).



## {{% heading "nextSteps" %}}

* {{< linkWithTitle "plugins/scale-agent/concepts/architecture.md" >}}
* {{< linkWithTitle "plugins/scale-agent/install/quickstart.md" >}}
* {{< linkWithTitle "plugins/scale-agent/install/install-spin.md" >}}
* {{< linkWithTitle "plugins/scale-agent/install/install-armory.md" >}}
