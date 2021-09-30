---
title: Getting Started with the Project Borealis CLI
linktitle: Project Borealis
description: >
  The Project Borealis CLI is a software deployment tool that you can use to deploy Kubernetes applications.
exlcude_search: true
weight: 30
---

## Overview

Project Borealis uses Armory's hosted cloud services to deploy Kubernetes applications to your Kubernetese clusters. When you execute a deploying through the Borealis CLI, it sends the deployment request to Armory's hosted cloud services. In turn, the cloud services communicate with your Kubernetes cluster using Armory's Remote Network Agent (RNA) to initiate the deployment. On your target cluster, the RNA works with Argo Rollouts to perform the actual deployment.

Borealis supports performing a canary deployment to deploy the app incrementally by setting percentage thresholds for the deployment. For example, you can deploy the new version of your app to 25% of your target cluster and then wait for a manual judgement or a configurable amount of time. This wait gives you time to assess the impact of your changes. From there, either continue the deployment to the next threshold you set or roll back the deployment.

The whole process can be done through the Borealis CLI and a deploy file that you create and tailor to your needs.

## Requirements

For information about the requirements to use the Borealis CLI, see [Requirements]({{< ref "borealis-requirements.md" >}}). 

### Prepare your deployment target

 If you have not already done so, install both the RNA and Argo Rollouts. You can do that using the following Helm chart:

{{< include "aurora-borealis/agent-argo-install.md" >}}

## Register for Armory Cloud services

To authenticate your CLI to Armory's hosted cloud services, you need to register for Armory's hosted cloud services.

1. Go to https://console.cloud.armory.io/.
2. Click **Sign Up** and complete the form.
3. Complete the two-factor authentication configuration.

These are the credentials you use to authenticate the Borealis CLI to Armory's hosted services, such as when you run the `login` command.


### Create client credentials

After you create an account, you can create client credentials that Borealis uses to authenticate with your deployment target.

{{< include "aurora-borealis/cloud-console-creds.md" >}}




## Install the Borealis CLI

1. Go to https://github.com/armory/armory-cli/releases to download the latest release for your operating system.
2. Save the file in a directory that is on your `PATH`, such as `/usr/local/bin`.
3. ename the download file to `armory`.
4. Give the file executable permissions.
   I DID 777 FOR THE FILE BUT OBVIOUSLY THAT SHOULD NOT BE IT.
5. Verfiy that you can run Borealis:

   ```bash
   armory
   ```

   The command returns basic information about the Borealis CLI, including available commands.

## Try out the Borealis CLI from your machine

Before you can deploy, make sure that you have your client ID and secret available. These are used to authenticate your Borealis CLI to the Armory cloud services and to the target cluster.

1. Authenticate to Armory's hosted cloud services from the CLI:
   ```bash
   armory login
   ```
   Provide your Armory hosted cloud services username and password as well as two-factor authentication code when prompted.
2. Generate your deploy template.
3. Customize your deploy file.
4. Start the deployment.


### Monitor your deployment

You can monitor the progress of your deployment and approve the steps either through the Borealis CLI itself or from the Status UI. The Status UI gives you a visual representation of a deployment's health and progress in addition to controls.

GIVE OVERVIEW OF THE UI

## Advanced use cases

The Borealis CLI can be integrated with other tools that support invoking CLIs, such as GitHub Actions, Jenkins, and Tekton. 

https://docs.github.com/en/actions/creating-actions -- either creating the action or getting and using the one Armory puts out depending on the timing

Jenkins give example and link to Jenkins docs about invoking a command from a Jenkins pipeline

Tekton