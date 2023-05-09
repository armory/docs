---
title: v2.28.6 Armory Release (OSS Spinnaker™ v1.28.6)
toc_hide: true
version: 2.28.6
date: 2023-04-28
description: >
  Release notes for Armory Continuous Deployment v2.28.6
---

## 2023/04/28 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a previous working version and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory 2.28.6, use Armory Operator 1.70 or later.

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

### Blue/Green(Red/Black) in the non-default namespace for Kubernetes fails

Version 2.28.6 introduced a bug which affects the Blue/Green(Red/Black) deployment strategy in Kubernetes. 

In the `afterStage` during a deployment that uses the Blue/Green (Red/Black) rollout strategy, Spinnaker tries to select the rollout strategy and switch the traffic to the newly deployed rollout strategy. 

However, when Orca sends the API request to Clouddriver for the rollout strategy details, Orca doesn’t include the namespace, which results in failure of the task with `Manifest not found`.

## Early access

### Dynamic Rollback Timeout

To make the dynamic timeout available, you need to enable the feature flag in Orca and Deck.

On the Orca side, the feature flag overrides the default value rollback timeout - 5 min - with a UI input from the user.

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

## Fixed Issues

### Clouddriver
Fixed an issue where customers are unable to use mixed instances and other advanced launch template features. (https://github.com/spinnaker/spinnaker/issues/6755)

### Deck
Fixed an issue where the UI crashes when running pipeline(s) with many stages.

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->




###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.28.6](https://www.spinnaker.io/changelogs/1.28.6-changelog/) changelog for details.

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
    commit: 95037f6d709c2dd03318b78c42c426106ee16a01
    version: 2.28.6
  deck:
    commit: e24db15a97545fd5dda3bdb88a70f640bc5a1104
    version: 2.28.6
  dinghy:
    commit: 912007004f7720b418cd133301c7fb20207e1f2f
    version: 2.28.6
  echo:
    commit: a602d9d5def0815cb52bdf6d695ca69cbf0abe3b
    version: 2.28.6
  fiat:
    commit: 45039aa7952cc409329faa30b8443667566459c1
    version: 2.28.6
  front50:
    commit: 3292cf2715a9e52bb4690601d4fd877407505ced
    version: 2.28.6
  gate:
    commit: c8058f4362f3f4ad108fa146d628a162445c7579
    version: 2.28.6
  igor:
    commit: 60964526194a1273a03a7ade1f8939751e337735
    version: 2.28.6
  kayenta:
    commit: 22fe5d47baacce77917c9026cefdedf91c64a956
    version: 2.28.6
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 06352546281e21597eb59d3e993e842b9259f142
    version: 2.28.6
  rosco:
    commit: 27d4a2b4a1d5f099b68471303d4fd14af156d46d
    version: 2.28.6
  terraformer:
    commit: ea9b0255b7d446bcbf0f0d4e03fc8699b7508431
    version: 2.28.6
timestamp: "2023-04-21 21:46:22"
version: 2.28.6
</code>
</pre>
</details>

### Armory


#### Armory Igor - 2.28.5...2.28.6

  - chore(cd): update base service version to igor:2023.03.02.19.40.25.release-1.28.x (#419)
  - chore(cd): update base service version to igor:2023.03.02.21.16.28.release-1.28.x (#420)

#### Armory Front50 - 2.28.5...2.28.6

  - chore(cd): update base service version to front50:2023.03.27.19.08.11.release-1.28.x (#509)
  - chore(cd): update armory-commons version to 3.11.5 (#534)

#### Armory Gate - 2.28.5...2.28.6

  - chore(cd): update base service version to gate:2023.03.02.19.38.56.release-1.28.x (#523)
  - chore(cd): update base service version to gate:2023.03.02.21.17.09.release-1.28.x (#524)
  - chore(cd): update base service version to gate:2023.03.27.19.10.16.release-1.28.x (#530)
  - chore(cd): update armory-commons version to 3.11.5 (#556)

#### Armory Orca - 2.28.5...2.28.6

  - chore(cd): update base orca version to 2023.03.02.19.46.59.release-1.28.x (#597)
  - chore(cd): update base orca version to 2023.03.02.21.24.49.release-1.28.x (#598)
  - chore(cd): update base orca version to 2023.03.28.15.32.53.release-1.28.x (#608)
  - chore(cd): update armory-commons version to 3.11.5 (#632)

#### Armory Deck - 2.28.5...2.28.6

  - chore(alpine): Upgrade alpine version (backport #1302) (#1303)
  - chore(build): only run security scans on PR merge (backport #1319) (#1327)
  - chore(cd): update base deck version to 2023.0.0-20230410180145.release-1.28.x (#1330)
  - chore(cd): update base deck version to 2023.0.0-20230410180145.release-1.28.x (#1332)
  - chore(cd): update base deck version to 2023.0.0-20230420193214.release-1.28.x (#1333)

#### Terraformer™ - 2.28.5...2.28.6

  - chore(alpine): Update alpine version (backport #497) (#499)

#### Armory Rosco - 2.28.5...2.28.6

  - chore(cd): update base service version to rosco:2023.03.02.19.37.08.release-1.28.x (#500)
  - chore(cd): update armory-commons version to 3.11.5 (#526)
  - chore(cd): update armory-commons version to 3.11.6 (#529)

#### Armory Clouddriver - 2.28.5...2.28.6

  - chore(cd): update base service version to clouddriver:2023.03.02.19.57.01.release-1.28.x (#812)
  - chore(cd): update base service version to clouddriver:2023.03.03.02.32.42.release-1.28.x (#813)
  - chore(cd): update base service version to clouddriver:2023.03.21.20.21.00.release-1.28.x (#821)
  - chore(cd): update base service version to clouddriver:2023.03.23.14.57.28.release-1.28.x (#826)
  - chore(cd): update base service version to clouddriver:2023.03.27.19.24.21.release-1.28.x (#829)
  - chore(cd): update armory-commons version to 3.11.5 (#862)
  - Bumped aws-cli to 1.22 for FIPS compliance (#854) (#863)
  - chore(cd): update armory-commons version to 3.11.6 (#868)

#### Armory Kayenta - 2.28.5...2.28.6

  - chore(cd): update base service version to kayenta:2023.03.03.04.50.48.release-1.28.x (#393)
  - chore(cd): update base service version to kayenta:2023.03.28.19.09.35.release-1.28.x (#398)
  - chore(cd): update armory-commons version to 3.11.5 (#423)
  - chore(cd): update armory-commons version to 3.11.6 (#430)

#### Armory Echo - 2.28.5...2.28.6

  - chore(cd): update base service version to echo:2023.03.02.19.38.24.release-1.28.x (#542)
  - chore(cd): update base service version to echo:2023.03.02.21.17.15.release-1.28.x (#543)
  - chore(cd): update base service version to echo:2023.03.27.19.10.41.release-1.28.x (#550)
  - chore(cd): update armory-commons version to 3.11.5 (#576)
  - chore(cd): update armory-commons version to 3.11.6 (#579)

#### Dinghy™ - 2.28.5...2.28.6

  - chore(dependencies): bumped oss dinghy version to 20230201103309-a73a68c80965 (#480)
  - chore(alpine): Upgrade alpine version (backport #481) (#482)

#### Armory Fiat - 2.28.5...2.28.6

  - chore(cd): update base service version to fiat:2023.03.02.19.37.20.release-1.28.x (#441)
  - chore(cd): update base service version to fiat:2023.03.16.17.55.44.release-1.28.x (#446)


### Spinnaker


#### Spinnaker Igor - 1.28.6

  - chore(dependencies): Autobump korkVersion (#1093)
  - chore(dependencies): Autobump fiatVersion (#1094)

#### Spinnaker Front50 - 1.28.6

  - chore(dependencies): Autobump korkVersion (#1214)
  - chore(dependencies): Autobump fiatVersion (#1215)
  - fix(sql): Populating lastModified field for pipelines when loading objects. (#1220) (#1223)
  - chore(dependencies): Autobump fiatVersion (#1227)

#### Spinnaker Gate - 1.28.6

  - chore(dependencies): Autobump korkVersion (#1624)
  - chore(dependencies): Autobump fiatVersion (#1625)
  - chore(dependencies): Autobump fiatVersion (#1632)

#### Spinnaker Orca - 1.28.6

  - chore(dependencies): Autobump korkVersion (#4405)
  - chore(dependencies): Autobump fiatVersion (#4406)
  - chore(dependencies): Autobump fiatVersion (#4425)
  - Fix/blue green deploy (backport #4414) (#4419)

#### Spinnaker Deck - 1.28.6

  - fix: UI crashes when running pipeline(s) with many stages. (backport #9960) (#9973)
  - fix(aws): Fixing bugs related to clone CX when instance types are incompatible with image/region (backport #9901) (#9975)

#### Spinnaker Rosco - 1.28.6

  - chore(dependencies): Autobump korkVersion (#959)

#### Spinnaker Clouddriver - 1.28.6

  - chore(dependencies): Autobump korkVersion (#5897)
  - chore(dependencies): Autobump fiatVersion (#5898)
  - fix(core): Renamed a query parameter for template tags (#5906) (#5908)
  - chore(aws): Update AWS IAM Authenticator version (#5910)
  - chore(dependencies): Autobump fiatVersion (#5916)

#### Spinnaker Kayenta - 1.28.6

  - chore(dependencies): Autobump orcaVersion (#936)
  - chore(dependencies): Autobump orcaVersion (#943)

#### Spinnaker Echo - 1.28.6

  - chore(dependencies): Autobump korkVersion (#1261)
  - chore(dependencies): Autobump fiatVersion (#1262)
  - chore(dependencies): Autobump fiatVersion (#1270)

#### Spinnaker Fiat - 1.28.6

  - chore(dependencies): Autobump korkVersion (#1026)
  - fix(logs): Redacted secret data in logs. (#1029) (#1030)

