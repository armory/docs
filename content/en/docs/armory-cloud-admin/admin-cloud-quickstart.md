---
title: Armory Cloud Admin Quickstart 
description: If this is your first time using Armory Cloud Console, start here. It walks you through using the Armory Cloud Console, from first log in to granting your app developers access to Armory Cloud.
---

{{% alert title="Info" color="primary" %}}{{< include "saas-status.md" >}}{{% /alert %}}

## Logging in to the Armory Cloud Console 

Armory provides a set of credentials to log in to the Cloud Console. These are separate from the user accounts that app developers use to access the Armory Platform UI and API. The Cloud Console is where you go to make changes to the Armory Cloud environment and what it has access to. For example, you can add deployment targets or other resources in the Cloud Console. When app developers log in to the Armory Platform, they can use these resources in their deployment pipelines.

To log in to the cloud console, go to the Armory Cloud Console. As a design partner, Armory provides a set of credentials for you to use.

From here, you can select what environment you want to configure or open the Armory Platform for that environment.

## Configuring the environment

If you are setting up the Armory Cloud environment for the first time, you need the following information:

**Required**

* [Artifact sources](#artifact-sources) you want to connect to. Artifacts are external JSON objects like an image, a file stored somewhere, or a binary blob in a bucket.
* [Deployment targets](#deployment-targets) you want your app developers to have access to.
* [Secrets](#secrets), such as AWS secret IDs, that Armory Cloud encrypts that you can use when configuring resources like deployment targets.
  
**Optional**

* [Packer files](#packer-files) to perform customized image baking.

To start, click **Configure** for the environment you want to add.

### Secrets

For development and other non-production environments, you can opt to enter secrets in plaintext into the Cloud Console. The best practice though is to secure them using Armory Cloud Console's Secrets UI. This is especially important for secrets that relate to your production environment's deployment target. Armory Cloud stores and transmits these secrets securely. Since the secrets are encrypted, they are not visible in the Armory Cloud Console after you enter them.

Note that these are configuration secrets meant for information such as AWS Secret Access Keys. They are separate from any kind of app secret your developers may be using within their deployment pipelines.

If this is your first time configuring an environment, consider adding secrets for the following resources:

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

Once you have a secret, refer to it by name when you are configuring like access keys for Deployment Targets.

### Artifact Sources

Add artifact sources to give app developers access to artifacts, such as external JSON objects like an image, a file stored somewhere, or a binary blob in a bucket. Armory Cloud can retrieve a resource from or store a resource in artifact sources.

Armory Cloud supports the following artifact providers:

- Docker Registry

To add an artifact source, perform the following steps:

1. In the Armory Cloud Console, select the environment you want to add an artifact provider to.
2. In the left navigation, select the **Artifact Source** you want to add.
3. Click **New** and configure the account.

### Deployment Targets

Deployment targets are the destination for the code your app developers want to deliver. Armory Cloud supports the following deployment targets:

- AWS
- Kubernetes

Before you start, make sure you have added [secrets](#secrets) if it is a production environment. This way, you do not have to enter sensitive information, like access keys, in plain text.

1. In the Armory Cloud Console, select the environment you want to configure.
2. Select the **Deployment Target** you want to add.
3. Click **New** and configure the account.

### Packer Files

Armory Cloud can bake machine images for you using Packer. By default, Armory ships a set of default Packer templates for Amazon Machine Images (AMI) that your app developers can use when crafting their delivery pipelines. For information about Packer templates, see [Templates](https://www.packer.io/docs/templates).

If you want to use custom Packer template files, add them here. This is optional, and you can skip this section if you do not want to use custom Packer templates. Any templates you add are available to app developers when they configure a delivery pipeline.

1. Navigate to **Manage Packer Files**.
2. Click **New File** and configure the custom Packer template.
   
   When configuring a Packer template, keep the following in mind:
   
   - Use a unique descriptive name for each secret.
   - Only alphanumeric characters, `.`, `-`, and `_` are allowed for the name.
   - As a best practice, maintain your Packer templates in source control and make your changes there. Then update the template in the Cloud Console.

3. Save your changes.


<!--### Pipeline Triggers

These are optional but provide a way for your developers to automatically trigger their deployment pipelines. -->

## Accessing the Armory Platform

The Armory Platform is where your app developers create their delivery pipelines.Once the environments are configured, your Application Developers can access Armory Cloud to start deploying applications.

The URL to access the Armory platform is available on the Cloud Console homepage when you click **Launch**.