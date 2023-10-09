---
title: v2.30.3 Armory Release (OSS Spinnaker™ v1.30.4)
toc_hide: true
version: 2.30.3
date: 2023-10-09
description: >
  Release notes for Armory Continuous Deployment v2.30.3
---

## 2023/10/09 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a previous working version and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory 2.30.3, use Armory Operator 1.70 or later.

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.>

### Orca requires RDBMS configured for UTF-8 encoding

**Impact**

- 2.28.6 migrates to the AWS MySQL driver from the OSS MySQL drivers.  This change is mostly seamless, but we’ve identified one breaking change.  If your database was created without utf8mb4 you will see failures after this upgrade.  utf8mb4 is the recommended DB format for any Spinnaker database, and we don’t anticipate most users who’ve followed setup instructions to encounter this failure. However, we’re calling out this change as a safeguard.

**Introduced in**: Armory CD 2.28.6

{{< include "breaking-changes/bc-kubectl-120.md" >}}
{{< include "breaking-changes/bc-plugin-compatibility-2-30-0.md" >}}

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

### Artifact Binding

Customers who utilize parent pipelines to provide artifacts to child pipelines may encounter unexpected errors or results in 2.30+ as child pipelines may not resolve those artifacts correctly.

**Affected versions**: Armory CD 2.30.0 and later

### 1.30+ “required artifacts to bind” breaks pipelines

Expected artifacts can be used in automated triggers and stages, and OSS [1.30](https://spinnaker.io/changelogs/1.30.0-changelog/#changes-to-the-way-artifact-constraints-on-triggers-work) changed the way artifact constraints work on triggers. Unfortunately those changes broke the previous behavior when triggering a pipeline from a stage, and this fix restores the previous behavior.

**Affected versions**: Armory CD 2.30.0 and later

### Clouddriver and Spring Cloud

The Spring Boot version has been upgraded, introducing a backwards incompatible change to the way configuration is loaded in Spinnaker. Users will need to set the ***spring.cloud.config.enabled*** property to ***true*** in the service settings of Clouddriver to preserve existing behavior. All of the other configuration blocks remain the same.

**Affected versions**: Armory CD 2.30.0 and later

### SpEL expressions and artifact binding

There is an issue where it appears that SpEL expressions are not being evaluated properly in artifact declarations (such as container images) for events such as the Deploy Manifest stage. What is actually happening is that an artifact binding is overriding the image value.

**Workaround**:

2.27.x or later: Disable artifact binding by adding the following parameter to the stage JSON: `enableArtifactBinding: false`. This setting only binds the version when the tag is missing, such as `image: nginx` without a version number.

**Affected versions**: Armory CD 2.27.x and later

## Deprecations

Reference [Feature Deprecations and end of support](https://docs.armory.io/continuous-deployment/feature-status/deprecations/)

## Early access features enabled by default

### Automatically cancel Jenkins jobs

You now have the ability to cancel triggered Jenkins jobs when a Spinnaker pipeline is canceled, giving you more control over your full Jenkins workflow. Learn more about Jenkins + Spinnaker in this [Spinnaker changelog](https://spinnaker.io/changelogs/1.29.0-changelog/#orca).

### Enhanced BitBucket Server pull request handling

Trigger Spinnaker pipelines natively when pull requests are opened in BitBucket with newly added events including PR opened, deleted, and declined. See [Triggering pipelines with Bitbucket Server](https://spinnaker.io/docs/guides/user/pipeline/triggers/bitbucket-events/) in the Spinnaker docs for details

## Early access features enabled manually

### Dynamic rollback timeout

To make the dynamic timeout available, you need to enable the feature flag in Orca and Deck. You need to add this block to `orca.yml` file if you want to enable the dynamic rollback timeout feature:

```yaml
rollback:
  timeout:
    enabled: true
```

On the Orca side, the feature flag overrides the default value rollback timeout - 5 min - with a UI input from the user.

On the Deck side, the feature flag enhances the Rollback Cluster stage UI with timeout input.

`window.spinnakerSettings.feature.dynamicRollbackTimeout = true;`

The default is used if there is no value set in the UI.

### Pipelines-as-Code PR checks

This feature, when enabled, verifies if the author of a commit that changed app parameters has sufficient WRITE permission for that app. You can specify a list of authors whose permissions are not valid. This option’s purpose is to skip permissions checks for bots and tools.

See [Permissions check for a commit]({{< ref "plugins/pipelines-as-code/install/configure#permissions-check-for-a-commit" >}}) for details.

### Pipelines-as-Code multi-branch enhancement

Now you can configure Pipeline-as-Code to pull Pipelines-as-Code files from multiple branches on the same repo. Cut out the tedious task of managing multiple repos; have a single repo for Spinnaker application pipelines. See [Multiple branches]({{<  ref "plugins/pipelines-as-code/install/configure#multiple-branches" >}}) for how to enable and configure this feature.

### Terraform template fix

Armory fixed an issue with SpEL expression failures appearing while using Terraformer to serialize data from a Terraform Plan execution. With this feature flag fix enabled, you are able to use the Terraform template file provider. Open a support ticket if you need this fix.

## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->

### Front50
* Rectified an issue related to incorrect versions of Google authentication dependencies.

### Clouddriver
* Addressed on issue where Lambda was leaking threads and eventually causing failures.
* Added configurable timeouts for Lambda invocations.

### Deck
* Added decimal support for upper/lower bound ASG tests.

### Gate
* Added the ability to disable the caching filter. By default it is set to on.

### Orca
* Addressed an issue where errors were being generated when deploying an ECSService.

###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.30.4](https://www.spinnaker.io/changelogs/1.30.4-changelog/) changelog for details.

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
    commit: 767aa739e9c38d2ec7822e9e9a1838b69a56d4c0
    version: 2.30.3
  deck:
    commit: 18e1727665cc52111760bf8e7f41cbf23da3b1a9
    version: 2.30.3
  dinghy:
    commit: a3b59d9e4b810cc968d0f5e8e8370e1670574768
    version: 2.30.3
  echo:
    commit: 2ef241fd3da29fb70cdb05432d022f0edd752d51
    version: 2.30.3
  fiat:
    commit: 5d44e1f53d2f33b17f8decfb057a18cfe4b6fa08
    version: 2.30.3
  front50:
    commit: 5d9bb31f65f96087be30ce96cea1b6d481a6bef4
    version: 2.30.3
  gate:
    commit: 04598366642300d6f028df33b6206b5ce75f1038
    version: 2.30.3
  igor:
    commit: f3d890427c79b7db6cf5fcb681e30542df97ff7c
    version: 2.30.3
  kayenta:
    commit: 1d2f5193ec681b5122fe7c34da6bbd569da8e0b8
    version: 2.30.3
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: ba62a86ef3af0007506b589a4272e3c2e03de00b
    version: 2.30.3
  rosco:
    commit: a2b4662a40281e553de2182b680d5fd7e6bc3955
    version: 2.30.3
  terraformer:
    commit: 249e7be18074af100212ddd554d9fb35afd65873
    version: 2.30.3
timestamp: "2023-09-29 15:15:45"
version: 2.30.3
</code>
</pre>
</details>

### Armory


#### Armory Gate - 2.30.2...2.30.3

  - chore(cd): update base service version to gate:2023.09.01.01.26.23.release-1.30.x (#608)
  - chore(cd): update base service version to gate:2023.09.07.17.47.28.release-1.30.x (#612)

#### Armory Rosco - 2.30.2...2.30.3

  - chore(ci): removed aquasec scan action (#565) (#568)

#### Armory Orca - 2.30.2...2.30.3

  - chore(cd): update base orca version to 2023.09.07.17.59.31.release-1.30.x (#693)
  - chore(ci): removed aquasec scan action (#695) (#706)
  - chore(cd): update base orca version to 2023.09.26.15.03.20.release-1.30.x (#721)

#### Armory Fiat - 2.30.2...2.30.3

  - chore(ci): removed aquasec scan action (#523) (#526)

#### Armory Echo - 2.30.2...2.30.3

  - chore(cd): update base service version to echo:2023.09.07.17.49.13.release-1.30.x (#616)
  - chore(ci): removed aquasec scan action (#618) (#622)

#### Dinghy™ - 2.30.2...2.30.3

  - chore(ci): removed aquasec scan action (#489) (#492)
  - chore(ci): removing aquasec scans for any push (#497) (#499)
  - chore(log): Bumped up dinghy and plank versions. (backport #490) (#505)

#### Armory Kayenta - 2.30.2...2.30.3

  - chore(ci): removed aquasec scan action (#469) (#471)

#### Armory Clouddriver - 2.30.2...2.30.3

  - chore(cd): update base service version to clouddriver:2023.08.29.09.35.30.release-1.30.x (#945)
  - chore(cd): update base service version to clouddriver:2023.09.07.19.02.07.release-1.30.x (#953)
  - chore(cd): update base service version to clouddriver:2023.09.07.22.04.28.release-1.30.x (#955)
  - chore(cd): update base service version to clouddriver:2023.09.08.02.48.03.release-1.30.x (#958)
  - chore(cd): update base service version to clouddriver:2023.09.08.03.51.25.release-1.30.x (#959)
  - chore(cd): update base service version to clouddriver:2023.09.08.04.42.03.release-1.30.x (#962)
  - chore(cd): update base service version to clouddriver:2023.09.08.05.40.38.release-1.30.x (#963)
  - chore(cd): update base service version to clouddriver:2023.09.08.14.33.30.release-1.30.x (#965)
  - chore(cd): update base service version to clouddriver:2023.09.16.22.42.11.release-1.30.x (#976)
  - chore(cd): update base service version to clouddriver:2023.09.20.19.03.35.release-1.30.x (#980)
  - chore(ci): removed aquasec scan action (#971) (#983)
  - fix: CVE-2023-37920 (#977) (#992)

#### Armory Front50 - 2.30.2...2.30.3

  - chore(cd): update base service version to front50:2023.09.07.17.50.48.release-1.30.x (#588)
  - chore(ci): removed aquasec scan action (#590) (#594)
  - chore(cd): update base service version to front50:2023.09.25.18.58.31.release-1.30.x (#601)
  - fix(dependencies): match google cloud storage version to this set in OSS, and bump OSS front50 version. (#602)

#### Terraformer™ - 2.30.2...2.30.3

  - chore(ci): removing aquasec scans on push (#517) (#519)
  - chore(ci): removed aquasec scan action (#510) (#512)

#### Armory Deck - 2.30.2...2.30.3

  - chore(cd): update base deck version to 2023.0.0-20230918174859.release-1.30.x (#1342)
  - chore(cd): update base deck version to 2023.0.0-20230920215154.release-1.30.x (#1343)
  - chore(ci): removed aquasec scan action (#1340) (#1345)
  - chore(ci): removing docker build and aquasec scans (#1350)

#### Armory Igor - 2.30.2...2.30.3

  - chore(cd): update base service version to igor:2023.09.07.17.50.00.release-1.30.x (#491)
  - chore(ci): removed aquasec scan action (#495) (#508)


### Spinnaker


#### Spinnaker Gate - 1.30.4

  - fix(cachingFilter: Allow disabling the content caching filter (#1699) (#1700)
  - chore(dependencies): Autobump fiatVersion (#1708)

#### Spinnaker Rosco - 1.30.4


#### Spinnaker Orca - 1.30.4

  - chore(dependencies): Autobump fiatVersion (#4520)
  - fix(vpc): add data annotation to vpc (#4534) (#4536)
  - fix: duplicate entry exception for correlation_ids table. (#4521) (#4532)

#### Spinnaker Fiat - 1.30.4


#### Spinnaker Echo - 1.30.4

  - chore(dependencies): Autobump fiatVersion (#1338)

#### Spinnaker Kayenta - 1.30.4


#### Spinnaker Clouddriver - 1.30.4

  - chore(dependencies): Autobump fiatVersion (#6017)
  - chore(gha): update to docker/login-action@v2 to stay up to date (#5920) (#6020)
  - chore(deps): bump actions/cache from 2 to 3 (#5926) (#6022)
  - chore(deps): bump actions/checkout from 2 to 3 (#5924) (#6024)
  - chore(gha): replace action for creating github releases (backport #5929) (#6026)
  - chore(deps): bump actions/setup-java from 2 to 3 (#5928) (#6029)
  - chore(deps): bump docker/build-push-action from 3 to 4 (#5927) (#6030)
  - chore(gha): replace deprecated set-output commands with environment files (#5930) (#6032)
  - fix: Fix docker build in GHA by removing some of the GHA tools (#6033) (#6035)
  - feat(lambda): Lambda calls default timeout after 50 seconds causing longer running lambdas to fail.  This adds configurable timeouts for lambda invocations (#6041) (#6044)
  - fix(lambda): Lambda is leaking threads on agent refreshes.  remove the custom threadpool (#6048) (#6051)

#### Spinnaker Front50 - 1.30.4

  - chore(dependencies): Autobump fiatVersion (#1388)
  - fix(dependency): fix dependency version leak of google-api-services-storage from kork in front50-web (#1302) (#1393)

#### Spinnaker Deck - 1.30.4

  - Revert "fix(core): conditionally hide expression evaluation warning messages (#9771)" (#10021) (#10024)
  - fix: Scaling bounds should parse float not int (#10026) (#10031)

#### Spinnaker Igor - 1.30.4

  - chore(dependencies): Autobump fiatVersion (#1167)

