---
title: v2.38.2 Armory Continuous Deployment Release (Spinnaker™ v1.38.0)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
date: 2026-06-23
description: >
  Release notes for Armory Continuous Deployment v2.38.2.
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

To install, upgrade, or configure Armory CD 2.38.2, use Armory Operator 1.8.6 or later.

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
[Spinnaker v1.38.0](https://www.spinnaker.io/changelogs/1.38.0-changelog/) changelog for details.

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
    commit: ec8a581ff19f5e5d65cdabc357fc0558b2b6efde
    version: 2.38.2
  deck:
    commit: ec8a581ff19f5e5d65cdabc357fc0558b2b6efde
    version: 2.38.2
  dinghy:
    commit: babaa4704f1df8a6f6b42e533716396c8a0f529b
    version: 2.38.2
  echo:
    commit: ec8a581ff19f5e5d65cdabc357fc0558b2b6efde
    version: 2.38.2
  fiat:
    commit: ec8a581ff19f5e5d65cdabc357fc0558b2b6efde
    version: 2.38.2
  front50:
    commit: ec8a581ff19f5e5d65cdabc357fc0558b2b6efde
    version: 2.38.2
  gate:
    commit: ec8a581ff19f5e5d65cdabc357fc0558b2b6efde
    version: 2.38.2
  igor:
    commit: ec8a581ff19f5e5d65cdabc357fc0558b2b6efde
    version: 2.38.2
  kayenta:
    commit: ec8a581ff19f5e5d65cdabc357fc0558b2b6efde
    version: 2.38.2
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: ec8a581ff19f5e5d65cdabc357fc0558b2b6efde
    version: 2.38.2
  rosco:
    commit: ec8a581ff19f5e5d65cdabc357fc0558b2b6efde
    version: 2.38.2
  terraformer:
    commit: babaa4704f1df8a6f6b42e533716396c8a0f529b
    version: 2.38.2
timestamp: "2026-06-19 10:58:13"
version: 2.38.2
</code>
</pre>
</details>

### Armory


#### Armory Gate - 2.38.1...2.38.2


#### Armory Igor - 2.38.1...2.38.2


#### Armory Dinghy - 2.38.1...2.38.2


#### Armory Kayenta - 2.38.1...2.38.2


#### Armory Orca - 2.38.1...2.38.2


#### Armory Rosco - 2.38.1...2.38.2


#### Armory Clouddriver - 2.38.1...2.38.2


#### Armory Deck - 2.38.1...2.38.2


#### Armory Fiat - 2.38.1...2.38.2


#### Armory Terraformer - 2.38.1...2.38.2


#### Armory Echo - 2.38.1...2.38.2


#### Armory Front50 - 2.38.1...2.38.2



### Spinnaker


#### Spinnaker Gate - 1.38.0


#### Spinnaker Igor - 1.38.0


#### Spinnaker Dinghy - 1.38.0


#### Spinnaker Kayenta - 1.38.0


#### Spinnaker Orca - 1.38.0


#### Spinnaker Rosco - 1.38.0


#### Spinnaker Clouddriver - 1.38.0


#### Spinnaker Deck - 1.38.0


#### Spinnaker Fiat - 1.38.0


#### Spinnaker Terraformer - 1.38.0


#### Spinnaker Echo - 1.38.0


#### Spinnaker Front50 - 1.38.0


