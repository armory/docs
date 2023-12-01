---
title: v2.31.0-rc3 Armory Release (OSS Spinnaker™ v1.31.2)
toc_hide: true
date: 2023-11-27
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
description: >
  Release notes for Armory Continuous Deployment v2.31.0-rc3. A beta release is not meant for installation in production environments.

---

## 2023/11/27 Release Notes

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

To install, upgrade, or configure Armory 2.31.0-rc3, use Armory Operator 1.70 or later.

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->




###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.31.2](https://www.spinnaker.io/changelogs/1.31.2-changelog/) changelog for details.

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
    commit: 1db66b13244c3d25b48e767992c5bb7730772271
    version: 2.31.0-rc3
  deck:
    commit: 1dd95e4ef5ed631f24253bf917200c3cf52655af
    version: 2.31.0-rc3
  dinghy:
    commit: 362913af0c5d00eee5ea3b157274cabbef920c43
    version: 2.31.0-rc3
  echo:
    commit: a700e1233d1eca8642b54413c87860737662d4c2
    version: 2.31.0-rc3
  fiat:
    commit: f1079f69f0184aae517680c48283cf9a52c9cf26
    version: 2.31.0-rc3
  front50:
    commit: 5db553c003950174757e6438ba024b6a4b51c9ed
    version: 2.31.0-rc3
  gate:
    commit: 1a4fc24d3d4870c375f6bc10fe6892c6b39a789e
    version: 2.31.0-rc3
  igor:
    commit: e94591b4172e7d75ce94db23ebed5deb756af92d
    version: 2.31.0-rc3
  kayenta:
    commit: 4a528f19b704cc0f25295daef56d27b78a84a25e
    version: 2.31.0-rc3
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: b1a6fe2247ef18f6239b3ab90b101197c57314c4
    version: 2.31.0-rc3
  rosco:
    commit: a30386ed64ae490e4788fe80b453528731a923bd
    version: 2.31.0-rc3
  terraformer:
    commit: 50082463ccd180cb4763078671a105ab70dee5e6
    version: 2.31.0-rc3
timestamp: "2023-11-23 15:13:30"
version: 2.31.0-rc3
</code>
</pre>
</details>

### Armory


#### Armory Fiat - 2.31.0-rc2...2.31.0-rc3

  - chore(cd): update base service version to fiat:2023.08.28.17.11.42.release-1.31.x (#519)

#### Armory Front50 - 2.31.0-rc2...2.31.0-rc3


#### Armory Clouddriver - 2.31.0-rc2...2.31.0-rc3

  - chore(cd): update base service version to clouddriver:2023.11.20.21.43.26.release-1.31.x (#1030)
  - chore(cd): update base service version to clouddriver:2023.11.22.08.49.50.release-1.31.x (#1037)

#### Dinghy™ - 2.31.0-rc2...2.31.0-rc3

  - chore(feat): Support ARM with docker buildx - SAAS-1953 (backport #504) (#511)
  - fix: Builds (#512) (#515)

#### Armory Igor - 2.31.0-rc2...2.31.0-rc3

  - chore(cd): update armory-commons version to 3.14.2 (#475)
  - chore(ci): removed aquasec scan action (#495) (#507)
  - chore(feat): Support ARM with docker buildx - SAAS-1953 (#524) (#525)
  - fix: NoSuchMethodError exception in JenkinsClient. (#377) (#529)
  - chore(cd): update base service version to igor:2023.08.29.04.59.43.release-1.31.x (#488)

#### Armory Gate - 2.31.0-rc2...2.31.0-rc3


#### Armory Echo - 2.31.0-rc2...2.31.0-rc3

  - fix: Upgrade grpc-netty-shaded to address the service initialization failure issue. (#647) (#648)

#### Armory Orca - 2.31.0-rc2...2.31.0-rc3

  - chore(cd): update base orca version to 2023.11.06.18.16.18.release-1.31.x (#763)
  - chore(cd): update base orca version to 2023.11.07.16.19.53.release-1.31.x (#765)
  - chore(build): trigger 2.31.x build (#777)

#### Armory Rosco - 2.31.0-rc2...2.31.0-rc3


#### Terraformer™ - 2.31.0-rc2...2.31.0-rc3


#### Armory Deck - 2.31.0-rc2...2.31.0-rc3


#### Armory Kayenta - 2.31.0-rc2...2.31.0-rc3

  - chore(cd): update base service version to kayenta:2023.08.29.15.29.59.release-1.31.x (#464)


### Spinnaker


#### Spinnaker Fiat - 1.31.2

  - chore(dependencies): Autobump korkVersion (#1023)
  - fix(tests): Introduce junit5 vintage engine for running junit4 test cases over junit5 in fiat (#1025)
  - chore(dependencies): Autobump korkVersion (#1028)
  - fix(logs): Redacted secret data in logs. (#1029)
  - chore(dependencies): Autobump korkVersion (#1033)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1035)
  - feat(exceptions): Add SpinnakerRetrofitErrorHandler and replace RetrofitError catch blocks (#1034)
  - chore(gha): update to docker/login-action@v2 to stay up to date (#1036)
  - chore(dependencies): Autobump korkVersion (#1037)
  - feat(gha): configure dependabot to keep github actions up to date (#1038)
  - chore(deps): bump actions/setup-java from 2 to 3 (#1039)
  - chore(deps): bump google-github-actions/upload-cloud-storage from 0 to 1 (#1040)
  - chore(deps): bump actions/checkout from 2 to 3 (#1043)
  - chore(deps): bump peter-evans/repository-dispatch from 1 to 2 (#1041)
  - chore(deps): bump google-github-actions/auth from 0 to 1 (#1042)
  - chore(gha): replace action for creating github releases (#1044)
  - chore(gha): replace deprecated set-output commands with environment files (#1045)
  - chore(deps): bump docker/build-push-action from 3 to 4 (#1046)
  - chore(dependencies): Autobump korkVersion (#1047)
  - chore(dependencies): Autobump korkVersion (#1048)
  - chore(dependencies): Autobump korkVersion (#1049)
  - chore(dependencies): Autobump korkVersion (#1051)
  - chore(dependencies): Autobump korkVersion (#1052)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1054)
  - refactor(test): prefix redis:5-alpine images with library/ (#1055)
  - chore(dependencies): Autobump korkVersion (#1056)
  - chore(dependencies): Autobump korkVersion (#1057)
  - fix(roles-sync): fix CallableCache's NPE exception for caching synchronization strategy (#1077) (#1081)
  - fix(ssl): Removed unused deprecated okHttpClientConfig from retrofitConfig. (#1082) (#1092)
  - chore(dependencies): Autobump korkVersion (#1095)

#### Spinnaker Front50 - 1.31.2


#### Spinnaker Clouddriver - 1.31.2

  - fix(cats): passing incorrect redis config into interval provider (#6105) (#6108)
  - feat(gcp): provide a configurable option to bypass gcp account health check. (backport #6093) (#6097)

#### Spinnaker Igor - 1.31.2

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
  - chore(dependencies): Autobump spinnakerGradleVersion (#1103)
  - chore(dependencies): Autobump fiatVersion (#1105)
  - chore(gha): update to docker/login-action@v2 to stay up to date (#1106)
  - chore(dependencies): Autobump korkVersion (#1107)
  - chore(dependencies): Autobump fiatVersion (#1108)
  - feat(gha): configure dependabot to keep github actions up to date (#1109)
  - chore(deps): bump actions/setup-java from 2 to 3 (#1111)
  - chore(deps): bump google-github-actions/upload-cloud-storage from 0 to 1 (#1110)
  - chore(deps): bump google-github-actions/auth from 0 to 1 (#1112)
  - chore(deps): bump docker/build-push-action from 2 to 4 (#1114)
  - chore(deps): bump actions/checkout from 2 to 3 (#1113)
  - chore(gha): replace action for creating github releases (#1115)
  - chore(gha): replace deprecated set-output commands with environment files (#1116)
  - chore(dependencies): Autobump korkVersion (#1117)
  - chore(dependencies): Autobump korkVersion (#1118)
  - chore(dependencies): Autobump korkVersion (#1119)
  - chore(dependencies): Autobump korkVersion (#1122)
  - chore(dependencies): Autobump korkVersion (#1123)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1127)
  - feat(travis): Add another Travis termination string (#1131)
  - chore(dependencies): Autobump korkVersion (#1132)
  - chore(dependencies): Autobump korkVersion (#1133)
  - chore(dependencies): Autobump fiatVersion (#1134)
  - chore(dependencies): Autobump korkVersion (#1162)
  - chore(dependencies): Autobump fiatVersion (#1163)

#### Spinnaker Gate - 1.31.2


#### Spinnaker Echo - 1.31.2


#### Spinnaker Orca - 1.31.2

  - fix(artifacts): Parent and child pipeline artifact resolution (backport #4575) (#4582)
  - fix(artifacts): Automated triggers with artifact constraints are broken if you have 2 or more of the same type (backport #4579) (#4587)

#### Spinnaker Rosco - 1.31.2


#### Spinnaker Deck - 1.31.2


#### Spinnaker Kayenta - 1.31.2

  - chore(cleanup): Doing refactoring of Kayenta to cleanup codebase (#926)
  - chore(dependencies): remove dependency on groovy-all in kayenta (#930)
  - chore(dependencies): Autobump orcaVersion (#931)
  - chore(dependencies): Autobump orcaVersion (#932)
  - feat: SPLAT-569: Add SQL data source for account credentials and account configurations persistence. (#938)
  - chore(dependencies): Autobump orcaVersion (#941)
  - chore(dependencies): Autobump spinnakerGradleVersion (#945)
  - chore(gha): update to docker/login-action@v2 to stay up to date (#946)
  - chore(dependencies): Autobump orcaVersion (#947)
  - feat(gha): configure dependabot to keep github actions up to date (#948)
  - chore(deps): bump actions/checkout from 2 to 3 (#949)
  - chore(deps): bump google-github-actions/upload-cloud-storage from 0 to 1 (#950)
  - chore(deps): bump google-github-actions/auth from 0 to 1 (#953)
  - chore(deps): bump actions/setup-java from 2 to 3 (#951)
  - chore(deps): bump docker/build-push-action from 3 to 4 (#952)
  - chore(gha): replace action for creating github releases (#954)
  - chore(gha): replace deprecated set-output commands with environment files (#955)
  - feat: SPLAT-582: Add a storage data migrator. (#940)
  - fix(signalfx): Fixed metric type missing due to duplicated field from parent class (#957)
  - feat: Add API endpoint to remove account credentials by account name(id) (#939)
  - chore(dependencies): Autobump spinnakerGradleVersion (#960)
  - refactor(deprecation): remove deprecated gradle constructs/features from kayenta in order to upgrade gradle 7 (#961)
  - chore(dependencies): Autobump orcaVersion (#966)
  - fix(orca): Fix orca contributors status. (backport #977) (#980)
  - chore(dependencies): Autobump orcaVersion (#983)

