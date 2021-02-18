---
title: v2.23.4 Armory Release (OSS Spinnaker™ v1.23.6)
toc_hide: true
version: 02.23.04
description: >
  Release notes for the Armory Platform
---

## 2021/02/04 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.23.4, use one of the following tools:

- Armory-extended Halyard 1.10 or later
- Armory Operator 1.2.1 or later

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

{{< include "breaking-changes/bc-k8s-job-suffix.md" >}}

{{< include "breaking-changes/bc-orca-forcecacherefresh.md" >}}

{{< include "known-issues/ki-orca-zombie-execution.md" >}}

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

{{< include "known-issues/ki-bake-var-file.md" >}}

{{< include "known-issues/ki-lambda-ui-caching.md" >}}
{{< include "known-issues/ki-healthchecks-dynamicAccounts.md" >}}
{{< include "known-issues/ki-dinghy-modules.md" >}}


### Fixed issues

* Fixed an issue where Clouddriver fails to cache images that belong to the first account (alphabetically) for each region.  

## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->

This release includes various improvements to security and performance.


###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.23.6](https://www.spinnaker.io/community/releases/versions/1-23-6-changelog) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.23.4
timestamp: "2021-02-03 15:52:32"
services:
    clouddriver:
        commit: 7b2a33c8
        version: 2.23.36
    deck:
        commit: ccf47bbb
        version: 2.23.19
    dinghy:
        commit: 41fde564
        version: 2.23.9
    echo:
        commit: e7ef217c
        version: 2.23.14
    fiat:
        commit: 7124416c
        version: 2.23.11
    front50:
        commit: 95b3ff9c
        version: 2.23.14
    gate:
        commit: dee95e1f
        version: 2.23.13
    igor:
        commit: c932b693
        version: 2.23.13
    kayenta:
        commit: ac7147d0
        version: 2.23.17
    monitoring-daemon:
        version: 2.23.0
    monitoring-third-party:
        version: 2.23.0
    orca:
        commit: fe3d069a
        version: 2.23.21
    rosco:
        commit: 296e82dc
        version: 2.23.18
    terraformer:
        commit: 7710fd96
        version: 2.23.9
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Gate - 2.23.5...2.23.13

  - chore(build): use armory BOM (#219)

#### Armory Igor - 2.23.5...2.23.13

  - chore(build): use armory commons bom (#177) (#179)

#### Armory Deck - 2.23.15...2.23.19

  - chore(deps): bump to new OSS 1.23.6 bom (#728)

#### Armory Clouddriver - 2.23.28...2.23.36

  - fix(build): Dependencies for Spring cloud config + Vault (#266)
  - fix(build): Remove explicit guava - get from armory-commons (#267)

#### Armory Fiat - 2.23.5...2.23.11

  - chore(build): use armory commons BOM (#156) (#158)

#### Armory Front50 - 2.23.6...2.23.14

  - chore(build): use armory commons BOM (#202) (#204)

#### Armory Kayenta - 2.23.8...2.23.17

  - chore(build): use armory commons BOM (#183) (#185)

#### Armory Rosco - 2.23.10...2.23.18

  - chore(build): use armory commons bom  (#185) (#187)

#### Dinghy™ - 2.23.8...2.23.9


#### Armory Echo - 2.23.6...2.23.14

  - fix(build): use armory commons BOM (#279)

#### Armory Orca - 2.23.12...2.23.21

  - fix(build): use armory commons BOM as platform (#205)

#### Terraformer™ - 2.23.6...2.23.9


