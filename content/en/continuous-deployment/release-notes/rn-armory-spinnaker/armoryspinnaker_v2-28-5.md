---
title: v2.28.5 Armory Release (OSS Spinnaker™ v1.28.5)
toc_hide: true
version: 02.28.5
date: 2023-03-07
description: >
  Release notes for Armory Continuous Deployment v2.28.5
---

## 2023/03/07 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a previous working version and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory 2.28.5, use Armory Operator 1.70 or later.

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

{{< include "breaking-changes/bc-orca-rdbms-configured-utf8.md" >}}

{{< include "breaking-changes/bc-kubectl-120.md" >}}

{{< include "breaking-changes/bc-dinghy-slack.md" >}}

{{< include "breaking-changes/bc-java-tls-mysql.md" >}}

{{< include "breaking-changes/bc-k8s-version-pre1-16.md" >}}

{{< include "breaking-changes/bc-k8s-infra-buttons.md" >}}

{{< include "breaking-changes/bc-git-artifact-constraint.md" >}}

{{< include "breaking-changes/bc-hal-deprecation.md" >}}

{{< include "breaking-changes/bc-plugin-compatibility-2-28-0.md" >}}

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

{{< include "known-issues/ki-fiat-mysql.md" >}}

{{< include "known-issues/ki-app-attr-not-configured.md" >}}

{{< include "known-issues/ki-app-eng-acct-auth.md" >}}

{{< include "known-issues/ki-spel-expr-art-binding.md" >}}

{{< include "known-issues/ki-pipelines-as-code-gh-comments.md" >}}

{{< include "known-issues/ki-secrets-and-spring-cloud.md" >}}

## Early access

### **New in 2.28.5** -> Dynamic Rollback Timeout

To make the dynamic timeout available, you need to enable the feature flag in Orca and Deck.

On the Orca side, the feature flag overrides the default value rollback timeout - 5min - with a UI input from the user.

```
{
  "yaml,"
   "orca.yml,"
  "rollback:"
  "timeout:"
    "enabled: true"
}
```

On the Deck side, the feature flag enhances the Rollback Cluster stage UI with timeout input.

`window.spinnakerSettings.feature.dynamicRollbackTimeout = true;`

The default is used if there is no value set in the UI.

### Pipelines as Code multi-branch enhancement

Now you can configure Pipelines as Code to pull Dinghy files from multiple branches on the same repo. Cut out the tedious task of managing multiple repos; have a single repo for Spinnaker application pipelines. See [Multiple branches]({{< ref "continuous-deployment/armory-admin/dinghy-enable#multiple-branches" >}}) for how to enable and configure this feature.

### Enhanced BitBucket Server pull request handling

Trigger Spinnaker pipelines natively when pull requests are opened in BitBucket with newly added events including PR opened, deleted, and declined. See [Triggering pipelines with Bitbucket Server](https://spinnaker.io/docs/guides/user/pipeline/triggers/bitbucket-events/)in the Spinnaker docs for details.

<!-- Spinnaker docs PR https://github.com/spinnaker/spinnaker.io/pull/285 -->

### Terraform template fix

Armory fixed an issue with SpEL expression failures appearing while using Terraformer to serialize data from a Terraform Plan execution. With this feature flag fix enabled, you will be able to use the Terraform template file provider. Please open a support ticket if you need this fix.

### Automatically Cancel Jenkins Jobs

You now have the ability to cancel triggered Jenkins jobs when a Spinnaker pipeline is canceled, giving you more control over your full Jenkins workflow. Learn more about Jenkins + Spinnaker in this [documentation](https://spinnaker.io/changelogs/1.29.0-changelog/#orca).

## Fixed issues

### Clouddriver
* Revert to using the dockerImage Artifact Replacer for cronjobs
* Two credentials with same accountId confuses EcrImageProvider with different regions

### Permissions
* Fix the deletion of permissions when resource name is uppercase

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->


###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.28.5](https://www.spinnaker.io/changelogs/1.28.5-changelog/) changelog for details.

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
    commit: 49c6d33aebf5c6edcd85904680afac4698e9e208
    version: 2.28.5
  deck:
    commit: bd57caffcdc86c9fb7560e958ba89141372d5d3d
    version: 2.28.5
  dinghy:
    commit: c4ed5b19dbcfefe8dea14cdff7df9a8ab540eba3
    version: 2.28.5
  echo:
    commit: 53bebfd6900b3de124dde043a00d164aa2e50773
    version: 2.28.5
  fiat:
    commit: e5eb6837f87b029248e3068119e05acbb85cf22c
    version: 2.28.5
  front50:
    commit: fab8841982330e7537629c9f24f41205cd5863fd
    version: 2.28.5
  gate:
    commit: 65bdd30238312bbca2dce613825eda7ae88f1dfa
    version: 2.28.5
  igor:
    commit: 61ce26babfcd0bdf62872c24e707ca5b5371a381
    version: 2.28.5
  kayenta:
    commit: 0333b9ed6153acfc090edcfa38e3514439e2863c
    version: 2.28.5
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 37f945ea4ca839267ddd95e436912ef8f82d559e
    version: 2.28.5
  rosco:
    commit: 945f21dec252da7dd2e00c8d23a1687aa3b9841a
    version: 2.28.5
  terraformer:
    commit: 3764e523e17dfdd4cf309dc2bd7c13d9b804f309
    version: 2.28.5
timestamp: "2023-02-23 01:24:13"
version: 2.28.5
</code>
</pre>
</details>

### Armory


#### Terraformer™ - 2.28.4...2.28.5


#### Armory Orca - 2.28.4...2.28.5

  - chore(cd): update base orca version to 2023.02.03.15.05.56.release-1.28.x (#583)

#### Armory Igor - 2.28.4...2.28.5


#### Dinghy™ - 2.28.4...2.28.5


#### Armory Deck - 2.28.4...2.28.5

  - chore(cd): update base deck version to 2023.0.0-20230203161351.release-1.28.x (#1294)

#### Armory Echo - 2.28.4...2.28.5


#### Armory Front50 - 2.28.4...2.28.5


#### Armory Fiat - 2.28.4...2.28.5

  - chore(cd): update base service version to fiat:2023.02.07.18.42.05.release-1.28.x (#430)

#### Armory Rosco - 2.28.4...2.28.5


#### Armory Clouddriver - 2.28.4...2.28.5

  - chore(cd): update base service version to clouddriver:2023.02.15.21.39.25.release-1.28.x (#799)
  - chore(cd): update base service version to clouddriver:2023.02.22.23.00.00.release-1.28.x (#804)

#### Armory Gate - 2.28.4...2.28.5


#### Armory Kayenta - 2.28.4...2.28.5



### Spinnaker


#### Spinnaker Orca - 1.28.5

  - fix(timeout): Added feature flag for rollback timeout ui input. (backport #4383) (#4385)

#### Spinnaker Igor - 1.28.5


#### Spinnaker Deck - 1.28.5

  - fix(timeout): Added feature flag for rollback timeout ui input. (backport #9937) (#9940)

#### Spinnaker Echo - 1.28.5


#### Spinnaker Front50 - 1.28.5


#### Spinnaker Fiat - 1.28.5

  - fix: Should fix the deletion of permissions when resource name is uppercase (backport #1012) (#1013)

#### Spinnaker Rosco - 1.28.5


#### Spinnaker Clouddriver - 1.28.5

  - fix(kubernetes): Revert to using the dockerImage Artifact Replacer for cronjobs (#5876) (#5877)
  - fix(ecr): Two credentials with same accountId confuses EcrImageProvider with different regions (#5885) (#5887)

#### Spinnaker Gate - 1.28.5


#### Spinnaker Kayenta - 1.28.5


