---
title: v2.30.1-rc1 Armory Release (OSS Spinnaker™ v1.30.3)
toc_hide: true
date: 2023-08-22
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
description: >
  Release notes for Armory Continuous Deployment v2.30.1-rc1. A beta release is not meant for installation in production environments.

---

## 2023/08/22 Release Notes

## Disclaimer

This pre-release software is to allow limited access to test or beta versions of the Armory services (“Services”) and to provide feedback and comments to Armory regarding the use of such Services. By using Services, you agree to be bound by the terms and conditions set forth herein.

Your Feedback is important and we welcome any feedback, analysis, suggestions and comments (including, but not limited to, bug reports and test results) (collectively, “Feedback”) regarding the Services. Any Feedback you provide will become the property of Armory and you agree that Armory may use or otherwise exploit all or part of your feedback or any derivative thereof in any manner without any further remuneration, compensation or credit to you. You represent and warrant that any Feedback which is provided by you hereunder is original work made solely by you and does not infringe any third party intellectual property rights.

Any Feedback provided to Armory shall be considered Armory Confidential Information and shall be covered by any confidentiality agreements between you and Armory.

You acknowledge that you are using the Services on a purely voluntary basis, as a means of assisting, and in consideration of the opportunity to assist Armory to use, implement, and understand various facets of the Services. You acknowledge and agree that nothing herein or in your voluntary submission of Feedback creates any employment relationship between you and Armory.

Armory may, in its sole discretion, at any time, terminate or discontinue all or your access to the Services. You acknowledge and agree that all such decisions by Armory are final and Armory will have no liability with respect to such decisions.

YOUR USE OF THE SERVICES IS AT YOUR OWN RISK. THE SERVICES, THE ARMORY TOOLS AND THE CONTENT ARE PROVIDED ON AN “AS IS” BASIS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED. ARMORY AND ITS LICENSORS MAKE NO REPRESENTATION, WARRANTY, OR GUARANTY AS TO THE RELIABILITY, TIMELINESS, QUALITY, SUITABILITY, TRUTH, AVAILABILITY, ACCURACY OR COMPLETENESS OF THE SERVICES, THE ARMORY TOOLS OR ANY CONTENT. ARMORY EXPRESSLY DISCLAIMS ON ITS OWN BEHALF AND ON BEHALF OF ITS EMPLOYEES, AGENTS, ATTORNEYS, CONSULTANTS, OR CONTRACTORS ANY AND ALL WARRANTIES INCLUDING, WITHOUT LIMITATION (A) THE USE OF THE SERVICES OR THE ARMORY TOOLS WILL BE TIMELY, UNINTERRUPTED OR ERROR-FREE OR OPERATE IN COMBINATION WITH ANY OTHER HARDWARE, SOFTWARE, SYSTEM OR DATA, (B) THE SERVICES AND THE ARMORY TOOLS AND/OR THEIR QUALITY WILL MEET CUSTOMER”S REQUIREMENTS OR EXPECTATIONS, (C) ANY CONTENT WILL BE ACCURATE OR RELIABLE, (D) ERRORS OR DEFECTS WILL BE CORRECTED, OR (E) THE SERVICES, THE ARMORY TOOLS OR THE SERVER(S) THAT MAKE THE SERVICES AVAILABLE ARE FREE OF VIRUSES OR OTHER HARMFUL COMPONENTS. CUSTOMER AGREES THAT ARMORY SHALL NOT BE RESPONSIBLE FOR THE AVAILABILITY OR ACTS OR OMISSIONS OF ANY THIRD PARTY, INCLUDING ANY THIRD-PARTY APPLICATION OR PRODUCT, AND ARMORY HEREBY DISCLAIMS ANY AND ALL LIABILITY IN CONNECTION WITH SUCH THIRD PARTIES.

IN NO EVENT SHALL ARMORY, ITS EMPLOYEES, AGENTS, ATTORNEYS, CONSULTANTS, OR CONTRACTORS BE LIABLE UNDER THIS AGREEMENT FOR ANY CONSEQUENTIAL, SPECIAL, LOST PROFITS, INDIRECT OR OTHER DAMAGES, INCLUDING BUT NOT LIMITED TO LOST PROFITS, LOSS OF BUSINESS, COST OF COVER WHETHER BASED IN CONTRACT, TORT (INCLUDING NEGLIGENCE), OR OTHERWISE, EVEN IF ARMORY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES AND NOTWITHSTANDING ANY FAILURE OF ESSENTIAL PURPOSE OF ANY LIMITED REMEDY. IN ANY EVENT, ARMORY, ITS EMPLOYEES’, AGENTS’, ATTORNEYS’, CONSULTANTS’ OR CONTRACTORS’ AGGREGATE LIABILITY UNDER THIS AGREEMENT FOR ANY CLAIM SHALL BE STRICTLY LIMITED TO $100.00. SOME STATES DO NOT ALLOW THE LIMITATION OR EXCLUSION OF LIABILITY FOR INCIDENTAL OR CONSEQUENTIAL DAMAGES, SO THE ABOVE LIMITATION OR EXCLUSION MAY NOT APPLY TO YOU.

You acknowledge that Armory has provided the Services in reliance upon the limitations of liability set forth herein and that the same is an essential basis of the bargain between the parties.


## Required Armory Operator version

To install, upgrade, or configure Armory 2.30.1-rc1, use Armory Operator 1.70 or later.

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

### Orca requires RDBMS configured for UTF-8 encoding
**Impact**

- 2.28.6 migrates to the AWS MySQL driver from the OSS MySQL drivers.  This change is mostly seamless, but we’ve identified one breaking change.  If your database was created without utf8mb4 you will see failures after this upgrade.  utf8mb4 is the recommended DB format for any Spinnaker database, and we don’t anticipate most users who’ve followed setup instructions to encounter this failure. However, we’re calling out this change as a safeguard.

{{< include "breaking-changes/bc-kubectl-120.md" >}}
{{< include "breaking-changes/bc-plugin-compatibility-2-28-0.md" >}}

**Introduced in**: Armory CD 2.28.6


## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

### Kayenta errors on startup
In some instances Kayenta will error because the *DiscoveryCompositeHealthContributor* does not implement *HealthIndicator.* There is a fix for this issue that should land in the next dot release.

**Affected versions**: Armory CD 2.30.0

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

### Clouddriver
* Fixed AWS CLI pip installation
* feat: Add the possibility to update the default handler for the Global Resource Property Registry. Due to the fact it is not possible to override the default handler behavior from a Spinnaker plugin code, we introduced a new setter function specifically designed to update the default handler for the Global Resource.
* fix(gce): remove the duplicate cache attribute "subnet" 

### Orca
* fix(waiting-executions) : Waiting executions doesn't follow FIFO. The fix makes Changes to push *StartWaitingExecutions* to the queue only when execution status is not running and disabled concurrent executions, in all other cases no need to push *StartWaitingExecutions* to the queue.

### Terraformer
* Session duration support on AWS roles

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
    commit: e83f27627c37921732db249ca823b2e6485a6f97
    version: 2.30.1-rc1
  deck:
    commit: 7737669d9a68843f448cc4c93ac2a6ea3485f95e
    version: 2.30.1-rc1
  dinghy:
    commit: 5250de80948732c8caac6ffc5293a8af80a63a0f
    version: 2.30.1-rc1
  echo:
    commit: 56844c654cd1b3981686933a9d5bc68011ee2bae
    version: 2.30.1-rc1
  fiat:
    commit: 12e4ccd27d90b556a65ffc76231ae84623e38e84
    version: 2.30.1-rc1
  front50:
    commit: ec0919166ced870668d787708c249945e9291a01
    version: 2.30.1-rc1
  gate:
    commit: 2dc9b4b767ab502faaa1b99c131eb7263cf519da
    version: 2.30.1-rc1
  igor:
    commit: 67b4c66f33b8b97b89e6b052654bebfea460a41f
    version: 2.30.1-rc1
  kayenta:
    commit: aafaf170d12818396f867b7370fdd2fd10048bfe
    version: 2.30.1-rc1
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 638d81c8d3186b6deb8829574c6ac5b65c88c94a
    version: 2.30.1-rc1
  rosco:
    commit: e74de6eaccbed6301505d9f3d2f6745b410211a7
    version: 2.30.1-rc1
  terraformer:
    commit: 650746ae3f596f9c6458987487c81840c85dd2a0
    version: 2.30.1-rc1
timestamp: "2023-08-22 21:26:19"
version: 2.30.1-rc1
</code>
</pre>
</details>

### Armory


#### Armory Clouddriver - 2.30.0...2.30.1-rc1

  - chore(cd): update base service version to clouddriver:2023.07.19.19.07.34.release-1.30.x (#902)
  - chore(cd): update base service version to clouddriver:2023.07.21.18.23.46.release-1.30.x (#905)
  - chore(kubectl): upgrade kubectl version from 1.20.6 to 1.22.17 (backport #878) (#917)
  - chore(cd): update base service version to clouddriver:2023.08.17.03.37.47.release-1.30.x (#920)
  - chore(cd): update base service version to clouddriver:2023.08.17.06.57.33.release-1.30.x (#922)
  - chore(cd): update base service version to clouddriver:2023.08.18.20.50.29.release-1.30.x (#923)
  - fix: AWS CLI pip installation (#918) (#925)
  - chore(cd): update base service version to clouddriver:2023.08.18.23.44.54.release-1.30.x (#926)

#### Terraformer™ - 2.30.0...2.30.1-rc1

  - Session duration support on AWS roles (#500) (#503)
  - fix: One more session timeout place (#501) (#505)

#### Armory Igor - 2.30.0...2.30.1-rc1

  - chore(cd): update base service version to igor:2023.08.17.02.51.58.release-1.30.x (#480)
  - chore(cd): update base service version to igor:2023.08.17.04.46.32.release-1.30.x (#481)
  - chore(cd): update base service version to igor:2023.08.18.20.06.35.release-1.30.x (#483)
  - chore(cd): update base service version to igor:2023.08.18.23.01.56.release-1.30.x (#484)

#### Armory Rosco - 2.30.0...2.30.1-rc1

  - chore(cd): update base service version to rosco:2023.08.17.02.48.33.release-1.30.x (#558)
  - chore(cd): update base service version to rosco:2023.08.18.20.06.48.release-1.30.x (#559)

#### Armory Front50 - 2.30.0...2.30.1-rc1

  - chore(cd): update base service version to front50:2023.08.18.20.06.26.release-1.30.x (#576)
  - chore(cd): update base service version to front50:2023.08.18.23.02.05.release-1.30.x (#577)

#### Armory Fiat - 2.30.0...2.30.1-rc1

  - chore(cd): update base service version to fiat:2023.08.17.02.48.22.release-1.30.x (#511)
  - chore(cd): update base service version to fiat:2023.08.18.20.06.20.release-1.30.x (#512)

#### Armory Deck - 2.30.0...2.30.1-rc1


#### Dinghy™ - 2.30.0...2.30.1-rc1


#### Armory Orca - 2.30.0...2.30.1-rc1

  - chore(cd): update base orca version to 2023.08.15.19.18.48.release-1.30.x (#677)
  - chore(cd): update base orca version to 2023.08.17.02.56.00.release-1.30.x (#679)
  - chore(cd): update base orca version to 2023.08.17.04.55.06.release-1.30.x (#681)
  - chore(cd): update base orca version to 2023.08.18.20.16.18.release-1.30.x (#683)
  - chore(cd): update base orca version to 2023.08.18.23.14.04.release-1.30.x (#684)

#### Armory Echo - 2.30.0...2.30.1-rc1

  - chore(cd): update base service version to echo:2023.08.17.02.52.47.release-1.30.x (#604)
  - chore(cd): update base service version to echo:2023.08.17.04.48.12.release-1.30.x (#606)
  - chore(cd): update base service version to echo:2023.08.18.20.06.15.release-1.30.x (#607)
  - chore(cd): update base service version to echo:2023.08.18.23.04.19.release-1.30.x (#608)

#### Armory Gate - 2.30.0...2.30.1-rc1

  - chore(cd): update base service version to gate:2023.08.17.02.52.18.release-1.30.x (#592)
  - chore(cd): update base service version to gate:2023.08.17.04.50.02.release-1.30.x (#593)
  - chore(cd): update base service version to gate:2023.08.18.20.06.31.release-1.30.x (#595)
  - chore(cd): update base service version to gate:2023.08.18.23.02.38.release-1.30.x (#596)

#### Armory Kayenta - 2.30.0...2.30.1-rc1

  - chore(cd): update base service version to kayenta:2023.08.17.05.53.17.release-1.30.x (#458)
  - chore(cd): update base service version to kayenta:2023.08.19.00.43.42.release-1.30.x (#461)


### Spinnaker


#### Spinnaker Clouddriver - 1.30.3

  - feat: Add the possibility to update the default handler for the Global Resource Property Registry. (#5963) (#5973)
  - fix(gce): remove the duplicate cache attribute "subnet" and update the test (#5977) (#5986)
  - chore(dependencies): Autobump korkVersion (#5998)
  - chore(dependencies): Autobump fiatVersion (#5999)
  - chore(dependencies): Autobump korkVersion (#6001)
  - chore(dependencies): Autobump fiatVersion (#6002)

#### Spinnaker Igor - 1.30.3

  - chore(dependencies): Autobump korkVersion (#1155)
  - chore(dependencies): Autobump fiatVersion (#1156)
  - chore(dependencies): Autobump korkVersion (#1158)
  - chore(dependencies): Autobump fiatVersion (#1159)

#### Spinnaker Rosco - 1.30.3

  - chore(dependencies): Autobump korkVersion (#1010)
  - chore(dependencies): Autobump korkVersion (#1011)

#### Spinnaker Front50 - 1.30.3

  - chore(dependencies): Autobump korkVersion (#1292)
  - chore(dependencies): Autobump fiatVersion (#1293)
  - chore(dependencies): Autobump korkVersion (#1295)
  - chore(dependencies): Autobump fiatVersion (#1296)

#### Spinnaker Fiat - 1.30.3

  - chore(dependencies): Autobump korkVersion (#1088)
  - chore(dependencies): Autobump korkVersion (#1089)

#### Spinnaker Deck - 1.30.3


#### Spinnaker Orca - 1.30.3

  - fix(waiting-executions) : concurrent waiting executions doesn't follow FIFO (backport #4415) (#4503)
  - chore(dependencies): Autobump korkVersion (#4505)
  - chore(dependencies): Autobump fiatVersion (#4506)
  - chore(dependencies): Autobump korkVersion (#4509)
  - chore(dependencies): Autobump fiatVersion (#4510)

#### Spinnaker Echo - 1.30.3

  - fix(gha): Fix github status log and add tests (#1316) (#1317)
  - chore(dependencies): Autobump korkVersion (#1326)
  - chore(dependencies): Autobump fiatVersion (#1327)
  - chore(dependencies): Autobump korkVersion (#1329)
  - chore(dependencies): Autobump fiatVersion (#1330)

#### Spinnaker Gate - 1.30.3

  - chore(dependencies): Autobump korkVersion (#1687)
  - chore(dependencies): Autobump fiatVersion (#1688)
  - chore(dependencies): Autobump korkVersion (#1690)
  - chore(dependencies): Autobump fiatVersion (#1691)

#### Spinnaker Kayenta - 1.30.3

  - chore(dependencies): Autobump orcaVersion (#978)
  - chore(dependencies): Autobump orcaVersion (#982)

