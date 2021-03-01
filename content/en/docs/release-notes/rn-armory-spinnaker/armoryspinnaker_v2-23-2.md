---
title: v2.23.2 Armory Release (OSS Spinnaker™ v1.23.5)
toc_hide: true
version: 02.23.02
description: >
  Release notes for the Armory Platform
---

## 2020/12/14 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.23.2, use one of the following tools:

- Armory-extended Halyard 1.10 or later
- Armory Operator 1.2.1 or later

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

{{< include "breaking-changes/bc-k8s-job-suffix.md" >}}

{{< include "breaking-changes/bc-orca-forcecacherefresh.md" >}}

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

{{< include "known-issues/ki-bake-var-file.md" >}}

{{< include "known-issues/ki-orca-zombie-execution.md" >}}
{{< include "known-issues/ki-lambda-ui-caching.md" >}}

### Fixed issues

- Fixed an issue where Clouddriver consumed more threads than it needed, which led to situations where pods did not have enough resources to start.
- Fixed an issue where Slack notifications for Pipelines as Code (Dinghy) did not work.
- Fixed an issue where an old version of Deck, the Spinnaker UI, was included in the Armory release.

## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->

### Notifications

Armory now supports using Microsoft Teams for notifications. For more information, see [Microsoft Teams](https://spinnaker.io/setup/features/notifications/#microsoft-teams).

### Terraform Integration

This release includes better logging for when a 503 error occurs between the Terraform Integration and Clouddriver.

###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.23.5](https://www.spinnaker.io/community/releases/versions/1-23-5-changelog) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.23.2
timestamp: "2020-12-14 19:12:43"
services:
    clouddriver:
        commit: 99f6675d
        version: 2.23.27
    deck:
        commit: 6b904a9c
        version: 2.23.14
    dinghy:
        commit: 2af1fe54
        version: 2.23.8
    echo:
        commit: 4ee974dd
        version: 2.23.6
    fiat:
        commit: 733f0a48
        version: 2.23.5
    front50:
        commit: "19492652"
        version: 2.23.6
    gate:
        commit: 55345b5a
        version: 2.23.5
    igor:
        commit: 06ff06e0
        version: 2.23.5
    kayenta:
        commit: 6c32239a
        version: 2.23.7
    monitoring-daemon:
        version: 2.23.0
    monitoring-third-party:
        version: 2.23.0
    orca:
        commit: 95f678f3
        version: 2.23.12
    rosco:
        commit: c2b498c9
        version: 2.23.10
    terraformer:
        commit: 9da5ef59
        version: 2.23.5
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Front50 - 2.23.4...2.23.6


#### Armory Igor - 2.23.2...2.23.5


#### Armory Deck - 2.23.10...2.23.14

  - fix(cloudwatch): change textbox template to json editor (#688) (#693)
  - fix(terraform): save the default terraform version (#692) (#694)
  - chore(deps): bump base to OSS 1.23.5 (bp #701) (#702)

#### Dinghy™ - 2.23.5...2.23.8

  - fix(slacknotifications): slack notifications fix for 2.23 (#298) (#302)

#### Armory Echo - 2.23.4...2.23.6


#### Armory Kayenta - 2.23.4...2.23.7

  - fix(cloudwatch): fixes duplicate config (#148) (#152)

#### Armory Rosco - 2.23.5...2.23.10

  - fix(fargate-job-executor): handle duplicate files when recursing config dir, because operator symlinks files more than once (#142) (#147)
  - Fix(fargate-job-executor): dont mutate original config when making orphan token clients (#146) (#148)
  - fix(fargate-job-executor): specify cluster when canceling job (#150) (#151)

#### Armory Gate - 2.23.3...2.23.5


#### Armory Orca - 2.23.10...2.23.12


#### Terraformer™ - 2.23.2...2.23.5

  - chore(logging): improve logging when clouddriver returns 503 (#285) (#289)

#### Armory Clouddriver - 2.23.25...2.23.27


#### Armory Fiat - 2.23.3...2.23.5
