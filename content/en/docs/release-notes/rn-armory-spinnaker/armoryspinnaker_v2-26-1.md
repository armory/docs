---
title: v2.26.1 Armory Release (OSS Spinnaker™ v1.26.6)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping --> 
description: >
  Release notes for Armory Enterprise v2.26.1
---

## 2021/07/40 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.26.1, use one of the following tools:

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
[Spinnaker v1.26.6](https://www.spinnaker.io/changelogs/1.26.6-changelog/) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.26.1
timestamp: "2021-07-20 19:04:54"
services:
    clouddriver:
        commit: 58e826ca
        version: 2.26.12
    deck:
        commit: 09f8ec58
        version: 2.26.7
    dinghy:
        commit: 33f6f14c
        version: 2.26.6
    echo:
        commit: 3cdb74fa
        version: 2.26.9
    fiat:
        commit: b2360f92
        version: 2.26.10
    front50:
        commit: d3dfd429
        version: 2.26.11
    gate:
        commit: ec2ae48c
        version: 2.26.9
    igor:
        commit: a9b45bca
        version: 2.26.9
    kayenta:
        commit: 1d27eaf7
        version: 2.26.10
    monitoring-daemon:
        version: 2.26.0
    monitoring-third-party:
        version: 2.26.0
    orca:
        commit: 69f66bf3
        version: 2.26.15
    rosco:
        commit: 1dfc60f1
        version: 2.26.13
    terraformer:
        commit: "540902e6"
        version: 2.26.9
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Echo - 2.26.5...2.26.9

  - [create-pull-request] automated change (#342) (#345)
  - chore(cd): add GitHub actions for new release process (#343)

#### Armory Rosco - 2.26.8...2.26.13

  - Update gradle.yml
  - chore(build): disable legacy integration tests (#271)
  - [create-pull-request] automated change (#268) (#273)

#### Armory Clouddriver - 2.26.6...2.26.12

  - chore(build): Autobump armory-commons: 3.9.5 (backport #342) (#344)
  - chore(cd): add GitHub actions for new release process (#343)
  - fix(dependencies): fix gradle.properties (#374)

#### Armory Deck - 2.26.5...2.26.7


#### Armory Gate - 2.26.5...2.26.9

  - chore(cd): add GitHub actions for new release process (#295)
  - chore(build): Autobump armory-commons: 3.9.5 (backport #294) (#298)

#### Armory Kayenta - 2.26.5...2.26.10

  - chore(cd): add GitHub actions for new release process (#260)
  - chore(build): Autobump armory-commons: 3.9.5 (backport #259) (#261)
  - feat(cloudwatch): add assume role feat and cleanup dependencies (#233) (#270)

#### Armory Igor - 2.26.6...2.26.9

  - chore(cd): add GitHub actions for new release process (#231)

#### Dinghy™ - 2.26.1...2.26.6

  - feat(use_gate): Configures the yeti source provider to generate a pla… (#422) (#433)
  - fix(local_modules_not_working_in_template_repo): updating internal bu… (backport #429) (#430)
  - fix(parsing_errors_when_using_yaml): upgrade to version of OSS dinghy that includes this fix BOB-30150 (#436) (#438)
  - feat(add_dinghyignore): upgrade oss dinghy version (#439) (#440)
  - feat(add_flag_for_json_validation): upgrade to latest version of OSS dinghy PUX-405 (#441) (#442)

#### Armory Fiat - 2.26.6...2.26.10

  - chore(cd): add GitHub actions for new release process (#223)
  - chore(build): Autobump armory-commons: 3.9.5 (backport #222) (#224)

#### Armory Front50 - 2.26.7...2.26.11

  - chore(cd): add GitHub actions for new release process (#272)
  - chore(build): Autobump armory-commons: 3.9.5 (backport #266) (#274)

#### Armory Orca - 2.26.12...2.26.15

  - [create-pull-request] automated change (#323) (#325)

#### Terraformer™ - 2.26.3...2.26.9

  - chore(tests): retrieve secrets from s3, not vault (#418) (#420)
  - task(tf_versions): update tf bundled versions script to use new key-server (#417) (#419)
  - feat(tf): New TF versions support (#412) (#426)
  - task(tf_versions): update tf bundled versions script to use new key (#428) (#429)
  - feat(cd): add workflow for building cd images (#408)

