---
title: v2.31.1-rc1 Armory Continuous Deployment Release (Spinnaker™ v1.31.3)
toc_hide: true
date: 2024-02-05
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
description: >
  Release notes for Armory Continuous Deployment v2.31.1-rc1. A beta release is not meant for installation in production environments.

---

## 2024/02/05 release notes

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

To install, upgrade, or configure Armory CD 2.31.1-rc1, use Armory Operator 1.70 or later.

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
[Spinnaker v1.31.3](https://www.spinnaker.io/changelogs/1.31.3-changelog/) changelog for details.

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
    commit: 1db66b13244c3d25b48e767992c5bb7730772271
    version: 2.31.1-rc1
  deck:
    commit: 1dd95e4ef5ed631f24253bf917200c3cf52655af
    version: 2.31.1-rc1
  dinghy:
    commit: 362913af0c5d00eee5ea3b157274cabbef920c43
    version: 2.31.1-rc1
  echo:
    commit: a700e1233d1eca8642b54413c87860737662d4c2
    version: 2.31.1-rc1
  fiat:
    commit: f1079f69f0184aae517680c48283cf9a52c9cf26
    version: 2.31.1-rc1
  front50:
    commit: 592471c8b5b45d0f5012d218f839921b91d6ae5c
    version: 2.31.1-rc1
  gate:
    commit: f0d8fde54a472050d32c2f6aee44fdd110e7382d
    version: 2.31.1-rc1
  igor:
    commit: 15c26af7729f7695edb835af225c4b5811ddd8c6
    version: 2.31.1-rc1
  kayenta:
    commit: e5c68b27dabe7675140805485b7bd60758a858f3
    version: 2.31.1-rc1
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 60004db47f9d73ed7e8972f75783d64f2885df35
    version: 2.31.1-rc1
  rosco:
    commit: a8ff067ff32d892f9bf29102d4ac663eeed1b4a0
    version: 2.31.1-rc1
  terraformer:
    commit: 50082463ccd180cb4763078671a105ab70dee5e6
    version: 2.31.1-rc1
timestamp: "2024-02-05 10:30:26"
version: 2.31.1-rc1
</code>
</pre>
</details>

### Armory


#### Armory Clouddriver - 2.31.0...2.31.1-rc1


#### Armory Deck - 2.31.0...2.31.1-rc1


#### Dinghy™ - 2.31.0...2.31.1-rc1


#### Armory Echo - 2.31.0...2.31.1-rc1


#### Armory Fiat - 2.31.0...2.31.1-rc1


#### Armory Front50 - 2.31.0...2.31.1-rc1

  - chore: Front50 OS upgrade (#604) (#640)

#### Armory Gate - 2.31.0...2.31.1-rc1

  - chore(gate): Removing Instance registration from Gate (backport #677) (#679)
  - fix(header): Fixing header plugin reference in config (backport #684) (#686)

#### Armory Igor - 2.31.0...2.31.1-rc1

  - chore(cd): update base service version to igor:2024.01.22.15.24.57.release-1.31.x (#555)
  - chore: OS Updates (#516) (#567)

#### Armory Kayenta - 2.31.0...2.31.1-rc1

  - chore(cd): update base service version to kayenta:2023.11.21.08.03.27.release-1.31.x (#499)

#### Armory Orca - 2.31.0...2.31.1-rc1

  - Adding aws mysql jdbc drivers (#816)

#### Armory Rosco - 2.31.0...2.31.1-rc1

  - fix(ci): Removing integration tests as not stable (backport #627) (#629)

#### Terraformer™ - 2.31.0...2.31.1-rc1



### Spinnaker


#### Spinnaker Clouddriver - 1.31.3


#### Spinnaker Deck - 1.31.3


#### Spinnaker Echo - 1.31.3


#### Spinnaker Fiat - 1.31.3


#### Spinnaker Front50 - 1.31.3


#### Spinnaker Gate - 1.31.3


#### Spinnaker Igor - 1.31.3

  - feat(jenkins): Enable Jenkins job triggers for jobs in sub-folders (#1204) (#1215)

#### Spinnaker Kayenta - 1.31.3

  - chore(dependencies): Autobump orcaVersion (#1001)

#### Spinnaker Orca - 1.31.3


#### Spinnaker Rosco - 1.31.3


