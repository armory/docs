---
title: v2.27.8 Armory Release (OSS Spinnaker™ v1.27.0)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
date: 2023-04-18
description: >
  Release notes for Armory Continuous Deployment v2.27.8
---

## 2023/04/18 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a previous working version and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory 2.27.8, use Armory Operator 1.70 or later.

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
[Spinnaker v1.27.0](https://www.spinnaker.io/changelogs/1.27.0-changelog/) changelog for details.

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
    commit: a3347ca5e207273abe60ca48e98bf494e6d8d359
    version: 2.27.8
  deck:
    commit: 57f5d89f15f6f9ddc5c3f4554e4b0a3bb6f03e2b
    version: 2.27.8
  dinghy:
    commit: d9146416b57d6c7008cfe6323ba3b0e6527181d0
    version: 2.27.8
  echo:
    commit: b220bcaa01be72ca2c4489203bc5ceb53d83e8af
    version: 2.27.8
  fiat:
    commit: e23c8b8a65463100c7075b1aacc140a0e0dc5216
    version: 2.27.8
  front50:
    commit: 5e1fe36c4b8df29cc9cb4d7af581a44b0ca44e59
    version: 2.27.8
  gate:
    commit: 9cd1a1174ee0bd19577ffdbd6aa11ad432a67082
    version: 2.27.8
  igor:
    commit: ebfdd8b8068fe1ff1ba3e7c25cd2b0c0fa803bd9
    version: 2.27.8
  kayenta:
    commit: 822b3339a4dbbccb9a135c102d8ba1ff199d49ec
    version: 2.27.8
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 2aa5a723767a5972a3b31278a1dcf5af32e66b99
    version: 2.27.8
  rosco:
    commit: 8b94ccff09fe762d896df9052e4199af6dd9b666
    version: 2.27.8
  terraformer:
    commit: 736ece67b4a52a612262cbe844d1edd3ad176d19
    version: 2.27.8
timestamp: "2023-03-22 15:19:48"
version: 2.27.8
</code>
</pre>
</details>

### Armory


#### Armory Fiat - 2.27.7...2.27.8

  - chore(cd): update base service version to fiat:2023.02.28.17.42.01.release-1.27.x (#439)
  - chore(cd): update base service version to fiat:2023.03.16.17.57.42.release-1.27.x (#447)

#### Armory Igor - 2.27.7...2.27.8

  - chore(cd): update base service version to igor:2023.02.28.17.45.14.release-1.27.x (#417)
  - chore(cd): update base service version to igor:2023.02.28.19.16.26.release-1.27.x (#418)

#### Armory Gate - 2.27.7...2.27.8

  - chore(cd): update base service version to gate:2023.02.28.17.43.36.release-1.27.x (#520)
  - chore(cd): update base service version to gate:2023.02.28.19.18.24.release-1.27.x (#521)

#### Armory Orca - 2.27.7...2.27.8

  - chore(cd): update base orca version to 2023.02.28.17.51.52.release-1.27.x (#594)
  - chore(cd): update base orca version to 2023.02.28.19.23.37.release-1.27.x (#595)

#### Armory Kayenta - 2.27.7...2.27.8

  - chore(cd): update base service version to kayenta:2023.02.28.21.15.17.release-1.27.x (#392)

#### Terraformer™ - 2.27.7...2.27.8

  - chore(alpine): Update alpine version (backport #497) (#498)

#### Armory Rosco - 2.27.7...2.27.8

  - chore(cd): update base service version to rosco:2023.02.28.17.41.47.release-1.27.x (#498)

#### Armory Deck - 2.27.7...2.27.8

  - chore(alpine): Upgrade alpine version (backport #1302) (#1304)

#### Armory Clouddriver - 2.27.7...2.27.8

  - chore(cd): update base service version to clouddriver:2023.02.22.23.00.31.release-1.27.x (#805)
  - chore(cd): update base service version to clouddriver:2023.02.28.18.06.11.release-1.27.x (#809)
  - chore(cd): update base service version to clouddriver:2023.02.28.19.32.28.release-1.27.x (#811)
  - chore(cd): update base service version to clouddriver:2023.03.21.20.22.35.release-1.27.x (#822)

#### Armory Echo - 2.27.7...2.27.8

  - chore(cd): update base service version to echo:2023.02.28.17.42.44.release-1.27.x (#540)
  - chore(cd): update base service version to echo:2023.02.28.19.16.55.release-1.27.x (#541)

#### Dinghy™ - 2.27.7...2.27.8

  - chore(dependencies): bumped oss dinghy version to 20230201103309-a73a68c80965 (#479)
  - chore(alpine): Upgrade alpine version (backport #481) (#483)

#### Armory Front50 - 2.27.7...2.27.8



### Spinnaker


#### Spinnaker Fiat - 1.27.0

  - chore(dependencies): Autobump korkVersion (#1024)
  - fix(logs): Redacted secret data in logs. (#1029) (#1032)

#### Spinnaker Igor - 1.27.0

  - chore(dependencies): Autobump korkVersion (#1091)
  - chore(dependencies): Autobump fiatVersion (#1092)

#### Spinnaker Gate - 1.27.0

  - chore(dependencies): Autobump korkVersion (#1621)
  - chore(dependencies): Autobump fiatVersion (#1622)

#### Spinnaker Orca - 1.27.0

  - chore(dependencies): Autobump korkVersion (#4401)
  - chore(dependencies): Autobump fiatVersion (#4402)

#### Spinnaker Kayenta - 1.27.0

  - chore(dependencies): Autobump orcaVersion (#934)

#### Spinnaker Rosco - 1.27.0

  - chore(dependencies): Autobump korkVersion (#957)

#### Spinnaker Deck - 1.27.0


#### Spinnaker Clouddriver - 1.27.0

  - fix(ecr): Two credentials with same accountId confuses EcrImageProvider with different regions (#5885) (#5886)
  - chore(dependencies): Autobump korkVersion (#5894)
  - chore(dependencies): Autobump fiatVersion (#5895)
  - fix(core): Renamed a query parameter for template tags (#5906) (#5907)

#### Spinnaker Echo - 1.27.0

  - chore(dependencies): Autobump korkVersion (#1259)
  - chore(dependencies): Autobump fiatVersion (#1260)

#### Spinnaker Front50 - 1.27.0


