---
title: Get Started with Project Borealis
linktitle: Get Started - Borealis
description: >
  To use Borealis, you must register for Armory's hosted cloud service and connecting your deployment target to Armory cloud.
exlcude_search: true
---

## {{% heading "prereq" %}}

Review the requirements for using Borealis on the [Requirements]({{< ref "borealis-requirements.md" >}}) page.

## Register for Armory Cloud services

{{< include "aurora-borealis/borealis-login-creds" >}}

## Create client credentials

After you create an account, you can create machine-to-machine client credentials for the various service accounts that you will need. These credentials are machine credentials that are meant for authentication when using Borealis programmatically. The credentials consist of a client ID and a client secret. Make sure to keep the secret somewhere safe. You cannot retrieve secrets that you lose access to. You would need to create a new set of credentials and update any services that used the credentials that you are replacing.

To get started, you need at least one service account to use for authentication between the Borealis and your deployment target where a Remote Network Agent (RNA) is installed. Armory recommends creating separate credentials for each cluster or service. For example, if you wanted to run the Borealis CLI in a Jenkins pipeline, create credentials for the deployment target and for the service account that you use with Jenkins.

To start, create the client credentials for the RNA on your deployment target:

{{< include "aurora-borealis/borealis-client-creds.md" >}}

## Prepare your deployment target

Borealis uses the RNA on your deployment target to communicate with Armory's hosted cloud services and to initiate the deployment. Use the provided Helm command to install and configure the RNA and Argo Rollouts.

{{< include "aurora-borealis/agent-argo-install.md" >}}

Note the account name that you assign to the deployment target. This account is used to reference the target when deploying your app.