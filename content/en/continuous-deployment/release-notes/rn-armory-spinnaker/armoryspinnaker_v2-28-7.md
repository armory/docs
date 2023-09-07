---
title: v2.28.7 Armory Release (OSS Spinnaker™ v1.28.0)
toc_hide: true
version: 2.28.7
date: 2023-09-07
description: >
  Release notes for Armory Continuous Deployment v2.28.7
---

## 2023/09/07 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a previous working version and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory 2.28.7, use Armory Operator 1.70 or later.

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

{{< include "breaking-changes/bc-orca-rdbms-configured-utf8.md" >}}

{{< include "breaking-changes/bc-kubectl-120.md" >}}

{{< include "breaking-changes/bc-hal-deprecation.md" >}}

{{< include "breaking-changes/bc-plugin-compatibility-2-28-0.md" >}}

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

{{< include "known-issues/ki-app-attr-not-configured.md" >}}

{{< include "known-issues/ki-secrets-and-spring-cloud.md" >}}

{{< include "known-issues/ki-pipelines-as-code-gh-comments.md" >}}

{{< include "known-issues/ki-spel-expr-art-binding.md" >}}

## Early access

### Dynamic Rollback Timeout

To make the dynamic timeout available, you need to enable the feature flag in Orca and Deck.

On the Orca side, the feature flag overrides the default value rollback timeout - 5 min - with a UI input from the user. You **must** add this block to the **orca.yml** file if you want to enable the dynamic rollback timeout feature.

```
{
  "rollback:"
  "timeout:"
    "enabled: true"
}
```

On the Deck side, the feature flag enhances the Rollback Cluster stage UI with timeout input.

`window.spinnakerSettings.feature.dynamicRollbackTimeout = true;`

The default is used if there is no value set in the UI.

### Pipelines as Code multi-branch enhancement

Now you can configure Pipelines as Code to pull Dinghy files from multiple branches on the same repo. Cut out the tedious task of managing multiple repos; have a single repo for Spinnaker application pipelines. See [Multiple branches]({{< ref "plugins/pipelines-as-code/install/configure#multiple-branches" >}}) for how to enable and configure this feature.

### Terraform template fix

Armory fixed an issue with SpEL expression failures appearing while using Terraformer to serialize data from a Terraform Plan execution. With this feature flag fix enabled, you will be able to use the Terraform template file provider. Please open a support ticket if you need this fix.

### Automatically Cancel Jenkins Jobs

You now have the ability to cancel triggered Jenkins jobs when a Spinnaker pipeline is canceled, giving you more control over your full Jenkins workflow. Learn more about Jenkins + Spinnaker in this [documentation](https://spinnaker.io/changelogs/1.29.0-changelog/#orca).

### Pipelines adapt to sub pipeline with manual judgment color
When a child/sub pipeline is running and requires a manual judgment, the parent pipeline provides a visual representation that the child pipeline has an manual judgement waiting. This [Github pull request](https://github.com/spinnaker/deck/pull/9863) shows a visual representation of the feature in action.

### Triggering pipelines with Bitbucket server
Please see this [Pipeline User Guide](https://spinnaker.io/docs/guides/user/pipeline/triggers/bitbucket-events/) to use this feature

## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->

### Clouddriver
* Addressed an issue where deploying to an ECS cluster with tags was failing

### Orca
* Fixed an issue where Blue/Green(Red/Black) in the non-default namespace for kubernetes was failing


###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.28.0](https://www.spinnaker.io/changelogs/1.28.0-changelog/) changelog for details.

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
    commit: 50b4f4881597a374a9ba85aac90c0c0b9b22cee5
    version: 2.28.7
  deck:
    commit: 5e7cef7a443e096cf8158c0c405c3ebbf8b97c35
    version: 2.28.7
  dinghy:
    commit: 912007004f7720b418cd133301c7fb20207e1f2f
    version: 2.28.7
  echo:
    commit: a602d9d5def0815cb52bdf6d695ca69cbf0abe3b
    version: 2.28.7
  fiat:
    commit: d0874307a60cbc457616569be910f4142c152586
    version: 2.28.7
  front50:
    commit: 3292cf2715a9e52bb4690601d4fd877407505ced
    version: 2.28.7
  gate:
    commit: c8058f4362f3f4ad108fa146d628a162445c7579
    version: 2.28.7
  igor:
    commit: 00998fa8b33acd6db5ffa8722e37593f608e9f64
    version: 2.28.7
  kayenta:
    commit: 3da923fd822202425b90a181c9734910c5c4a609
    version: 2.28.7
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 27a66c125270377772675b0e24d93566d878cfb9
    version: 2.28.7
  rosco:
    commit: 27d4a2b4a1d5f099b68471303d4fd14af156d46d
    version: 2.28.7
  terraformer:
    commit: ea9b0255b7d446bcbf0f0d4e03fc8699b7508431
    version: 2.28.7
timestamp: "2023-06-01 05:41:58"
version: 2.28.7
</code>
</pre>
</details>

### Armory


#### Armory Echo - 2.28.6...2.28.7


#### Armory Kayenta - 2.28.6...2.28.7

  - chore(cd): update base service version to kayenta:2023.06.01.03.10.17.release-1.28.x (#443)

#### Armory Igor - 2.28.6...2.28.7

  - chore(cd): update base service version to igor:2023.03.27.19.09.31.release-1.28.x (#426)
  - chore(cd): update armory-commons version to 3.11.5 (#450)
  - chore(cd): update armory-commons version to 3.11.6 (#453)

#### Armory Gate - 2.28.6...2.28.7


#### Armory Orca - 2.28.6...2.28.7

  - chore(cd): update base orca version to 2023.05.18.14.27.20.release-1.28.x (#645)

#### Armory Deck - 2.28.6...2.28.7

  - chore(cd): update base deck version to 2023.0.0-20230430115438.release-1.28.x (#1334)

#### Armory Fiat - 2.28.6...2.28.7

  - chore(cd): update armory-commons version to 3.11.5 (#472)
  - chore(cd): update armory-commons version to 3.11.6 (#476)

#### Armory Rosco - 2.28.6...2.28.7


#### Armory Front50 - 2.28.6...2.28.7


#### Terraformer™ - 2.28.6...2.28.7


#### Armory Clouddriver - 2.28.6...2.28.7

  - chore(cd): update base service version to clouddriver:2023.05.30.19.45.25.release-1.28.x (#880)

#### Dinghy™ - 2.28.6...2.28.7



### Spinnaker


#### Spinnaker Echo - 1.28.0


#### Spinnaker Kayenta - 1.28.0


#### Spinnaker Igor - 1.28.0


#### Spinnaker Gate - 1.28.0


#### Spinnaker Orca - 1.28.0


#### Spinnaker Deck - 1.28.0


#### Spinnaker Fiat - 1.28.0


#### Spinnaker Rosco - 1.28.0


#### Spinnaker Front50 - 1.28.0


#### Spinnaker Clouddriver - 1.28.0


