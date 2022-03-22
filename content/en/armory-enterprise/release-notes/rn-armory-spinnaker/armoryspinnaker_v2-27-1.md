---
title: v2.27.1 Armory Release LTS (OSS Spinnaker™ v1.27.0)
toc_hide: true
version: 02.27.01
description: >
  Release notes for Armory Enterprise v2.27.1, a long term stable release. The release notes for 2.27.1 include improvements and fixes from the 2.27.0 Beta release.
---

## 2021/11/18 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Operator version

To install, upgrade, or configure Armory 2.27.1, use the following Operator version:

* Armory Operator 1.4.0 or later

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->
> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

{{< include "breaking-changes/bc-dinghy-slack.md" >}}

{{< include "breaking-changes/bc-java-tls-mysql.md" >}}

{{< include "breaking-changes/bc-k8s-version-pre1-16.md" >}}

{{< include "breaking-changes/bc-k8s-infra-buttons.md" >}}

{{< include "breaking-changes/bc-hal-deprecation.md" >}}

#### Plugin compatibility

{{< include "breaking-changes/bc-plug-version-lts-227.md" >}}


## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

{{< include "known-issues/ki-bake-var-file.md" >}}
{{< include "known-issues/ki-artifact-binding-spel.md" >}}
{{< include "known-issues/ki-dinghy-gh-notifications.md" >}}


## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->

### Deployment targets

#### General fixes

* Fixed an NPE related to the `kubesvcCredentialsLoader`.
* Fixed an issue where new namespaces failed to get created as part of a Deploy Manifest Stage. This issue occurred because of a validation problem. <!--BOB-30448-->
* The Clouddriver service is now more resilient when starting. Previously, the service failed to start if an account that gets added has permission errors.
* Fixed an issue where a stage never completes if the manifest getting deployed is of the kind `CSIDriver`. <!-- BOB-30402-->

#### AWS Lambda

> Note that these updates also require v1.0.9 of the AWS Lambda plugin.

- Fixed an issue in the UI where a stack trace gets displayed when you try to view functions. <!--BOB-30359-->
- Fixed an issue where the UI did not show functions for an application if there are no configured clusters. Functions now appear instead of a 404 error. <!--BOB-30260-->
- Caching behavior and performance have been improved. The changes include fixes for the following issues:
  - The Lambda API returns request conflicts (HTTP status 409).
  - Event Source Mapping of ARNs fails after initially succeeding. This occured during the Lambda Event Configuration Task.
  - Underscores (_) in environment variable names caused validation errors.
  - An exception related to event configs occurred intermittently during the Lambda Event Configuration Task.
  - Lambda function creation using the Deploy Lambda stage failed causing subsequent runs of the pipeline to encounter an error that states the function already exists.
  - The Lambda Cache Refresh Task did not refresh the cache. This led to issues where downstream tasks referenced older versions.
  - A permission issue  caused the Infrastructure view in the UI (Deck) to not display Lambda functions.

#### Cloud Foundry

* Improved the resiliency of the Cloud Foundry provider. Invalid permissions for a caching agent, such as if permissions are missing for one region, no longer cause all deployments to that account to fail. <!--BOB-304707 -->
* Improved the caching behavior for the provider. Previously, the cache on a dedicated caching pod (such as when cache sharding or HA is enabled) may not have been updated if a different pod performed an operation that modifies the cache. This led to situations where the Cloud Foundry provider  attempts actions for Server Groups that no longer existed. You can configure this behavior with the following properties: <!--BOB-30408-->

   - `expireAfterWrite`: the amount of time (in seconds) to wait before expiring the cache after a write operation
   - `expireAfterAccess`: the amount of time (in seconds) to wait before expiring the cache after a access operation

* Improved error handling when a caching agent has insufficient permissions. A `RuntimeException` no longer occurs.
- Added an Unbind Service Stage to the Cloud Foundry provider. Services must be unbound before they can be deleted. Use this stage prior to a Destroy Service stage. Alternatively, you can unbind all services before they are deleted in the Destroy Service stage by selecting the checkbox in the stage to do this. <!--PIT-98 BOB-30233-->
- Improved error handling when a Deploy Service stage fails <!--BOB-30273-->
- The Cloud Foundry provider now supports the following manifest attributes:

  - Processes Health
  - Timeout
  - Random route

- Fixed an issue where attributes that involved `health-check-type` parameters were not respected. Armory Enterprise (Spinnaker) now allows single parameters, such as `timeout`, to be set. Note that Armory Enterprise does not perform validation on parameters, so you may encounter runtime exceptions for Cloud Foundry if you provide invalid parameters. <!--BOB-30473-->

### Instance registration

When you log in to the UI, you are prompted to register your Armory Enterprise (Spinnaker) instance. When you register an instance, Armory provides you with a client ID and client secret that you add to your Operator manifest.

Registration is required for certain features to work.

Note that registration does not automatically turn on Armory Diagnostics. This means that registration does not send information about your apps and pipelines to Armory. If you are sending diagnostic information to Armory, registering your deployment ensures that Armory can know which logs are yours, improving Armory's ability to provide support.

For more information, see [Instance Registration]({{< ref "ae-instance-reg" >}}).

### Plugin compatibility

{{< include "breaking-changes/bc-plug-version-lts-227.md" >}}


## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.27.1
timestamp: "2021-11-04 21:25:35"
services:
    clouddriver:
        commit: a9bd461d8e5e862925b4c04f77774da97e2ecd73
        version: 2.27.1
    deck:
        commit: 8912ef4f4a4f171384497b787aee0e83847ffd5c
        version: 2.27.1
    dinghy:
        commit: 71f2ed003fe6b75d8e4f43e800725f2ff3a8a1fe
        version: 2.27.1
    echo:
        commit: 5ec4a67ff921c2bdefc776dda03a0780ff853bcf
        version: 2.27.1
    fiat:
        commit: f23a1b97346816afc4e8e85dfc3ac137282af64a
        version: 2.27.1
    front50:
        commit: f6339ea78bf6edc39250289b1a9e5545d53bc94f
        version: 2.27.1
    gate:
        commit: 68ccfd60091751f192cebde89572fe555b914ea5
        version: 2.27.1
    igor:
        commit: 9f4db42f060f6fb45aad4c038525d71528a2f9f5
        version: 2.27.1
    kayenta:
        commit: 1cdf69a42c359a1f12077b6b1cba5606ac3e5daf
        version: 2.27.1
    monitoring-daemon:
        version: 2.26.0
    monitoring-third-party:
        version: 2.26.0
    orca:
        commit: 522655a252c5a1a97f7745fe622ba06bccb99a8c
        version: 2.27.1
    rosco:
        commit: ac6fe57054e435c6058911c4caa177cba5fa64b3
        version: 2.27.1
    terraformer:
        commit: 5e69c32279c6516047eaf6de261d3632095677aa
        version: 2.27.1
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Orca - 2.27.0...2.27.1

  - [create-pull-request] automated change (#335) (#367)
  - [create-pull-request] automated change (#371) (#372)
  - Revert "[create-pull-request] automated change (#371) (#372)" (#373)

#### Armory Deck - 2.27.0...2.27.1


#### Armory Echo - 2.27.0...2.27.1


#### Armory Front50 - 2.27.0...2.27.1

  - chore(build): remove platform build (#311)
  - chore(cd): update base service version to front50:2021.10.28.01.40.53.release-1.27.x (#324)

#### Armory Igor - 2.27.0...2.27.1


#### Terraformer™ - 2.27.0...2.27.1

  - Updating Terraform Versions 1.0.8 1.0.9 (#444) (#445)

#### Armory Rosco - 2.27.0...2.27.1

  - [create-pull-request] automated change (#286) (#309)

#### Armory Clouddriver - 2.27.0...2.27.1

  - [create-pull-request] automated change (#364) (#457)
  - chore(cd): update base service version to clouddriver:2021.10.12.23.25.53.release-1.27.x (#462)
  - chore(cd): update base service version to clouddriver:2021.10.12.23.52.07.release-1.27.x (#463)
  - chore(cd): update base service version to clouddriver:2021.10.18.21.53.46.release-1.27.x (#466)
  - chore(cd): update base service version to clouddriver:2021.10.19.23.47.12.release-1.27.x (#467)
  - chore(cd): update base service version to clouddriver:2021.11.01.21.19.09.release-1.27.x (#476)
  - chore(cd): update base service version to clouddriver:2021.11.02.19.30.35.release-1.27.x (#478)
  - chore(cd): update base service version to clouddriver:2021.11.03.20.45.14.release-1.27.x (#480)

#### Dinghy™ - 2.27.0...2.27.1


#### Armory Kayenta - 2.27.0...2.27.1

  - [create-pull-request] automated change (#268) (#280)

#### Armory Gate - 2.27.0...2.27.1

  - [create-pull-request] automated change (#305) (#328)
  - Rebuild artifacts (#336)
  - chore(release): Bump armory header version (#337) (#338)

#### Armory Fiat - 2.27.0...2.27.1

  - [create-pull-request] automated change (#232) (#256)
  - [create-pull-request] automated change (#261) (#262)

