---
title: v2.41.4 Armory Continuous Deployment Release (Spinnaker™ v1.41.0)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
date: 2026-11-11
description: >
  Release notes for Armory Continuous Deployment v2.41.4.
---

<!--
MAKE SURE TO ADD 'LTS' OR 'FEATURE' TO THE TITLE TO INDICATE RELEASE CATEGORY.
FOR EXAMPLE, "Armory Continuous Deployment Release LTS" or "Armory Continuous Deployment Release Feature" so users know release category and support time period
-->

## 2026/11/11 release notes

>Note: If you experience production issues after upgrading Armory Continuous Deployment, roll back to a previous working version and report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version
{{% alert color="warning" title="Important" %}}
[Armory Operator]({{< ref "armory-operator" >}}) has been deprecated and will is considered EOL. Please migrate to the [Kustomize]({{< ref "armory-operator-to-kustomize-migration" >}}) method of deployment.
{{% /alert %}}

To install, upgrade, or configure Armory CD 2.41.4, use Armory Operator 1.8.6 or later.

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
[Spinnaker v1.41.0](https://www.spinnaker.io/changelogs/1.41.0-changelog/) changelog for details.

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
    commit: a61592695b465283806504ea4a5e3b70cf804d99
    version: 2.41.4
  deck:
    commit: a61592695b465283806504ea4a5e3b70cf804d99
    version: 2.41.4
  dinghy:
    commit: f22d5925ee1d282a725a5926317f40ff76b1d742
    version: 2.41.4
  echo:
    commit: a61592695b465283806504ea4a5e3b70cf804d99
    version: 2.41.4
  fiat:
    commit: a61592695b465283806504ea4a5e3b70cf804d99
    version: 2.41.4
  front50:
    commit: a61592695b465283806504ea4a5e3b70cf804d99
    version: 2.41.4
  gate:
    commit: a61592695b465283806504ea4a5e3b70cf804d99
    version: 2.41.4
  igor:
    commit: a61592695b465283806504ea4a5e3b70cf804d99
    version: 2.41.4
  kayenta:
    commit: a61592695b465283806504ea4a5e3b70cf804d99
    version: 2.41.4
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: a61592695b465283806504ea4a5e3b70cf804d99
    version: 2.41.4
  rosco:
    commit: a61592695b465283806504ea4a5e3b70cf804d99
    version: 2.41.4
  terraformer:
    commit: a61592695b465283806504ea4a5e3b70cf804d99
    version: 2.41.4
timestamp: "2026-11-10 11:41:18"
version: 2.41.4
</code>
</pre>
</details>

### Armory


#### Armory Igor - 2.41.3...2.41.4


#### Armory Gate - 2.41.3...2.41.4


#### Armory Orca - 2.41.3...2.41.4


#### Armory Kayenta - 2.41.3...2.41.4


#### Armory Terraformer - 2.41.3...2.41.4


#### Armory Dinghy - 2.41.3...2.41.4


#### Armory Rosco - 2.41.3...2.41.4


#### Armory Deck - 2.41.3...2.41.4


#### Armory Clouddriver - 2.41.3...2.41.4


#### Armory Echo - 2.41.3...2.41.4


#### Armory Front50 - 2.41.3...2.41.4


#### Armory Fiat - 2.41.3...2.41.4



### Spinnaker


#### Spinnaker Igor - 1.41.0


#### Spinnaker Gate - 1.41.0


#### Spinnaker Orca - 1.41.0


#### Spinnaker Kayenta - 1.41.0


#### Spinnaker Terraformer - 1.41.0


#### Spinnaker Dinghy - 1.41.0


#### Spinnaker Rosco - 1.41.0


#### Spinnaker Deck - 1.41.0


#### Spinnaker Clouddriver - 1.41.0


#### Spinnaker Echo - 1.41.0


#### Spinnaker Front50 - 1.41.0


#### Spinnaker Fiat - 1.41.0


