---
title: v2.30.5 Armory Release (OSS Spinnaker™ v1.30.4)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
date: 2023-11-10
description: >
  Release notes for Armory Continuous Deployment v2.30.5
---

## 2023/11/10 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a previous working version and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory 2.30.5, use Armory Operator 1.70 or later.

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
[Spinnaker v1.30.4](https://www.spinnaker.io/changelogs/1.30.4-changelog/) changelog for details.

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
    commit: 767aa739e9c38d2ec7822e9e9a1838b69a56d4c0
    version: 2.30.5
  deck:
    commit: b14f5660fbe9cde883dfaf25442a1e8cfe0c27b0
    version: 2.30.5
  dinghy:
    commit: a3b59d9e4b810cc968d0f5e8e8370e1670574768
    version: 2.30.5
  echo:
    commit: ea2081903be070da4b217a4c54d070f1503e6d00
    version: 2.30.5
  fiat:
    commit: 5d44e1f53d2f33b17f8decfb057a18cfe4b6fa08
    version: 2.30.5
  front50:
    commit: 5d9bb31f65f96087be30ce96cea1b6d481a6bef4
    version: 2.30.5
  gate:
    commit: 5758316afba1260d2012730c471fd461819e7f39
    version: 2.30.5
  igor:
    commit: 3123451525458f96548859b9bf2b15c89810f577
    version: 2.30.5
  kayenta:
    commit: 1d2f5193ec681b5122fe7c34da6bbd569da8e0b8
    version: 2.30.5
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: fdac510ea4f54b33abafbc840d7380100c6ab689
    version: 2.30.5
  rosco:
    commit: 7907c80fd9ca1d956d5927a3e190617671b7e012
    version: 2.30.5
  terraformer:
    commit: 249e7be18074af100212ddd554d9fb35afd65873
    version: 2.30.5
timestamp: "2023-11-08 19:09:49"
version: 2.30.5
</code>
</pre>
</details>

### Armory


#### Armory Clouddriver - 2.30.4...2.30.5


#### Armory Orca - 2.30.4...2.30.5

  - chore(cd): update base orca version to 2023.11.06.18.16.22.release-1.30.x (#762)
  - chore(cd): update base orca version to 2023.11.07.00.08.28.release-1.30.x (#764)
  - re-trigger build (#766)

#### Armory Igor - 2.30.4...2.30.5


#### Armory Rosco - 2.30.4...2.30.5


#### Armory Gate - 2.30.4...2.30.5


#### Armory Front50 - 2.30.4...2.30.5


#### Armory Fiat - 2.30.4...2.30.5


#### Armory Kayenta - 2.30.4...2.30.5


#### Terraformer™ - 2.30.4...2.30.5


#### Armory Echo - 2.30.4...2.30.5

  - fix: Upgrade grpc-netty-shaded to address the service initialization failure issue. (#647)

#### Dinghy™ - 2.30.4...2.30.5


#### Armory Deck - 2.30.4...2.30.5

  - chore(cd): update base deck version to 2023.0.0-20231024161913.release-1.30.x (#1364)


### Spinnaker


#### Spinnaker Clouddriver - 1.30.4


#### Spinnaker Orca - 1.30.4

  - fix(artifacts): Parent and child pipeline artifact resolution (backport #4575) (#4581)
  - fix(artifacts): Automated triggers with artifact constraints are broken if you have 2 or more of the same type (backport #4579) (#4586)

#### Spinnaker Igor - 1.30.4


#### Spinnaker Rosco - 1.30.4


#### Spinnaker Gate - 1.30.4


#### Spinnaker Front50 - 1.30.4


#### Spinnaker Fiat - 1.30.4


#### Spinnaker Kayenta - 1.30.4


#### Spinnaker Echo - 1.30.4


#### Spinnaker Deck - 1.30.4

  - fix: Updating Lambda functions available Runtimes (#10055) (#10056)

