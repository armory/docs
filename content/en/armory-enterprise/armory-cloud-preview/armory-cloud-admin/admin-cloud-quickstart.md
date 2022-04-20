---
title: Cloud Admin Quickstart  (Preview)
description: If this is your first time using Armory Cloud Console, start here. It walks you through using the Armory Cloud Console, from first log in to granting your app developers access to Armory Cloud.
draft: true
aliases:
  - /docs/armory-cloud-admin/admin-cloud-quickstart/
---
![Proprietary](/images/proprietary.svg)
{{% alert title="Info" color="primary" %}}{{< include "saas-status.md" >}}{{% /alert %}}

## Logging in to the Armory Cloud Console 

Armory provides a set of credentials to log in to the Cloud Console. These are separate from the user accounts that app developers use to access the Armory Enterprise UI and API. The Cloud Console is where you go to make changes to the Armory Cloud environment and what it has access to. For example, you can add deployment targets or other resources in the Cloud Console. When app developers log in to Armory Enterprise, they can use these resources in their deployment pipelines.

As a design partner, Armory provides credentials for you to use for logging in to the Cloud Console.

From here, you can select which environment you want to configure or open Armory Enterprise for that environment.

## Configuring the environment

If you are setting up the Armory Cloud environment for the first time, you need the following:

**Required**

* AWS permissions that allow you to create AssumeRoles. Armory Cloud provides a Cloud Formation template for you to use to create the required AssumeRole. This AssumeRole gets used for actions like provisioning new infrastructure to bake an image.
* [Artifact sources](#artifact-sources) you want to connect to. Artifacts are external JSON objects like an image, a file stored somewhere, or a binary blob in a bucket.
* [Deployment targets](#deployment-targets) you want your app developers to have access to.
* [Secrets](#secrets), such as AWS Secret Access Keys. Armory Cloud encrypts these after you add them. When configuring resources like deployment targets, you can reference the secrets by a name you assign.
  
**Optional**

* [Packer files](#packer-files) to perform customized image baking.

To start, click **Configure** for the environment you want to add.

## Secrets

For development and other non-production environments, you can choose to enter secrets in plaintext into the Cloud Console. The best practice, though, is to secure your secrets using the Secrets UI in the Armory Cloud Console. Secrets are values such as an access token for GitHub. Armory Cloud stores and transmits these secrets securely if they are entered into the Secrets UI. Once entered, they are encrypted and not visible in the Armory Cloud Console. Note that these are configuration secrets meant for information such as AWS Secret Access Keys. They are separate from any kind of app secret your developers may be using within their deployment pipelines.

If this is your first time configuring an environment, consider adding secrets for the following resources to start:

- Artifact sources, such as a Docker or ECR Registry. These are a type of external resource your app developers can reference in their delivery pipelines. You can learn more about artifacts later on in this guide when you configure [Artifact Sources](#artifact-sources).
- Deployment target, such as an AWS Secert Access Key. These are where your app developers want to deploy their coed to. You can learn more later on in this guide when you configure [Deployment Targets](#deployment-targets).

1. On the Armory Cloud Console homepage, select **Configure** for the environment you want to configure.
2. Go to **Manage Secrets**.
3. Click **New Secret** and complete the form.
   
   When configuring secrets, keep the following in mind:
   
   - Use a unique descriptive name for each secret.
   - Only alphanumeric characters, `.`, `-`, and `_` are allowed for the name.
   - Once you save a secret, you can no longer access the plain-text version of it.
  
4. Save your changes.

Once you have a secret, refer to it by name when you need to provide values for things like access keys for Deployment Targets.

## Artifact Sources

Add artifact sources to give app developers access to artifacts, such as external JSON objects like an image, a file stored somewhere, or a binary blob in a bucket. Armory Cloud can retrieve a resource from or store a resource in artifact sources.

Armory Cloud supports the following artifact providers:

- Docker Registry

To add an artifact source, perform the following steps:

1. In the Armory Cloud Console, select the environment you want to add an artifact provider to.
2. In the left navigation, select the **Artifact Source** you want to add.
3. Click **New** and configure the account.

## Deployment Targets

Deployment targets are the destination for the code your app developers want to deliver. Armory Cloud supports the following deployment targets:

- AWS
- Kubernetes

Before you start, make sure you have added [secrets](#secrets) if it is a production environment. This way, you do not have to enter sensitive information, like access keys, in plain text.

1. In the Armory Cloud Console, select the environment you want to configure.
2. Select the **Deployment Target** you want to add.
3. Click **New** and configure the account.

## Packer Files

Armory Cloud can bake machine images for you using Packer. Packer templates help you bake images that remain consistent, immutable, and repeatable, which gives your app developers the ability to deploy without worrying about unintended configuration drift and other common issues. By default, Armory ships a set of default Packer templates for Amazon Machine Images (AMI) that your app developers can use when crafting their delivery pipelines. You have the option of adding custom Packer template files to do more customized baking though. For general information about Packer templates, see [Templates](https://www.packer.io/docs/templates).

Adding a custom Packer file is optional, and you can skip this section if you do not want to provide any custom Packer templates for your app developers. Any templates you do add here are available to app developers when they configure a delivery pipeline.

1. Navigate to **Manage Packer Files**.
2. Click **New File** and configure the custom Packer template.
   
   When configuring a Packer template, keep the following in mind:
   
   - Use a unique descriptive name for each secret.
   - Only alphanumeric characters, `.`, `-`, and `_` are allowed for the name.
   - As a best practice, maintain your Packer templates in source control and make your changes there. Then update the template in the Cloud Console.

3. Save your changes.

## Notifications

Configure notifications to alert your app devs about certain pipeline events, such as pipeline completion or failure. 

### Slack

Before you can configure Slack notifications for Armory Cloud, you need to configure a bot user in Slack:

1. Go to https://api.slack.com/apps.
2. Create a new app for your workspace.
3. Create a bot:
   * For **OAuth & Permissions**, assign the bot write permissions for chat.
   * By default, the bot uses the name you gave the app. You will use this name when configuring Slack notifications in Armory Cloud.
   * Although not required, Armory recommends that you set the bot to always be shown as online.
4. Install the app in your workspace and note the **Bot User OAuth Token**. Save this token somewhere safe. You need to add it to the Cloud Console as a secret. The token authorizes the bot to post messages to your Slack workspace in any channel it is invited to.
5. Invite the bot to your channels.

After you complete the configuration in Slack, finish setting notifications in the Cloud Console:

1. In the Armory Cloud Console, go to the **Secrets** page.
2. Add the **Bot User OAuth Token** from Slack as a secret. Give it a descriptive name.
3. Go to **Notifications > Slack**.
4. Enable the feature.
5. Provide the display name for the Slack bot. This is the user name that sends notifications in Slack. It should match the name the bot has in Slack.
6. Select the **Bot User OAuth Token** from the list of secrets.

Save the configuration.

<!--### Pipeline Triggers

These are optional but provide a way for your developers to automatically trigger their deployment pipelines. -->

## Accessing Armory Enterprise

Armory Enterprise is where your app developers create their delivery pipelines. Once the environments are configured, your app developers can access Armory Cloud to start deploying applications.

The URL to access the Armory platform is available on the Cloud Console homepage when you click **Launch**.