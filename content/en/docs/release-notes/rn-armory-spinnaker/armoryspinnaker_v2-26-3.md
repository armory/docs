---
title: v2.26.3 Armory Release (OSS Spinnaker™ v1.26.6)
toc_hide: true
version: 02.26.03
description: >
  Release notes for Armory Enterprise v2.26.3 
---

## 2021/09/24 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.26.3, use one of the following tools:

- Armory-extended Halyard 1.12 or later
  - 2.26.x is the last minor release that you can use Halyard to install or manage. Future releases require the Armory Operator. For more information, see [Halyard Deprecation]({{< ref "halyard-deprecation" >}}).

- Armory Operator 1.2.6 or later

   For information about upgrading, Operator, see [Upgrade the Operator]({{< ref "op-manage-operator#upgrade-the-operator" >}}).


## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, see the [Support Portal](https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010414). Note that you must be logged in to the portal to see the information.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

{{< include "breaking-changes/bc-java-tls-mysql.md" >}}

{{< include "breaking-changes/bc-k8s-version-pre1-16.md" >}}

{{< include "breaking-changes/bc-k8s-infra-buttons.md" >}}

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

{{< include "known-issues/ki-bake-var-file.md" >}}

## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->
### AWS Lambda

* Fixed an issue where infrastructure for Lambda functions was not being displayed in the UI. This was related to Lambda functions and their event source mappings.


###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.26.6](https://www.spinnaker.io/changelogs/1.26.6-changelog/) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.26.3
timestamp: "2021-09-23 02:12:12"
services:
    clouddriver:
        commit: d361f7e62fe555fda9dd5682b64627f4703563a8
        version: 2.26.20
    deck:
        commit: 198d62eae2710dceed1f462e50a183abba613fef
        version: 2.26.10
    dinghy:
        commit: d1406fad85771d7f44a266d3302d6195c00d7ec2
        version: 2.26.11
    echo:
        commit: c1e9ced6759392159ee628e63cc5808a1c5d8fdd
        version: 2.26.11
    fiat:
        commit: ea4874e41748992d24e0a36a5534bc37d0aa0d31
        version: 2.26.12
    front50:
        commit: ba5b33e616e51dc0e655f40da18277c9434ca5fe
        version: 2.26.13
    gate:
        commit: a7242aa7506dff2f342c69562666308c653fae17
        version: 2.26.11
    igor:
        commit: d1ad3f87ee857a73f6e546ea4cc410286e87cea9
        version: 2.26.11
    kayenta:
        commit: 4f668d1297a5d205d516667c1af6902d0d9f380f
        version: 2.26.12
    monitoring-daemon:
        version: 2.26.0
    monitoring-third-party:
        version: 2.26.0
    orca:
        commit: a3463f61ff082502c1c6cb35ea7b01aeee5456a9
        version: 2.26.17
    rosco:
        commit: 1dfc60f1f70ccdadc2cc03ff9f27b5ca39bb9c39
        version: 2.26.15
    terraformer:
        commit: 2dc177734c1445252dfeb3b8353ce94596c8a4c3
        version: 2.26.13
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Igor - 2.26.10...2.26.11

  - chore(build): remove platform build (#257)

#### Armory Clouddriver - 2.26.19...2.26.20

  - chore(cd): update base service version to clouddriver:2021.09.01.22.20.35.release-1.26.x (#412)
  - chore(cd): update base service version to clouddriver:2021.09.02.07.27.19.release-1.26.x (#413)
  - chore(cd): update base service version to clouddriver:2021.09.02.07.44.26.release-1.26.x (#414)
  - chore(cd): update base service version to clouddriver:2021.09.02.17.47.50.release-1.26.x (#416)
  - chore(build): remove platform build (#426)
  - chore(cd): update base service version to clouddriver:2021.09.09.21.52.53.release-1.26.x (#432)
  - chore(cd): update base service version to clouddriver:2021.09.09.23.19.30.release-1.26.x (#433)
  - chore(cd): update base service version to clouddriver:2021.09.10.19.35.46.release-1.26.x (#438)
  - chore(cd): update base service version to clouddriver:2021.09.17.17.07.10.release-1.26.x (#445)
  - chore(cd): update base service version to clouddriver:2021.09.17.18.53.46.release-1.26.x (#447)

#### Armory Fiat - 2.26.11...2.26.12

  - chore(build): remove platform build (#251)

#### Armory Kayenta - 2.26.11...2.26.12


#### Terraformer™ - 2.26.12...2.26.13

  - chore(build): remove platform build (#440)

#### Armory Deck - 2.26.9...2.26.10

  - chore(build): remove platform build (#1116)
  - fix(build): use same name than GHA (#1119)
  - chore(cd): update base deck version to 2021.0.0 20210922221550.release-1.26.x-166666656 (#1120)

#### Armory Gate - 2.26.10...2.26.11

  - chore(build): remove platform build (#326)

#### Armory Rosco - 2.26.14...2.26.15


#### Armory Front50 - 2.26.12...2.26.13

  - chore(cd): update base service version to front50:2021.06.25.20.05.12.release-1.26.x (#307)

#### Armory Orca - 2.26.16...2.26.17

  - fix(build): remove redhat publishing (#357)

#### Dinghy™ - 2.26.10...2.26.11

  - chore(build): remove platform build (#455)

#### Armory Echo - 2.26.10...2.26.11

  - chore(build): remove platform build (#368)

