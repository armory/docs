---
title: v2.27.3 Armory Enterprise Release (Spinnaker™ v1.27.0)
toc_hide: true
version: 02.27.03
description: >
  Release notes for Armory Enterprise v2.27.3
---

## 2022/03/11 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Operator version

To install, upgrade, or configure Armory 2.27.3, use one of the following tools:

- Armory Operator 1.6.0 or later

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

{{< include "breaking-changes/bc-dinghy-slack.md" >}}

{{< include "breaking-changes/bc-java-tls-mysql.md" >}}

{{< include "breaking-changes/bc-k8s-version-pre1-16.md" >}}

{{< include "breaking-changes/bc-k8s-infra-buttons.md" >}}

{{< include "breaking-changes/bc-hal-deprecation.md" >}}

#### Plugin compatibility

{{< include "breaking-changes/bc-plug-version-lts-227.md" >}}

## Known issues


{{< include "known-issues/ki-deck-navbar.md" >}}
{{< include "known-issues/ki-bake-var-file.md" >}}
{{< include "known-issues/ki-artifact-binding-spel.md" >}}
{{< include "known-issues/ki-dinghy-gh-notifications.md" >}}
{{< include "known-issues/ki-secrets-and-spring-cloud.md" >}}

## Highlighted updates

### Cloud Foundry

* Fixed an issue where Fiat crashed due to invalid Cloud Foundry accounts.
* Performance optimization to reduce unnecessary api calls to Cloud Foundry during caching cycles.

### **Show** Added to Terraform Integration Stage

There is a new Terraform action available as part of the Terraform Integration stage. This action is the equivalent of running the Terraform ```show``` command with Terraform. The JSON output from your planfile can be used in subsequent stages.

To use the stage, select **Terraform** for the stage type and **Show** as the action in the Stage Configuration UI. Note that the **Show** stage depends on your **Plan** stage. For more information, see [Show Stage section in the Terraform Integration docs]({{< ref "terraform-use-integration#example-terraform-integration-stage" >}}).

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
    commit: 5eb6c8598e22a90ca6eb8c5d7dcb5daddeade04f
    version: 2.27.3
  deck:
    commit: ea911f8927180bb5223f3c6149005568111ad294
    version: 2.27.3
  dinghy:
    commit: ee2e7f8b9778741dae1a5571cb47ac6c76c51d81
    version: 2.27.3
  echo:
    commit: aa794fa58437bbaae6b3f7c32f4844e5da937c92
    version: 2.27.3
  fiat:
    commit: e285a77d97d73304e3a1f75fd67c736eac804a37
    version: 2.27.3
  front50:
    commit: e60edec818a2c0633c9e809b1cca66a03e640d9a
    version: 2.27.3
  gate:
    commit: f4f1b1c0511d7d20e948541eceb020112acc9f52
    version: 2.27.3
  igor:
    commit: 97986b3554e3501507989335e73618a832357f71
    version: 2.27.3
  kayenta:
    commit: 800b14c9162cc0f486f4e7f510f87ec8db9b5e98
    version: 2.27.3
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 4fe016e9539cfae5cf79b39888227afc11a5741b
    version: 2.27.3
  rosco:
    commit: 44f38498ade0864c5c8373f43560a984c2c91432
    version: 2.27.3
  terraformer:
    commit: 89dd4af83b669d6a12de41611ea0bdf57857dd73
    version: 2.27.3
timestamp: "2022-03-02 19:10:56"
version: 2.27.3
</code>
</pre>
</details>

### Armory


#### Armory Igor - 2.27.2...2.27.3

  - chore(build): Autobump armory-commons: 3.10.0 (#280)
  - chore(build): update mergify config (backport #283) (#284)
  - chore(cd): update base service version to igor:2022.01.19.07.32.50.release-1.27.x (#282)
  - chore(cd): update armory-commons version to 3.10.1 (#287)
  - chore(cd): update armory-commons version to 3.10.2 (#291)

#### Armory Gate - 2.27.2...2.27.3

  - chore(build): Autobump armory-commons: 3.10.0 (#363)
  - chore(cd): update base service version to gate:2022.01.19.07.39.09.release-1.27.x (#378)
  - chore(cd): update base service version to gate:2022.01.19.07.39.09.release-1.27.x (#370)
  - chore(cd): update base service version to gate:2022.01.19.07.39.09.release-1.27.x (#366)
  - chore(build): update mergify config (backport #373) (#374)
  - chore(cd): update base service version to gate:2022.02.03.20.15.21.release-1.27.x (#382)
  - chore(cd): update armory-commons version to 3.10.1 (#385)
  - chore(cd): update armory-commons version to 3.10.2 (#389)

#### Armory Orca - 2.27.2...2.27.3

  - [create-pull-request] automated change (#403)
  - chore(build): update mergify config (backport #408) (#409)
  - chore(cd): update base orca version to 2022.01.19.07.10.29.release-1.27.x (#405)
  - chore(cd): update base orca version to 2022.01.19.07.10.29.release-1.27.x (#407)
  - chore(gradle): upgrade gradle wrapper to 7.3.3 (#412)
  - chore(cd): update armory-commons version to 3.10.1 (#415)
  - chore(cd): update base orca version to 2022.02.11.18.48.53.release-1.27.x (#417)
  - chore(cd): update base orca version to 2022.02.14.23.53.57.release-1.27.x (#419)
  - chore(cd): update base orca version to 2022.02.15.22.24.23.release-1.27.x (#421)
  - chore(cd): update armory-commons version to 3.10.2 (#420)

#### Armory Kayenta - 2.27.2...2.27.3

  - chore(build): update mergify config (backport #297) (#298)
  - chore(cd): update armory-commons version to 3.10.1 (#301)
  - chore(cd): update base service version to kayenta:2022.02.16.00.31.30.release-1.27.x (#302)
  - chore(cd): update armory-commons version to 3.10.2 (#304)

#### Armory Rosco - 2.27.2...2.27.3

  - [create-pull-request] automated change (#338)
  - chore(cd): update armory-commons version to 3.10.1 (#348)
  - chore(cd): update base service version to rosco:2022.01.19.07.33.06.release-1.27.x (#346)
  - fix(tests): remove tests intended for Spinnaker Cloud (#314) (#351)
  - fix(build): remove redhat publishing (#301)
  - fix(test): increase timeout for AMI bake int test (#350) (#356)
  - chore(cd): update armory-commons version to 3.10.2 (#358)

#### Terraformer™ - 2.27.2...2.27.3

  - feat(terraform): Adds show option for terraform stage (#447) (#448)

#### Armory Deck - 2.27.2...2.27.3

  - feat(terraform): Adds show option for terraform stage (backport #1149) (#1150)
  - chore(cd): update base deck version to 2021.0.0-20211217214939.release-1.27.x (#1158)
  - chore(cd): update base deck version to 2022.0.0-20220119092715.release-1.27.x (#1163)
  - chore(cd): update base deck version to 2022.0.0-20220119092715.release-1.27.x (#1166)
  - chore(build): update mergify config (#1167)

#### Armory Clouddriver - 2.27.2...2.27.3

  - chore(cd): update base service version to clouddriver:2021.12.17.10.45.12.release-1.27.x (#513)
  - chore(cd): update base service version to clouddriver:2021.12.22.18.20.08.release-1.27.x (#518)
  - chore(build): Autobump armory-commons: 3.10.0 (#517)
  - chore(cd): update base service version to clouddriver:2022.01.19.07.03.15.release-1.27.x (#524)
  - chore(cd): update base service version to clouddriver:2022.01.19.07.33.22.release-1.27.x (#528)
  - chore(cd): update armory-commons version to 3.10.1 (#537)
  - chore(cd): update armory-commons version to 3.10.2 (#541)
  - chore(cd): update base service version to clouddriver:2022.02.22.16.52.45.release-1.27.x (#544)
  - chore(cd): update base service version to clouddriver:2022.02.24.19.52.46.release-1.27.x (#549)

#### Armory Echo - 2.27.2...2.27.3

  - chore(build): Autobump armory-commons: 3.10.0 (#400)
  - chore(cd): update base service version to echo:2022.01.19.07.51.20.release-1.27.x (#410)
  - chore(cd): update base service version to echo:2022.01.19.07.51.20.release-1.27.x (#403)
  - chore(cd): update base service version to echo:2022.01.19.07.51.20.release-1.27.x (#404)
  - chore(build): update mergify config (backport #406) (#407)
  - chore(cd): update armory-commons version to 3.10.1 (#411)
  - chore(cd): update armory-commons version to 3.10.2 (#413)

#### Dinghy™ - 2.27.2...2.27.3

  - chore(build): update mergify config (#457) (#458)

#### Armory Front50 - 2.27.2...2.27.3

  - chore(build): Autobump armory-commons: 3.10.0 (#346)
  - chore(cd): update base service version to front50:2022.01.19.08.45.30.release-1.27.x (#355)
  - chore(cd): update base service version to front50:2022.01.19.08.45.30.release-1.27.x (#349)
  - chore(build): update mergify config (backport #351) (#352)
  - chore(cd): update armory-commons version to 3.10.1 (#356)
  - chore(cd): update armory-commons version to 3.10.2 (#359)

#### Armory Fiat - 2.27.2...2.27.3

  - chore(build): Autobump armory-commons: 3.10.0 (#286)
  - chore(build): update mergify config (backport #293) (#294)
  - chore(cd): update base service version to fiat:2022.01.19.08.14.32.release-1.27.x (#289)
  - chore(cd): update base service version to fiat:2022.01.19.08.14.32.release-1.27.x (#292)
  - chore(cd): update armory-commons version to 3.10.1 (#298)
  - chore(cd): update armory-commons version to 3.10.2 (#301)
  - chore(cd): update base service version to fiat:2022.03.02.18.55.09.release-1.27.x (#308)

