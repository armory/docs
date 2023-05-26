---
title: Armory Continuous Deployment-as-a-Service System Requirements
linkTitle: System Requirements
weight: 20
aliases:
  - /cd-as-a-service/release-notes/requirements/
categories: ["CD-as-a-Service"]
tags: ["Architecture"]
---

## Remote Network Agent

Armory CD-as-a-Service uses agents that run in target Kubernetes clusters to communicate with Armory CD-as-a-Service. Make sure your environment meets the [networking](#networking) requirements so that the agents can communicate with Armory CD-as-a-Service.

There are no additional requirements for installing the agents that Armory CD-as-a-Service uses. For information about how to install these agents, see [Enable the Armory CD-as-a-Service Remote Network Agent in target Kubernetes clusters]({{< ref "plugin-spinnaker#enable-the-armory-cd-as-a-service-remote-network-agent-in-target-kubernetes-clusters" >}}) or {{< linkWithTitle "cd-as-a-service/tasks/networking/install-agent" >}}.

> The Armory Scale Agent for Spinnaker and Kubernetes is a separate agent from the Remote Network Agent. The Scale Agent has its own requirements. For more information, see {{< linkWithTitle "plugins/scale-agent/_index.md" >}}.

## Deployment target

You need a Kubernetes cluster to act as the deployment target for your app. The cluster must run Kubernetes 1.16 or later.

## Networking

{{< include "cdaas/req-networking.md" >}}

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "cd-as-a-service/setup/quickstart.md" >}}