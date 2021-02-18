---
title: v2.23.3 Armory Release (OSS Spinnaker™ v1.23.5)
toc_hide: true
version: 02.23.03
description: >
  Release notes for the Armory Platform
---

## 2021/01/06 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.23.3, use one of the following tools:

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
{{< include "known-issues/ki-aws-image-cache.md" >}}

## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->

This release includes bug fixes and performance improvements.

###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.23.5](https://www.spinnaker.io/community/releases/versions/1-23-5-changelog) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.23.3
timestamp: "2021-01-06 18:34:22"
services:
    clouddriver:
        commit: 7b48618e
        version: 2.23.28
    deck:
        commit: c12cb26f
        version: 2.23.15
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
        commit: 602679b2
        version: 2.23.8
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
        commit: 25d9a96b
        version: 2.23.6
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory

#### Armory Deck - 2.23.14...2.23.15

  - chore(deps): bump to new OSS 1.23.5 bom (#710)

#### Armory Front50 - 2.23.6...2.23.6


#### Terraformer™ - 2.23.5...2.23.6

  - refactor(git/repo): improve git/repo perf (bp #295) (#296)

#### Armory Kayenta - 2.23.7...2.23.8

  - fix(kayenta): force oss version to 1.24.0 (#158)

#### Armory Orca - 2.23.12...2.23.12


#### Armory Gate - 2.23.5...2.23.5


#### Armory Echo - 2.23.6...2.23.6


#### Dinghy™ - 2.23.8...2.23.8


#### Armory Fiat - 2.23.5...2.23.5


#### Armory Clouddriver - 2.23.27...2.23.28

  - feat(docker): adding ecr utility to get an ecr token (#235) (#237)

#### Armory Igor - 2.23.5...2.23.5


#### Armory Rosco - 2.23.10...2.23.10


