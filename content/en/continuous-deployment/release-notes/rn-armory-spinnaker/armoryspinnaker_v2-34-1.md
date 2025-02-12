---
title: v2.34.1 Armory Continuous Deployment Release (Spinnaker™ v1.34.6)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
date: 2025-02-12
description: >
  Release notes for Armory Continuous Deployment v2.34.1.
---

<!-- 
MAKE SURE TO ADD 'LTS' OR 'FEATURE' TO THE TITLE TO INDICATE RELEASE CATEGORY. 
FOR EXAMPLE, "Armory Continuous Deployment Release LTS" or "Armory Continuous Deployment Release Feature" so users know release category and support time period 
-->

## 2025/02/12 release notes

>Note: If you experience production issues after upgrading Armory Continuous Deployment, roll back to a previous working version and report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory CD 2.34.1, use Armory Operator 1.70 or later.

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
[Spinnaker v1.34.6](https://www.spinnaker.io/changelogs/1.34.6-changelog/) changelog for details.

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
    commit: 7602c40d66f8d99254c740ac782fb4c7a8e547db
    version: 2.34.1
  deck:
    commit: 4e15526f16000326035436c57783415b5e5c1d72
    version: 2.34.1
  dinghy:
    commit: fbba492fb3d6c116d75f9ca959f6b5d84ab473a6
    version: 2.34.1
  echo:
    commit: 391b1f4924679a0ce23c216d4b0d8bc4cfdd9ed5
    version: 2.34.1
  fiat:
    commit: df367d6ed0185b61abcea1e943109503a4b7928b
    version: 2.34.1
  front50:
    commit: eb8691d3c549c86ba3547b0710828b9f37c62f38
    version: 2.34.1
  gate:
    commit: f54a45abcf7a622e4233e471723c2b54d3972c5d
    version: 2.34.1
  igor:
    commit: 0ddc88fc33b097ca8d822e91591218c2216dbbc2
    version: 2.34.1
  kayenta:
    commit: b8983452be0897fc98a6c47d84f8689a9e0e623b
    version: 2.34.1
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 9385c93a4ce4f30a5484989b0b9913b6cd7e24d6
    version: 2.34.1
  rosco:
    commit: f0e9fdb04e392820324f5edb72c0ff46b5307701
    version: 2.34.1
  terraformer:
    commit: d4b6e9f53f3a2b595ce25e0b044318d47fd239b6
    version: 2.34.1
timestamp: "2024-08-29 12:35:20"
version: 2.34.1
</code>
</pre>
</details>

### Armory


#### Armory Clouddriver - 2.34.0...2.34.1

  - chore(cd): update base service version to clouddriver:2024.08.08.19.08.20.release-1.34.x (#1157)
  - chore(cd): update base service version to clouddriver:2024.08.17.00.37.38.release-1.34.x (#1160)
  - chore(cd): update base service version to clouddriver:2024.08.17.03.54.14.release-1.34.x (#1161)
  - chore(cd): update base service version to clouddriver:2024.08.17.21.27.20.release-1.34.x (#1163)
  - chore(cd): update base service version to clouddriver:2024.08.18.02.43.56.release-1.34.x (#1165)

#### Armory Deck - 2.34.0...2.34.1

  - chore(cd): update base deck version to 2024.0.0-20240808191056.release-1.34.x (#1428)

#### Dinghy™ - 2.34.0...2.34.1


#### Armory Echo - 2.34.0...2.34.1

  - chore(cd): update base service version to echo:2024.08.16.23.59.20.release-1.34.x (#737)
  - chore(cd): update base service version to echo:2024.08.17.03.16.29.release-1.34.x (#738)

#### Armory Fiat - 2.34.0...2.34.1

  - chore(cd): update base service version to fiat:2024.08.16.23.56.14.release-1.34.x (#625)

#### Armory Front50 - 2.34.0...2.34.1

  - chore(cd): update base service version to front50:2024.08.16.23.58.39.release-1.34.x (#708)
  - chore(cd): update base service version to front50:2024.08.18.02.21.08.release-1.34.x (#711)
  - chore(cd): update base service version to front50:2024.08.23.16.11.18.release-1.34.x (#712)

#### Armory Gate - 2.34.0...2.34.1

  - chore(cd): update base service version to gate:2024.08.09.02.35.08.release-1.34.x (#744)
  - chore(cd): update base service version to gate:2024.08.10.04.22.27.release-1.34.x (#745)
  - chore(cd): update base service version to gate:2024.08.16.23.57.38.release-1.34.x (#746)
  - chore(cd): update base service version to gate:2024.08.17.03.15.23.release-1.34.x (#747)

#### Armory Igor - 2.34.0...2.34.1

  - chore(cd): update base service version to igor:2024.08.17.03.16.09.release-1.34.x (#623)

#### Armory Kayenta - 2.34.0...2.34.1

  - chore(cd): update base service version to kayenta:2024.08.08.20.11.17.release-1.34.x (#549)
  - chore(cd): update base service version to kayenta:2024.08.17.05.49.51.release-1.34.x (#552)

#### Armory Orca - 2.34.0...2.34.1

  - chore(cd): update base orca version to 2024.08.17.02.35.16.release-1.34.x (#932)
  - chore(cd): update base orca version to 2024.08.17.03.26.59.release-1.34.x (#933)

#### Armory Rosco - 2.34.0...2.34.1

  - chore(cd): update base service version to rosco:2024.08.17.00.00.56.release-1.34.x (#684)

#### Terraformer™ - 2.34.0...2.34.1

  - chore(terraformer): Backport fixes (#571)


### Spinnaker


#### Spinnaker Clouddriver - 1.34.6

  - chore(gcp): Adding STRONG_COOKIE_AFFINITY in gcp LB model (#6259) (#6262)
  - chore(dependencies): Autobump korkVersion (#6266)
  - chore(dependencies): Autobump fiatVersion (#6267)
  - fix(gha): only bump halyard on master (#6268) (#6269)
  - fix(gha): remove whitespace from BRANCH in release.yml (#6271) (#6272)

#### Spinnaker Deck - 1.34.6

  - chore(gcp): Adding STRONG_COOKIE_AFFINITY in gcp LB model (#10124) (#10127)

#### Spinnaker Echo - 1.34.6

  - chore(dependencies): Autobump korkVersion (#1417)
  - feat(pipelinetriggers): set pipeline-cache.filterFront50Pipelines to true by default (#1416)
  - chore(dependencies): Autobump fiatVersion (#1413)
  - chore(dependencies): Autobump korkVersion (#1440)
  - chore(dependencies): Autobump fiatVersion (#1441)

#### Spinnaker Fiat - 1.34.6

  - chore(dependencies): Autobump korkVersion (#1156)
  - chore(dependencies): Autobump korkVersion (#1153)
  - chore(dependencies): Autobump korkVersion (#1177)

#### Spinnaker Front50 - 1.34.6

  - chore(dependencies): Autobump korkVersion (#1488)
  - chore(dependencies): Autobump fiatVersion (#1489)
  - fix(gha): only bump halyard on master (#1490) (#1491)
  - fix(front50-gcs): Fix ObjectType filenames for GCS Front50 persistent store (#1493) (#1494)

#### Spinnaker Gate - 1.34.6

  - fix(web/test): stop leaking system properties from FunctionalSpec (#1798) (#1818)
  - fix(core): remove ErrorPageSecurityFilter bean named errorPageSecurityInterceptor (#1817)
  - chore(dependencies): Autobump korkVersion (#1821)
  - chore(dependencies): Autobump fiatVersion (#1822)

#### Spinnaker Igor - 1.34.6

  - chore(dependencies): Autobump korkVersion (#1253)
  - chore(dependencies): Autobump fiatVersion (#1250)
  - chore(dependencies): Autobump korkVersion (#1272)
  - chore(dependencies): Autobump fiatVersion (#1273)

#### Spinnaker Kayenta - 1.34.6

  - fix(stackdriver): handle null timeSeries and empty points (#1047) (#1050)
  - chore(dependencies): Autobump orcaVersion (#1058)

#### Spinnaker Orca - 1.34.6

  - chore(dependencies): Autobump korkVersion (#4776)
  - chore(dependencies): Autobump fiatVersion (#4777)

#### Spinnaker Rosco - 1.34.6

  - chore(dependencies): Autobump korkVersion (#1106)

