---
title: v2.32.3 Armory Continuous Deployment Release (Spinnaker™ v1.32.4)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
date: 2024-05-14
description: >
  Release notes for Armory Continuous Deployment v2.32.3.
---

<!-- 
MAKE SURE TO ADD 'LTS' OR 'FEATURE' TO THE TITLE TO INDICATE RELEASE CATEGORY. 
FOR EXAMPLE, "Armory Continuous Deployment Release LTS" or "Armory Continuous Deployment Release Feature" so users know release category and support time period 
-->

## 2024/05/14 release notes

>Note: If you experience production issues after upgrading Armory Continuous Deployment, roll back to a previous working version and report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory CD 2.32.3, use Armory Operator 1.70 or later.

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
    commit: 7d9e31043c8baa81afb59a2a30aee2235b7e90ab
    version: 2.32.3
  deck:
    commit: 19096fa607fabd0fd8865b18739eab577b4b7a9b
    version: 2.32.3
  dinghy:
    commit: f5b14ffba75721322ada662f2325e80ec86347de
    version: 2.32.3
  echo:
    commit: 9d2abeeea4341e5ba94654925ba6488a9038af3f
    version: 2.32.3
  fiat:
    commit: 5e1839ef81812c439fb37b411bd3b381131c8c40
    version: 2.32.3
  front50:
    commit: ba318cd2c445f14e5d6c3db87fa1658549385403
    version: 2.32.3
  gate:
    commit: c6654ca6e316eef474c59296120d3f9f34eb0bdf
    version: 2.32.3
  igor:
    commit: 9339ab63ab3d85ebcb00131033d19f26ad436f05
    version: 2.32.3
  kayenta:
    commit: bccd150fcc8a7cb7df537ec6269bce5d2843c703
    version: 2.32.3
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: ddbe104b0a3e32406c3bac38ea2b8c0c04605825
    version: 2.32.3
  rosco:
    commit: dfe611ffdd2cf9ae7c524fb9970af47350ca5e96
    version: 2.32.3
  terraformer:
    commit: 2dc7666ca2d25acb85ab2b9f8efc864599061c45
    version: 2.32.3
timestamp: "2024-05-13 20:39:58"
version: 2.32.3
</code>
</pre>
</details>

### Armory


#### Armory Kayenta - 2.32.2...2.32.3


#### Armory Echo - 2.32.2...2.32.3


#### Armory Orca - 2.32.2...2.32.3

  - chore(cd): update base orca version to 2024.05.07.00.09.39.release-1.32.x (#885)
  - chore(cd): update base orca version to 2024.05.09.17.58.27.release-1.32.x (#889)

#### Armory Fiat - 2.32.2...2.32.3


#### Armory Gate - 2.32.2...2.32.3


#### Terraformer™ - 2.32.2...2.32.3


#### Armory Clouddriver - 2.32.2...2.32.3

  - chore(cd): update base service version to clouddriver:2024.05.07.00.14.24.release-1.32.x (#1123)

#### Armory Rosco - 2.32.2...2.32.3


#### Armory Deck - 2.32.2...2.32.3

  - chore(cd): update base deck version to 2024.0.0-20240507164950.release-1.32.x (#1408)
  - chore(cd): update base deck version to 2024.0.0-20240509175950.release-1.32.x (#1409)
  - chore(cd): update base deck version to 2024.0.0-20240510152918.release-1.32.x (#1412)
  - chore(cd): update base deck version to 2024.0.0-20240513181456.release-1.32.x (#1416)

#### Dinghy™ - 2.32.2...2.32.3


#### Armory Igor - 2.32.2...2.32.3


#### Armory Front50 - 2.32.2...2.32.3



### Spinnaker


#### Spinnaker Kayenta - 1.32.4


#### Spinnaker Echo - 1.32.4


#### Spinnaker Orca - 1.32.4

  - fix(check-pre-condition): CheckPrecondition doesn't evaluate expression correctly after upstream stages get restarted (#4682) (#4719)
  - fix(jenkins): Wrong Job name encoding in query params for Artifacts/Properties (#4722) (#4725)

#### Spinnaker Fiat - 1.32.4


#### Spinnaker Gate - 1.32.4


#### Spinnaker Clouddriver - 1.32.4

  - fix(gcp): Relaxed health check for GCP accounts (#6200) (#6204)

#### Spinnaker Rosco - 1.32.4


#### Spinnaker Deck - 1.32.4

  - fix(lambda): Invoke stage excludedArtifactTypes not including the embedded-artifact type (#10097) (#10102)
  - feat(taskView): Implement opt-in paginated request for TaskView (backport #10093) (#10094)
  - fix(pipeline): Handle render/validation when stageTimeoutMs is a Spel expression (#10103) (#10106)
  - fix(redblack): fixing redblack onchange values (#10107) (#10111)

#### Spinnaker Igor - 1.32.4


#### Spinnaker Front50 - 1.32.4


