---
title: v2.24.2 Armory Release (OSS Spinnaker™ v1.24.6)
toc_hide: true
version: 02.24.02
description: >
  Release notes for Armory Enterprise v2.24.2 
---

## 2021/07/06 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.24.2, use one of the following tools:

- Armory-extended Halyard 1.10 or later
- Armory Operator 1.2.1 or later
   For information about upgrading, Operator, see [Upgrade the Operator]({{< ref "op-manage-operator#upgrade-the-operator" >}}).

## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, see the [Support Portal](https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010414). Note that you must be logged in to the portal to see the information.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->
> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

{{< include "breaking-changes/bc-k8s-job-suffix.md" >}}

<!-- Moved this to Breaking changes instead of KI. Didn't bother renaming it. -->
{{< include "known-issues/ki-orca-zombie-execution.md" >}}

{{< include "breaking-changes/bc-orca-forcecacherefresh.md" >}}


## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->
{{< include "known-issues/ki-bake-var-file.md" >}}
{{< include "known-issues/ki-lambda-ui-caching.md" >}}
{{< include "known-issues/ki-dinghy-modules.md" >}}

## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->
### AWS Lambda

Health status fields are now part of the function cache so that corresponding tasks can continue as expected.

### Terraform Integration

Terraform versions 13.6 to 14.10 are now available in the Terraform Integration stage.

###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.24.6](https://www.spinnaker.io/changelogs/1.24.6-changelog/) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.24.2
timestamp: "2021-07-06 14:37:34"
services:
    clouddriver:
        commit: eed137c5
        version: 2.24.24
    deck:
        commit: 5cb89f5a
        version: 2.24.4
    dinghy:
        commit: eaa25737
        version: 2.24.11
    echo:
        commit: 44a92c44
        version: 2.24.12
    fiat:
        commit: 40f20536
        version: 2.24.13
    front50:
        commit: 33170b40
        version: 2.24.14
    gate:
        commit: 62ffcfcb
        version: 2.24.15
    igor:
        commit: f981a107
        version: 2.24.10
    kayenta:
        commit: a828efe7
        version: 2.24.16
    monitoring-daemon:
        version: 2.24.0
    monitoring-third-party:
        version: 2.24.0
    orca:
        commit: 5325cf8c
        version: 2.24.14
    rosco:
        commit: bd1646b6
        version: 2.24.15
    terraformer:
        commit: 449494d2
        version: 2.24.7
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Front50 - 2.24.12...2.24.14

#### Terraformer™ - 2.24.4...2.24.7

  - chore(versions): add terraform 13.6 through 14.10 (bp #376) (#378)
  - security(versions): secure terraform binaries (backport #390) (#392)
  - chore(versions): update tf installer to use new hashi keys (#396) (#399)

#### Armory Fiat - 2.24.12...2.24.13


#### Dinghy™ - 2.24.10...2.24.11

  - fix(config): bit more err checking on initial config load (#378)

#### Armory Echo - 2.24.11...2.24.12


#### Armory Clouddriver - 2.24.23...2.24.24


#### Armory Orca - 2.24.13...2.24.14


#### Armory Igor - 2.24.9...2.24.10


#### Armory Deck - 2.24.3...2.24.4


#### Armory Kayenta - 2.24.14...2.24.16

  - feat(dynatrace): adding support for resolution parameter (#224) (#228)

#### Armory Rosco - 2.24.12...2.24.15

  - Update gradle.yml
  - fix(inttest): fixing vpc and subnets because recreation (backport #230) (#278)

#### Armory Gate - 2.24.14...2.24.15


