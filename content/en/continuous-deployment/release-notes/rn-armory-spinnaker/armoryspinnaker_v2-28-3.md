---
title: v2.28.3 Armory Release (OSS Spinnaker™ v1.28.4)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
date: 2023-01-26
description: >
  Release notes for Armory Enterprise v2.28.3
---

## 2023/01/26 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a previous working version and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory 2.28.3, use Armory Operator 1.70 or later.

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
[Spinnaker v1.28.4](https://www.spinnaker.io/changelogs/1.28.4-changelog/) changelog for details.

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
    commit: 66e1a26166ed649ebfb0ad6b0ac830924d2d6df2
    version: 2.28.3
  deck:
    commit: dd17c153eaf117ab7990c11182a6bdc887d020f9
    version: 2.28.3
  dinghy:
    commit: c4ed5b19dbcfefe8dea14cdff7df9a8ab540eba3
    version: 2.28.3
  echo:
    commit: 53bebfd6900b3de124dde043a00d164aa2e50773
    version: 2.28.3
  fiat:
    commit: 48c8759b0878fd1b86b91dae9ee288afcf03dd39
    version: 2.28.3
  front50:
    commit: fab8841982330e7537629c9f24f41205cd5863fd
    version: 2.28.3
  gate:
    commit: 65bdd30238312bbca2dce613825eda7ae88f1dfa
    version: 2.28.3
  igor:
    commit: 61ce26babfcd0bdf62872c24e707ca5b5371a381
    version: 2.28.3
  kayenta:
    commit: 0333b9ed6153acfc090edcfa38e3514439e2863c
    version: 2.28.3
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 76fe72a46566bb404eb4db4c842ecb0775c546bf
    version: 2.28.3
  rosco:
    commit: 945f21dec252da7dd2e00c8d23a1687aa3b9841a
    version: 2.28.3
  terraformer:
    commit: 3764e523e17dfdd4cf309dc2bd7c13d9b804f309
    version: 2.28.3
timestamp: "2023-01-20 19:07:29"
version: 2.28.3
</code>
</pre>
</details>

### Armory


#### Armory Kayenta - 2.28.2...2.28.3

  - fix(kayenta-integration-tests): update dynatrace tenant to qso00828 (backport #376) (#377)
  - chore(cd): update base service version to kayenta:2022.12.05.19.06.46.release-1.28.x (#374)

#### Armory Gate - 2.28.2...2.28.3


#### Armory Rosco - 2.28.2...2.28.3


#### Armory Igor - 2.28.2...2.28.3


#### Armory Orca - 2.28.2...2.28.3


#### Terraformer™ - 2.28.2...2.28.3

  - Fixes builds with golint being dead until were on a newer golang (#491) (#495)
  - feat(gcloud): Bump to latest gcloud sdk & adds the GKE Auth plugin (#490) (#493)

#### Armory Deck - 2.28.2...2.28.3


#### Armory Clouddriver - 2.28.2...2.28.3

  - feat(google): Updated google cloud SDK to support GKE >1.26 (#769) (#772)
  - chore(cd): update base service version to clouddriver:2023.01.20.18.13.55.release-1.28.x (#779)

#### Dinghy™ - 2.28.2...2.28.3


#### Armory Echo - 2.28.2...2.28.3

  - chore(cd): update base service version to echo:2022.12.14.15.47.22.release-1.28.x (#516)
  - chore(cd): update base service version to echo:2023.01.20.14.47.47.release-1.28.x (#527)

#### Armory Fiat - 2.28.2...2.28.3


#### Armory Front50 - 2.28.2...2.28.3



### Spinnaker


#### Spinnaker Kayenta - 1.28.4

  - fix(security): Bump commons-text for CVE-2022-42889 (#911) (#914)
  - chore(dependencies): Autobump spinnakerGradleVersion (#917) (#921)
  - chore(dependencies): Autobump orcaVersion (#923)

#### Spinnaker Gate - 1.28.4


#### Spinnaker Rosco - 1.28.4


#### Spinnaker Igor - 1.28.4


#### Spinnaker Orca - 1.28.4


#### Spinnaker Deck - 1.28.4


#### Spinnaker Clouddriver - 1.28.4

  - chore(dependencies): pin version of com.github.tomakehurst:wiremock (#5845) (#5858)

#### Spinnaker Echo - 1.28.4

  - feat(event): Add circuit breaker for events sending. (#1233) (#1237)
  - fix: The circuit breaker feature for sending events to telemetry endpoint is hidden under a required feature flag property (#1241) (#1245)

#### Spinnaker Fiat - 1.28.4


#### Spinnaker Front50 - 1.28.4


