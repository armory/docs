---
title: v2.30.3-rc1 Armory Release (OSS Spinnaker™ v1.30.4)
toc_hide: true
date: 2023-10-02
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
description: >
  Release notes for Armory Continuous Deployment v2.30.3-rc1. A beta release is not meant for installation in production environments.

---

## 2023/10/02 Release Notes

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

To install, upgrade, or configure Armory 2.30.3-rc1, use Armory Operator 1.70 or later.

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
[Spinnaker v1.30.4](https://www.spinnaker.io/changelogs/1.30.4-changelog/) changelog for details.

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
    commit: 767aa739e9c38d2ec7822e9e9a1838b69a56d4c0
    version: 2.30.3-rc1
  deck:
    commit: 18e1727665cc52111760bf8e7f41cbf23da3b1a9
    version: 2.30.3-rc1
  dinghy:
    commit: a3b59d9e4b810cc968d0f5e8e8370e1670574768
    version: 2.30.3-rc1
  echo:
    commit: 2ef241fd3da29fb70cdb05432d022f0edd752d51
    version: 2.30.3-rc1
  fiat:
    commit: 5d44e1f53d2f33b17f8decfb057a18cfe4b6fa08
    version: 2.30.3-rc1
  front50:
    commit: 5d9bb31f65f96087be30ce96cea1b6d481a6bef4
    version: 2.30.3-rc1
  gate:
    commit: 04598366642300d6f028df33b6206b5ce75f1038
    version: 2.30.3-rc1
  igor:
    commit: f3d890427c79b7db6cf5fcb681e30542df97ff7c
    version: 2.30.3-rc1
  kayenta:
    commit: 1d2f5193ec681b5122fe7c34da6bbd569da8e0b8
    version: 2.30.3-rc1
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: ba62a86ef3af0007506b589a4272e3c2e03de00b
    version: 2.30.3-rc1
  rosco:
    commit: a2b4662a40281e553de2182b680d5fd7e6bc3955
    version: 2.30.3-rc1
  terraformer:
    commit: 249e7be18074af100212ddd554d9fb35afd65873
    version: 2.30.3-rc1
timestamp: "2023-09-29 15:15:45"
version: 2.30.3-rc1
</code>
</pre>
</details>

### Armory


#### Armory Gate - 2.30.2...2.30.3-rc1

  - chore(cd): update base service version to gate:2023.09.01.01.26.23.release-1.30.x (#608)
  - chore(cd): update base service version to gate:2023.09.07.17.47.28.release-1.30.x (#612)
  - chore(ci): removed aquasec scan action (#616) (#622)

#### Armory Rosco - 2.30.2...2.30.3-rc1

  - chore(ci): removed aquasec scan action (#565) (#568)

#### Armory Orca - 2.30.2...2.30.3-rc1

  - chore(cd): update base orca version to 2023.09.07.17.59.31.release-1.30.x (#693)
  - chore(ci): removed aquasec scan action (#695) (#706)
  - chore(cd): update base orca version to 2023.09.26.15.03.20.release-1.30.x (#721)

#### Armory Fiat - 2.30.2...2.30.3-rc1

  - chore(ci): removed aquasec scan action (#523) (#526)

#### Armory Echo - 2.30.2...2.30.3-rc1

  - chore(cd): update base service version to echo:2023.09.07.17.49.13.release-1.30.x (#616)
  - chore(ci): removed aquasec scan action (#618) (#622)

#### Dinghy™ - 2.30.2...2.30.3-rc1

  - chore(ci): removed aquasec scan action (#489) (#492)
  - chore(ci): removing aquasec scans for any push (#497) (#499)
  - chore(log): Bumped up dinghy and plank versions. (backport #490) (#505)

#### Armory Kayenta - 2.30.2...2.30.3-rc1

  - chore(ci): removed aquasec scan action (#469) (#471)

#### Armory Clouddriver - 2.30.2...2.30.3-rc1

  - chore(cd): update base service version to clouddriver:2023.08.29.09.35.30.release-1.30.x (#945)
  - chore(cd): update base service version to clouddriver:2023.09.07.19.02.07.release-1.30.x (#953)
  - chore(cd): update base service version to clouddriver:2023.09.07.22.04.28.release-1.30.x (#955)
  - chore(cd): update base service version to clouddriver:2023.09.08.02.48.03.release-1.30.x (#958)
  - chore(cd): update base service version to clouddriver:2023.09.08.03.51.25.release-1.30.x (#959)
  - chore(cd): update base service version to clouddriver:2023.09.08.04.42.03.release-1.30.x (#962)
  - chore(cd): update base service version to clouddriver:2023.09.08.05.40.38.release-1.30.x (#963)
  - chore(cd): update base service version to clouddriver:2023.09.08.14.33.30.release-1.30.x (#965)
  - chore(cd): update base service version to clouddriver:2023.09.16.22.42.11.release-1.30.x (#976)
  - chore(cd): update base service version to clouddriver:2023.09.20.19.03.35.release-1.30.x (#980)
  - chore(ci): removed aquasec scan action (#971) (#983)
  - fix: CVE-2023-37920 (#977) (#992)

#### Armory Front50 - 2.30.2...2.30.3-rc1

  - chore(cd): update base service version to front50:2023.09.07.17.50.48.release-1.30.x (#588)
  - chore(ci): removed aquasec scan action (#590) (#594)
  - chore(cd): update base service version to front50:2023.09.25.18.58.31.release-1.30.x (#601)
  - fix(dependencies): match google cloud storage version to this set in OSS, and bump OSS front50 version. (#602)

#### Terraformer™ - 2.30.2...2.30.3-rc1

  - chore(ci): removing aquasec scans on push (#517) (#519)
  - chore(ci): removed aquasec scan action (#510) (#512)

#### Armory Deck - 2.30.2...2.30.3-rc1

  - chore(cd): update base deck version to 2023.0.0-20230918174859.release-1.30.x (#1342)
  - chore(cd): update base deck version to 2023.0.0-20230920215154.release-1.30.x (#1343)
  - chore(ci): removed aquasec scan action (#1340) (#1345)
  - chore(ci): removing docker build and aquasec scans (#1350)

#### Armory Igor - 2.30.2...2.30.3-rc1

  - chore(cd): update base service version to igor:2023.09.07.17.50.00.release-1.30.x (#491)
  - chore(ci): removed aquasec scan action (#495) (#508)


### Spinnaker


#### Spinnaker Gate - 1.30.4

  - fix(cachingFilter: Allow disabling the content caching filter (#1699) (#1700)
  - chore(dependencies): Autobump fiatVersion (#1708)

#### Spinnaker Rosco - 1.30.4


#### Spinnaker Orca - 1.30.4

  - chore(dependencies): Autobump fiatVersion (#4520)
  - fix(vpc): add data annotation to vpc (#4534) (#4536)
  - fix: duplicate entry exception for correlation_ids table. (#4521) (#4532)

#### Spinnaker Fiat - 1.30.4


#### Spinnaker Echo - 1.30.4

  - chore(dependencies): Autobump fiatVersion (#1338)

#### Spinnaker Kayenta - 1.30.4


#### Spinnaker Clouddriver - 1.30.4

  - chore(dependencies): Autobump fiatVersion (#6017)
  - chore(gha): update to docker/login-action@v2 to stay up to date (#5920) (#6020)
  - chore(deps): bump actions/cache from 2 to 3 (#5926) (#6022)
  - chore(deps): bump actions/checkout from 2 to 3 (#5924) (#6024)
  - chore(gha): replace action for creating github releases (backport #5929) (#6026)
  - chore(deps): bump actions/setup-java from 2 to 3 (#5928) (#6029)
  - chore(deps): bump docker/build-push-action from 3 to 4 (#5927) (#6030)
  - chore(gha): replace deprecated set-output commands with environment files (#5930) (#6032)
  - fix: Fix docker build in GHA by removing some of the GHA tools (#6033) (#6035)
  - feat(lambda): Lambda calls default timeout after 50 seconds causing longer running lambdas to fail.  This adds configurable timeouts for lambda invocations (#6041) (#6044)
  - fix(lambda): Lambda is leaking threads on agent refreshes.  remove the custom threadpool (#6048) (#6051)

#### Spinnaker Front50 - 1.30.4

  - chore(dependencies): Autobump fiatVersion (#1388)
  - fix(dependency): fix dependency version leak of google-api-services-storage from kork in front50-web (#1302) (#1393)

#### Spinnaker Deck - 1.30.4

  - Revert "fix(core): conditionally hide expression evaluation warning messages (#9771)" (#10021) (#10024)
  - fix: Scaling bounds should parse float not int (#10026) (#10031)

#### Spinnaker Igor - 1.30.4

  - chore(dependencies): Autobump fiatVersion (#1167)

