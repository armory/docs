---
title: v2.28.6-rc2 Armory Release (OSS Spinnaker™ v1.28.6)
toc_hide: true
date: 2023-04-21
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
description: >
  Release notes for Armory Continuous Deployment v2.28.6-rc2. A beta release is not meant for installation in production environments.

---

## 2023/04/21 Release Notes

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

To install, upgrade, or configure Armory 2.28.6-rc2, use Armory Operator 1.70 or later.

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
    commit: 95037f6d709c2dd03318b78c42c426106ee16a01
    version: 2.28.6-rc2
  deck:
    commit: e24db15a97545fd5dda3bdb88a70f640bc5a1104
    version: 2.28.6-rc2
  dinghy:
    commit: 912007004f7720b418cd133301c7fb20207e1f2f
    version: 2.28.6-rc2
  echo:
    commit: a602d9d5def0815cb52bdf6d695ca69cbf0abe3b
    version: 2.28.6-rc2
  fiat:
    commit: 45039aa7952cc409329faa30b8443667566459c1
    version: 2.28.6-rc2
  front50:
    commit: 3292cf2715a9e52bb4690601d4fd877407505ced
    version: 2.28.6-rc2
  gate:
    commit: c8058f4362f3f4ad108fa146d628a162445c7579
    version: 2.28.6-rc2
  igor:
    commit: 60964526194a1273a03a7ade1f8939751e337735
    version: 2.28.6-rc2
  kayenta:
    commit: 22fe5d47baacce77917c9026cefdedf91c64a956
    version: 2.28.6-rc2
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 06352546281e21597eb59d3e993e842b9259f142
    version: 2.28.6-rc2
  rosco:
    commit: 27d4a2b4a1d5f099b68471303d4fd14af156d46d
    version: 2.28.6-rc2
  terraformer:
    commit: ea9b0255b7d446bcbf0f0d4e03fc8699b7508431
    version: 2.28.6-rc2
timestamp: "2023-04-21 21:46:22"
version: 2.28.6-rc2
</code>
</pre>
</details>

### Armory


#### Dinghy™ - 2.28.6-rc1...2.28.6-rc2


#### Armory Fiat - 2.28.6-rc1...2.28.6-rc2


#### Armory Clouddriver - 2.28.6-rc1...2.28.6-rc2

  - chore(cd): update armory-commons version to 3.11.5 (#862)
  - Bumped aws-cli to 1.22 for FIPS compliance (#854) (#863)
  - chore(cd): update armory-commons version to 3.11.6 (#868)

#### Armory Igor - 2.28.6-rc1...2.28.6-rc2


#### Armory Rosco - 2.28.6-rc1...2.28.6-rc2

  - chore(cd): update armory-commons version to 3.11.5 (#526)
  - chore(cd): update armory-commons version to 3.11.6 (#529)

#### Armory Kayenta - 2.28.6-rc1...2.28.6-rc2

  - chore(cd): update base service version to kayenta:2023.03.28.19.09.35.release-1.28.x (#398)
  - chore(cd): update armory-commons version to 3.11.5 (#423)
  - chore(cd): update armory-commons version to 3.11.6 (#430)

#### Terraformer™ - 2.28.6-rc1...2.28.6-rc2


#### Armory Gate - 2.28.6-rc1...2.28.6-rc2

  - chore(cd): update armory-commons version to 3.11.5 (#556)

#### Armory Echo - 2.28.6-rc1...2.28.6-rc2

  - chore(cd): update armory-commons version to 3.11.5 (#576)
  - chore(cd): update armory-commons version to 3.11.6 (#579)

#### Armory Deck - 2.28.6-rc1...2.28.6-rc2

  - chore(build): only run security scans on PR merge (backport #1319) (#1327)
  - chore(cd): update base deck version to 2023.0.0-20230410180145.release-1.28.x (#1330)
  - chore(cd): update base deck version to 2023.0.0-20230410180145.release-1.28.x (#1332)
  - chore(cd): update base deck version to 2023.0.0-20230420193214.release-1.28.x (#1333)

#### Armory Orca - 2.28.6-rc1...2.28.6-rc2

  - chore(cd): update armory-commons version to 3.11.5 (#632)

#### Armory Front50 - 2.28.6-rc1...2.28.6-rc2

  - chore(cd): update base service version to front50:2023.03.27.19.08.11.release-1.28.x (#509)
  - chore(cd): update armory-commons version to 3.11.5 (#534)


### Spinnaker


#### Spinnaker Fiat - 1.28.6


#### Spinnaker Clouddriver - 1.28.6


#### Spinnaker Igor - 1.28.6


#### Spinnaker Rosco - 1.28.6


#### Spinnaker Kayenta - 1.28.6

  - chore(dependencies): Autobump orcaVersion (#943)

#### Spinnaker Gate - 1.28.6


#### Spinnaker Echo - 1.28.6


#### Spinnaker Deck - 1.28.6

  - fix: UI crashes when running pipeline(s) with many stages. (backport #9960) (#9973)
  - fix(aws): Fixing bugs related to clone CX when instance types are incompatible with image/region (backport #9901) (#9975)

#### Spinnaker Orca - 1.28.6


#### Spinnaker Front50 - 1.28.6

  - chore(dependencies): Autobump korkVersion (#1214)
  - chore(dependencies): Autobump fiatVersion (#1215)
  - fix(sql): Populating lastModified field for pipelines when loading objects. (#1220) (#1223)
  - chore(dependencies): Autobump fiatVersion (#1227)

