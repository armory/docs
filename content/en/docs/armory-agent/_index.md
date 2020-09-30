---
title: "Armory Agent for Kubernetes"
linkTitle: "Armory Agent for K8s"
description: >
  A native Kubernetes service that enables high-scale deployments to Kubernetes using Spinnaker<sup>TM</sup>
weight: 20
---

Armory Agent is a new, flexible way for Spinnaker to interact with your Kubernetes infrastructure.

* Massive scale for Kubernetes

  * Agent listens for changes at the cluster level and only streams updates to Spinnaker.
  * Spinnaker displays changes to your infrastructure, whether Spinnaker-initiated or not, in real time in its cache, all over a single TCP connection per cluster.
  * Caching and deployment scales to thousands of Kubernetes clusters for your largest applications.
  * Agent uses optimized storage that results in nice performance improvements, made possible by adopting Kubernetes and RDBMS-specific storage.
  * Automate Agent installation with cluster provisioning.

* Security

  * Configure accounts in Agent instead of Clouddriver.
  * Store your `kubeconfig` files in one of the supported [secret engines]({{< ref "secrets#supported-secret-engines" >}}) engines or provision them via the method of your choice as Kubernetes secrets.

* Policy-Driven Deployments

  * IaaS policies (Terraform or Pulumi)
  * Security policies
  * Software promotion policies for ticketing and approval

The Armory Agent consists of a lightweight service that runs in-cluster, like all other Spinnaker services, or as an agent outside of the cluster. The service sends data to the Armory Agent plugin, which runs in the same namespace as Spinnaker and interacts with the Clouddriver service.

Check out our [Quick Start guide]({{< ref "agent-install-quick">}}) to install the Armory Agent on your version of Spinnaker or the Armory platform.
