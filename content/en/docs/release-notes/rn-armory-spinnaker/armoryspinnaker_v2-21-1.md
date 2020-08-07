---
title: v2.21.1 Armory Release (OSS Spinnaker v1.21.0)
toc_hide: true
---

## 2020/08/50 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
## Required Halyard version

Armory Spinnaker 2.21.1 requires Armory Halyard <PUT IN A VERSION NUMBER> or later.

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
[Spinnaker v1.21.0](https://www.spinnaker.io/community/releases/versions/1-21-0-changelog)

## Detailed Updates

### Bill of Materials
Here's the bom for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.21.1
timestamp: "2020-08-07 00:26:36"
services:
    clouddriver:
        commit: f97b7cc2
        version: 2.21.1
    deck:
        commit: 8c42b95f
        version: 2.21.3
    dinghy:
        commit: 0a23b203
        version: 2.21.2
    echo:
        commit: 880b43b4
        version: 2.21.1
    fiat:
        commit: 4e293ee1
        version: 2.21.1
    front50:
        commit: 9b3d3bac
        version: 2.21.0
    gate:
        commit: 71d53af6
        version: 2.21.3
    igor:
        commit: b5662632
        version: 2.21.1
    kayenta:
        commit: 339d2b68
        version: 2.21.1
    monitoring-daemon:
        version: 2.21.0
    monitoring-third-party:
        version: 2.21.0
    orca:
        commit: "69235005"
        version: 2.21.2
    rosco:
        commit: 1c0b7e7c
        version: 2.21.1
    terraformer:
        commit: be026f2c
        version: 2.21.3
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Front50 - 2.21.0...2.21.0


#### Terraformer™ - 2.21.3...2.21.3


#### Armory Fiat - 2.21.1...2.21.1


#### Armory Igor - 2.21.1...2.21.1


#### Dinghy™ - 2.21.1...2.21.2

  - fix(status): change github when dinghyfiles are not changed (#261) (#262)

#### Armory Kayenta - 2.21.1...2.21.1


#### Armory Deck - 2.21.3...2.21.3


#### Armory Clouddriver - 2.21.1...2.21.1


#### Armory Echo - 2.21.1...2.21.1


#### Armory Rosco - 2.21.1...2.21.1


#### Armory Gate - 2.21.2...2.21.3

  - fix(cve): CVE fixes (#155) (#156)

#### Armory Orca - 2.21.0...2.21.2

  - fix(clouddriver): manual impl of oss fix for custom jobs (#139)
  - chore(build): push images to dockerhub (#135) (#140)

