---
title: v2.36.10 Armory Continuous Deployment Release (Spinnaker™ v1.36.0)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
date: 2026-06-23
description: >
  Release notes for Armory Continuous Deployment v2.36.10.
---

<!--
MAKE SURE TO ADD 'LTS' OR 'FEATURE' TO THE TITLE TO INDICATE RELEASE CATEGORY.
FOR EXAMPLE, "Armory Continuous Deployment Release LTS" or "Armory Continuous Deployment Release Feature" so users know release category and support time period
-->

## 2026/06/23 release notes

>Note: If you experience production issues after upgrading Armory Continuous Deployment, roll back to a previous working version and report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version
{{% alert color="warning" title="Important" %}}
[Armory Operator]({{< ref "armory-operator" >}}) has been deprecated and will is considered EOL. Please migrate to the [Kustomize]({{< ref "armory-operator-to-kustomize-migration" >}}) method of deployment.
{{% /alert %}}

To install, upgrade, or configure Armory CD 2.36.10, use Armory Operator 1.8.6 or later.

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




###  Spinnaker community contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.36.0](https://www.spinnaker.io/changelogs/1.36.0-changelog/) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

<details><summary>Expand to see the BOM</summary>
<pre class="highlight">
<code>artifactSources:
  dockerRegistry: docker.io/armory
dependencies:
  redis:
    commit: null
    version: 2:2.8.4-2
services:
  clouddriver:
    commit: a2d32de1265bca8a24307feac58f706b23fec243
    version: 2.36.10
  deck:
    commit: 69dbbdfb3765511c8ac623d4f5ad54f8c1a47566
    version: 2.36.10
  dinghy:
    commit: d36fdf5b496b18212275686d4c9069d72c9dbeb1
    version: 2.36.10
  echo:
    commit: eabb406c04f3bfba78ffab3fc2dedc4acfceb740
    version: 2.36.10
  fiat:
    commit: 8a44db140c557d219721a0be23875eada6d24306
    version: 2.36.10
  front50:
    commit: 0f05af74a344e02c25eba0b74980ba7d9cd283b3
    version: 2.36.10
  gate:
    commit: f17a329e0b491a7da919a429187fccd52da98543
    version: 2.36.10
  igor:
    commit: cb13fe4f94b5deb21d257aa96a85f5b567a449dc
    version: 2.36.10
  kayenta:
    commit: c975c3fb9d0f02aa64fee095bc5d100c80ab19b6
    version: 2.36.10
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 5f45aa313539a10cc51b97a68374531ce1e77165
    version: 2.36.10
  rosco:
    commit: e45eea397aaa24088cafe71638fe82accb6b89f0
    version: 2.36.10
  terraformer:
    commit: 8453d42107fda5f0c315c8459f523e9182805832
    version: 2.36.10
timestamp: "2026-06-23 10:37:12"
version: 2.36.10
</code>
</pre>
</details>

### Armory


#### Armory Front50 - 2.36.9...2.36.10


#### Armory Deck - 2.36.9...2.36.10


#### Armory Rosco - 2.36.9...2.36.10


#### Armory Echo - 2.36.9...2.36.10


#### Armory Clouddriver - 2.36.9...2.36.10


#### Armory Kayenta - 2.36.9...2.36.10


#### Armory Terraformer - 2.36.9...2.36.10


#### Armory Dinghy - 2.36.9...2.36.10


#### Armory Orca - 2.36.9...2.36.10


#### Armory Gate - 2.36.9...2.36.10


#### Armory Fiat - 2.36.9...2.36.10


#### Armory Igor - 2.36.9...2.36.10



### Spinnaker


#### Spinnaker Front50 - 1.36.0


#### Spinnaker Deck - 1.36.0


#### Spinnaker Rosco - 1.36.0


#### Spinnaker Echo - 1.36.0


#### Spinnaker Clouddriver - 1.36.0


#### Spinnaker Kayenta - 1.36.0


#### Spinnaker Terraformer - 1.36.0


#### Spinnaker Dinghy - 1.36.0


#### Spinnaker Orca - 1.36.0


#### Spinnaker Gate - 1.36.0


#### Spinnaker Fiat - 1.36.0


#### Spinnaker Igor - 1.36.0


