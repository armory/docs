---
title: "Armory Agent for Kubernetes"
linkTitle: "Armory Agent for K8s"
description: >
  A native Kubernetes service that enables high-scale deployments to Kubernetes using Spinnaker<sup>TM</sup>
weight: 20
---

Armory Agent is a new, flexible way for Spinnaker to interact with your Kubernetes infrastructure at scale.

* Agents listens for changes at the cluster level and only streams updates to Spinnaker.
* Changes to your infrastructure, whether Spinnaker-initiated or not, show up in real time in Spinnaker's cache, all over a single TCP connection per cluster.
* Caching and deployment scales to thousands of Kubernetes clusters for your largest applications.
* Agent uses optimized storage that results in nice performance improvements, made possible by adopting Kubernetes and RDBMS-specific storage.
* You configure accounts in Agent instead of Clouddriver.
* You can store your `kubeconfig` files in one of the supported [secret engines]({{< ref "secrets#supported-secret-engines" >}}) engines or just provision them via the method of your choice as Kubernetes secrets.

The Armory Agent consists of a lightweight service that runs in-cluster, like all other Spinnaker services, or as agent outside of the cluster. The service sends data to the Armory Agent plugin, which runs in the same namespace as Spinnaker and interacts with the Clouddriver service.

Check out our [Quick Start guide]({{< ref "agent-install-quick">}}) to install the Armory Agent on your version of Spinnaker or the Armory platform.
