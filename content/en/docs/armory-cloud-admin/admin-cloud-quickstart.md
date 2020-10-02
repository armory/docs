---
title: Armory Cloud Admin Quickstart 
---

If this is your first time using Armory Cloud, use this guide to get started. It walks you through from first log in to granting your app developers access to Spinnaker.

## Logging in to the Armory Cloud Console 

Armory provides a set of credentials to log in to the Cloud Console. These are separate from the user accounts that app developers use to access the Armory Platform UI and API. The Cloud Console is where you go to make changes to the Armory Cloud environment and what it has access to. For example, you can add artifact stores or deployment targets in the Cloud Console.

1. Go to the Armory Cloud Console: https://console.cloud.armory.io.
2. Log in with the credentials that Armory provides.

The first time logging into the Cloud Console, there will not be any environments created. So select the sandbox environment to get started.

## Managing secrets

Add configuration secrets to Armory Cloud to grant your app developers access to resources such as deployment targets. Armory Cloud stores and transmits these secrets securely. Once configured, refer to them by a name you assign instead of entering them in plain text.

Note that these secrets are separate from any kind of app secret your developers may be using within their deployment pipelines.

1. On the Armory Cloud Console homepage, select **Manage Secrets** for the environment you want to configure secrets for.
2. On this screen, you can perform several tasks:
   
   - Add a new secret
   - Update a secret
   - Delete a secret

## Configuring the environment

If you are setting up the Armory Cloud environment for the first time, you need require the following information:

* Artifact Providers that can be referenced in delivery pipelines
* **Cloud Providers**: These serve as the deployment targets for applications. Once configured, your app developers can refer to them in their deployment pipelines.

### Artifacts

Artifacts are external resources along the lines of an image, a file stored somewhere, or a binary blob in a bucket. Armory Cloud supports artifact providers that you can retrieve a resource from or store a resource in. 

To add an artifact provider, perform the following steps:

1. In the Armory Cloud Console, select the environment you want to add an artifact provider to.
2. Select the artifact provider you want to add.
3. Click **New** and configure the account:

### Cloud providers

Cloud providers are the deployment targets for any app that you deliver using Armory Cloud.

1. In the Armory Cloud Console, select the environment you want to configure cloud providers for.
2. Select the cloud provider you want to add.
3. Click **New** and configure the account:


## Accessing Spinnaker

Once the environments are configured, your Application Developers can access the cloud deployment of the Armory Platform to start deploying applications.

