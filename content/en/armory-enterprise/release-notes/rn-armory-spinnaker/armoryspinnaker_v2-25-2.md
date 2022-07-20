---
title: v2.25.2 Armory Enterprise Release (Spinnaker™ v1.25.8)
toc_hide: true
version: 02.25.02
description: >
  Release notes for Armory Enterprise v2.25.2
---

## 2022/04/06 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a previous working version and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.25.2, use one of the following tools:

- Armory-extended Halyard 1.12
- Armory Operator 1.2.6

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

{{< include "breaking-changes/bc-k8s-job-suffix.md" >}}
{{< include "known-issues/ki-orca-zombie-execution.md" >}}
{{< include "breaking-changes/bc-orca-forcecacherefresh.md" >}}

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->
{{< include "known-issues/ki-bake-var-file.md" >}}
{{< include "known-issues/ki-lambda-ui-caching.md" >}}
{{< include "known-issues/ki-dinghy-pipelineID.md" >}}

## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->
Fixed a dependency issue that caused an Oauth2 error in Gate on startup.

Addressed the Github Deprecated Teams API Endpoint issue per the notice: https://github.blog/changelog/2022-02-22-sunset-notice-deprecated-teams-api-endpoints/.


###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.25.8](https://www.spinnaker.io/changelogs/1.25.8-changelog/) changelog for details.

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
    commit: 33b60a3d7d9e038b4cac59f256dfb1cdcd6dfc4c
    version: 2.25.7
  deck:
    commit: 509a6a3d0dc87754ce53a4e7072f5101f5f90fbd
    version: 2.25.7
  dinghy:
    commit: 8e48f434fbf9b4830d4b27f89efa6b57b39372ea
    version: 2.25.6
  echo:
    commit: d7f37af9b470ad5795426dd9b912d4a337aa78b7
    version: 2.25.5
  fiat:
    commit: 56c9f6e90c9dc2181208f76576b2a20b6a5aa38a
    version: 2.25.6
  front50:
    commit: 40cfa8aea76490f18dc326f814f5b56261e4f11b
    version: 2.25.5
  gate:
    commit: b32a01cffb0ba3cd70ab1baa2b01d1bd933e3b17
    version: 2.25.8
  igor:
    commit: 39200c329fa711f0964d2e19ddfe642e9ad55ec4
    version: 2.25.5
  kayenta:
    commit: 7e874ca312c441e4c1f8c2dc3e721698f801669c
    version: 2.25.5
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: b9608b22be7fc7aa05e3f178115cb1f6d34d26b8
    version: 2.25.4
  rosco:
    commit: ce0b6657e8658ba8f3d760ae1a791ffbd3f8425a
    version: 2.25.9
  terraformer:
    commit: 6b396cc9c51c396231d75f2f28899dd3ec8c6844
    version: 2.25.10
timestamp: "2022-04-04 17:24:09"
version: 2.25.2
</code>
</pre>
</details>

### Armory


#### Armory Front50 - 2.25.1...2.25.2

  - chore(build): update mergify config (#351) (#354)
  - chore(cd): update armory-commons version to 3.8.8 (#362)
  - chore(action): auto approve astrolabe pr (#370) (#390)

#### Armory Deck - 2.25.1...2.25.2

  - fix(build): update sync script to legacy location (#1185)
  - chore(action): upgrade node version (backport #1188) (#1191)
  - chore(cd): update base deck version to 2021.0.0-20211115212635.release-1.25.x (#1194)

#### Armory Fiat - 2.25.1...2.25.2

  - chore(build): update mergify config (backport #293) (#296)
  - chore(cd): update base service version to fiat:2022.03.03.09.24.29.release-1.25.x (#311)
  - chore(cd): update base service version to fiat:2022.03.07.20.32.07.release-1.25.x (#317)
  - chore(action): auto approve astrolabe prs (#318) (#323)
  - chore(cd): update armory-commons version to 3.8.8 (#303)

#### Armory Gate - 2.25.1...2.25.2

  - chore(cd): update base service version to gate:2022.01.19.09.10.38.release-1.25.x (#379)
  - chore(cd): update base service version to gate:2022.01.19.09.10.38.release-1.25.x (#369)
  - chore(cd): update base service version to gate:2022.01.19.09.10.38.release-1.25.x (#368)
  - chore(build): update mergify config (backport #373) (#376)
  - chore(cd): update base service version to gate:2022.02.03.20.15.33.release-1.25.x (#381)
  - chore(action): auto approve astrolabe pr (#398) (#402)
  - chore(cd): update armory-commons version to 3.8.8 (#392)

#### Armory Igor - 2.25.1...2.25.2

  - chore(build): update mergify config (#283) (#286)
  - chore(action): auto approve astrolabe pr (#299) (#304)
  - chore(cd): update armory-commons version to 3.8.8 (#293)

#### Armory Clouddriver - 2.25.1...2.25.2

  - chore(cd): update base service version to clouddriver:2021.12.30.00.36.29.release-1.25.x (#515)
  - chore(cd): update base service version to clouddriver:2022.02.18.21.12.33.release-1.25.x (#543)
  - chore(cd): update base service version to clouddriver:2022.02.23.23.16.21.release-1.25.x (#548)
  - chore(action): auto approve prs with extensionDependencyUpdate label (#558) (#568)
  - chore(cd): update armory-commons version to 3.8.8 (#551)
  - fix(imdsv2): Support newer aws-iam-authenticator (#581)
  - chore(build): update mergify config (#529)
  - chore(cd): update base service version to clouddriver:2022.02.24.16.32.48.release-1.25.x (#599)

#### Armory Orca - 2.25.1...2.25.2

  - [create-pull-request] automated change (#402)
  - chore(build): update mergify config (backport #408) (#411)
  - chore(action): auto approve astrolabe pr (#431) (#437)
  - chore(cd): update armory-commons version to 3.8.8 (#425)

#### Armory Kayenta - 2.25.1...2.25.2

  - chore(build): update mergify config (backport #297) (#300)
  - chore(cd): update armory-commons version to 3.8.8 (#306)

#### Armory Rosco - 2.25.1...2.25.2

  - chore(docker): update rosco baking utilities to match OSS (backport #253) (#256)
  - fix(timezone): set timezone for tzdata (backport #259) (#260)
  - fix(test): increase timeout for AMI bake int test (backport #350) (#354)
  - chore(action): auto approve extensionDependency pr (backport #369) (#379)
  - chore(gha): re-enable integration tests (#287) (#290)
  - chore(cd): update armory-commons version to 3.8.8 (#360)
  - fix(build): remove redhat publishing (backport #301) (#353)
  - fix(inttest): fixing vpc and subnets because recreation (backport #230) (#279)
  - chore(build): update mergify config (#343) (#386)

#### Dinghy™ - 2.25.1...2.25.2

  - chore(build): update mergify config (#457) (#460)

#### Armory Echo - 2.25.1...2.25.2

  - chore(build): update mergify config (#406) (#409)
  - chore(action): auto approve prs from astrolabe (#423) (#428)
  - chore(cd): update armory-commons version to 3.8.8 (#417)

#### Terraformer™ - 2.25.1...2.25.2

  - chore(build): update mergify config (backport #451) (#452)

