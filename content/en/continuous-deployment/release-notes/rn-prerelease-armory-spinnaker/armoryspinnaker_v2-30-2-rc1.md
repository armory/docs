---
title: v2.30.2-rc1 Armory Release (OSS Spinnaker™ v1.30.3)
toc_hide: true
date: 2023-08-29
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
description: >
  Release notes for Armory Continuous Deployment v2.30.2-rc1. A beta release is not meant for installation in production environments.

---

## 2023/08/29 Release Notes

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

To install, upgrade, or configure Armory 2.30.2-rc1, use Armory Operator 1.70 or later.

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
    version: 2.30.2-rc1
  deck:
    commit: 7737669d9a68843f448cc4c93ac2a6ea3485f95e
    version: 2.30.2-rc1
  dinghy:
    commit: 5250de80948732c8caac6ffc5293a8af80a63a0f
    version: 2.30.2-rc1
  echo:
    commit: 56844c654cd1b3981686933a9d5bc68011ee2bae
    version: 2.30.2-rc1
  fiat:
    commit: 30319b57d40a7e9fd61067b7e0d9fb73bf9a6c46
    version: 2.30.2-rc1
  front50:
    commit: ec0919166ced870668d787708c249945e9291a01
    version: 2.30.2-rc1
  gate:
    commit: df941ff5c34d14e794c8784c28a1b30b28754971
    version: 2.30.2-rc1
  igor:
    commit: 67b4c66f33b8b97b89e6b052654bebfea460a41f
    version: 2.30.2-rc1
  kayenta:
    commit: 4d82ef4a72129a715749005235ce0d6ba4778603
    version: 2.30.2-rc1
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 638d81c8d3186b6deb8829574c6ac5b65c88c94a
    version: 2.30.2-rc1
  rosco:
    commit: e74de6eaccbed6301505d9f3d2f6745b410211a7
    version: 2.30.2-rc1
  terraformer:
    commit: 650746ae3f596f9c6458987487c81840c85dd2a0
    version: 2.30.2-rc1
timestamp: "2023-08-29 01:03:06"
version: 2.30.2-rc1
</code>
</pre>
</details>

### Armory


#### Armory Clouddriver - 2.30.1...2.30.2-rc1

  - chore(cd): update base service version to clouddriver:2023.08.25.16.41.50.release-1.30.x (#933)
  - chore(cd): update base service version to clouddriver:2023.08.28.14.14.14.release-1.30.x (#937)

#### Armory Deck - 2.30.1...2.30.2-rc1


#### Dinghy™ - 2.30.1...2.30.2-rc1


#### Armory Echo - 2.30.1...2.30.2-rc1


#### Armory Fiat - 2.30.1...2.30.2-rc1


#### Armory Front50 - 2.30.1...2.30.2-rc1


#### Armory Gate - 2.30.1...2.30.2-rc1

  - fix: esapi CVE scan report (#602) (#603)

#### Armory Igor - 2.30.1...2.30.2-rc1


#### Armory Kayenta - 2.30.1...2.30.2-rc1


#### Armory Orca - 2.30.1...2.30.2-rc1


#### Armory Rosco - 2.30.1...2.30.2-rc1


#### Terraformer™ - 2.30.1...2.30.2-rc1



### Spinnaker


#### Spinnaker Clouddriver - 1.30.3

#### Spinnaker Deck - 1.30.3


#### Spinnaker Echo - 1.30.3


#### Spinnaker Fiat - 1.30.3


#### Spinnaker Front50 - 1.30.3


#### Spinnaker Gate - 1.30.3


#### Spinnaker Igor - 1.30.3


#### Spinnaker Kayenta - 1.30.3


#### Spinnaker Orca - 1.30.3


#### Spinnaker Rosco - 1.30.3


