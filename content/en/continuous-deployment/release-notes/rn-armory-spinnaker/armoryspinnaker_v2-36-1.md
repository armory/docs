---
title: v2.36.1 Armory Continuous Deployment Release (Spinnaker™ v1.36.1)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
date: 2025-02-20
description: >
  Release notes for Armory Continuous Deployment v2.36.1.
---

<!-- 
MAKE SURE TO ADD 'LTS' OR 'FEATURE' TO THE TITLE TO INDICATE RELEASE CATEGORY. 
FOR EXAMPLE, "Armory Continuous Deployment Release LTS" or "Armory Continuous Deployment Release Feature" so users know release category and support time period 
-->

## 2025/02/20 release notes

>Note: If you experience production issues after upgrading Armory Continuous Deployment, roll back to a previous working version and report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory CD 2.36.1, use Armory Operator 1.70 or later.

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




###  Spinnaker community contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.36.1](https://www.spinnaker.io/changelogs/1.36.1-changelog/) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

<details><summary>Expand to see the BOM</summary>
<pre class="highlight">
<code>artifactSources:
  dockerRegistry: docker.io/armory
dependencies:
  redis:
    commit: null
    version: 2:2.8.4-2
services:
  clouddriver:
    commit: e52a253da499f54ea951d46472ee20ada1326d1a
    version: 2.36.1
  deck:
    commit: 1c97b782e123ee219673c245878aeb59e87b0a06
    version: 2.36.1
  dinghy:
    commit: 50041173d1a043493409059e7fa5d7a1a80fb553
    version: 2.36.1
  echo:
    commit: 4c2efbbb9e57b64a1a4fa85aef8eeccc8aaa80a7
    version: 2.36.1
  fiat:
    commit: bd424d60f055e6694aeaf74af5b92862932b09c3
    version: 2.36.1
  front50:
    commit: 9e2606c2d386d00b18b76104564b6467ea2010d3
    version: 2.36.1
  gate:
    commit: cc3f1b3059533feb0bc770eebde4f2c0714c7800
    version: 2.36.1
  igor:
    commit: c5540e0bfe83bb87fa8896c7c7924113c17453b4
    version: 2.36.1
  kayenta:
    commit: 1dab7bb6f4156bdf7f15ef74722139e07ceb4581
    version: 2.36.1
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 9fa8bf04e3b5882c0b03d0309684ef0cd00a64c0
    version: 2.36.1
  rosco:
    commit: 80f1885bcd93da023fdb858d563cc24ccadce276
    version: 2.36.1
  terraformer:
    commit: 9756bee07eaabbb25b54812996314c22554ec1c0
    version: 2.36.1
timestamp: "2025-02-20 12:49:12"
version: 2.36.1
</code>
</pre>
</details>

### Armory


#### Armory Igor - 2.36.0...2.36.1


#### Terraformer™ - 2.36.0...2.36.1


#### Armory Rosco - 2.36.0...2.36.1


#### Armory Gate - 2.36.0...2.36.1


#### Armory Echo - 2.36.0...2.36.1


#### Armory Deck - 2.36.0...2.36.1

  - fix(metadata): Reverting MetadataFilterOverride (#1450) (#1451)

#### Armory Orca - 2.36.0...2.36.1


#### Armory Kayenta - 2.36.0...2.36.1


#### Dinghy™ - 2.36.0...2.36.1


#### Armory Front50 - 2.36.0...2.36.1


#### Armory Clouddriver - 2.36.0...2.36.1


#### Armory Fiat - 2.36.0...2.36.1



### Spinnaker


#### Spinnaker Igor - 1.36.1


#### Spinnaker Rosco - 1.36.1


#### Spinnaker Gate - 1.36.1


#### Spinnaker Echo - 1.36.1


#### Spinnaker Deck - 1.36.1


#### Spinnaker Orca - 1.36.1


#### Spinnaker Kayenta - 1.36.1


#### Spinnaker Front50 - 1.36.1


#### Spinnaker Clouddriver - 1.36.1


#### Spinnaker Fiat - 1.36.1


