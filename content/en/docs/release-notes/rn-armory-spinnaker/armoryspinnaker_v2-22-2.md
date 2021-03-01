---
title: v2.22.2 Armory Release (OSS Spinnaker™ v1.22.2)
toc_hide: true
date: 2020-10-21
version: 02.22.02
---

## 2020/10/21 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Halyard or Operator version

Armory Spinnaker 2.22.1 requires one of the following:

* Armory Halyard 1.9.4 or later.
* Armory Spinnaker Operator 1.0.3 or later.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. -->

{{< include "breaking-changes/bc-k8s-namespace.md" >}}


{{< include "breaking-changes/bc-k8s-job-suffix.md" >}}

{{< include "breaking-changes/bc-spinnaker-metrics.md" >}}

## Known issues

{{< include "known-issues/ki-plugins-sdk.md" >}}

{{< include "known-issues/ki-gce-predictive-autoscaling.md" >}}

{{< include "known-issues/ki-livemanifests.md" >}}

{{< include "known-issues/ki-dinghy-modules.md" >}}

## Highlighted updates

### Deployment targets

#### Pivotal Cloud Foundry

This release includes the following improvements to the PCF provider:

* Fixes a regression that caused deployments to fail
* Improves performance in the Spinnaker UI when viewing PCF clusters

### Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, contact your Armory account representative.

###  Spinnaker community contributions

<!-- Copy/paste highlights from the corresponding OSS version. -->

There have also been numerous enhancements, fixes and features across all of Spinnaker's other services. See their changes here:  
[Spinnaker v1.22.2](https://www.spinnaker.io/community/releases/versions/1-22-2-changelog)

## Detailed Updates

### Bill of Materials
Here's the bom for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.22.2
timestamp: "2020-10-21 11:45:26"
services:
    clouddriver:
        commit: dcfd57fc
        version: 2.22.11
    deck:
        commit: 3c7cd857
        version: 2.22.7
    dinghy:
        commit: ad5418ab
        version: 2.22.0
    echo:
        commit: d200e4b8
        version: 2.22.2
    fiat:
        commit: 6419cd67
        version: 2.22.3
    front50:
        commit: 703ae67d
        version: 2.22.2
    gate:
        commit: 971be7fc
        version: 2.22.3
    igor:
        commit: ebceb417
        version: 2.22.3
    kayenta:
        commit: 4ffa74d8
        version: 2.22.3
    monitoring-daemon:
        version: 2.22.0
    monitoring-third-party:
        version: 2.22.0
    orca:
        commit: d0d067ac
        version: 2.22.2
    rosco:
        commit: 72ee6ba5
        version: 2.22.5
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


#### Armory Igor - 2.22.2...2.22.3


#### Armory Kayenta - 2.22.2...2.22.3


#### Armory Rosco - 2.22.3...2.22.5

  - fix(kustomize): Update kustomize with latest bug fixes (#113) (#115)

#### Terraformer™ - 2.22.2...2.22.2


#### Armory Gate - 2.22.2...2.22.3


#### Armory Clouddriver - 2.22.10...2.22.11


#### Armory Front50 - 2.22.1...2.22.2


#### Dinghy™ - 2.22.0...2.22.0


#### Armory Orca - 2.22.1...2.22.2


#### Armory Fiat - 2.22.2...2.22.3


#### Armory Deck - 2.22.5...2.22.7

  - fix(typo): an egregious typo in the Terraform help text (#669) (#672)

#### Armory Echo - 2.22.1...2.22.2
