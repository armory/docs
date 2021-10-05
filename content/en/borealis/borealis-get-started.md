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

Borealis supports performing a canary deployment to deploy the app progressively to your cluster by setting percentage thresholds for the deployment. For example, you can deploy the new version of your app to 25% of your target cluster and then wait for a manual judgement or a configurable amount of time. This wait gives you time to assess the impact of your changes. From there, either continue the deployment to the next threshold you set or roll back the deployment.

The whole process can be done through the Borealis CLI and a deploy file that you create and tailor to your needs.

## Requirements

For information about the requirements for using the Borealis CLI, see [Requirements]({{< ref "borealis-requirements.md" >}}). 

## Register for Armory Cloud services

To authenticate your CLI to Armory's hosted cloud services, you need to register for Armory's hosted cloud services.

1. Register for Armory's hosted cloud services with the link that Armory provides.
2. Click **Sign Up** and complete the form.
3. Complete the two-factor authentication configuration.

These are the credentials you use to authenticate the Borealis CLI to Armory's hosted services, such as when you run the `login` command with the Borealis CLI. Every user who wants to deploy to your clusters using Borealis must register and create an account.

## Create credentials for service accounts

After you create an account, you can create client credentials that Borealis uses to authenticate with your deployment target. These are machine credentials used for authentication to and from Borealis. You need at least one service account to use for authentication between Borealis and your deployment target where an RNA is installed.  

Armory recommends creating separate credentials for each service or cluster. For example, if you wanted to run the Borealis CLI in a Jenkins pipeline, create credentials for the deployment target and for the Jenkins service account.

{{< include "aurora-borealis/cloud-console-creds.md" >}}

## Prepare your deployment target

{{< include "aurora-borealis/agent-argo-install.md" >}}

## Create 

## Install the Borealis CLI

1. Go to https://github.com/armory/armory-cli/releases to download the latest release for your operating system.
2. Save the file in a directory that is on your `PATH`, such as `/usr/local/bin`.
3. ename the download file to `armory`.
4. Give the file XYZ permissions.
   I DID 777.
5. Verfiy that you can run Borealis:

   ```bash
   armory 
   ```

   The command returns basic information about the Borealis CLI, including available commands.

## Try the Borealis CLI from your machine

Before you can deploy, make sure that you have the client ID and secret for your deployment target available. These are used to authenticate Armory's hosted cloud services to the target cluster. Since you are using the Borealis CLI, you do not need to have a service account for authenicating your CLI to the cloud services. Instead, you will log in manually.

1. Log in to Armory's hosted cloud services from the CLI:
   
   ```bash
   armory login
   ```

   Provide your Armory hosted cloud services username and password as well as two-factor authentication code when prompted.
2. Generate your deployment template and output it to a file:
   
   ```bash
   armory template canary > canary.yaml
   ```

  This command generates a deployment template for canary deployments and saves it to a file named `canary.yaml`.
3. Customize the template your deployment file.
4. Start the deployment:
   
   ```bash
   armory deploy -c <clientID-for-taret-cluster> -s <secret-for-target-cluster>  -f canary.yaml
   ```


### Monitor your deployment

You can monitor the progress of your deployment and approve the steps either through the Borealis CLI itself or from the Status UI. The Status UI gives you a visual representation of a deployment's health and progress in addition to controls.

#### CLI 

You can monitor the status of your deployiement by running the following command:

```bash
armory deploy status -i <deployment-ID>
```

#### Status UI



GIVE OVERVIEW OF THE UI

## Advanced use cases

The Borealis CLI can be integrated with other tools that support invoking CLIs, such as GitHub Actions, Jenkins, and Tekton. 

https://docs.github.com/en/actions/creating-actions -- either creating the action or getting and using the one Armory puts out depending on the timing

Jenkins give example and link to Jenkins docs about invoking a command from a Jenkins pipeline

Tekton