---
title: v2.28.1 Armory Release (OSS Spinnaker™ v1.28.1)
toc_hide: true
version: 02.28.1
date: 2022-11-23
description: >
  Release notes for Armory Enterprise v2.28.1
---

## 2022/11/17 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a previous working version and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.28.1, use one of the following tools:

- Armory Operator 1.6.0 or later

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->
{{< include "breaking-changes/bc-orca-rdbms-configured-utf8.md" >}}

{{< include "breaking-changes/bc-kubectl-120.md" >}}

{{< include "breaking-changes/bc-dinghy-slack.md" >}}

{{< include "breaking-changes/bc-java-tls-mysql.md" >}}

{{< include "breaking-changes/bc-k8s-version-pre1-16.md" >}}

{{< include "breaking-changes/bc-k8s-infra-buttons.md" >}}

{{< include "breaking-changes/bc-git-artifact-constraint.md" >}}

{{< include "breaking-changes/bc-hal-deprecation.md" >}}

{{< include "breaking-changes/bc-plugin-compatibility-2-28-0.md" >}}


## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

{{< include "known-issues/ki-empty-roles.md" >}}

{{< include "known-issues/ki-app-attr-not-configured.md" >}}

{{< include "known-issues/ki-app-eng-acct-auth.md" >}}

{{< include "known-issues/ki-403-permission-err.md" >}}

{{< include "known-issues/ki-spel-expr-art-binding.md" >}}

{{< include "known-issues/ki-pipelines-as-code-gh-comments.md" >}}

{{< include "known-issues/ki-secrets-and-spring-cloud.md" >}}

## Highlighted updates

  * **Terraform 0.12 Now Supported** - Restored support for Terraform 0.12 in version 2.28.1.
  * **Update for Kubernetes v2 provider accounts that use the aws-iam-authenticator** - Fixed failures for the Kubernetes V2 provider accounts that still use client.authentication.k8s.io/v1alpha1. This bug was introduced in 2.28.0.
  * **Dinghy Vault Passwords** - Fixed an issue where Dinghy fails to start when Vault password contain an exclamation point.
  * **Revision History Display** - Addressed an issue where the revision history was not showing the timestamp of the revision.
  * **Automated Triggers Permissions** - Fixed an issue where permissions defined under "Automated Triggers" become empty after a triggered pipeline update.

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->


###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.28.1](https://www.spinnaker.io/changelogs/1.28.1-changelog/) changelog for details.

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
    commit: 9216f0fae587d3af14ed41fb9f21e9195b30c269
    version: 2.28.1
  deck:
    commit: bd4fb67ec81c5e201b31b4e3e7829dff93476580
    version: 2.28.1
  dinghy:
    commit: fc867f05b41e5e2756c42990b576341973e96276
    version: 2.28.1
  echo:
    commit: 010bdc55d57c1000ef93f826204e6ccf54f6f6e7
    version: 2.28.1
  fiat:
    commit: fce52482097b606389328d25d220be5eaaddab21
    version: 2.28.1
  front50:
    commit: 1e5d3a5dfce38d26f809dee107d8145c00caa27e
    version: 2.28.1
  gate:
    commit: 2b2b668ac5d4cbf126190baf450116de6aa0aa4a
    version: 2.28.1
  igor:
    commit: e7e01c998423941507a7322e6891ea6e95a16792
    version: 2.28.1
  kayenta:
    commit: 6004bfd90ad2e4fa9b02dddc26253210b8aa3a3c
    version: 2.28.1
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 583b59cfcea93cce9b221509d0d4ec03a9487939
    version: 2.28.1
  rosco:
    commit: 88567fc0c710c63b2093fc95e674052314978250
    version: 2.28.1
  terraformer:
    commit: bb576e57561db2d957c25e00992e24f53a223bd5
    version: 2.28.1
timestamp: "2022-11-10 18:20:57"
version: 2.28.1
</code>
</pre>
</details>

### Armory


#### Armory Fiat - 2.28.0...2.28.1

  - chore(cd): update base service version to fiat:2022.08.03.03.06.22.release-1.28.x (#385)

#### Armory Front50 - 2.28.0...2.28.1

  - chore(cd): update base service version to front50:2022.08.02.17.26.34.release-1.28.x (#439)
  - chore(cd): update base service version to front50:2022.08.17.00.43.53.release-1.28.x (#446)
  - chore(cd): update base service version to front50:2022.08.19.03.09.32.release-1.28.x (#449)
  - chore(cd): update base service version to front50:2022.09.12.22.11.46.release-1.28.x (#453)

#### Armory Gate - 2.28.0...2.28.1

  - chore(cd): update base service version to gate:2022.08.03.03.06.50.release-1.28.x (#466)
  - chore(cd): update base service version to gate:2022.08.19.03.10.44.release-1.28.x (#472)

#### Armory Igor - 2.28.0...2.28.1

  - chore(cd): update base service version to igor:2022.08.03.03.06.44.release-1.28.x (#355)
  - chore(cd): update base service version to igor:2022.08.19.03.10.49.release-1.28.x (#363)
  - chore(cd): update base service version to igor:2022.10.19.18.22.51.release-1.28.x (#372)
  - chore(cd): update base service version to igor:2022.10.19.19.58.28.release-1.28.x (#373)
  - chore(cd): update base service version to igor:2022.11.02.03.23.29.release-1.28.x (#375)

#### Armory Kayenta - 2.28.0...2.28.1

  - chore(cd): update base service version to kayenta:2022.08.03.03.06.40.release-1.28.x (#352)
  - chore(cd): update base service version to kayenta:2022.08.19.04.13.29.release-1.28.x (#358)

#### Armory Orca - 2.28.0...2.28.1

  - chore(cd): update base orca version to 2022.08.03.03.09.59.release-1.28.x (#506)
  - chore(cd): update base orca version to 2022.08.19.03.19.08.release-1.28.x (#514)
  - Revert "feat(iam): aws mysql jdbc (#449) (#464)" (#516)
  - chore(cd): update base orca version to 2022.10.19.20.11.38.release-1.28.x (#531)
  - chore(cd): update base orca version to 2022.10.19.20.47.46.release-1.28.x (#532)
  - chore(cd): update base orca version to 2022.11.02.03.24.15.release-1.28.x (#535)
  - chore(cd): update base orca version to 2022.11.08.07.29.46.release-1.28.x (#536)
  - chore(cd): update base orca version to 2022.11.08.17.42.51.release-1.28.x (#539)

#### Armory Rosco - 2.28.0...2.28.1

  - chore(cd): update base service version to rosco:2022.08.03.03.02.12.release-1.28.x (#440)
  - chore(cd): update base service version to rosco:2022.08.23.02.26.09.release-1.28.x (#446)
  - chore(cd): update base service version to rosco:2022.08.23.15.48.11.release-1.28.x (#447)
  - chore(cd): update base service version to rosco:2022.10.19.18.21.29.release-1.28.x (#452)

#### Terraformer™ - 2.28.0...2.28.1

  - chore(tf_versions): Adding TF versions 1.1.x 1.2.x and missing patch versions (backport #472) (#473)
  - fix(versions): Rollback removal of .12 versions from 2.28 release (#476)

#### Armory Deck - 2.28.0...2.28.1

  - chore(cd): update base deck version to 2022.0.0-20221006145341.release-1.28.x (#1259)
  - chore(cd): update base deck version to 2022.0.0-20221021162854.release-1.28.x (#1262)
  - chore(cd): update base deck version to 2022.0.0-20221108072118.release-1.28.x (#1269)
  - chore(cd): update base deck version to 2022.0.0-20221108195439.release-1.28.x (#1271)

#### Armory Clouddriver - 2.28.0...2.28.1

  - chore(aws-iam): Updating aws-iam-authenticator to 0.5.9 due to CVE-2022-2385 (backport #692) (#696)
  - chore(cd): update base service version to clouddriver:2022.08.03.03.18.32.release-1.28.x (#701)
  - chore(cd): update base service version to clouddriver:2022.08.19.03.29.51.release-1.28.x (#709)
  - chore(cd): update base service version to clouddriver:2022.09.27.19.40.20.release-1.28.x (#723)
  - chore(cd): update base service version to clouddriver:2022.10.19.18.30.22.release-1.28.x (#728)
  - chore(cd): update base service version to clouddriver:2022.10.19.20.15.01.release-1.28.x (#729)
  - chore(cd): update base service version to clouddriver:2022.11.01.18.09.15.release-1.28.x (#733)
  - chore(cd): update base service version to clouddriver:2022.11.02.20.03.48.release-1.28.x (#738)

#### Dinghy™ - 2.28.0...2.28.1


#### Armory Echo - 2.28.0...2.28.1

  - chore(cd): update base service version to echo:2022.08.03.03.06.27.release-1.28.x (#481)
  - chore(cd): update base service version to echo:2022.08.19.03.10.53.release-1.28.x (#488)
  - chore(cd): update base service version to echo:2022.10.19.18.23.43.release-1.28.x (#496)
  - chore(cd): update base service version to echo:2022.10.19.19.59.13.release-1.28.x (#497)


### Spinnaker


#### Spinnaker Fiat - 1.28.1

  - chore(dockerfile): upgrade to latest alpine image (#967) (#969)

#### Spinnaker Front50 - 1.28.1

  - fix: Revision history is not showing the timestamp of the revision (backport #1142) (#1147)
  - chore(dockerfile): upgrade to latest alpine image (backport #1151) (#1153)
  - chore(dependencies): Autobump fiatVersion (#1155)
  - fix(updateTs): missing updateTs field in the get pipeline history's response. (backport #1159) (#1162)

#### Spinnaker Gate - 1.28.1

  - chore(dockerfile): upgrade to latest alpine image (#1564) (#1566)
  - chore(dependencies): Autobump fiatVersion (#1570)

#### Spinnaker Igor - 1.28.1

  - chore(dockerfile): upgrade to latest alpine image (#1030) (#1032)
  - chore(dependencies): Autobump fiatVersion (#1037)
  - chore(dependencies): Autobump korkVersion (#1047)
  - chore(dependencies): Autobump fiatVersion (#1048)
  - feat(jenkins): Stop Jenkins job when job name has slashes in the job name (backport #1038) (#1052)

#### Spinnaker Kayenta - 1.28.1

  - chore(dockerfile): upgrade to latest alpine image (#900) (#902)
  - chore(dependencies): Autobump orcaVersion (#905)

#### Spinnaker Orca - 1.28.1

  - chore(dockerfile): upgrade to latest alpine image (#4284) (#4286)
  - chore(dependencies): Autobump fiatVersion (#4293)
  - chore(dependencies): Autobump fiatVersion (#4315)
  - chore(dependencies): Autobump korkVersion (#4314)
  - feat(igor): Stop Jenkins job when job name has slashes in the job name (backport #4294) (#4321)
  - fix(stageExecution): In evaluable variable stage restart scenario variables are not cleaned properly (#16) (backport #4307) (#4326)
  - fix(stage): Resource requests on custom stage | Error: got "map", expected "string…" (backport #4295) (#4328)

#### Spinnaker Rosco - 1.28.1

  - chore(dockerfile): upgrade to latest alpine image (backport #894) (#896)
  - fix(install): Fixed bugs in postInstall script that causes installation to fail on Ubuntu 20.04 and 22.04 LTS (#899) (#901)
  - chore(ci): Upload halconfigs to GCS on Tag push (#873) (#902)
  - chore(dependencies): Autobump korkVersion (#908)

#### Spinnaker Deck - 1.28.1

  - fix(core): Do not set static document base URL (#9890) (#9891)
  - fix(search): Error thrown when search version 2 is enabled (#9888) (#9889)
  - fix(links): update link to spinnaker release changelog (#9897) (#9899)
  - perf(pipelinegraph): Improve the performance of the pipeline graph rendering  (backport #9871) (#9906)
  - Fix(core/pipelines): Fix syntax error on ui-select causing stage configuration to not load (backport #9886) (#9908)

#### Spinnaker Clouddriver - 1.28.1

  - chore(dockerfile): upgrade to latest alpine image (#5758) (#5760)
  - chore(dependencies): Autobump fiatVersion (#5771)
  - fix(core): Remove payload data from logs (#5784) (#5789)
  - chore(dependencies): Autobump korkVersion (#5801)
  - chore(dependencies): Autobump fiatVersion (#5802)
  - chore(configserver): use version 0.14.2 of com.github.wnameless.json:json-flattener (#5804) (#5805)
  - fix(appengine): Fixes app engine credentials repo (#5807) (#5808)

#### Spinnaker Echo - 1.28.1

  - chore(dockerfile): upgrade to latest alpine image (#1193) (#1195)
  - chore(dependencies): Autobump fiatVersion (#1199)
  - chore(dependencies): Autobump korkVersion (#1211)
  - chore(dependencies): Autobump fiatVersion (#1212)

