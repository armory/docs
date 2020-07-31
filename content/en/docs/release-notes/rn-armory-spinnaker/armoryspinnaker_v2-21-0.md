---
title: v2.21.0 Armory Release (OSS Spinnaker v1.21.2)
toc_hide: true
---

## 2020/07/31 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Halyard version

Armory Spinnaker 2.21.0 requires one of the following:
* Armory Halyard 1.9.4 or later.
* Armory Spinnaker Operator 1.0.2 or later.

## Breaking changes

### Spinnaker metrics

Metrics data, specifically the metric names, for Spinnaker changed in 2.20. These changes are not backwards compatible and may result in broken third-party dashboards, such as Grafana dashboards.

**Workarounds**:

* **Observability plugin**: Armory is working on updates to the [Observability plugin](https://github.com/armory-plugins/armory-observability-plugin) to remedy this issue. The plugin currently supports New Relic & Prometheus. Note that this resolution requires you to make updates to use the new metric names.

   For information about how to install a plugin, see [Plugin Users Guide](https://spinnaker.io/guides/user/plugins/).

* **Update existing dashboards**: Change your dashboards and alerts to use the new metric names.

Although both workarounds involve updating your dashboards to use the new metric names, Armory recommends switching to the Observability plugin. Due to changes the Spinnaker project is making, the Observability plugin provides a long-term solution. 

This release note will be updated once the updated plugin is available.

### HTTP sessions for Gate
Armory Spinnaker 2.19.x and higher include an upgrade to the Spring Boot dependency. This requires you to flush all the Gate sessions for your Spinnaker deployment. For more information, see [Flushing Gate Sessions](https://kb.armory.io/admin/flush-gate-sessions/).

### Scheduled removal of Kubernetes V1 provider
The Kubernetes V1 provider has been removed in Spinnaker 1.21 (Armory Spinnaker 2.21). Please see the [RFC](https://github.com/spinnaker/governance/blob/master/rfc/eol_kubernetes_v1.md) for more details.

Breaking change: Kubernetes accounts with an unspecified providerVersion will now default to V2. Update your Halconfig to specify `providerVersion: v1` for any Kubernetes accounts you are currently using with the V1 provider.

## Known Issues

### Dynamic Accounts for Kubernetes

There is an issue with Dynamic Accounts for Kubernetes where the following issues occur:

* Agents can be removed but still run on schedule. 
* Force cache refresh times out.
* If you have the clean up agent setup, your data randomly disappears and reappears.  

These issues do not occur immediately, and you may even see modified accounts appear.

### Security update

We continue to make Spinnaker's security a top priority. Although several CVEs are resolved, the following still exist:

#### Multiple services

`CVE-2020-5410` was resolved in a previous version of Armory Spinnaker; however, this CVE introduced a regression for users of Spring Cloud and has been rolled back. Armory will continue to monitor releases for a fix.

#### Orca

- CVE-2020-13790

This is an embedded dependency in OpenJDK11. A version of OpenJDK11 that addresses
this CVE has only recently been released. The CVE will be fixed in an upcoming release. The risk to services users is low. The CVE deals with processing `jpeg` images in the Java Runtime Environment, a task Armory Spinnaker services do not perform.

The following CVEs have been recently identified and will be addressed in an upcoming release:

- CVE-2020-14155

#### Clouddriver

The following CVEs still exist in Clouddriver:

- CVE-2020-1747
- CVE-2017-18342
- CVE-2020-13757
- CVE-2016-10745

All of them are embedded dependencies in the Google Cloud SDK. A version of the Google Cloud SDK addressing these CVEs has not been released. The risk to Clouddriver users is low. All four CVEs deal with untrusted input, which Clouddriver does not provide to the Google Cloud SDK. Additionally, users deploying to other cloud providers are not at risk for this vulnerability.

The following CVE also exists for Clouddriver:

- CVE-2020-7014 deals with an Elasticsearch exploit related to token generation. Clouddriver only makes use of entity tags and does not allow for token generation or authentication.

#### Terraformer

Armory has identified and is triaging the following CVEs in Terraformer, the service for the Terraform integration: 

- CVE-2020-14422
- CVE-2020-13757

## Highlighted Updates

### Armory

Summary of changes in the latest release.

###  Spinnaker Community Contributions

<! -- Copy/paste highlights from the corresponding OSS version. -->

There have also been numerous enhancements, fixes and features across all of Spinnaker's other services. See their changes here:  
[Spinnaker v1.21.2](https://www.spinnaker.io/community/releases/versions/1-21-2-changelog)

## Detailed Updates

### Bill of Materials
Here's the bom for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.21.0
timestamp: "2020-07-31 20:23:22"
services:
    clouddriver:
        commit: f97b7cc2
        version: 2.21.1
    deck:
        commit: 8c42b95f
        version: 2.21.3
    dinghy:
        commit: 780d019d
        version: 2.21.1
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
        commit: c17b7686
        version: 2.21.2
    igor:
        commit: b5662632
        version: 2.21.1
    kayenta:
        commit: c67e13d7
        version: 2.21.0
    monitoring-daemon:
        version: 2.21.0
    monitoring-third-party:
        version: 2.21.0
    orca:
        commit: d49aeea4
        version: 2.21.0
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


#### Armory Orca - 2.20.5...2.21.0

  - chore(version): Generate build-info properties file (#104)
  - fix(build): explicitly set armory commons version (#116)
  - fix(build): force nebula version (#120)

#### Armory Deck - 2.20.4...2.21.3

  - fix(commons): rollback version of commons (#616)
  - chore(release): update to oss 1.21.2-rc1 (#633) (#634)
  - chore(build): push images to dockerhub (#631) (#635)
  - fix(header): remove custom angular header shim (#636) (#637)

#### Armory Fiat - 2.20.6...2.21.1

  - chore(version): upgrade armory commons, armory settings plugin and JDK github actions to generate build-info properties file (#57)
  - fix(release): set nebula release version (#73)
  - chore(core): update fiat.yml config 1.20->1.21 (#92) (#93)

#### Armory Clouddriver - 2.20.8...2.21.1

  - chore(version): upgrade armoryCommons & armory.settings plugin to generate build-info.properties file (#131)
  - fix(build): explicitly set armory commons version (#150)
  - fix(build): Add gcloud app-engine-go component (#156)
  - fix(dynamicAccounts): Port fix of caching agents deleted on refresh (#173)
  - chore(build): python3, remove curl, groff, less, aws 1.18.109, kubectl 1.17.7 (#175) (#176)

#### Armory Igor - 2.20.11...2.21.1

  - chore(version): Generate build-info properties file (#65)
  - chore(cve): fix CVE-2020-13692 (#75)
  - chore(build): fix nebula issue (#78)
  - chore(deps): change armory-commons import to -all (#86)
  - fix(build): explicitly set armory commons version (#92)
  - chore(core): update igor.yml config (#113) (#114)

#### Terraformer - 2.20.8...2.21.3

  - fix(profiles): dont evaluate permissions on a nil Profile (#183)
  - fix(profiles): test verifying no error thrown when profile is nil (#185)
  - chore(deps): update plank version (#186)
  - fix(git/repo): support symlinks when unpacking tarball archives (#192)
  - feat(terraform): require terraform version (#197)
  - fix(artifacts): retrieve artifacts by name || reference (#199)
  - chore(tests): beginning of integration test fram (#198)
  - chore(versions): maintain image with all versions (#203)
  - chore(versions): manual exec versions workflow (#206)
  - chore(build): fix build and push action name (#208)
  - chore(versions): fix docker action again (#209)
  - chore(versions): fix image name (#210)
  - chore(docker): use cache image for tf versions (#204)
  - chore(integration): trigger integration tests (#214)
  - Revert "chore(integration): trigger integration tests (#214)" (#215)
  - chore(test): trigger integration tests (#219)
  - fix(artifacts): use one method for consistent download/reading (#217)
  - chore(environment): add image pull secret (#222)
  - chore(security): upgrade to alpine:3.12 (#226) (#227)

#### Dinghy - 2.20.6...2.21.1

  - feat(slacknotifications): Send slack applications notifications (#228)
  - Fix for app update on every change (#231)
  - fix(notifications): Fixed slack notification (#242)
  - feat(prvalidation): repository processing and PR validations (#241)
  - fix(prval): bugfix for PR validation (#249)
  - fix(bitbucket): Fix Bitbucket integration (#252)

#### Armory Kayenta - 2.20.6...2.21.0

  - chore(version): upgrade armory commons, armory settings plugin and JDK github actions to generate build-info properties file (#77)
  - fix(release): set nebula release version (#92)

#### Armory Echo - 2.20.12...2.21.1

  - chore(version): upgrade armory commons, armory settings and JDK on guthub actions (#158)
  - chore(build): update nebula plugin to fix release task (#173)
  - chore(deps): change armory-commons import to -all (#176)
  - fix(dinghy): fix webhook validations headers to lowercase (#181)
  - fix(bitbucket): fix bitbucket integration with dinghy (#185)
  - fix(build): explicitly set armory commons version (#190)
  - fix(github): fix conflicting bean with upstream (#194)
  - feat(plugin-metrics): adds support for proxying plugin events to the debug endpoint (#198)
  - fix(plugin-metrics): speed up test (#199)

#### Armory Front50 - 2.20.8...2.21.0

  - chore(version): Generate build-info properties file. (#92)
  - chore(cve): force commons-collections and postgresql (#107)
  - chore(deps): upgrade nebula plugin (#110)

#### Armory Rosco - 2.20.6...2.21.1

  - chore(version): upgrade armory commons, armory settings plugin and JDK github action to generate build-info properties file (#58)
  - chore(dependencies): bump spinnaker release
  - fix(release): set nebula release version (#71)
  - fix(release): use armorycommons to set nebula version (#73)
  - Revert "fix(release): use armorycommons to set nebula version (#73)" (#74)
  - fix(rosco): updated config from  1.20.x..1.21.x (#89) (#90)

#### Armory Gate - 2.20.4...2.21.2

  - fix(terraformer): propagate auth to profiles call (#123)
  - chore(version): upgrade armory commons, armory settings plugin and JDK github actions to generate build-info properties file. (#117)
  - chore(build): fix nebula issue (#149) (#150)
  - fix(configs): adding redis configs (#152) (#153)
  - chore(build): push images to dockerhub (#151) (#154)

