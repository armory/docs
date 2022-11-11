---
title: v2.27.2 Armory Enterprise Release LTS (Spinnaker™ v1.27.0)
toc_hide: true
version: 02.27.02
description: >
  Release notes for Armory Enterprise v2.27.2 LTS
---

## 2021/12/14 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a previous working version and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Operator version

To install, upgrade, or configure Armory 2.27.2, use the following Operator version:

* Armory Operator 1.4.0 or later

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

This release includes a security fix. For more information, see the Critical Notification that Armory's Support Team sent out on 14 December 2021, contact your Armory account rep, or see this (login required) Support article: https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010520.

## Breaking changes


{{< include "breaking-changes/bc-dinghy-slack.md" >}}

{{< include "breaking-changes/bc-java-tls-mysql.md" >}}

{{< include "breaking-changes/bc-k8s-version-pre1-16.md" >}}

{{< include "breaking-changes/bc-k8s-infra-buttons.md" >}}

{{< include "breaking-changes/bc-hal-deprecation.md" >}}

#### Plugin compatibility

{{< include "breaking-changes/bc-plug-version-lts-227.md" >}}


## Known issues


{{< include "known-issues/ki-bake-var-file.md" >}}
{{< include "known-issues/ki-artifact-binding-spel.md" >}}
{{< include "known-issues/ki-dinghy-gh-notifications.md" >}}


## Highlighted updates

This release includes a security fix. For more information, see the Critical Notification that Armory's Support Team sent out on 14 December 2021, contact your Armory account rep, or see this (login required) Support article: https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010520.

## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.27.2
timestamp: "2021-12-14 23:38:36"
services:
    clouddriver:
        commit: a9bd461d8e5e862925b4c04f77774da97e2ecd73
        version: 2.27.2
    deck:
        commit: d2a44f00f618e01853ef7890abe1ed6d2ce62c2e
        version: 2.27.2
    dinghy:
        commit: 71f2ed003fe6b75d8e4f43e800725f2ff3a8a1fe
        version: 2.27.2
    echo:
        commit: 5ec4a67ff921c2bdefc776dda03a0780ff853bcf
        version: 2.27.2
    fiat:
        commit: f23a1b97346816afc4e8e85dfc3ac137282af64a
        version: 2.27.2
    front50:
        commit: f6339ea78bf6edc39250289b1a9e5545d53bc94f
        version: 2.27.2
    gate:
        commit: 10936c03e0722b42a8d632f7869e4c1ad29610a6
        version: 2.27.2
    igor:
        commit: 9f4db42f060f6fb45aad4c038525d71528a2f9f5
        version: 2.27.2
    kayenta:
        commit: 1cdf69a42c359a1f12077b6b1cba5606ac3e5daf
        version: 2.27.2
    monitoring-daemon:
        version: 2.26.0
    monitoring-third-party:
        version: 2.26.0
    orca:
        commit: 522655a252c5a1a97f7745fe622ba06bccb99a8c
        version: 2.27.2
    rosco:
        commit: ac6fe57054e435c6058911c4caa177cba5fa64b3
        version: 2.27.2
    terraformer:
        commit: 5e69c32279c6516047eaf6de261d3632095677aa
        version: 2.27.2
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Rosco - 2.27.1...2.27.2


#### Dinghy™ - 2.27.1...2.27.2


#### Armory Kayenta - 2.27.1...2.27.2


#### Armory Front50 - 2.27.1...2.27.2


#### Armory Fiat - 2.27.1...2.27.2


#### Armory Deck - 2.27.1...2.27.2

  - chore(cd): update base deck version to 2021.0.0-20211115175155.release-1.27.x (#1148)

#### Armory Gate - 2.27.1...2.27.2

  - chore(cd): update base service version to gate:2021.12.14.20.34.14.release-1.27.x (#355)

#### Armory Orca - 2.27.1...2.27.2


#### Armory Echo - 2.27.1...2.27.2


#### Armory Clouddriver - 2.27.1...2.27.2


#### Terraformer™ - 2.27.1...2.27.2


#### Armory Igor - 2.27.1...2.27.2


