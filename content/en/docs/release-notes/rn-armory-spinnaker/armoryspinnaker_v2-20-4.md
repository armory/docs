---
title: v2.20.4-rc.1 Armory Release (OSS Spinnaker v1.20.6)
toc_hide: true
---

## 2020/07/110 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
## Required Halyard version

Armory Spinnaker 2.20.4-rc.1 requires Armory Halyard <PUT IN A VERSION NUMBER> or later.

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
<code>version: 2.20.4-rc.1
timestamp: "2020-07-20 11:09:18"
services:
    clouddriver:
        commit: 10d82f59
        version: 2.20.7
    deck:
        commit: 583083ff
        version: 2.20.4
    dinghy:
        commit: 190087af
        version: 2.20.4
    echo:
        commit: 4dcfa307
        version: 2.20.11
    fiat:
        commit: 6dc835fb
        version: 2.20.5
    front50:
        commit: 4ac738bb
        version: 2.20.7
    gate:
        commit: 8437e3b7
        version: 2.20.4
    igor:
        commit: 48bb9519
        version: 2.20.10
    kayenta:
        commit: 86699b64
        version: 2.20.5
    monitoring-daemon:
        version: 2.20.0
    monitoring-third-party:
        version: 2.20.0
    orca:
        commit: 29462caf
        version: 2.20.4
    rosco:
        commit: b21dd8d3
        version: 2.20.5
    terraformer:
        commit: b1e28624
        version: 2.20.5
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Front50 - 2.20.6...2.20.7


#### Armory Orca - 2.20.3...2.20.4


#### Armory Deck - 2.20.4...2.20.4


#### Dinghy™ - 2.20.3...2.20.4

  - fix(notifications): Fixed slack notification (#242) (#243)

#### Armory Echo - 2.20.9...2.20.11

  - feat(plugin-metrics): adds support for proxying plugin events to the debug endpoint (#198) (#203)

#### Armory Clouddriver - 2.20.6...2.20.7


#### Armory Kayenta - 2.20.4...2.20.5


#### Armory Fiat - 2.20.4...2.20.5


#### Armory Igor - 2.20.9...2.20.10


#### Armory Gate - 2.20.4...2.20.4


#### Terraformer™ - 2.20.4...2.20.5

  - fix(artifacts): retrieve artifacts by name || reference (#199) (#200)

#### Armory Rosco - 2.20.4...2.20.5


