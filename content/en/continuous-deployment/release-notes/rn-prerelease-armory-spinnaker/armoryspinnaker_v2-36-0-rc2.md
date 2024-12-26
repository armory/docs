---
title: v2.36.0-rc2 Armory Continuous Deployment Release (Spinnaker™ v1.36.0)
toc_hide: true
date: 2024-12-26
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
description: >
  Release notes for Armory Continuous Deployment v2.36.0-rc2. A beta release is not meant for installation in production environments.

---

## 2024/12/26 release notes

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

To install, upgrade, or configure Armory CD 2.36.0-rc2, use Armory Operator 1.70 or later.

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




###  Spinnaker community contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.36.0](https://www.spinnaker.io/changelogs/1.36.0-changelog/) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

<details><summary>Expand to see the BOM</summary>
<pre class="highlight">
<code>artifactSources:
  dockerRegistry: docker.io/armory
dependencies:
  redis:
    commit: null
    version: 2:2.8.4-2
services:
  clouddriver:
    commit: 4cdace1410e84e73c4ea9ac48f9c7a895e3b9976
    version: 2.36.0-rc2
  deck:
    commit: 384f4d4922031162974496e287e265091551bbb4
    version: 2.36.0-rc2
  dinghy:
    commit: 50041173d1a043493409059e7fa5d7a1a80fb553
    version: 2.36.0-rc2
  echo:
    commit: 1a83a99cb4b8cf6e6ca32ab5418666dce6fd2158
    version: 2.36.0-rc2
  fiat:
    commit: c8f5d4381b0a288f554d37ae3d96ae154eccc57d
    version: 2.36.0-rc2
  front50:
    commit: 1daf85e251e2994278f06eb8f3c7df1d92595df2
    version: 2.36.0-rc2
  gate:
    commit: 0e5faf620267761450973a08f8d222fee1a87abe
    version: 2.36.0-rc2
  igor:
    commit: d28f7260388d131de8a9a36cdbc52d3b8d0d0498
    version: 2.36.0-rc2
  kayenta:
    commit: 6f3282cc34552b14e053d0d34397d176814fe46c
    version: 2.36.0-rc2
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 4878c7cf57648f50b67ee28c96a3895271869543
    version: 2.36.0-rc2
  rosco:
    commit: 32a0a65248c02a34f2c811afd5d02928abe26eeb
    version: 2.36.0-rc2
  terraformer:
    commit: 9756bee07eaabbb25b54812996314c22554ec1c0
    version: 2.36.0-rc2
timestamp: "2024-12-26 20:35:49"
version: 2.36.0-rc2
</code>
</pre>
</details>

### Armory


#### Armory Fiat - 2.36.0-rc1...2.36.0-rc2


#### Armory Orca - 2.36.0-rc1...2.36.0-rc2

  - chore(cd): update base orca version to 2024.12.11.15.53.17.release-1.36.x (#968)
  - chore(base): bump latest orca from 1.36.x (#972)

#### Armory Echo - 2.36.0-rc1...2.36.0-rc2


#### Dinghy™ - 2.36.0-rc1...2.36.0-rc2


#### Armory Rosco - 2.36.0-rc1...2.36.0-rc2

  - chore(cd): update base service version to rosco:2024.11.25.15.38.22.release-1.36.x (#704)

#### Armory Kayenta - 2.36.0-rc1...2.36.0-rc2


#### Armory Clouddriver - 2.36.0-rc1...2.36.0-rc2

  - chore(cd): update base service version to clouddriver:2024.12.12.19.01.29.release-1.36.x (#1200)
  - chore(cd): update base service version to clouddriver:2024.12.13.19.41.15.release-1.36.x (#1201)

#### Terraformer™ - 2.36.0-rc1...2.36.0-rc2


#### Armory Deck - 2.36.0-rc1...2.36.0-rc2


#### Armory Igor - 2.36.0-rc1...2.36.0-rc2


#### Armory Front50 - 2.36.0-rc1...2.36.0-rc2


#### Armory Gate - 2.36.0-rc1...2.36.0-rc2



### Spinnaker


#### Spinnaker Fiat - 1.36.0


#### Spinnaker Orca - 1.36.0


#### Spinnaker Echo - 1.36.0


#### Spinnaker Rosco - 1.36.0


#### Spinnaker Kayenta - 1.36.0


#### Spinnaker Clouddriver - 1.36.0

  - fix(ecs): Cloudwatch alarms cleanup on destroy ecs group (#6315) (#6316)
  - feat(aws): CleanupAlarmsAgent with an optional user-defined name pattern (#6317) (#6319)

#### Spinnaker Deck - 1.36.0


#### Spinnaker Igor - 1.36.0


#### Spinnaker Front50 - 1.36.0


#### Spinnaker Gate - 1.36.0


