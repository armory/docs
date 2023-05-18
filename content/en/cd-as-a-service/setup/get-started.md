---
title: Sign Up and Connect Your Kubernetes Cluster
linktitle: Sign Up
description: >
  Sign up for Armory Continuous Deployment-as-a-Service. Connect to your Kubernetes cluster by installing a Kubernetes agent.
weight: 10
aliases:
  - cd-as-a-service/setup/get-started/
---

## How to get started using Armory CD-as-a-Service

The following steps should take less than 5 minutes to complete:

1. [Sign up for Armory CD-as-a-Service](#register-for-armory-cd-as-a-service).
1. [Connect your Kubernetes cluster](#connect-your-kubernetes-cluster).

## {{% heading "prereq" %}}

* You have reviewed the CD-as-a-Service [system requirements]({{< ref "cd-as-a-service/concepts/architecture/system-requirements.md" >}}).
* You have access to a Kubernetes cluster.

## Sign up for Armory CD-as-a-Service

{{< include "cdaas/register.md" >}}

## Connect your Kubernetes Cluster

1. In the CD-as-a-Service Console, navigate to the **Welcome to Continuous Deployment-as-a-Service** [Configuration page](https://console.cloud.armory.io/configuration).
1. Click the **Connect your Kubernetes Cluster** link.
1. In the **Select Installation Method** window, choose **Connect Cluster Using Kubectl**.
1. In the **Identify Your Cluster** window, enter a name for your Remote Network Agent (RNA) in the **Cluster Name** field. You install this RNA in the cluster where you want to deploy your app, so create a meaningful name.
1. Click **Continue**.
1. The **Connect New Remote Network Agent** window displays a script that you run to install the RNA in your cluster.

## {{%  heading "nextSteps" %}}

Learn how to deploy your app using one of these options:

* {{< linkWithTitle "cd-as-a-service/setup/cli.md" >}}
* {{< linkWithTitle "cd-as-a-service/setup/gh-action.md" >}}
* {{< linkWithTitle "cd-as-a-service/setup/argo-rollouts.md" >}}
