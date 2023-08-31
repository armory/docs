---
title: v2.30.2 Armory Release (OSS Spinnaker™ v1.30.3)
toc_hide: true
version: 2.30.2
date: 2023-08-29
description: >
  Release notes for Armory Continuous Deployment v2.30.2
---

## 2023/08/29 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a previous working version and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory 2.30.2, use Armory Operator 1.70 or later.

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
{{< include "breaking-changes/bc-plugin-compatibility-2-28-0.md" >}}

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

### Using Custom Resource Status Plugin and Scale Agent generates an error
Armory customers that may be using the Custom Resource Status Plugin (2.0.3) may encounter an error “An attempt was made to call a method that does not exist."
That error will prevent Armory CDSH from starting.

**Workaround**: Customers encountering this issue can downgrade to [Custom Resource Status Plugin (2.0.2)](https://docs.armory.io/plugins/plugin-k8s-custom-resource-status/) as an option until Armory CDSH versions 2.30.3+ or 2.28.7+ are available.

**Affected versions**: Armory CD 2.30.0 and later

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

Trigger Spinnaker pipelines natively when pull requests are opened in BitBucket with newly added events including PR opened, deleted, and declined. See [Triggering pipelines with Bitbucket Server](https://spinnaker.io/docs/guides/user/pipeline/triggers/bitbucket-events/) in the Spinnaker docs for details

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

### **Dinghy PR Checks**

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

### Gate 
* fix: regression in saml configuration that prevented successful configuration of authn/z

###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.30.3](https://www.spinnaker.io/changelogs/1.30.3-changelog/) changelog for details.

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
    commit: 9e69fcd6cd17f31e35eeb7d443cdbf9c2d9ac187
    version: 2.30.2
  deck:
    commit: 7737669d9a68843f448cc4c93ac2a6ea3485f95e
    version: 2.30.2
  dinghy:
    commit: 5250de80948732c8caac6ffc5293a8af80a63a0f
    version: 2.30.2
  echo:
    commit: 56844c654cd1b3981686933a9d5bc68011ee2bae
    version: 2.30.2
  fiat:
    commit: 30319b57d40a7e9fd61067b7e0d9fb73bf9a6c46
    version: 2.30.2
  front50:
    commit: ec0919166ced870668d787708c249945e9291a01
    version: 2.30.2
  gate:
    commit: df941ff5c34d14e794c8784c28a1b30b28754971
    version: 2.30.2
  igor:
    commit: 67b4c66f33b8b97b89e6b052654bebfea460a41f
    version: 2.30.2
  kayenta:
    commit: 4d82ef4a72129a715749005235ce0d6ba4778603
    version: 2.30.2
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 638d81c8d3186b6deb8829574c6ac5b65c88c94a
    version: 2.30.2
  rosco:
    commit: e74de6eaccbed6301505d9f3d2f6745b410211a7
    version: 2.30.2
  terraformer:
    commit: 650746ae3f596f9c6458987487c81840c85dd2a0
    version: 2.30.2
timestamp: "2023-08-29 01:03:06"
version: 2.30.2
</code>
</pre>
</details>

### Armory


#### Terraformer™ - 2.30.1...2.30.2


#### Armory Igor - 2.30.1...2.30.2


#### Armory Clouddriver - 2.30.1...2.30.2

  - chore(cd): update base service version to clouddriver:2023.08.25.16.41.50.release-1.30.x (#933)
  - chore(cd): update base service version to clouddriver:2023.08.28.14.14.14.release-1.30.x (#937)

#### Armory Rosco - 2.30.1...2.30.2


#### Armory Gate - 2.30.1...2.30.2

  - fix: esapi CVE scan report (#602) (#603)

#### Armory Front50 - 2.30.1...2.30.2


#### Armory Deck - 2.30.1...2.30.2


#### Armory Kayenta - 2.30.1...2.30.2


#### Dinghy™ - 2.30.1...2.30.2


#### Armory Fiat - 2.30.1...2.30.2


#### Armory Orca - 2.30.1...2.30.2


#### Armory Echo - 2.30.1...2.30.2



### Spinnaker


#### Spinnaker Igor - 1.30.3


#### Spinnaker Clouddriver - 1.30.3

  - fix(builds): Backport flag for installing aws cli (#6006)

#### Spinnaker Rosco - 1.30.3


#### Spinnaker Gate - 1.30.3


#### Spinnaker Front50 - 1.30.3


#### Spinnaker Deck - 1.30.3


#### Spinnaker Kayenta - 1.30.3


#### Spinnaker Fiat - 1.30.3


#### Spinnaker Orca - 1.30.3


#### Spinnaker Echo - 1.30.3


