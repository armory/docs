---
title: v2.30.2 Armory Release (OSS Spinnaker™ v1.30.3)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
date: 2023-08-29
description: >
  Release notes for Armory Continuous Deployment v2.30.2
---

## 2023/08/29 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a previous working version and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory 2.30.2, use Armory Operator 1.70 or later.

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
[Spinnaker v1.30.3](https://www.spinnaker.io/changelogs/1.30.3-changelog/) changelog for details.

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
    commit: 9e69fcd6cd17f31e35eeb7d443cdbf9c2d9ac187
    version: 2.30.2
  deck:
    commit: 7737669d9a68843f448cc4c93ac2a6ea3485f95e
    version: 2.30.2
  dinghy:
    commit: 5250de80948732c8caac6ffc5293a8af80a63a0f
    version: 2.30.2
  echo:
    commit: 56844c654cd1b3981686933a9d5bc68011ee2bae
    version: 2.30.2
  fiat:
    commit: 30319b57d40a7e9fd61067b7e0d9fb73bf9a6c46
    version: 2.30.2
  front50:
    commit: ec0919166ced870668d787708c249945e9291a01
    version: 2.30.2
  gate:
    commit: df941ff5c34d14e794c8784c28a1b30b28754971
    version: 2.30.2
  igor:
    commit: 67b4c66f33b8b97b89e6b052654bebfea460a41f
    version: 2.30.2
  kayenta:
    commit: 4d82ef4a72129a715749005235ce0d6ba4778603
    version: 2.30.2
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 638d81c8d3186b6deb8829574c6ac5b65c88c94a
    version: 2.30.2
  rosco:
    commit: e74de6eaccbed6301505d9f3d2f6745b410211a7
    version: 2.30.2
  terraformer:
    commit: 650746ae3f596f9c6458987487c81840c85dd2a0
    version: 2.30.2
timestamp: "2023-08-29 01:03:06"
version: 2.30.2
</code>
</pre>
</details>

### Armory


#### Terraformer™ - 2.30.1...2.30.2


#### Armory Igor - 2.30.1...2.30.2


#### Armory Clouddriver - 2.30.1...2.30.2

  - chore(cd): update base service version to clouddriver:2023.08.25.16.41.50.release-1.30.x (#933)
  - chore(cd): update base service version to clouddriver:2023.08.28.14.14.14.release-1.30.x (#937)

#### Armory Rosco - 2.30.1...2.30.2


#### Armory Gate - 2.30.1...2.30.2

  - fix: esapi CVE scan report (#602) (#603)

#### Armory Front50 - 2.30.1...2.30.2


#### Armory Deck - 2.30.1...2.30.2


#### Armory Kayenta - 2.30.1...2.30.2


#### Dinghy™ - 2.30.1...2.30.2


#### Armory Fiat - 2.30.1...2.30.2


#### Armory Orca - 2.30.1...2.30.2


#### Armory Echo - 2.30.1...2.30.2



### Spinnaker


#### Spinnaker Igor - 1.30.3


#### Spinnaker Clouddriver - 1.30.3

  - fix(builds): Backport flag for installing aws cli (#6006)

#### Spinnaker Rosco - 1.30.3


#### Spinnaker Gate - 1.30.3


#### Spinnaker Front50 - 1.30.3


#### Spinnaker Deck - 1.30.3


#### Spinnaker Kayenta - 1.30.3


#### Spinnaker Fiat - 1.30.3


#### Spinnaker Orca - 1.30.3


#### Spinnaker Echo - 1.30.3


