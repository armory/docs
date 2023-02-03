---
title: v2.28.2 Armory Continuous Deployment Release (OSS Spinnaker™ v1.28.4)
toc_hide: true
version: 02.28.2
date: 2023-01-09
description: >
  Release notes for Armory Continuous Deployment v2.28.2
---

## 2023/01/09 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a previous working version and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory 2.28.2, use Armory Operator 1.70 or later.

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

{{< include "breaking-changes/bc-orca-rdbms-configured-utf8.md" >}}

{{< include "known-issues/ki-fiat-mysql.md" >}}

{{< include "breaking-changes/bc-kubectl-120.md" >}}

{{< include "breaking-changes/bc-dinghy-slack.md" >}}

{{< include "breaking-changes/bc-java-tls-mysql.md" >}}

{{< include "breaking-changes/bc-k8s-version-pre1-16.md" >}}

{{< include "breaking-changes/bc-k8s-infra-buttons.md" >}}

{{< include "breaking-changes/bc-git-artifact-constraint.md" >}}

{{< include "breaking-changes/bc-hal-deprecation.md" >}}

{{< include "breaking-changes/bc-plugin-compatibility-2-28-0.md" >}}


> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

{{< include "known-issues/ki-empty-roles.md" >}}

{{< include "known-issues/ki-app-attr-not-configured.md" >}}

{{< include "known-issues/ki-app-eng-acct-auth.md" >}}

{{< include "known-issues/ki-spel-expr-art-binding.md" >}}

{{< include "known-issues/ki-pipelines-as-code-gh-comments.md" >}}

{{< include "known-issues/ki-secrets-and-spring-cloud.md" >}}

## Early access

### Pipelines as Code multi-branch enhancement

Now you can configure Pipelines as Code to pull Dinghy files from multiple branches on the same repo. Cut out the tedious task of managing multiple repos; have a single repo for Spinnaker application pipelines. See [Multiple branches]({{< ref "continuous-deployment/armory-admin/dinghy-enable#multiple-branches" >}}) for how to enable and configure this feature.

### Enhanced BitBucket Server pull request handling

Trigger Spinnaker pipelines natively when pull requests are opened in BitBucket with newly added events including PR opened, deleted, and declined. See [Triggering pipelines with Bitbucket Server](https://spinnaker.io/docs/guides/user/pipeline/triggers/bitbucket-events/) in the Spinnaker docs for details.

<!-- Spinnaker docs PR https://github.com/spinnaker/spinnaker.io/pull/285 -->

### Terraform template fix

Armory fixed an issue with SpEL expression failures appearing while using Terraformer to serialize data from a Terraform Plan execution. With this feature flag fix enabled, you will be able to use the Terraform template file provider. Please open a support ticket if you need this fix.


## Highlighted updates

### General fixes

  * **Duplicate Pipelines**: Addressed an issue where Spinnaker users were ending up with duplicate pipelines when using pipelines as code.
  * **Jenkins Backlinks**: Fixed an issue where Igor was failing when Jenkins backlinks were enabled.
  * **Manual Judgment**: Improved the logic around restart scenarios when executing a manual judgment.

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->

###  Spinnaker community contributions

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
    commit: 960c72d1e7e7b9e857d94af9731c3441426ee073
    version: 2.28.2
  deck:
    commit: dd17c153eaf117ab7990c11182a6bdc887d020f9
    version: 2.28.2
  dinghy:
    commit: c4ed5b19dbcfefe8dea14cdff7df9a8ab540eba3
    version: 2.28.2
  echo:
    commit: 6d4e4ae054b7a13050a1d271b3c771a790e27fc6
    version: 2.28.2
  fiat:
    commit: 48c8759b0878fd1b86b91dae9ee288afcf03dd39
    version: 2.28.2
  front50:
    commit: fab8841982330e7537629c9f24f41205cd5863fd
    version: 2.28.2
  gate:
    commit: 65bdd30238312bbca2dce613825eda7ae88f1dfa
    version: 2.28.2
  igor:
    commit: 61ce26babfcd0bdf62872c24e707ca5b5371a381
    version: 2.28.2
  kayenta:
    commit: 6004bfd90ad2e4fa9b02dddc26253210b8aa3a3c
    version: 2.28.2
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 76fe72a46566bb404eb4db4c842ecb0775c546bf
    version: 2.28.2
  rosco:
    commit: 945f21dec252da7dd2e00c8d23a1687aa3b9841a
    version: 2.28.2
  terraformer:
    commit: 0d18998cb4790dd4857d79e318d873450bd5975d
    version: 2.28.2
timestamp: "2022-12-15 10:58:49"
version: 2.28.2
</code>
</pre>
</details>

### Armory


#### Armory Clouddriver - 2.28.1...2.28.2

  - chore(cd): update base service version to clouddriver:2022.11.17.17.21.13.release-1.28.x (#742)
  - chore(cd): update base service version to clouddriver:2022.11.25.21.33.33.release-1.28.x (#750)
  - chore(cd): update base service version to clouddriver:2022.11.29.21.59.34.release-1.28.x (#752)

#### Armory Fiat - 2.28.1...2.28.2

  - chore(cd): update base service version to fiat:2022.11.21.16.27.25.release-1.28.x (#411)

#### Armory Deck - 2.28.1...2.28.2

  - chore(cd): update base deck version to 2022.0.0-20221129214415.release-1.28.x (#1279)
  - chore(cd): update base deck version to 2022.0.0-20221206152435.release-1.28.x (#1282)
  - style(logo): Changed Armory logo (#1264) (#1265)

#### Armory Echo - 2.28.1...2.28.2

  - chore(cd): update base service version to echo:2022.11.29.21.47.23.release-1.28.x (#504)
  - chore(cd): update base service version to echo:2022.12.06.19.49.37.release-1.28.x (#507)

#### Dinghy™ - 2.28.1...2.28.2

  - Updated oss dinghy version to v0.0.0-20221021170743-d8697fabf1e8 (#475)

#### Armory Gate - 2.28.1...2.28.2

  - chore(cd): update base service version to gate:2022.10.19.18.23.12.release-1.28.x (#480)
  - chore(cd): update base service version to gate:2022.10.19.20.00.40.release-1.28.x (#481)
  - fix(header): update plugins.json with newest header version (backport #482) (#483)
  - revert(header): update plugins.json with newest header version (#484) (#485)
  - chore(cd): update base service version to gate:2022.11.29.21.51.30.release-1.28.x (#492)

#### Armory Igor - 2.28.1...2.28.2

  - fix: NoSuchMethodError exception in JenkinsClient. (#377) (#387)
  - chore(cd): update base service version to igor:2022.11.29.21.52.31.release-1.28.x (#390)

#### Terraformer™ - 2.28.1...2.28.2

  - Updating TF versions up to 1.3.4 (#478)
  - fix(log): calling remote logging asynchronously (#471) (#485)
  - fix(versions): Sets version constraints for kubectl & aws-iam-authent… (#487) (#489)

#### Armory Kayenta - 2.28.1...2.28.2


#### Armory Front50 - 2.28.1...2.28.2

  - chore(cd): update base service version to front50:2022.11.29.21.48.45.release-1.28.x (#472)

#### Armory Orca - 2.28.1...2.28.2

  - chore(cd): update base orca version to 2022.11.18.19.16.39.release-1.28.x (#548)
  - chore(cd): update base orca version to 2022.11.21.16.33.46.release-1.28.x (#552)
  - chore(cd): update base orca version to 2022.11.23.15.55.22.release-1.28.x (#557)

#### Armory Rosco - 2.28.1...2.28.2

  - chore(cd): update base service version to rosco:2022.11.23.15.48.41.release-1.28.x (#468)
  - chore(cd): update base service version to rosco:2022.11.29.21.53.24.release-1.28.x (#470)
  - chore(cd): update base service version to rosco:2022.12.08.21.17.26.release-1.28.x (#474)


### Spinnaker


#### Spinnaker Clouddriver - 1.28.4

  - fix(kubernetes): teach KubernetesManifest to support kubernetes resources where the spec is not a map (#5814) (#5817)
  - fix(artifacts/bitbuket): added ACCEPT Header when using token auth (#5813) (#5823)
  - chore(dependencies): Autobump spinnakerGradleVersion (#5819) (#5827)

#### Spinnaker Fiat - 1.28.4

  - fix(permissions): ensure lower case for resource name in fiat_permission and fiat_resource tables (backport #963) (#980)
  - fix(roles): Ensure account manager role is cached (backport #960) (#984)
  - fix: add migration to ensure consistency between resource_name in fiat_resource and fiat_permission tables (backport #964) (#978)
  - chore(dependencies): Autobump korkVersion (#986)
  - chore(dependencies): Autobump spinnakerGradleVersion (#989) (#994)

#### Spinnaker Deck - 1.28.4

  - chore(dependencies): Autobump spinnakerGradleVersion (#9916) (#9926)
  - feat(pipeline): added feature flag for pipeline when mj stage child (backport #9914) (#9920)

#### Spinnaker Echo - 1.28.4

  - chore(dependencies): Autobump spinnakerGradleVersion (#1215) (#1222)
  - feat(webhooks): Handle Bitbucket Server PR events (#1224)

#### Spinnaker Gate - 1.28.4

  - chore(dependencies): Autobump korkVersion (#1581)
  - chore(dependencies): Autobump fiatVersion (#1582)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1585) (#1592)

#### Spinnaker Igor - 1.28.4

  - chore(dependencies): Autobump spinnakerGradleVersion (#1055) (#1061)

#### Spinnaker Kayenta - 1.28.4


#### Spinnaker Front50 - 1.28.4

  - chore(dependencies): Autobump korkVersion (#1170)
  - chore(dependencies): Autobump fiatVersion (#1171)
  - fix(pipelines): prevent from creating duplicated pipelines (#1172) (#1174)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1177) (#1183)

#### Spinnaker Orca - 1.28.4

  - fix(tasks): Fix MonitorKayentaCanaryTask on results data map (#4312) (#4339)
  - chore(dependencies): Autobump spinnakerGradleVersion (#4337) (#4345)
  - feat(bakery): Clean up cached data created by Rosco. (#4323) (#4350)

#### Spinnaker Rosco - 1.28.4

  - feat(bakery): Clean up cached data created by Rosco. (#912) (#921)
  - chore(dependencies): Autobump spinnakerGradleVersion (#917) (#925)
  - Merge pull request from GHSA-wqq8-664f-54hh

