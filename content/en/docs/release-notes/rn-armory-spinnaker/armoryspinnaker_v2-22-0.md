---
title: v2.22.0 Armory Release (OSS Spinnaker™ v1.22.1)
toc_hide: true
date: 2020-09-25
version: 02.22.00
---

## 2020/09/25 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Halyard and Operator version

Armory Spinnaker 2.22.0 requires one of the following:

* Armory Halyard 1.9.4 or later.
* Armory Spinnaker Operator 1.0.3 or later.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. -->

{{< include "breaking-changes/bc-k8s-namespace.md" >}}


{{< include "breaking-changes/bc-k8s-job-suffix.md" >}}

{{< include "breaking-changes/bc-metrics-name.md" >}}

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed -->

{{< include "known-issues/ki-plugins-sdk.md" >}}

{{< include "known-issues/ki-gce-predictive-autoscaling.md" >}}

{{< include "known-issues/ki-aws-iam-token.md" >}}

#### Security update

We continue to make Spinnaker's security a top priority. Although several CVEs are resolved, the following still exist:

##### Multiple services

`CVE-2020-5410` was resolved in a previous version of Armory Spinnaker; however, this CVE introduced a regression for users of Spring Cloud and has been rolled back. Armory will continue to monitor releases for a fix.


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

##### Terraformer

Armory has identified and is triaging the following CVEs in Terraformer, the service for the Terraform integration:

- CVE-2020-15778

## Highlighted updates

### Armory

Summary of changes in the latest release.

#### Security fixes

This release includes fixes for the following CVEs:

* [CVE-2020-11984](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11984)
* [CVE-2020-9484](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-9484)
* [CVE-2020-7692](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-7692)

Additionally, several CVEs are resolved in the Deck and Gate services.

#### UI

The Spinnaker UI, Deck, has undergone extensive changes to provide better user experience around certain features. The changes may look drastic at first, but Fernando, an engineer at Armory, is here to walk you through them:

<iframe width="560" height="315" src="https://www.youtube.com/embed/e6nC7AtYv4s" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

**New buttons**

When you first log in to Spinnaker, you now see **Create Application** and **Create Project** buttons. Previously, these were under a menu named **Actions**. The buttons also appear on the corresponding page, either Application or Project.

{{< figure src="/images/deck-post-2-22-buttons.png" alt="2.22 includes new buttons for creating an application and creating a project" >}}

**Applications view**

The changes look drastic, but there is no change in functionality. The top navigation for the **Applications** page is now on the left and has been expanded so that more capabilities are visible at the top level.

{{< figure src="/images/deck-post-2-22-app-page.png" alt="The Applications page has a new left navigation." >}}

###  Spinnaker Community contributions

<!-- Copy/paste highlights from the corresponding OSS version. -->

There have also been numerous enhancements, fixes and features across all of Spinnaker's other services. See their changes here:  
[Spinnaker v1.22.1](https://www.spinnaker.io/community/releases/versions/1-22-1-changelog).

## Detailed updates

### Bill of Materials
Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.22.0
timestamp: "2020-09-24 18:00:34"
services:
    clouddriver:
        commit: 1a194e06
        version: 2.22.3
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
        commit: d03460f3
        version: 2.22.2
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


#### Armory Orca - 2.21.4...2.22.1

  - chore(build): push images to dockerhub (#135)
  - fix(terraformer): remove deprecated method call (#147)

#### Armory Kayenta - 2.21.2...2.22.2

  - chore(core): update kayenta.yml config 1.20->1.21 (#111)
  - fix(cve): CVE fixes CVE-2020-9484 and CVE-2020-7692 (#128) (#131)

#### Terraformer™ - 2.21.6...2.22.2

  - chore(security): upgrade to alpine:3.12 (#226)
  - chore(integration): add healthcheck to default env (#228)
  - feat(terraform): beginnings of hcl parser (#230)
  - feat(remote): add support for remote backends (#231)
  - feat(tfc): add auth support for tfe/c (#233)
  - feat(tests): add clouddriver gitrepo account (#235)
  - chore(tests): add successful integration test for terraform plan (#234)
  - fix(docker): re-add cache dir to container (#239)
  - feat(terraform): add 0.13.0 and recent 0.12.x versions (#237)
  - fix(profiles): add session token for AWS assume role (#245)
  - chore(hash): updating hash to fix build
  - fix(plan): add targets to plan command (#262) (#264)

#### Armory Igor - 2.21.2...2.22.2

  - chore(core): update igor.yml config (#113)
  - feat(test): integration test scaffolding (#116)
  - chore(readme): adding readme

#### Armory Deck - 2.21.7...2.22.5

  - fix(terraform): fix planForDestroy flag rendering in execution details (#632)
  - chore(cve): fix CVE-2020-11984 (#640)
  - feat(mptv2): add feature flag for mptv2 && upgrade to oss 1.22.x (#649) (#650)
  - fix(appengine): fix rendering of StageArtifactSelector when artifacts are created #8516 (#651)
  - fix(functions): change KMSKeyArn to match function cache data model #8566 (#661)

#### Armory Clouddriver - 2.21.5...2.22.3

  - chore(build): python3, remove curl, groff, less, aws 1.18.109, kubectl 1.17.7 (#175)
  - fix(cve) Security fixes (#177)
  - fix(opa): reconcile upstream 1.22 changes (#187)
  - feat(plugins): include plugin downloader and pluginManifest to service. (#184)
  - fix(dynamicAccounts): Server unable to start with vault (#188)
  - fix(chore): undo backport for spring security version 5.3.2 (#200)

#### Armory Fiat - 2.21.2...2.22.2

  - chore(core): update fiat.yml config 1.20->1.21 (#92)
  - feat(test): add file and github teams role provider integration test (#96)
  - chore(hash): updating hash to fix build

#### Armory Echo - 2.21.3...2.22.1

  - fix(plugins): Don't fail when debug service is not provided because diagnostics.enabled is false (#224) (#225)

#### Armory Front50 - 2.21.0...2.22.1

  - feat(integrationTest): add scaffoling for integration tests (#128)
  - feat(tests): helm chart for front50 integration tests (#131)
  - chore(integration): add mysql integration test (#132)
  - feat(tests): add initial tests for Application CRUD operations (#137)
  - feat(tests): initial tests for Pipeline CRUD ops (#138)

#### Armory Gate - 2.21.6...2.22.2

  - chore(build): fix nebula issue (#149)
  - chore(build): push images to dockerhub (#151)
  - fix(configs): adding redis configs (#152)
  - fix(cve): CVE fixes (#155)
  - fix(saml): Esapi dependency exact version (downgrade) (#160)
  - feat(plugins): include plugin downloader and plugin manifest (#164)
  - fix(hash): updating hash for builds

#### Dinghy™ - 2.21.3...2.22.0

  - fix(status): change github when dinghyfiles are not changed (#261)
  - fix(prvalidation): fixed pr validation bug related with no dinghyfiles changed (#265)

#### Armory Rosco - 2.21.2...2.22.2

  - fix(rosco): updated config from  1.20.x..1.21.x (#89)
  - feat(tests): integration test scaffolding (#92)
  - chore(readme): adding readme

