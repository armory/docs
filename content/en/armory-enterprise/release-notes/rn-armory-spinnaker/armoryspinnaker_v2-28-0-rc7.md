---
title: v2.28.0-rc7 Armory Release (OSS Spinnaker™ v1.28.0)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
description: >
  Release notes for Armory Enterprise v2.28.0-rc7
---

## 2022/06/14 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.28.0-rc7, use one of the following tools:

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
    commit: 188d76cfbc65dd5da1d7de9e7813a8d107945066
    version: 2.28.0-rc7
  deck:
    commit: 693348595c771625ac4bdc5224921b5882578d79
    version: 2.28.0-rc7
  dinghy:
    commit: 403640bc88ad42cc55105bff773408d5f845e49c
    version: 2.28.0-rc7
  echo:
    commit: 488477dd85edfc6206337bb31f76892e641d1803
    version: 2.28.0-rc7
  fiat:
    commit: 9aca7990e68cc8022a55af31db7df1d04e02de4c
    version: 2.28.0-rc7
  front50:
    commit: f818ac4ce606e4b4f74f3cada4f4bc173a949b50
    version: 2.28.0-rc7
  gate:
    commit: 472e2dd8a37e85403b1c934d194d0c4862d97a96
    version: 2.28.0-rc7
  igor:
    commit: 5ea6da54f840ecaffa72d62386d9efd7bb54e0fe
    version: 2.28.0-rc7
  kayenta:
    commit: ebc7a92d06ed18b93233a6c887fe9acfd85ccc8c
    version: 2.28.0-rc7
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 877733807a0661adef388e9ad45f79506428e2fe
    version: 2.28.0-rc7
  rosco:
    commit: 8878e069687bfd229bd00907ede66dfe1b73d2e0
    version: 2.28.0-rc7
  terraformer:
    commit: c3c07a7c4f09752409183f906fb9fa5458e7d602
    version: 2.28.0-rc7
timestamp: "2022-06-14 17:24:09"
version: 2.28.0-rc7
</code>
</pre>
</details>

### Armory


#### Armory Front50 - 2.27.0...2.28.0-rc7


#### Armory Deck - 2.27.0...2.28.0-rc7


#### Armory Fiat - 2.27.0...2.28.0-rc7


#### Armory Gate - 2.27.0...2.28.0-rc7


#### Armory Igor - 2.27.0...2.28.0-rc7


#### Armory Clouddriver - 2.27.0...2.28.0-rc7


#### Armory Orca - 2.27.0...2.28.0-rc7


#### Armory Kayenta - 2.27.0...2.28.0-rc7


#### Armory Rosco - 2.27.0...2.28.0-rc7


#### Dinghy™ - 2.27.0...2.28.0-rc7


#### Armory Echo - 2.27.0...2.28.0-rc7


#### Terraformer™ - 2.27.0...2.28.0-rc7


