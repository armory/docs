---
title: v2.23.5 Armory Release (OSS Spinnaker™ v1.23.7)
toc_hide: true
version: 02.23.05
description: >
  Release notes for the Armory Platform
---

## 2021/02/04 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.23.5, use one of the following tools:

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

## Highlighted updates

### Cloudfoundry

Improved how  Spring Cloud Config and another dynamic account solutions perform. Credentials definition now get compared against existing definitions. This ensures that Armory only updates credentials when they are updated orchanged.
This improvement also adds an annotation to ensure credentials are compared correctly with the equals operation.



###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.23.7](https://www.spinnaker.io/community/releases/versions/1-23-7-changelog) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.23.5
timestamp: "2021-02-20 00:39:19"
services:
    clouddriver:
        commit: 101a373e
        version: 2.23.37
    deck:
        commit: 480bcbd3
        version: 2.23.20
    dinghy:
        commit: 41fde564
        version: 2.23.9
    echo:
        commit: a2d96ae3
        version: 2.23.15
    fiat:
        commit: a57d1be1
        version: 2.23.12
    front50:
        commit: 18e2d6eb
        version: 2.23.15
    gate:
        commit: 50bb95a7
        version: 2.23.14
    igor:
        commit: fb8b50d5
        version: 2.23.14
    kayenta:
        commit: ac7147d0
        version: 2.23.17
    monitoring-daemon:
        version: 2.23.0
    monitoring-third-party:
        version: 2.23.0
    orca:
        commit: 3ebabac6
        version: 2.23.22
    rosco:
        commit: "28400960"
        version: 2.23.19
    terraformer:
        commit: dd566b91
        version: 2.23.10
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Deck - 2.23.19...2.23.20


#### Armory Echo - 2.23.14...2.23.15


#### Armory Igor - 2.23.13...2.23.14


#### Armory Kayenta - 2.23.17...2.23.17


#### Armory Fiat - 2.23.11...2.23.12


#### Armory Gate - 2.23.13...2.23.14


#### Armory Orca - 2.23.21...2.23.22


#### Armory Clouddriver - 2.23.36...2.23.37


#### Dinghy™ - 2.23.9...2.23.9


#### Terraformer™ - 2.23.9...2.23.10

  - fix(cve): Alpine > 3.13 to fix glib and openssh cves (#328) (#349)

#### Armory Rosco - 2.23.18...2.23.19


#### Armory Front50 - 2.23.14...2.23.15


