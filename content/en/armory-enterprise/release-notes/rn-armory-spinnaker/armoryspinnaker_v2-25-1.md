---
title: v2.25.1 Armory Enterprise Release (Spinnaker™ v1.25.3)
toc_hide: true
version: 02.25.01
date: 2021-12-15
description: >
  Release notes for Armory Enterprise 2.25.1
---

## 2021/12/15 Release Notes

> Note: If you're experiencing production issues after upgrading Armory Enterprise, rollback to a previous working version and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

For information about what Armory supports for this version, see the [ [Armory Enterprise v2.25 compatibility matrix](https://v2-25.docs.armory.io/docs/armory-enterprise-matrix/).

## Required Halyard or Operator version
​
To install, upgrade, or configure Armory 2.25.1, use one of the following tools:
- Armory-extended Halyard 1.12 or later
- Armory Operator 1.2.6 or later
​
   For information about upgrading, Operator, see [Upgrade the Operator]({{< ref "op-manage-operator#upgrade-the-operator" >}}).
​
## Security
​
Armory scans the codebase as we develop and release software. For information about CVE scans for this release, see the [Support Portal](https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010414). Note that you must be logged in to the portal to see the information.

This release includes a security fix. For more information, see the Critical Notification that Armory's Support Team sent out on 14 December 2021, contact your Armory account rep, or see this (login required) Support article: https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010520.
​
## Breaking changes

>Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.


{{< include "breaking-changes/bc-k8s-job-suffix.md" >}}
​
{{< include "known-issues/ki-orca-zombie-execution.md" >}}
​
{{< include "breaking-changes/bc-orca-forcecacherefresh.md" >}}
​
## Known issues
​
{{< include "known-issues/ki-bake-var-file.md" >}}
{{< include "known-issues/ki-lambda-ui-caching.md" >}}
{{< include "known-issues/ki-dinghy-pipelineID.md" >}}
​
​
#### Git repo artifact provider cannot checkout SHAs
​
Only branches are currently supported. For more information, see [6363](https://github.com/spinnaker/spinnaker/issues/6363).
​
#### Server groups
<!-- ENG-5847 -->
There is a known issue where you cannot edit AWS server groups with the **Edit** button in the UI. The edit window closes immediately after you open it.
​
**Workaround**: To make changes to your server groups, edit the stage JSON directly by clicking on the **Edit stage as JSON** button.
​
## Highlighted updates
​
This release includes a security fix. For more information, see the Critical Notification that Armory's Support Team sent out on 14 December 2021, contact your Armory account rep, or see this (login required) Support article: https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010520.

###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.25.3](https://spinnaker.io/changelogs/1.25.3-changelog/) changelog for details.

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


#### Armory Deck - 2.25.3...2.25.6

  - fix(settings): add MPTv2 and Dinghy Events flags back (#776)
  - fix(build): include cd actions & use cd dependencies (#1144)

#### Armory Kayenta - 2.25.2...2.25.4

  - fix(build): add cd workflow / use io.spinnaker deps (#284)
  - chore(cd): update base service version to kayenta:2021.12.08.00.12.05.release-1.25.x (#291)
  - chore(armory-commons): autobump armory-commons to 3.8.6 (#293)

#### Dinghy™ - 2.25.1...2.25.5

  - fix(config): bit more err checking on initial config load (#380)
  - fix(crash_on_module_updates): remove call to log.fatal() (#366) (#367) (#428)
  - chore(build): include workflow to onboard dinghy in cd images (#456)

#### Armory Clouddriver - 2.25.3...2.25.6

  - fix(build): use baseServiceVersion as base for the extension (#482)
  - fix(build): update workflows to produce CD images (#483)
  - fix(build): use the correct dependencies from baseServiceVersion (#485)
  - chore(build): bump armory.settings plugin to 1.7.2 (#495)
  - chore(cd): update base service version to clouddriver:2021.12.07.22.20.09.release-1.25.x (#504)
  - chore(armory-commons): autobump armory-commons to 3.8.6 (#507)

#### Armory Fiat - 2.25.3...2.25.5

  - fix(build): onboard 2.25.x with astrolabe cd (#265)
  - chore(cd): update base service version to fiat:2021.12.07.22.20.53.release-1.25.x (#277)
  - chore(armory-commons): autobump armory-commons to 3.8.6 (#280)

#### Terraformer™ - 2.25.0...2.25.9

  - chore(build): add gcloud sdk + anthoscli (#374) (#375)
  - chore(versions): add terraform 13.6 through 14.10 (bp #376) (#377)
  - security(versions): secure terraform binaries (backport #390) (#391)
  - chore(versions): update tf installer to use new hashi keys (#396) (#398)
  - chore(tests): retrieve secrets from s3, not vault (#418) (#422)
  - task(tf_versions): update tf bundled versions script to use new key-server (#417) (#424)
  - task(tf_versions): update tf bundled versions script to use new key (#428) (#430)
  - fix(build): add cd workflow (#446)

#### Armory Front50 - 2.25.2...2.25.4

  - fix(build): onboard front50 with astrolabe cd build (#326)
  - chore(cd): update base service version to front50:2021.12.07.22.22.25.release-1.25.x (#338)
  - chore(armory-commons): autobump armory-commons to 3.8.6 (#341)

#### Armory Gate - 2.25.5...2.25.7

  - fix(build): onboard 2.25.x with cd process (#340)
  - feat(gradle): Add stack trace to gradle build (backport #359) (#360)
  - chore(cd): update base service version to gate:2021.12.15.00.04.16.release-1.25.x (#357)

#### Armory Orca - 2.25.2...2.25.3

  - fix(build): add cd workflow for Astrolabe (#374)
  - chore(cd): update base orca version to 2021.12.07.23.35.56.release-1.25.x (#391)
  - chore(armory-commons): autobump armory-commons to 3.8.6 (#396)

#### Armory Rosco - 2.25.2...2.25.8

  - Update gradle.yml
  - fix(build): add cd workflows / build using artifact (#320)
  - chore(cd): update base service version to rosco:2021.12.07.23.36.04.release-1.25.x (#330)
  - chore(armory-commons): autobump armory-commons to 3.8.6 (#333)
  - fix(tests): remove tests intended for Spinnaker Cloud (#314) (#322)

#### Armory Igor - 2.25.2...2.25.4

  - fix(build): include workflows for CD with Astrolabe (#265)
  - chore(cd): update base service version to igor:2021.12.07.23.57.30.release-1.25.x (#273)
  - chore(armory-commons): autobump armory-commons to 3.8.6 (#276)

#### Armory Echo - 2.25.2...2.25.4

  - fix(build): onboard 2.25.x with astrolabe cd process (#376)
  - chore(build): bump armory gradle 1.7.2 (#378)
  - chore(cd): update base service version to echo:2021.12.07.22.20.45.release-1.25.x (#390)
  - chore(armory-commons): bump armory-commons to 3.8.6 (#394)

