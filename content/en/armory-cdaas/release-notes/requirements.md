---
title: Armory Continuous Deployment-as-a-Service System Requirements
linkTitle: System Requirements
exclude_search: true
weight: 20
---

## Remote Network Agent

Armory CDaaS uses agents that run in target Kubernetes clusters to communicate with Armory services. Make sure your environment meets the [networking](#networking) requirements so that the agents can communicate with Armory CDaaS.

There are no additional requirements for installing the agents that Armory CDaaS uses. For information about how to install these agents, see [Enable the Armory CDaaS Remote Network Agent in target Kubernetes clusters]({{< ref "plugin-spinnaker#enable-the-armory-cdaas-remote-network-agent-in-target-kubernetes-clusters" >}}) or {{< linkWithTitle "get-started" >}}.

> If you are using the Armory Agent for Kubernetes, that is a separate agent from the Remote Networking Agent. It has its own requirements. For more information, see [those requirements]({{< ref "armory-agent-install#before-you-begin" >}}).

## Deployment target

You need a Kubernetes cluster to act as the deployment target for your app. The cluster must run Kubernetes 1.16 or later.

## Networking

> Note that the Spinnaker requirements are applicable only if you use the Project Aurora stage for Armory Enterprise (or Spinnaker).

| Protocol                    | DNS                                                                    | Port | Used By           | Notes                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|-----------------------------|------------------------------------------------------------------------|------|-------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| HTTPS                       | api.cloud.armory.io                      | 443  | Spinnaker         | **Armory Cloud REST API**<br><br>Used fetch information from the Kubernetes cache                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| TLS enabled gRPC over HTTP2 | agent-hub.cloud.armory.io                | 443  | Agents | **Armory Cloud Agent-Hub**<br><br>Used to connect agents to the Agent Hub through encrypted long-lived gRPC HTTP2 connections. The connections are used for bi-directional communication between Armory Enterprise or Armory Cloud Services and any target Kubernetes clusters.<br><br>This is needed so that Armory Cloud Services can interact with a your private Kubernetes APIs, orchestrate deployments, and cache data for Armory Enterprise without direct network access to your Kubernetes APIs.<br><br>Agents send data about deployments, replica-sets, and related data to Armory Cloud's Agent Cache to power infrastructure management experiences, such as the Project Aurora Plugin. |
| HTTPS                       | auth.cloud.armory.io                    | 443  | Spinnaker, Agents | **Armory’s OIDC authorization server**<br><br>Used to exchange the client ID and secret for a Java Web Token () to verify identity.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| HTTPS                       | github.com                                        | 443  | Spinnaker         | **Github**<br><br>Used to download official Armory plugins at startup time.