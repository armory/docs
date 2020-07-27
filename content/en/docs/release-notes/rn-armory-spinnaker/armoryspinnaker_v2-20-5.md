---
title: v2.20.5-rc.2 Armory Release (OSS Spinnaker v1.20.6)
toc_hide: true
---

## 2020/07/30 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
## Required Halyard version

Armory Spinnaker 2.20.5-rc.2 requires Armory Halyard <PUT IN A VERSION NUMBER> or later.

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
<code>version: 2.20.5-rc.2
timestamp: "2020-07-27 14:29:40"
services:
    clouddriver:
        commit: 45d2c64e
        version: 2.20.8
    deck:
        commit: 583083ff
        version: 2.20.4
    dinghy:
        commit: 0482189c
        version: 2.20.6
    echo:
        commit: ae9df3d9
        version: 2.20.12
    fiat:
        commit: 3b54af70
        version: 2.20.6
    front50:
        commit: 23d3f79c
        version: 2.20.8
    gate:
        commit: 8437e3b7
        version: 2.20.4
    igor:
        commit: f9c155c0
        version: 2.20.11
    kayenta:
        commit: 84b54034
        version: 2.20.6
    monitoring-daemon:
        version: 2.20.0
    monitoring-third-party:
        version: 2.20.0
    orca:
        commit: 3703a361
        version: 2.20.5
    rosco:
        commit: 052bd22d
        version: 2.20.6
    terraformer:
        commit: e4e78996
        version: 2.20.8
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Rosco - 2.20.6...2.20.6


#### Armory Kayenta - 2.20.6...2.20.6


#### Armory Orca - 2.20.5...2.20.5


#### Armory Echo - 2.20.12...2.20.12


#### Armory Igor - 2.20.11...2.20.11


#### Armory Front50 - 2.20.8...2.20.8


#### Armory Gate - 2.20.4...2.20.4


#### Armory Deck - 2.20.4...2.20.4


#### Armory Clouddriver - 2.20.8...2.20.8


#### Dinghy™ - 2.20.4...2.20.6

  - fix(bitbucket): fix Bitbucket integration (#257)
  - fix(bitbucket): fix Bitbucket integration (#259)

#### Armory Fiat - 2.20.6...2.20.6


#### Terraformer™ - 2.20.5...2.20.8

  - Revert "fix(artifacts): retrieve artifacts by name || reference (#199) (#200)" (#213)
  - Revert "Revert "fix(artifacts): retrieve artifacts by name || reference (#199) (#200)" (#213)" (#218)
  - fix(artifacts): use one method for consistent download/reading (#217) (#220)

