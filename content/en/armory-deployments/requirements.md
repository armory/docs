---
title: "System Requirements for Armory Deployments"
linkTitle: "System Requirements"
exclude_search: true
weight: 20
---

To use Armory Deployments, make sure you meet the following requirements.

## Armory Cloud Agent

Armory Deployments uses agents that run in target Kubernetes clusters to communicate with Armory Cloud services, specifically the Agent Hub. Make sure the [networking](#networking) requirements are met so that the Agent can communicate with the Agent Hub. 

There are no additional requirements for installing the Agent to use with Armory Deployments. 

> If you are using the Armory Agent for Spinnaker, that is a separate agent. It has its own requirements. For more information, see [those requirements]({{< ref "armory-agent-quick#before-you-begin" >}}).

## Argo Rollouts

You must have Argo Rollouts 1.x or later installed in the Kubernetes cluster you want to deploy to. For information about how to install Argo Rollout, see [Controller Installation in the Argo documentation](https://argoproj.github.io/argo-rollouts/installation/#controller-installation). Note that the Argo Rollout Controller is separate from Argo CD.

## Kubernetes

Deployment target clusters must run Kubernetes 1.16 or later.

## Networking

> Note that the Spinnaker requirements are applicable only if you use the Armory Deployments Progressive Kubernetes stage for Armory Enterprise (or Spinnaker).

| Protocol                    | DNS                                                                    | Port | Used By           | Notes                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|-----------------------------|------------------------------------------------------------------------|------|-------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| HTTPS                       | api.cloud.armory.io                      | 443  | Spinnaker         | **Armory Cloud REST API**<br><br>Used fetch information from the Kubernetes cache                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| TLS enabled gRPC over HTTP2 | agents.cloud.armory.io                | 443  | Spinnaker, Agents | **Armory Cloud Agent Hub**<br><br>Used to connect agents to the Agent Hub through encrypted long-lived gRPC HTTP2 connections. The connections are used for bi-directional communication between Armory Enterprise or Armory Cloud Services and any target Kubernetes clusters.<br><br>This is needed so that Armory Cloud Services can interact with a your private Kubernetes APIs, orchestrate deployments, and cache data for Armory Enterprise without direct network access to your Kubernetes APIs.<br><br>Agents send data about deployments, replica-sets, and related data to Armory Cloud's Agent Cache to power infrastructure management experiences, such as the Armory Deployments Plugin. |
| HTTPS                       | auth.cloud.armory.io                    | 443  | Spinnaker, Agents | **Armory’s OIDC authorization server**<br><br>Used to exchange the client ID and secret for a Java Web Token () to verify identity.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| TLS enabled gRPC over HTTP2 | grpc.deploy.cloud.armory.io | 443  | Spinnaker         | **Armory Cloud Deploy Engine gRPC Service**<br><br>Used to orchestrate deployments in target Kubernetes clusters through agents using gRPC.<br><br>Armory Enterprise calls this during the Armory Kubernetes Progressive Delivery Stage.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| HTTPS                       | github.com                                        | 443  | Spinnaker         | **Github**<br><br>Used to download official Armory plugins at startup time.