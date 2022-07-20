---
title: v2.28.0 Armory Release (OSS Spinnaker™ v1.28.0)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
description: >
  Release notes for Armory Enterprise v2.28.0
---

## 2022/07/20 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.28.0, use one of the following tools:

- Armory-extended Halyard <PUT IN A VERSION NUMBER> or later
- Armory Operator <PUT IN A VERSION NUMBER> or later

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->




###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.28.0](https://www.spinnaker.io/changelogs/1.28.0-changelog/) changelog for details.

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
    commit: adbe01b56d31389c9cad1274b894c740835c3834
    version: 2.28.0
  deck:
    commit: 108847b83576abf24d437a0c89015a65f337ec54
    version: 2.28.0
  dinghy:
    commit: 403640bc88ad42cc55105bff773408d5f845e49c
    version: 2.28.0
  echo:
    commit: 488477dd85edfc6206337bb31f76892e641d1803
    version: 2.28.0
  fiat:
    commit: 5728f3484b01459e9b246117cdfbb54f9d00768c
    version: 2.28.0
  front50:
    commit: 1bc61a77916acf5bf7b13041005e730bdac8cd8e
    version: 2.28.0
  gate:
    commit: 938dccc232f849bae4446376579a39755267904b
    version: 2.28.0
  igor:
    commit: c10937f0110f81bd2f17dfea79bfbf01f53598a5
    version: 2.28.0
  kayenta:
    commit: 7bfe2c300432c865f10f07985d81decb58b1ee48
    version: 2.28.0
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 30ca83945081107105b9186461730988fabd11d5
    version: 2.28.0
  rosco:
    commit: 36a55d07da5f25fc385e67922e35f387f13a6fb1
    version: 2.28.0
  terraformer:
    commit: c3c07a7c4f09752409183f906fb9fa5458e7d602
    version: 2.28.0
timestamp: "2022-07-19 18:54:16"
version: 2.28.0
</code>
</pre>
</details>

### Armory


#### Terraformer™ - 2.27.3...2.28.0


#### Armory Clouddriver - 2.27.3...2.28.0


#### Armory Rosco - 2.27.3...2.28.0


#### Armory Deck - 2.27.3...2.28.0


#### Armory Front50 - 2.27.3...2.28.0


#### Dinghy™ - 2.27.3...2.28.0


#### Armory Kayenta - 2.27.3...2.28.0


#### Armory Echo - 2.27.3...2.28.0


#### Armory Orca - 2.27.3...2.28.0


#### Armory Gate - 2.27.3...2.28.0


#### Armory Igor - 2.27.3...2.28.0


#### Armory Fiat - 2.27.3...2.28.0


