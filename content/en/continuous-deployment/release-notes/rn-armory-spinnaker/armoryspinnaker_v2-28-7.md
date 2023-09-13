---
title: v2.28.7 Armory Release (OSS Spinnaker™ v1.28.0)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
date: 2023-09-13
description: >
  Release notes for Armory Continuous Deployment v2.28.7
---

## 2023/09/13 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a previous working version and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory 2.28.7, use Armory Operator 1.70 or later.

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
[Spinnaker v1.28.0](https://www.spinnaker.io/changelogs/1.28.0-changelog/) changelog for details.

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
    commit: 50b4f4881597a374a9ba85aac90c0c0b9b22cee5
    version: 2.28.7
  deck:
    commit: 5e7cef7a443e096cf8158c0c405c3ebbf8b97c35
    version: 2.28.7
  dinghy:
    commit: 912007004f7720b418cd133301c7fb20207e1f2f
    version: 2.28.7
  echo:
    commit: a602d9d5def0815cb52bdf6d695ca69cbf0abe3b
    version: 2.28.7
  fiat:
    commit: d0874307a60cbc457616569be910f4142c152586
    version: 2.28.7
  front50:
    commit: 3292cf2715a9e52bb4690601d4fd877407505ced
    version: 2.28.7
  gate:
    commit: c8058f4362f3f4ad108fa146d628a162445c7579
    version: 2.28.7
  igor:
    commit: 00998fa8b33acd6db5ffa8722e37593f608e9f64
    version: 2.28.7
  kayenta:
    commit: 3da923fd822202425b90a181c9734910c5c4a609
    version: 2.28.7
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 27a66c125270377772675b0e24d93566d878cfb9
    version: 2.28.7
  rosco:
    commit: 27d4a2b4a1d5f099b68471303d4fd14af156d46d
    version: 2.28.7
  terraformer:
    commit: ea9b0255b7d446bcbf0f0d4e03fc8699b7508431
    version: 2.28.7
timestamp: "2023-06-01 05:41:58"
version: 2.28.7
</code>
</pre>
</details>

### Armory


#### Armory Echo - 2.28.6...2.28.7


#### Armory Kayenta - 2.28.6...2.28.7

  - chore(cd): update base service version to kayenta:2023.06.01.03.10.17.release-1.28.x (#443)

#### Armory Igor - 2.28.6...2.28.7

  - chore(cd): update base service version to igor:2023.03.27.19.09.31.release-1.28.x (#426)
  - chore(cd): update armory-commons version to 3.11.5 (#450)
  - chore(cd): update armory-commons version to 3.11.6 (#453)

#### Armory Gate - 2.28.6...2.28.7


#### Armory Orca - 2.28.6...2.28.7

  - chore(cd): update base orca version to 2023.05.18.14.27.20.release-1.28.x (#645)

#### Armory Deck - 2.28.6...2.28.7

  - chore(cd): update base deck version to 2023.0.0-20230430115438.release-1.28.x (#1334)

#### Armory Fiat - 2.28.6...2.28.7

  - chore(cd): update armory-commons version to 3.11.5 (#472)
  - chore(cd): update armory-commons version to 3.11.6 (#476)

#### Armory Rosco - 2.28.6...2.28.7


#### Armory Front50 - 2.28.6...2.28.7


#### Terraformer™ - 2.28.6...2.28.7


#### Armory Clouddriver - 2.28.6...2.28.7

  - chore(cd): update base service version to clouddriver:2023.05.30.19.45.25.release-1.28.x (#880)

#### Dinghy™ - 2.28.6...2.28.7



### Spinnaker


#### Spinnaker Echo - 1.28.0


#### Spinnaker Kayenta - 1.28.0

  - chore(dependencies): Autobump orcaVersion (#963)

#### Spinnaker Igor - 1.28.0

  - chore(dependencies): Autobump fiatVersion (#1101)

#### Spinnaker Gate - 1.28.0


#### Spinnaker Orca - 1.28.0

  - fix(deployment): fixed missing namespace while fetching manifest details from clouddriver (#4453) (#4455)

#### Spinnaker Deck - 1.28.0

  - fix(aws): Fixing bugs related to clone CX when instance types are incompatible with image/region (backport #9901) (#9975)

#### Spinnaker Fiat - 1.28.0


#### Spinnaker Rosco - 1.28.0


#### Spinnaker Front50 - 1.28.0


#### Spinnaker Clouddriver - 1.28.0

  - chore(dependencies): Autobump fiatVersion (#5916)

