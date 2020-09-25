---
title: v2.22.0 Armory Release (OSS Spinnaker v1.22.1)
toc_hide: true
description: Release notes for Armory 2.22.0
---

## 2020/09/25 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Halyard and Operator version

Armory Spinnaker 2.21.2 requires one of the following:

* Armory Halyard 1.9.4 or later.
* Armory Spinnaker Operator 1.0.3 or later.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. -->

{{< include "bc-k8s-namespace.md" >}}

{{< include "bc-docker-giduid.md" >}}

{{< include "bc-k8s-job-suffix.md" >}}


#### Spinnaker metrics

Metrics data, specifically the metric names, for Spinnaker changed in 2.20. These changes are not backwards compatible and may result in broken third-party dashboards, such as Grafana dashboards.

**Workarounds**:

* **Observability plugin**: Armory is working on updates to the [Observability plugin](https://github.com/armory-plugins/armory-observability-plugin) to remedy this issue. The plugin currently supports New Relic & Prometheus. Note that this resolution requires you to make updates to use the new metric names.

   For information about how to install a plugin, see [Plugin Users Guide](https://spinnaker.io/guides/user/plugins/).

* **Update existing dashboards**: Change your dashboards and alerts to use the new metric names.

Although both workarounds involve updating your dashboards to use the new metric names, Armory recommends switching to the Observability plugin. Due to changes the Spinnaker project is making, the Observability plugin provides a long-term solution. 

This release note will be updated once the updated plugin is available.

## Known Issues
<!-- Copy/paste known issues from the previous version if they're not fixed -->
There are currently no known issues with this release.

## Highlighted Updates

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

###  Spinnaker Community Contributions

<!-- Copy/paste highlights from the corresponding OSS version. -->

There have also been numerous enhancements, fixes and features across all of Spinnaker's other services. See their changes here:  
[Spinnaker v1.22.1](https://www.spinnaker.io/community/releases/versions/1-22-1-changelog).

## Detailed Updates

### Bill of Materials
Here's the bom for this version.
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

