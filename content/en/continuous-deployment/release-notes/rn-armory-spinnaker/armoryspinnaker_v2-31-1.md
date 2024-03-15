---
title: v2.31.1 Armory Continuous Deployment Release (Spinnaker™ v1.31.3)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
date: 2024-03-15
description: >
  Release notes for Armory Continuous Deployment v2.31.1.
---

<!-- 
MAKE SURE TO ADD 'LTS' OR 'FEATURE' TO THE TITLE TO INDICATE RELEASE CATEGORY. 
FOR EXAMPLE, "Armory Continuous Deployment Release LTS" or "Armory Continuous Deployment Release Feature" so users know release category and support time period 
-->

## 2024/03/15 release notes

>Note: If you experience production issues after upgrading Armory Continuous Deployment, roll back to a previous working version and report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory CD 2.31.1, use Armory Operator 1.70 or later.

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
[Spinnaker v1.31.3](https://www.spinnaker.io/changelogs/1.31.3-changelog/) changelog for details.

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
    commit: cb7a25cc5d610afc67346cf25af98082566e38f6
    version: 2.31.1
  deck:
    commit: 1dd95e4ef5ed631f24253bf917200c3cf52655af
    version: 2.31.1
  dinghy:
    commit: 1bbb649f71d128d167229d72a1c94aa480f99684
    version: 2.31.1
  echo:
    commit: abefa81c6eac597a0db45e33ebaebd464cfdc5df
    version: 2.31.1
  fiat:
    commit: f1079f69f0184aae517680c48283cf9a52c9cf26
    version: 2.31.1
  front50:
    commit: 13814c48944265261af52c3929a4b96fc6c45add
    version: 2.31.1
  gate:
    commit: abfb0120ca617cb5806c7f2082ab4f8e9d7190b2
    version: 2.31.1
  igor:
    commit: a66db7a9037a4ddec4e131ec0b0bb137956a9395
    version: 2.31.1
  kayenta:
    commit: 18b22f0e9ca778f354ec5ac8255d0014ba6339ff
    version: 2.31.1
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: e46aab32af0ec1031eb216fc3fa2cf00f957aea0
    version: 2.31.1
  rosco:
    commit: 9812503db8271e32cd5d7960db12441fa8a39494
    version: 2.31.1
  terraformer:
    commit: 50082463ccd180cb4763078671a105ab70dee5e6
    version: 2.31.1
timestamp: "2024-03-14 18:17:56"
version: 2.31.1
</code>
</pre>
</details>

### Armory


#### Armory Orca - 2.31.0...2.31.1

  - Adding aws mysql jdbc drivers (#816)
  - chore(cd): update armory-commons version to 3.14.4 (#832)
  - chore(cd): update armory-commons version to 3.14.5 (#835)
  - chore(cd): update base orca version to 2024.03.11.15.12.53.release-1.31.x (#843)
  - chore(cd): update base orca version to 2024.03.14.15.56.51.release-1.31.x (#848)
  - chore(cd): update base orca version to 2024.03.14.16.21.01.release-1.31.x (#849)

#### Terraformer™ - 2.31.0...2.31.1


#### Armory Fiat - 2.31.0...2.31.1


#### Armory Igor - 2.31.0...2.31.1

  - chore(cd): update base service version to igor:2024.01.22.15.24.57.release-1.31.x (#555)
  - chore: OS Updates (#516) (#567)
  - chore(cd): update armory-commons version to 3.14.4 (#578)
  - chore(cd): update armory-commons version to 3.14.5 (#580)
  - chore(cd): update base service version to igor:2024.03.14.15.50.26.release-1.31.x (#589)

#### Armory Deck - 2.31.0...2.31.1


#### Armory Echo - 2.31.0...2.31.1

  - chore(cd): update armory-commons version to 3.14.4 (#691)
  - chore(cd): update armory-commons version to 3.14.5 (#693)
  - chore(cd): update base service version to echo:2024.03.14.14.32.38.release-1.31.x (#701)
  - chore(cd): update base service version to echo:2024.03.14.16.01.06.release-1.31.x (#702)

#### Armory Rosco - 2.31.0...2.31.1

  - fix(ci): Removing integration tests as not stable (backport #627) (#629)
  - chore(cd): update armory-commons version to 3.14.4 (#645)
  - chore(cd): update armory-commons version to 3.14.5 (#646)

#### Armory Kayenta - 2.31.0...2.31.1

  - chore(cd): update base service version to kayenta:2023.11.21.08.03.27.release-1.31.x (#499)
  - chore(cd): update armory-commons version to 3.14.4 (#521)
  - chore(cd): update armory-commons version to 3.14.5 (#522)

#### Armory Front50 - 2.31.0...2.31.1

  - chore: Front50 OS upgrade (#604) (#640)
  - chore(cd): update armory-commons version to 3.14.4 (#657)
  - chore(cd): update armory-commons version to 3.14.5 (#658)
  - Updating force dependency on com.google.cloud:google-cloud-storage:1.108.0 (#663) (#664)

#### Armory Clouddriver - 2.31.0...2.31.1

  - chore(cd): update armory-commons version to 3.14.4 (#1081)
  - chore(cd): update base service version to clouddriver:2024.02.27.14.37.01.release-1.31.x (#1082)
  - chore(cd): update armory-commons version to 3.14.5 (#1085)

#### Armory Gate - 2.31.0...2.31.1

  - chore(gate): Removing Instance registration from Gate (backport #677) (#679)
  - fix(header): Fixing header plugin reference in config (backport #684) (#686)
  - chore(cd): update armory-commons version to 3.14.4 (#701)
  - chore(cd): update armory-commons version to 3.14.5 (#702)

#### Dinghy™ - 2.31.0...2.31.1

  - chore(dependencies): v0.0.0-20240213103436-d0dc889db2c6 (backport #529) (#531)


### Spinnaker


#### Spinnaker Orca - 1.31.3

  - feat(servergroup): Allow users to opt-out of the target desired size check when verifying if the instances scaled up or down successfully (#4649) (#4652)
  - feat(jenkins): Enable Jenkins job triggers for jobs in sub-folders (#4618) (#4633)
  - fix(jenkins): Enable properties and artifacts with job name as query parameter (#4661) (#4677)

#### Spinnaker Fiat - 1.31.3


#### Spinnaker Igor - 1.31.3

  - feat(jenkins): Enable Jenkins job triggers for jobs in sub-folders (#1204) (#1215)
  - fix(jenkins): Enable properties and artifacts with job name as query parameter (#1230) (#1240)

#### Spinnaker Deck - 1.31.3


#### Spinnaker Echo - 1.31.3

  - feat(jenkins): Enable Jenkins job triggers for jobs in sub-folders (#1373) (#1380)
  - fix(jenkins): Enable properties and artifacts with job name as query parameter (#1393) (#1403)

#### Spinnaker Rosco - 1.31.3


#### Spinnaker Kayenta - 1.31.3

  - chore(dependencies): Autobump orcaVersion (#1001)

#### Spinnaker Front50 - 1.31.3


#### Spinnaker Clouddriver - 1.31.3

  - fix: Change the agent type name to not include the account name since this would generate LOTS of tables and cause problems long term (#6158) (#6164)

#### Spinnaker Gate - 1.31.3


