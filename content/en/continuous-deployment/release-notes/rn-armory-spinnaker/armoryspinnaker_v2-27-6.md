---
title: v2.27.6 Armory Release (OSS Spinnaker™ v1.27.3)
toc_hide: true
version: 02.27.06
date: 2023-01-30
description: >
  Release notes for Armory Continuous Deployment v2.27.6
---

## 2023/01/30 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a previous working version and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory 2.27.6, use Armory Operator 1.70 or later.

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

{{< include "breaking-changes/bc-k8s-version-pre1-16.md" >}}
{{< include "breaking-changes/bc-k8s-infra-buttons.md" >}}
{{< include "breaking-changes/bc-hal-deprecation.md" >}}
{{< include "breaking-changes/bc-plug-version-lts-227.md" >}}

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

{{< include "known-issues/ki-artifact-binding-spel.md" >}}
{{< include "known-issues/ki-dinghy-gh-notifications.md" >}}
{{< include "known-issues/ki-secrets-and-spring-cloud.md" >}}
{{< include "known-issues/ki-pipelines-as-code-gh-comments.md" >}}

## Early Access features

### Pipelines as Code multi-branch enhancement

Now you can configure Pipelines as Code to pull Dinghy files from multiple branches in the same repo. Cut out the tedious task of managing multiple repos; have a single repo for Spinnaker application pipelines. See [Multiple branches]({{< ref "plugins/pipelines-as-code/install-cdsh#multiple-branches" >}}) for how to enable and configure this feature.

### Feature flag in Orca to use the new Igor stop endpoint 

When defining a Jenkins job inside folders, the name contains slashes. Because of that, instead of matching the request to the IGOR STOP endpoint (`/masters/{name}/jobs/{jobName}/stop/{queuedBuild}/{buildNumber}`), Spring is matching the request to the BUILD one (`/masters/{name}/jobs/**`)
The stop request is failing because it is trying to start a job that does not exist.  A [feature flag](https://spinnaker.io/changelogs/1.29.0-changelog/#orca) was added to call the existing endpoint (which accepts the job name as path variable) or the new one (which accepts the job name as a query parameter).

## Fixes

* Updated google cloud SDK to support GKE >1.26
* Bumped commons-text to address CVE-2022-42889
* Add migration to ensure consistency between resource_name in fiat_resource and fiat_permission tables

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
    commit: 60eafebf9875071709e3d8ec53d2729a197574f1
    version: 2.27.6
  deck:
    commit: 0802cbb92aa32eb6b387b5a6e54db14843fc6f31
    version: 2.27.6
  dinghy:
    commit: ca161395d61ae5e93d1f9ecfbb503b68c2b54bc5
    version: 2.27.6
  echo:
    commit: 3204f90e951562245c62430d863617c34b3a0826
    version: 2.27.6
  fiat:
    commit: b3ca6748d2377454949420613e7912748ea00b52
    version: 2.27.6
  front50:
    commit: 5e1fe36c4b8df29cc9cb4d7af581a44b0ca44e59
    version: 2.27.6
  gate:
    commit: adf9732bc7b3c8df48b21b86ef9783efcadec78b
    version: 2.27.6
  igor:
    commit: 9e2d7946da19c803eb0bd12e888c5119528a364c
    version: 2.27.6
  kayenta:
    commit: 5a1efcefddfe78f37550f5bee723570e3737ce04
    version: 2.27.6
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: fa3449f0202512534382d2d2a0431f25f4f408c5
    version: 2.27.6
  rosco:
    commit: f4164fdcfa275b62e0c0fefbe26b5cbd845c543d
    version: 2.27.6
  terraformer:
    commit: f845ba2fc760c46b98794a10c32cc2b713c7c9e0
    version: 2.27.6
timestamp: "2023-01-20 20:04:33"
version: 2.27.6
</code>
</pre>
</details>

### Armory


#### Armory Kayenta - 2.27.5...2.27.6

  - fix(kayenta-integration-tests): update dynatrace tenant to qso00828 (backport #376) (#378)
  - chore(cd): update base service version to kayenta:2022.12.01.22.29.56.release-1.27.x (#373)

#### Armory Orca - 2.27.5...2.27.6


#### Terraformer™ - 2.27.5...2.27.6

  - fix(versions): Sets version constraints for kubectl & aws-iam-authent… (backport #487) (#488)
  - Fixes builds with golint being dead until were on a newer golang (#491) (#494)
  - feat(gcloud): Bump to latest gcloud sdk & adds the GKE Auth plugin (#490) (#492)

#### Armory Rosco - 2.27.5...2.27.6


#### Armory Deck - 2.27.5...2.27.6

  - style(logo): Changed Armory logo (#1264) (#1266)

#### Armory Clouddriver - 2.27.5...2.27.6

  - feat(google): Updated google cloud SDK to support GKE >1.26 (#769) (#771)
  - chore(cd): update base service version to clouddriver:2023.01.20.18.19.32.release-1.27.x (#781)

#### Armory Fiat - 2.27.5...2.27.6

  - chore(cd): update base service version to fiat:2022.11.18.19.29.05.release-1.27.x (#408)

#### Armory Gate - 2.27.5...2.27.6


#### Armory Echo - 2.27.5...2.27.6

  - chore(cd): update base service version to echo:2022.12.14.15.47.16.release-1.27.x (#515)
  - chore(cd): update base service version to echo:2023.01.20.14.47.33.release-1.27.x (#525)

#### Armory Front50 - 2.27.5...2.27.6

  - chore(cd): update base service version to front50:2022.12.01.21.15.09.release-1.27.x (#473)

#### Armory Igor - 2.27.5...2.27.6


#### Dinghy™ - 2.27.5...2.27.6



### Spinnaker


#### Spinnaker Kayenta - 1.27.3

  - fix(security): Bump commons-text for CVE-2022-42889 (#911) (#913)
  - chore(dependencies): Autobump orcaVersion (#918)
  - chore(dependencies): Autobump orcaVersion (#919)
  - chore(dependencies): Autobump spinnakerGradleVersion (#917) (#920)

#### Spinnaker Orca - 1.27.3


#### Spinnaker Rosco - 1.27.3


#### Spinnaker Deck - 1.27.3


#### Spinnaker Clouddriver - 1.27.3

  - chore(dependencies): pin version of com.github.tomakehurst:wiremock (#5845) (#5857)

#### Spinnaker Fiat - 1.27.3

  - fix(permissions): ensure lower case for resource name in fiat_permission and fiat_resource tables (backport #963) (#979)
  - chore(build): set timeout for apt publishing to 5 minutes (#987)
  - chore(build): set timeout for apt publishing to 10 minutes and add --stacktrace (#988)
  - chore(dependencies): Autobump spinnakerGradleVersion (#989) (#990)
  - Cleanup publish debugging (#991)

#### Spinnaker Gate - 1.27.3


#### Spinnaker Echo - 1.27.3

  - feat(event): Add circuit breaker for events sending. (#1233) (#1238)
  - fix: The circuit breaker feature for sending events to telemetry endpoint is hidden under a required feature flag property (#1241) (#1244)

#### Spinnaker Front50 - 1.27.3

  - chore(dependencies): Autobump fiatVersion (#1178)
  - fix(pipelines): prevent from creating duplicated pipelines (#1172) (#1173)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1177) (#1182)
  - chore(gha): bump versions of github actions (#1185)

#### Spinnaker Igor - 1.27.3


