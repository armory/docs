---
title: v2.27.1 Armory Release (OSS Spinnaker™ v1.27.0)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping --> 
description: >
  Release notes for Armory Enterprise v2.27.1 
---

## 2021/11/20 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.27.1, use one of the following tools:

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
  - chore(build): Autobump armory-commons: 3.9.7 (backport #472) (#473)
  - chore(armory-commons): Revert armorry commons & gradle upgrade (#474)
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
  - chore(build): upgrade to gradle 7 (#258) (#259)
  - [create-pull-request] automated change (#261) (#262)
  - chore(armory-commons): Revert gradle upgrade & armory commons (#263)

