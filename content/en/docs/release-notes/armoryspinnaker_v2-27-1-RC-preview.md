---
title: v2.27.1 RC Armory Release Preview (OSS Spinnaker™ v1.27.0)
toc_hide: true
version: 2.27.01 
description: >
  Release notes for Armory Enterprise v2.27.1 Release Candidate (RC). A RC release is not meant for installation in production environments. The release notes for 2.27.1 also include improvements and fixes from the 2.27.0 Beta release.
---

## 2021/10/15 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Disclaimer

{{< include "lts-beta.md" >}}

## Required Operator version

To install, upgrade, or configure Armory 2.27.1 RC, use the following Operator version:

* Armory Operator 1.4.0 or later

For information about upgrading, Operator, see [Upgrade the Operator]({{< ref "op-manage-operator#upgrade-the-operator" >}}). Using Halyard to install version 2.27.0 or later is not supported. For more information, see [Halyard Deprecation]({{< ref "halyard-deprecation" >}}).

## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, see the [Support Portal](https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010414). Note that you must be logged in to the portal to see the information.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

{{< include "breaking-changes/bc-java-tls-mysql.md" >}}

{{< include "breaking-changes/bc-k8s-version-pre1-16.md" >}}

{{< include "breaking-changes/bc-k8s-infra-buttons.md" >}}

{{< include "breaking-changes/bc-hal-deprecation.md" >}}

#### Plugin compatibility

{{< include "breaking-changes/bc-plug-version-lts.md" >}}

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

{{< include "known-issues/ki-bake-var-file.md" >}}
{{< include "known-issues/ki-artifact-binding-spel.md" >}}


## Highlighted updates

### Armory Agent for Kubernetes

Armory Enterprise 2.27.x requires an updated version of the Agent Clouddriver Plugin. The minimum plugin version required is `v0.10.0`.

### Clouddriver

#### General fixes

* Fixed an NPE related to the `kubesvcCredentialsLoader`.
* Fixed an issue where new namespaces failed to get created as part of a Deploy Manifest Stage. This issue occurred because of a validation problem.
* The Clouddriver service is now more resilient when starting. Previously, the service failed to start if an account that gets added has permission errors.

#### AWS Lambda

> Note that these updates also require v1.0.8 of the AWS Lambda plugin.

- Fixed an issue in the UI where a stack trace gets displayed when you try to view functions. <!--BOB-30359-->
- Fixed an issue where the UI did not show functions for an application when there are no configured clusters. Functions now appear instead of a 404 error. <!--BOB-30260-->
- Caching behavior and performance have been improved. The changes include fixes for the following issues:
  - The Lambda API returns request conflicts (HTTP status 409). 
  - Event Source Mapping of ARNs fails after initially succeeding. This occured during the Lambda Event Configuration Task. 
  - Underscores (_) in environment variable names caused validation errors.
  - An exception related to event configs occurred intermittently during the Lambda Event Configuration Task. 
  - Lambda function creation using the Deploy Lambda stage failed causing subsequent runs of the pipeline to encounter an error that states the function already exists.
  - The Lambda Cache Refresh Task did not refresh the cache. This led to issues where downstream tasks referenced older versions.
  - A permission issue  caused the Infrastructure view in the UI (Deck) to not display Lambda functions.

#### Clound Foundry

* Improved the resiliency of the Cloud Foundry provider. Invalid permissions for a caching agent, such as if permissions are missing for one region, no longer cause all deployments to that account to fail.
* Improved the caching behavior for the provider. Previously, the cache on a dedicated caching pod (such as when cache sharding or HA is enabled) may not have been updated if a different pod performed an operation that modifies the cache. This led to situations where the Cloud Foundry provider to attempt actions for Server Groups that no longer existed. You can configure this behavior with the following properties in your Operator manifest:
   - `expireAfterWrite`: the amount of time (in seconds) to wait before expiring the cache after a write operation
   - `expireAfterAccess`: the amount of time (in seconds) to wait before expiring the cache after a access operation
* Improved error handling when a caching agent has insufficient permissions. A RuntimeException no longer occurs.

###  Instance registration

When you log in to the UI, you will be prompted to register your environment. When you register an environment, Armory provides you with a client ID and client secret that you add to your Operator manifest.

Registration is required for certain features to work.

Note that registration does not automatically turn on Armory Diagnostics. This means that registration does not send information about your apps and pipelines to Armory. If you are sending diagnostic information to Armory, registering your deployment ensures that Armory can know which logs are yours, improving Armory's ability to provide support.

For more information, see [Environment Registration]({{< ref "ae-instance-reg" >}}).

### Plugin compatibility

{{< include "breaking-changes/bc-plug-version-lts.md" >}}

###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.27.0](https://www.spinnaker.io/changelogs/1.27.0-changelog/) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.27.1-rc1
timestamp: "2021-10-13 00:26:13"
services:
    clouddriver:
        commit: f8dddc09221407879db167edbce250dc70876d67
        version: 2.27.1-rc1
    deck:
        commit: 8912ef4f4a4f171384497b787aee0e83847ffd5c
        version: 2.27.1-rc1
    dinghy:
        commit: 71f2ed003fe6b75d8e4f43e800725f2ff3a8a1fe
        version: 2.27.1-rc1
    echo:
        commit: 5ec4a67ff921c2bdefc776dda03a0780ff853bcf
        version: 2.27.1-rc1
    fiat:
        commit: 85220a0b23bc52016a5d875a4fa5a45d8e138a61
        version: 2.27.1-rc1
    front50:
        commit: 10450164df4d77a380f0d447da66c9788a209908
        version: 2.27.1-rc1
    gate:
        commit: 2de972d861f5c8a276e332082530b4cb3d65b576
        version: 2.27.1-rc1
    igor:
        commit: 9f4db42f060f6fb45aad4c038525d71528a2f9f5
        version: 2.27.1-rc1
    kayenta:
        commit: 1cdf69a42c359a1f12077b6b1cba5606ac3e5daf
        version: 2.27.1-rc1
    monitoring-daemon:
        version: 2.26.0
    monitoring-third-party:
        version: 2.26.0
    orca:
        commit: 0349a6eca2f40a82700bdeb5c744e9db594b96c6
        version: 2.27.1-rc1
    rosco:
        commit: ac6fe57054e435c6058911c4caa177cba5fa64b3
        version: 2.27.1-rc1
    terraformer:
        commit: 23fad54614db0040074a0176066eefae38e9dc4a
        version: 2.27.1-rc1
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Deck - 2.27.0...2.27.1-rc1


#### Armory Fiat - 2.27.0...2.27.1-rc1

  - [create-pull-request] automated change (#232) (#256)

#### Dinghy™ - 2.27.0...2.27.1-rc1


#### Armory Front50 - 2.27.0...2.27.1-rc1

  - chore(build): remove platform build (#311)

#### Armory Orca - 2.27.0...2.27.1-rc1

  - [create-pull-request] automated change (#335) (#367)

#### Armory Clouddriver - 2.27.0...2.27.1-rc1

  - [create-pull-request] automated change (#364) (#457)
  - chore(cd): update base service version to clouddriver:2021.10.12.23.25.53.release-1.27.x (#462)
  - chore(cd): update base service version to clouddriver:2021.10.12.23.52.07.release-1.27.x (#463)

#### Armory Igor - 2.27.0...2.27.1-rc1


#### Armory Kayenta - 2.27.0...2.27.1-rc1

  - [create-pull-request] automated change (#268) (#280)

#### Armory Rosco - 2.27.0...2.27.1-rc1

  - [create-pull-request] automated change (#286) (#309)

#### Terraformer™ - 2.27.0...2.27.1-rc1


#### Armory Echo - 2.27.0...2.27.1-rc1


#### Armory Gate - 2.27.0...2.27.1-rc1

  - [create-pull-request] automated change (#305) (#328)
