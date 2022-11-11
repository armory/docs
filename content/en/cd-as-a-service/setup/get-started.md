---
title: Get Started with Armory CD-as-a-Service
linktitle: Armory CD-as-a-Service
description: >
  Learn how to get started using Armory CD-as-a-Service to deploy apps to your Kubernetes clusters.

weight: 10
---

## How to get started using Armory CD-as-a-Service

The following steps should take less than 5 minutes to complete:

1. [Register for Armory CD-as-a-Service](#register-for-armory-cd-as-a-service).
1. [Connect your Kubernetes cluster](#connect-your-kubernetes-cluster).

## {{% heading "prereq" %}}

* You have reviewed the system requirements for using Armory CD-as-a-Service on the [Requirements]({{< ref "requirements.md" >}}) page.
* You have access to a Kubernetes cluster and have installed [kubectl](https://kubernetes.io/docs/tasks/tools/).
* You have installed [Helm](https://helm.sh/)(v3), which is used to install the Remote Network Agent.


## Register for Armory CD-as-a-Service

Access the [Registration screen](https://go.armory.io/signup/) to create an account. Fill in the required fields. When you're done, click **Create Account**.  

> You may have to log in after creating your account.

The **Welcome to Continuous Deployment-as-a-Service** [Configuration page](https://console.cloud.armory.io/configuration) lists the steps you need to complete to begin using Armory CD-as-a-Service.

## Connect your Kubernetes Cluster

1. In the CD-as-a-Service Console, navigate to the **Welcome to Continuous Deployment-as-a-Service** [Configuration page](https://console.cloud.armory.io/configuration).
1. Click the **Connect your Kubernetes Cluster** link.
1. In the **Add a New Remote Network Agent** pop-up window, enter a name for your Remote Network Agent (RNA) in the **Agent Identifier** field. You install this RNA in the cluster where you want to deploy your app, so create a meaningful name.
1. Click **Continue**.
1. The pop-up window displays options for installing the RNA.

   - **Quick**: The quickest option is to copy the provided script and run it in your terminal after you have set your `kubectl` context. _By default, the RNA is installed with `*` (all) permissions in the cluster. You need to do a manual install if you want to modify the default permissions._
   - **Manual**: Copy the **Client ID**, **Client Secret**, and the name you gave you RNA (the value of the **Agent Identifier** field). Then follow the instructions in the {{< linkWithTitle "cd-as-a-service/tasks/networking/install-agent.md" >}} guide.

## {{%  heading "nextSteps" %}}

Learn how to deploy your app using one of these options:

* {{< linkWithTitle "cd-as-a-service/setup/cli.md" >}}
* {{< linkWithTitle "cd-as-a-service/setup/gh-action.md" >}}
