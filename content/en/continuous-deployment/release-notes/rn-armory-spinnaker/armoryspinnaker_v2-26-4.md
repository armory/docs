---
title: v2.26.4 Armory Continuous Deployment Release (Spinnaker™ v1.26.6)
toc_hide: true
version: 02.26.04
date: 2021-12-15
description: >
  Release notes for Armory Continuous Deployment v2.26.4
---

## 2021/12/15 Release Notes

> Note: If you're experiencing production issues after upgrading Armory Continuous Deployment, rollback to a previous working version and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Halyard or Operator version
​
To install, upgrade, or configure Armory 2.26.4, use one of the following tools:
​
- Armory-extended Halyard 1.12 or later
  - 2.26.x is the last minor release that you can use Halyard to install or manage. Future releases require the Armory Operator. For more information, see [Halyard Deprecation]({{< ref "halyard-deprecation" >}}).
​
- Armory Operator 1.2.6 or later
​
   For information about upgrading, Operator, see [Upgrade the Operator]({{< ref "op-manage-operator#upgrade-the-operator" >}}).
​
​
## Security
​
Armory scans the codebase as we develop and release software. For information about CVE scans for this release, see the [Support Portal](https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010414). Note that you must be logged in to the portal to see the information.

This release includes a security fix. For more information, see the Critical Notification that Armory's Support Team sent out on 14 December 2021, contact your Armory account rep, or see this (login required) Support article: https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010520.
​
## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->
​
{{< include "breaking-changes/bc-java-tls-mysql.md" >}}
​
{{< include "breaking-changes/bc-k8s-version-pre1-16.md" >}}
​
{{< include "breaking-changes/bc-k8s-infra-buttons.md" >}}
​
## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->
​
{{< include "known-issues/ki-bake-var-file.md" >}}
{{< include "known-issues/ki-artifact-binding-spel.md" >}}
{{< include "known-issues/ki-dinghy-gh-notifications.md" >}}
​
## Highlighted updates
​
This release includes a security fix. For more information, see the Critical Notification that Armory's Support Team sent out on 14 December 2021, contact your Armory account rep, or see this (login required) Support article: https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010520.

###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.26.6](https://www.spinnaker.io/changelogs/1.26.6-changelog/) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.26.4
timestamp: "2021-12-15 17:47:54"
services:
    clouddriver:
        commit: 18729608df655fa9ffdf28a968e4bdf22e140e59
        version: 2.26.24
    deck:
        commit: 198d62eae2710dceed1f462e50a183abba613fef
        version: 2.26.11
    dinghy:
        commit: d1406fad85771d7f44a266d3302d6195c00d7ec2
        version: 2.26.12
    echo:
        commit: ce4f4ed265be8cb746784c6fd4bed7bf5156107e
        version: 2.26.12
    fiat:
        commit: e46182a670fc9bac7c02f809df7ffe65c89ba148
        version: 2.26.13
    front50:
        commit: 7e14c30538a9b97468aba0360408abf4a06bc0dd
        version: 2.26.14
    gate:
        commit: 41c92b2d613e47521c60d2c9036504ff405fbb91
        version: 2.26.12
    igor:
        commit: 889135384533cd723c0a6377a37a7365cf92a8b2
        version: 2.26.12
    kayenta:
        commit: 2403ad86e76898a65939ebdf879bf287fa8b1429
        version: 2.26.13
    monitoring-daemon:
        version: 2.26.0
    monitoring-third-party:
        version: 2.26.0
    orca:
        commit: 624af61e6bf75bc92e67a6bef6439f8ae29ec79a
        version: 2.26.18
    rosco:
        commit: cbb42562fad6583e6efcb24a7378cb6fd84668f0
        version: 2.26.18
    terraformer:
        commit: 2dc177734c1445252dfeb3b8353ce94596c8a4c3
        version: 2.26.14
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Igor - 2.26.11...2.26.12

  - chore(build): bump armory-commons 3.9.6 (backport #260) (#262)

#### Armory Clouddriver - 2.26.20...2.26.24

  - chore(build): Autobump armory-commons: 3.9.6 (backport #364) (#458)

#### Armory Kayenta - 2.26.12...2.26.13

  - chore(build): remove platform build (#279)
  - chore(build): Autobump armory-commons: 3.9.6 (backport #268) (#281)

#### Armory Echo - 2.26.11...2.26.12

  - chore(build): Autobump armory-commons: 3.9.6 (backport #351) (#372)

#### Armory Deck - 2.26.10...2.26.11


#### Armory Orca - 2.26.17...2.26.18

  - chore(build): remove platform build (#364)
  - chore(build): Autobump armory-commons: 3.9.6 (backport #335) (#368)

#### Terraformer™ - 2.26.13...2.26.14


#### Armory Gate - 2.26.11...2.26.12

  - chore(build): Autobump armory-commons: 3.9.6 (backport #305) (#329)
  - chore(cd): update base service version to gate:2021.12.14.23.45.08.release-1.26.x (#356)

#### Dinghy™ - 2.26.11...2.26.12


#### Armory Rosco - 2.26.15...2.26.18

  - chore(build): Autobump armory-commons: 3.9.6 (backport #286) (#310)

#### Armory Fiat - 2.26.12...2.26.13

  - chore(build): Autobump armory-commons: 3.9.6 (backport #232) (#257)
  - chore(cd): update base service version to fiat:2021.12.14.22.49.55.release-1.26.x (#283)

#### Armory Front50 - 2.26.13...2.26.14

  - chore(build): remove platform build (#312)
  - chore(build): Autobump armory-commons: 3.9.6 (backport #285) (#318)
