---
title: Install a Remote Network Agent
linktitle: Install RNA
description: >
  Install a CD-as-a-Service Remote Network Agent in your Kubernetes cluster.
---

<!-- The CDaaS UI links to this page. Do not change the title. -->

## Remote Network Agent installation methods

By default, the Remote Network Agent (RNA) is installed with full access to the cluster. At a minimum, the RNA needs permissions to create, edit, and delete all `kind` objects that you plan to deploy with CD-as-a-Service, in all namespaces you plan to deploy to. The RNA also requires network access to any monitoring solutions or webhook APIs that you plan to forward through it.

You can install the Remote Network Agent (RNA) in your Kubernetes cluster using one of the following:

* **CLI**
  * Install using default configuration
  * Not recommended for production environments
* **kubectl**
  * Install using default configuration
  * Not recommended for production environments
* **Helm**
  * Install using default or advanced configuration
  * Recommended for production environments

{{% alert title="Important" color="warning" %}}
If you are coming to this guide from the UI **Install a Remote Network Agent** screen because you want to manually install the RNA, follow the [Helm instructions](#install-using-helm). Use the cluster name you created to identify your RNA. Copy the **Client ID** and **Client Secret** from the UI.

_Do not close the pop-up window in the UI until you have completed RNA installation. The credentials in the pop-up window are deleted if you close the window before the RNA has connected._
{{% /alert %}}

## Install using the CLI

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

   This command creates **Client Credentials** for you. During the installation process, you choose your cluster and provide an `agent identifier` (cluster name) for the RNA.

## Install using kubectl

### {{% heading "prereq" %}}

* You have **Client Credentials**. See the {{< linkWithTitle "cd-as-a-service/tasks/iam/client-creds.md" >}} guide for instructions.

### Steps

{{< include "cdaas/rna-install-kubectl.md" >}}

## Install using Helm

### {{% heading "prereq" %}}

* You have **Client Credentials**. See the {{< linkWithTitle "cd-as-a-service/tasks/iam/client-creds.md" >}} guide for instructions.

### Steps

{{< include "cdaas/rna-install-helm.md" >}}