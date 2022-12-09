---
title: v2.28.1-rc4 Armory Release (OSS Spinnaker™ v1.28.1)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
description: >
  Release notes for Armory Enterprise v2.28.1-rc4. A beta release is not meant for installation in production environments.

---

## 2022/11/11 Release Notes

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

To install, upgrade, or configure Armory 2.28.1-rc4, use Armory Operator 1.70 or later.

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
[Spinnaker v1.28.1](https://www.spinnaker.io/changelogs/1.28.1-changelog/) changelog for details.

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
    commit: 9216f0fae587d3af14ed41fb9f21e9195b30c269
    version: 2.28.1-rc4
  deck:
    commit: bd4fb67ec81c5e201b31b4e3e7829dff93476580
    version: 2.28.1-rc4
  dinghy:
    commit: fc867f05b41e5e2756c42990b576341973e96276
    version: 2.28.1-rc4
  echo:
    commit: 010bdc55d57c1000ef93f826204e6ccf54f6f6e7
    version: 2.28.1-rc4
  fiat:
    commit: fce52482097b606389328d25d220be5eaaddab21
    version: 2.28.1-rc4
  front50:
    commit: 1e5d3a5dfce38d26f809dee107d8145c00caa27e
    version: 2.28.1-rc4
  gate:
    commit: 4615a016768bf7e772189da05415d654a440e107
    version: 2.28.1-rc4
  igor:
    commit: e7e01c998423941507a7322e6891ea6e95a16792
    version: 2.28.1-rc4
  kayenta:
    commit: 6004bfd90ad2e4fa9b02dddc26253210b8aa3a3c
    version: 2.28.1-rc4
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 583b59cfcea93cce9b221509d0d4ec03a9487939
    version: 2.28.1-rc4
  rosco:
    commit: 88567fc0c710c63b2093fc95e674052314978250
    version: 2.28.1-rc4
  terraformer:
    commit: bb576e57561db2d957c25e00992e24f53a223bd5
    version: 2.28.1-rc4
timestamp: "2022-11-11 02:41:34"
version: 2.28.1-rc4
</code>
</pre>
</details>

### Armory


#### Armory Fiat - 2.28.1-rc3...2.28.1-rc4


#### Armory Front50 - 2.28.1-rc3...2.28.1-rc4


#### Armory Igor - 2.28.1-rc3...2.28.1-rc4


#### Armory Kayenta - 2.28.1-rc3...2.28.1-rc4


#### Armory Rosco - 2.28.1-rc3...2.28.1-rc4


#### Armory Orca - 2.28.1-rc3...2.28.1-rc4


#### Armory Deck - 2.28.1-rc3...2.28.1-rc4


#### Terraformer™ - 2.28.1-rc3...2.28.1-rc4


#### Armory Clouddriver - 2.28.1-rc3...2.28.1-rc4


#### Dinghy™ - 2.28.1-rc3...2.28.1-rc4


#### Armory Gate - 2.28.1-rc3...2.28.1-rc4

  - chore(cd): update base service version to gate:2022.10.19.18.23.12.release-1.28.x (#480)
  - chore(cd): update base service version to gate:2022.10.19.20.00.40.release-1.28.x (#481)
  - fix(header): update plugins.json with newest header version (backport #482) (#483)

#### Armory Echo - 2.28.1-rc3...2.28.1-rc4



### Spinnaker


#### Spinnaker Fiat - 1.28.1


#### Spinnaker Front50 - 1.28.1


#### Spinnaker Igor - 1.28.1


#### Spinnaker Kayenta - 1.28.1


#### Spinnaker Rosco - 1.28.1


#### Spinnaker Orca - 1.28.1


#### Spinnaker Deck - 1.28.1


#### Spinnaker Clouddriver - 1.28.1


#### Spinnaker Gate - 1.28.1

  - chore(dependencies): Autobump korkVersion (#1581)
  - chore(dependencies): Autobump fiatVersion (#1582)

#### Spinnaker Echo - 1.28.1


