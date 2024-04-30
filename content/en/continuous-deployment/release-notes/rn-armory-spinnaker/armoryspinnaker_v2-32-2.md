---
title: v2.32.2 Armory Continuous Deployment Release (Spinnaker™ v1.32.4)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
date: 2024-04-30
description: >
  Release notes for Armory Continuous Deployment v2.32.2.
---

<!-- 
MAKE SURE TO ADD 'LTS' OR 'FEATURE' TO THE TITLE TO INDICATE RELEASE CATEGORY. 
FOR EXAMPLE, "Armory Continuous Deployment Release LTS" or "Armory Continuous Deployment Release Feature" so users know release category and support time period 
-->

## 2024/04/30 release notes

>Note: If you experience production issues after upgrading Armory Continuous Deployment, roll back to a previous working version and report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory CD 2.32.2, use Armory Operator 1.70 or later.

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
    version: 2.32.2
  deck:
    commit: 13f331421b292db61f14392e6932880aa5c49f25
    version: 2.32.2
  dinghy:
    commit: f5b14ffba75721322ada662f2325e80ec86347de
    version: 2.32.2
  echo:
    commit: 9d2abeeea4341e5ba94654925ba6488a9038af3f
    version: 2.32.2
  fiat:
    commit: 5e1839ef81812c439fb37b411bd3b381131c8c40
    version: 2.32.2
  front50:
    commit: ba318cd2c445f14e5d6c3db87fa1658549385403
    version: 2.32.2
  gate:
    commit: c6654ca6e316eef474c59296120d3f9f34eb0bdf
    version: 2.32.2
  igor:
    commit: 9339ab63ab3d85ebcb00131033d19f26ad436f05
    version: 2.32.2
  kayenta:
    commit: bccd150fcc8a7cb7df537ec6269bce5d2843c703
    version: 2.32.2
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: aa898e512f93921b8786ea790bfe1cb5abc12f2b
    version: 2.32.2
  rosco:
    commit: dfe611ffdd2cf9ae7c524fb9970af47350ca5e96
    version: 2.32.2
  terraformer:
    commit: 2dc7666ca2d25acb85ab2b9f8efc864599061c45
    version: 2.32.2
timestamp: "2024-04-25 15:56:08"
version: 2.32.2
</code>
</pre>
</details>

### Armory


#### Armory Clouddriver - 2.32.1...2.32.2


#### Armory Kayenta - 2.32.1...2.32.2


#### Armory Echo - 2.32.1...2.32.2


#### Armory Deck - 2.32.1...2.32.2

  - chore(cd): update base deck version to 2024.0.0-20240416232157.release-1.32.x (#1400)
  - chore(cd): update base deck version to 2024.0.0-20240425133704.release-1.32.x (#1403)
  - chore(cd): update base deck version to 2024.0.0-20240425135304.release-1.32.x (#1404)

#### Armory Fiat - 2.32.1...2.32.2

  - fix(build): Updating vault addr for gradle build (#597) (#598)

#### Armory Gate - 2.32.1...2.32.2

  - chore(cd): update base service version to gate:2024.03.25.21.57.21.release-1.32.x (#712)

#### Terraformer™ - 2.32.1...2.32.2

  - fix(tf-show): Reverting go-cmd implementation (#551) (#552)
  - Build: Removing full history fetch (#553) (#554)
  - Updating Dockerfile with harness email list and pull from Dockerhub (#550) (#556)
  - Fixing Dockerfile with missing tools (#557) (#558)
  - fix(build): Refarctoring Dockerfile to fix build failures (#559) (#560)
  - fix(build): Fixing Dockerfile for multi-build process (#561) (#562)

#### Armory Rosco - 2.32.1...2.32.2


#### Dinghy™ - 2.32.1...2.32.2


#### Armory Orca - 2.32.1...2.32.2

  - chore(cd): update base orca version to 2024.03.26.22.19.53.release-1.32.x (#856)
  - chore(cd): update base orca version to 2024.04.02.15.59.15.release-1.32.x (#860)
  - chore(cd): update base orca version to 2024.04.15.20.03.44.release-1.32.x (#865)
  - chore(cd): update base orca version to 2024.04.15.22.28.52.release-1.32.x (#867)

#### Armory Igor - 2.32.1...2.32.2


#### Armory Front50 - 2.32.1...2.32.2



### Spinnaker


#### Spinnaker Clouddriver - 1.32.4


#### Spinnaker Kayenta - 1.32.4


#### Spinnaker Echo - 1.32.4


#### Spinnaker Deck - 1.32.4

  - fix(runJobs): Persist External Log links after the deletion of the pods (#10081) (#10084)
  - fix(pipelineGraph): Handling exception when requisiteStageRefIds is not defined (#10086) (#10089)
  - fix(lambdaStages): Exporting Lambda stages based on the feature flag settings (#10085) (#10092)

#### Spinnaker Fiat - 1.32.4


#### Spinnaker Gate - 1.32.4

  - fix(core): RetrofitError thrown on login (#1737) (#1779)

#### Spinnaker Rosco - 1.32.4


#### Spinnaker Orca - 1.32.4

  - feat(servergroup): Allow users to opt-out of the target desired size check when verifying if the instances scaled up or down successfully (#4649) (#4653)
  - fix(queue): Fix `ZombieExecutionCheckingAgent` to handle queues with more than 100 items (#4648) (#4683)
  - fix(explicitRollback): Add configurable timeout for serverGroup lookup from Clouddriver API (#4686) (#4690)
  - perf(sql): Optimise searchForPipelinesByTrigger LIMIT and OFFSET SQL query (#4698) (#4699)
  - fix(SqlExecutionRepository): fixed bug in sql repository in orca-sql … (backport #4697) (#4701)

#### Spinnaker Igor - 1.32.4


#### Spinnaker Front50 - 1.32.4


