---
title: v2.27.1-rc1 Armory Release (OSS Spinnaker™ v1.27.0)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping --> 
description: >
  Release notes for Armory Enterprise v2.27.1-rc1 
---

## 2021/10/10 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.27.1-rc1, use one of the following tools:

- Armory-extended Halyard <PUT IN A VERSION NUMBER> or later
- Armory Operator <PUT IN A VERSION NUMBER> or later

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->




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

