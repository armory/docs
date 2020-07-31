---
title: Release Preview for Armory Spinnaker 2.21 (OSS 1.21)
linkTitle: "Next Release"
description: "Learn about some of the upcoming changes to Spinnaker and their impact."
---

## Overview

Learn about some of the upcoming major changes to Spinnaker by the open source community and Armory. Included in this page are the implications of upcoming changes. Armory will incorporate this information into the release notes when appropriate, but this page is meant to be a preview and advance notice.

This page is updated on a regular basis.

## Changes in 2.21 

This section describes the notable upcoming changes to Spinnaker services in Armory Spinnaker 2.21.x (Open Source 1.21). These changes can be from the Open Source Community or Armory.

<!-- Summaries for the services go here in alphabetical order. Copy the Gate example. Have a bigger change that touches multilple services or one that requires a bit more detail? Add it to Upcoming major changes. -->

<!-- ### Some descriptive title

This section describes changes to <service>, Spinnaker's <descriptive description> service:

**Change**: Lore te gatesum. [commit hash](link)
* **Impact**: Make sure you hit 88 MPH before Biff shows up.

**Change**: Lore te gatesum. [commit hash](link)
* **Impact**: Make sure you hit 88 MPH before Biff shows up.
-->

### Authorization

This section describes changes to Fiat, Spinnaker's authorization service:

**Change**: Add support for extension resources. [daf58f5f](https://github.com/spinnaker/fiat/commit/daf58f5fd1fdc9f02f1920e13ca1d0e483b42680)
* **Impact**: This change allows Fiat to serve / evaluate permissions for arbitrary resources. This adds additional functionality to the Plugins framework for Spinnaker. For an example, see [File Resource Provider Plugin](https://github.com/spinnaker-plugin-examples/fileResourceProvider).


### Baking

This section describes changes to Rosco, Spinnaker's image bakery:

**Change**: Updated Packer to version 1.4.5. [0091cc1d](https://github.com/spinnaker/rosco/commit/0091cc1dc30eee002115b684806393e9c7dc437d)
* **Impact**: You can now run more than one instance of Packer's Docker Builder at a time. Resolves [this issue](https://github.com/hashicorp/packer/issues/7904).

### CI integration

This section describes changes to Igor, Spinnaker's service that integrates with CI systems:

**Change**: Resolved [5803](https://github.com/spinnaker/spinnaker/issues/5803) where Jenkins stages fail because Igor could not find a property file. [7c47ce3f](https://github.com/spinnaker/igor/commit/7c47ce3fece8120fc53c615a9683f4ce0070ea4b)
* **Impact**: Igor now automatically retries fetching the property file from Jenkins when encountering a 404.  Igor will retry up to 5 times with 2 seconds non-exponential backoff.

### Cloud providers 

This section describes changes to Clouddriver, Spinnaker's cloud connector service:

**Change**: Legacy Kubernetes (V1) provider removed from Spinnaker. Armory Spinnaker 2.20 (OSS 1.20) was the final release that included support for the V1 provider.
* **Impact**: Migrate all Kubernetes accounts to the standard V2 provider before upgrading.

**Change**: The Alicloud, DC/OS, and Oracle cloud providers are excluded from OSS Spinnaker 1.21 because they no longer meet Spinnaker's cloud provider requirements. For more information about these requirements, see [Cloud Provider Requirements](https://github.com/spinnaker/governance/blob/master/cloud-provider-requirements.md).
* **Impact**: If you use one of these cloud providers and cannot migrate to a supported provider, do not upgrade to Armory Spinnaker 2.21 (OSS 1.21). Clouddriver providers are created and maintained by each cloud provider. Contact your cloud provider to review the requirements for inclusion in the Spinnaker project.

### Eventing

This section describes changes to Echo, Spinnaker's event service:

**Change**: Add action conditions for Git triggers. [715693a](https://github.com/spinnaker/echo/commit/715693a02869edcbc37d0159e4c5f518eab6e7c8)
* **Impact**: You can now filter triggers on Git webhooks. Add an actions section to the pipeline JSON to filter what type of actions can trigger the pipeline. The following example configures a pipeline to only trigger when a pull request is closed:
   ```json
   "triggers: [
      {
         "actions": [
            "pull_request:closed"
         ],
         "branch": "",
         "enabled": true,
         "project": "MyProject",
         "slug": "MyRepository",
         "source": "github",
         "type": "git"
      }
   ],
   ```
   
**Change**: Usage statistics for Spinnaker are now collected by default. The Open Source Spinnaker project collects this information to inform the development of Spinnaker. It is anonymized before it gets sent and then aggregated. For more information about these metrics or to view them, see [Usage Statistics](https://spinnaker.io/community/stats/#usage-statistics).
* **Impact**:  If you want to turn the usage statistics off, see [How is the data collected](https://spinnaker.io/community/stats/#how-is-the-data-collected).

**Change**: Add ability to suppress triggers at runtime. [7aebc7a3](https://github.com/spinnaker/echo/commit/7aebc7a319706ec3ec2d94d2102ea4b219a63707)
* **Impact**: This change adds the following properties that can be used in `echo.yml`:
   * `scheduler.suppressTriggers`: (Default: `false`) Allows suppressing event triggers from the CRON scheduler.
   * `scheduler.compensationJob.suppressTriggers`: (Default: `false`) Allows suppressing event triggers from the compensation job (missed CRON scheduler).
   
   You might use these properties when you are running two instances of Echo that are both running the scheduler for redundancy. Both Echos need to be current in situations where you need to switch the Echo service being used, but only one of them need to trigger events at any given time.

   These properties are backed by the DynamicConfigService and can be modified at runtime.

### Metadata persistence

This section describes changes to Front50, Spinnaker's metadata repository:

**Change**: Ability to overwrite an application config entirely through the API. [2cf86b34](https://github.com/spinnaker/front50/commit/2cf86b34d40f847208a1a55bee352bc731fd1b6b)
* **Impact**: New API functionality!
  
**Change**: Ability to validate application names when applications are created or modified through the API. [2cf86b34](https://github.com/spinnaker/front50/commit/2cf86b34d40f847208a1a55bee352bc731fd1b6b)
* **Impact**: When you submit an application name through the API instead of Deck, Spinnaker can now validate the name to ensure that the name only contains allowed characters. This behavior is off by default. To enable this validation, add the following config to `front50-local.yml`:
  
   ```yaml
   validation:
    applicationNameValidator:
        validationRegex: "^.*$"
        validationMessage: "<Optional. Message to display to user if the application name contains disallowed characters.">
   ```

**Change**: Front50 now only attempts to sync authorization permissions if Fiat is enabled.
* **Impact**: Fewer unncessary log messages.


### Task orchestration

This section describes changes to Orca, Spinnaker's task orchestration service:

**Change**: Add function `pipelineIdInApplication` to Pipeline Expressions, which allows you to fetch the ID of a pipeline given its name and its application name. [febb6f68](https://github.com/spinnaker/orca/commit/febb6f68c4c9dcfd5aba82eab587add2fae2b11d)
* **Impact**: This function is useful when running a dependent pipeline that fails in a different application.

**Change**: **AWS** -- Pass the AWS account to Clouddriver when retrieving images. [9eadf5e6](https://github.com/spinnaker/orca/commit/9eadf5e68ca1b535f8fe562b5f870ce962c6e242)
* **Impact**: This modifies the behavior of the Find Image from Tags stage. You can configure the stage to look for images in a specific AWS account if the following config is set in the stage JSON: `imageOwnerAccount`.

**Change**: Expose the `amiName` property in bake stage output (if present). [ee99ba11](https://github.com/spinnaker/orca/commit/ee99ba114aff96ab37654336922a2ac75da7ad6c)
* **Impact**: You can access `amiName` in downstream stages.

**Change**: **AWS** -- Add exported environment variables in the CodeBuild stage context. [2ab7032e](https://github.com/spinnaker/orca/commit/2ab7032e28303d4b23ecde8ba6286ded0147d52c)
* **Impact**:  Allows end users to consume the environment variables exported from CodeBuild build stage by specifying a pipeline expression like `${#stage('AWS CodeBuild')['context']['buildInfo']['exportedEnvironmentVariables']}`.

**Change**: Merge collections when merging stage outputs. [f44ba60f](https://github.com/spinnaker/orca/commit/f44ba60fd8eaa89f3d5b10a1f335df07e4dd0b35)
* **Impact**: More data may be available in the pipeline execution history. This changes the behavior of stage outputs. Previously, stage outputs overwrote each other if duplicates were present. Now, stage outputs concatenate collections from duplicate keys.

**Change**: Add a dynamic toggle for sending full pipeline executions between Spinnaker services. [54a0ff85](https://github.com/spinnaker/orca/commit/54a0ff8586433905e9d1d4a93023ff9ecd33cef2)
* **Impact**: Large pipeline executions can generate a lot of tasks, which generates Echo traffic that includes the full execution payload. This option allows for a reduced payload size. To turn this feature on, add the following config to Echo:
   ```yaml
   echo:
      ...
      events:
         includeFullExecution: true
      ...
   ```
**Change**: Prevent leak of information through template resolution endpoint. [ef080b1](https://github.com/spinnaker/orca/commit/ef080b136eb955866f31004ad8f2e7b6a8e8a900)
* **Impact**: You were able use Orca to search the internet! Or read its EC2 metadata or whatever. This change fixes that by removing an SSRF vulnerability. 


### UI

This section describes changes to Deck, Spinnaker's UI:

**Change**: Improved UI for child pipeline failures. Previously, failures in pipelines that run as stages of other pipelines were difficult to debug.  [a2af93f](https://github.com/spinnaker/deck/commit/a2af93fd961323fbea611a97bf7c0bbbb82c9828)
* **Impact**: There is now a modal to surface failed child pipeline execution details. You can enable this feature by adding the following config to `settings-local.js`:
   ```
   window.spinnakerSettings.feature.executionMarkerInformationModal = true;
   ```
   This feature will be on by default in Open Source Spinnaker 1.22.


## Upcoming major changes 

This section describes upcoming changes that affect more than one service or a change in recommendations.

### Kubernetes Run Job stage names

Spinnaker no longer automatically appends a unique suffix to the name of jobs created by the Kubernetes Run Job stage. Prior to this release, if you specified `metadata.name: my-job`, Spinnaker would update the name to `my-job-[random-string]` before deploying the job to Kubernetes. As of 2.22, the job’s name will be passed through to Kubernetes exactly as supplied.

To continue having a random suffix added to the job name, set the `metadata.generateName` field instead of `metadata.name`, which causes the Kubernetes API to append a random suffix to the name.

This change is particularly important for users who are using the preconfigured job stage for Kubernetes, or who are otherwise sharing job stages among different pipelines. In these cases, jobs are often running concurrently, and it is important that each job have a unique name. In order to retain the previous behavior, these users will need to manually update their Kubernetes job manifests to use the `generateName` field.

#### Impact

Users of Armory Spinnaker >= 2.20.x can opt in to this new behavior by setting `kubernetes.jobs.append-suffix: false` in their `clouddriver-local.yml`.

As of Spinnaker 1.22, this new behavior is the default. Users can still opt out of the new behavior by setting `kubernetes.jobs.append-suffix: true` in their `clouddriver-local.yml`. This will cause Spinnaker to continue to append a suffix to the name of jobs as in prior releases.

The ability to opt out of the new behavior will be removed in Armory Spinnaker 2.23 (OSS Spinnaker 1.23). The `kubernetes.jobs.append-suffix: true` setting will have no effect, and Spinnaker no longer appends a suffix to job names. Armory recommendeds that 2.22 users who opt out of the new behavior update any necessary jobs and remove the `kubernetes.jobs.append-suffix: true` setting before upgrading to Armory Spinnaker 2.23.

#### Version
Armory Spinnaker 2.22 and 2.23 (Open Source Spinnaker 1.22 and 1.23)

### Spinnaker Operator

#### Change

Currently, Halyard manages Spinnaker's configs and lifecycle. Spinnaker users are accustomed to running `hal deploy apply` after making a change. If you have looked at Armory's documentation recently, you may have noticed that alongside the Halyard configs you are used to, Operator sections containing equivalent configs for the Spinnaker Operator have started showing up.   

#### Impact

Nothing if you are happy with Halyard and want to continue to use it. 

If you want to make your Spinnaker deployment more Kubernetes native though, Operator provides that pathway. The service `yaml` files that you edited manually or through `hal` commands are traded out for manifests that you can store in source control, facilitating collaboration. 

#### Version
Armory's extended Spinnaker Operator is available now. In addition, Armory's extended Halyard continues to be available.
