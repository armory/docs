---
title: Armory Continuous Deployment-as-a-Service System Requirements
linkTitle: System Requirements
exclude_search: true
weight: 20
---

## Remote Network Agent

Armory CD-as-a-Service uses agents that run in target Kubernetes clusters to communicate with Armory services. Make sure your environment meets the [networking](#networking) requirements so that the agents can communicate with Armory CD-as-a-Service.

There are no additional requirements for installing the agents that Armory CD-as-a-Service uses. For information about how to install these agents, see [Enable the Armory CD-as-a-Service Remote Network Agent in target Kubernetes clusters]({{< ref "plugin-spinnaker#enable-the-armory-cd-as-a-service-remote-network-agent-in-target-kubernetes-clusters" >}}) or {{< linkWithTitle "get-started" >}}.

> If you are using the Armory Agent for Kubernetes, that is a separate agent from the Remote Networking Agent. It has its own requirements. For more information, see [those requirements]({{< ref "armory-agent-install#before-you-begin" >}}).

## Deployment target

You need a Kubernetes cluster to act as the deployment target for your app. The cluster must run Kubernetes 1.16 or later.

## Networking

{{< include "cdaas/req-networking.md" >}}