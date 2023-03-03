---
title: v2.27.6-rc1 Armory Release (OSS Spinnaker™ v1.27.3)
toc_hide: true
date: 2023-01-19
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
description: >
  Release notes for Armory Continuous Deployment v2.27.6-rc1. A beta release is not meant for installation in production environments.

---

## 2023/01/19 Release Notes

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

To install, upgrade, or configure Armory 2.27.6-rc1, use Armory Operator 1.70 or later.

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
[Spinnaker v1.27.3](https://www.spinnaker.io/changelogs/1.27.3-changelog/) changelog for details.

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
    commit: c978d08b3f5d155e8efbfb9010520d848bf4a93c
    version: 2.27.6-rc1
  deck:
    commit: 0802cbb92aa32eb6b387b5a6e54db14843fc6f31
    version: 2.27.6-rc1
  dinghy:
    commit: ca161395d61ae5e93d1f9ecfbb503b68c2b54bc5
    version: 2.27.6-rc1
  echo:
    commit: ed3c35253d27af121a5a6874de9b006d3b5d3bcf
    version: 2.27.6-rc1
  fiat:
    commit: b3ca6748d2377454949420613e7912748ea00b52
    version: 2.27.6-rc1
  front50:
    commit: 5e1fe36c4b8df29cc9cb4d7af581a44b0ca44e59
    version: 2.27.6-rc1
  gate:
    commit: adf9732bc7b3c8df48b21b86ef9783efcadec78b
    version: 2.27.6-rc1
  igor:
    commit: 9e2d7946da19c803eb0bd12e888c5119528a364c
    version: 2.27.6-rc1
  kayenta:
    commit: 5a1efcefddfe78f37550f5bee723570e3737ce04
    version: 2.27.6-rc1
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: fa3449f0202512534382d2d2a0431f25f4f408c5
    version: 2.27.6-rc1
  rosco:
    commit: f4164fdcfa275b62e0c0fefbe26b5cbd845c543d
    version: 2.27.6-rc1
  terraformer:
    commit: f845ba2fc760c46b98794a10c32cc2b713c7c9e0
    version: 2.27.6-rc1
timestamp: "2023-01-10 18:31:01"
version: 2.27.6-rc1
</code>
</pre>
</details>

### Armory


#### Dinghy™ - 2.27.5...2.27.6-rc1


#### Armory Clouddriver - 2.27.5...2.27.6-rc1

  - feat(google): Updated google cloud SDK to support GKE >1.26 (#769) (#771)

#### Armory Deck - 2.27.5...2.27.6-rc1

  - style(logo): Changed Armory logo (#1264) (#1266)

#### Armory Fiat - 2.27.5...2.27.6-rc1

  - chore(cd): update base service version to fiat:2022.11.18.19.29.05.release-1.27.x (#408)

#### Armory Front50 - 2.27.5...2.27.6-rc1

  - chore(cd): update base service version to front50:2022.12.01.21.15.09.release-1.27.x (#473)

#### Armory Echo - 2.27.5...2.27.6-rc1


#### Armory Kayenta - 2.27.5...2.27.6-rc1

  - fix(kayenta-integration-tests): update dynatrace tenant to qso00828 (backport #376) (#378)
  - chore(cd): update base service version to kayenta:2022.12.01.22.29.56.release-1.27.x (#373)

#### Armory Gate - 2.27.5...2.27.6-rc1


#### Terraformer™ - 2.27.5...2.27.6-rc1

  - fix(versions): Sets version constraints for kubectl & aws-iam-authent… (backport #487) (#488)
  - Fixes builds with golint being dead until were on a newer golang (#491) (#494)
  - feat(gcloud): Bump to latest gcloud sdk & adds the GKE Auth plugin (#490) (#492)

#### Armory Igor - 2.27.5...2.27.6-rc1


#### Armory Orca - 2.27.5...2.27.6-rc1


#### Armory Rosco - 2.27.5...2.27.6-rc1



### Spinnaker


#### Spinnaker Clouddriver - 1.27.3


#### Spinnaker Deck - 1.27.3


#### Spinnaker Fiat - 1.27.3

  - fix(permissions): ensure lower case for resource name in fiat_permission and fiat_resource tables (backport #963) (#979)
  - chore(build): set timeout for apt publishing to 5 minutes (#987)
  - chore(build): set timeout for apt publishing to 10 minutes and add --stacktrace (#988)
  - chore(dependencies): Autobump spinnakerGradleVersion (#989) (#990)
  - Cleanup publish debugging (#991)

#### Spinnaker Front50 - 1.27.3

  - chore(dependencies): Autobump fiatVersion (#1178)
  - fix(pipelines): prevent from creating duplicated pipelines (#1172) (#1173)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1177) (#1182)
  - chore(gha): bump versions of github actions (#1185)

#### Spinnaker Echo - 1.27.3


#### Spinnaker Kayenta - 1.27.3

  - fix(security): Bump commons-text for CVE-2022-42889 (#911) (#913)
  - chore(dependencies): Autobump orcaVersion (#918)
  - chore(dependencies): Autobump orcaVersion (#919)
  - chore(dependencies): Autobump spinnakerGradleVersion (#917) (#920)

#### Spinnaker Gate - 1.27.3


#### Spinnaker Igor - 1.27.3


#### Spinnaker Orca - 1.27.3


#### Spinnaker Rosco - 1.27.3


