---
title: Install a Remote Network Agent
linktitle: Install Agent
exclude_search: true
description: >
  Install a Remote Network Agent in your Kubernetes cluster.
aliases:
   - /cd-as-a-service/setup/get-started/#install-the-remote-network-agent
   - /cd-as-a-service/setup/get-started#install-the-remote-network-agent
---

<!--## Deployment targets

### Add a Kubernetes deployment target

[**Deployment Targets > Kubernetes**](https://console.cloud.armory.io/configuration/accounts/kubernetes)

For a deployment target to be available, you need to add it to Armory CD-as-a-Service.

How you add a deployment target depends on whether or not the Kubernetes cluster is accessible from the public internet. If it is, you add it through the **Configuration UI**, and no additional steps are needed. If it is not, you must first install a Remote Network Agent (RNA) on it and then add it through the **Configuration UI**.

For information about how to add a deployment target, see [Prepare your deployment target]({{< ref "get-started#prepare-your-deployment-target" >}}).
-->

## {{% heading "prereq" %}}

* If you are coming to this guide from the **Add a New Remote Network Agent** page in the UI, you have your RNA name (**Agent Identifier**), **Client ID**, and **Client Secret**. _Do not close the pop-up window in the UI until you have completed RNA installation. The credentials in the pop-up window are deleted if you close the window before the RNA has connected._
* You have created client credentials. See the {{< linkWithTitle "cd-as-a-service/tasks/iam/client-creds.md" >}} guide for instructions.
* You have access to a Kubernetes cluster and have installed [kubectl](https://kubernetes.io/docs/tasks/tools/).
* You have installed [Helm](https://helm.sh/)(v3), which is used to install the Remote Network Agent.

## Install the Remote Network Agent

{{< include "cdaas/rna-install.md" >}}