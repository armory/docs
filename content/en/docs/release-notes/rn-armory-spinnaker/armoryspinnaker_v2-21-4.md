---
title: v2.21.4 Armory Release (OSS Spinnaker™ v1.21.4)
toc_hide: true
date: 2020-09-11
version: 02.21.04
---

## 2020/09/11 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Halyard and Operator version

Armory Spinnaker 2.21.2 requires one of the following:

* Armory Halyard 1.9.4 or later.
* Armory Spinnaker Operator 1.0.3 or later.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. -->

{{< include "breaking-changes/bc-k8s-namespace.md" >}}

{{< include "breaking-changes/bc-metrics-name.md" >}}

#### Scheduled removal of Kubernetes V1 provider

The Kubernetes V1 provider has been removed in Spinnaker 1.21 (Armory Spinnaker 2.21). Please see the [RFC](https://github.com/spinnaker/governance/blob/master/rfc/eol_kubernetes_v1.md) for more details.

## Known Issues
<!-- Copy/paste known issues from the previous version if they're not fixed -->

{{< include "known-issues/ki-livemanifests.md" >}}

#### Security update

We continue to make Spinnaker's security a top priority. Although several CVEs are resolved, the following still exist:

##### Multiple services

`CVE-2020-5410` was resolved in a previous version of Armory Spinnaker; however, this CVE introduced a regression for users of Spring Cloud and has been rolled back. Armory will continue to monitor releases for a fix.

##### Orca

The following CVEs have been recently identified and will be addressed in an upcoming release:

- CVE-2020-7692

##### Clouddriver

The following CVEs still exist in Clouddriver:

- CVE-2017-18342
- CVE-2020-1747
- CVE-2019-17638
- CVE-2020-13757
- CVE-2016-10745

All of them are embedded dependencies in the Google Cloud SDK. A version of the Google Cloud SDK addressing these CVEs has not been released. The risk to Clouddriver users is low. All four CVEs deal with untrusted input, which Clouddriver does not provide to the Google Cloud SDK. Additionally, users deploying to other cloud providers are not at risk for this vulnerability.

The following CVE also exists for Clouddriver:

- CVE-2020-7014 deals with an Elasticsearch exploit related to token generation. Clouddriver only makes use of entity tags and does not allow for token generation or authentication.

The following CVEs will be triaged as part of a future release:
- CVE-2020-7692

##### Terraformer

Armory has identified and is triaging the following CVEs in Terraformer, the service for the Terraform integration:

- CVE-2020-15778

## Highlighted Updates

### Terraform Integration

Fixed an issue where an `InvalidClientTokenId` error occurs when using Named Profiles for AWS credentials with assumeRole.

###  Spinnaker Community Contributions

<!-- Copy/paste highlights from the corresponding OSS version. -->

There have also been numerous enhancements, fixes and features across all of Spinnaker's other services. See their changes here:  
[Spinnaker v1.21.4](https://www.spinnaker.io/community/releases/versions/1-21-4-changelog)

## Detailed Updates

### Bill of Materials
Here's the bom for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.21.4
timestamp: "2020-09-11 15:39:15"
services:
    clouddriver:
        commit: 8af10d5b
        version: 2.21.5
    deck:
        commit: 5c1d7356
        version: 2.21.7
    dinghy:
        commit: 8fa8c0ae
        version: 2.21.3
    echo:
        commit: ebbfce21
        version: 2.21.3
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
        commit: c7552cb2
        version: 2.21.6
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Echo - 2.21.2...2.21.3

  - fix(plugins): Don't fail when debug service is not provided because diagnostics.enabled is false (#224) (#226)

#### Armory Gate - 2.21.6...2.21.6


#### Dinghy™ - 2.21.3...2.21.3


#### Armory Clouddriver - 2.21.5...2.21.5


#### Armory Rosco - 2.21.2...2.21.2


#### Terraformer™ - 2.21.5...2.21.6

  - fix(profiles): add session token for AWS assume role (#245) (#246)

#### Armory Fiat - 2.21.2...2.21.2


#### Armory Front50 - 2.21.0...2.21.0


#### Armory Deck - 2.21.6...2.21.7

  - feat(build): add details on how to build from a OSS forked release branch (#652) (#654)

#### Armory Igor - 2.21.2...2.21.2


#### Armory Kayenta - 2.21.2...2.21.2


#### Armory Orca - 2.21.4...2.21.4