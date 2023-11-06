---
title: v2.30.4 Armory Release (OSS Spinnaker™ v1.30.4)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
date: 2023-11-06
description: >
  Release notes for Armory Continuous Deployment v2.30.4
---

## 2023/11/06 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a previous working version and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory 2.30.4, use Armory Operator 1.70 or later.

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
[Spinnaker v1.30.4](https://www.spinnaker.io/changelogs/1.30.4-changelog/) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>artifactSources:
  dockerRegistry: docker.io/armory
dependencies:
  redis:
    commit: null
    version: 2:2.8.4-2
services:
  clouddriver:
    commit: 767aa739e9c38d2ec7822e9e9a1838b69a56d4c0
    version: 2.30.4
  deck:
    commit: 305d4e3ccdd7ad009c14a0093cd64bdb0ad9aeaa
    version: 2.30.4
  dinghy:
    commit: a3b59d9e4b810cc968d0f5e8e8370e1670574768
    version: 2.30.4
  echo:
    commit: 2ef241fd3da29fb70cdb05432d022f0edd752d51
    version: 2.30.4
  fiat:
    commit: 5d44e1f53d2f33b17f8decfb057a18cfe4b6fa08
    version: 2.30.4
  front50:
    commit: 5d9bb31f65f96087be30ce96cea1b6d481a6bef4
    version: 2.30.4
  gate:
    commit: 5758316afba1260d2012730c471fd461819e7f39
    version: 2.30.4
  igor:
    commit: 3123451525458f96548859b9bf2b15c89810f577
    version: 2.30.4
  kayenta:
    commit: 1d2f5193ec681b5122fe7c34da6bbd569da8e0b8
    version: 2.30.4
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: abf688128f3557e53d8873b5f2fe623b1ad478f9
    version: 2.30.4
  rosco:
    commit: 7907c80fd9ca1d956d5927a3e190617671b7e012
    version: 2.30.4
  terraformer:
    commit: 249e7be18074af100212ddd554d9fb35afd65873
    version: 2.30.4
timestamp: "2023-10-19 13:42:07"
version: 2.30.4
</code>
</pre>
</details>

### Armory


#### Dinghy™ - 2.30.3...2.30.4


#### Armory Echo - 2.30.3...2.30.4


#### Armory Clouddriver - 2.30.3...2.30.4


#### Armory Kayenta - 2.30.3...2.30.4


#### Armory Gate - 2.30.3...2.30.4

  - Updating Banner plugin to 0.2.0 (#630) (#631)

#### Terraformer™ - 2.30.3...2.30.4


#### Armory Rosco - 2.30.3...2.30.4

  - chore(cd): update base service version to rosco:2023.10.18.06.02.34.release-1.30.x (#591)

#### Armory Deck - 2.30.3...2.30.4

  - chore(cd): update base deck version to 2023.0.0-20231018060032.release-1.30.x (#1359)

#### Armory Igor - 2.30.3...2.30.4

  - fix: NoSuchMethodError exception in JenkinsClient. (#377) (#528)

#### Armory Orca - 2.30.3...2.30.4

  - chore(cd): update base orca version to 2023.10.09.23.59.23.release-1.30.x (#738)
  - fix(terraformer): Ignoring logs from the Terraformer stage context (#740) (#741)
  - chore(cd): update base orca version to 2023.10.18.06.01.45.release-1.30.x (#752)

#### Armory Fiat - 2.30.3...2.30.4


#### Armory Front50 - 2.30.3...2.30.4



### Spinnaker


#### Spinnaker Echo - 1.30.4


#### Spinnaker Clouddriver - 1.30.4


#### Spinnaker Kayenta - 1.30.4


#### Spinnaker Gate - 1.30.4


#### Spinnaker Rosco - 1.30.4

  - feat(helm/bake): Add additional input fields where we can fill in details of the APIs versions (#1020) (#1029)

#### Spinnaker Deck - 1.30.4

  - feat(helm/bake): Add additional input fields where we can fill in details of the APIs versions (#10036) (#10046)

#### Spinnaker Igor - 1.30.4


#### Spinnaker Orca - 1.30.4

  - fix(front50): teach MonitorPipelineTask to handle missing/null execution ids (#4555) (#4558)
  - feat(helm/bake): Add additional input fields where we can fill in details of the APIs versions (#4546) (#4563)

#### Spinnaker Fiat - 1.30.4


#### Spinnaker Front50 - 1.30.4


