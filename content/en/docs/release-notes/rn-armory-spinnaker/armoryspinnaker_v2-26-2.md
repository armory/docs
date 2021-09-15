---
title: v2.26.2 Armory Release (OSS Spinnaker™ v1.26.6)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping --> 
description: >
  Release notes for Armory Enterprise v2.26.2 
---

## 2021/09/90 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.26.2, use one of the following tools:

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
[Spinnaker v1.26.6](https://www.spinnaker.io/changelogs/1.26.6-changelog/) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.26.2
timestamp: "2021-09-02 18:30:45"
services:
    clouddriver:
        commit: 942f74be6aa77ebd34f9183437171848e3b9fd35
        version: 2.26.19
    deck:
        commit: a2296787ab03efc53c85d03cbf8eecddedab6094
        version: 2.26.9
    dinghy:
        commit: 0796be13e88a77c72d94d4e0538a4fab152366b8
        version: 2.26.10
    echo:
        commit: b2f76d93f06a0434987fb00daa77a22396c54658
        version: 2.26.10
    fiat:
        commit: 6aba766ef74c6fe186d7f047095a775936bef71f
        version: 2.26.11
    front50:
        commit: 8bdd585434b9bde9834bf580d96fdd42d12dc933
        version: 2.26.12
    gate:
        commit: 1d66c8a302ed4bf7ad07ce3944b7d7e43baae0a0
        version: 2.26.10
    igor:
        commit: 4f76b327913693263e18a670dc8782d77bbc8ee1
        version: 2.26.10
    kayenta:
        commit: 4f668d1297a5d205d516667c1af6902d0d9f380f
        version: 2.26.11
    monitoring-daemon:
        version: 2.26.0
    monitoring-third-party:
        version: 2.26.0
    orca:
        commit: 6b547ff4ac81742d1c4cb7fab713a16f6deefd34
        version: 2.26.16
    rosco:
        commit: 1dfc60f1f70ccdadc2cc03ff9f27b5ca39bb9c39
        version: 2.26.14
    terraformer:
        commit: d20745f6ac1fb87b876dbd255b0b26004fb0341a
        version: 2.26.12
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Deck - 2.26.7...2.26.9

  - fix(build): remove redhat publishing (#1109)
  - chore(actions): include cd actions (#1111)
  - chore(cd): update base deck version to 2021.0.0-20210820171135.release-1.26.x (#1112)

#### Armory Clouddriver - 2.26.12...2.26.19

  - chore(cd): update base service version to clouddriver:2021.07.28.19.49.01.release-1.26.x (#381)
  - chore(cd): update base service version to clouddriver:2021.07.28.23.39.00.release-1.26.x (#382)
  - chore(cd): update base service version to clouddriver:2021.07.29.00.03.42.release-1.26.x (#383)
  - chore(cd): update base service version to clouddriver:2021.07.29.00.21.10.release-1.26.x (#384)
  - chore(cd): update base service version to clouddriver:2021.08.17.07.55.22.release-1.26.x (#396)
  - chore(cd): update base service version to clouddriver:2021.08.18.19.46.18.release-1.26.x (#397)
  - fix(build): remove redhat publishing (#405)

#### Armory Rosco - 2.26.13...2.26.14


#### Armory Fiat - 2.26.10...2.26.11

  - fix(build): update gha
  - fix(build): remove redhat publishing (#245) (#246)

#### Armory Igor - 2.26.9...2.26.10

  - fix(build): remove redhat publishing (#252)

#### Armory Front50 - 2.26.11...2.26.12

  - fix(build): remove redhat publishing (#305)

#### Armory Gate - 2.26.9...2.26.10

  - fix(build): remove redhat publishing (#320)

#### Armory Kayenta - 2.26.10...2.26.11

  - fix(build): remove redhat publishing (#275)

#### Terraformer™ - 2.26.9...2.26.12

  - feat(tf): Add support for newer TF versions (#432) (#434)

#### Armory Orca - 2.26.15...2.26.16

  - chore(cd): update base orca version to 2021.08.17.08.55.02.release-1.26.x (#354)

#### Dinghy™ - 2.26.6...2.26.10

  - fix(notif): honor github endpoint in notifier constructor (backport #447) (#448)
  - fix(build): add dinghy to stackfile (#449)
  - fix(ubi): removing ubi publishing (#451)

#### Armory Echo - 2.26.9...2.26.10

  - fix(build): remove redhat publishing (#364)

