---
title: v2.20.1 Armory Release (OSS Spinnaker v1.20.6)
toc_hide: true
---

## 2020/06/26 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
## Required Halyard version

Armory Spinnaker 2.20.1 requires Armory Halyard 1.9.4 or later.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. -->

## Known Issues
<!-- Copy/paste known issues from the previous version if they're not fixed -->
There are currently no known issues with this release.

## Highlighted Updates

### Armory

Summary of changes in the latest release.

###  Spinnaker Community Contributions

<! -- Copy/paste highlights from the corresponding OSS version. -->

There have also been numerous enhancements, fixes and features across all of Spinnaker's other services. See their changes here:  
[Spinnaker v1.20.6](https://www.spinnaker.io/community/releases/versions/1-20-6-changelog)

## Detailed Updates

### Bill of Materials
Here's the bom for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.20.1
timestamp: "2020-06-26 08:33:42"
services:
    clouddriver:
        commit: c6a62bef
        version: 2.20.3
    deck:
        commit: 583083ff
        version: 2.20.4
    dinghy:
        commit: f710446c
        version: 2.20.3
    echo:
        commit: e118a5ac
        version: 2.20.4
    fiat:
        commit: 8d4db29b
        version: 2.20.3
    front50:
        commit: 4ab036ea
        version: 2.20.5
    gate:
        commit: 69ba2895
        version: 2.20.2
    igor:
        commit: 44ae1b05
        version: 2.20.7
    kayenta:
        commit: 9d6743d9
        version: 2.20.3
    monitoring-daemon:
        version: 2.20.0
    monitoring-third-party:
        version: 2.20.0
    orca:
        commit: 3d2cf0a1
        version: 2.20.1
    rosco:
        commit: 9e974c48
        version: 2.20.3
    terraformer:
        commit: 5b00d7a6
        version: 2.20.3
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Kayenta - 2.20.2...2.20.3

  - fix(release): set nebula release version (#92) (#93)

#### Armory Rosco - 2.20.2...2.20.3

  - fix(release): set nebula release version (#71) (#72)

#### Dinghy™ - 2.20.1...2.20.3

  - Fix for app update on every change (#231) (#232)

#### Armory Fiat - 2.20.2...2.20.3

  - fix(release): set nebula release version (#73) (#74)

#### Armory Igor - 2.20.3...2.20.7

  - fix(plugins): manual port of spinnaker/igor#715 for 2.20.x (#82)
  - chore(deps): change armory-commons import to -all (#86) (#88)

#### Terraformer™ - 2.20.3...2.20.3


#### Armory Gate - 2.20.2...2.20.2


#### Armory Echo - 2.20.1...2.20.4

  - chore(build): update nebula plugin to fix release task (#173) (#175)
  - chore(deps): change armory-commons import to -all (#176) (#178)

#### Armory Front50 - 2.20.3...2.20.5


#### Armory Orca - 2.20.1...2.20.1


#### Armory Clouddriver - 2.20.1...2.20.3


#### Armory Deck - 2.20.3...2.20.4

  - chore(deps): update to latest 1.20.x release (#618)

