---
title: v2.24.0 Armory Release (OSS Spinnaker™ v1.24.2)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping --> 
description: >
  Release notes for the Armory Platform
---

## 2021/01/60 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.24.0, use one of the following tools:

- Armory-extended Halyard <PUT IN A VERSION NUMBER> or later
- Armory Operator <PUT IN A VERSION NUMBER> or later

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

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
[Spinnaker v1.24.2](https://www.spinnaker.io/community/releases/versions/1-24-2-changelog) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.24.0
timestamp: "2021-01-19 18:09:21"
services:
    clouddriver:
        commit: 4c5d79fc
        version: 2.24.8
    deck:
        commit: d0859de2
        version: 2.24.1
    dinghy:
        commit: 16f3f547
        version: 2.24.5
    echo:
        commit: 3335cceb
        version: 2.24.3
    fiat:
        commit: e21ee877
        version: 2.24.3
    front50:
        commit: 9d1b8844
        version: 2.24.3
    gate:
        commit: 599b2365
        version: 2.24.3
    igor:
        commit: 213c430c
        version: 2.24.4
    kayenta:
        commit: 0a93d760
        version: 2.24.6
    monitoring-daemon:
        version: 2.24.0
    monitoring-third-party:
        version: 2.24.0
    orca:
        commit: cef289ed
        version: 2.24.4
    rosco:
        commit: cb8dc475
        version: 2.24.3
    terraformer:
        commit: f7d5096e
        version: 2.24.2
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Echo - 2.23.6...2.24.3

  - fix(GHA): set-env deprecated (#244)

#### Armory Clouddriver - 2.23.28...2.24.8

  - fix(GHA): set-env deprecated (#224)
  - feat(docker): adding ecr utility to get an ecr token (#235) (#238)
  - fix(dep/springboot): downgrade spring-boot to SR4 (#249) (#250)
  - fix(config): reverted spring.profile sytax to SR4 syntax (#251) (#252)
  - fix(dependencies): downgrade resilience4j to match OSS (#253) (#254)

#### Armory Fiat - 2.23.5...2.24.3

  - fix(GHA): set-env deprecated (#126)

#### Armory Gate - 2.23.5...2.24.3

  - feat(dinghy): add api endpoints for dinghy. (#184)
  - fix(GHA): set-env deprecated (#186)
  - feat(dinghy): update dinghy events endpoint. (#187)

#### Armory Igor - 2.23.5...2.24.4

  - fix(GHA): set-env deprecated (#141)

#### Armory Front50 - 2.23.6...2.24.3

  - fix(GHA): set-env deprecated (#165)
  - fix(chore): typo for regex autobump (#151)

#### Armory Deck - 2.23.15...2.24.1

  - feat(kayenta): extending kayenta module to add dynatrace UI (#675)
  - feat(dinghy): add dinghy header. (#679)
  - fix(GHA): set-env deprecated (#682)
  - feat(dinghy): add dinghy component. (#680)
  - fix(dinghy): fix NPE for commits and files. (#684)
  - feat(kayenta): add cloudwatch UI (#686)
  - fix(cloudwatch): change textbox template to json editor (#688)
  - fix(terraform): save the default terraform version (#692)
  - chore(deps): update to 1.23.4 base (#698)
  - chore(deps): bump base to OSS 1.23.5 (#701)
  - chore(deps): bump base to OSS 1.24.0 (#704)
  - chore(deps): bump to new OSS 1.24.2 bom (#713) (#714)

#### Dinghy™ - 2.23.8...2.24.5

  - fix(nilcommits): fix nil commits for deck ui (#286)
  - fix(nofiles): only show file changes in logevents (#289)
  - feat(mainbranch): main branch support switch when master fails (#292)
  - fix(slacknotifications): slack notifications fix for 2.23 (#298)
  - feat(github): add GitHub notifier. (#297)
  - feat(yaml): update yaml support to be on par with json (#291)
  - feat(sqlsupport): full sql support (#300) (#308)
  - feat(parser): sprig functions support (#311) (#312)
  - fix(liquibase): liquibase will be executed by dinghy since it has the secrets (#314) (#315)
  - fix(validations): pr validations fixes (#317) (#318)

#### Armory Kayenta - 2.23.8...2.24.6

  - feat(cloudwatch): adding cloudwatch config and integration test (#142)
  - fix(GHA): set-env deprecated (#145)
  - fix(cloudwatch): fixes duplicate config (#148)
  - fix(cve): fix 2020-5408 force security-core to 5.2.4 (#163) (#164)
  - Update gradle.yml

#### Armory Orca - 2.23.12...2.24.4

  - fix(GHA): set-env deprecated (#170)

#### Armory Rosco - 2.23.10...2.24.3

  - Fix(fargate-job-executor): dont mutate original config when making orphan token clients (#146)
  - fix(fargate-job-executor): handle duplicate files when recursing config dir, because operator symlinks files more than once (#142)
  - fix(fargate-job-executor): specify cluster when canceling job (#150)
  - feat(fargate): Enable IAM authentication with Vault for Fargate Job Executor (#154)
  - fix(remote-jobs-image): fix tag command (#159)

#### Terraformer™ - 2.23.6...2.24.2

  - feat(retry): adds retries to clouddriver service (#283)
  - feat(retry): add customizable options (#284)
  - chore(versions): add 0.13.4, 0.13.5, 0.14.0 (#287)
  - chore(logging): improve logging when clouddriver returns 503 (#285)
  - chore(deps): update tf to add 0.14.1 & 0.14.2 (#290)
  - fix(clouddriver): fix short-write of git/repo file (#294)
  - refactor(git/repo): improve git/repo perf (#295)

