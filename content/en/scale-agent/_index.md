---
title: "Armory Scale Agent for Spinnaker and Kubernetes"
weight: 1
no_list: true
description: >
  The Armory Scale Agent for Spinnaker and Kubernetes is a lightweight, real-time agent that scales deployment execution operations from your Spinnaker or Armory Continuous Deployment instance to all of your Kubernetes clusters.
---
![Proprietary](/images/proprietary.svg)

## Overview of the Scale Agent

The [Scale Agent for Spinnaker and Kubernetes](https://www.armory.io/products/scale-agent-for-spinnaker-kubernetes/) consists of a lightweight service that you deploy on Kubernetes and a plugin that you install into Clouddriver. With these, you can scale Kubernetes deployments to limitless clusters and namespaces with minimal latency, accelerating your pipeline execution times. 

The Scale Agent works with Armory Continuous Deployment v2.26+ and Spinnaker v1.26+. 

### Advantages of using the Armory Scale Agent

* **Scalability**
  * Caching and deployment scales to thousands of Kubernetes clusters for your largest applications.
  * By leveraging the Kubernetes `watch` mechanism, the Armory Scale Agent detects changes to Kubernetes and streams them in real time over a single TCP connection per cluster to Spinnaker<sup>TM</sup>.
  * The Agent optimizes how infrastructure information is cached, making _Force Cache Refresh_ almost instantaneous. This means optimal performance for your end users and your pipeline executions.

* **Security**
  * Keep your Kubernetes API servers private from Spinnaker.
  * Only the information Spinnaker needs leaves the cluster.
  * Decentralize your account management. Using Kubernetes Service Accounts, teams control what Spinnaker can do. Add or remove accounts in real time, and then use them without restarting Spinnaker.
  * Use Kubernetes Service Accounts or store your `kubeconfig` files in one of the supported [secret engines]({{< ref "continuous-deployment/armory-admin/secrets" >}}), or provision them via the method of your choice as Kubernetes secrets.

* **Usability**
  * Use the Armory Scale Agent alongside Spinnaker and benefit from performance improvements.
  * Use YAML, a HELM chart, or a Kustomize template to inject the Armory Scale Agent into newly provisioned Kubernetes clusters and immediately make those clusters software deployment targets.
  * Use the Armory Scale Agent with little operational overhead or changes in the way you currently manage Spinnaker.

* **Kubernetes Account Management**
   * Configure accounts statically in the Scale Agent service before deployment either in a ConfigMap or in an `armory-agent.yml` file in the pod. If you provision clusters automatically, the Armory Scale Agent service can dynamically reload accounts when the ConfigMap or `armory-agent.yaml` changes. You could, for example, configure accounts in a `ConfigMap` mounting to `/opt/armory/config/armory-agent-local.yaml`.  The Scale Agent service reflects `ConfigMap` changes within seconds after etcd sync.
   * Get Kubernetes accounts automatically registered when you deploy the Armory Scale Agent in a target cluster.
   * Manually migrate Clouddriver Kubernetes accounts to the Scale Agent using a REST API.
   * Automatically migrate Clouddriver Kubernetes accounts using [Clouddriver Account Management](https://spinnaker.io/docs/setup/other_config/accounts/) (requires Spinnaker 1.28+)


## How to get started using the Scale Agent

* **New Spinnaker instance**: {{< linkWithTitle "scale-agent/install/quickstart.md" >}} shows you how to use the Spinnaker Operator and Kustomize to install Spinnaker and the Scale Agent in the same Kubernetes cluster and namespace for testing the Scale Agent's features.
* **Existing Spinnaker instance**: {{< linkWithTitle "scale-agent/install/install-spin.md" >}} covers installation using Halyard for the plugin and `kubectl` to apply the service's manifests. You deploy the Scale Agent service to the same cluster and namespace as Spinnaker.
* **Existing Armory Continuous Deployment instance**: {{< linkWithTitle "scale-agent/install/install-armory" >}} covers how to use the Armory Operator to install the Scale Agent components. You deploy the Scale Agent service to the same cluster and namespace as Armory CD.

>For installation into existing instances, note that your Clouddriver service must use a MySQL-compatible database. If yours doesn't, see the {{< linkWithTitle "clouddriver-sql-configure.md" >}} guide for instructions.


## Supported Spinnaker and Armory CD versions

{{< include "scale-agent/agent-compat-matrix.md" >}}

You can find a full list of previous releases in the [artifactory](https://armory.jfrog.io/artifactory/manifests/).

## Docs organization

If you're familiar with the Kubernetes docs, you may notice that the Armory Scale Agent docs are organized in a similar fashion:

* [Get Started]({{< ref "scale-agent/install" >}}): This section contains guides for installing and uninstalling the Armory Scale Agent.
* [Concepts]({{< ref "scale-agent/concepts" >}}): These pages explain aspects of the Armory Scale Agent. The content is objective, containing architecture, definitions, rules, and guidelines. Rather than containing a sequence of steps, these pages link to related tasks and tutorials.
* [Tasks]({{< ref "scale-agent/tasks" >}}): Task pages show you how to do a single procedure by following a short series of steps that produce an intended outcome. Task content expects a minimum level of background knowledge, and each page links to conceptual content that you should be familiar with before you begin the task.
* [Reference]({{< ref "scale-agent/reference" >}}): This section contains both manually maintained and autogenerated reference material for configuring the plugin and service and using the APIs.
* [Release Notes]({{< ref "scale-agent/release-notes" >}})


## {{% heading "nextSteps" %}}

* {{< linkWithTitle "scale-agent/concepts/architecture.md" >}}
* {{< linkWithTitle "scale-agent/install/install-spin.md" >}}
* {{< linkWithTitle "scale-agent/install/install-armory.md" >}}
