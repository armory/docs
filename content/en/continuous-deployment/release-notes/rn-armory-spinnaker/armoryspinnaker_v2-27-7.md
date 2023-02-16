---
title: v2.27.7 Armory Release (OSS Spinnaker™ v1.27.3)
toc_hide: true
version: 02.27.07
date: 2023-02-16
description: >
  Release notes for Armory Enterprise v2.27.7
---

## 2023/02/16 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a previous working version and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory 2.27.7, use Armory Operator 1.70 or later.

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

## Early Access features

### Make the timeout value for DetermineRollbackCandidatesTask within the rollbackCluster stage be configurable via the Spinnaker UI/Portal

Description to follow

### Pipelines as Code multi-branch enhancement

Now you can configure Pipelines as Code to pull Dinghy files from multiple branches in the same repo. Cut out the tedious task of managing multiple repos; have a single repo for Spinnaker application pipelines. See [Multiple branches]({{< ref "continuous-deployment/armory-admin/dinghy-enable#multiple-branches" >}}) for how to enable and configure this feature.

### Feature flag in Orca to use the new Igor stop endpoint 

When defining a Jenkins job inside folders, the name contains slashes. Because of that, instead of matching the request to the IGOR STOP endpoint (`/masters/{name}/jobs/{jobName}/stop/{queuedBuild}/{buildNumber}`), Spring is matching the request to the BUILD one (`/masters/{name}/jobs/**`)
The stop request is failing because it is trying to start a job that does not exist.  A [feature flag](https://spinnaker.io/changelogs/1.29.0-changelog/#orca) was added to call the existing endpoint (which accepts the job name as path variable) or the new one (which accepts the job name as a query parameter).

## Fixed

* Updated google cloud SDK to support GKE >1.26

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
    commit: dc29b777268954cce13b1b36b152d4e2a493caa9
    version: 2.27.7
  deck:
    commit: be6776c69c18743de1df214acaa500250569a146
    version: 2.27.7
  dinghy:
    commit: ca161395d61ae5e93d1f9ecfbb503b68c2b54bc5
    version: 2.27.7
  echo:
    commit: 3204f90e951562245c62430d863617c34b3a0826
    version: 2.27.7
  fiat:
    commit: b3ca6748d2377454949420613e7912748ea00b52
    version: 2.27.7
  front50:
    commit: 5e1fe36c4b8df29cc9cb4d7af581a44b0ca44e59
    version: 2.27.7
  gate:
    commit: adf9732bc7b3c8df48b21b86ef9783efcadec78b
    version: 2.27.7
  igor:
    commit: 9e2d7946da19c803eb0bd12e888c5119528a364c
    version: 2.27.7
  kayenta:
    commit: 5a1efcefddfe78f37550f5bee723570e3737ce04
    version: 2.27.7
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: b239fa305820b1102d38fe4d0beeaca847c0f4f2
    version: 2.27.7
  rosco:
    commit: f4164fdcfa275b62e0c0fefbe26b5cbd845c543d
    version: 2.27.7
  terraformer:
    commit: f845ba2fc760c46b98794a10c32cc2b713c7c9e0
    version: 2.27.7
timestamp: "2023-02-08 07:01:33"
version: 2.27.7
</code>
</pre>
</details>

### Armory


#### Armory Orca - 2.27.6...2.27.7

  - chore(cd): update base orca version to 2023.02.03.15.10.20.release-1.27.x (#585)

#### Armory Rosco - 2.27.6...2.27.7


#### Armory Deck - 2.27.6...2.27.7

  - chore(cd): update base deck version to 2023.0.0-20230203161357.release-1.27.x (#1295)

#### Armory Echo - 2.27.6...2.27.7


#### Armory Clouddriver - 2.27.6...2.27.7

  - chore(cd): update base service version to clouddriver:2023.01.27.17.41.53.release-1.27.x (#784)

#### Armory Fiat - 2.27.6...2.27.7


#### Armory Front50 - 2.27.6...2.27.7


#### Dinghy™ - 2.27.6...2.27.7


#### Armory Gate - 2.27.6...2.27.7


#### Armory Igor - 2.27.6...2.27.7


#### Armory Kayenta - 2.27.6...2.27.7


#### Terraformer™ - 2.27.6...2.27.7



### Spinnaker


#### Spinnaker Orca - 1.27.3

  - fix(timeout): Added feature flag for rollback timeout ui input. (backport #4383) (#4384)

#### Spinnaker Rosco - 1.27.3


#### Spinnaker Deck - 1.27.3

  - fix(timeout): Added feature flag for rollback timeout ui input. (backport #9937) (#9939)

#### Spinnaker Echo - 1.27.3


#### Spinnaker Clouddriver - 1.27.3

  - feat(gke): Enables gcloud auth plugin for 1.26+ GKE clusters (backport #5847) (#5852)

#### Spinnaker Fiat - 1.27.3


#### Spinnaker Front50 - 1.27.3


#### Spinnaker Gate - 1.27.3


#### Spinnaker Igor - 1.27.3


#### Spinnaker Kayenta - 1.27.3


