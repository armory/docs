---
title: Install a Remote Network Agent in Your Cluster
linktitle: Install RNA
description: >
  Install a CD-as-a-Service Remote Network Agent in your Kubernetes cluster.
categories: ["Guides"]
tags: [ "Networking", "Remote Network Agent", "CD-as-as-Service Setup"]
---

<!-- The CDaaS UI links to this page. Do not change the title. -->

## Remote Network Agent installation methods

By default, you install a Remote Network Agent (RNA) with full access to your cluster. At a minimum, the RNA needs permissions to create, edit, and delete all `kind` objects that you plan to deploy with CD-as-a-Service, in all namespaces you plan to deploy to. The RNA also requires network access to any monitoring solutions or webhook APIs that you plan to forward through it.

You can install the Remote Network Agent (RNA) in your Kubernetes cluster using one of the following:

* [**UI wizard**](#generate-install-script-using-a-ui-wizard)
  * Use a UI wizard to generate an install script that includes **Client Credentials** 
  * Install using default configuration
  * Not recommended for production environments
* [**CLI**](#install-manually-using-the-cli)
  * Install using default configuration
  * Not recommended for production environments
* [**kubectl**](#install-manually-using-kubectl)
  * Install using default configuration
  * Not recommended for production environments
* [**Helm**](#install-manually-using-helm)
  * Install using default or advanced configuration
  * Recommended for production environments

{{% alert title="Important" color="warning" %}}
If you are coming to this guide from the UI **Install a Remote Network Agent** screen because you want to manually install the RNA, follow the [Helm instructions](#install-using-helm). Use the cluster name you created to identify your RNA. Copy the **Client ID** and **Client Secret** from the UI.

_Do not close the pop-up window in the UI until you have completed RNA installation. The credentials in the pop-up window are deleted if you close the window before the RNA has connected._
{{% /alert %}}

## {{% heading "prereq" %}}

* You have a role that allows you to create **Client Credentials** and connect a Remote Network Agent.
* You have access to your own Kubernetes cluster.

## Generate install script using a UI wizard

>You do not need to create **Client Credentials** for these options. The UI does that for you.

### Option 1

1. In the CD-as-a-Service Console, navigate to the **Welcome to Continuous Deployment-as-a-Service** [Configuration page](https://console.cloud.armory.io/configuration).
1. Click **Connect your Kubernetes Cluster**.
1. In the **Select Installation Method** window, select either **Connect Cluster Using Helm** or **Connect Cluster Using Kubectl**.
1. In the **Identify Your Cluster** window, enter an agent identifier for your Remote Network Agent (RNA) in the **Cluster Name** field. You install this RNA in the cluster where you want to deploy your app, so create a meaningful identifier.
1. Click **Continue**.
1. Copy the script from the **Connect New Remote Network Agent** window and run it locally.

### Option 2

1. In the CD-as-a-Service Console, navigate to the [Configuration page](https://console.cloud.armory.io/configuration).
1. Access the **Networking** > **Agents** screen.
1. Click **Add an Agent**.
1. In the **Name New Remote Network Agent** window, enter a name for your Remote Network Agent (RNA) in **Agent Identifier**. You install this RNA in the cluster where you want to deploy your app, so create a meaningful name.
1. Choose **I want to use my own cluster.** in the **Choose Cluster Type** window.
1. Copy the script in the **Install a Remote Network Agent** window and run it locally using kubectl.

## Install manually using the CLI

>You do not need to create **Client Credentials** for this option. The CLI does that for you.

1. Install the CLI if you haven't already.

   {{< include "cdaas/install-cli.md" >}}

1. Log in using the CLI.

   ```shell
   armory login
   ``` 

1. Install the RNA in your cluster.

   ```shell
   armory agent create
   ```

   You choose your cluster and provide an **agent identifier** (cluster name) for the RNA during the installation process.

## Install manually using kubectl

### {{% heading "prereq" %}}

You have **Client Credentials** with Remote Network Agent permissions.

<details><summary>Show me how</summary>
{{< include "cdaas/client-creds.md" >}}

</details>

### Steps

{{< include "cdaas/rna-install-kubectl.md" >}}

## Install manually using Helm

### {{% heading "prereq" %}}

You have **Client Credentials** with Remote Network Agent permissions.

<details><summary>Show me how</summary>
{{< include "cdaas/client-creds.md" >}}
</details>

### Steps

{{< include "cdaas/rna-install-helm.md" >}}