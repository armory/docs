---
title: v2.32.1 Armory Continuous Deployment Release (Spinnaker™ v1.32.4)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
date: 2024-03-14
description: >
  Release notes for Armory Continuous Deployment v2.32.1.
---

<!-- 
MAKE SURE TO ADD 'LTS' OR 'FEATURE' TO THE TITLE TO INDICATE RELEASE CATEGORY. 
FOR EXAMPLE, "Armory Continuous Deployment Release LTS" or "Armory Continuous Deployment Release Feature" so users know release category and support time period 
-->

## 2024/03/14 release notes

>Note: If you experience production issues after upgrading Armory Continuous Deployment, roll back to a previous working version and report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory CD 2.32.1, use Armory Operator 1.70 or later.

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
[Spinnaker v1.32.4](https://www.spinnaker.io/changelogs/1.32.4-changelog/) changelog for details.

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
    commit: b29acea67a40b4145431137ba96454c1d1bf0d73
    version: 2.32.1
  deck:
    commit: e7c8c0982afe9a49ab6c3d230f3aaa38e874eb30
    version: 2.32.1
  dinghy:
    commit: f5b14ffba75721322ada662f2325e80ec86347de
    version: 2.32.1
  echo:
    commit: 9d2abeeea4341e5ba94654925ba6488a9038af3f
    version: 2.32.1
  fiat:
    commit: 3f3fe6bf09708847a0f853bc74f6755920a4312b
    version: 2.32.1
  front50:
    commit: ba318cd2c445f14e5d6c3db87fa1658549385403
    version: 2.32.1
  gate:
    commit: dd64887668a2e2212667ca942e0bfd303aa34c60
    version: 2.32.1
  igor:
    commit: 9339ab63ab3d85ebcb00131033d19f26ad436f05
    version: 2.32.1
  kayenta:
    commit: bccd150fcc8a7cb7df537ec6269bce5d2843c703
    version: 2.32.1
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 9d45d87956abd9aad29ef8f9858e602e72d78c3c
    version: 2.32.1
  rosco:
    commit: dfe611ffdd2cf9ae7c524fb9970af47350ca5e96
    version: 2.32.1
  terraformer:
    commit: 6dbdb8b4c277cca4285b4d29d10f6cf3765f7590
    version: 2.32.1
timestamp: "2024-03-12 14:53:28"
version: 2.32.1
</code>
</pre>
</details>

### Armory


#### Armory Front50 - 2.32.0...2.32.1

  - chore(cd): update armory-commons version to 3.15.3 (#659)
  - chore(cd): update armory-commons version to 3.15.4 (#660)
  - Fixing gcs dependencies (#662)
  - chore(armory-commons): Update armory-commons to 3.15.4 (#665)
  - chore(cd): update base service version to front50:2024.03.08.16.52.13.release-1.32.x (#666)
  - chore(cd): update base service version to front50:2024.03.08.19.18.53.release-1.32.x (#667)

#### Armory Clouddriver - 2.32.0...2.32.1

  - chore(cd): update base service version to clouddriver:2024.02.27.14.37.13.release-1.32.x (#1083)
  - chore(cd): update armory-commons version to 3.15.3 (#1086)
  - chore(cd): update armory-commons version to 3.15.4 (#1088)
  - chore(cd): update base service version to clouddriver:2024.03.08.19.52.28.release-1.32.x (#1091)

#### Armory Deck - 2.32.0...2.32.1


#### Armory Orca - 2.32.0...2.32.1

  - chore(cd): update base orca version to 2024.02.27.15.33.36.release-1.32.x (#833)
  - chore(cd): update armory-commons version to 3.15.3 (#836)
  - chore(cd): update armory-commons version to 3.15.4 (#837)
  - chore(cd): update base orca version to 2024.03.08.16.54.30.release-1.32.x (#840)
  - chore(cd): update base orca version to 2024.03.08.19.21.42.release-1.32.x (#841)

#### Dinghy™ - 2.32.0...2.32.1


#### Armory Gate - 2.32.0...2.32.1

  - fix: esapi CVE scan report (#602) (#700)
  - chore(cd): update armory-commons version to 3.15.4 (#704)
  - chore(cd): update base service version to gate:2024.03.08.19.17.43.release-1.32.x (#707)

#### Armory Rosco - 2.32.0...2.32.1

  - chore(cd): update armory-commons version to 3.15.3 (#647)
  - chore(cd): update armory-commons version to 3.15.4 (#648)
  - chore(cd): update base service version to rosco:2024.03.08.16.49.31.release-1.32.x (#650)

#### Armory Echo - 2.32.0...2.32.1

  - chore(cd): update base service version to echo:2024.02.27.15.33.43.release-1.32.x (#692)
  - chore(cd): update armory-commons version to 3.15.3 (#694)
  - chore(cd): update armory-commons version to 3.15.4 (#695)
  - chore(cd): update base service version to echo:2024.03.08.16.50.19.release-1.32.x (#697)
  - chore(cd): update base service version to echo:2024.03.08.19.17.18.release-1.32.x (#698)

#### Terraformer™ - 2.32.0...2.32.1

  - fix(remote/artifacts): Passing user to clouddriver when using remote store (#548) (#549)

#### Armory Fiat - 2.32.0...2.32.1

  - chore(cd): update armory-commons version to 3.15.4 (#587)
  - chore(cd): update base service version to fiat:2024.03.08.16.48.59.release-1.32.x (#590)

#### Armory Kayenta - 2.32.0...2.32.1

  - chore(cd): update armory-commons version to 3.15.4 (#524)
  - chore(cd): update base service version to kayenta:2024.03.08.20.48.11.release-1.32.x (#525)

#### Armory Igor - 2.32.0...2.32.1

  - chore(cd): update base service version to igor:2024.02.27.15.32.19.release-1.32.x (#579)
  - chore(cd): update armory-commons version to 3.15.3 (#581)
  - chore(cd): update armory-commons version to 3.15.4 (#582)
  - chore(cd): update base service version to igor:2024.03.08.16.52.17.release-1.32.x (#584)
  - chore(cd): update base service version to igor:2024.03.08.19.18.39.release-1.32.x (#585)


### Spinnaker


#### Spinnaker Front50 - 1.32.4

  - chore(dependencies): Autobump korkVersion (#1439)
  - chore(dependencies): Autobump fiatVersion (#1440)

#### Spinnaker Clouddriver - 1.32.4

  - fix: Change the agent type name to not include the account name since this would generate LOTS of tables and cause problems long term (#6158) (#6165)
  - chore(dependencies): Autobump korkVersion (#6169)
  - chore(dependencies): Autobump fiatVersion (#6170)

#### Spinnaker Deck - 1.32.4


#### Spinnaker Orca - 1.32.4

  - fix(jenkins): Enable properties and artifacts with job name as query parameter (#4661) (#4664)
  - chore(dependencies): Autobump korkVersion (#4667)
  - chore(dependencies): Autobump fiatVersion (#4668)

#### Spinnaker Gate - 1.32.4

  - chore(dependencies): Autobump korkVersion (#1773)
  - chore(dependencies): Autobump fiatVersion (#1774)

#### Spinnaker Rosco - 1.32.4

  - chore(dependencies): Autobump korkVersion (#1077)

#### Spinnaker Echo - 1.32.4

  - fix(jenkins): Enable properties and artifacts with job name as query parameter (#1393) (#1396)
  - chore(dependencies): Autobump korkVersion (#1398)
  - chore(dependencies): Autobump fiatVersion (#1399)

#### Spinnaker Fiat - 1.32.4

  - chore(dependencies): Autobump korkVersion (#1145)

#### Spinnaker Kayenta - 1.32.4

  - chore(dependencies): Autobump orcaVersion (#1023)

#### Spinnaker Igor - 1.32.4

  - fix(jenkins): Enable properties and artifacts with job name as query parameter (#1230) (#1233)
  - chore(dependencies): Autobump korkVersion (#1235)
  - chore(dependencies): Autobump fiatVersion (#1236)

