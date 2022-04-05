---
title: v2.24.1 Armory Release (OSS Spinnaker™ v1.24.4)
toc_hide: true
version: 02.24.01
description: >
  Release notes for v2.24.1 Armory Enterprise
---

## 2021/03/16 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

For information about what Armory supports for this version, see the [Armory Enterprise v2.24 compatibility matrix](https://v2-24.docs.armory.io/docs/armory-platform-matrix/).

## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.24.1, use one of the following tools:

- Armory-extended Halyard 1.10 or later
- Armory Operator 1.2.1 or later

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->
> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

{{< include "breaking-changes/bc-k8s-job-suffix.md" >}}

<!-- Moved this to Breaking changes instead of KI. Didn't bother renaming it. -->
{{< include "known-issues/ki-orca-zombie-execution.md" >}}

{{< include "breaking-changes/bc-orca-forcecacherefresh.md" >}}


## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->
{{< include "known-issues/ki-bake-var-file.md" >}}
{{< include "known-issues/ki-lambda-ui-caching.md" >}}
{{< include "known-issues/ki-dinghy-modules.md" >}}

### Fixed issues

* Fixed an issue where pull request comments on GitHub caused the Dinghy pod for Pipelines as Code to crash or report incorrect information.

## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->

### Application metrics for Canary Analysis

Improved how the Kayenta service handles data from Dynatrace. The integration now parses integer and null data points properly.

### Security

Resolved CVEs.

### Terraform Integration

Named Profiles for static type credentials now support using key/value pairs in a Terraform variable file. You can use these key/value pairs for configs such as secrets.


###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.24.4](https://spinnaker.io/changelogs/1.24.4-changelog/) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.24.1
timestamp: "2021-03-16 11:55:29"
services:
    clouddriver:
        commit: b3e8200e
        version: 2.24.23
    deck:
        commit: 8a779fcb
        version: 2.24.3
    dinghy:
        commit: badda447
        version: 2.24.10
    echo:
        commit: 58e19e4d
        version: 2.24.11
    fiat:
        commit: 5acc8fbc
        version: 2.24.12
    front50:
        commit: 683f90b4
        version: 2.24.12
    gate:
        commit: 162f0379
        version: 2.24.14
    igor:
        commit: 0abefd92
        version: 2.24.9
    kayenta:
        commit: af2612d0
        version: 2.24.14
    monitoring-daemon:
        version: 2.24.0
    monitoring-third-party:
        version: 2.24.0
    orca:
        commit: fa3ca91a
        version: 2.24.13
    rosco:
        commit: 3e3e744c
        version: 2.24.12
    terraformer:
        commit: e2d6b847
        version: 2.24.4
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Rosco - 2.24.4...2.24.12

  - chore(build): use armory commons bom  (#185) (#186)
  - chore(build): backport armory-commons changes (#195)


#### Terraformer™ - 2.24.2...2.24.4

  - fix(cve): Alpine > 3.13 to fix glib and openssh cves (#328) (#329)
  - fix(profiles): support passing vars via TF_VAR (#339) (#341)

#### Armory Clouddriver - 2.24.10...2.24.23

  - chore(build): use Armory commons BOM, remove some unused constraints (#271) (#272)
  - chore(dependencies): exclude tencent, huawei, oracle, yandex, move junit/logback to bom (bp #274) (#277)
  - chore(build): bump google sdk to fix CVEs (#280) (#281)

#### Armory Orca - 2.24.5...2.24.13

  - chore(build): use armory commons BOM (#209)
  - chore(dependencies): use armory commons bom (#212) (#214)

#### Armory Kayenta - 2.24.7...2.24.14

  - chore(build): use armory commons BOM (#183) (#184)
  - chore(build): use armory commons bom (#192)
  - fix(dynatrace): fix parse of datapoints values (#204) (#205)

#### Dinghy™ - 2.24.5...2.24.10

  - feat(Post_multiple_comments_for_lengthy_logs): Breaks up long log messages into multiple GitHub comments to prevent a 422 (#347) (#348)
  - fix(crash_on_module_updates): adds check to verify a 200 status code on comment post prior to postin the reaction (#358) (#359)
  - fix(crash_on_module_updates): remove call to log.fatal() (#366) (#367)

#### Armory Deck - 2.24.1...2.24.3


#### Armory Echo - 2.24.4...2.24.11

  - chore(build): use armory-commons BOM (#282) (#283)
  - chore(dependencies): move junit/logback to bom (#285) (#287)

#### Armory Front50 - 2.24.4...2.24.12

  - chore(build): use armory commons BOM (#202) (#203)
  - chore(dependencies): use armory commons bom (#208) (#210)

#### Armory Igor - 2.24.5...2.24.9

  - chore(build): use armory commons bom (#177) (#178)
  - chore(build): rely on armory-commons (#183) (#184)

#### Armory Gate - 2.24.4...2.24.14

  - chore(dependencies): use armory commons bom (bp #223) (#226)

#### Armory Fiat - 2.24.4...2.24.12

  - chore(build): use armory commons BOM (#156) (#157)
  - chore(dependencies): use armory commons bom (#162) (#165)
