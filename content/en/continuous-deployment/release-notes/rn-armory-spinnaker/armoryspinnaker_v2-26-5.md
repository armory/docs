---
title: v2.26.5 Armory Continuous Deployment Release (Spinnaker™ v1.26.6)
toc_hide: true
version: 02.26.05
date: 2022-02-21
description: >
  Release notes for Armory Continuous Deployment v2.26.5
---

## 2022/01/21 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a previous working version and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.26.5, use one of the following tools:
​
- Armory-extended Halyard 1.12 or later
  - 2.26.x is the last minor release that you can use Halyard to install or manage. Future releases require the Armory Operator. For more information, see [Halyard Deprecation]({{< ref "halyard-deprecation" >}}).
​
- Armory Operator 1.2.6 or later

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

{{< include "breaking-changes/bc-java-tls-mysql.md" >}}
​
{{< include "breaking-changes/bc-k8s-version-pre1-16.md" >}}
​
{{< include "breaking-changes/bc-k8s-infra-buttons.md" >}}

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

{{< include "known-issues/ki-bake-var-file.md" >}}
{{< include "known-issues/ki-artifact-binding-spel.md" >}}
{{< include "known-issues/ki-dinghy-gh-notifications.md" >}}
{{< include "known-issues/ki-secrets-and-spring-cloud.md" >}}

## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->

### Terraform Show stage

There is a new Terraform Show stage available as part of the Terraform Integration. This stage is the equivalent of running the `terraform show` command with Terraform. The JSON output from your `planfile` can be used in subsequent stages.

To use the stage, select **Terraform** for the stage type and **Show** as the action in the stage configuration UI. Note that the Show stage depends on your Plan stage. For more information, see the [Show Stage section in the Terraform Integration docs]({{< ref "plugins/terraform/use#example-terraform-integration-stage" >}}).


###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.26.6](https://www.spinnaker.io/changelogs/1.26.6-changelog/) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.26.5
timestamp: "2022-01-19 21:15:17"
services:
    clouddriver:
        commit: 2957f1021447910d60f0f6e9e290988c9b5a11e0
        version: 2.26.25
    deck:
        commit: 0180fcf0a08b0121c5d9af9d3c589487368ad7f4
        version: 2.26.12
    dinghy:
        commit: d1406fad85771d7f44a266d3302d6195c00d7ec2
        version: 2.26.13
    echo:
        commit: ce4f4ed265be8cb746784c6fd4bed7bf5156107e
        version: 2.26.13
    fiat:
        commit: e46182a670fc9bac7c02f809df7ffe65c89ba148
        version: 2.26.14
    front50:
        commit: 7e14c30538a9b97468aba0360408abf4a06bc0dd
        version: 2.26.15
    gate:
        commit: 41c92b2d613e47521c60d2c9036504ff405fbb91
        version: 2.26.13
    igor:
        commit: 889135384533cd723c0a6377a37a7365cf92a8b2
        version: 2.26.13
    kayenta:
        commit: 2403ad86e76898a65939ebdf879bf287fa8b1429
        version: 2.26.14
    monitoring-daemon:
        version: 2.26.0
    monitoring-third-party:
        version: 2.26.0
    orca:
        commit: 624af61e6bf75bc92e67a6bef6439f8ae29ec79a
        version: 2.26.19
    rosco:
        commit: cbb42562fad6583e6efcb24a7378cb6fd84668f0
        version: 2.26.19
    terraformer:
        commit: 0cded7056eeecbb85a70a1b94fe1ce83613295bf
        version: 2.26.15
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Kayenta - 2.26.13...2.26.14


#### Dinghy™ - 2.26.12...2.26.13


#### Armory Deck - 2.26.11...2.26.12

  - feat(terraform): Adds show option for terraform stage (backport #1149) (#1151)

#### Terraformer™ - 2.26.14...2.26.15

  - feat(terraform): Adds show option for terraform stage (#447) (#449)

#### Armory Igor - 2.26.12...2.26.13


#### Armory Clouddriver - 2.26.24...2.26.25

  - chore(cd): update base service version to clouddriver:2021.12.30.00.36.21.release-1.26.x (#514)
  - chore(cd): update base service version to clouddriver:2022.01.19.07.05.30.release-1.26.x (#525)

#### Armory Orca - 2.26.18...2.26.19


#### Armory Echo - 2.26.12...2.26.13


#### Armory Gate - 2.26.12...2.26.13


#### Armory Fiat - 2.26.13...2.26.14


#### Armory Front50 - 2.26.14...2.26.15


#### Armory Rosco - 2.26.18...2.26.19


