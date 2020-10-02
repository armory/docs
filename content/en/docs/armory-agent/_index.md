---
title: "Armory Agent for Kubernetes"
linkTitle: "Armory Agent for K8s"
description: >
  The Armory Agent is a new, flexible way for Spinnaker<sup>TM</sup> to interact with your Kubernetes infrastructure
weight: 20
---

The Armory Agent service runs in-cluster, like all other Spinnaker services, or as an agent outside of the cluster. The service sends data to the Armory Agent plugin, which extends Clouddriver and runs in the same namespace as Spinnaker.

* Scalability for Kubernetes

  * The Armory Agent service listens for changes at the cluster level and only streams updates to the plugin.
  * Spinnaker displays changes to your infrastructure, whether Spinnaker-initiated or not, in real time in its cache, all over a single TCP connection per cluster.
  * Caching and deployment scales to thousands of Kubernetes clusters for your largest applications.
  * The Armory Agent uses optimized storage that results in nice performance improvements, made possible by adopting Kubernetes and RDBMS-specific storage.
  * Automate Armory Agent service installation with your cluster provisioning.

* Resiliency

  * Any number of service agents can monitor a Kubernetes cluster at one time. If the primary agent fails, the secondary agent monitoring the cluster takes over sending events and performing operations where the primary agent left off.  

* Security

  * Configure cloud accounts in the Armory Agent instead of Clouddriver.
  * Store your `kubeconfig` files in one of the supported [secret engines]({{< ref "secrets#supported-secret-engines" >}}) engines or provision them via the method of your choice as Kubernetes secrets.
  * Access to the Kubernetes namespaces and event bus is fully configurable to meet even the most regulated cluster configurations.

    * Kubernetes Service Accounts control the Armory Agent's access to Kubernetes namespaces.
    * You can have one Armory Agent service for the entire Kubernetes cluster or multiple services, each with limited access to namespaces and events.
    * Permissions are inherited from the Kubernetes role binding used when installing the Armory Agent service.
    * The Armory Agent can assume service accounts within the cluster for Spinnaker deployment pipelines. 

  * Secure network communication between the service and plugin via [gPRC](https://grpc.io/), Mutual TLS (mTLS) authentication, and [JSON Web Token (JWT)](https://jwt.io/) authentication.

* Policy-Driven Deployments

    * IaaS policies (Terraform or Pulumi)
    * Security policies
    * Software promotion policies for ticketing and approval

* Installation

  * Agent mode: install in the clusters where Spinnaker deploys your applications.
  * Cluster mode: install in the same cluster as Spinnaker.
  * Infra mode: install in an infrastructure node cluster to make use of shared services and more processing power.


>Check out our [Quick Start guide]({{< ref "agent-install-quick">}}) to install the Armory Agent on your version of Spinnaker or the Armory platform.
