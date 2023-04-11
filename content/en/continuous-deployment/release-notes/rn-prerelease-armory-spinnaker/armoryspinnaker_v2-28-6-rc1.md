---
title: v2.28.6-rc1 Armory Release (OSS Spinnaker™ v1.28.6)
toc_hide: true
date: 2023-04-11
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
description: >
  Release notes for Armory Continuous Deployment v2.28.6-rc1. A beta release is not meant for installation in production environments.

---

## 2023/04/11 Release Notes

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

To install, upgrade, or configure Armory 2.28.6-rc1, use Armory Operator 1.70 or later.

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
[Spinnaker v1.28.6](https://www.spinnaker.io/changelogs/1.28.6-changelog/) changelog for details.

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
    commit: e3b237b6188e587b6de17922aa09841ae77f35bf
    version: 2.28.6-rc1
  deck:
    commit: c9062f5626855846a1354d274bf1bc7083a86880
    version: 2.28.6-rc1
  dinghy:
    commit: 912007004f7720b418cd133301c7fb20207e1f2f
    version: 2.28.6-rc1
  echo:
    commit: 8b763d646f1a52db3a9de33acf4e7e420220c3e0
    version: 2.28.6-rc1
  fiat:
    commit: 45039aa7952cc409329faa30b8443667566459c1
    version: 2.28.6-rc1
  front50:
    commit: fab8841982330e7537629c9f24f41205cd5863fd
    version: 2.28.6-rc1
  gate:
    commit: 43c004af54657dba4a8a429f450de0dad240ed7e
    version: 2.28.6-rc1
  igor:
    commit: 60964526194a1273a03a7ade1f8939751e337735
    version: 2.28.6-rc1
  kayenta:
    commit: 705629b88f6532d4f81dcd8063a31ad55a0ee29b
    version: 2.28.6-rc1
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 6bec7e613ce3cbb8b3ea9223311579e433efc7b1
    version: 2.28.6-rc1
  rosco:
    commit: 12b901a2270bba8971c4b44b47e9256db95cd9b4
    version: 2.28.6-rc1
  terraformer:
    commit: ea9b0255b7d446bcbf0f0d4e03fc8699b7508431
    version: 2.28.6-rc1
timestamp: "2023-03-28 16:41:18"
version: 2.28.6-rc1
</code>
</pre>
</details>

### Armory


#### Armory Echo - 2.28.5...2.28.6-rc1

  - chore(cd): update base service version to echo:2023.03.02.19.38.24.release-1.28.x (#542)
  - chore(cd): update base service version to echo:2023.03.02.21.17.15.release-1.28.x (#543)
  - chore(cd): update base service version to echo:2023.03.27.19.10.41.release-1.28.x (#550)

#### Armory Kayenta - 2.28.5...2.28.6-rc1

  - chore(cd): update base service version to kayenta:2023.03.03.04.50.48.release-1.28.x (#393)

#### Armory Igor - 2.28.5...2.28.6-rc1

  - chore(cd): update base service version to igor:2023.03.02.19.40.25.release-1.28.x (#419)
  - chore(cd): update base service version to igor:2023.03.02.21.16.28.release-1.28.x (#420)

#### Armory Rosco - 2.28.5...2.28.6-rc1

  - chore(cd): update base service version to rosco:2023.03.02.19.37.08.release-1.28.x (#500)

#### Terraformer™ - 2.28.5...2.28.6-rc1

  - chore(alpine): Update alpine version (backport #497) (#499)

#### Armory Front50 - 2.28.5...2.28.6-rc1


#### Armory Clouddriver - 2.28.5...2.28.6-rc1

  - chore(cd): update base service version to clouddriver:2023.03.02.19.57.01.release-1.28.x (#812)
  - chore(cd): update base service version to clouddriver:2023.03.03.02.32.42.release-1.28.x (#813)
  - chore(cd): update base service version to clouddriver:2023.03.21.20.21.00.release-1.28.x (#821)
  - chore(cd): update base service version to clouddriver:2023.03.23.14.57.28.release-1.28.x (#826)
  - chore(cd): update base service version to clouddriver:2023.03.27.19.24.21.release-1.28.x (#829)

#### Dinghy™ - 2.28.5...2.28.6-rc1

  - chore(dependencies): bumped oss dinghy version to 20230201103309-a73a68c80965 (#480)
  - chore(alpine): Upgrade alpine version (backport #481) (#482)

#### Armory Gate - 2.28.5...2.28.6-rc1

  - chore(cd): update base service version to gate:2023.03.02.19.38.56.release-1.28.x (#523)
  - chore(cd): update base service version to gate:2023.03.02.21.17.09.release-1.28.x (#524)
  - chore(cd): update base service version to gate:2023.03.27.19.10.16.release-1.28.x (#530)

#### Armory Deck - 2.28.5...2.28.6-rc1

  - chore(alpine): Upgrade alpine version (backport #1302) (#1303)

#### Armory Orca - 2.28.5...2.28.6-rc1

  - chore(cd): update base orca version to 2023.03.02.19.46.59.release-1.28.x (#597)
  - chore(cd): update base orca version to 2023.03.02.21.24.49.release-1.28.x (#598)
  - chore(cd): update base orca version to 2023.03.28.15.32.53.release-1.28.x (#608)

#### Armory Fiat - 2.28.5...2.28.6-rc1

  - chore(cd): update base service version to fiat:2023.03.02.19.37.20.release-1.28.x (#441)
  - chore(cd): update base service version to fiat:2023.03.16.17.55.44.release-1.28.x (#446)


### Spinnaker


#### Spinnaker Echo - 1.28.6

  - chore(dependencies): Autobump korkVersion (#1261)
  - chore(dependencies): Autobump fiatVersion (#1262)
  - chore(dependencies): Autobump fiatVersion (#1270)

#### Spinnaker Kayenta - 1.28.6

  - chore(dependencies): Autobump orcaVersion (#936)

#### Spinnaker Igor - 1.28.6

  - chore(dependencies): Autobump korkVersion (#1093)
  - chore(dependencies): Autobump fiatVersion (#1094)

#### Spinnaker Rosco - 1.28.6

  - chore(dependencies): Autobump korkVersion (#959)

#### Spinnaker Front50 - 1.28.6


#### Spinnaker Clouddriver - 1.28.6

  - chore(dependencies): Autobump korkVersion (#5897)
  - chore(dependencies): Autobump fiatVersion (#5898)
  - fix(core): Renamed a query parameter for template tags (#5906) (#5908)
  - chore(aws): Update AWS IAM Authenticator version (#5910)
  - chore(dependencies): Autobump fiatVersion (#5916)

#### Spinnaker Gate - 1.28.6

  - chore(dependencies): Autobump korkVersion (#1624)
  - chore(dependencies): Autobump fiatVersion (#1625)
  - chore(dependencies): Autobump fiatVersion (#1632)

#### Spinnaker Deck - 1.28.6


#### Spinnaker Orca - 1.28.6

  - chore(dependencies): Autobump korkVersion (#4405)
  - chore(dependencies): Autobump fiatVersion (#4406)
  - chore(dependencies): Autobump fiatVersion (#4425)
  - Fix/blue green deploy (backport #4414) (#4419)

#### Spinnaker Fiat - 1.28.6

  - chore(dependencies): Autobump korkVersion (#1026)
  - fix(logs): Redacted secret data in logs. (#1029) (#1030)

