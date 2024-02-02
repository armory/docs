---
title: v2.32.0-rc2 Armory Continuous Deployment Release (Spinnaker™ v1.32.3)
toc_hide: true
date: 2024-02-02
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
description: >
  Release notes for Armory Continuous Deployment v2.32.0-rc2. A beta release is not meant for installation in production environments.

---

## 2024/02/02 release notes

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

To install, upgrade, or configure Armory CD 2.32.0-rc2, use Armory Operator 1.70 or later.

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
[Spinnaker v1.32.3](https://www.spinnaker.io/changelogs/1.32.3-changelog/) changelog for details.

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
    commit: 27d2b5f64b07ae03a49edac6f3e937b06f15d1bf
    version: 2.32.0-rc2
  deck:
    commit: a79682affbf676b47dc20d81ab7de04562686119
    version: 2.32.0-rc2
  dinghy:
    commit: 3a713c33889aa36301dd4fde4061c3d5d3bfa237
    version: 2.32.0-rc2
  echo:
    commit: b69e483d8f0c99da6ad21dacdc897e17257fe092
    version: 2.32.0-rc2
  fiat:
    commit: 2c0d010ce00d9519b316e15af734a05835df1048
    version: 2.32.0-rc2
  front50:
    commit: c68b97b642a6d9168d361d74dad373e565850f5d
    version: 2.32.0-rc2
  gate:
    commit: 1f96d4f238c63798cf34e818760ffb25b3a4b009
    version: 2.32.0-rc2
  igor:
    commit: bb72a0d7401dc994dcefec9a4cddf0b16db04086
    version: 2.32.0-rc2
  kayenta:
    commit: af68e872b806eb49f4f0071187f998f18f04c3c2
    version: 2.32.0-rc2
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 9b0cbcc0d618fb135d7e9551db5b493ad3def9a3
    version: 2.32.0-rc2
  rosco:
    commit: 776c66208dd16ad41defad3d0b6d8bcc3dbba24d
    version: 2.32.0-rc2
  terraformer:
    commit: d13481b3b561dd232adff996f119b95e25a626bc
    version: 2.32.0-rc2
timestamp: "2024-02-02 10:06:20"
version: 2.32.0-rc2
</code>
</pre>
</details>

### Armory


#### Terraformer™ - 2.32.0-rc1...2.32.0-rc2

  - chore(cd): Merge master to release-2.32.x branch (#540)

#### Dinghy™ - 2.32.0-rc1...2.32.0-rc2


#### Armory Deck - 2.32.0-rc1...2.32.0-rc2

  - chore(oss): Sync oss with release-2.32-x  (#1389)
  - build(action): pass version to fix build (#1390) (#1391)

#### Armory Gate - 2.32.0-rc1...2.32.0-rc2

  - Removing Instance registration from Gate (#677) (#678)
  - Fixnig armory header plugin (#681)
  - fix(header): Fix local repo for Armory.Header (#682)
  - Fixing header plugin reference (#684) (#685)
  - chore(cd): update base service version to gate:2024.02.01.16.29.20.release-1.32.x (#689)

#### Armory Front50 - 2.32.0-rc1...2.32.0-rc2


#### Armory Echo - 2.32.0-rc1...2.32.0-rc2


#### Armory Clouddriver - 2.32.0-rc1...2.32.0-rc2


#### Armory Orca - 2.32.0-rc1...2.32.0-rc2

  - fix(terraformer): Fixing NPE for artifact binding (#810)

#### Armory Fiat - 2.32.0-rc1...2.32.0-rc2


#### Armory Rosco - 2.32.0-rc1...2.32.0-rc2


#### Armory Igor - 2.32.0-rc1...2.32.0-rc2


#### Armory Kayenta - 2.32.0-rc1...2.32.0-rc2



### Spinnaker


#### Spinnaker Deck - 1.32.3

  - feat(helm/bake): Add additional input fields where we can fill in details of the APIs versions (#10036) (#10048)
  - fix(kubernetes): export rollout restart stage so it's actually available for use (#10037) (#10043)
  - fix: Scaling bounds should parse float not int (#10026) (#10033)
  - Revert "fix(core): conditionally hide expression evaluation warning messages (#9771)" (#10021) (#10022)
  - feat(core): set Cancellation Reason to be expanded by default (#10018)
  - Revert "fix(core): conditionally hide expression evaluation warning messages (#9771)" (#10021)
  - feat(core): Add ability to set Default Tag filters for an application in application config (#10020)
  - fix: Scaling bounds should parse float not int (#10026)
  - Publish packages to NPM (#10019)
  - chore(deps-dev): bump vite from 2.4.2 to 2.9.16 in /packages/app (#10027)
  - chore(deps): bump luxon from 1.23.0 to 1.28.1 in /packages/cloudrun (#10028)
  - chore(deps): bump angular and @types/angular in /packages/cloudrun (#10030)
  - chore(deps): bump docker/setup-buildx-action from 2 to 3 (#10039)
  - fix(kubernetes): export rollout restart stage so it's actually available for use (#10037)
  - chore(deps): bump docker/setup-qemu-action from 2 to 3 (#10038)
  - chore(deps): bump actions/checkout from 3 to 4 (#10042)
  - chore(deps): bump docker/build-push-action from 4 to 5 (#10040)
  - chore(deps): bump docker/login-action from 2 to 3 (#10041)
  - feat(helm/bake): Add additional input fields where we can fill in details of the APIs versions (#10036)
  - fix(publish): set access config in deck libraries (#10049)
  - Publish packages to NPM (#10029)
  - fix(lambda): available Runtimes shared between Deploy stage and Functions tab (#10050)

#### Spinnaker Gate - 1.32.3

  - fix: Fix git trigger issue caused by a misconfig of the object mapper when creating the echo retrofit service (#1756) (#1757)

#### Spinnaker Front50 - 1.32.3


#### Spinnaker Echo - 1.32.3


#### Spinnaker Clouddriver - 1.32.3


#### Spinnaker Orca - 1.32.3


#### Spinnaker Fiat - 1.32.3


#### Spinnaker Rosco - 1.32.3


#### Spinnaker Igor - 1.32.3


#### Spinnaker Kayenta - 1.32.3


