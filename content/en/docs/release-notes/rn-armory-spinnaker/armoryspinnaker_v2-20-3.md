---
title: v2.20.3 Armory Release (OSS Spinnaker v1.20.6)
toc_hide: true
---

## 2020/07/70 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
## Required Halyard version

Armory Spinnaker 2.20.3 requires Armory Halyard <PUT IN A VERSION NUMBER> or later.

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
<code>version: 2.20.3
timestamp: "2020-07-07 07:40:48"
services:
    clouddriver:
        commit: ac73b373
        version: 2.20.5
    deck:
        commit: 583083ff
        version: 2.20.4
    dinghy:
        commit: f710446c
        version: 2.20.3
    echo:
        commit: 5442782d
        version: 2.20.8
    fiat:
        commit: f4c3cc15
        version: 2.20.4
    front50:
        commit: 66dda373
        version: 2.20.6
    gate:
        commit: 8437e3b7
        version: 2.20.4
    igor:
        commit: 69ca5136
        version: 2.20.9
    kayenta:
        commit: 9d6743d9
        version: 2.20.3
    monitoring-daemon:
        version: 2.20.0
    monitoring-third-party:
        version: 2.20.0
    orca:
        commit: 1c66db43
        version: 2.20.3
    rosco:
        commit: 5e3f7e91
        version: 2.20.4
    terraformer:
        commit: f1867f44
        version: 2.20.4
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Gate - 2.20.3...2.20.4


#### Armory Rosco - 2.20.3...2.20.4


#### Terraformer™ - 2.20.3...2.20.4

  - fix(git/repo): support symlinks when unpacking tarball archives (#192) (#194)

#### Armory Clouddriver - 2.20.5...2.20.5


#### Armory Kayenta - 2.20.3...2.20.3


#### Armory Fiat - 2.20.3...2.20.4


#### Armory Front50 - 2.20.5...2.20.6


#### Dinghy™ - 2.20.3...2.20.3


#### Armory Igor - 2.20.8...2.20.9


#### Armory Orca - 2.20.2...2.20.3


#### Armory Deck - 2.20.4...2.20.4


#### Armory Echo - 2.20.7...2.20.8

  - fix(github): fix conflicting bean with upstream (#194) (#195)

