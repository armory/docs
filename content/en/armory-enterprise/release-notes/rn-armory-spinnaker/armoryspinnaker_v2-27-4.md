---
title: v2.27.4 Armory Release (OSS Spinnaker™ v1.27.1)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
description: >
  Release notes for Armory Enterprise v2.27.4
---

## 2022/09/02 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a previous working version and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.27.4, use one of the following tools:

- Armory-extended Halyard <PUT IN A VERSION NUMBER> or later
- Armory Operator <PUT IN A VERSION NUMBER> or later

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->




###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.27.1](https://www.spinnaker.io/changelogs/1.27.1-changelog/) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>artifactSources:
  dockerRegistry: docker.io/armory
dependencies:
  redis:
    commit: null
    version: 2:2.8.4-2
services:
  clouddriver:
    commit: a6a2b412958bd3d5555dc74190df86ab2c4fb5a5
    version: 2.27.4
  deck:
    commit: 1b08ce5370fd95b9c4647734c36df71d729a386a
    version: 2.27.4
  dinghy:
    commit: ee2e7f8b9778741dae1a5571cb47ac6c76c51d81
    version: 2.27.4
  echo:
    commit: 749433b28e8c8724b00c7f853736296c06b7eaa9
    version: 2.27.4
  fiat:
    commit: 9d615d351b220ea846e3c31890ecea7757fe40f4
    version: 2.27.4
  front50:
    commit: a05405308878a6278522793b0d55f0f8a06cb6a5
    version: 2.27.4
  gate:
    commit: 0aa1dac24a046fa8ff37b7cdd6edb704a16b215c
    version: 2.27.4
  igor:
    commit: cb18ff7fe94fca85ab546b4304cb9fa9ce380b69
    version: 2.27.4
  kayenta:
    commit: 08b8f4656b4f6285ae5b0a5577ab10f6c50ba8ec
    version: 2.27.4
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: fc9593f3c4da98fa8c7f6753598a75f4ea19a49c
    version: 2.27.4
  rosco:
    commit: eec2780305426ba8c38bcf599176a00b138b96cf
    version: 2.27.4
  terraformer:
    commit: 53c9f50a991a3f102e14a103340c3eea5c9ef982
    version: 2.27.4
timestamp: "2022-08-31 20:17:03"
version: 2.27.4
</code>
</pre>
</details>

### Armory


#### Armory Front50 - 2.27.3...2.27.4

  - chore(cd): update armory-commons version to 3.10.3 (#361)
  - chore(cd): update base service version to front50:2022.03.21.23.23.18.release-1.27.x (#383)
  - chore(cd): update armory-commons version to 3.10.6 (#382)
  - chore(action): auto approve astrolabe pr (#370) (#388)
  - chore(cd): update base service version to front50:2022.04.01.23.12.01.release-1.27.x (#395)
  - chore(cd): update base service version to front50:2022.04.01.23.40.50.release-1.27.x (#396)
  - chore(cd): update base service version to front50:2022.04.02.22.05.00.release-1.27.x (#397)
  - feat(iam): use aws-mysql-jdbc (#392)
  - chore(cd): update base service version to front50:2022.04.26.16.43.34.release-1.27.x (#412)
  - chore(cd): update base service version to front50:2022.04.26.21.25.40.release-1.27.x (#413)
  - chore(cd): update base service version to front50:2022.04.27.05.02.01.release-1.27.x (#416)
  - chore(cd): update base service version to front50:2022.04.27.05.12.28.release-1.27.x (#417)
  - chore(dockerfile): upgrade to latest alpine image (backport #434) (#435)
  - chore(cd): update base service version to front50:2022.08.02.17.26.31.release-1.27.x (#438)
  - chore(cd): update armory-commons version to 3.10.7 (#440)
  - chore(cd): update base service version to front50:2022.08.17.00.43.57.release-1.27.x (#447)

#### Terraformer™ - 2.27.3...2.27.4


#### Armory Clouddriver - 2.27.3...2.27.4

  - chore(action): auto approve prs with extensionDependencyUpdate label (#558) (#566)
  - chore(cd): update armory-commons version to 3.10.4 (#570)
  - fix(idmsv2): Bump aws-iam-authenticator (backport #563) (#575)
  - fix(aws-iam-authenticator): Rollback authenticator (#578)
  - chore(cd): update armory-commons version to 3.10.5 (#583)
  - chore(cd): update armory-commons version to 3.10.6 (#585)
  - feat(iam): use aws-mysql-jdbc (#586)
  - chore(cd): update base service version to clouddriver:2022.03.21.18.41.11.release-1.27.x (#587)
  - chore(cd): update base service version to clouddriver:2022.03.21.23.37.45.release-1.27.x (#589)
  - chore(cd): update base service version to clouddriver:2022.04.01.23.17.01.release-1.27.x (#595)
  - chore(cd): update base service version to clouddriver:2022.04.01.23.52.01.release-1.27.x (#596)
  - chore(cd): update base service version to clouddriver:2022.04.02.21.55.39.release-1.27.x (#597)
  - chore(cd): update base service version to clouddriver:2022.04.02.22.21.08.release-1.27.x (#598)
  - chore(cd): update base service version to clouddriver:2022.04.12.02.55.01.release-1.27.x (#607)
  - chore(kubectl): Updating kubectl version to 1.20.6 (backport #608) (#610)
  - fix(jvm): Update base image to 3.14 (#615)
  - fix(aws-iam-authenticator): Fixes to use a version that figures out API contract (#619)
  - chore(cd): update base service version to clouddriver:2022.04.26.15.11.43.release-1.27.x (#626)
  - chore(cd): update base service version to clouddriver:2022.04.26.21.09.12.release-1.27.x (#628)
  - chore(cd): update base service version to clouddriver:2022.04.27.03.49.36.release-1.27.x (#632)
  - chore(cd): update base service version to clouddriver:2022.04.27.05.17.29.release-1.27.x (#635)
  - chore(gradle): removing spinnaker gradle fix version (backport #647) (#659)
  - chore(cd): update base service version to clouddriver:2022.05.17.15.06.27.release-1.27.x (#650)
  - chore(cd): update base service version to clouddriver:2022.07.07.18.30.50.release-1.27.x (#686)
  - chore(dockerfile): upgrade to latest alpine image (#689) (#690)
  - chore(aws-iam): Updating aws-iam-authenticator to 0.5.9 due to CVE-2022-2385 (backport #692) (#695)
  - chore(cd): update base service version to clouddriver:2022.08.03.03.18.27.release-1.27.x (#700)
  - chore(cd): update armory-commons version to 3.10.7 (#704)
  - chore(cd): update base service version to clouddriver:2022.08.17.22.35.25.release-1.27.x (#708)

#### Armory Echo - 2.27.3...2.27.4

  - chore(action): auto approve prs from astrolabe (#423) (#426)
  - chore(cd): update armory-commons version to 3.10.4 (#431)
  - chore(cd): update armory-commons version to 3.10.5 (#436)
  - chore(cd): update armory-commons version to 3.10.6 (#438)
  - chore(cd): update base service version to echo:2022.03.21.15.46.42.release-1.27.x (#439)
  - chore(cd): update base service version to echo:2022.03.21.23.22.58.release-1.27.x (#440)
  - chore(cd): update base service version to echo:2022.04.01.23.11.12.release-1.27.x (#444)
  - chore(cd): update base service version to echo:2022.04.01.23.39.52.release-1.27.x (#445)
  - chore(cd): update base service version to echo:2022.04.26.16.16.02.release-1.27.x (#454)
  - chore(cd): update base service version to echo:2022.04.27.04.40.11.release-1.27.x (#461)
  - chore(cd): update base service version to echo:2022.08.03.03.06.31.release-1.27.x (#479)
  - chore(cd): update armory-commons version to 3.10.7 (#483)
  - chore(cd): update base service version to echo:2022.08.17.22.13.30.release-1.27.x (#487)

#### Dinghy™ - 2.27.3...2.27.4


#### Armory Gate - 2.27.3...2.27.4

  - chore(action): auto approve astrolabe pr (#398) (#400)
  - chore(cd): update armory-commons version to 3.10.4 (#405)
  - chore(cd): update armory-commons version to 3.10.5 (#410)
  - chore(cd): update armory-commons version to 3.10.6 (#412)
  - chore(cd): update base service version to gate:2022.03.21.23.23.37.release-1.27.x (#413)
  - chore(cd): update base service version to gate:2022.04.01.23.16.01.release-1.27.x (#418)
  - chore(cd): update base service version to gate:2022.04.01.23.57.37.release-1.27.x (#419)
  - chore(cd): update base service version to gate:2022.04.26.16.46.41.release-1.27.x (#430)
  - chore(cd): update base service version to gate:2022.04.26.21.21.22.release-1.27.x (#431)
  - chore(cd): update base service version to gate:2022.04.27.05.09.59.release-1.27.x (#434)
  - chore(cd): update base service version to gate:2022.04.27.05.20.10.release-1.27.x (#437)
  - chore(release): Backport header fix to 2.27.x release (backport #454) (#455)
  - fix(perf): upgrade alpine version to resolve perf in GCP (backport #457) (#458)
  - fix(header): set header version for this release (#460)
  - chore(cd): update base service version to gate:2022.08.03.03.06.55.release-1.27.x (#465)
  - chore(cd): update armory-commons version to 3.10.7 (#467)
  - chore(cd): update base service version to gate:2022.08.17.22.14.22.release-1.27.x (#471)

#### Armory Igor - 2.27.3...2.27.4

  - chore(action): auto approve astrolabe pr (#299) (#302)
  - chore(cd): update armory-commons version to 3.10.4 (#307)
  - chore(cd): update armory-commons version to 3.10.5 (#312)
  - chore(cd): update armory-commons version to 3.10.6 (#314)
  - chore(cd): update base service version to igor:2022.03.21.18.42.32.release-1.27.x (#315)
  - chore(cd): update base service version to igor:2022.03.21.23.23.58.release-1.27.x (#316)
  - chore(cd): update base service version to igor:2022.04.01.23.35.50.release-1.27.x (#320)
  - chore(cd): update base service version to igor:2022.04.02.02.50.48.release-1.27.x (#321)
  - chore(cd): update base service version to igor:2022.04.26.16.43.20.release-1.27.x (#331)
  - chore(cd): update base service version to igor:2022.04.26.21.21.16.release-1.27.x (#332)
  - chore(cd): update base service version to igor:2022.04.27.05.23.46.release-1.27.x (#333)
  - chore(cd): update base service version to igor:2022.04.27.05.30.34.release-1.27.x (#335)
  - chore(dockerfile): upgrade to latest alpine image (#348) (#349)
  - chore(cd): update base service version to igor:2022.08.03.03.04.08.release-1.27.x (#356)
  - chore(cd): update armory-commons version to 3.10.7 (#359)
  - chore(cd): update base service version to igor:2022.08.17.22.13.26.release-1.27.x (#361)

#### Armory Deck - 2.27.3...2.27.4


#### Armory Fiat - 2.27.3...2.27.4

  - chore(action): auto approve astrolabe prs (#318) (#321)
  - chore(cd): update armory-commons version to 3.10.4 (#327)
  - chore(cd): update armory-commons version to 3.10.5 (#331)
  - chore(cd): update armory-commons version to 3.10.6 (#332)
  - chore(cd): update base service version to fiat:2022.03.21.18.41.53.release-1.27.x (#333)
  - chore(cd): update base service version to fiat:2022.03.21.23.23.09.release-1.27.x (#334)
  - chore(cd): update base service version to fiat:2022.04.01.22.16.31.release-1.27.x (#342)
  - chore(cd): update base service version to fiat:2022.04.01.22.43.59.release-1.27.x (#343)
  - chore(cd): update base service version to fiat:2022.04.26.16.43.25.release-1.27.x (#353)
  - chore(cd): update base service version to fiat:2022.04.27.04.03.44.release-1.27.x (#357)
  - chore(cd): update base service version to fiat:2022.05.19.23.32.15.release-1.27.x (#367)
  - fix(build): pass version to nebula and remove devSnapshot publishing (backport #355) (#372)
  - chore(build): upgrade armory settings (backport #360) (#369)
  - chore(dockerfile): upgrade to latest alpine image (#378) (#379)
  - chore(cd): update base service version to fiat:2022.08.03.03.06.59.release-1.27.x (#386)
  - chore(cd): update armory-commons version to 3.10.7 (#387)

#### Armory Kayenta - 2.27.3...2.27.4

  - chore(cd): update base service version to kayenta:2022.04.27.05.41.49.release-1.27.x (#337)
  - chore(cd): update armory-commons version to 3.10.6 (#321)
  - chore(dockerfile): upgrade to latest alpine image (#345) (#346)
  - chore(cd): update base service version to kayenta:2022.08.03.03.06.36.release-1.27.x (#351)
  - chore(cd): update armory-commons version to 3.10.7 (#355)
  - chore(cd): update base service version to kayenta:2022.08.18.00.00.27.release-1.27.x (#357)

#### Armory Rosco - 2.27.3...2.27.4

  - chore(cd): update armory-commons version to 3.10.3 (#359)
  - chore(action): auto approve extensionDependency pr (#369) (#377)
  - chore(cd): update armory-commons version to 3.10.4 (#381)
  - chore(cd): update armory-commons version to 3.10.5 (#385)
  - chore(build): update mergify config (#343) (#388)
  - chore(cd): update armory-commons version to 3.10.6 (#390)
  - chore(cd): update base service version to rosco:2022.03.21.18.43.05.release-1.27.x (#391)
  - chore(cd): update base service version to rosco:2022.03.21.23.22.48.release-1.27.x (#392)
  - chore(cd): update base service version to rosco:2022.04.01.23.28.07.release-1.27.x (#396)
  - chore(cd): update base service version to rosco:2022.04.26.18.16.54.release-1.27.x (#404)
  - chore(cd): update base service version to rosco:2022.04.26.21.08.03.release-1.27.x (#406)
  - chore(cd): update base service version to rosco:2022.04.27.03.19.40.release-1.27.x (#411)
  - chore(build): remove platform build (#305)
  - chore(dockerfile): upgrade to latest alpine image (#428) (#430)
  - chore(cd): update armory-commons version to 3.10.7 (#439)
  - chore(cd): update base service version to rosco:2022.08.03.03.02.10.release-1.27.x (#441)
  - chore(cd): update base service version to rosco:2022.08.23.02.25.55.release-1.27.x (#445)

#### Armory Orca - 2.27.3...2.27.4

  - chore(action): auto approve astrolabe pr (#431) (#435)
  - chore(cd): update armory-commons version to 3.10.4 (#440)
  - chore(cd): update armory-commons version to 3.10.5 (#446)
  - chore(cd): update armory-commons version to 3.10.6 (#448)
  - chore(cd): update base orca version to 2022.03.21.15.48.11.release-1.27.x (#450)
  - chore(cd): update base orca version to 2022.03.21.18.42.54.release-1.27.x (#451)
  - chore(cd): update base orca version to 2022.04.01.23.40.45.release-1.27.x (#456)
  - chore(cd): update base orca version to 2022.04.01.23.57.41.release-1.27.x (#457)
  - chore(cd): update base orca version to 2022.04.02.02.36.54.release-1.27.x (#458)
  - feat(iam): aws mysql jdbc (#449)
  - chore(cd): update base orca version to 2022.04.26.17.16.24.release-1.27.x (#473)
  - chore(cd): update base orca version to 2022.04.26.21.22.29.release-1.27.x (#474)
  - chore(cd): update base orca version to 2022.04.27.05.38.47.release-1.27.x (#477)
  - chore(cd): update base orca version to 2022.04.27.05.53.30.release-1.27.x (#480)
  - chore(dockerfile): upgrade to latest alpine image (#495) (#496)
  - chore(cd): update base orca version to 2022.08.03.03.10.04.release-1.27.x (#505)
  - chore(cd): update armory-commons version to 3.10.7 (#508)
  - chore(cd): update base orca version to 2022.08.17.22.25.10.release-1.27.x (#513)
  - Revert(deps): "feat(iam): aws mysql jdbc" (#515)


### Spinnaker


#### Spinnaker Front50 - 1.27.1


#### Spinnaker Clouddriver - 1.27.1

  - chore(ci): GHA - container image and apt package build & push (#5667)
  - chore(dependencies): Autobump korkVersion (#5630)
  - chore(dependencies): bump spinnakerGradleVersion (#936) (#5674)
  - chore(dependencies): Autobump fiatVersion (#5675)
  - fix(build): don't bump the version of clouddriver in front50 (#5477) (#5676)
  - chore(dependencies): don't create an autobump PR for halyard on a clouddriver release branch (#5677)
  - fix(kubernetes): Pin Debian Package version of kubectl as well (#5685) (#5686)
  - chore(ci): Upload halconfigs to GCS on Tag push (#5689) (#5693)
  - chore(dependencies): Autobump fiatVersion (#5695)
  - fix(ci): fetch previous tag from git instead of API (#5696) (#5698)
  - chore(ci): Mergify - merge Autobumps on release-* (#5697) (#5700)
  - chore(titus): limit protobuf to 3.17.3 (#5706) (#5712)
  - fix(caching): K8s cache affected when not enough permissions in service account (backport #5742) (#5745)
  - chore(dockerfile): upgrade to latest alpine image (#5758) (#5759)
  - chore(dependencies): Autobump fiatVersion (#5768)

#### Spinnaker Echo - 1.27.1


#### Spinnaker Gate - 1.27.1


#### Spinnaker Igor - 1.27.1


#### Spinnaker Deck - 1.27.1


#### Spinnaker Fiat - 1.27.1

  - chore(ci): GHA - container image and apt package build & push (#930)
  - chore(dependencies): Autobump korkVersion (#904)
  - feat(build): bump dependencies for the given branch (#934) (#935)
  - chore(dependencies): bump spinnakerGradleVersion (#936)
  - chore(ci): Upload halconfigs to GCS on Tag push (#940) (#943)
  - chore(dependencies): don't create an autobump PR for halyard on a fiat release branch (#946)
  - fix(ci): fetch previous tag from git instead of API (#948) (#950)
  - chore(build): specify an artifact for bumpdeps to look for (backport #916) (#956)
  - chore(dockerfile): upgrade to latest alpine image (#967) (#968)

#### Spinnaker Kayenta - 1.27.1

  - chore(ci): GHA - container image and apt package build & push (#879)
  - chore(dependencies): bump spinnakerGradleVersion (#881)
  - chore(dependencies): Autobump orcaVersion (#882)
  - chore(ci): Upload halconfigs to GCS on Tag push (#884) (#885)
  - chore(dependencies): Autobump orcaVersion (#887)
  - fix(ci): fetch previous tag from git instead of API (#888) (#890)
  - chore(ci): Mergify - merge Autobumps on release-* (#889) (#892)
  - chore(dockerfile): upgrade to latest alpine image (#900) (#901)
  - chore(dependencies): Autobump orcaVersion (#904)

#### Spinnaker Rosco - 1.27.1


#### Spinnaker Orca - 1.27.1

  - fix(plugins-test): try harder for the version of versionNotSupportedPlugin to actually not be supported (#4236) (#4241)
  - chore(ci): GHA - container image and apt package build & push (#4240)
  - fix(discovery test): fixes admin controller test intermittent failures (#4202) (#4249)
  - feat(build): bump dependencies for the given branch (#4247) (#4248)
  - chore(dependencies): bump spinnakerGradleVersion (#4251)
  - chore(dependencies): Autobump fiatVersion (#4250)
  - chore(ci): Upload halconfigs to GCS on Tag push (#4256) (#4260)
  - chore(dependencies): Autobump fiatVersion (#4262)
  - fix(ci): fetch previous tag from git instead of API (#4263) (#4265)
  - chore(ci): Mergify - merge Autobumps on release-* (#4264) (#4267)
  - chore(dockerfile): upgrade to latest alpine image (#4284) (#4285)
  - chore(dependencies): Autobump fiatVersion (#4292)

