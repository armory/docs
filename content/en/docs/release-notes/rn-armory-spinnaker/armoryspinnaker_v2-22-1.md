---
title: v2.22.1 Armory Release (OSS Spinnaker™ v1.22.2)
toc_hide: true
date: 2020-10-15
version: 02.22.01
---

## 2020/10/15 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Halyard or Operator version

Armory Spinnaker 2.22.1 requires one of the following:

* Armory Halyard 1.9.4 or later.
* Armory Spinnaker Operator 1.0.3 or later.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. -->

{{< include "breaking-changes/bc-k8s-namespace.md" >}}


{{< include "breaking-changes/bc-k8s-job-suffix.md" >}}

{{< include "breaking-changes/bc-metrics-name.md" >}}

## Known issues

{{< include "known-issues/ki-plugins-sdk.md" >}}

{{< include "known-issues/ki-gce-predictive-autoscaling.md" >}}


#### Security update

We continue to make Spinnaker's security a top priority. Although several CVEs are resolved, the following still exist.

##### Multiple services

`CVE-2020-5410` was resolved in a previous version of Armory Spinnaker; however, this CVE introduced a regression for users of Spring Cloud and has been rolled back. Armory will continue to monitor releases for a fix.


##### Clouddriver

The following CVE exists for Clouddriver:

- CVE-2020-7014 deals with an Elasticsearch exploit related to token generation. Clouddriver only makes use of entity tags and does not allow for token generation or authentication.

##### Terraformer

Armory has identified and is triaging the following CVEs in Terraformer, the service for the Terraform integration:

- CVE-2020-15778
- CVE-2020-13757. This CVE was resolved in other services but still exists in the Terraformer service.

## Highlighted updates

### Deployment targets

#### AWS

Fixed an issue where fetching an AWS token might take longer than expected.

### Manifest templating

Armory now includes version 3.8.1 of kustomize.

### Security

This release resolves several CVEs in Clouddriver:

* [CVE-2017-18342](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-18342)
* [CVE-2019-17638](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17638)
* [CVE-2020-1747](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1747)
* [CVE-2016-10745](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-10745)
* [CVE-2020-7009](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-7009)
* [CVE-2020-13757](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-13757)
* [CVE-2015-9251](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2015-9251)
* [CVE-2020-8927](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8927)
* [CVE-2014-0012](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2014-0012)
* [CVE-2014-1402](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2014-1402)
* [CVE-2011-4969](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2011-4969)
* [CVE-2016-10516](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-10516)
* [CVE-2020-7656](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-7656)
* [CVE-2020-7019](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-7019)

###  Spinnaker Community Contributions

<!-- Copy/paste highlights from the corresponding OSS version. -->

There have also been numerous enhancements, fixes and features across all of Spinnaker's other services. See their changes here: [Spinnaker v1.22.2](https://www.spinnaker.io/community/releases/versions/1-22-2-changelog).

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


