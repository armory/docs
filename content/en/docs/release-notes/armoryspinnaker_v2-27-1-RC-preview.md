---
title: v2.27.1 RC Armory Release Preview (OSS Spinnaker™ v1.27.0)
toc_hide: true
version: 2.27.01 
description: >
  Release notes for Armory Enterprise v2.27.1 Release Candidate (RC). A RC release is not meant for installation in production environments. 
---

## 2021/09/30 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Disclaimer

{{< include "lts-beta.md" >}}

## Required Operator version

To install, upgrade, or configure Armory 2.27.1 RC, use the following Operator version:

* Armory Operator 1.4.0 or later

For information about upgrading, Operator, see [Upgrade the Operator]({{< ref "op-manage-operator#upgrade-the-operator" >}}). Using Halyard to install version 2.27.0 or later is not suported. For more information, see [Halyard Deprecation]({{< ref "halyard-deprecation" >}}).

## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, see the [Support Portal](https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010414). Note that you must be logged in to the portal to see the information.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

{{< include "breaking-changes/bc-java-tls-mysql.md" >}}

{{< include "breaking-changes/bc-k8s-version-pre1-16.md" >}}

{{< include "breaking-changes/bc-k8s-infra-buttons.md" >}}

#### Halyard deprecation

Halyard is no longer supported for installing Armory Enterprise 2.27.0 and later. Use the Operator. For more information, see [Halyard Deprecation]({{< ref "halyard-deprecation" >}}).

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

{{< include "known-issues/ki-bake-var-file.md" >}}
{{< include "known-issues/ki-artifact-binding-spel.md" >}}

#### NullPointerException in Clouddriver

The following NPE occurs in the Clouddriver service:

```
Error creating bean with name 'kubesvcCredentialsLoader': Invocation of init method failed; nested exception is java.lang.NullPointerException
```

To resolve the issue, set the following property to `false` in your Operator manifest: `spec.spinnakerConfig.profiles.clouddriver.armory.cloud.enabled`.


## Highlighted updates

### Clound Foundry

* Improved the resiliency of the Cloud Foundry provider. Invalid permissions for a caching agent, such as if permissions are missing for one region, no longer cause all deployments to that account to fail.
* Improved the caching behavior for the provider. Previously, the cache on a dedicated caching pod (such as when cache sharding or HA is enabled) may not have been updated if a different pod performed an operation that modifies the cache. This led to situations where the Cloud Foundry provider to attempt actions for Server Groups that no longer existed. You can configure this behavior with the following properties in your Operator manifest:
   - `expireAfterWrite`: the amount of time (in seconds) to wait before expiring the cache after a write operation
   - `expireAfterAccess`: the amount of time (in seconds) to wait before expiring the cache after a access operation
* Improved error handling when a caching agent has insufficient permissions. A RuntimeException no longer occurs.

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
