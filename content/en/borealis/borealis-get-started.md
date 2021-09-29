---
title: Getting Started with the Project Borealis CLI
description: >
  The Project Borealis CLI is a software deployment tool that you can use to deploy Kubernetes applications.
exlcude_search: true
weight: 20
---

## Overview

Project Borealis uses Armory's hosted cloud services to deploy Kubernetes applications to your Kubernetese clusters. When you execute a deploying through the Project Borealis CLI, it sends the deployment request to Armory's hosted cloud services. In turn, the cloud services communicate with your Kubernetes cluster using Armory's Remote Network Agent (RNA) to intiatie the deployment.

From the CLI, you can monitor the progress of the deployment. 

## Requirements

For information about the requirements to use the Project Borealis CLI, see [Requirements]({{< ref "borealis-requirements.md" >}}). 

## Register for Armory Cloud services

CREATE SINGLE-SOURCED CHUNK FROM THE AURORA-INSTALL DOC AND USE IT HERE AND THERE

## Prepare your deployment target

Project Borealis 

The target Kubernetes cluster needs both the Remote Network Agent and Argo Rollouts installed. You can do that using the following Helm chart:

MAKE THE HELM CHART BLURB REUSABLE AND INSERT IT HERE



## Install the Project Borealis CLI

1. Go to https://github.com/armory/armory-cli/releases to download the latest release for your operating system.
2. Save the download in a directory that is on your `PATH`, such as `/usr/local/bin`.

   Armory recommends that you rename the download file to `armory`.
3. Give the file executable permissions.
   I DID 777 FOR THE FILE BUT OBVIOUSLY THAT SHOULD NOT BE IT.
4. Verfiy that you can run Borealis:

   ```bash
   armory
   ```

   The command returns basic information about the Borealis CLI, including available commands.

