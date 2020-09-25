---
title: "Armory Agent for Kubernetes"
linkTitle: "Armory Agent for K8s"
description: >
  A native Kubernetes service that enables high-scale deployments to Kubernetes using Spinnaker<sup>TM</sup>
weight: 20
---

Armory Agent is a new way for Spinnaker to deploy applications to Kubernetes.  Clouddriver, Spinnaker's current Kubernetes V2 Provider, has scaling issues when it computes and builds deployment caches for Kubernetes. With the Kubernetes plugin and Armory Agent, the caching and deployments scales with the number clusters and namespaces. Armory Agent for Kubernetes can scale to 100s or even 1000s of Kubernetes clusters for the largest applications.

Spinnaker monitors your Kubernetes infrastructure constantly so it can display the infrastructure to users, know how to version your services, and more. Spinnaker reaches out to each cluster, retrieves all the Kubernetes objects it is configured to, computes some relationships, and then stores the result in its cache. While powerful, this unobtrusive discovery mechanism has given rise to performance and account management issues when monitoring hundreds or thousands of Kubernetes clusters. The Armory Agent takes a different approach, listening to changes at the cluster level and streaming them back to Spinnaker. Changes to your infrastructure, whether Spinnaker-initiated or not, show up in real time in Spinnaker's cache, all over a single TCP connection per cluster.

<insert Chad's first diagram>

## Compatibility matrix

The Armory Agent is compatible with the Armory Platform and open source Spinnaker. It consists of a lightweight service that you deploy on Kubernetes and a plugin that you install into Spinnaker.

| Armory (Spinnaker) Version | Armory Agent Plugin Version    | Armory Agent for K8s Version |
|:-------------------------- |:------------------------------ |:---------------------------- |
| 2.19.x (1.19.x)            | 0.2.0<br>0.2.1<br>0.2.2 Latest | 0.2.0<br>0.2.1               |
| 2.20.x (1.20.x)            | 0.3.0<br>0.3.1<br>0.3.2 Latest | 0.2.1<br>0.2.2 Latest        |
| 2.21.x (1.21.x)            | 0.4.0 Latest                   | 0.2.2                        |

Check out our [Quick Start guide]({{< ref "agent-install-quick">}}) to install the Armory Agent on your version of Spinnaker or the Armory platform.
