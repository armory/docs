---
title: v2.28.2-rc1 Armory Release (OSS Spinnaker™ v1.28.3)
toc_hide: true
date: 2022-12-08
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
description: >
  Release notes for Armory Enterprise v2.28.2-rc1. A beta release is not meant for installation in production environments.

---

## 2022/12/08 Release Notes

## Disclaimer

This pre-release software is to allow limited access to test or beta versions of the Armory services (“Services”) and to provide feedback and comments to Armory regarding the use of such Services. By using Services, you agree to be bound by the terms and conditions set forth herein.

Your Feedback is important and we welcome any feedback, analysis, suggestions and comments (including, but not limited to, bug reports and test results) (collectively, “Feedback”) regarding the Services. Any Feedback you provide will become the property of Armory and you agree that Armory may use or otherwise exploit all or part of your feedback or any derivative thereof in any manner without any further remuneration, compensation or credit to you. You represent and warrant that any Feedback which is provided by you hereunder is original work made solely by you and does not infringe any third party intellectual property rights.

Any Feedback provided to Armory shall be considered Armory Confidential Information and shall be covered by any confidentiality agreements between you and Armory.

You acknowledge that you are using the Services on a purely voluntary basis, as a means of assisting, and in consideration of the opportunity to assist Armory to use, implement, and understand various facets of the Services. You acknowledge and agree that nothing herein or in your voluntary submission of Feedback creates any employment relationship between you and Armory.

Armory may, in its sole discretion, at any time, terminate or discontinue all or your access to the Services. You acknowledge and agree that all such decisions by Armory are final and Armory will have no liability with respect to such decisions.

YOUR USE OF THE SERVICES IS AT YOUR OWN RISK. THE SERVICES, THE ARMORY TOOLS AND THE CONTENT ARE PROVIDED ON AN “AS IS” BASIS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED. ARMORY AND ITS LICENSORS MAKE NO REPRESENTATION, WARRANTY, OR GUARANTY AS TO THE RELIABILITY, TIMELINESS, QUALITY, SUITABILITY, TRUTH, AVAILABILITY, ACCURACY OR COMPLETENESS OF THE SERVICES, THE ARMORY TOOLS OR ANY CONTENT. ARMORY EXPRESSLY DISCLAIMS ON ITS OWN BEHALF AND ON BEHALF OF ITS EMPLOYEES, AGENTS, ATTORNEYS, CONSULTANTS, OR CONTRACTORS ANY AND ALL WARRANTIES INCLUDING, WITHOUT LIMITATION (A) THE USE OF THE SERVICES OR THE ARMORY TOOLS WILL BE TIMELY, UNINTERRUPTED OR ERROR-FREE OR OPERATE IN COMBINATION WITH ANY OTHER HARDWARE, SOFTWARE, SYSTEM OR DATA, (B) THE SERVICES AND THE ARMORY TOOLS AND/OR THEIR QUALITY WILL MEET CUSTOMER”S REQUIREMENTS OR EXPECTATIONS, (C) ANY CONTENT WILL BE ACCURATE OR RELIABLE, (D) ERRORS OR DEFECTS WILL BE CORRECTED, OR (E) THE SERVICES, THE ARMORY TOOLS OR THE SERVER(S) THAT MAKE THE SERVICES AVAILABLE ARE FREE OF VIRUSES OR OTHER HARMFUL COMPONENTS. CUSTOMER AGREES THAT ARMORY SHALL NOT BE RESPONSIBLE FOR THE AVAILABILITY OR ACTS OR OMISSIONS OF ANY THIRD PARTY, INCLUDING ANY THIRD-PARTY APPLICATION OR PRODUCT, AND ARMORY HEREBY DISCLAIMS ANY AND ALL LIABILITY IN CONNECTION WITH SUCH THIRD PARTIES.

IN NO EVENT SHALL ARMORY, ITS EMPLOYEES, AGENTS, ATTORNEYS, CONSULTANTS, OR CONTRACTORS BE LIABLE UNDER THIS AGREEMENT FOR ANY CONSEQUENTIAL, SPECIAL, LOST PROFITS, INDIRECT OR OTHER DAMAGES, INCLUDING BUT NOT LIMITED TO LOST PROFITS, LOSS OF BUSINESS, COST OF COVER WHETHER BASED IN CONTRACT, TORT (INCLUDING NEGLIGENCE), OR OTHERWISE, EVEN IF ARMORY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES AND NOTWITHSTANDING ANY FAILURE OF ESSENTIAL PURPOSE OF ANY LIMITED REMEDY. IN ANY EVENT, ARMORY, ITS EMPLOYEES’, AGENTS’, ATTORNEYS’, CONSULTANTS’ OR CONTRACTORS’ AGGREGATE LIABILITY UNDER THIS AGREEMENT FOR ANY CLAIM SHALL BE STRICTLY LIMITED TO $100.00. SOME STATES DO NOT ALLOW THE LIMITATION OR EXCLUSION OF LIABILITY FOR INCIDENTAL OR CONSEQUENTIAL DAMAGES, SO THE ABOVE LIMITATION OR EXCLUSION MAY NOT APPLY TO YOU.

You acknowledge that Armory has provided the Services in reliance upon the limitations of liability set forth herein and that the same is an essential basis of the bargain between the parties.


## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.28.2-rc1, use one of the following tools:

- Armory-extended Halyard <PUT IN A VERSION NUMBER> or later
- Armory Operator <PUT IN A VERSION NUMBER> or later

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
[Spinnaker v1.28.3](https://www.spinnaker.io/changelogs/1.28.3-changelog/) changelog for details.

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
    commit: 960c72d1e7e7b9e857d94af9731c3441426ee073
    version: 2.28.2-rc1
  deck:
    commit: 6798fd1789d2c062c4a1cd2e33615e6bad9aa90b
    version: 2.28.2-rc1
  dinghy:
    commit: c4ed5b19dbcfefe8dea14cdff7df9a8ab540eba3
    version: 2.28.2-rc1
  echo:
    commit: 6d4e4ae054b7a13050a1d271b3c771a790e27fc6
    version: 2.28.2-rc1
  fiat:
    commit: fce52482097b606389328d25d220be5eaaddab21
    version: 2.28.2-rc1
  front50:
    commit: 1e5d3a5dfce38d26f809dee107d8145c00caa27e
    version: 2.28.2-rc1
  gate:
    commit: 65bdd30238312bbca2dce613825eda7ae88f1dfa
    version: 2.28.2-rc1
  igor:
    commit: 61ce26babfcd0bdf62872c24e707ca5b5371a381
    version: 2.28.2-rc1
  kayenta:
    commit: 6004bfd90ad2e4fa9b02dddc26253210b8aa3a3c
    version: 2.28.2-rc1
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 76fe72a46566bb404eb4db4c842ecb0775c546bf
    version: 2.28.2-rc1
  rosco:
    commit: 33e7e7db7e2475f0a5ce8c42f7ccc986d8c134fa
    version: 2.28.2-rc1
  terraformer:
    commit: 57c6a9a72d4cfccb7caf229e360fa7f17410afea
    version: 2.28.2-rc1
timestamp: "2022-12-08 15:44:56"
version: 2.28.2-rc1
</code>
</pre>
</details>

### Armory


#### Armory Deck - 2.28.1...2.28.2-rc1

  - chore(cd): update base deck version to 2022.0.0-20221129214415.release-1.28.x (#1279)
  - chore(cd): update base deck version to 2022.0.0-20221206152435.release-1.28.x (#1282)

#### Armory Echo - 2.28.1...2.28.2-rc1

  - chore(cd): update base service version to echo:2022.11.29.21.47.23.release-1.28.x (#504)
  - chore(cd): update base service version to echo:2022.12.06.19.49.37.release-1.28.x (#507)

#### Armory Rosco - 2.28.1...2.28.2-rc1

  - chore(cd): update base service version to rosco:2022.11.23.15.48.41.release-1.28.x (#468)
  - chore(cd): update base service version to rosco:2022.11.29.21.53.24.release-1.28.x (#470)

#### Armory Igor - 2.28.1...2.28.2-rc1

  - fix: NoSuchMethodError exception in JenkinsClient. (#377) (#387)
  - chore(cd): update base service version to igor:2022.11.29.21.52.31.release-1.28.x (#390)

#### Armory Kayenta - 2.28.1...2.28.2-rc1


#### Dinghy™ - 2.28.1...2.28.2-rc1

  - Updated oss dinghy version to v0.0.0-20221021170743-d8697fabf1e8 (#475)

#### Armory Clouddriver - 2.28.1...2.28.2-rc1

  - chore(cd): update base service version to clouddriver:2022.11.17.17.21.13.release-1.28.x (#742)
  - chore(cd): update base service version to clouddriver:2022.11.25.21.33.33.release-1.28.x (#750)
  - chore(cd): update base service version to clouddriver:2022.11.29.21.59.34.release-1.28.x (#752)

#### Armory Orca - 2.28.1...2.28.2-rc1

  - chore(cd): update base orca version to 2022.11.18.19.16.39.release-1.28.x (#548)
  - chore(cd): update base orca version to 2022.11.21.16.33.46.release-1.28.x (#552)
  - chore(cd): update base orca version to 2022.11.23.15.55.22.release-1.28.x (#557)

#### Armory Gate - 2.28.1...2.28.2-rc1

  - chore(cd): update base service version to gate:2022.10.19.18.23.12.release-1.28.x (#480)
  - chore(cd): update base service version to gate:2022.10.19.20.00.40.release-1.28.x (#481)
  - fix(header): update plugins.json with newest header version (backport #482) (#483)
  - revert(header): update plugins.json with newest header version (#484) (#485)
  - chore(cd): update base service version to gate:2022.11.29.21.51.30.release-1.28.x (#492)

#### Armory Fiat - 2.28.1...2.28.2-rc1


#### Armory Front50 - 2.28.1...2.28.2-rc1


#### Terraformer™ - 2.28.1...2.28.2-rc1

  - Updating TF versions up to 1.3.4 (#478)
  - fix(log): calling remote logging asynchronously (#471) (#485)


### Spinnaker


#### Spinnaker Deck - 1.28.3

  - chore(dependencies): Autobump spinnakerGradleVersion (#9916) (#9926)
  - feat(pipeline): added feature flag for pipeline when mj stage child (backport #9914) (#9920)

#### Spinnaker Echo - 1.28.3

  - chore(dependencies): Autobump spinnakerGradleVersion (#1215) (#1222)
  - feat(webhooks): Handle Bitbucket Server PR events (#1224)

#### Spinnaker Rosco - 1.28.3

  - feat(bakery): Clean up cached data created by Rosco. (#912) (#921)
  - chore(dependencies): Autobump spinnakerGradleVersion (#917) (#925)

#### Spinnaker Igor - 1.28.3

  - chore(dependencies): Autobump spinnakerGradleVersion (#1055) (#1061)

#### Spinnaker Kayenta - 1.28.3


#### Spinnaker Clouddriver - 1.28.3

  - fix(kubernetes): teach KubernetesManifest to support kubernetes resources where the spec is not a map (#5814) (#5817)
  - fix(artifacts/bitbuket): added ACCEPT Header when using token auth (#5813) (#5823)
  - chore(dependencies): Autobump spinnakerGradleVersion (#5819) (#5827)

#### Spinnaker Orca - 1.28.3

  - fix(tasks): Fix MonitorKayentaCanaryTask on results data map (#4312) (#4339)
  - chore(dependencies): Autobump spinnakerGradleVersion (#4337) (#4345)
  - feat(bakery): Clean up cached data created by Rosco. (#4323) (#4350)

#### Spinnaker Gate - 1.28.3

  - chore(dependencies): Autobump korkVersion (#1581)
  - chore(dependencies): Autobump fiatVersion (#1582)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1585) (#1592)

#### Spinnaker Fiat - 1.28.3


#### Spinnaker Front50 - 1.28.3


