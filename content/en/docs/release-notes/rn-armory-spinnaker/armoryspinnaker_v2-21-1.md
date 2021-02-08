---
title: v2.21.1 Armory Release (OSS Spinnaker™ v1.21.2)
toc_hide: true
date: 2020-08-06
version: 02.21.01
---

## 2020/08/06 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Halyard version

Armory 2.21.1 requires one of the following:

* Armory-extended Halyard 1.9.4 or later.
* Armory Operator 1.0.3 or later.

## Breaking changes

{{< include "breaking-changes/bc-k8s-namespace.md" >}}

{{< include "breaking-changes/bc-metrics-name.md" >}}

#### HTTP sessions for Gate
Armory 2.19.x and higher include an upgrade to the Spring Boot dependency. This requires you to flush all the Gate sessions for your Spinnaker deployment. For more information, see [Flushing Gate Sessions](https://kb.armory.io/admin/flush-gate-sessions/).

#### Scheduled removal of Kubernetes V1 provider
The Kubernetes V1 provider has been removed in Spinnaker 1.21 (Armory 2.21). Please see the [RFC](https://github.com/spinnaker/governance/blob/master/rfc/eol_kubernetes_v1.md) for more details.

If you still have any jobs that use the V1 provider, you will encounter an error. For more information, see [Cloud providers](#cloud-providers).

## Known Issues

{{< include "known-issues/ki-saml-authn.md" >}}

#### Security update

We continue to make Spinnaker's security a top priority. Although several CVEs are resolved, the following still exist:

##### Multiple services

`CVE-2020-5410` was resolved in a previous version of Spinnaker; however, this CVE introduced a regression for users of Spring Cloud and has been rolled back. Armory will continue to monitor releases for a fix.

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

## Highlights

This release makes the following improvements:

* Fixes an issue in 2.20.0 where Custom Job Stages fail. For more information, see the [Known Issue]({{< ref "armoryspinnaker_v2-21-0#custom-job-stages" >}}).
* Improves how the GitHub PR Validation for Pipelines as Code works. If there are no changes to a `dinghyfile`, PR Validation passes.

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


#### Terraformer - 2.21.3...2.21.3


#### Armory Fiat - 2.21.1...2.21.1


#### Armory Igor - 2.21.1...2.21.1


#### Dinghy - 2.21.1...2.21.2

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

