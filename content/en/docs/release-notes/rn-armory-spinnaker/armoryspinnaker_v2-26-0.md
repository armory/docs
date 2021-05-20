---
title: v2.26.0 Armory Release (OSS Spinnaker™ v1.26.3)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping --> 
description: >
  Release notes for Armory Enterprise v2.26.0 
---

## 2021/05/20 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.26.0, use one of the following tools:

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
[Spinnaker v1.26.3](https://www.spinnaker.io/community/releases/versions/1-26-3-changelog) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.26.0
timestamp: "2021-05-20 02:28:34"
services:
    clouddriver:
        commit: e4612edb
        version: 2.26.6
    deck:
        commit: 68f37740
        version: 2.26.5
    dinghy:
        commit: a4c17545
        version: 2.26.1
    echo:
        commit: 6c7077ba
        version: 2.26.5
    fiat:
        commit: d5ddf6e9
        version: 2.26.6
    front50:
        commit: d08d6cc1
        version: 2.26.7
    gate:
        commit: e77d91d7
        version: 2.26.5
    igor:
        commit: ee5df451
        version: 2.26.6
    kayenta:
        commit: 3ea94181
        version: 2.26.5
    monitoring-daemon:
        version: 2.26.0
    monitoring-third-party:
        version: 2.26.0
    orca:
        commit: 157b115a
        version: 2.26.12
    rosco:
        commit: 2187403f
        version: 2.26.8
    terraformer:
        commit: 8f31c968
        version: 2.26.3
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Deck - 2.25.3...2.26.5

  - feat(terraform): Adds custom marker icon (#747)
  - chore(build): update to 1.25.3 (#761)
  - fix(changelog-link): add value and url (#764)
  - chore(release): update deck for 2.26.x (#775)
  - chore(deps): sync 1.26.3 (#783) (#784)
  - chore(core): disable pipeline tags feature until it's considered stable (#788) (#789)

#### Armory Clouddriver - 2.25.3...2.26.6

  - [create-pull-request] automated change (#296)
  - feat(git): Added git binaries to docker images (#311)
  - chore(githubactions): update aquasec version (#313)
  - [create-pull-request] automated change (#315)
  - [create-pull-request] automated change (#326)
  - [create-pull-request] automated change (#329) (#330)

#### Armory Igor - 2.25.2...2.26.6

  - Update gradle.properties (#209)
  - fix(dependencies): update armory-commons (#221) (#222)

#### Armory Orca - 2.25.2...2.26.12

  - Sync with CD branch, update CD branch with Orca version updates (#233)
  - Update sync_cd.yml (#243)
  - feat(cd): move all cd work to master (#244)
  - fix(cd): fixes workflow and updates init.gradle for new maven coordinates (#245)
  - fix(cd): PR should have a title that title checker will be happy with (#247)
  - chore(cd): update base orca version to 2021.03.24.00.52.35.master (#250)
  - add label to base service update PRs (#251)
  - feat(cd): publish every image to docker registry & openshift (#252)
  - fix(cd): docker images should be named orca-armory, not orca (#255)
  - feat(cd): use latest gradle plugin, images get tagged as armory-io/orca-armory (#257)
  - fix(cd): fix dockerhub login (#258)
  - feat(cd): switch docker ns prefix from armory-io to armory (#260)
  - [create-pull-request] automated change (#261)
  - feat(cloud): adding interceptor for multitenant services (#259)
  - chore(cd): update base orca version to 2021.04.02.21.36.17.master (#263)
  - chore(cd): update base orca version to 2021.04.13.10.30.00.master (#267)
  - chore(cd): auto approve base update pull requests (#270)
  - use Astrolabe's GH token for base update PRs (#273)
  - chore(cd): update base orca version to 2021.04.14.11.40.00.master (#274)
  - feat(cd): use variables action (#275)
  - chore(cd): update base orca version to 2021.04.19.11.07.00.master (#276)
  - chore(cd): update base orca version to 2021.04.21.11.27.00.master (#277)
  - chore(cd): update base orca version to 2021.04.23.02.16.26.master (#278)
  - [create-pull-request] automated change (#280)
  - chore(cd): update base orca version to 2021.4.23.21.50.9.master (#281)
  - [create-pull-request] automated change (#282)
  - chore(build): update group id to match new location (#291)
  - [create-pull-request] automated change (#295)
  - chore(cd): revert invalid baseServiceVersion (#294)
  - chore(cd): update base orca version to 2021.04.28.21.37.41.master (#296)
  - [create-pull-request] automated change (#301) (#302)
  - chore(cd): update base orca version to 2021.05.06.23.02.43.release-1.26.x (#306)
  - chore(cd): handle release branch builds and updates (#305) (#307)
  - chore(cd): test release process
  - chore(cd): fetch full github history on build
  - chore(cd): update base orca version to 2021.05.07.15.54.14.release-1.26.x (#309)

#### Dinghy™ - 2.25.1...2.26.1

  - fix(crash_on_module_updates): remove call to log.fatal() (#366)
  - feat(multi_tenant): refactor internal project to work with multi-tenant  (#375)
  - fix(config): bit more err checking on initial config load (#377)
  - Feat(add_dist_tracing): Enables tracing for internal dinghy (#376)
  - Feat(add_yeti_client): Adds client for pulling remote config from Yeti (#374)
  - Feat(enable_caching_and_yeti_remote_source): Adds the yeti remote source and caching for remote configs.  (#383)
  - chore(oss): bump oss version (#413)
  - chore(dependencies): updating oss version (backport #415) (#416)

#### Armory Fiat - 2.25.3...2.26.6

  - chore(build): Autobump armory-commons: 3.8.1 (#181)
  - [create-pull-request] automated change (#197)
  - [create-pull-request] automated change (#208)
  - [create-pull-request] automated change (#211) (#212)

#### Armory Gate - 2.25.5...2.26.5

  - fix(keel): add default keel endpoints. (#258)
  - chore(githubactions): update aquasec version (#262)
  - [create-pull-request] automated change (#264)
  - [create-pull-request] automated change (#266)
  - chore(build): Autobump armory-commons: 3.9.1 (#268)
  - chore(build): Autobump armory-commons: 3.9.2 (#279)
  - [create-pull-request] automated change (#282) (#283)

#### Armory Rosco - 2.25.2...2.26.8

  - fix(baking): Only try cancelling jobs that are confirmed to exist (#226)
  - fix(inttest): fixing vpc and subnets because recreation (#230)
  - fix(infra): Ignoring K8 test due to Docker Hub rate limits (#233)
  - Update Dockerfile (#236)
  - [create-pull-request] automated change (#234)
  - [create-pull-request] automated change (#246)
  - [create-pull-request] automated change (#249) (#250)
  - fix(timezone): set timezone for tzdata (backport #259) (#261)
  - chore(docker): update rosco baking utilities to match OSS (#253) (#257)

#### Terraformer™ - 2.25.0...2.26.3

  - fix(build): set up Go in github action (#369)
  - chore(build): add gcloud sdk + anthoscli (#374)
  - chore(versions): add terraform 13.6 through 14.10 (#376)
  - security(versions): secure terraform binaries (#390)
  - chore(build): kick off new build (#395)
  - chore(versions): update tf installer to use new hashi keys (#396) (#402)

#### Armory Echo - 2.25.2...2.26.5

  - chore(build): Autobump armory-commons: 3.9.1 (#317)
  - [create-pull-request] automated change (#328)
  - [create-pull-request] automated change (#331) (#332)

#### Armory Front50 - 2.25.2...2.26.7

  - [create-pull-request] automated change (#243)
  - [create-pull-request] automated change (#255)
  - [create-pull-request] automated change (#258) (#259)
  - fix(tests): use artifactory to avoid docker rate limits (#261) (#262)

#### Armory Kayenta - 2.25.2...2.26.5

  - feat(dynatrace): adding support for resolution parameter (#224)
  - feat(build): publish kayenta armory artifacts (#232)
  - [create-pull-request] automated change (#234)
  - chore(build): Autobump armory-commons: 3.9.3 (backport #248) (#249)

