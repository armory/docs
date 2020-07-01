---
title: v2.20.2 Armory Release (OSS Spinnaker v1.20.6)
toc_hide: true
---

## 2020/07/1 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Halyard version

Armory Spinnaker 2.20.2 requires Armory Halyard 1.9.4 or later.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. -->

## Known Issues
<!-- Copy/paste known issues from the previous version if they're not fixed -->
There are currently no known issues with this release.


### Security update

We continue to make Spinnaker's security a top priority. Although several CVEs are resolved, the following still exist:

#### Orca

- CVE-2020-13790

This is an embedded dependency in OpenJDK11. A version of OpenJDK11 that addresses
this CVE has only recently been released, and will be fixed in the next release. The risk to services users is low: the CVE deals with processing jpeg images in the Java Runtime Environment, a task our services do not utilize.

The following CVEs have been recently identified and will be addressed in the next released:

- CVE-2020-14155

#### Clouddriver

The following three CVEs still exist in Clouddriver:

- CVE-2020-1747
- CVE-2017-18342
- CVE-2020-13757
- CVE-2016-10745

All of them are embedded dependencies in the Google Cloud SDK. A version of the Google Cloud SDK addressing these CVEs has not been released. The risk to Clouddriver users is low: all three CVEs deal with untrusted input, which Clouddriver does not provide to the Google Cloud SDK. Additionally, users deploying to other cloud providers are not at risk for this vulernability.

The following CVEs also exist for the service:

- CVE-2020-7014 - deals with an Elasticsearch exploit. Clouddriver only makes use of entity tags and does not allow for token generation or authentication.

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
<code>version: 2.20.2
timestamp: "2020-07-01 08:17:14"
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
        commit: 1f1310e0
        version: 2.20.7
    fiat:
        commit: 8d4db29b
        version: 2.20.3
    front50:
        commit: 4ab036ea
        version: 2.20.5
    gate:
        commit: cfd0be04
        version: 2.20.3
    igor:
        commit: 5bd7a32c
        version: 2.20.8
    kayenta:
        commit: 9d6743d9
        version: 2.20.3
    monitoring-daemon:
        version: 2.20.0
    monitoring-third-party:
        version: 2.20.0
    orca:
        commit: eb40808c
        version: 2.20.2
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


#### Armory Orca - 2.20.1...2.20.2

#### Armory Rosco - 2.20.3...2.20.3


#### Armory Echo - 2.20.4...2.20.7

  - fix(dinghy): fix webhook validations headers to lowercase (#181) (#182)
  - fix(bitbucket): fix bitbucket integration with dinghy (#185) (#187)

#### Armory Deck - 2.20.4...2.20.4


#### Armory Gate - 2.20.3...2.20.3


#### Armory Kayenta - 2.20.3...2.20.3


#### Armory Clouddriver - 2.20.4...2.20.5


#### Dinghy™ - 2.20.3...2.20.3


#### Armory Front50 - 2.20.5...2.20.5


#### Armory Igor - 2.20.7...2.20.8


#### Terraformer™ - 2.20.3...2.20.3


#### Armory Fiat - 2.20.3...2.20.3


