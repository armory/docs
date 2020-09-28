---
title: "Armory Agent for Kubernetes"
linkTitle: "Armory Agent for K8s"
description: >
  A native Kubernetes service that enables high-scale deployments to Kubernetes using Spinnaker<sup>TM</sup>
weight: 20
---

Armory Agent is a new, flexible way for Spinnaker to interact with your Kubernetes infrastructure that solves the scaling issues plaguing Spinnaker's Kubernetes V2 Provider.

![Armory Agent Overview](/images/armory-agent/agent-overview.png)

Kubernetes V2 Provider disadvantages:

* Monitors your Kubernetes infrastructure every thirty seconds.
* Contacts each cluster, retrieves all the Kubernetes objects it is configured to retrieve, computes relationships, and then stores the result in its cache - even if there have been no changes on the Kubernetes side.
* Encounters performance and account management issues when monitoring hundreds or thousands of Kubernetes clusters.

Armory Agent for Kubernetes advantages:

* Listens for changes at the cluster level and streams only those changes back to Spinnaker.
* Changes to your infrastructure, whether Spinnaker-initiated or not, show up in real time in Spinnaker's cache, all over a single TCP connection per cluster.
* Caching and deployment scales to thousands of Kubernetes clusters for your largest applications.


Check out our [Quick Start guide]({{< ref "agent-install-quick">}}) to install the Armory Agent on your version of Spinnaker or the Armory platform.
