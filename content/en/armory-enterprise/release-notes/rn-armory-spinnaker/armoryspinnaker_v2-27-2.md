---
title: v2.27.2 Armory Release (OSS Spinnaker™ v1.27.0)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping --> 
description: >
  Release notes for Armory Enterprise v2.27.2 
---

## 2021/12/70 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.27.2, use one of the following tools:

- Armory-extended Halyard <PUT IN A VERSION NUMBER> or later
- Armory Operator <PUT IN A VERSION NUMBER> or later

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

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
<code>version: 2.27.2
timestamp: "2021-12-14 23:38:36"
services:
    clouddriver:
        commit: a9bd461d8e5e862925b4c04f77774da97e2ecd73
        version: 2.27.2
    deck:
        commit: d2a44f00f618e01853ef7890abe1ed6d2ce62c2e
        version: 2.27.2
    dinghy:
        commit: 71f2ed003fe6b75d8e4f43e800725f2ff3a8a1fe
        version: 2.27.2
    echo:
        commit: 5ec4a67ff921c2bdefc776dda03a0780ff853bcf
        version: 2.27.2
    fiat:
        commit: f23a1b97346816afc4e8e85dfc3ac137282af64a
        version: 2.27.2
    front50:
        commit: f6339ea78bf6edc39250289b1a9e5545d53bc94f
        version: 2.27.2
    gate:
        commit: 10936c03e0722b42a8d632f7869e4c1ad29610a6
        version: 2.27.2
    igor:
        commit: 9f4db42f060f6fb45aad4c038525d71528a2f9f5
        version: 2.27.2
    kayenta:
        commit: 1cdf69a42c359a1f12077b6b1cba5606ac3e5daf
        version: 2.27.2
    monitoring-daemon:
        version: 2.26.0
    monitoring-third-party:
        version: 2.26.0
    orca:
        commit: 522655a252c5a1a97f7745fe622ba06bccb99a8c
        version: 2.27.2
    rosco:
        commit: ac6fe57054e435c6058911c4caa177cba5fa64b3
        version: 2.27.2
    terraformer:
        commit: 5e69c32279c6516047eaf6de261d3632095677aa
        version: 2.27.2
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Rosco - 2.27.1...2.27.2


#### Dinghy™ - 2.27.1...2.27.2


#### Armory Kayenta - 2.27.1...2.27.2


#### Armory Front50 - 2.27.1...2.27.2


#### Armory Fiat - 2.27.1...2.27.2


#### Armory Deck - 2.27.1...2.27.2

  - chore(cd): update base deck version to 2021.0.0-20211115175155.release-1.27.x (#1148)

#### Armory Gate - 2.27.1...2.27.2

  - chore(cd): update base service version to gate:2021.12.14.20.34.14.release-1.27.x (#355)

#### Armory Orca - 2.27.1...2.27.2


#### Armory Echo - 2.27.1...2.27.2


#### Armory Clouddriver - 2.27.1...2.27.2


#### Terraformer™ - 2.27.1...2.27.2


#### Armory Igor - 2.27.1...2.27.2


