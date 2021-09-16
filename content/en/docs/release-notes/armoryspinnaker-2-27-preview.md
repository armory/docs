---
title: v2.27.0 Armory Release Preview
toc_hide: true
hide_summary: true
exclude_search: true
description: >
    Preview of the changes and enhancements coming in Armory Enterprise v2.27.0. Note that the actual contents of the release are subject to change. Items may be added or removed from this preview without prior notice. 
---

## Required Operator version

To install, upgrade, or configure Armory 2.27.0, use the following Operator version:

Armory Operator 1.2.6 or later

For information about upgrading, Operator, see [Upgrade the Operator]({{< ref "op-manage-operator#upgrade-the-operator" >}}). Using Halyard to install version 2.27.0 or later is not suported. For more information, see [Halyard Deprecation]({{< ref "halyard-deprecation" >}}).

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

{{< include "breaking-changes/bc-java-tls-mysql.md" >}}

{{< include "breaking-changes/bc-k8s-version-pre1-16.md" >}}

{{< include "breaking-changes/bc-k8s-infra-buttons.md" >}}

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

{{< include "known-issues/ki-bake-var-file.md" >}}

## Highlighted updates

### Deployment targets

#### AWS Lambda

> Note that these updates also require v1.0.8 of the AWS Lambda plugin. 

- Fixed an issue in the UI where a stack trace gets displayed when you try to view functions. Note that this also requires v1.0.8 of the AWS Lambda plugin. <!--BOB-30359-->
- Fixed an issue where the UI did not show functions for an application when there are no configured clusters. Functions now appear instead of a 404 error. <!--BOB-30260-->
- Caching behavior and performance have been improved. The changes include fixes for the following issues:
  - The Lambda API returns request conflicts (HTTP status 409). 
  - Event Source Mapping of ARNs fails after initially succeeding. This occured during the Lambda Event Configuration Task. 
  - Underscores (_) in environment variable names caused validation errors.
  - An exception related to event configs occurred intermittently during the Lambda Event Configuration Task. 
  - Lambda function creation using the Deploy Lambda stage failed causing subsequent runs of the pipeline to encounter an error that states the function already exists.
  - The Lambda Cache Refresh Task did not refresh the cache. This led to issues where downstream tasks referenced older versions.
  - A permission issue  caused the Infrastructure view in the UI (Deck) to not display Lambda functions.

#### Cloud Foundry

- An Unbind Service Stage has been added to the Cloud Foundry provider. Services must be unbound before they can be deleted. Use this stage prior to a Destroy Service stage. Alternatively, you can unbind all services before they are deleted in the Destroy Service stage by selecting the checkbox in the stage to do this. <!--PIT-98 BOB-30233-->
- Improved error handling when a Deploy Service stage fails <!--BOB-30273-->
- The Cloud Foundry provider now supports the following manifest attributes:
  - Processes Health
  - Timeout
  - Random route

#### General improvements

The Clouddriver service is now more resilient when starting. Previously, the service failed to start if an account that gets added has permission errors. <!-- BOB-30131-->

###  Environment registration

When you log in to the UI, you will be prompted to register your environment. When you register an environment, Armory provides you with a client ID and client secret that you add to your Operator manifest.

Registration is required for certain features to work.

Note that registration does not automatically turn on Armory Diagnostics. This means that registration does not send information about your apps and pipelines to Armory. If you are sending diagnostic information to Armory, registering your deployment ensures that Armory can know which logs are yours, improving Armory's ability to provide support.
