---
title: v2.21.3 Armory Release (OSS Spinnaker v1.21.4)
toc_hide: true
---

## 2020/08/50 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
## Required Halyard version

Armory Spinnaker 2.21.3 requires Armory Halyard <PUT IN A VERSION NUMBER> or later.

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
[Spinnaker v1.21.4](https://www.spinnaker.io/community/releases/versions/1-21-4-changelog)

## Detailed Updates

### Bill of Materials
Here's the bom for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.21.3
timestamp: "2020-08-26 16:59:10"
services:
    clouddriver:
        commit: 8af10d5b
        version: 2.21.5
    deck:
        commit: 53d7adc3
        version: 2.21.6
    dinghy:
        commit: 8fa8c0ae
        version: 2.21.3
    echo:
        commit: 17a274cf
        version: 2.21.2
    fiat:
        commit: a7b64e03
        version: 2.21.2
    front50:
        commit: 9b3d3bac
        version: 2.21.0
    gate:
        commit: "844223e9"
        version: 2.21.6
    igor:
        commit: b3a7e1fc
        version: 2.21.2
    kayenta:
        commit: 7caca133
        version: 2.21.2
    monitoring-daemon:
        version: 2.21.0
    monitoring-third-party:
        version: 2.21.0
    orca:
        commit: 7da34395
        version: 2.21.4
    rosco:
        commit: f9f89e5a
        version: 2.21.2
    terraformer:
        commit: 516ca41a
        version: 2.21.5
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Terraformer™ - 2.21.5...2.21.5


#### Dinghy™ - 2.21.3...2.21.3


#### Armory Echo - 2.21.2...2.21.2


#### Armory Clouddriver - 2.21.4...2.21.5

  - fix(dynamicAccounts): Server unable to start with vault (#188) (#189)

#### Armory Orca - 2.21.3...2.21.4

  - fix(terraformer): remove deprecated method call (#147) (#148)

#### Armory Fiat - 2.21.2...2.21.2


#### Armory Front50 - 2.21.0...2.21.0


#### Armory Kayenta - 2.21.2...2.21.2


#### Armory Rosco - 2.21.2...2.21.2


#### Armory Deck - 2.21.6...2.21.6


#### Armory Gate - 2.21.6...2.21.6


#### Armory Igor - 2.21.2...2.21.2


