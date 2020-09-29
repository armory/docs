---
title: "Armory Agent for Kubernetes"
linkTitle: "Armory Agent for K8s"
description: >
  A native Kubernetes service that enables high-scale deployments to Kubernetes using Spinnaker<sup>TM</sup>
weight: 20
---

Armory Agent is a new, flexible way for Spinnaker to interact with your Kubernetes infrastructure at scale.

Armory Agent for Kubernetes advantages:

* Listens for changes at the cluster level and only streams updates to Spinnaker.
* Changes to your infrastructure, whether Spinnaker-initiated or not, show up in real time in Spinnaker's cache, all over a single TCP connection per cluster.
* Caching and deployment scales to thousands of Kubernetes clusters for your largest applications.
* Optimized storage that results in nice performance improvements, made possible by adopting Kubernetes and RDBMS-specific storage.


Check out our [Quick Start guide]({{< ref "agent-install-quick">}}) to install the Armory Agent on your version of Spinnaker or the Armory platform.
