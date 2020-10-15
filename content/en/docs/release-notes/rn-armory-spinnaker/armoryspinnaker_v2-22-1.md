---
title: v2.22.1 Armory Release (OSS Spinnaker v1.22.2)
toc_hide: true
---

## 2020/10/30 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
## Required Halyard version

Armory Spinnaker 2.22.1 requires Armory Halyard <PUT IN A VERSION NUMBER> or later.

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
[Spinnaker v1.22.2](https://www.spinnaker.io/community/releases/versions/1-22-2-changelog)

## Detailed Updates

### Bill of Materials
Here's the bom for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.22.1
timestamp: "2020-10-15 15:36:55"
services:
    clouddriver:
        commit: 57502e9a
        version: 2.22.10
    deck:
        commit: f3b0fa58
        version: 2.22.5
    dinghy:
        commit: ad5418ab
        version: 2.22.0
    echo:
        commit: 7cb7dbb4
        version: 2.22.1
    fiat:
        commit: b96e9905
        version: 2.22.2
    front50:
        commit: 7083c875
        version: 2.22.1
    gate:
        commit: fde8b76a
        version: 2.22.2
    igor:
        commit: ef536157
        version: 2.22.2
    kayenta:
        commit: b1aa5c56
        version: 2.22.2
    monitoring-daemon:
        version: 2.22.0
    monitoring-third-party:
        version: 2.22.0
    orca:
        commit: 89cad735
        version: 2.22.1
    rosco:
        commit: dd80635a
        version: 2.22.3
    terraformer:
        commit: e2d395ce
        version: 2.22.2
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Deck - 2.22.5...2.22.5


#### Armory Kayenta - 2.22.2...2.22.2


#### Terraformer™ - 2.22.2...2.22.2


#### Armory Clouddriver - 2.22.3...2.22.10

  - fix(docker): downgrade aws-iam-authenticator (#205) (#207)
  - chore(build): resolve CVEs and reduce docker layers (#213)
  - chore(build): resolve CVEs and reduce docker layers (#213) (#218)

#### Armory Igor - 2.22.2...2.22.2


#### Armory Echo - 2.22.1...2.22.1


#### Armory Fiat - 2.22.2...2.22.2


#### Armory Front50 - 2.22.1...2.22.1


#### Armory Rosco - 2.22.2...2.22.3

  - feat(kustomize): update version of kustomize used (#108) (#110)

#### Armory Gate - 2.22.2...2.22.2


#### Armory Orca - 2.22.1...2.22.1


#### Dinghy™ - 2.22.0...2.22.0


