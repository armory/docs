---
title: v2.23.1 Armory Release (OSS Spinnaker™ v1.23.3)
toc_hide: true
version: 02.23.01
description: >
  Release notes for the Armory Platform
---

## 2020/12/5 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
> 
## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.23.1, use one of the following tools:

- Armory-extended Halyard 1.10.0 or later
- Armory Operator 1.2.1 or later

## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, contact your Armory account representative.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->


{{< include "breaking-changes/bc-k8s-job-suffix.md" >}}

{{< include "breaking-changes/bc-orca-forcecacherefresh.md" >}}

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->
#### Clouddriver resources

There is a known issue with Clouddriver that affects the performance of the Armory Platform, causing it to consume more resources. This can lead to a situation where pods do not have enough resources to start.

#### Pipelines as Code Slack notifications

There is a known issue where Slack notifications do not work for Pipelines as Code (Dinghy).

#### Spinnaker UI

An old version of Deck, the Spinnaker UI, exists in this release.


{{< include "known-issues/ki-lambda-ui-caching.md" >}}

## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->

### Clouddriver



### Automatic Canary Analysis

#### Cloudwatch Integration

Armory now supports Cloudwatch as a metrics provider for Automatic Canary Analysis. For more information, [Using Canary Analysis with AWS CloudWatch]({{< ref "kayenta-canary-cloudwatch" >}}).

### Deployment targets

#### Pivotal Cloud Foundry

This release includes the following improvements to the PCF provider:

* Fixes a regression that caused deployments to fail if routes were specified in a manifest.

###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.23.3](https://www.spinnaker.io/community/releases/versions/1-23-3-changelog) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.23.1
timestamp: "2020-12-02 17:23:41"
services:
    clouddriver:
        commit: dc4839bf
        version: 2.23.25
    deck:
        commit: 7fa4d3d1
        version: 2.23.10
    dinghy:
        commit: b05c28f9
        version: 2.23.5
    echo:
        commit: 0be27822
        version: 2.23.4
    fiat:
        commit: 6ef30d9d
        version: 2.23.3
    front50:
        commit: 9cd8f0e4
        version: 2.23.4
    gate:
        commit: d25c8e6e
        version: 2.23.3
    igor:
        commit: 215616fa
        version: 2.23.2
    kayenta:
        commit: 55ab67c5
        version: 2.23.4
    monitoring-daemon:
        version: 2.23.0
    monitoring-third-party:
        version: 2.23.0
    orca:
        commit: "19346318"
        version: 2.23.10
    rosco:
        commit: d7012b41
        version: 2.23.5
    terraformer:
        commit: da937fcf
        version: 2.23.2
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Deck - 2.23.8...2.23.10

  - feat(kayenta): add cloudwatch UI (#686) (#687)

#### Armory Front50 - 2.23.3...2.23.4


#### Armory Echo - 2.23.3...2.23.4


#### Armory Rosco - 2.23.4...2.23.5


#### Terraformer™ - 2.23.1...2.23.2


#### Armory Gate - 2.23.2...2.23.3


#### Armory Igor - 2.23.1...2.23.2


#### Armory Kayenta - 2.23.2...2.23.4

  - feat(cloudwatch): adding cloudwatch config and integration test (#142) (#147)

#### Armory Fiat - 2.23.2...2.23.3


#### Dinghy™ - 2.23.4...2.23.5


#### Armory Orca - 2.23.9...2.23.10


#### Armory Clouddriver - 2.23.24...2.23.25

