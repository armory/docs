---
title: v2.25.1 Armory Release (OSS Spinnaker™ v1.25.6)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping --> 
description: >
  Release notes for Armory Enterprise v2.25.1 
---

## 2021/12/40 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.25.1, use one of the following tools:

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
[Spinnaker v1.25.6](https://www.spinnaker.io/changelogs/1.25.6-changelog/) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.25.1
timestamp: "2021-12-15 17:23:28"
services:
    clouddriver:
        commit: a764fa3dd360655e8ebd9b81e2217fce554f434c
        version: 2.25.6
    deck:
        commit: 3be7d16e0ba22113b38a7e8a1862f9769a119d10
        version: 2.25.6
    dinghy:
        commit: 7feba3a7b859b9595758c7c9e09782e651d9f0f8
        version: 2.25.5
    echo:
        commit: d4254bb69d38e8bf9216c045c4380933ff4582e1
        version: 2.25.4
    fiat:
        commit: fe60b6210c6ce00167aa42143a4dffebcf03fb9f
        version: 2.25.5
    front50:
        commit: 3d2302240be46ca85600e488c20059a9990f13d4
        version: 2.25.4
    gate:
        commit: eab05d036bef8c391274baa7fb3d294862fad37e
        version: 2.25.7
    igor:
        commit: 670df68838b5183faa5ab42db3559b20bbfb29c9
        version: 2.25.4
    kayenta:
        commit: f859543dc93fe2438cca2b7907fde957dde9f64c
        version: 2.25.4
    monitoring-daemon:
        version: 2.26.0
    monitoring-third-party:
        version: 2.26.0
    orca:
        commit: 8f84752ec39945409533737c25beb2a853fa22d0
        version: 2.25.3
    rosco:
        commit: 8ef53c816490ac4350813003e098d9ccdff33b0b
        version: 2.25.8
    terraformer:
        commit: 4551e4c1976da52d1f96033f2849d97dc4c9131c
        version: 2.25.9
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Terraformer™ - 2.25.0...2.25.9

  - chore(build): add gcloud sdk + anthoscli (#374) (#375)
  - chore(versions): add terraform 13.6 through 14.10 (bp #376) (#377)
  - security(versions): secure terraform binaries (backport #390) (#391)
  - chore(versions): update tf installer to use new hashi keys (#396) (#398)
  - chore(tests): retrieve secrets from s3, not vault (#418) (#422)
  - task(tf_versions): update tf bundled versions script to use new key-server (#417) (#424)
  - task(tf_versions): update tf bundled versions script to use new key (#428) (#430)
  - fix(build): add cd workflow (#446)

#### Armory Orca - 2.25.2...2.25.3

  - fix(build): add cd workflow for Astrolabe (#374)
  - chore(cd): update base orca version to 2021.12.07.23.35.56.release-1.25.x (#391)
  - chore(armory-commons): autobump armory-commons to 3.8.6 (#396)

#### Armory Deck - 2.25.3...2.25.6

  - fix(settings): add MPTv2 and Dinghy Events flags back (#776)
  - fix(build): include cd actions & use cd dependencies (#1144)

#### Armory Fiat - 2.25.3...2.25.5

  - fix(build): onboard 2.25.x with astrolabe cd (#265)
  - chore(cd): update base service version to fiat:2021.12.07.22.20.53.release-1.25.x (#277)
  - chore(armory-commons): autobump armory-commons to 3.8.6 (#280)

#### Armory Kayenta - 2.25.2...2.25.4

  - fix(build): add cd workflow / use io.spinnaker deps (#284)
  - chore(cd): update base service version to kayenta:2021.12.08.00.12.05.release-1.25.x (#291)
  - chore(armory-commons): autobump armory-commons to 3.8.6 (#293)

#### Dinghy™ - 2.25.1...2.25.5

  - fix(config): bit more err checking on initial config load (#380)
  - fix(crash_on_module_updates): remove call to log.fatal() (#366) (#367) (#428)
  - chore(build): include workflow to onboard dinghy in cd images (#456)

#### Armory Echo - 2.25.2...2.25.4

  - fix(build): onboard 2.25.x with astrolabe cd process (#376)
  - chore(build): bump armory gradle 1.7.2 (#378)
  - chore(cd): update base service version to echo:2021.12.07.22.20.45.release-1.25.x (#390)
  - chore(armory-commons): bump armory-commons to 3.8.6 (#394)

#### Armory Igor - 2.25.2...2.25.4

  - fix(build): include workflows for CD with Astrolabe (#265)
  - chore(cd): update base service version to igor:2021.12.07.23.57.30.release-1.25.x (#273)
  - chore(armory-commons): autobump armory-commons to 3.8.6 (#276)

#### Armory Clouddriver - 2.25.3...2.25.6

  - fix(build): use baseServiceVersion as base for the extension (#482)
  - fix(build): update workflows to produce CD images (#483)
  - fix(build): use the correct dependencies from baseServiceVersion (#485)
  - chore(build): bump armory.settings plugin to 1.7.2 (#495)
  - chore(cd): update base service version to clouddriver:2021.12.07.22.20.09.release-1.25.x (#504)
  - chore(armory-commons): autobump armory-commons to 3.8.6 (#507)

#### Armory Front50 - 2.25.2...2.25.4

  - fix(build): onboard front50 with astrolabe cd build (#326)
  - chore(cd): update base service version to front50:2021.12.07.22.22.25.release-1.25.x (#338)
  - chore(armory-commons): autobump armory-commons to 3.8.6 (#341)

#### Armory Gate - 2.25.5...2.25.7

  - fix(build): onboard 2.25.x with cd process (#340)
  - feat(gradle): Add stack trace to gradle build (backport #359) (#360)
  - chore(cd): update base service version to gate:2021.12.15.00.04.16.release-1.25.x (#357)

#### Armory Rosco - 2.25.2...2.25.8

  - Update gradle.yml
  - fix(build): add cd workflows / build using artifact (#320)
  - chore(cd): update base service version to rosco:2021.12.07.23.36.04.release-1.25.x (#330)
  - chore(armory-commons): autobump armory-commons to 3.8.6 (#333)
  - fix(tests): remove tests intended for Spinnaker Cloud (#314) (#322)

