---
title: Armory Cloud Admin Quickstart 
---

If this is your first time using Armory Cloud, this guide walks you through the parts of Armory Cloud that you must configure before your users can start deploying your applications.

## Logging in to the Armory Cloud Console 

Armory provides a set of credentials to log in to the Cloud Console with. These are separate from the user accounts that Application Developers use to access the Spinnaker UI.

1. Go to the Armory Cloud Console: https://console.cloud.armory.io.
2. Log in with the credentials that Armory provides.
3. Select the environment you want to configure.

## Configuring the environment

Setting up your Armory Cloud environment the first time requires the following:

* Artifact providers that can be referenced in delivery pipelines
* Cloud providers that serve as the deployment targets for your applications
* (Optional)
* (Optional)

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

Once the environments are configured, your Application Developers can access the cloud deployment of the Armory Platform to start deploying their applications.

