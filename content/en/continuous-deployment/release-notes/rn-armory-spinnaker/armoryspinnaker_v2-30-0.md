---
title: v2.30.0 Armory Release (OSS Spinnaker™ v1.30.2)
toc_hide: true
version: 02.30.0
date: 2023-08-09
description: >
  Release notes for Armory Continuous Deployment v2.30.0
---

## 2023/08/09 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a previous working version and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory 2.30.0, use Armory Operator 1.70 or later.

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Armory Compatibility Matrix
Please consult the [Armory Compatibility Matrix](https://docs.armory.io/continuous-deployment/feature-status/continuous-deployment-matrix/) for information about support and compatibility for Armory Continuous Deployment as well as the products and platforms with which it integrates.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->
> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

### Orca requires RDBMS configured for UTF-8 encoding
**Impact**

- 2.28.6 migrates to the AWS MySQL driver from the OSS MySQL drivers.  This change is mostly seamless, but we’ve identified one breaking change.  If your database was created without utf8mb4 you will see failures after this upgrade.  utf8mb4 is the recommended DB format for any Spinnaker database, and we don’t anticipate most users who’ve followed setup instructions to encounter this failure. However, we’re calling out this change as a safeguard.

**Introduced in**: Armory CD 2.28.6

{{< include "breaking-changes/bc-kubectl-120.md" >}}
{{< include "breaking-changes/bc-k8s-v2-provider-aws-iam-auth.md" >}}
{{< include "breaking-changes/bc-plugin-compatibility-2-28-0.md" >}}


## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

### 1.30+ “required artifacts to bind” breaks pipelines
Expected artifacts can be used in automated triggers and stages, and OSS [1.30](https://spinnaker.io/changelogs/1.30.0-changelog/#changes-to-the-way-artifact-constraints-on-triggers-work) changed the way artifact constraints work on triggers. Unfortunately those changes broke the previous behavior when triggering a pipeline from a stage, and this fix restores the previous behavior.

**Affected versions**: Armory CD 2.30.0

### Clouddriver and Spring Cloud
The Spring Boot version has been upgraded, introducing a backwards incompatible change to the way configuration is loaded in Spinnaker. Users will need to set the ***spring.cloud.config.enabled*** property to ***true*** in the service settings of Clouddriver to preserve existing behavior. All of the other configuration blocks remain the same.

**Affected versions**: Armory CD 2.30.0

### Application attributes section displays “This Application has not been configured”
There is a known issue that relates to the **Application Attributes** section under the **Config** menu. An application that was already created and configured in Spinnaker displays the message, “This application has not been configured.” While the information is missing, there is no functional impact.

**Affected versions**: Armory CD 2.28.0 and later

### SpEL expressions and artifact binding
There is an issue where it appears that SpEL expressions are not being evaluated properly in artifact declarations (such as container images) for events such as the Deploy Manifest stage. What is actually happening is that an artifact binding is overriding the image value.

**Workaround**:
2.27.x or later: Disable artifact binding by adding the following parameter to the stage JSON: `enableArtifactBinding: false`.
This setting only binds the version when the tag is missing, such as `image: nginx` without a version number.

**Affected versions**: Armory CD 2.27.x and later

## Deprecations
Reference [Feature Deprecations and end of support](https://docs.armory.io/continuous-deployment/feature-status/deprecations/)

## Early access enabled by default

### **Automatically Cancel Jenkins Jobs**

You now have the ability to cancel triggered Jenkins jobs when a Spinnaker pipeline is canceled, giving you more control over your full Jenkins workflow. Learn more about Jenkins + Spinnaker in this [Spinnaker changelog.](https://spinnaker.io/changelogs/1.29.0-changelog/#orca).

### **Enhanced BitBucket Server pull request handling**

Trigger Spinnaker pipelines natively when pull requests are opened in BitBucket with newly added events including PR opened, deleted, and declined. See [Triggering pipelines with Bitbucket Server](https://spinnaker.io/docs/guides/user/pipeline/triggers/bitbucket-events/) in the Spinnaker docs for details.

## Early Access

### **Dynamic Rollback Timeout**

To make the dynamic timeout available, you need to enable the feature flag in Orca and Deck. You need to add this block to `orca.yml` file if you want to enable the dynamic rollback timeout feature:

```

rollback:
  timeout:
    enabled: true

```

On the Orca side, the feature flag overrides the default value rollback timeout - 5 min - with a UI input from the user.

On the Deck side, the feature flag enhances the Rollback Cluster stage UI with timeout input.

`window.spinnakerSettings.feature.dynamicRollbackTimeout = true;`

The default is used if there is no value set in the UI.

### Dinghy PR Checks

This feature, when enabled, verifies if the author of a commit that changed app parameters has sufficient WRITE permission for that app. You can specify a list of authors whose permissions are not valid. This option’s purpose is to skip permissions checks for bots and tools.

See [Permissions check for a commit]({{< ref "plugins/pipelines-as-code/install/configure#permissions-check-for-a-commit" >}}) for details.

### **Terraform template fix**

Armory fixed an issue with SpEL expression failures appearing while using Terraformer to serialize data from a Terraform Plan execution. With this feature flag fix enabled, you will be able to use the Terraform template file provider. Please open a support ticket if you need this fix.

### **Pipelines as Code multi-branch enhancement**

Now you can configure Pipelines as Code to pull Dinghy files from multiple branches on the same repo. Cut out the tedious task of managing multiple repos; have a single repo for Spinnaker application pipelines. See [Multiple branches]({{<  ref "plugins/pipelines-as-code/install/configure#multiple-branches" >}}) for how to enable and configure this feature.

## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->

### Cloudddriver
* New mechanism to cache applications known to Front50. See https://spinnaker.io/changelogs/1.29.0-changelog/#clouddriver

### Deck
* Fixed an issue where the UI was crashing  when running pipeline(s) with many stages. This change prevents iterating over child nodes as it has already been checked and as a result greatly reduces the number of interactions and increases speed.

### Echo
* Fixed an issue where Echo was failing to handle /webhooks/git/github requests

### Fiat
* New way to control how Fiat queries Clouddriver during a role sync (performance improvement)
    - https://spinnaker.io/changelogs/1.29.0-changelog/#fiat
* Addressed an issue related to concurrent sync calls causing memory exceptions and lack of available SQL connections. The fix prevents a new synchronization from starting if one is already in progress.

### Front50
* Resolved a performance regression where Front50 cached all pipeline configs on every sync, causing unnecessarily high service load

### Gate
https://github.com/spinnaker/gate/pull/1610 expands support for adding request headers to the response header. Previously limited to X-SPINNAKER-REQUEST-ID, it’s now possible to specify any fields with a X-SPINNAKER prefix via the new interceptors.responseHeader.fields configuration property. The default value is X-SPINNAKER-REQUEST-ID to preserve the previous functionality.
```
#gate.yml

interceptors:
  responseHeader:
    fields:
      - X-SPINNAKER-REQUEST-ID
      - X-SPINNAKER-USER
```
### Igor
- New stop API endpoint
    - https://spinnaker.io/changelogs/1.29.0-changelog/#igor

### Kayenta
* Implemented a MySQL data source for storage

### Azure Baking

### AWS EC2 improvements, including UI changes
* Improvements to AWS EC2 instance types API integration: The integration previously used AWS EC2 pricing docs to retrieve EC2 instance types and information. It was replaced with [AWS EC2 describe-instance-types API instead](https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-instance-types.html).
* Improvements to /instanceTypes API: Addition of instance type metadata/ information to API response. See before-after at (https://github.com/spinnaker/clouddriver/pull/5609).
* Changes to /images API:
	◦	Addition of architecture type to images API (used to filter out incompatible instance types in Deck). 
	◦	Images Caching agentType was modified to include the account information. Due to this change, your cache might still contain entries for the old cache keys [as seen in Redis](https://github.com/spinnaker/clouddriver/pull/5609#discussion_r951929849). These old keys will need to be cleaned up manually after upgrading to v1.29, if they are set to never expire.
  example: 
  * *old key: com.netflix.spinnaker.clouddriver.aws.provider.AwsInfrastructureProvider:AmazonInstanceTypeCachingAgent/eu-central-1:relationships*
  * *new key: com.netflix.spinnaker.clouddriver.aws.provider.AwsInfrastructureProvider:AmazonInstanceTypeCachingAgent/my-aws-devel-acct/eu-central-1:relationships*

UI Changes
- Displaying instance type info in Custom instance type selector in 2 places:
  - As a tooltip for already selected instance types
  - Enhanced drop down for list of available instance types
- Adding filtering capability to the drop down in custom instance type selector. Filters implemented:
  - instance family / size / type e.g. c3/ large/ c3.large
  - min vcpu e.g. 16vcpu
  - min memory e.g 32gib
  - instance storage type e.g. ssd, hdd
  - spot support
  - ebs support
  - gpu support
  - current generation v/s old generation like *'currentGen' / 'oldGen'

### Kubernetes
Change 'red/black' to 'blue/green' in Spinnaker. Users coming to Spinnaker are now more familiar with Blue/Green industry terminology than the Netflix-specific phrasing Red/Black.

* The Red/Black rollout strategy is marked as deprecated in the UI.
* A Blue/Green rollout strategy is added that is functionally equivalent to the Red/Black rollout strategy. Changes made in Clouddriver and Orca.
* Introduce a pipeline validator in Front50 that validates if red/black is used when creating/updating a Kubernetes pipeline. For now, it is logging a warning, but it will fail when we remove the red/black Kubernetes traffic management strategy.

Red/Black to Blue/Green migration details:
* Front50 already supports migrations but you need to be enable it by adding migrations.enabled=true in your Front50 config. When Front50 starts, it automatically migrates existing pipelines using red/black to blue/green.
* *If you do not enable migration*, red/black continues to work until the Spinnaker community decides to remove red/black.

### Artifact Handling
Changes to the way artifact constraints on triggers work
If you have a pipeline with multiple triggers using different artifact constraints/expected artifacts, these have for a while been evaluated in an unexpected matter. To learn more, visit 
https://spinnaker.io/changelogs/1.30.0-changelog/#changes-to-the-way-artifact-constraints-on-triggers-work.

### Spring Boot 2.4 changes
* Read more about Spring boot in the [1.30 Release notes](https://spinnaker.io/changelogs/1.30.0-changelog/#spring-boot-24)

###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.30.2](https://www.spinnaker.io/changelogs/1.30.2-changelog/) changelog for details.


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
    commit: 5dfa9fe9e2285a875f0f39cb29e46a6470f34665
    version: 2.30.0
  deck:
    commit: a5ae63596f79df5c3dd4999253a9ed72dece7de3
    version: 2.30.0
  dinghy:
    commit: 5250de80948732c8caac6ffc5293a8af80a63a0f
    version: 2.30.0
  echo:
    commit: 86c586f7c523a4c320189eff00731271b8d31e32
    version: 2.30.0
  fiat:
    commit: 0150c145b239568c294ab88251dc2fbb20ace279
    version: 2.30.0
  front50:
    commit: bdbf36960c30b3599bdf0fa31620dfaf08927074
    version: 2.30.0
  gate:
    commit: 679225a36b20fe39ecb175813929972c497d1a92
    version: 2.30.0
  igor:
    commit: 020e01bbeaadf3d5eb745b33180bd1011c4b068f
    version: 2.30.0
  kayenta:
    commit: 16aa401c453de95b670524b491cbaa682bcf2817
    version: 2.30.0
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 25ccf32473a809846c1c3d4c967bb05ad9622549
    version: 2.30.0
  rosco:
    commit: c72a24d8c560ea7b27fd8ecf45c9c11ca63682f4
    version: 2.30.0
  terraformer:
    commit: 418546f57129380e383e62b6178ed582e6d64a93
    version: 2.30.0
timestamp: "2023-05-31 22:11:31"
version: 2.30.0
</code>
</pre>
</details>

### Armory


#### Armory Clouddriver - 2.28.0...2.30.0

  - chore(cd): update base service version to clouddriver:2022.07.07.23.26.37.release-1.28.x (#688)
  - chore(cd): update base service version to clouddriver:2022.07.05.23.42.44.release-1.28.x (#685)
  - chore(cd): update base service version to clouddriver:2022.06.14.19.25.36.release-1.28.x (#674)
  - chore(cd): update base service version to clouddriver:2022.06.03.22.38.58.release-1.28.x (#667)
  - chore(cd): update armory-commons version to 3.11.4 (#655)
  - chore(cd): update base service version to clouddriver:2022.05.18.17.04.07.release-1.28.x (#653)
  - chore(cd): update base service version to clouddriver:2022.05.18.16.35.10.release-1.28.x (#652)
  - chore(cd): update base service version to clouddriver:2022.05.17.21.10.01.release-1.28.x (#651)
  - chore(gradle): removing spinnaker gradle fix version (#647) (#648)
  - feat(iam): use aws-mysql-jdbc (#586) (#617)
  - chore(cd): update armory-commons version to 3.11.3 (#642)
  - chore(build): upgrade armory settings (#640) (#641)
  - chore(cd): update armory-commons version to 3.11.2 (#638)
  - fix(build): clean mergify conflict (#637)
  - fix(build): pass version to nebula, remove publish devSnapshots (#630) (#636)
  - chore(cd): update base service version to clouddriver:2022.04.27.05.22.30.release-1.28.x (#634)
  - chore(cd): update base service version to clouddriver:2022.04.27.03.50.34.release-1.28.x (#631)
  - chore(cd): update base service version to clouddriver:2022.04.26.15.47.37.release-1.28.x (#627)
  - chore(cd): update base service version to clouddriver:2022.04.26.14.54.42.release-1.28.x (#625)
  - chore(cd): update armory-commons version to 3.11.1 (#624)
  - Updating kubectl version to match OSS (#608) (#609)
  - chore(cd): update base service version to clouddriver:2022.04.09.02.50.33.release-1.28.x (#604)
  - chore(cd): update base service version to clouddriver:2022.04.09.00.37.02.release-1.28.x (#603)
  - chore(cd): update base service version to clouddriver:2022.04.04.16.50.07.master (#600)
  - chore(cd): update base service version to clouddriver:2022.04.04.21.25.36.master (#601)
  - chore(cd): update base service version to clouddriver:2022.04.08.14.55.54.master (#602)
  - chore(cd): update base service version to clouddriver:2022.04.11.10.08.50.master (#605)
  - chore(cd): update base service version to clouddriver:2022.04.12.02.29.25.master (#606)
  - Updating kubectl version to match OSS (#608)
  - chore(cd): update base service version to clouddriver:2022.04.13.01.25.37.master (#612)
  - chore(cd): update base service version to clouddriver:2022.04.13.19.21.38.master (#613)
  - chore(cd): update base service version to clouddriver:2022.04.20.15.17.44.master (#620)
  - chore(cd): update base service version to clouddriver:2022.04.21.16.12.01.master (#622)
  - chore(cd): update base service version to clouddriver:2022.04.27.03.25.12.master (#629)
  - chore(cd): update base service version to clouddriver:2022.04.27.04.54.32.master (#633)
  - fix(build): pass version to nebula, remove publish devSnapshots (#630)
  - chore(cd): update base service version to clouddriver:2022.04.30.11.45.33.master (#639)
  - chore(build): upgrade armory settings (#640)
  - chore(cd): update base service version to clouddriver:2022.05.12.00.27.53.master (#643)
  - chore(cd): update base service version to clouddriver:2022.05.13.00.04.59.master (#644)
  - chore(gradle): removing spinnaker gradle fix version (#647)
  - chore(cd): update base service version to clouddriver:2022.05.16.18.23.27.master (#649)
  - chore(cd): update base service version to clouddriver:2022.05.18.17.57.41.master (#654)
  - fix(iam-auth): Fixes iam authenticator to dynamic check apis (#618)
  - chore(cd): update base service version to clouddriver:2022.05.19.21.46.28.master (#657)
  - chore(build): updating armory-commons (#656)
  - chore(cd): update base service version to clouddriver:2022.05.20.17.04.12.master (#658)
  - feat(iam): use aws-mysql-jdbc (backport #586) (#646)
  - chore(cd): update base service version to clouddriver:2022.05.24.02.37.11.master (#661)
  - chore(cd): update base service version to clouddriver:2022.05.27.00.24.49.master (#662)
  - chore(cd): update base service version to clouddriver:2022.05.27.15.27.14.master (#663)
  - chore(cd): update base service version to clouddriver:2022.05.27.17.07.39.master (#664)
  - chore(cd): update base service version to clouddriver:2022.06.01.18.30.18.master (#665)
  - chore(cd): update base service version to clouddriver:2022.06.03.19.48.46.master (#666)
  - chore(cd): update base service version to clouddriver:2022.06.06.17.18.06.master (#668)
  - chore(cd): update base service version to clouddriver:2022.06.07.17.42.23.master (#669)
  - chore(cd): update base service version to clouddriver:2022.06.08.20.20.30.master (#670)
  - chore(cd): update base service version to clouddriver:2022.06.11.16.26.30.master (#671)
  - chore(cd): update base service version to clouddriver:2022.06.14.18.16.06.master (#672)
  - chore(cd): update base service version to clouddriver:2022.06.14.18.57.25.master (#673)
  - chore(cd): update base service version to clouddriver:2022.06.14.23.00.38.master (#675)
  - chore(cd): update base service version to clouddriver:2022.06.15.23.35.34.master (#676)
  - chore(cd): update base service version to clouddriver:2022.06.16.18.28.41.master (#677)
  - chore(cd): update base service version to clouddriver:2022.06.16.22.59.43.master (#678)
  - chore(cd): update base service version to clouddriver:2022.06.18.02.14.56.master (#679)
  - chore(cd): update base service version to clouddriver:2022.06.21.14.10.58.master (#680)
  - chore(cd): update base service version to clouddriver:2022.06.23.19.56.04.master (#681)
  - chore(cd): update base service version to clouddriver:2022.06.24.01.25.13.master (#682)
  - chore(cd): update base service version to clouddriver:2022.07.05.21.07.29.master (#683)
  - chore(cd): update base service version to clouddriver:2022.07.05.23.42.48.master (#684)
  - chore(dockerfile): upgrade to latest alpine image (#689)
  - chore(cd): update base service version to clouddriver:2022.07.25.16.51.20.master (#693)
  - chore(cd): update base service version to clouddriver:2022.07.27.23.51.58.master (#694)
  - Updating aws-iam-authenticator to 0.5.9 due to CVE-2022-2385 (#692)
  - chore(cd): update base service version to clouddriver:2022.08.01.21.36.35.master (#697)
  - chore(cd): update base service version to clouddriver:2022.08.02.14.20.57.master (#698)
  - chore(cd): update base service version to clouddriver:2022.08.03.02.29.38.master (#699)
  - chore(cd): update base service version to clouddriver:2022.08.08.14.56.30.master (#702)
  - chore(cd): update base service version to clouddriver:2022.08.15.19.16.42.master (#705)
  - chore(cd): update base service version to clouddriver:2022.08.15.19.51.15.master (#706)
  - chore(cd): update base service version to clouddriver:2022.08.16.15.50.05.master (#707)
  - chore(cd): update base service version to clouddriver:2022.08.22.06.25.08.master (#710)
  - chore(cd): update base service version to clouddriver:2022.08.24.14.21.39.master (#711)
  - chore(cd): update base service version to clouddriver:2022.08.24.22.25.06.master (#712)
  - chore(cd): update base service version to clouddriver:2022.08.25.19.55.27.master (#713)
  - chore(cd): update base service version to clouddriver:2022.09.02.00.09.48.master (#714)
  - chore(cd): update base service version to clouddriver:2022.09.02.01.00.53.master (#715)
  - chore(cd): update base service version to clouddriver:2022.09.02.14.53.21.master (#716)
  - chore(cd): update base service version to clouddriver:2022.09.02.18.17.14.master (#717)
  - chore(cd): update base service version to clouddriver:2022.09.09.19.50.46.master (#718)
  - chore(cd): update base service version to clouddriver:2022.09.12.18.59.36.master (#719)
  - chore(cd): update base service version to clouddriver:2022.09.13.20.43.09.master (#720)
  - chore(cd): update base service version to clouddriver:2022.09.14.16.30.11.master (#721)
  - chore(cd): update base service version to clouddriver:2022.09.27.19.09.40.master (#722)
  - chore(cd): update base service version to clouddriver:2022.10.06.16.45.47.master (#725)
  - chore(cd): update base service version to clouddriver:2022.10.10.17.09.27.master (#726)
  - chore(cd): update base service version to clouddriver:2022.10.10.18.27.46.master (#727)
  - chore(cd): update base service version to clouddriver:2022.10.19.17.17.54.master (#730)
  - chore(cd): update base service version to clouddriver:2022.10.21.21.59.52.master (#731)
  - chore(cd): update base service version to clouddriver:2022.10.27.13.47.05.master (#732)
  - chore(cd): update base service version to clouddriver:2022.11.01.17.45.19.master (#734)
  - chore(cd): update base service version to clouddriver:2022.11.02.03.38.36.master (#735)
  - chore(cd): update base service version to clouddriver:2022.11.02.15.17.26.master (#736)
  - fix(azure): forcing reactor version for azure sdk (#737)
  - chore(cd): update base service version to clouddriver:2022.11.16.18.17.39.master (#739)
  - chore(cd): update base service version to clouddriver:2022.11.17.00.46.42.master (#740)
  - chore(cd): update base service version to clouddriver:2022.11.17.17.33.46.master (#743)
  - chore(cd): update base service version to clouddriver:2022.11.19.02.08.13.master (#745)
  - chore(cd): update base service version to clouddriver:2022.11.19.17.07.08.master (#746)
  - chore(cd): update base service version to clouddriver:2022.11.22.17.44.20.master (#747)
  - chore(cd): update base service version to clouddriver:2022.11.24.16.35.57.master (#748)
  - chore(cd): update base service version to clouddriver:2022.11.25.06.30.21.master (#749)
  - chore(cd): update base service version to clouddriver:2022.12.02.21.49.55.master (#753)
  - chore(cd): update base service version to clouddriver:2022.12.07.16.15.33.master (#754)
  - chore(cd): update base service version to clouddriver:2022.12.07.21.56.34.master (#755)
  - chore(cd): update base service version to clouddriver:2022.12.09.01.26.47.master (#756)
  - chore(cd): update base service version to clouddriver:2022.12.09.02.30.30.master (#757)
  - chore(cd): update base service version to clouddriver:2022.12.09.03.36.49.master (#758)
  - chore(cd): update base service version to clouddriver:2022.12.09.06.40.08.master (#759)
  - chore(cd): update base service version to clouddriver:2022.12.09.17.04.05.master (#760)
  - chore(cd): update base service version to clouddriver:2022.12.15.17.02.20.master (#762)
  - chore(cd): update base service version to clouddriver:2022.12.21.23.32.36.master (#763)
  - chore(cd): update base service version to clouddriver:2022.12.22.05.26.04.master (#764)
  - chore(cd): update base service version to clouddriver:2022.12.22.12.32.04.master (#765)
  - chore(cd): update base service version to clouddriver:2023.01.01.17.38.55.master (#766)
  - fix(cloudfoundry): upgrading armory-commons to use vault secrets (#767)
  - chore(cd): update base service version to clouddriver:2023.01.04.21.11.15.master (#768)
  - fix(sql): forcing liquibase version (#770)
  - feat(google): Updated google cloud SDK to support GKE >1.26 (#769)
  - update(docs): Updated docs on versions (#761)
  - chore(cd): update base service version to clouddriver:2023.01.11.18.48.59.master (#775)
  - chore(cd): update base service version to clouddriver:2023.01.12.22.30.21.master (#776)
  - chore(cd): update base service version to clouddriver:2023.01.13.22.46.13.master (#777)
  - chore(cd): update base service version to clouddriver:2023.01.27.00.21.34.master (#783)
  - chore(cd): update base service version to clouddriver:2023.01.30.16.08.58.master (#785)
  - chore(cd): update base service version to clouddriver:2023.01.30.17.21.25.master (#786)
  - chore(cd): update base service version to clouddriver:2023.02.01.16.00.05.master (#788)
  - chore(cd): update base service version to clouddriver:2023.02.08.20.35.59.master (#790)
  - chore(cd): update base service version to clouddriver:2023.02.08.23.13.15.master (#791)
  - chore(cd): update base service version to clouddriver:2023.02.09.00.22.48.master (#792)
  - chore(cd): update base service version to clouddriver:2023.02.09.01.38.58.master (#793)
  - chore(cd): update base service version to clouddriver:2023.02.09.05.02.13.master (#794)
  - chore(cd): update base service version to clouddriver:2023.02.09.07.11.08.master (#795)
  - chore(cd): update base service version to clouddriver:2023.02.14.05.08.28.master (#796)
  - chore(cd): update base service version to clouddriver:2023.02.15.21.12.08.master (#798)
  - chore(cd): update base service version to clouddriver:2023.02.16.16.45.16.master (#801)
  - chore(cd): update base service version to clouddriver:2023.02.20.20.42.57.master (#802)
  - chore(cd): update base service version to clouddriver:2023.02.20.21.51.30.master (#803)
  - chore(cd): update base service version to clouddriver:2023.02.22.20.12.12.master (#806)
  - chore(cd): update base service version to clouddriver:2023.02.23.17.25.27.master (#807)
  - chore(cd): update base service version to clouddriver:2023.02.23.21.38.10.master (#808)
  - chore(cd): update base service version to clouddriver:2023.03.02.12.13.06.master (#810)
  - chore(cd): update base service version to clouddriver:2023.03.09.16.05.50.master (#816)
  - chore(cd): update base service version to clouddriver:2023.03.13.22.28.44.master (#817)
  - chore(cd): update base service version to clouddriver:2023.03.18.00.04.47.master (#818)
  - chore(cd): update armory-commons version to 3.13.1 (#837)
  - chore(cd): update base service version to clouddriver:2023.03.24.23.48.26.release-1.30.x (#839)
  - chore(cd): update base service version to clouddriver:2023.04.05.14.02.06.release-1.30.x (#856)
  - chore(cd): update base service version to clouddriver:2023.04.06.10.03.44.release-1.30.x (#859)
  - chore(cd): update base service version to clouddriver:2023.04.07.02.16.05.release-1.30.x (#860)
  - chore(cd): update armory-commons version to 3.13.2 (#861)
  - chore(cd): update armory-commons version to 3.13.3 (#867)
  - chore(cd): update armory-commons version to 3.13.4 (#869)
  - chore(cd): update armory-commons version to 3.13.5 (#874)
  - chore(cd): update base service version to clouddriver:2023.05.30.19.45.40.release-1.30.x (#882)

#### Armory Deck - 2.28.0...2.30.0

  - fix(font): Switch font to Sans3 (backport #1239) (#1240)
  - chore(cd): update base deck version to 2022.0.0-20220713154638.release-1.28.x (#1237)
  - chore(cd): update base deck version to 2022.0.0-20220706232954.release-1.28.x (#1234)
  - chore(cd): update base deck version to 2022.0.0-20220705204056.release-1.28.x (#1233)
  - fix(expandnav): Update recoil version to the same version as in oss project (backport #1224) (#1225)
  - chore(cd): update base deck version to 2022.0.0-20220606173439.release-1.28.x (#1223)
  - chore(cd): update base deck version to 2022.0.0-20220524093036.release-1.28.x (#1221)
  - docs(tf): improve backend artifact help txt for the stage (#1113)
  - fix(expandnav): Update recoil version to the same version as in oss project (#1224)
  - fix(font): Switch font to Sans3 (#1239)
  - feat(armory): Add quickspin feature flag (#1249)
  - style(logo): Changed Armory logo (#1264)
  - docs(yarn): added troubleshooting for yarn and github (#1275)
  - chore(cd): update base deck version to 2022.0.0-20221128231909.master (#1276)
  - chore(cd): update base deck version to 2022.0.0-20221130174048.master (#1281)
  - chore(cd): update base deck version to 2022.0.0-20221212162149.master (#1283)
  - fix(runtime): There was an incompatibility between angular version (1.8.0) and angular sanitize version (#1284)
  - chore(cd): update base deck version to 2022.0.0-20221222045945.master (#1285)
  - chore(cd): update base deck version to 2023.0.0-20230105160952.master (#1286)
  - chore(cd): update base deck version to 2023.0.0-20230110154919.master (#1287)
  - chore(cd): update base deck version to 2023.0.0-20230110161007.master (#1288)
  - chore(cd): update base deck version to 2023.0.0-20230125224635.master (#1289)
  - chore(cd): update base deck version to 2023.0.0-20230202120433.master (#1293)
  - chore(cd): update base deck version to 2023.0.0-20230207090202.master (#1297)
  - chore(cd): update base deck version to 2023.0.0-20230214090728.master (#1298)
  - chore(cd): update base deck version to 2023.0.0-20230220114621.master (#1299)
  - chore(cd): update base deck version to 2023.0.0-20230220132814.master (#1300)
  - chore(cd): update base deck version to 2023.0.0-20230321144223.release-1.30.x (#1331)

#### Dinghy™ - 2.28.0...2.30.0

  - chore(dependencies): Bump OSS Dinghy version (#461)
  - chore(dependencies): update plank version (#464)
  - chore(dependencies): updated oss dinghy version to v0.0.0-20221025163127-2d465e0cea94 (#470)
  - chore(docs): added docs about backporting oss features (#474)
  - feat(tls): Enables TLS redis URLs (#476)
  - chore(dependencies): Updated oss dinghy version (#477)
  - chore(alpine): Upgrade alpine version (#481)

#### Armory Echo - 2.28.0...2.30.0

  - chore(cd): update armory-commons version to 3.11.4 (#472)
  - chore(cd): update armory-commons version to 3.11.3 (#471)
  - chore(build): upgrade armory settings (#469) (#470)
  - chore(cd): update armory-commons version to 3.11.2 (#468)
  - fix(build): use semver version from astrolabe variables (#464) (#465)
  - chore(cd): update base service version to echo:2022.04.27.04.44.17.release-1.28.x (#463)
  - chore(cd): update base service version to echo:2022.04.27.04.35.31.release-1.28.x (#462)
  - fix(build): include version to artifactory/nebula plugin (backport #456) (#458)
  - chore(cd): update base service version to echo:2022.04.26.16.15.57.release-1.28.x (#455)
  - chore(cd): update armory-commons version to 3.11.1 (#453)
  - chore(cd): update base service version to echo:2022.04.09.02.36.00.release-1.28.x (#447)
  - chore(cd): update base service version to echo:2022.04.01.15.36.33.master (#443)
  - chore(cd): update base service version to echo:2022.04.04.21.06.21.master (#446)
  - chore(cd): update base service version to echo:2022.04.14.16.53.32.master (#448)
  - chore(cd): update base service version to echo:2022.04.20.15.17.48.master (#449)
  - chore(cd): update base service version to echo:2022.04.20.18.17.24.master (#450)
  - chore(cd): update base service version to echo:2022.04.21.15.59.16.master (#451)
  - fix(build): include version to artifactory/nebula plugin (#456)
  - chore(cd): update base service version to echo:2022.04.27.04.21.23.master (#459)
  - chore(cd): update base service version to echo:2022.04.27.04.28.29.master (#460)
  - fix(build): use semver version from astrolabe variables (#464)
  - chore(build): upgrade armory settings (#469)
  - chore(build): updating armory-commons (#473)
  - chore(cd): update base service version to echo:2022.04.28.11.23.33.master (#467)
  - chore(cd): update base service version to echo:2022.05.27.15.13.57.master (#474)
  - chore(cd): update base service version to echo:2022.05.27.20.17.29.master (#475)
  - chore(cd): update base service version to echo:2022.06.06.17.04.57.master (#476)
  - chore(cd): update base service version to echo:2022.06.14.18.38.40.master (#477)
  - chore(cd): update base service version to echo:2022.07.27.23.37.25.master (#478)
  - chore(cd): update base service version to echo:2022.08.03.02.53.03.master (#480)
  - chore(cd): update base service version to echo:2022.08.13.04.22.48.master (#485)
  - chore(cd): update base service version to echo:2022.08.15.19.05.42.master (#486)
  - chore(cd): update base service version to echo:2022.08.25.19.33.36.master (#489)
  - chore(cd): update base service version to echo:2022.09.12.18.31.44.master (#490)
  - chore(cd): update base service version to echo:2022.09.13.20.21.05.master (#491)
  - chore(cd): update base service version to echo:2022.09.14.16.00.12.master (#492)
  - chore(cd): update base service version to echo:2022.09.27.18.06.29.master (#493)
  - chore(cd): update base service version to echo:2022.10.03.15.36.31.master (#494)
  - chore(cd): update base service version to echo:2022.10.10.17.49.34.master (#495)
  - chore(cd): update base service version to echo:2022.11.18.18.22.08.master (#498)
  - chore(cd): update base service version to echo:2022.11.19.16.28.16.master (#500)
  - chore(cd): update base service version to echo:2022.11.24.15.57.49.master (#501)
  - re-trigger build (#502)
  - re-trigger build for stack (#505)
  - chore(cd): update base service version to echo:2022.11.30.16.14.24.master (#506)
  - chore(cd): update base service version to echo:2022.12.07.16.52.30.master (#508)
  - chore(cd): update base service version to echo:2022.12.09.00.48.10.master (#510)
  - chore(cd): update base service version to echo:2022.12.09.02.57.46.master (#511)
  - chore(cd): update base service version to echo:2022.12.09.06.02.22.master (#512)
  - chore(cd): update base service version to echo:2022.12.09.16.42.31.master (#513)
  - chore(cd): update base service version to echo:2022.12.14.15.26.17.master (#514)
  - chore(cd): update base service version to echo:2022.12.14.22.12.50.master (#517)
  - chore(cd): update base service version to echo:2022.12.16.00.25.34.master (#518)
  - fix: Update config after OSS spring boot migration (#519)
  - chore(cd): update base service version to echo:2023.01.12.21.50.58.master (#522)
  - chore(cd): update base service version to echo:2023.01.20.14.32.19.master (#524)
  - chore(cd): update base service version to echo:2023.01.26.22.02.31.master (#528)
  - chore(cd): update base service version to echo:2023.01.30.15.29.44.master (#529)
  - chore(cd): update base service version to echo:2023.01.30.16.27.29.master (#530)
  - chore(cd): update base service version to echo:2023.02.08.08.42.16.master (#531)
  - chore(cd): update base service version to echo:2023.02.08.19.53.33.master (#532)
  - chore(cd): update base service version to echo:2023.02.08.22.19.31.master (#533)
  - chore(cd): update base service version to echo:2023.02.08.23.29.50.master (#534)
  - chore(cd): update base service version to echo:2023.02.09.00.59.31.master (#535)
  - chore(cd): update base service version to echo:2023.02.09.06.34.26.master (#536)
  - chore(cd): update base service version to echo:2023.02.10.05.34.06.master (#537)
  - chore(cd): update base service version to echo:2023.02.20.19.52.01.master (#538)
  - chore(cd): update base service version to echo:2023.02.20.21.09.15.master (#539)
  - chore(cd): update armory-commons version to 3.13.1 (#558)
  - chore(cd): update base service version to echo:2023.04.05.11.38.02.release-1.30.x (#572)
  - chore(cd): update base service version to echo:2023.04.07.01.30.15.release-1.30.x (#573)
  - chore(cd): update armory-commons version to 3.13.2 (#575)
  - chore(cd): update armory-commons version to 3.13.3 (#578)
  - chore(cd): update armory-commons version to 3.13.4 (#580)
  - chore(cd): update armory-commons version to 3.13.5 (#583)

#### Armory Fiat - 2.28.0...2.30.0

  - chore(cd): update base service version to fiat:2022.04.27.04.04.45.release-1.28.x (#370)
  - chore(cd): update armory-commons version to 3.11.4 (#365)
  - chore(cd): update armory-commons version to 3.11.3 (#362)
  - chore(build): upgrade armory settings (#360) (#361)
  - chore(cd): update armory-commons version to 3.11.2 (#359)
  - fix(build): pass version to nebula and remove devSnapshot publishing (backport #355) (#358)
  - chore(cd): update base service version to fiat:2022.04.26.16.36.30.release-1.28.x (#352)
  - chore(cd): update armory-commons version to 3.11.1 (#351)
  - chore(cd): update base service version to fiat:2022.04.09.02.00.53.release-1.28.x (#345)
  - chore(cd): update base service version to fiat:2022.04.01.22.02.12.master (#341)
  - chore(cd): update base service version to fiat:2022.04.04.21.04.58.master (#344)
  - chore(cd): update base service version to fiat:2022.04.13.19.19.16.master (#346)
  - chore(cd): update base service version to fiat:2022.04.20.15.19.32.master (#347)
  - chore(cd): update base service version to fiat:2022.04.21.15.56.28.master (#349)
  - chore(cd): update base service version to fiat:2022.04.27.03.57.12.master (#354)
  - chore(cd): update base service version to fiat:2022.04.27.04.03.50.master (#356)
  - fix(build): pass version to nebula and remove devSnapshot publishing (#355)
  - chore(build): upgrade armory settings (#360)
  - chore(build): updating armory-commons (#366)
  - chore(cd): update base service version to fiat:2022.05.19.22.57.38.master (#371)
  - chore(cd): update base service version to fiat:2022.05.27.15.12.30.master (#374)
  - chore(cd): update base service version to fiat:2022.06.06.17.03.12.master (#375)
  - chore(cd): update base service version to fiat:2022.06.14.18.38.36.master (#376)
  - chore(cd): update base service version to fiat:2022.06.24.16.02.34.master (#377)
  - chore(dockerfile): upgrade to latest alpine image (#378)
  - chore(cd): update base service version to fiat:2022.07.26.00.02.40.master (#381)
  - chore(cd): update base service version to fiat:2022.07.26.12.49.24.master (#382)
  - chore(cd): update base service version to fiat:2022.07.27.23.28.35.master (#383)
  - chore(cd): update base service version to fiat:2022.08.03.02.30.50.master (#384)
  - chore(cd): update base service version to fiat:2022.08.13.22.29.32.master (#389)
  - chore(cd): update base service version to fiat:2022.08.15.19.02.00.master (#390)
  - chore(cd): update base service version to fiat:2022.12.09.06.00.32.master (#416)
  - chore(cd): update base service version to fiat:2022.12.15.16.51.17.master (#417)
  - chore(cd): update base service version to fiat:2022.12.22.04.47.41.master (#418)
  - chore(cd): update base service version to fiat:2023.01.12.21.48.17.master (#421)
  - chore(cd): update base service version to fiat:2023.01.19.18.55.19.master (#422)
  - chore(cd): update base service version to fiat:2023.01.23.17.07.21.master (#423)
  - chore(cd): update base service version to fiat:2023.01.26.22.03.42.master (#424)
  - chore(cd): update base service version to fiat:2023.01.30.15.29.51.master (#425)
  - chore(cd): update base service version to fiat:2023.01.30.16.28.00.master (#426)
  - chore(cd): update base service version to fiat:2023.02.07.14.56.27.master (#427)
  - chore(cd): update base service version to fiat:2023.02.07.15.21.58.master (#428)
  - chore(cd): update base service version to fiat:2023.02.08.19.56.02.master (#431)
  - chore(cd): update base service version to fiat:2023.02.08.23.29.06.master (#433)
  - chore(cd): update base service version to fiat:2023.02.09.00.55.51.master (#434)
  - chore(cd): update base service version to fiat:2023.02.09.06.30.45.master (#435)
  - chore(cd): update base service version to fiat:2023.02.17.16.05.18.master (#436)
  - chore(cd): update base service version to fiat:2023.02.20.19.50.58.master (#437)
  - chore(cd): update armory-commons version to 3.13.1 (#456)
  - chore(cd): update base service version to fiat:2023.04.05.11.36.40.release-1.30.x (#470)
  - chore(cd): update armory-commons version to 3.13.2 (#471)
  - chore(cd): update armory-commons version to 3.13.3 (#475)
  - chore(cd): update armory-commons version to 3.13.5 (#478)

#### Armory Front50 - 2.28.0...2.30.0

  - fix(dependencies): match google api+auth versions to those set in oss (#432) (#433)
  - chore(cd): update armory-commons version to 3.11.4 (#424)
  - feat(iam): use aws-mysql-jdbc (#392) (#401)
  - chore(cd): update armory-commons version to 3.11.3 (#422)
  - fix(build): pass version to nebula and remove devSnapshot publishing (backport #419) (#421)
  - chore(cd): update armory-commons version to 3.11.2 (#420)
  - chore(cd): update base service version to front50:2022.04.27.05.12.35.release-1.28.x (#418)
  - chore(cd): update base service version to front50:2022.04.27.05.02.09.release-1.28.x (#414)
  - chore(cd): update base service version to front50:2022.04.26.16.45.10.release-1.28.x (#411)
  - chore(cd): update armory-commons version to 3.11.1 (#410)
  - chore(build): resolve conflicting armoryCommonsVersion to 3.10.6 (#403)
  - chore(cd): update armory-commons version to 3.10.6 (#382) (#402)
  - chore(cd): update base service version to front50:2022.04.09.02.35.50.release-1.28.x (#400)
  - chore(cd): update base service version to front50:2022.04.09.00.23.58.release-1.28.x (#399)
  - chore(cd): update base service version to front50:2022.04.01.15.36.24.master (#394)
  - fix(build): pass version to nebula and remove devSnapshot publishing (#419)
  - chore(build): updating armory-commons (#426)
  - feat(iam): use aws-mysql-jdbc (backport #392) (#405)
  - fix(dependencies): match google api+auth versions to those set in oss (#432)
  - chore(dockerfile): upgrade to latest alpine image (#434)
  - chore(cd): update base service version to front50:2023.04.07.01.28.32.release-1.30.x (#532)
  - chore(cd): update armory-commons version to 3.13.1 (#514)
  - chore(cd): update armory-commons version to 3.13.2 (#533)
  - chore(cd): update base service version to front50:2023.04.27.18.45.08.release-1.30.x (#541)
  - chore(cd): update armory-commons version to 3.13.3 (#538)
  - chore(cd): update base service version to front50:2023.05.22.19.11.48.release-1.30.x (#548)
  - chore(cd): update armory-commons version to 3.13.5 (#544)

#### Armory Gate - 2.28.0...2.30.0

  - chore(release): Change the URL to point to the local opt/gate repository (#450) (#451) (#452)
  - chore(release): Change the URL to point to the local opt/gate repository (#450) (#451)
  - chore(release): Bump armory header version (#448) (#449)
  - chore(cd): update armory-commons version to 3.11.4 (#444)
  - chore(cd): update armory-commons version to 3.11.3 (#443)
  - chore(build): upgrade armory settings (#441) (#442)
  - chore(cd): update armory-commons version to 3.11.2 (#440)
  - chore(cd): update base service version to gate:2022.04.27.05.20.04.release-1.28.x (#436)
  - chore(cd): update armory-commons version to 3.11.1 (#428)
  - fix(build): pass version to nebula and remove devSnapshots publishing (backport #438) (#439)
  - chore(cd): update base service version to gate:2022.04.01.15.36.20.master (#417)
  - chore(cd): update base service version to gate:2022.04.04.21.06.25.master (#422)
  - chore(cd): update base service version to gate:2022.04.20.15.19.23.master (#423)
  - chore(cd): update base service version to gate:2022.04.20.18.17.06.master (#424)
  - chore(cd): update base service version to gate:2022.04.21.15.56.14.master (#425)
  - chore(cd): update base service version to gate:2022.04.21.17.35.08.master (#426)
  - chore(cd): update base service version to gate:2022.04.27.05.02.05.master (#432)
  - fix(build): pass version to nebula and remove devSnapshots publishing (#438)
  - chore(cd): update base service version to gate:2022.04.27.05.07.06.master (#433)
  - chore(build): upgrade armory settings (#441)
  - chore(build): updating armory-commons (#445)
  - chore(cd): update base service version to gate:2022.05.27.15.15.52.master (#446)
  - chore(cd): update base service version to gate:2022.06.06.17.05.14.master (#447)
  - chore(release): Bump armory header version (#448)
  - chore(release): Change the URL to point to the local opt/gate repository (#450)
  - chore(cd): update base service version to gate:2022.06.14.18.37.46.master (#453)
  - chore(release): Backport header fix to 2.27.x release (#454)
  - Revert "chore(release): Backport header fix to 2.27.x release (#454)" (#456)
  - fix(perf): upgrade alpine version to resolve perf in GCP (#457)
  - chore(cd): update base service version to gate:2022.07.12.12.33.00.master (#461)
  - fix(header): update plugins.json with newest header version (#482)
  - revert(header): update plugins.json with newest header version (#484)
  - chore(cd): update armory-commons version to 3.13.1 (#537)
  - chore(cd): update armory-commons version to 3.13.2 (#554)
  - chore(cd): update base service version to gate:2023.04.07.01.27.28.release-1.30.x (#553)
  - fix(tests): Fix JUnit tests (#558)
  - chore(cd): update armory-commons version to 3.13.3 (#559)
  - chore(cd): update armory-commons version to 3.13.5 (#563)

#### Armory Igor - 2.28.0...2.30.0

  - chore(cd): update armory-commons version to 3.11.4 (#342)
  - chore(cd): update armory-commons version to 3.11.3 (#341)
  - chore(cd): update base service version to igor:2022.04.27.05.30.38.release-1.28.x (#336)
  - chore(build): pass version to nebula and remove devSnapshot publishing (backport #337) (#340)
  - chore(cd): update armory-commons version to 3.11.2 (#339)
  - chore(cd): update base service version to igor:2022.04.01.15.36.29.master (#319)
  - chore(cd): update base service version to igor:2022.04.28.14.35.18.master (#338)
  - chore(build): pass version to nebula and remove devSnapshot publishing (#337)
  - chore(build): updating armory-commons (#343)
  - chore(cd): update base service version to igor:2022.05.27.15.14.21.master (#344)
  - chore(cd): update base service version to igor:2022.05.27.20.14.47.master (#345)
  - chore(cd): update base service version to igor:2022.06.06.17.04.26.master (#346)
  - chore(cd): update base service version to igor:2022.06.14.18.37.51.master (#347)
  - chore(dockerfile): upgrade to latest alpine image (#348)
  - chore(cd): update base service version to igor:2022.07.20.18.17.25.master (#351)
  - chore(cd): update base service version to igor:2022.07.27.23.35.29.master (#352)
  - chore(cd): update base service version to igor:2022.08.01.21.10.11.master (#353)
  - chore(cd): update base service version to igor:2022.08.03.02.29.42.master (#354)
  - chore(cd): update base service version to igor:2022.08.13.22.29.05.master (#357)
  - chore(cd): update base service version to igor:2022.08.15.19.01.51.master (#358)
  - chore(cd): update base service version to igor:2022.08.18.16.17.36.master (#362)
  - chore(cd): update base service version to igor:2022.08.25.19.31.07.master (#364)
  - chore(cd): update base service version to igor:2022.08.26.15.15.54.master (#365)
  - chore(cd): update base service version to igor:2022.09.12.18.32.49.master (#366)
  - chore(cd): update base service version to igor:2022.09.13.20.18.06.master (#367)
  - chore(cd): update base service version to igor:2022.09.14.15.59.58.master (#368)
  - chore(cd): update armory-commons version to 3.13.1 (#431)
  - chore(cd): update base service version to igor:2023.04.07.01.27.38.release-1.30.x (#448)
  - chore(cd): update armory-commons version to 3.13.2 (#449)
  - chore(cd): update armory-commons version to 3.13.3 (#452)
  - chore(cd): update armory-commons version to 3.13.5 (#455)

#### Armory Kayenta - 2.28.0...2.30.0

  - chore(cd): update armory-commons version to 3.11.4 (#343)
  - chore(cd): update armory-commons version to 3.11.3 (#342)
  - chore(cd): update armory-commons version to 3.11.2 (#340)
  - chore(cd): update base service version to kayenta:2022.04.27.05.42.08.release-1.28.x (#338)
  - chore(build): pass version to nebula and remove devSnapshot publishing (backport #339) (#341)
  - chore(cd): update base service version to kayenta:2022.03.23.21.03.31.master (#323)
  - chore(cd): update base service version to kayenta:2022.04.27.05.33.46.master (#336)
  - chore(build): pass version to nebula and remove devSnapshot publishing (#339)
  - chore(build): updating armory-commons (#344)
  - chore(dockerfile): upgrade to latest alpine image (#345)
  - chore(cd): update base service version to kayenta:2022.07.20.18.15.49.master (#348)
  - chore(cd): update base service version to kayenta:2022.07.20.22.34.41.master (#350)
  - chore(cd): update base service version to kayenta:2022.08.03.02.54.58.master (#353)
  - chore(cd): update base service version to kayenta:2022.08.13.22.24.28.master (#354)
  - feat(scc): Support spring cloud config system like other services for? (#371)
  - fix(kayenta-integration-tests): update dynatrace tenant to qso00828 (#376)
  - chore(cd): update base service version to kayenta:2022.12.08.17.37.22.master (#375)
  - chore(cd): update base service version to kayenta:2023.01.17.20.42.16.master (#385)
  - chore(cd): update base service version to kayenta:2023.01.23.17.15.20.master (#386)
  - chore(cd): update base service version to kayenta:2023.01.24.16.10.35.master (#387)
  - chore(cd): update armory-commons version to 3.13.2 (#424)
  - chore(cd): update base service version to kayenta:2023.04.13.23.42.23.release-1.30.x (#427)
  - chore(cd): update armory-commons version to 3.13.3 (#428)
  - chore(refactoring): refactored setting default system properties (#429)
  - fix: Update path of main class. (#432)
  - fix(config): add missing exclude spring config (#435) (#436)
  - fix: Remove whitespace when defining spring properties (#437) (#438)
  - chore(cd): update armory-commons version to 3.13.5 (#439)

#### Armory Orca - 2.28.0...2.30.0

  - chore(cd): update armory-commons version to 3.11.4 (#488)
  - chore(cd): update armory-commons version to 3.11.3 (#486)
  - feat(iam): aws mysql jdbc (#449) (#464)
  - chore(build): upgrade armory settings (#484) (#485)
  - chore(cd): update armory-commons version to 3.11.2 (#483)
  - fix(build): pass version to nebula and remove devsnapshot publishing (backport #481) (#482)
  - chore(cd): update base orca version to 2022.04.27.05.53.34.release-1.28.x (#479)
  - chore(cd): update base orca version to 2022.04.27.05.36.33.release-1.28.x (#476)
  - chore(cd): update base orca version to 2022.04.26.17.14.12.release-1.28.x (#472)
  - chore(cd): update armory-commons version to 3.11.1 (#471)
  - chore(cd): update base orca version to 2022.04.09.02.41.36.release-1.28.x (#462)
  - chore(cd): update base orca version to 2022.04.01.22.15.58.master (#459)
  - chore(cd): update armory-commons version to 3.13.1 (#613)
  - chore(cd): update base orca version to 2023.04.07.01.52.33.release-1.30.x (#629)
  - chore(cd): update armory-commons version to 3.13.2 (#630)
  - chore(build): Backport missing build changes (#634)
  - chore(cd): update armory-commons version to 3.13.3 (#635)
  - chore(cd): update armory-commons version to 3.13.4 (#637)
  - chore(cd): update armory-commons version to 3.13.5 (#642)
  - chore(cd): update base orca version to 2023.05.18.14.27.05.release-1.30.x (#644)

#### Armory Rosco - 2.28.0...2.30.0

  - chore(cd): update armory-commons version to 3.11.0 (#402)
  - fix(mergify):fix conflicts (#419)
  - chore(cd): update armory-commons version to 3.11.4 (#418)
  - fix(build): pass version to nebula and use baseServiceVersion in all ? (#415) (#417)
  - chore(cd): update armory-commons version to 3.11.3 (#416)
  - chore(cd): update armory-commons version to 3.11.2 (#413)
  - chore(build): remove platform build (#297) (#412)
  - chore(cd): update base service version to rosco:2022.04.27.03.24.16.release-1.28.x (#410)
  - chore(cd): update base service version to rosco:2022.04.26.21.07.59.release-1.28.x (#407)
  - chore(cd): update armory-commons version to 3.11.1 (#403)
  - chore(cd): update base service version to rosco:2022.04.01.15.34.25.master (#395)
  - chore(cd): update base service version to rosco:2022.04.04.21.04.50.master (#397)
  - chore(cd): update base service version to rosco:2022.04.20.02.37.26.master (#398)
  - chore(cd): update base service version to rosco:2022.04.20.02.56.12.master (#399)
  - chore(cd): update base service version to rosco:2022.04.20.18.17.20.master (#400)
  - chore(cd): update base service version to rosco:2022.04.21.15.56.38.master (#401)
  - chore(cd): update base service version to rosco:2022.04.26.20.48.56.master (#405)
  - chore(cd): update base service version to rosco:2022.04.27.02.44.16.master (#408)
  - chore(build): remove platform build (#297)
  - chore(cd): update base service version to rosco:2022.05.04.22.07.45.master (#414)
  - fix(build): pass version to nebula and use baseServiceVersion in all ? (#415)
  - chore(build): updating armory-commons (#420)
  - chore(cd): update base service version to rosco:2022.05.04.22.07.45.master (#421)
  - chore(cd): update base service version to rosco:2022.05.27.15.12.22.master (#422)
  - chore(cd): update base service version to rosco:2022.06.06.17.03.08.master (#423)
  - chore(cd): update base service version to rosco:2022.06.09.22.08.52.master (#424)
  - chore(cd): update base service version to rosco:2022.06.10.15.00.46.master (#425)
  - chore(cd): update base service version to rosco:2022.06.14.18.37.43.master (#426)
  - chore(cd): update base service version to rosco:2022.06.18.02.01.01.master (#427)
  - chore(cd): update base service version to rosco:2022.07.09.02.24.56.master (#429)
  - chore(dockerfile): upgrade to latest alpine image (#428)
  - feat(packer): Upgraded packer to version 1.8.1 (#432)
  - chore(cd): update base service version to rosco:2022.07.18.22.45.28.master (#433)
  - feat(dockerfile): add Kustomize 4 to Dockerfiles (#434)
  - chore(cd): update armory-commons version to 3.13.1 (#508)
  - chore(cd): update base service version to rosco:2023.04.05.11.40.04.release-1.30.x (#523)
  - chore(cd): update armory-commons version to 3.13.3 (#528)
  - chore(cd): update armory-commons version to 3.13.5 (#532)

#### Terraformer™ - 2.28.0...2.30.0

  - feat(azure): Add azure cli (#450) (#470)
  - feat(tls): Support for TLS Redis (#456) (#468)
  - chore(build): update mergify config (#451) (#465)
  - chore(logs): Add terraform logs (#464) (#467)
  - fix(test): Changed clouddriver version (#463) (#466)
  - fix(artifacts): fix npe when using binary tf plugins (#455) (#461)
  - feat(terraform): Adds show option for terraform stage (#447)
  - chore(build): update mergify config (#451)
  - fix(artifacts): fix npe when using binary tf plugins (#455)
  - fix(test): Changed clouddriver version (#463)
  - chore(logs): Add terraform logs (#464)
  - chore(gha): run the tf versions action when tf_install script changes (#397)
  - feat(tls): Support for TLS Redis (#456)
  - feat(removed): Remove old versions of TF that should no longer be used (#462)
  - feat(azure): Add azure cli (#450)
  - fix(log): calling remote logging asynchronously (#471)
  - Adding TF versions 1.1.x 1.2.x and missing patch versions (#472)
  - Adding TF versions up to 1.3.4 (#477)
  - Updating TF versions from 0.12.x-1.3.5 (#481)
  - fix(versions): Sets version constraints for kubectl & aws-iam-authent? (#487)
  - Fixes builds with golint being dead until were on a newer golang (#491)
  - feat(gcloud): Bump to latest gcloud sdk & adds the GKE Auth plugin (#490)


### Spinnaker


#### Spinnaker Clouddriver - 1.30.2

  - fix(appEngine): lazy init for App Engine beans for credentials (backport #5749) (#5750)
  - fix(gitrepo): Support to authenticate with user and token (#5733) (#5736)
  - fix(core): ignore roles for anonymous user to access account (backport #5726) (#5727)
  - fix(cf): scale app before building droplet (backport #5692) (#5710)
  - fix(cf): update service binding name regex (backport #5663) (#5709)
  - chore(titus): limit protobuf to 3.17.3 (#5706) (#5714)
  - chore(ci): Mergify - merge Autobumps on release-* (#5697) (#5701)
  - fix(ci): fetch previous tag from git instead of API (#5696) (#5699)
  - chore(ci): Upload halconfigs to GCS on Tag push (#5689) (#5694)
  - fix(kubernetes): Pin Debian Package version of kubectl as well (#5685) (#5687)
  - chore(dependencies): Autobump fiatVersion (#5684)
  - chore(dependencies): don't create an autobump PR for halyard on a clo? (backport #5677) (#5683)
  - chore(it): add CR/CRD integration tests (#5672)
  - chore(dependencies): Autobump korkVersion (#5679)
  - feat(kubernetes): support propagation policy in delete manifest stage (#5678)
  - fix(sql): Fix running tasks listing (#5680)
  - fix(kubernetes): Pin Debian Package version of kubectl as well (#5685)
  - chore: bump google cloud sdk to v374.0.0 (#5644)
  - fix(dependency): Issue of missing javax.validation:validation-api dependency while upgrading the spring cloud to Hoxton.SR12 in kork (#5688)
  - chore(ci): Upload halconfigs to GCS on Tag push (#5689)
  - chore(dependencies): Autobump korkVersion (#5690)
  - chore(dependencies): Autobump korkVersion (#5691)
  - fix(ci): fetch previous tag from git instead of API (#5696)
  - chore(ci): Mergify - merge Autobumps on release-* (#5697)
  - refactor(clusters): Add typing and convert to java syntax. (#5320)
  - fix(docker): Support sortTagsByDate for SQL cache (#5098)
  - chore(titus): limit protobuf to 3.17.3 (#5706)
  - fix(cf): update service binding name regex (#5663)
  - fix(cf): set build sizing (#5692)
  - feat(search): provide a way to turn off cats search provider and kubernetes search provider (#5595)
  - fix(core): remove duplicate LoggingInstrumentation, MetricInstrumentation and CatsOnDemandCacheUpdater beans (#5705)
  - chore(ci): Only run CodeQL on Spinnaker repos (#5715)
  - feat(cfn): add property notificationARNs (#5708)
  - fix(core): set error message for AtomicOperationConverterNotFoundException (#5717)
  - feat(kubernetes): enable getManifest() to return Kubernetes system resources (#5720)
  - chore(dependencies): Autobump korkVersion (#5721)
  - fix(web): copy the MDC to threads that service async endpoints (#5716)
  - feat(provider/azure): Wait for server group healthy before continuing (#5723)
  - fix(core): ignore roles for anonymous user to access account (#5726)
  - chore(dependencies): Autobump korkVersion (#5728)
  - fix(provider/azure): Allow internal load balancers to show up (#5730)
  - fix(provider/azure): Scale sets can become healthy after time (#5729)
  - fix(provider/azure): Remove unused serverGroups tags (#5724)
  - fix(build): Remove temporary workaround from 2016 (#5725)
  - refactor(groovy): migrate things to Java (#5703)
  - fix(gitrepo): Support to authenticate with user and token (#5733)
  - chore(dependencies): Autobump korkVersion (#5735)
  - feat(core): User secrets and account upsert (#5719)
  - feat(artifacts/s3): make the AmazonS3 client used for retrieving s3 artifacts configurable (#5734)
  - feat(aws/image): add the aws.defaults.image-states configuration property (a comma-separated string (#5732)
  - chore(dependencies): use org.apache.commons:commons-compress:1.21 to fix CVE-2021-35516 and CVE-2021-35517 (#5731)
  - feat(artifacts/s3): add request handler for the s3 client used to retrieve artifacts to enable http connection pool metrics (#5738)
  - config(web): explicit qualifier bean for AsyncTaskExecutor in WebConfig (#5741)
  - fix(azure): increase health interval (#5740)
  - fix(caching): K8s cache affected when not enough permissions in service account (#5742)
  - fix(appEngine): lazy init for appengine beans for credentials (#5749)
  - feat(Aws-Lambda): Added Endpoints to delete Concurrencies (#5743)
  - fix(provider/google): Added scope to the credentials (#5718)
  - feat(gce): to support kork-credentials abstractions (#5747)
  - fix(logging): Fix log message format (#5755)
  - chore(dependencies): Autobump korkVersion (#5756)
  - chore(dependencies): Autobump fiatVersion (#5757)
  - fix(clouddriver-kubernetes): Changed property to name from getName (#5754)
  - chore(dockerfile): upgrade to latest alpine image (#5758)
  - feat(provider/google): GCE Autoscaler Support for Clouddriver. (#5748)
  - chore(dependencies): Autobump korkVersion (#5766)
  - Protobuf for m1 (#5765)
  - Arm64 support (#5767)
  - chore: bump gcloud version to 398.0.0 (#5761)
  - fix(ECS): support upper case on the tag of image (#5770)
  - feat(aws): Improving AWS EC2 instance types API integration and caching, feat(aws): Adding archi type to images API and caching (#5609)
  - chore(dependencies): Autobump fiatVersion (#5772)
  - fix(cats/redis): explicitly remove an agent from the activeAgents map when it is unscheduled  (#5774)
  - perf(web/cluster): make getForAccountAndNameAndType() more efficient (#5775)
  - feat(kubernetes): Add a check to verify if application name obtained from a kubernetes manifest exists in Front50 (#5777)
  - feat(kubernetes): add support for retrieving run job logs from a specific pod (#5778)
  - chore(aws/integration): make it easier to diagnose failures in CreateServerGroupSpec (#5780)
  - chore(dependencies): Autobump korkVersion (#5781)
  - test(GoogleSecretManager): add a test to make sure the right versions of libraries are built (#5773)
  - chore(dependencies): Autobump fiatVersion (#5782)
  - chore(dependencies): Autobump fiatVersion (#5783)
  - fix(core): Remove payload data from logs (#5784)
  - feat(azure): Upgrade azure sdk to the latest one (#5791)
  - chore(dependencies): Autobump korkVersion (#5786)
  - chore(dependencies): Autobump korkVersion (#5794)
  - chore(kubernetes): stop specifying the version of io.kubernetes:client-java (#5797)
  - feat(azure): Add cache agents to cache custom VM managed images  (#5792)
  - chore(build): give local builds as much memory as we do in CI (#5796)
  - fix(google): Fix for the missing CredentialsRepository issue (#5793)
  - chore(dependencies): Autobump korkVersion (#5800)
  - fix(cats-sql/test): prevent null pointer exception during cleanup (#5798)
  - feat(azure): Fetch Azure managed images from the managed images namespace cache (#5795)
  - chore(configserver): use version 0.14.2 of com.github.wnameless.json:json-flattener (#5804)
  - fix(appengine): Fixes app engine credentials repo (#5807)
  - fix(provider/azure): Fix CreateAzureServerGroupWithAzureLoadBalancerAtomicOperation and DestroyAzureServerGroupAtomicOperation after migrating to latest Azure SDK (#5803)
  - chore(deps): remove version specification from org.yaml:snakeyaml (#5812)
  - fix(kubernetes): teach KubernetesManifest to support kubernetes resources where the spec is not a map (#5814)
  - chore(test): ignore tests that require docker when it's not available (#5815)
  - feat(kubernetes): Introduce blue/green traffic management strategy (#5811)
  - chore(dependencies): Autobump spinnakerGradleVersion (#5819)
  - chore(dependencies): Autobump korkVersion (#5821)
  - chore(dependencies): Autobump korkVersion (#5822)
  - fix(artifacts/bitbuket): added ACCEPT Header when using token auth (#5813)
  - chore(dependencies): Autobump korkVersion (#5825)
  - feat(provider/google): Added cloudrun provider functionality in clouddriver. (#5751)
  - chore(kubernetes): remove duplicate dependency declaration of org.mockito:mockito-core (#5829)
  - refactor(web): Clean up redundant spring property in gradle file (#5834)
  - feat(kubernetes): add endpoints to allow k8s tasks to be retried by orca (#5833)
  - chore(dependencies): Autobump korkVersion (#5836)
  - chore(dependencies): Autobump korkVersion (#5837)
  - chore(dependencies): Autobump korkVersion (#5838)
  - chore(dependencies): Autobump korkVersion (#5839)
  - chore(dependencies): remove dependency on groovy-all where straightforward (#5840)
  - feat(k8s): Add Deployment Kind support for Blue/Green deployments (#5830)
  - Revert "feat(k8s): Add Deployment Kind support for Blue/Green deployments (#5830)" (#5843)
  - chore(dependencies): Autobump korkVersion (#5842)
  - chore(dependencies): Autobump spinnakerGradleVersion (#5844)
  - test(integration): Prevent interference between tests (#5835)
  - chore(dependencies): pin version of com.github.tomakehurst:wiremock (#5845)
  - feat(kubernetes): add visibility to KubectlJobExecutor by adding logs and extending the task object to include stdout and stderr info (#5846)
  - feat(gke): Enables gcloud auth plugin for 1.26+ GKE clusters (#5847)
  - chore(dependencies): Autobump korkVersion (#5853)
  - chore(kubernetes/test): actually run the junit tests (#5855)
  - fix(kubectl): add metrics to retries, make log messages more descriptive and support retries for all kubectl actions (#5854)
  - chore(dependencies): Autobump korkVersion (#5861)
  - chore(dependencies): Autobump korkVersion (#5862)
  - chore(dependencies): Autobump korkVersion (#5863)
  - chore(cats): make relationship log info instead of warn (#5668)
  - chore(dependencies): Autobump korkVersion (#5867)
  - chore(dependencies): Autobump korkVersion (#5869)
  - chore(dependencies): Autobump korkVersion (#5870)
  - chore(dependencies): Autobump korkVersion (#5871)
  - feat(core): copy the MDC into work done by PooledRequests (#5868)
  - chore(dependencies): Autobump korkVersion (#5872)
  - chore(dependencies): use version 3.21.12 of com.google.protobuf (#5873)
  - fix(google): make AbstractAtomicOperationsCredentialsConverter generic type (#5866)
  - fix(google): added null check for autoscaler custom metric scaling policies (#5849)
  - fix(kubernetes): Revert to using the dockerImage Artifact Replacer for cronjobs (#5876)
  - chore(dependencies): remove dependency on groovy-all with required groovy package (#5879)
  - chore(dependencies): Autobump korkVersion (#5883)
  - chore(dependencies): Autobump korkVersion (#5884)
  - fix(ecr): Two credentials with same accountId confuses EcrImageProvider with different regions (#5885)
  - fix(manifest-replicas): ReplicaSet Source-Capacity (#5874)
  - fix(aws): don't log empty warning BasicAmazonDeployDescriptionValidator.validate (#5889)
  - fix(gce): fixed the error caused by account removal (#5882)
  - fix(tests): Introduce junit vintage engine for junit4 test cases to kotlin-test.gradle, cleanup of useJUnitPlatform() from sub-modules and removing spek.gradle in clouddriver (#5901)
  - chore(dependencies): Autobump korkVersion (#5902)
  - chore(dependencies): Autobump korkVersion (#5905)
  - fix(cats-redis): release Semaphore to avoid leaking (#5903)
  - fix(core): Renamed a query parameter for template tags (#5906)
  - chore(aws): Update AWS IAM Authenticator version
  - fix(helm): propagate throwable on helm error (#5893)
  - chore(dependencies): Autobump fiatVersion (#5912)
  - chore(dependencies): Autobump korkVersion (#5938)
  - chore(dependencies): don't create an autobump PR for halyard on a clouddriver release branch (#5677) (#5939)
  - fix(metrics): revert metric names to pre-Java (#5936) (#5942)
  - chore(dependencies): Autobump fiatVersion (#5943)
  - fix(aws): ECS Service Tagging broken (backport #5954) (#5958)

#### Spinnaker Deck - 1.30.2

  - fix(ci): fetch previous tag from git instead of API (backport #9847) (#9850)
  - fix(aws): Fix Create Server Group button (backport #9865) (#9866)
  - chore(ci): Mergify - merge Autobumps on release-* (backport #9848) (#9852)
  - fix(core): Synchronize the verticalNavExpandedAtom using an atom effect (backport #9859) (#9860)
  - fix(cf): extract service name from context for execution details (backport #9843) (#9857)
  - fix(ci): Setup NodeJS the same in every GHA (#9834)
  - chore(dependencies): bump angular from 1.6.10 to 1.8.0 (#9836)
  - chore(publish): publish packages (#9837)
  - chore(ci): Upload halconfigs to GCS on Tag push (#9838)
  - chore(deps): bump async from 2.6.3 to 2.6.4 (#9840)
  - chore(deps): bump async from 2.6.3 to 2.6.4 in /test/functional (#9839)
  - Updating email validation to allow for longer domains per issue-6636 (#9841)
  - chore(publish): publish packages (#9842)
  - fix(ci): fetch previous tag from git instead of API (#9847)
  - chore(ci): Mergify - merge Autobumps on release-* (#9848)
  - fix(core): apps always display as unconfigured (#9853)
  - chore(publish): publish packages (#9854)
  - chore(cve): bump @spinnaker deps and fix CVEs (#9855)
  - fix(cf): extract service name from context for execution details (#9843)
  - chore(publish): publish packages (#9856)
  - feat(core): Synchronize the verticalNavExpandedAtom using an atom effect (#9859)
  - Fix(Oracle): Fixes Spinnaker configuration issue with Oracle object storage (#9858)
  - chore: Set permissions for GitHub actions (#9844)
  - chore(publish): publish packages (#9861)
  - style(core): pipelines adapt to sub pipeline with manual judgment color (#9863)
  - fix(aws): Fix Create Server Group button (#9865)
  - chore(publish): publish packages (#9864)
  - feat(rosco): add Kustomize 4 support (#9868)
  - chore(publish): publish packages (#9869)
  - perf(pipelinegraph): Improve the performance of the pipeline graph rendering (#9871)
  - feat(provider/google): enhanced autoscaler functionality. (#9867)
  - chore(gha): synchronize peer dependencies during bump packages step (#9872)
  - feat(dependencies): Update vulnerable dependencies (#9875)
  - chore(gha): add quotes around variables to treat as strings instead of possible commands (#9876)
  - Output bump packages bug (#9879)
  - Publish packages to NPM (#9880)
  - chore(build): Build docker images for multiple architectures (#9882)
  - Improvements to AMI and instance type validations, custom instance type selector (#9793)
  - Publish packages to NPM (#9883)
  - fix(notifications): Added space in Google Chat notification. (#9884)
  - Fix(core/pipelines): Fix syntax error on ui-select causing stage configuration to not load (#9886)
  - fix(search): Error thrown when search version 2 is enabled (#9888)
  - chore(dependencies): Updating Formik in @spinnaker/presentation (#9887)
  - fix(core): Do not set static document base URL (#9890)
  - Publish packages to NPM (#9885)
  - fix(aws): fix instance type selector by allowing instance types that can't be validated. (#9893)
  - fix(links): update link to spinnaker release changelog (#9897)
  - Publish packages to NPM (#9894)
  - fix(aws): Fixing AWS AZ auto rebalancing section by setting the default zones (#9902)
  - fix(aws): Fixing bugs related to clone CX when instance types are incompatible with image/region (#9901)
  - feat(kubernetes): Introduce blue/green traffic management strategy (#9911)
  - chore(dependencies): Autobump spinnakerGradleVersion (#9916)
  - feat(Azure): Update UI to handle custom and managed images. (#9910)
  - feat(pipeline): added feature flag for pipeline when mj stage child (#9914)
  - fix(aws): Guard against missing launchConfig.instanceMonitoring (#9917)
  - Aws rollback timeout v2 (#9923)
  - fix(dependencies): Pin correct cheerio version (#9924)
  - feat(core/bake): support include crds flag in Helm3 (#9903)
  - feat(Blue/Green): Add warning label and enhance disable/enable manifest stage with Deployment kind. (#9928)
  - chore(dependencies): Autobump spinnakerGradleVersion (#9932)
  - fix(azure): Register Azure Bake Execution Details Controller (#9933)
  - chore(deps): bump qs from 6.5.2 to 6.5.3 in /test/functional (#9929)
  - feat(core/pipeline): Add missing flag `skipDownstreamOutput` in pipeline stage (#9930)
  - fix(helm): update tooltip to not include Chart.yaml (#9934)
  - fix(core): Missing config elements after Angular 1.8 update (#9936)
  - fix(deck): Apache user should own the settings-local.js file, not spinnaker user, to display the custom profile features on DeckUI (#9935)
  - Publish packages to NPM (#9904)
  - fix(timeout): Added feature flag for rollback timeout ui input. (#9937)
  - Publish packages to NPM (#9938)
  - fix(ecs): skip checking for upstream stages for ECS deploy (#9945)
  - Publish packages to NPM (#9946)
  - fix(google): Resolved typo errors in GCE Autoscaler feature (#9947)
  - Publish packages to NPM (#9949)
  - fix(6755): Resolved issue regarding warning reporting when cloning a server group in AWS (#9948)
  - Revert "feat(Blue/Green): Add warning label and enhance disable/enable manifest stage with Deployment kind." (#9951)
  - chore(dev): specifying React code for Deck PRs (#9953)
  - feat(provider/cloudrun): Added cloudrun functionality to deck (#9931)
  - chore(feature-flag): mj parent pipeline enabled by default (#9954)
  - Publish packages to NPM (#9955)

#### Spinnaker Echo - 1.30.2

  - fix(ci): fetch previous tag from git instead of API (#1181) (#1184)
  - chore(ci): Upload halconfigs to GCS on Tag push (#1174) (#1179)
  - chore(dependencies): Autobump fiatVersion (#1172)
  - chore(dependencies): Autobump korkVersion (#1168)
  - chore(dependencies): Autobump korkVersion (#1171)
  - fix(dependency): Issue of missing javax.validation and hibernate-validator dependencies while upgrading the spring cloud to Hoxton.SR12 in kork (#1173)
  - chore(ci): Upload halconfigs to GCS on Tag push (#1174)
  - chore(dependencies): Autobump korkVersion (#1175)
  - chore(dependencies): Autobump korkVersion (#1176)
  - fix(ci): fetch previous tag from git instead of API (#1181)
  - chore(ci): Mergify - merge Autobumps on release-* (#1182)
  - feat(webhooks/github): Add more metadata to PR events (#1177)
  - feat(gitlabci): Added GitlabCI build type (#1148)
  - chore(dependencies): Autobump korkVersion (#1188)
  - feat(webhooks/github): Support for GitHub branch events (#1187)
  - chore(dependencies): Autobump korkVersion (#1189)
  - chore(dependencies): Autobump korkVersion (#1190)
  - chore(dependencies): Autobump korkVersion (#1191)
  - chore(dependencies): Autobump fiatVersion (#1192)
  - chore(dockerfile): upgrade to latest alpine image (#1193)
  - chore(build): Build docker images for multiple architectures (#1196)
  - chore(dependencies): Autobump korkVersion (#1197)
  - chore(dependencies): Autobump fiatVersion (#1200)
  - chore(dependencies): Autobump korkVersion (#1202)
  - chore(dependencies): Autobump fiatVersion (#1203)
  - chore(dependencies): Autobump fiatVersion (#1204)
  - chore(dependencies): Autobump korkVersion (#1205)
  - chore(dependencies): Autobump korkVersion (#1206)
  - chore(dependencies): Autobump korkVersion (#1208)
  - fix(pipelineTriggers): handle invalid constraint regexes (#1209)
  - fix(notifications): Encode url in email notification (#1207)
  - feat(manualJudgment): Change formatting of manual judgment emails (#1201)
  - chore(dependencies): Autobump korkVersion (#1210)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1215)
  - chore(dependencies): Autobump korkVersion (#1217)
  - chore(dependencies): Autobump korkVersion (#1218)
  - chore(dependencies): Autobump korkVersion (#1220)
  - feat(webhooks): Handle Bitbucket Server PR events (#1219)
  - refactor(web): Clean up redundant spring property in gradle file (#1228)
  - chore(dependencies): Autobump korkVersion (#1229)
  - chore(dependencies): Autobump korkVersion (#1230)
  - chore(dependencies): Autobump korkVersion (#1231)
  - chore(dependencies): Autobump korkVersion (#1232)
  - chore(dependencies): remove dependency on groovy-all (#1234)
  - feat(event): Add circuit breaker for events sending. (#1233)
  - feat(pubsub): add support for links in pubsub triggers (#1235)
  - chore(dependencies): Autobump korkVersion (#1240)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1242)
  - chore(dependencies): Autobump korkVersion (#1243)
  - fix: The circuit breaker feature for sending events to telemetry endpoint is hidden under a required feature flag property (#1241)
  - chore(dependencies): Autobump korkVersion (#1247)
  - chore(dependencies): Autobump korkVersion (#1248)
  - chore(dependencies): Autobump korkVersion (#1249)
  - fix(bitbucket): Add project key as identifier (#1250)
  - chore(dependencies): Autobump korkVersion (#1251)
  - chore(dependencies): Autobump korkVersion (#1252)
  - chore(dependencies): Autobump korkVersion (#1253)
  - chore(dependencies): Autobump korkVersion (#1254)
  - chore(dependencies): Autobump korkVersion (#1255)
  - fix(webhook/github): Add null check when getting the pull request action (#1256)
  - chore(dependencies): Autobump korkVersion (#1257)
  - chore(dependencies): Autobump korkVersion (#1258)
  - chore(dependencies): Autobump korkVersion (#1265)
  - fix(tests): Introduce junit5 vintage engine for running junit4 test cases over junit5 and cleanup of useJUnitPlatform() from sub-modules in echo (#1266)
  - chore(dependencies): Autobump korkVersion (#1267)
  - chore(dependencies): Autobump fiatVersion (#1268)
  - chore(dependencies): Autobump korkVersion (#1288)
  - chore(dependencies): Autobump fiatVersion (#1289)

#### Spinnaker Fiat - 1.30.2

  - chore(ci): Upload halconfigs to GCS on Tag push (#940) (#944)
  - chore(dependencies): don't create an autobump PR for halyard on a fia? (#938)
  - feat(build): bump dependencies for the given branch (#934)
  - chore(dependencies): Autobump korkVersion (#937)
  - fix(dependency): Issue of missing javax.validation:validation-api dependency while upgrading the spring cloud to Hoxton.SR12 in kork (#939)
  - chore(ci): Upload halconfigs to GCS on Tag push (#940)
  - chore(dependencies): Autobump korkVersion (#941)
  - chore(dependencies): Autobump korkVersion (#942)
  - fix(ci): fetch previous tag from git instead of API (#948)
  - chore(ci): Mergify - merge Autobumps on release-* (#949)
  - fix(google): skip groups for service accounts (#953)
  - fix(ci): Only bumpdep Halyard for master branch (#947)
  - chore(dependencies): Autobump korkVersion (#957)
  - chore(dependencies): Autobump korkVersion (#958)
  - chore(dependencies): Autobump korkVersion (#959)
  - fix(roles): Ensure account manager role is cached (#960)
  - perf(fiat-roles): Cache long-running roles' synchronization process (#962)
  - fix(permissions): ensure lower case for resource name in fiat_permission and fiat_resource tables (#963)
  - chore(dependencies): Autobump korkVersion (#965)
  - feat(api): Add support for more Spring Security APIs (#966)
  - fix: add migration to ensure consistency between resource_name in fiat_resource and fiat_permission tables (#964)
  - chore(dockerfile): upgrade to latest alpine image (#967)
  - chore(build): Build docker images for multiple architectures (#970)
  - chore(dependencies): Autobump korkVersion (#971)
  - perf(serviceAccounts): allows syncing service accounts without resolving user roles (#961)
  - feat(roles): add capability to control querying clouddriver for applications during roles sync (#972)
  - chore(dependencies): Autobump korkVersion (#973)
  - fix(gha): fix syntax error in code that determines what repos to bump (#974)
  - fix(gha): Event branch doesn't match (#975)
  - chore(dependencies): Autobump korkVersion (#976)
  - chore(dependencies): Autobump korkVersion (#981)
  - chore(dependencies): Autobump korkVersion (#982)
  - chore(dependencies): Autobump korkVersion (#985)
  - chore(dependencies): Autobump spinnakerGradleVersion (#989)
  - chore(dependencies): Autobump korkVersion (#992)
  - chore(dependencies): Autobump korkVersion (#993)
  - chore(dependencies): Autobump korkVersion (#996)
  - refactor(web): Clean up redundant spring property in gradle file (#998)
  - chore(dependencies): Autobump korkVersion (#999)
  - chore(dependencies): Autobump korkVersion (#1000)
  - chore(dependencies): Autobump korkVersion (#1001)
  - chore(dependencies): Autobump korkVersion (#1002)
  - chore(dependencies): Autobump korkVersion (#1004)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1005)
  - chore(dependencies): Autobump korkVersion (#1006)
  - refactor(sql): Optimize read queries for getUserPermission (#1003)
  - chore(web): clean up for spring property setup (#1008)
  - chore(dependencies): Autobump korkVersion (#1009)
  - chore(dependencies): Autobump korkVersion (#1010)
  - chore(dependencies): Autobump korkVersion (#1011)
  - fix: Should fix the deletion of permissions when resource name is uppercase (#1012)
  - fix(fiat-roles): Fiat fails to start if write mode is disabled (#1007)
  - chore(dependencies): Autobump korkVersion (#1016)
  - chore(dependencies): Autobump korkVersion (#1017)
  - chore(dependencies): Autobump korkVersion (#1018)
  - chore(dependencies): Autobump korkVersion (#1019)
  - chore(dependencies): Autobump korkVersion (#1020)
  - chore(dependencies): remove residual dependency on groovy-all in fiat (#1021)
  - chore(dependencies): Autobump korkVersion (#1022)
  - chore(dependencies): Autobump korkVersion (#1023)
  - fix(tests): Introduce junit5 vintage engine for running junit4 test cases over junit5 in fiat (#1025)
  - chore(dependencies): Autobump korkVersion (#1028)
  - fix(logs): Redacted secret data in logs. (#1029)
  - chore(dependencies): Autobump korkVersion (#1033)
  - chore(dependencies): Autobump korkVersion (#1050)

#### Spinnaker Front50 - 1.30.2

  - fix(ci): fetch previous tag from git instead of API (#1127) (#1130)
  - chore(ci): Upload halconfigs to GCS on Tag push (#1120) (#1125)
  - chore(dependencies): Autobump fiatVersion (#1118)
  - chore(dependencies): don't create an autobump PR for halyard on a fro? (backport #1115) (#1117)
  - chore(dependencies): Autobump korkVersion (#1112)
  - chore(dependencies): Autobump korkVersion (#1116)
  - fix(dependency): Issue of missing javax.validation, hibernate-validator dependencies and version conflict of com.google.cloud:google-cloud-storage while upgrading the spring cloud to Hoxton.SR12 in kork. (#1119)
  - chore(ci): Upload halconfigs to GCS on Tag push (#1120)
  - chore(dependencies): Autobump korkVersion (#1121)
  - chore(dependencies): Autobump korkVersion (#1122)
  - fix(ci): fetch previous tag from git instead of API (#1127)
  - chore(ci): Mergify - merge Autobumps on release-* (#1128)
  - fix(pipeline): include updated timestamp (#1133)
  - chore(dependencies): Autobump korkVersion (#1134)
  - chore(dependencies): Autobump korkVersion (#1136)
  - fix(build): Remove extra repository (#1135)
  - chore(dependencies): Autobump korkVersion (#1137)
  - chore(dependencies): Autobump korkVersion (#1141)
  - chore(dependencies): Autobump fiatVersion (#1145)
  - fix: Revision history is not showing the timestamp of the revision (#1142)
  - chore(build): Build docker images for multiple architectures (#1148)
  - chore(dependencies): Autobump korkVersion (#1150)
  - chore(dockerfile): upgrade to latest alpine image (#1151)
  - chore(dependencies): Autobump fiatVersion (#1157)
  - chore(dependencies): Autobump korkVersion (#1160)
  - fix(updateTs): missing updateTs field in the get pipeline history's response. (#1159)
  - chore(dependencies): Autobump fiatVersion (#1163)
  - chore(dependencies): Autobump fiatVersion (#1164)
  - chore(dependencies): Autobump korkVersion (#1166)
  - chore(dependencies): Autobump korkVersion (#1167)
  - chore(dependencies): Autobump korkVersion (#1168)
  - perf(serviceAccounts): Add attribute that allows creating service accounts without running full role syncs (#1139)
  - chore(dependencies): Autobump korkVersion (#1169)
  - fix(pipelines): prevent from creating duplicated pipelines (#1172)
  - feat(pipeline/kubernetes): Introduce validator for kubernetes blue/green traffic management strategy (#1176)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1177)
  - chore(dependencies): Autobump korkVersion (#1179)
  - chore(dependencies): Autobump korkVersion (#1180)
  - chore(dependencies): Autobump korkVersion (#1181)
  - refactor(web): Clean up redundant spring property in gradle file (#1188)
  - chore(dependencies): Autobump korkVersion (#1189)
  - chore(dependencies): Autobump korkVersion (#1190)
  - chore(dependencies): Autobump korkVersion (#1191)
  - chore(dependencies): Autobump korkVersion (#1192)
  - chore(dependencies): remove dependency on groovy-all where straightforward (#1193)
  - chore(dependencies): Autobump korkVersion (#1194)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1195)
  - chore(dependencies): Autobump korkVersion (#1198)
  - feat(pipeline/kubernetes): Migrate existing K8s deploy manifest traffic management from redblack to bluegreen (#1197)
  - chore(web): clean up for spring property setup (#1199)
  - chore(dependencies): Autobump korkVersion (#1200)
  - chore(dependencies): Autobump korkVersion (#1201)
  - chore(dependencies): Autobump korkVersion (#1202)
  - chore(dependencies): Autobump korkVersion (#1203)
  - chore(dependencies): Autobump korkVersion (#1204)
  - chore(dependencies): Autobump korkVersion (#1205)
  - chore(dependencies): Autobump korkVersion (#1206)
  - chore(dependencies): Autobump korkVersion (#1207)
  - chore(dependencies): remove residual dependency on groovy-all (#1208)
  - chore(dependencies): Autobump korkVersion (#1209)
  - chore(dependencies): Autobump korkVersion (#1210)
  - feat(migration): ability to disable deleting orphaned objects (#1211)
  - chore(tests): Cleanup of useJUnitPlatform() from sub-modules and introducing junit-vintage-engine in front50 (#1218)
  - chore(dependencies): Autobump korkVersion (#1219)
  - chore(dependencies): Autobump korkVersion (#1221)
  - fix(sql): Populating lastModified field for pipelines when loading objects. (#1220)
  - chore(dependencies): Autobump fiatVersion (#1225)
  - chore(dependencies): Autobump korkVersion (#1246)
  - chore(dependencies): don't create an autobump PR for halyard on a front50 release branch (#1115) (#1247)
  - chore(dependencies): Autobump fiatVersion (#1248)
  - fix(validator): Fix NPE when traffic management is not defined in a deployment manifest (#1253) (#1254)
  - fix(migrations): do not migrate redblack pipelines without stages (#1259) (#1260)

#### Spinnaker Gate - 1.30.2

  - fix(ci): fetch previous tag from git instead of API (#1551) (#1554)
  - chore(ci): Upload halconfigs to GCS on Tag push (#1544) (#1549)
  - chore(dependencies): Autobump fiatVersion (#1543)
  - chore(dependencies): Autobump korkVersion (#1539)
  - chore(dependencies): Autobump korkVersion (#1542)
  - chore(ci): Upload halconfigs to GCS on Tag push (#1544)
  - chore(dependencies): Autobump korkVersion (#1545)
  - chore(dependencies): Autobump korkVersion (#1547)
  - feat(tasks): Allow max polling of task status to be set (#1546)
  - fix(ci): fetch previous tag from git instead of API (#1551)
  - chore(ci): Mergify - merge Autobumps on release-* (#1552)
  - chore(dependencies): Autobump korkVersion (#1557)
  - chore(dependencies): Autobump korkVersion (#1558)
  - chore(dependencies): Autobump korkVersion (#1559)
  - fix(restart-pipeline) : CheckPrecondition doesn't evaluate expression correctly when upstream stages get restarted (#1560)
  - chore(build): Gradle 7 compatibility (#1561)
  - chore(dependencies): Autobump korkVersion (#1562)
  - chore(dependencies): Autobump fiatVersion (#1563)
  - chore(dockerfile): upgrade to latest alpine image (#1564)
  - chore(build): Build docker images for multiple architectures (#1567)
  - chore(dependencies): Autobump korkVersion (#1568)
  - chore(dependencies): Autobump fiatVersion (#1571)
  - chore(dependencies): Autobump korkVersion (#1572)
  - chore(dependencies): Autobump fiatVersion (#1573)
  - chore(dependencies): Autobump fiatVersion (#1574)
  - chore(dependencies): Autobump korkVersion (#1575)
  - chore(dependencies): Autobump korkVersion (#1577)
  - chore(dependencies): Autobump korkVersion (#1578)
  - chore(dependencies): Autobump korkVersion (#1580)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1585)
  - chore(dependencies): Autobump korkVersion (#1587)
  - chore(dependencies): Autobump korkVersion (#1588)
  - chore(dependencies): Autobump korkVersion (#1590)
  - refactor(web): Clean up redundant spring property in gradle file (#1597)
  - chore(dependencies): Autobump korkVersion (#1598)
  - chore(dependencies): Autobump korkVersion (#1599)
  - chore(dependencies): Autobump korkVersion (#1600)
  - chore(dependencies): Autobump korkVersion (#1601)
  - chore(dependencies): remove dependency on groovy-all (#1602)
  - chore(dependencies): Autobump korkVersion (#1603)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1604)
  - chore(dependencies): Autobump korkVersion (#1605)
  - chore(web): clean up for spring property setup (#1606)
  - chore(dependencies): Autobump korkVersion (#1607)
  - chore(dependencies): Autobump korkVersion (#1608)
  - chore(dependencies): Autobump korkVersion (#1609)
  - feat(web): Add X-SPINNAKER-* optional data to HTTP response header (#1610)
  - fix(web): Fixes ArtifactController and ArtifactService to close the InputStream object used in the fetch api and add unit test for controller (#1611)
  - refactor(web): Remove unnecessary code from ResponseHeaderInterceptorTest (#1613)
  - feat(web): Enable extracting Spinnaker related headers from request into authenticated request MDC, by setting the extractSpinnakerHeaders flag to true when creating the AuthenticatedRequestFilter in GateConfig. This allows the propagation of request headers with X-SPINNAKER prefix downstream through the AuthenticatedRequest MDC for consumption e.g. response interceptor (#1612)
  - chore(dependencies): Autobump korkVersion (#1614)
  - chore(dependencies): Autobump korkVersion (#1615)
  - chore(dependencies): Autobump korkVersion (#1616)
  - chore(dependencies): Autobump korkVersion (#1617)
  - chore(dependencies): Autobump korkVersion (#1618)
  - chore(dependencies): Autobump korkVersion (#1619)
  - chore(dependencies): Autobump korkVersion (#1620)
  - fix(tests): Introduce junit5 vintage engine for running junit4 test cases over junit5 in gate (#1623)
  - chore(dependencies): Autobump korkVersion (#1628)
  - chore(dependencies): Autobump korkVersion (#1629)
  - chore(dependencies): Autobump fiatVersion (#1630)
  - chore(dependencies): Autobump korkVersion (#1649)
  - chore(dependencies): Autobump fiatVersion (#1650)

#### Spinnaker Igor - 1.30.2

  - fix(ci): fetch previous tag from git instead of API (#1017) (#1020)
  - chore(ci): Upload halconfigs to GCS on Tag push (#1011) (#1015)
  - chore(dependencies): Autobump fiatVersion (#1009)
  - chore(dependencies): Autobump korkVersion (#1005)
  - chore(dependencies): Autobump korkVersion (#1008)
  - fix(dependency): Issue of missing javax.validation:validation-api dependency while upgrading the spring cloud to Hoxton.SR12 in kork (#1010)
  - chore(ci): Upload halconfigs to GCS on Tag push (#1011)
  - chore(dependencies): Autobump korkVersion (#1012)
  - chore(dependencies): Autobump korkVersion (#1013)
  - fix(ci): fetch previous tag from git instead of API (#1017)
  - chore(ci): Mergify - merge Autobumps on release-* (#1018)
  - Implemented Gitlab CI polling and build property support (#986)
  - chore(dependencies): Autobump korkVersion (#1024)
  - chore(web): remove deprecated endpoints.health.sensitive configuration property (#1023)
  - chore(dependencies): Autobump korkVersion (#1025)
  - chore(dependencies): Autobump korkVersion (#1026)
  - chore(build): Gradle 7 compatibility (#1027)
  - chore(dependencies): Autobump korkVersion (#1028)
  - chore(dependencies): Autobump fiatVersion (#1029)
  - chore(dockerfile): upgrade to latest alpine image (#1030)
  - chore(build): Build docker images for multiple architectures (#1033)
  - chore(dependencies): Autobump korkVersion (#1034)
  - fix(artifacts): ArtifactExtractor is unable to deserialize jsr310 dates (#1035)
  - chore(dependencies): Autobump fiatVersion (#1039)
  - feat(jenkins): Stop Jenkins job when job name as slashes in the job name (#1038)
  - chore(dependencies): Autobump korkVersion (#1040)
  - chore(dependencies): Autobump fiatVersion (#1041)
  - chore(dependencies): Autobump fiatVersion (#1042)
  - chore(dependencies): Autobump korkVersion (#1043)
  - chore(dependencies): Autobump korkVersion (#1044)
  - chore(dependencies): Autobump korkVersion (#1045)
  - chore(dependencies): Autobump korkVersion (#1046)
  - fix(monitor): rename parameter to let spring know what bean inject (#1053)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1055)
  - chore(dependencies): Autobump korkVersion (#1057)
  - chore(dependencies): Autobump korkVersion (#1058)
  - chore(dependencies): Autobump korkVersion (#1059)
  - refactor(web): Clean up redundant spring property in gradle file (#1065)
  - chore(dependencies): Autobump korkVersion (#1066)
  - chore(dependencies): Autobump korkVersion (#1067)
  - chore(dependencies): Autobump korkVersion (#1068)
  - chore(dependencies): Autobump korkVersion (#1069)
  - chore(dependencies): remove dependency on groovy-all where straightforward (#1070)
  - chore(dependencies): Autobump korkVersion (#1071)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1072)
  - fix(gitlabci): Fixed JSON parsing exceptions for unknown GitlabCI pipeline statuses (#1073)
  - chore(dependencies): Autobump korkVersion (#1074)
  - feat(travis): Add redis TTL for queue keys (#1076)
  - fix(travis): Enable legacy log fetching (#1075)
  - chore(dependencies): Autobump korkVersion (#1078)
  - chore(dependencies): Autobump korkVersion (#1079)
  - fix(travis): Redis TTL is given in seconds, not minutes (#1077)
  - chore(dependencies): Autobump korkVersion (#1080)
  - chore(dependencies): Autobump korkVersion (#1081)
  - chore(dependencies): Autobump korkVersion (#1082)
  - chore(dependencies): Autobump korkVersion (#1083)
  - chore(dependencies): Autobump korkVersion (#1084)
  - chore(dependencies): Autobump korkVersion (#1085)
  - chore(dependencies): remove dependency on groovy-all with required groovy package (#1086)
  - chore(dependencies): Autobump korkVersion (#1087)
  - chore(dependencies): Autobump korkVersion (#1088)
  - fix(travis): Don't panic if log fetching fails (#1089)
  - chore(dependencies): Autobump korkVersion (#1097)
  - chore(dependencies): Autobump korkVersion (#1098)
  - chore(dependencies): Autobump fiatVersion (#1099)
  - chore(dependencies): Autobump korkVersion (#1120)
  - chore(dependencies): Autobump fiatVersion (#1121)

#### Spinnaker Kayenta - 1.30.2

  - fix(ci): fetch previous tag from git instead of API (#888) (#891)
  - chore(ci): Upload halconfigs to GCS on Tag push (#884) (#886)
  - chore(dependencies): Autobump orcaVersion (#883)
  - chore(dependencies): Autobump spinnakerGradleVersion (#880)
  - chore(ci): Upload halconfigs to GCS on Tag push (#884)
  - fix(ci): fetch previous tag from git instead of API (#888)
  - chore(ci): Mergify - merge Autobumps on release-* (#889)
  - chore(build): Gradle 7 compatibility (#895)
  - chore(dependencies): add explicit dependency on javax.validation:validation-api (#897)
  - chore(dependencies): Autobump orcaVersion (#896)
  - chore(dockerfile): upgrade to latest alpine image (#900)
  - chore(build): Build docker images for multiple architectures (#903)
  - chore(dependencies): Autobump orcaVersion (#906)
  - fix(integration-tests): change testCompileOnly dependencies to testImplementation (#907)
  - fix(dependency): To enable controlled conflict resolution of direct and transitive dependencies version using kork-bom for upgrading the spring-boot 2.3.x. (#908)
  - fix(test): Issue with kayenta-integration-tests while upgrading spring-boot to 2.3.12 (#909)
  - chore(dependencies): Autobump orcaVersion (#910)
  - feat(influxdb): enhancements and bug fixes (#899)
  - fix(security): Bump commons-text for CVE-2022-42889 (#911)
  - chore(dependencies): Bump orcaVersion (#916)
  - chore(dependencies): Autobump spinnakerGradleVersion (#917)
  - refactor(web): Clean up redundant spring property in gradle file (#925)
  - chore(dependencies): Autobump spinnakerGradleVersion (#927)
  - chore(web): clean up for spring property setup (#928)
  - chore(dependency): unpinning the version of io.rest-assured (#929)
  - chore(cleanup): Doing refactoring of Kayenta to cleanup codebase (#926)
  - chore(dependencies): remove dependency on groovy-all in kayenta (#930)
  - chore(dependencies): Autobump orcaVersion (#931)
  - chore(dependencies): Autobump orcaVersion (#932)
  - feat: SPLAT-569: Add SQL data source for account credentials and account configurations persistence. (#938)
  - chore(dependencies): Autobump orcaVersion (#941)
  - chore(dependencies): Autobump orcaVersion (#956)
  - fix(signalfx): Fixed metric type missing due to duplicated field from parent class (#957) (#958)

#### Spinnaker Orca - 1.30.2

  - fix(ci): fetch previous tag from git instead of API (#4263) (#4266)
  - chore(ci): Upload halconfigs to GCS on Tag push (#4256) (#4261)
  - chore(dependencies): Autobump fiatVersion (#4253)
  - feat(build): bump dependencies for the given branch (#4247)
  - chore(dependencies): Autobump korkVersion (#4252)
  - Fix for size (#4242)
  - fix(dependency): Issue of missing javax.validation and hibernate-validator dependencies while upgrading the spring cloud to Hoxton.SR12 in kork (#4254)
  - chore(ci): Upload halconfigs to GCS on Tag push (#4256)
  - chore(dependencies): Autobump korkVersion (#4257)
  - chore(dependencies): Autobump korkVersion (#4258)
  - feat(stageExecution): supporting extra custom tags for stage execution metrics (#4255)
  - fix(ci): fetch previous tag from git instead of API (#4263)
  - chore(ci): Mergify - merge Autobumps on release-* (#4264)
  - fix(cfn): Fix detection of empty CloudFormation changesets (#4270)
  - chore(dependencies): Autobump korkVersion (#4272)
  - fix(tasks): Fix MonitorPipelineTask regression (#4271)
  - chore(dependencies): Autobump korkVersion (#4273)
  - chore(dependencies): Autobump korkVersion (#4275)
  - feat(orca): add Kustomize 4 support (#4280)
  - fix(restart-pipeline) : CheckPrecondition doesn't evaluate expression correctly when upstream stages get restarted (#4278)
  - chore(tests): redact some data in test (#4281)
  - feat(webhook): Allow webhook retries for selected status codes (#4276)
  - chore(dependencies): Autobump korkVersion (#4282)
  - chore(dependencies): Autobump fiatVersion (#4283)
  - chore(dockerfile): upgrade to latest alpine image (#4284)
  - refactor(groovy): migrating Clouddriver services to Java (#4269)
  - chore(build): Build docker images for multiple architectures (#4288)
  - fix(clouddriver): fix property binding for Clouddriver (#4290)
  - chore(dependencies): Autobump korkVersion (#4291)
  - fix(preconfiguredJobs): Resource requests on custom stage | Error: got "map", expected "string" (#4295)
  - feat(igor): Stop Jenkins job when job name has slashes in the job name (#4294)
  - chore(dependencies): Autobump fiatVersion (#4296)
  - fix(sql): Wrong indentation for rollback in database changelog (#4297)
  - fix(stageExecution): In MJ stages find the correct authenticated user? (#4289)
  - feat(orchestration): provide a way to allow only certain configured ad-hoc operations to be performed (#4195)
  - chore(dependencies): Autobump korkVersion (#4298)
  - chore(dependencies): Autobump fiatVersion (#4299)
  - chore(dependencies): Autobump fiatVersion (#4300)
  - chore(dependencies): Autobump korkVersion (#4302)
  - chore(dependencies): Autobump korkVersion (#4304)
  - chore(dependencies): Autobump korkVersion (#4308)
  - fix(stageExecution): In evaluable variable stage restart scenario variables are not cleaned properly (#16) (#4307)
  - feat(cloudrun): Adding cloudrun provider in orca. (#4279)
  - chore(kubernetes): stop specifying the version of io.kubernetes:client-java (#4310)
  - feat(cloudrun): Adding cloudrun provider in orca. (#4311)
  - chore(dependencies): Autobump korkVersion (#4313)
  - fix(config): restore prior visibility of methods on CloudDriverConfigurationProperties class (#4317)
  - fix(artifacts): Expected Artifacts should be trigger specific (#4322)
  - feat(bakery): add includeCRDs in Helm Bake request (#4324)
  - fix(config): add back public visibility for ClouddriverRetrofitBuilder class (#4331)
  - feat(kubernetes events in orca): Exposes kubernetes events in orca for enhanced logging (#4301)
  - fix(orca): display task exception messages (#4259)
  - feat(bakery): Clean up cached data created by Rosco. (#4323)
  - feat(kubernetes): Introduce blue/green traffic management strategy (#4332)
  - chore(dependencies): Autobump spinnakerGradleVersion (#4337)
  - fix(tasks): Fix MonitorKayentaCanaryTask on results data map (#4312)
  - chore(dependencies): Autobump korkVersion (#4342)
  - chore(dependencies): Autobump korkVersion (#4343)
  - feat(Azure): Update createBakeTask for managed and custom images. (#4336)
  - chore(dependencies): Autobump korkVersion (#4352)
  - feat(AWS): Get the rollback timeout value from stage data. (#4353)
  - feat(k8s): Add support of Deployment kind for Blue/Green deployments. (#4355)
  - refactor(web): Clean up redundant spring property in gradle file (#4359)
  - chore(dependencies): Autobump korkVersion (#4360)
  - chore(dependencies): Autobump korkVersion (#4361)
  - chore(dependencies): Autobump korkVersion (#4362)
  - chore(dependencies): Autobump korkVersion (#4363)
  - chore(dependencies): remove dependency on groovy-all where straightforward (#4364)
  - chore(dependencies): Autobump korkVersion (#4365)
  - feat(bakery): add tasks.monitor-bake.timeout-millis configuration property for MonitorBakeTask timeout (#4367)
  - chore(front50): Make Monitor Pipeline Task timeout overridable (#4347)
  - Fix orca bakery (#4370)
  - chore(dependencies): Autobump spinnakerGradleVersion (#4371)
  - fix(stageExecution): Extend MJ auth propagate logic for exhaustive cases (#4368)
  - feat(tasks): Capture task output data from clouddriver (#4374)
  - fix(dependency): Issue with keiko-redis-spring module while upgrading the spring boot 2.5.x (#4375)
  - chore(dependencies): Autobump korkVersion (#4376)
  - chore(web): clean up for spring property setup (#4377)
  - chore(dependencies): Autobump korkVersion (#4378)
  - chore(dependencies): Autobump korkVersion (#4380)
  - chore(dependencies): Autobump korkVersion (#4381)
  - feat(config): allow configuration of writeable clouddriver endpoints by account and/or cloudProvider (#4287)
  - fix(timeout): Added feature flag for rollback timeout ui input. (#4383)
  - chore(dependencies): Autobump korkVersion (#4390)
  - chore(dependencies): Autobump korkVersion (#4391)
  - chore(dependencies): Autobump korkVersion (#4392)
  - chore(dependencies): Autobump korkVersion (#4393)
  - chore(dependencies): Autobump korkVersion (#4394)
  - chore(dependencies): Autobump korkVersion (#4398)
  - chore(dependencies): Autobump korkVersion (#4399)
  - fix(waiting-executions) : Waiting executions doesn't follow FIFO (#4356)
  - fix(artifacts): Be more lenient when filtering expected artifacts (#4397)
  - fix(artifacts): Stop copying expectedArtifactIds to child pipelines (#4404)
  - Revert "feat(k8s): Add support of Deployment kind for Blue/Green deployments." (#4407)
  - chore(dependencies): Autobump korkVersion (#4411)
  - feat(igor): Default the feature flag which sends the job name as query parameter to on (#4412)
  - chore(dependencies): Autobump korkVersion (#4413)
  - Fix/blue green deploy (#4414)
  - chore(dependencies): Autobump fiatVersion (#4417)
  - chore(dependencies): Autobump korkVersion (#4444)
  - chore(dependencies): Autobump korkVersion (#4444) (#4446)
  - fix(deployment): fixed missing namespace while fetching manifest details from clouddriver (#4453) (#4457)

#### Spinnaker Rosco - 1.30.2

  - chore(ci): Mergify - merge Autobumps on release-* (#878) (#882)
  - fix(halyard): Use Halyard's spinnaker.yml defined Redis (#874) (#876)
  - chore(dependencies): Autobump korkVersion (#866)
  - chore(dependencies): Autobump korkVersion (#868)
  - chore(ci): Upload halconfigs to GCS on Tag push (#869)
  - chore(ci): Halyard expects tar.gz but doesn't gunzip (#870)
  - chore(dependencies): Autobump korkVersion (#871)
  - chore(dependencies): Autobump korkVersion (#872)
  - fix(halyard): Use Halyard's spinnaker.yml defined Redis (#874)
  - fix(ci): fetch previous tag from git instead of API (#877)
  - chore(ci): Mergify - merge Autobumps on release-* (#878)
  - fix(bake): propagate X-SPINNAKER-* headers to clouddriver (#883)
  - chore(dependencies): Autobump korkVersion (#884)
  - chore(dependencies): Autobump korkVersion (#885)
  - Arm64 support (#886)
  - chore(builds): fix github actions builds (#887)
  - chore(dependencies): Autobump korkVersion (#889)
  - chore(dependencies): use org.apache.commons:commons-compress:1.21 to fix multiple vulnerabilities (#888)
  - feat(rosco): add Kustomize 4 support (#891)
  - feature(rosco): Update packer to 1.8.1 (#890)
  - chore(build): Gradle 7 compatibility (#892)
  - chore(dependencies): Autobump korkVersion (#893)
  - chore(dockerfile): upgrade to latest alpine image (#894)
  - chore(security): upgrade codeql to v2 (#897)
  - chore(dependencies): Autobump korkVersion (#898)
  - fix(install): Fixed bugs in postInstall script that causes installation to fail on Ubuntu 20.04 and 22.04 LTS (#899)
  - chore(dependencies): Autobump korkVersion (#903)
  - chore(dependencies): Autobump korkVersion (#904)
  - chore(dependencies): Autobump korkVersion (#905)
  - chore(dependencies): Autobump korkVersion (#906)
  - chore(dependencies): Autobump korkVersion (#907)
  - chore(gha): replace deprecated set-output and save-state commands (#909)
  - feat(azure): baking from another existing image (#910)
  - feat(azure): Improve uniqueness of Azure Bake Key (#911)
  - feat(helm): support for including crds in Helm3 (#913)
  - fix(azure): removing empty params for image name (#914)
  - chore(deps): remove version specification from org.yaml:snakeyaml (#915)
  - feat(bakery): Clean up cached data created by Rosco. (#912)
  - chore(dependencies): Autobump spinnakerGradleVersion (#917)
  - chore(dependencies): Autobump korkVersion (#918)
  - chore(dependencies): Autobump korkVersion (#919)
  - fix(Azure): Update centos default image version. (#916)
  - chore(dependencies): Autobump korkVersion (#923)
  - refactor(web): Clean up redundant spring property in gradle file (#928)
  - Merge pull request from GHSA-wqq8-664f-54hh
  - chore(dependencies): Autobump korkVersion (#930)
  - chore(dependencies): Autobump korkVersion (#931)
  - chore(dependencies): Autobump korkVersion (#932)
  - chore(dependencies): Autobump korkVersion (#933)
  - chore(dependencies): remove dependency on groovy-all where straightforward (#934)
  - chore(dependencies): Autobump korkVersion (#935)
  - chore(dependencies): Autobump spinnakerGradleVersion (#936)
  - chore(dependencies): Autobump korkVersion (#939)
  - chore(web): clean up for spring property setup (#941)
  - chore(dependencies): Autobump korkVersion (#943)
  - chore(dependencies): Autobump korkVersion (#944)
  - chore(dependencies): Autobump korkVersion (#945)
  - chore(dependencies): Autobump korkVersion (#948)
  - chore(dependencies): Autobump korkVersion (#949)
  - chore(dependencies): Autobump korkVersion (#950)
  - chore(dependencies): Autobump korkVersion (#951)
  - chore(dependencies): Autobump korkVersion (#952)
  - chore(dependencies): remove residual dependency on groovy-all in rosco-manifest (#954)
  - chore(dependencies): Autobump korkVersion (#955)
  - chore(dependencies): Autobump korkVersion (#956)
  - fix(tests): Introduce junit5 vintage engine for running junit4 test cases over junit5 in rosco (#958)
  - chore(dependencies): Autobump korkVersion (#961)
  - chore(dependencies): Autobump korkVersion (#962)
  - fix(manifests/test): add org.junit.jupiter:junit-jupiter-engine as a test runtime dependency (#963)
  - chore(dependencies): Autobump korkVersion (#978)

