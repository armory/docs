---
title: v2.27.5 Armory Release (OSS Spinnaker™ v1.27.3)
toc_hide: true
version: 02.27.05
date: 2023-01-12
description: >
  Release notes for Armory Enterprise v2.27.5
---

## 2023/01/12 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a previous working version and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory 2.27.5, use Armory Operator 1.70 or later.

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

{{< include "breaking-changes/bc-k8s-version-pre1-16.md" >}}
{{< include "breaking-changes/bc-k8s-infra-buttons.md" >}}
{{< include "breaking-changes/bc-hal-deprecation.md" >}}
{{< include "breaking-changes/bc-plug-version-lts-227.md" >}}

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

{{< include "known-issues/ki-artifact-binding-spel.md" >}}
{{< include "known-issues/ki-dinghy-gh-notifications.md" >}}
{{< include "known-issues/ki-secrets-and-spring-cloud.md" >}}
{{< include "known-issues/ki-pipelines-as-code-gh-comments.md" >}}

## Early Access

### Pipelines as Code multi-branch enhancement

Now you can configure Pipelines as Code to pull Dinghy files from multiple branches on the same repo. Cut out the tedious task of managing multiple repos; have a single repo for Spinnaker application pipelines. See [Multiple branches]({{< ref "continuous-deployment/armory-admin/dinghy-enable#multiple-branches" >}}) for how to enable and configure this feature.

### Feature flag in Orca to use the new Igor stop endpoint 

When defining a Jenkins job inside folders, the name contains slashes. Because of that, instead of matching the request to the IGOR STOP endpoint (`/masters/{name}/jobs/{jobName}/stop/{queuedBuild}/{buildNumber}`), Spring is matching the request to the BUILD one (`/masters/{name}/jobs/**`)
The stop request is failing because it is trying to start a job that does not exist.  A [feature flag](https://spinnaker.io/changelogs/1.29.0-changelog/#orca) was added to call the existing endpoint (which accepts the job name as path variable) or the new one (which accepts the job name as a query parameter).

## Fixes

### General
  * Revision History Display - Addressed an issue where the revision history was not showing the timestamp of the revision.
  * Duplicate Pipelines - Addressed an issue where Spinnaker users were ending up with duplicate pipelines when using pipelines as code.
  * Jenkins Backlinks - Fixed an issue where Igor was failing when Jenkins backlinks were enabled.
  * KubernetesManifest - Teach KubernetesManifest to support kubernetes resources where the spec is not a map.

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->


###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.27.3](https://www.spinnaker.io/changelogs/1.27.3-changelog/) changelog for details.

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
    commit: f310d91adf02ab892147e02fd549fd09af05a332
    version: 2.27.5
  deck:
    commit: 1d2408e6d94fa62200bd0b776fdc021c5ff9f83d
    version: 2.27.5
  dinghy:
    commit: ca161395d61ae5e93d1f9ecfbb503b68c2b54bc5
    version: 2.27.5
  echo:
    commit: ed3c35253d27af121a5a6874de9b006d3b5d3bcf
    version: 2.27.5
  fiat:
    commit: 9d615d351b220ea846e3c31890ecea7757fe40f4
    version: 2.27.5
  front50:
    commit: 8be88a5e2efdf5ac85b6ea38c264d762e8ccf523
    version: 2.27.5
  gate:
    commit: adf9732bc7b3c8df48b21b86ef9783efcadec78b
    version: 2.27.5
  igor:
    commit: 9e2d7946da19c803eb0bd12e888c5119528a364c
    version: 2.27.5
  kayenta:
    commit: 08b8f4656b4f6285ae5b0a5577ab10f6c50ba8ec
    version: 2.27.5
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: fa3449f0202512534382d2d2a0431f25f4f408c5
    version: 2.27.5
  rosco:
    commit: f4164fdcfa275b62e0c0fefbe26b5cbd845c543d
    version: 2.27.5
  terraformer:
    commit: 0703f04671e56a94ac99e436a30c237b274e9407
    version: 2.27.5
timestamp: "2022-12-08 23:35:17"
version: 2.27.5
</code>
</pre>
</details>

### Armory


#### Armory Front50 - 2.27.4...2.27.5

  - chore(cd): update base service version to front50:2022.08.17.22.13.34.release-1.27.x (#448)
  - chore(cd): update base service version to front50:2022.09.12.22.11.40.release-1.27.x (#454)

#### Armory Kayenta - 2.27.4...2.27.5


#### Terraformer™ - 2.27.4...2.27.5

  - Updating up to 1.3.5 tf version (#480)
  - fix(log): calling remote logging asynchronously (#471) (#486)

#### Armory Clouddriver - 2.27.4...2.27.5

  - chore(cd): update base service version to clouddriver:2022.09.27.19.40.03.release-1.27.x (#724)
  - chore(cd): update base service version to clouddriver:2022.11.17.17.20.07.release-1.27.x (#741)
  - chore(cd): update base service version to clouddriver:2022.11.18.20.27.41.release-1.27.x (#744)
  - chore(cd): update base service version to clouddriver:2022.11.29.22.19.50.release-1.27.x (#751)

#### Armory Echo - 2.27.4...2.27.5

  - chore(cd): update base service version to echo:2022.11.18.20.17.06.release-1.27.x (#499)
  - chore(cd): update base service version to echo:2022.11.29.21.47.09.release-1.27.x (#503)

#### Armory Gate - 2.27.4...2.27.5

  - chore(cd): update base service version to gate:2022.11.18.20.16.26.release-1.27.x (#487)
  - chore(cd): update base service version to gate:2022.11.29.21.50.55.release-1.27.x (#491)
  - chore(cd): update base service version to gate:2022.12.01.19.38.20.release-1.27.x (#493)

#### Dinghy™ - 2.27.4...2.27.5


#### Armory Igor - 2.27.4...2.27.5

  - chore(cd): update base service version to igor:2022.11.02.03.23.43.release-1.27.x (#374)
  - chore(cd): update base service version to igor:2022.11.18.20.16.38.release-1.27.x (#379)
  - fix: NoSuchMethodError exception in JenkinsClient. (#377) (#386)
  - chore(cd): update base service version to igor:2022.11.29.21.52.13.release-1.27.x (#389)

#### Armory Deck - 2.27.4...2.27.5

  - chore(cd): update base deck version to 2022.0.0-20221021162941.release-1.27.x (#1263)
  - chore(cd): update base deck version to 2022.0.0-20221129214343.release-1.27.x (#1278)

#### Armory Orca - 2.27.4...2.27.5

  - chore(cd): update base orca version to 2022.11.02.03.24.06.release-1.27.x (#534)
  - chore(cd): update base orca version to 2022.11.08.07.29.37.release-1.27.x (#537)
  - chore(cd): update base orca version to 2022.11.08.22.28.13.release-1.27.x (#540)
  - chore(cd): update base orca version to 2022.11.18.19.16.45.release-1.27.x (#549)
  - chore(cd): update base orca version to 2022.11.18.20.23.15.release-1.27.x (#550)
  - chore(cd): update base orca version to 2022.11.21.16.32.20.release-1.27.x (#553)
  - chore(cd): update base orca version to 2022.11.23.15.54.32.release-1.27.x (#556)

#### Armory Rosco - 2.27.4...2.27.5

  - chore(cd): update base service version to rosco:2022.11.23.15.48.46.release-1.27.x (#467)
  - chore(cd): update base service version to rosco:2022.11.29.21.53.45.release-1.27.x (#471)
  - chore(cd): update base service version to rosco:2022.12.08.21.13.25.release-1.27.x (#475)

#### Armory Fiat - 2.27.4...2.27.5



### Spinnaker


#### Spinnaker Front50 - 1.27.3

  - chore(dependencies): Autobump fiatVersion (#1154)
  - fix(updateTs): missing updateTs field in the get pipeline history's response. (backport #1159) (#1161)

#### Spinnaker Kayenta - 1.27.3


#### Spinnaker Clouddriver - 1.27.3

  - fix(core): Remove payload data from logs (#5784) (#5788)
  - fix(kubernetes): teach KubernetesManifest to support kubernetes resources where the spec is not a map (#5814) (#5816)
  - chore(dependencies): Autobump fiatVersion (#5820)
  - chore(dependencies): Autobump spinnakerGradleVersion (#5819) (#5826)

#### Spinnaker Echo - 1.27.3

  - chore(dependencies): Autobump fiatVersion (#1216)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1215) (#1221)

#### Spinnaker Gate - 1.27.3

  - chore(dependencies): Autobump fiatVersion (#1586)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1585) (#1591)
  - chore(gha): bump versions of github actions (#1594)

#### Spinnaker Igor - 1.27.3

  - feat(jenkins): Stop Jenkins job when job name has slashes in the job name (backport #1038) (#1051)
  - chore(dependencies): Autobump fiatVersion (#1056)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1055) (#1060)

#### Spinnaker Deck - 1.27.3

  - fix(links): update link to spinnaker release changelog (#9897) (#9898)
  - chore(dependencies): Autobump spinnakerGradleVersion (#9916) (#9925)

#### Spinnaker Orca - 1.27.3

  - feat(igor): Stop Jenkins job when job name has slashes in the job name (backport #4294) (#4320)
  - fix(stageExecution): In evaluable variable stage restart scenario variables are not cleaned properly (#16) (backport #4307) (#4325)
  - fix(stage): Resource requests on custom stage | Error: got "map", expected "string…" (backport #4295) (#4329)
  - fix(tasks): Fix MonitorKayentaCanaryTask on results data map (#4312) (#4338)
  - chore(dependencies): Autobump fiatVersion (#4341)
  - chore(dependencies): Autobump spinnakerGradleVersion (#4337) (#4344)
  - feat(bakery): Clean up cached data created by Rosco. (#4323) (#4349)

#### Spinnaker Rosco - 1.27.3

  - feat(bakery): Clean up cached data created by Rosco. (#912) (#920)
  - chore(dependencies): Autobump spinnakerGradleVersion (#917) (#924)
  - Merge pull request from GHSA-wqq8-664f-54hh

#### Spinnaker Fiat - 1.27.3


