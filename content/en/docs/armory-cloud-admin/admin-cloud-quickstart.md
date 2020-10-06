---
title: Armory Cloud Admin Quickstart 
description: If this is your first time using Armory Cloud, use this guide to get started. It walks you through using the Armory Cloud Console, from first log in to granting your app developers access to Armory Cloud.
---

{{% alert title="Info" color="primary" %}}{{< include "saas-status.md" >}}{{% /alert %}}

## Logging in to the Armory Cloud Console 

Armory provides a set of credentials to log in to the Cloud Console. These are separate from the user accounts that app developers use to access the Armory Platform UI and API. The Cloud Console is where you go to make changes to the Armory Cloud environment and what it has access to. For example, you can add artifact stores or deployment targets in the Cloud Console.

1. Go to the Armory Cloud Console: https://console.cloud.armory.io.
2. Log in with the credentials that Armory provides.

The first time logging into the Cloud Console, there will not be any environments created. So select the sandbox environment to get started.

## Adding secrets

Start by adding configuration secrets to Armory Cloud to grant your app developers access to resources such as deployment targets. This way, you do not have secrets visible in plain text for your configurations. Armory Cloud stores and transmits these secrets securely. Since the secrets are encrypted, they are not visible in the Armory Cloud Console. You reference them by a name you assign when needed.

Note that these are configuration secrets meant for information such as AWS Secret Access Keys. They are separate from any kind of app secret your developers may be using within their deployment pipelines.

1. On the Armory Cloud Console homepage, select **Manage Secrets** for the environment you want to configure secrets for.
2. On this screen, you can perform several tasks:

   - Add a new secret
   - Update a secret
   - Delete a secret

If this is your first time configuring an environment, consider adding the following secrets:

- Artifact sources, such as a Docker or ECR Registry. These are a type of external resource your app developers can reference in their delivery pipelines. You can learn more about artifacts later on in this guide when you configure [Artifact Sources](#artifact-sources).
- Deployment target, such as an AWS Secert Access Key. These are where your app developers want to deploy their coed to. You can learn more later on in this guide when you configure [Deployment Targets](#deployment-targets).

## Configuring the environment

If you are setting up the Armory Cloud environment for the first time, you need require the following information:

<!-- add link to  saas pcm once that exists. for now, adding it to the sections directly.-->

### Artifact Sources

Add artifact sources to give app developers access to artifacts, external JSON objects like an image, a file stored somewhere, or a binary blob in a bucket. Armory Cloud can retrieve a resource from or store a resource in artifact sources.

Armory Cloud supports several artifact providers:

- Amazon S3
- Docker Registry

To add an artifact source, perform the following steps:

1. In the Armory Cloud Console, select the environment you want to add an artifact provider to.
2. In the left navigation, select the **Artifact Source** you want to add.
3. Click **New** and configure the account:

### Deployment Targets

Deployment targets are the destination for the code your app developers want to deliver. Armory Cloud supports the following deployment targets:

- AWS
- Kubernetes

1. In the Armory Cloud Console, select the environment you want to configure cloud providers for.
2. Select the deployment target you want to add.
3. Click **New** and configure the account:

### Pipeline Triggers

These are optional but provide a way for your developers to automatically trigger their deployment pipelines.

## Accessing Spinnaker

Once the environments are configured, your Application Developers can access the cloud deployment of the Armory Platform to start deploying applications.