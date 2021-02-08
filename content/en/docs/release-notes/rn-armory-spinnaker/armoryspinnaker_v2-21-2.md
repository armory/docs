---
title: v2.21.2 Armory Release (OSS Spinnaker™ v1.21.4)
toc_hide: true
date: 2020-08-07
version: 02.21.02
---

## 2020/08/07 Release Notes

> Note: If you're experiencing production issues after upgrading, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Halyard and Operator version

Armory Spinnaker 2.21.2 requires one of the following:
* Armory Halyard 1.9.4 or later.
* Armory Spinnaker Operator 1.0.3 or later.

## Breaking changes

{{< include "breaking-changes/bc-k8s-namespace.md" >}}

{{< include "breaking-changes/bc-metrics-name.md" >}}

#### Scheduled removal of Kubernetes V1 provider
The Kubernetes V1 provider has been removed in Spinnaker 1.21 (Armory Spinnaker 2.21). Please see the [RFC](https://github.com/spinnaker/governance/blob/master/rfc/eol_kubernetes_v1.md) for more details.


## Known Issues

#### Dynamic Account Configurations with Vault

Clouddriver fails to start when you use Vault as the backend for Dynamic Account Configurations.

**Affected version:** 2.21.2
**Fixed version:** 2.21.3

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


### Authentication

Fixed an issue where SAML login did not work.

### Pipelines as Code

Fixed an issue with `dinghyfile` validation when no changes are made to the file.

### Security

Resolved [CVE-2020-11984](https://nvd.nist.gov/vuln/detail/CVE-2020-11984).

###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes and features across all of Spinnaker's other services. See their changes here:  
[Spinnaker v1.21.4](https://www.spinnaker.io/community/releases/versions/1-21-4-changelog)

## Detailed Updates

### Bill of Materials
Here's the bom for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.21.2
timestamp: "2020-08-24 19:44:03"
services:
    clouddriver:
        commit: bad246c6
        version: 2.21.4
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
        commit: e969ea99
        version: 2.21.3
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


#### Armory Kayenta - 2.21.1...2.21.2


#### Armory Fiat - 2.21.1...2.21.2


#### Armory Gate - 2.21.3...2.21.6

  - fix(saml): Esapi dependency exact version (downgrade) (#160) (#161)

#### Terraformer™ - 2.21.3...2.21.5

  - fix(docker): re-add cache dir to container (#239) (#240)

#### Armory Clouddriver - 2.21.1...2.21.4

  - fix(cve): Security fixes (#180)

#### Dinghy™ - 2.21.2...2.21.3

  - fix(prvalidation): fixed pr validation bug related with no dinghyfiles changed (#265) (#266)

#### Armory Rosco - 2.21.1...2.21.2


#### Armory Deck - 2.21.3...2.21.6

  - chore(cve): fix CVE-2020-11984 (#640) (#643)

#### Armory Igor - 2.21.1...2.21.2


#### Armory Echo - 2.21.1...2.21.2


#### Armory Front50 - 2.21.0...2.21.0


#### Armory Orca - 2.21.2...2.21.3


