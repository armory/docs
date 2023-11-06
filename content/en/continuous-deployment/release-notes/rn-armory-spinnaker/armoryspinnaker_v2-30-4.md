---
title: v2.30.4 Armory Release (OSS Spinnaker™ v1.30.4)
toc_hide: true
version: 2.30.4
date: 2023-11-06
description: >
  Release notes for Armory Continuous Deployment v2.30.4
---

## 2023/11/06 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a previous working version and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory 2.30.4, use Armory Operator 1.70 or later.

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

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

Reference [Feature Deprecations and end of support]({{< ref "continuous-deployment/feature-status/deprecations/" >}})

## Early access features enabled by default

### Automatically cancel Jenkins jobs

You now have the ability to cancel triggered Jenkins jobs when a Spinnaker pipeline is canceled, giving you more control over your full Jenkins workflow. Learn more about Jenkins + Spinnaker in this [Spinnaker changelog](https://spinnaker.io/changelogs/1.29.0-changelog/#orca).

### Enhanced BitBucket Server pull request handling

Trigger Spinnaker pipelines natively when pull requests are opened in BitBucket with newly added events including PR opened, deleted, and declined. See [Triggering pipelines with Bitbucket Server](https://spinnaker.io/docs/guides/user/pipeline/triggers/bitbucket-events/) in the Spinnaker docs for details

## Early access features enabled manually

### NEW in this release - Helm Parameters

Spinnaker users baking Helm charts can now use SpEL expression parameters for API Version and Kubernetes Version in the Bake Manifest stage so that they can conditionally deploy different versions of artifacts depending on the target cluster API and K8s versions. To learn more about this exciting new feature, visit [Helm Parameters](https://spinnaker.io/docs/guides/user/kubernetes-v2/deploy-helm/).

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

### Run Pipelines-as-Code with permissions scoped to a specific service account

Enhancing Pipelines-as-Code to upsert pipeline using an Orca call instead of a Front50 call, to mimic the calls from Deck. By default, it is disabled. Enabling can be achieved by setting the following in `dinghy.yml`:

```upsertPipelineUsingOrcaTaskEnabled: true```

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

### Igor
Fixed an issue that involved Jenkins backlinks being enabled in Orca. Igor was encountering an issue while attempting to invoke the JenkinsClient.submitDescription method.

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
    version: 2.30.4
  deck:
    commit: 305d4e3ccdd7ad009c14a0093cd64bdb0ad9aeaa
    version: 2.30.4
  dinghy:
    commit: a3b59d9e4b810cc968d0f5e8e8370e1670574768
    version: 2.30.4
  echo:
    commit: 2ef241fd3da29fb70cdb05432d022f0edd752d51
    version: 2.30.4
  fiat:
    commit: 5d44e1f53d2f33b17f8decfb057a18cfe4b6fa08
    version: 2.30.4
  front50:
    commit: 5d9bb31f65f96087be30ce96cea1b6d481a6bef4
    version: 2.30.4
  gate:
    commit: 5758316afba1260d2012730c471fd461819e7f39
    version: 2.30.4
  igor:
    commit: 3123451525458f96548859b9bf2b15c89810f577
    version: 2.30.4
  kayenta:
    commit: 1d2f5193ec681b5122fe7c34da6bbd569da8e0b8
    version: 2.30.4
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: abf688128f3557e53d8873b5f2fe623b1ad478f9
    version: 2.30.4
  rosco:
    commit: 7907c80fd9ca1d956d5927a3e190617671b7e012
    version: 2.30.4
  terraformer:
    commit: 249e7be18074af100212ddd554d9fb35afd65873
    version: 2.30.4
timestamp: "2023-10-19 13:42:07"
version: 2.30.4
</code>
</pre>
</details>

### Armory


#### Dinghy™ - 2.30.3...2.30.4


#### Armory Echo - 2.30.3...2.30.4


#### Armory Clouddriver - 2.30.3...2.30.4


#### Armory Kayenta - 2.30.3...2.30.4


#### Armory Gate - 2.30.3...2.30.4

  - Updating Banner plugin to 0.2.0 (#630) (#631)

#### Terraformer™ - 2.30.3...2.30.4


#### Armory Rosco - 2.30.3...2.30.4

  - chore(cd): update base service version to rosco:2023.10.18.06.02.34.release-1.30.x (#591)

#### Armory Deck - 2.30.3...2.30.4

  - chore(cd): update base deck version to 2023.0.0-20231018060032.release-1.30.x (#1359)

#### Armory Igor - 2.30.3...2.30.4

  - fix: NoSuchMethodError exception in JenkinsClient. (#377) (#528)

#### Armory Orca - 2.30.3...2.30.4

  - chore(cd): update base orca version to 2023.10.09.23.59.23.release-1.30.x (#738)
  - fix(terraformer): Ignoring logs from the Terraformer stage context (#740) (#741)
  - chore(cd): update base orca version to 2023.10.18.06.01.45.release-1.30.x (#752)

#### Armory Fiat - 2.30.3...2.30.4


#### Armory Front50 - 2.30.3...2.30.4



### Spinnaker


#### Spinnaker Echo - 1.30.4


#### Spinnaker Clouddriver - 1.30.4


#### Spinnaker Kayenta - 1.30.4


#### Spinnaker Gate - 1.30.4


#### Spinnaker Rosco - 1.30.4

  - feat(helm/bake): Add additional input fields where we can fill in details of the APIs versions (#1020) (#1029)

#### Spinnaker Deck - 1.30.4

  - feat(helm/bake): Add additional input fields where we can fill in details of the APIs versions (#10036) (#10046)

#### Spinnaker Igor - 1.30.4


#### Spinnaker Orca - 1.30.4

  - fix(front50): teach MonitorPipelineTask to handle missing/null execution ids (#4555) (#4558)
  - feat(helm/bake): Add additional input fields where we can fill in details of the APIs versions (#4546) (#4563)

#### Spinnaker Fiat - 1.30.4


#### Spinnaker Front50 - 1.30.4


