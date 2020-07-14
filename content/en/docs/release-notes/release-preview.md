---
title: Release Preview
description: "Learn about some of the upcoming changes to Spinnaker and their impact."
---

## Overview

Learn about some of the upcoming major changes to Spinnaker by the open source community and Armory. Included in this page are the implications of upcoming changes. Armory will incorporate this information into the release notes when appropriate, but this page is meant to be a preview and advance notice.

This page is updated on a regular basis.

## Summary of services

This section describes the notable upcoming changes to Spinnaker services in Armory Spinnaker 2.21.x (Open Source 1.21). These changes can be from the Open Source Community or Armory.

<!-- Summaries for the services go here in alphabetical order. Copy the Gate example. Have a bigger change that touches multilple services or one that requires a bit more detail? Add it to Upcoming major changes. -->

<!-- ### Gate

**Change**: Lore te gatesum
* **Impact**: Make sure you hit 88 MPH before Biff shows up.

**Change**: Lore te gatesum
* **Impact**: Make sure you hit 88 MPH before Biff shows up.
-->

### Clouddriver

**Change**: Legacy Kubernetes (V1) provider removed from Spinnaker. Armory Spinnaker 2.20 (OSS 1.20) was the final release that included support for the V1 provider.
* **Impact**: Migrate all Kubernetes accounts to the standard V2 provider before upgrading.

**Change**: The Alicloud, DC/OS, and Oracle cloud providers are excluded from OSS Spinnaker 1.21 because they no longer meet Spinnaker's cloud provider requirements. For more information about these requirements, see [Cloud Provider Requirements](https://github.com/spinnaker/governance/blob/master/cloud-provider-requirements.md)
* **Impact**: If you use one of these cloud providers and cannot migrate to a supported provider, do not upgrade to Armory Spinnaker 2.21 (OSS 1.21). Clouddriver providers are created and maintained by each cloud provider. Contact your cloud provider to review the requirements for inclusion in the Spinnaker project.

### Deck

**Change**: Improved UI for child pipeline failures. Previously, failures in pipelines that run as stages of other pipelines were difficult to debug. There is now a modal to surface failed child pipeline execution details.
* **Impact**: You can enable this feature by adding the following config to `settings-local.js`:
   ```
   window.spinnakerSettings.feature.executionMarkerInformationModal = true;
   ```
   This feature will be on by default in Open Source Spinnaker 1.22.

### Front50

**Change**: Ability to overwrite an application config entirely through the API.
* **Impact**: New API functionality!
  
**Change**: Ability to configure application name validation.
* **Impact**: When you submit an application name through the API instead of Deck, Spinnaker can now validate the name to ensure that the name only contains allowed characters. This behavior is off by default. To enable this validation, add the following config to `front50-local.yml`:
  
   ```yaml
   validation:
    applicationNameValidator:
        validationRegex: "^.*$"
        validationMessage: "<Optional. Message to display to user if the application name contains disallowed characters.">
   ```

**Change**: Front50 now only attempts to sync authorization permissions if Fiat is enabled.
* **Impact**: Fewer unncessary log messages.

### Igor

**Change**: Resolved [5803](https://github.com/spinnaker/spinnaker/issues/5803) where Jenkins stages fail because Igor could not find a property file.
* **Impact**: Igor now automatically retries fetching the property file from Jenkins when encountering a 404.  Igor will retry up to 5 times with 2 seconds non-exponential backoff.

### Rosco

**Change**: Updated Packer to version 1.4.5.
* **Impact**: You can now run more than one instance of Packer's Docker Builder at a time. Resolves [this issue](https://github.com/hashicorp/packer/issues/7904)

## Upcoming major changes 

This section describes upcoming changes that affect more than one service or a change in recommendations.

### Kubernetes Run Job stage names

Spinnaker no longer automatically appends a unique suffix to the name of jobs created by the Kubernetes Run Job stage. Prior to this release, if you specified `metadata.name: my-job`, Spinnaker would update the name to `my-job-[random-string]` before deploying the job to Kubernetes. As of 1.22, the job’s name will be passed through to Kubernetes exactly as supplied.

To continue having a random suffix added to the job name, set the `metadata.generateName` field instead of `metadata.name`, which causes the Kubernetes API to append a random suffix to the name.

This change is particularly important for users who are using the preconfigured job stage for Kubernetes, or who are otherwise sharing job stages among different pipelines. In these cases, jobs are often running concurrently, and it is important that each job have a unique name. In order to retain the previous behavior, these users will need to manually update their Kubernetes job manifests to use the `generateName` field.

#### Impact

Users of Spinnaker >= 1.20.3 can opt in to this new no-suffix behavior by setting `kubernetes.jobs.append-suffix: false` in their `clouddriver-local.yml`.

As of Spinnaker 1.22, this new behavior is the default. Users can still opt out of the new behavior by setting `kubernetes.jobs.append-suffix: true` in their `clouddriver-local.yml`. This will cause Spinnaker to continue to append a suffix to the name of jobs as in prior releases.

The ability to opt out of the new behavior will be removed in OSS Spinnaker 1.23. The above setting will have no effect, and Spinnaker will no longer append a suffix to job names. It is strongly recommended that 1.22 users who opt out update any necessary jobs and remove the setting before upgrading to Spinnaker 1.23.

#### Version
Armory Spinnaker 2.22 (Open Source Spinnaker 1.22)

### Spinnaker Operator

#### Change

Currently, Halyard manages Spinnaker's configs and lifecycle. Spinnaker users are accustomed to running `hal deploy apply` after making a change. If you have looked at Armory's documentation recently, you may have noticed that alongside the Halyard configs you are used to, Operator sections containing equivalent configs for the Spinnaker Operator have started showing up.   

#### Impact

Nothing if you are happy with Halyard and want to continue to use it. 

If you want to make your Spinnaker deployment more Kubernetes native though, Operator provides that pathway. The service `yaml` files that you edited manually or through `hal` commands are traded out for manifests that you can store in source control, facilitating collaboration. 

#### Version
Armory's extended Spinnaker Operator is available now. In addition, Armory's extended Halyard continues to be available.
