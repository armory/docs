---
title: v2.35.0-rc1 Armory Continuous Deployment Release (Spinnaker™ v1.35.4)
toc_hide: true
date: 2024-11-06
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
description: >
  Release notes for Armory Continuous Deployment v2.35.0-rc1. A beta release is not meant for installation in production environments.

---

## 2024/11/06 release notes

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

To install, upgrade, or configure Armory CD 2.35.0-rc1, use Armory Operator 1.70 or later.

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
[Spinnaker v1.35.4](https://www.spinnaker.io/changelogs/1.35.4-changelog/) changelog for details.

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
    commit: 61870a298437653ac15a109e0e2a4e13dfdb61ca
    version: 2.35.0-rc1
  deck:
    commit: b04971d387e1a0664f536427976c0d64733044b5
    version: 2.35.0-rc1
  dinghy:
    commit: 50041173d1a043493409059e7fa5d7a1a80fb553
    version: 2.35.0-rc1
  echo:
    commit: 1bb22da7c0c104b25b56271ff3e4016fd0ceda22
    version: 2.35.0-rc1
  fiat:
    commit: ce4a5e689b66fce9f5aa4e3039f0fe1af5e69f74
    version: 2.35.0-rc1
  front50:
    commit: 900b169d3cea95992d781e22939bb5fa1224a75d
    version: 2.35.0-rc1
  gate:
    commit: af49faafbd341109028335630f25c46e9077bc1f
    version: 2.35.0-rc1
  igor:
    commit: 56f0c75e06b79f2e3029b0b0da323a2d6c0dff6f
    version: 2.35.0-rc1
  kayenta:
    commit: ac4b20926966e3b984c9b46ae241c5a12e0dddc2
    version: 2.35.0-rc1
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 007b767579a0b983049ae5da7960d8b286462e94
    version: 2.35.0-rc1
  rosco:
    commit: 8e22b77b251ee3083cddfa6cdc11e8eaec2dfdb0
    version: 2.35.0-rc1
  terraformer:
    commit: 9756bee07eaabbb25b54812996314c22554ec1c0
    version: 2.35.0-rc1
timestamp: "2024-11-06 06:52:08"
version: 2.35.0-rc1
</code>
</pre>
</details>

### Armory


#### Armory Orca - 2.34.0...2.35.0-rc1

  - chore(build): Updating Build dependencies (#911)
  - chore(cd): update base orca version to 2024.06.12.02.19.43.release-1.34.x (#899)
  - chore(cd): update base orca version to 2024.06.11.23.58.30.release-1.34.x (#898)
  - chore(cd): update base orca version to 2024.06.11.17.07.47.release-1.34.x (#896)
  - chore(cd): update base orca version to 2024.05.09.17.57.44.release-1.34.x (#888)
  - chore(cd): update armory-commons version to 3.16.2 (#883)
  - chore(cd): update base orca version to 2024.04.29.19.19.52.master (#880)
  - chore(cd): update base orca version to 2024.05.01.16.01.28.master (#884)
  - chore(cd): update base orca version to 2024.05.07.02.35.57.master (#886)
  - chore(cd): update base orca version to 2024.05.09.11.44.35.master (#887)
  - chore(cd): update base orca version to 2024.05.10.18.29.13.master (#890)
  - chore(cd): update base orca version to 2024.06.06.14.09.33.master (#891)
  - chore(cd): update base orca version to 2024.06.07.06.05.25.master (#892)
  - chore(cd): update base orca version to 2024.06.10.16.36.40.master (#894)
  - chore(cd): update base orca version to 2024.06.11.02.19.24.master (#895)
  - chore(cd): update base orca version to 2024.06.11.21.15.44.master (#897)
  - chore(cd): update base orca version to 2024.06.12.08.13.09.master (#900)
  - chore(cd): update base orca version to 2024.06.12.14.47.24.master (#901)
  - chore(cd): update base orca version to 2024.06.12.21.59.59.master (#902)
  - chore(cd): update base orca version to 2024.06.13.04.50.47.master (#903)
  - chore(cd): update base orca version to 2024.06.13.18.56.50.master (#904)
  - chore(cd): update base orca version to 2024.06.13.19.24.10.master (#905)
  - chore(cd): update base orca version to 2024.06.13.22.33.24.master (#906)
  - chore: Builds working with latest versions (#907)
  - fix: Testing GHA fixes (#908)
  - Snakeyaml build fix (#909)
  - chore(cd): update base orca version to 2024.06.25.16.25.46.master (#910)
  - chore(cd): update base orca version to 2024.07.01.23.50.54.master (#913)
  - chore(cd): update base orca version to 2024.07.03.16.08.40.master (#917)
  - chore(cd): update base orca version to 2024.07.10.14.30.54.master (#919)
  - chore(cd): update base orca version to 2024.07.16.20.38.37.master (#923)
  - chore(cd): update base orca version to 2024.08.21.22.59.27.master (#934)
  - chore(cd): update base orca version to 2024.08.28.15.02.07.master (#936)
  - chore(cd): update armory-commons version to 3.17.3 (#940)
  - chore(dep): update base to 2024.08.13.08.26.10.release-1.35.x (#950)
  - chore(java): migrate to java 17 (#949) (#951)

#### Armory Fiat - 2.34.0...2.35.0-rc1

  - chore(cd): update armory-commons version to 3.16.2 (#606)
  - chore(cd): update base service version to fiat:2024.04.27.01.37.20.master (#602)
  - chore(cd): update base service version to fiat:2024.05.01.20.55.58.master (#607)
  - chore(cd): update base service version to fiat:2024.05.10.18.23.12.master (#608)
  - chore(cd): update base service version to fiat:2024.06.06.14.02.18.master (#609)
  - chore(cd): update base service version to fiat:2024.06.07.05.54.34.master (#610)
  - chore(cd): update base service version to fiat:2024.06.12.03.57.15.master (#611)
  - chore(cd): update base service version to fiat:2024.06.12.14.43.24.master (#612)
  - chore(build): Updating Build dependencies (#613)
  - chore(cd): update base service version to fiat:2024.07.01.23.37.17.master (#616)
  - chore(cd): update base service version to fiat:2024.07.02.18.24.28.master (#618)
  - chore(cd): update base service version to fiat:2024.08.06.19.16.43.master (#624)
  - chore(cd): update armory-commons version to 3.17.3 (#630)
  - chore(cd): update base service version to fiat:2024.08.06.19.16.43.release-1.35.x (#635)
  - chore(java): migrate to java 17 (backport #636) (#637)

#### Armory Kayenta - 2.34.0...2.35.0-rc1

  - chore(build): Updating Build dependencies (#544) (#545)
  - chore(cd): update base service version to kayenta:2024.04.01.18.08.38.master (#530)
  - chore(build): Updating Build dependencies (#544)
  - chore(cd): update base service version to kayenta:2024.06.13.14.30.12.master (#542)
  - chore(cd): update base service version to kayenta:2024.07.01.15.11.36.master (#546)
  - chore(cd): update base service version to kayenta:2024.07.03.20.32.39.master (#547)
  - chore(cd): update base service version to kayenta:2024.08.08.17.03.42.master (#548)
  - chore(cd): update base service version to kayenta:2024.08.13.23.14.13.master (#551)
  - chore(cd): update armory-commons version to 3.17.3 (#557)
  - chore(java): migrate to java 17 (#560) (#561)

#### Dinghy™ - 2.34.0...2.35.0-rc1

  - chore(dependencies): v0.0.0-20240213103436-d0dc889db2c6 (#529)
  - chore: Bumps and delete support (#533)

#### Armory Rosco - 2.34.0...2.35.0-rc1

  - Fix permissions on container (#675)
  - chore(build): Updating Build dependencies (#671) (#672)
  - chore(cd): update base service version to rosco:2024.04.18.17.06.07.release-1.34.x (#666)
  - chore(cd): update armory-commons version to 3.16.2 (#664)
  - chore(cd): update base service version to rosco:2024.04.18.16.53.13.master (#659)
  - chore(cd): update base service version to rosco:2024.05.10.18.26.57.master (#665)
  - chore(cd): update base service version to rosco:2024.06.06.14.05.00.master (#667)
  - chore(cd): update base service version to rosco:2024.06.07.06.01.10.master (#668)
  - chore(cd): update base service version to rosco:2024.06.12.03.37.34.master (#669)
  - chore(cd): update base service version to rosco:2024.06.12.14.46.35.master (#670)
  - chore(build): Updating Build dependencies (#671)
  - chore(cd): update base service version to rosco:2024.07.01.17.46.03.master (#673)
  - chore(cd): update base service version to rosco:2024.07.01.23.43.22.master (#674)
  - chore(cd): update base service version to rosco:2024.07.02.18.24.20.master (#678)
  - chore(cd): update base service version to rosco:2024.08.06.19.21.17.master (#683)
  - chore(cd): update armory-commons version to 3.17.3 (#689)
  - chore(cd): update base service version to rosco:2024.08.06.19.21.17.release-1.35.x (#694)
  - chore(java): Migrate to Java 17 (#695) (#696)
  - fix(java): fix merge conflict (#697)

#### Armory Igor - 2.34.0...2.35.0-rc1

  - chore(cd): update armory-commons version to 3.16.2 (#606)
  - chore(cd): update base service version to igor:2024.04.27.02.25.13.master (#602)
  - chore(cd): update base service version to igor:2024.05.08.16.58.51.master (#607)
  - chore(cd): update base service version to igor:2024.05.10.18.23.25.master (#608)
  - chore(cd): update base service version to igor:2024.06.06.14.04.06.master (#609)
  - chore(cd): update base service version to igor:2024.06.07.05.55.00.master (#610)
  - chore(cd): update base service version to igor:2024.06.12.03.35.53.master (#611)
  - chore(cd): update base service version to igor:2024.06.12.14.42.33.master (#612)
  - chore(build): Updating Build dependencies (#613)
  - chore(cd): update base service version to igor:2024.07.01.15.13.01.master (#615)
  - chore(cd): update base service version to igor:2024.07.01.23.40.57.master (#616)
  - chore(cd): update base service version to igor:2024.07.02.18.22.57.master (#618)
  - chore(cd): update base service version to igor:2024.07.17.18.07.09.master (#619)
  - chore(cd): update base service version to igor:2024.07.30.18.41.52.master (#620)
  - chore(cd): update base service version to igor:2024.08.06.19.18.18.master (#621)
  - chore(cd): update base service version to igor:2024.08.13.08.13.54.master (#622)
  - chore(cd): update armory-commons version to 3.17.3 (#628)
  - chore(cd): update base service version to igor:2024.08.13.08.13.54.release-1.35.x (#634)
  - chore(java): migrate to java 17 (#635)

#### Armory Gate - 2.34.0...2.35.0-rc1

  - chore(build): Updating Build dependencies (#732) (#733)
  - chore(cd): update armory-commons version to 3.16.2 (#721)
  - Updating Armory commons and gradle jar (#714)
  - chore(build): Updating Build dependencies (#732)
  - chore(cd): update base service version to gate:2024.06.12.14.34.23.master (#731)
  - chore(cd): update base service version to gate:2024.07.02.02.26.57.master (#736)
  - chore(cd): update base service version to gate:2024.07.02.18.25.11.master (#738)
  - chore(cd): update base service version to gate:2024.07.12.17.45.03.master (#739)
  - chore(cd): update base service version to gate:2024.07.17.16.39.39.master (#740)
  - chore(cd): update base service version to gate:2024.07.17.18.06.59.master (#741)
  - chore(cd): update base service version to gate:2024.07.30.18.41.46.master (#742)
  - chore(cd): update base service version to gate:2024.08.06.19.17.52.master (#743)
  - chore(cd): update base service version to gate:2024.08.13.08.18.00.master (#748)
  - chore(cd): update base service version to gate:2024.08.23.19.46.38.master (#749)
  - chore(cd): update armory-commons version to 3.17.3 (#755)
  - chore(base): bump base 1.35 and migrate to jdk17 (#766)
  - chore(java): migrate to jdk 17 (backport #767) (#768)

#### Armory Front50 - 2.34.0...2.35.0-rc1

  - chore(cd): update base service version to front50:2024.06.18.14.36.38.release-1.34.x (#696)
  - chore(cd): update armory-commons version to 3.16.2 (#685)
  - chore(cd): update base service version to front50:2024.04.29.15.39.38.master (#682)
  - chore(cd): update base service version to front50:2024.05.10.18.26.08.master (#686)
  - chore(cd): update base service version to front50:2024.05.16.17.58.24.master (#687)
  - chore(cd): update base service version to front50:2024.06.03.19.41.03.master (#688)
  - chore(cd): update base service version to front50:2024.06.06.14.02.13.master (#689)
  - chore(cd): update base service version to front50:2024.06.07.05.54.32.master (#690)
  - chore(cd): update base service version to front50:2024.06.10.17.07.03.master (#691)
  - chore(cd): update base service version to front50:2024.06.11.21.15.35.master (#693)
  - chore(cd): update base service version to front50:2024.06.12.04.59.08.master (#694)
  - chore(cd): update base service version to front50:2024.06.12.14.34.39.master (#695)
  - chore(build): Updating Build dependencies (#697)
  - chore(cd): update base service version to front50:2024.07.01.23.39.55.master (#699)
  - chore(cd): update base service version to front50:2024.07.02.18.24.06.master (#701)
  - chore(cd): update base service version to front50:2024.07.12.17.45.40.master (#702)
  - chore(cd): update base service version to front50:2024.07.17.18.08.28.master (#703)
  - chore(cd): update base service version to front50:2024.07.23.02.51.23.master (#704)
  - chore(cd): update base service version to front50:2024.07.30.18.37.55.master (#705)
  - chore(cd): update base service version to front50:2024.08.06.19.20.30.master (#706)
  - chore(cd): update base service version to front50:2024.08.13.08.16.50.master (#707)
  - chore(cd): update base service version to front50:2024.08.17.02.15.46.master (#709)
  - chore(cd): update base service version to front50:2024.08.18.01.59.14.master (#710)
  - chore(cd): update base service version to front50:2024.08.23.15.47.09.master (#714)
  - chore(cd): update armory-commons version to 3.17.3 (#719)
  - chore(cd): update base service version to front50:2024.08.23.16.11.34.release-1.35.x (#724)
  - chore(java): migrate to jdk 17 (backport #726) (#727)

#### Terraformer™ - 2.34.0...2.35.0-rc1

  - fix: ASSMT-304: Jobs are in RUNNING status indefinitely. (#563)
  - fix: ASSMT-304: func passes lock by value issue. (#564)
  - fix: ASSMT-304: panic: interface conversion: interface {} is **runner.Job, not *runner.Job. (#565)
  - chore: Move terraformer versions to docker hub (#567)
  - Fix: typo in secret for docker password (#568)
  - fix: ASSMT-304: Performance degradation. (#566)
  - fix: ASSMT-304: incorrect Terraform stage execution status, logs appeared after the stage was executed, truncated logs, missing data in the context outputs of the stage. (#570)

#### Armory Clouddriver - 2.34.0...2.35.0-rc1

  - chore(cd): update base service version to clouddriver:2024.06.11.19.47.52.release-1.34.x (#1136)
  - chore(cd): update base service version to clouddriver:2024.06.11.18.46.36.release-1.34.x (#1135)
  - chore(cd): update base service version to clouddriver:2024.06.11.17.42.55.release-1.34.x (#1134)
  - chore(cd): update base service version to clouddriver:2024.05.15.14.49.18.release-1.34.x (#1126)
  - chore(cd): update base service version to clouddriver:2024.05.07.00.11.46.release-1.34.x (#1122)
  - chore(cd): update armory-commons version to 3.16.2 (#1118)
  - chore(cd): update base service version to clouddriver:2024.04.29.20.13.35.master (#1115)
  - chore(cd): update base service version to clouddriver:2024.05.01.12.49.03.master (#1119)
  - chore(cd): update base service version to clouddriver:2024.05.01.21.46.13.master (#1120)
  - chore(cd): update base service version to clouddriver:2024.05.02.04.24.59.master (#1121)
  - chore(cd): update base service version to clouddriver:2024.05.10.18.56.26.master (#1124)
  - chore(cd): update base service version to clouddriver:2024.05.15.14.03.08.master (#1125)
  - chore(cd): update base service version to clouddriver:2024.05.16.17.58.54.master (#1128)
  - chore(cd): update base service version to clouddriver:2024.06.05.17.42.55.master (#1130)
  - chore(cd): update base service version to clouddriver:2024.06.06.14.39.20.master (#1131)
  - chore(cd): update base service version to clouddriver:2024.06.07.06.44.17.master (#1132)
  - chore(cd): update base service version to clouddriver:2024.06.07.15.13.58.master (#1133)
  - chore(cd): update base service version to clouddriver:2024.06.12.06.05.50.master (#1137)
  - chore(cd): update base service version to clouddriver:2024.06.12.15.09.36.master (#1138)
  - chore(build): Updating Build dependencies (#1140)
  - chore(cd): update base service version to clouddriver:2024.06.26.14.55.22.master (#1141)
  - chore(cd): update base service version to clouddriver:2024.07.02.00.14.36.master (#1143)
  - chore(cd): update base service version to clouddriver:2024.07.02.17.16.09.master (#1144)
  - chore(cd): update base service version to clouddriver:2024.07.09.23.51.13.master (#1145)
  - chore(cd): update base service version to clouddriver:2024.07.12.18.00.41.master (#1146)
  - chore(cd): update base service version to clouddriver:2024.07.13.14.35.46.master (#1147)
  - chore(cd): update base service version to clouddriver:2024.07.13.20.49.12.master (#1148)
  - chore(cd): update base service version to clouddriver:2024.07.16.21.05.02.master (#1149)
  - chore(cd): update base service version to clouddriver:2024.07.17.17.30.47.master (#1150)
  - chore(cd): update base service version to clouddriver:2024.08.07.03.50.02.master (#1153)
  - chore(cd): update base service version to clouddriver:2024.08.07.04.42.37.master (#1154)
  - chore(cd): update base service version to clouddriver:2024.08.08.16.49.12.master (#1155)
  - chore(cd): update base service version to clouddriver:2024.08.13.08.52.16.master (#1158)
  - chore(cd): update base service version to clouddriver:2024.08.16.16.47.04.master (#1159)
  - chore(cd): update base service version to clouddriver:2024.08.17.18.34.38.master (#1162)
  - chore(cd): update base service version to clouddriver:2024.08.18.01.11.26.master (#1164)
  - chore(cd): update base service version to clouddriver:2024.08.19.18.37.14.master (#1166)
  - chore(cd): update base service version to clouddriver:2024.08.20.16.01.28.master (#1167)
  - chore(cd): update base service version to clouddriver:2024.08.20.17.06.19.master (#1168)
  - chore(cd): update base service version to clouddriver:2024.08.27.16.04.19.master (#1170)
  - chore(cd): update armory-commons version to 3.17.3 (#1174)
  - chore(cd): update base service version to clouddriver:2024.08.27.16.52.09.release-1.35.x (#1182)
  - chore(cd): update base service version to clouddriver:2024.10.15.15.18.20.release-1.35.x (#1185)
  - chore(java): compile base service with Java 17 (#1183) (#1186)
  - chore(java): Migrate to java 17 (#1187) (#1188)

#### Armory Deck - 2.34.0...2.35.0-rc1

  - chore(cd): update base deck version to 2024.0.0-20240513181436.release-1.34.x (#1417)
  - chore(cd): update base deck version to 2024.0.0-20240510163512.release-1.34.x (#1413)
  - chore(cd): update base deck version to 2024.0.0-20240509180831.release-1.34.x (#1410)
  - chore(cd): update base deck version to 2024.0.0-20240507163358.release-1.34.x (#1407)
  - chore(cd): update base deck version to 2024.0.0-20240425133611.master (#1402)
  - chore(cd): update base deck version to 2024.0.0-20240507073802.master (#1405)
  - chore(cd): update base deck version to 2024.0.0-20240507161802.master (#1406)
  - chore(cd): update base deck version to 2024.0.0-20240510143732.master (#1411)
  - chore(cd): update base deck version to 2024.0.0-20240512134402.master (#1414)
  - chore(cd): update base deck version to 2024.0.0-20240513123242.master (#1415)
  - chore(cd): update base deck version to 2024.0.0-20240610143829.master (#1419)
  - chore(cd): update base deck version to 2024.0.0-20240626113443.master (#1422)
  - chore(cd): update base deck version to 2024.0.0-20240701180101.master (#1423)
  - chore(cd): update base deck version to 2024.0.0-20240709230956.master (#1424)
  - chore(cd): update base deck version to 2024.0.0-20240801174507.master (#1425)
  - chore(cd): update base deck version to 2024.0.0-20240808170143.master (#1426)
  - chore(cd): update base deck version to 2024.0.0-20240808170143.master (#1429)
  - chore(cd): update base deck version to 2024.0.0-20240911165928.release-1.35.x (#1431)

#### Armory Echo - 2.34.0...2.35.0-rc1

  - chore(cd): update armory-commons version to 3.16.2 (#716)
  - chore(cd): update base service version to echo:2024.04.27.02.26.26.master (#712)
  - chore(cd): update base service version to echo:2024.05.10.18.24.59.master (#717)
  - chore(cd): update base service version to echo:2024.06.06.14.04.52.master (#718)
  - chore(cd): update base service version to echo:2024.06.07.06.00.43.master (#719)
  - chore(cd): update base service version to echo:2024.06.12.05.10.02.master (#720)
  - chore(cd): update base service version to echo:2024.06.12.14.34.33.master (#721)
  - chore(cd): update base service version to echo:2024.06.12.14.52.56.master (#722)
  - chore(build): Updating Build dependencies (#723)
  - chore(cd): update base service version to echo:2024.07.01.23.39.31.master (#726)
  - chore(cd): update base service version to echo:2024.07.02.19.53.07.master (#729)
  - chore(cd): update base service version to echo:2024.07.09.16.15.40.master (#730)
  - chore(cd): update base service version to echo:2024.07.11.21.33.00.master (#731)
  - chore(cd): update base service version to echo:2024.07.18.11.05.25.master (#732)
  - chore(cd): update base service version to echo:2024.07.19.13.57.31.master (#733)
  - chore(cd): update base service version to echo:2024.07.30.18.39.41.master (#734)
  - chore(cd): update base service version to echo:2024.08.06.19.58.37.master (#735)
  - chore(cd): update base service version to echo:2024.08.13.08.15.00.master (#736)
  - chore(cd): update armory-commons version to 3.17.3 (#743)
  - chore(java): migrate to jdk 17 (backport #750) (#751)


### Spinnaker


#### Spinnaker Orca - 1.35.4

  - fix(liquibase): fix checkSum errors occurring with spinnaker upgrade (#4727) (#4744)
  - fix(tests): add new containerized integration tests to run orca with mysql and postgres (#4736) (#4742)
  - feat(build): add orca-integration module to exercise the just-built docker image (#4721) (#4740)
  - fix(blueGreen): Scaling replicaSets should not be considered for deletion (#4728) (#4730)
  - fix(jenkins): Wrong Job name encoding in query params for Artifacts/Properties (#4722) (#4723)
  - chore(dependencies): Autobump fiatVersion (#4704)
  - feat(front50): set front50.useTriggeredByEndpoint to true by default (#4707)
  - fix(clouddriver): Handle the Retrofit conversionError in ClusterSizePreconditionTask (#4708)
  - fix(test/keel): Javadoc referring to missing method in ImportDeliveryConfigTaskTest (#4709)
  - fix(clouddriver): Throw SpinnakerHttpException when Http status is 403 in DetermineSourceServerGroupTask (#4710)
  - fix(test/bakery): Mock http errors using SpinnakerHttpException in CompletedBakeTaskSpec (#4711)
  - chore(dependencies): Autobump korkVersion (#4713)
  - chore(dependencies): Autobump fiatVersion (#4714)
  - chore(dependencies): Autobump korkVersion (#4715)
  - refactor(retrofit): Cleanup unused RetrofitError occurrences (#4712)
  - fix(test/clouddriver): Mock http error using SpinnakerHttpException in WaitForCloudFormationCompletionTaskSpec (#4717)
  - refactor(retrofit): Dismantle RetrofitExceptionHandler (#4716)
  - feat(build): add orca-integration module to exercise the just-built docker image (#4721)
  - fix(jenkins): Wrong Job name encoding in query params for Artifacts/Properties (#4722)
  - chore(dependencies): Autobump korkVersion (#4726)
  - fix(blueGreen): Scaling replicaSets should not be considered for deletion (#4728)
  - chore(dependencies): Autobump korkVersion (#4734)
  - chore(dependencies): Autobump korkVersion (#4735)
  - fix(tests): add new containerized integration tests to run orca with mysql and postgres (#4736)
  - fix(liquibase): fix checkSum errors occurring with spinnaker upgrade (#4727)
  - chore(build): enable cross compilation plugin for Java 17 (#4738)
  - chore(dependencies): Autobump korkVersion (#4745)
  - chore(dependencies): Autobump fiatVersion (#4746)
  - fix(dokka): use version 1.9.20 of org.jetbrains.dokka (#4747)
  - fix(build): revert java17 changes (#4750)
  - chore(gradle): Fix gradle test memory allocation (#4748)
  - chore(build): exercise dokka in prs and branch builds (#4751)
  - chore(build): enable cross compilation plugin for Java 17 (take 2) (#4752)
  - fix(integration/test): increase container startup time (#4754)
  - fix(build): remove dokka plugin since it doesn't work with java 17 (#4753)
  - chore(deps): bump docker/build-push-action from 5 to 6 (#4756)
  - chore(dependencies): Autobump korkVersion (#4757)
  - chore(dependencies): Autobump korkVersion (#4758)
  - chore(dependencies): Autobump korkVersion (#4759)
  - feat(SpEL): implement to configure the limit of characters for SpEL expressions (#4755)
  - perf(sql): Store child pipeline execution in trigger as reference (#4749)
  - test(core): demonstrate behavior of SpEL expression evaluation (#4762)
  - fix(orca-clouddriver): replace getType() with StageDefinitionBuilder.getType() for DestroyServerGroup (#4761)
  - chore(dependencies): Autobump korkVersion (#4763)
  - fix(tests): refactor tests and junit platform name to execute startup tests (#4764)
  - fix(sqlExecutionRepo): Return compressed columns when enabled for retrieve pipelines with configId (#4765)
  - test(sql): Add extra test  for pipelineRef feature flag (#4760)
  - chore(dependencies): Autobump korkVersion (#4767)
  - chore(dependencies): Autobump korkVersion (#4768)
  - refactor(test): replace assertion used from library unitils-core to assertj-core while spockframework upgrade to 2.2-groovy-3.0 (#4769)
  - chore(dependency): add explicit assertj-core dependency while spockframework upgrade to 2.2-groovy-3.0 (#4770)
  - chore(dependency): add explicit byte-buddy dependency while upgrading spockframework to 2.2-groovy-3.0 (#4771)
  - chore(dependencies): Autobump korkVersion (#4772)
  - chore(dependencies): Autobump fiatVersion (#4774)

#### Spinnaker Fiat - 1.35.4

  - chore(dependencies): Autobump korkVersion (#1157)
  - feat(build): add fiat-integration module to exercise the just-built docker imageTest docker image (#1158)
  - chore(dependencies): Autobump korkVersion (#1159)
  - chore(dependencies): Autobump korkVersion (#1163)
  - chore(dependencies): Autobump korkVersion (#1164)
  - chore(dependencies): Autobump korkVersion (#1165)
  - chore(build): enable cross compilation plugin for Java 17 (#1166)
  - chore(deps): bump docker/build-push-action from 5 to 6 (#1167)
  - chore(dependencies): Autobump korkVersion (#1168)
  - chore(dependencies): Autobump korkVersion (#1169)
  - chore(dependencies): Autobump korkVersion (#1170)
  - chore(dependencies): Autobump korkVersion (#1171)
  - chore(dependencies): Autobump korkVersion (#1172)
  - refactor(fiat-core): convert groovy unit tests to java (#1174)
  - chore(dependencies): Autobump korkVersion (#1175)
  - fix(ldap/roles): fix the issue of multiple entries in Ldap for single user (#1173)
  - chore(dependencies): Autobump korkVersion (#1176)

#### Spinnaker Kayenta - 1.35.4

  - chore(dependencies): Autobump orcaVersion (#1027)
  - chore(deps): bump gradle/wrapper-validation-action from 2 to 3 (#1031)
  - feat(build): add kayenta-integration module to exercise the just-built docker image (#1032)
  - refactor(retrofit): add SpinnakerServerExceptionHandler (#1035)
  - chore(dependencies): Autobump orcaVersion (#1036)
  - chore(dependency): unpin mysql-connector-java and liquibase-core (#1037)
  - chore(dependencies): Autobump orcaVersion (#1041)
  - refactor(auto-configuration): replace spring.factories with AutoConfiguration.imports file to enable auto-configuration during upgrade to spring boot 2.7.x (#1039)
  - chore(build): enable cross compilation plugin for Java 17 (#1040)
  - chore(deps): bump docker/build-push-action from 5 to 6 (#1044)
  - chore(build): upgrade builder image to gradle:7.6.1-jdk17 (#1045)
  - fix(stackdriver): handle null timeSeries and empty points (#1047)
  - chore(dependencies): Autobump orcaVersion (#1057)

#### Spinnaker Rosco - 1.35.4

  - chore(dependencies): Autobump korkVersion (#1086)
  - fix(install): Removed install_aws_cli2 function from Debian post installation script which installs a Debian package within a Debian package causing errors, as well as errors when an aws cli is already installed (#6945) (#1088)
  - chore(dependencies): Autobump korkVersion (#1090)
  - chore(dependencies): Autobump korkVersion (#1091)
  - chore(dependencies): Autobump korkVersion (#1092)
  - chore(dependencies): Autobump korkVersion (#1093)
  - chore(dependencies): Autobump korkVersion (#1094)
  - chore(dependencies): Autobump korkVersion (#1095)
  - chore(build): enable cross compilation plugin for Java 17 (#1096)
  - chore(deps): bump docker/build-push-action from 5 to 6 (#1097)
  - chore(dependencies): Autobump korkVersion (#1098)
  - chore(dependencies): Autobump korkVersion (#1099)
  - chore(dependencies): Autobump korkVersion (#1100)
  - chore(dependencies): Autobump korkVersion (#1101)
  - refactor(test): fix scope of init method while upgrading junit to 5.9.0 (#1102)
  - chore(dependencies): Autobump korkVersion (#1103)
  - chore(dependencies): Autobump korkVersion (#1104)
  - chore(dependencies): Autobump korkVersion (#1105)

#### Spinnaker Igor - 1.35.4

  - chore(dependencies): Autobump korkVersion (#1255)
  - fix(travis): Properly return API triggered builds (#1256)
  - chore(dependencies): Autobump korkVersion (#1257)
  - chore(dependencies): Autobump korkVersion (#1259)
  - chore(dependencies): Autobump korkVersion (#1260)
  - refactor(artifact): moved artifacts (groovy) unit tests to artifacts (java) (#1258)
  - chore(dependencies): Autobump korkVersion (#1261)
  - chore(dependencies): Autobump fiatVersion (#1262)
  - chore(deps): bump docker/build-push-action from 5 to 6 (#1263)
  - chore(dependencies): Autobump korkVersion (#1264)
  - chore(dependencies): Autobump korkVersion (#1265)
  - chore(dependencies): Autobump korkVersion (#1266)
  - chore(dependencies): Autobump korkVersion (#1267)
  - chore(dependencies): Autobump korkVersion (#1268)
  - chore(dependencies): Autobump korkVersion (#1269)
  - chore(dependencies): Autobump korkVersion (#1270)
  - chore(dependencies): Autobump fiatVersion (#1271)

#### Spinnaker Gate - 1.35.4

  - chore(dependencies): Autobump korkVersion (#1791)
  - chore(dependencies): Autobump fiatVersion (#1792)
  - chore(dependencies): Autobump korkVersion (#1793)
  - feat(build): add gate-integration module to exercise the just-built docker image (#1794)
  - feat(gha): run integration test in branch builds (#1795)
  - feat(saml): Update SAML to use Spring Security (#1744)
  - chore(dependencies): Autobump korkVersion (#1797)
  - fix(web/test): stop leaking system properties from FunctionalSpec (#1798)
  - chore(dependencies): Autobump korkVersion (#1801)
  - chore(dependencies): Autobump korkVersion (#1802)
  - chore(build): enable cross compilation plugin for Java 17 (#1803)
  - chore(dependencies): Autobump korkVersion (#1804)
  - chore(dependencies): Autobump fiatVersion (#1805)
  - chore(dependencies): Autobump korkVersion (#1806)
  - chore(deps): bump docker/build-push-action from 5 to 6 (#1807)
  - chore(dependencies): Autobump korkVersion (#1808)
  - chore(dependencies): Autobump korkVersion (#1809)
  - chore(dependencies): Autobump korkVersion (#1810)
  - refactor(test): fix scope of setup method while upgrading junit to 5.9.0 (#1811)
  - chore(dependencies): Autobump korkVersion (#1812)
  - chore(dependencies): Autobump korkVersion (#1814)
  - chore(dependencies): Autobump korkVersion (#1815)
  - fix(core): remove ErrorPageSecurityFilter bean named errorPageSecurityFilter (#1819)
  - chore(dependencies): Autobump fiatVersion (#1820)

#### Spinnaker Front50 - 1.35.4

  - chore(dependencies): Autobump fiatVersion (#1454)
  - refactor(web): change ensureCronTriggersHaveIdentifier to return void (#1457)
  - chore(dependencies): Autobump korkVersion (#1460)
  - chore(dependencies): Autobump fiatVersion (#1461)
  - chore(dependencies): Autobump korkVersion (#1462)
  - feat(migrations): Support for migrations defined in plugins (#1458)
  - chore(dependencies): Autobump korkVersion (#1463)
  - chore(dependency): unpin mysql-connector-java (#1464)
  - fix(web): Retrieve dependent pipelines correctly (#1459)
  - chore(dependencies): Autobump korkVersion (#1467)
  - chore(dependencies): Autobump korkVersion (#1468)
  - fix(migrator): GCS to SQL migrator APPLICATION_PERMISSION objectType fix (#1466)
  - chore(build): enable cross compilation plugin for Java 17 (#1469)
  - chore(dependencies): Autobump korkVersion (#1475)
  - chore(dependencies): Autobump fiatVersion (#1476)
  - chore(deps): bump docker/build-push-action from 5 to 6 (#1477)
  - chore(dependencies): Autobump korkVersion (#1478)
  - chore(dependencies): Autobump korkVersion (#1479)
  - chore(dependencies): Autobump korkVersion (#1480)
  - chore(dependencies): Autobump korkVersion (#1481)
  - chore(dependencies): Autobump korkVersion (#1482)
  - refactor(validator): moved validator groovy unit tests to java (#1484)
  - chore(dependencies): Autobump korkVersion (#1485)
  - chore(dependencies): Autobump korkVersion (#1486)
  - chore(dependencies): Autobump fiatVersion (#1487)
  - fix(gha): only bump halyard on master (#1490) (#1492)
  - fix(front50-gcs): Fix ObjectType filenames for GCS Front50 persistent store (#1493) (#1495)

#### Spinnaker Clouddriver - 1.35.4

  - fix(liquibase): fix checkSum errors occurring with spinnaker upgrade (#6217) (#6232)
  - fix(tests): refactored existing containerized integration test and added new tests for postgres and mysql (#6221) (#6230)
  - feat(build): add fiat-integration module to exercise the just-built docker imageTest docker image (#6206) (#6228)
  - fix(ClusterController): Fix GetClusters returning only the last 2 providers clusterNames of application (#6210) (#6213)
  - fix(gcp): Relaxed health check for GCP accounts (#6200) (#6202)
  - fix(databaseChangeLog): fix for 'addAfterColumn is not allowed on postgresql' (#6194) (#6196)
  - chore(deps): remove duplicate/old fiatVersion (#6191) (#6193)
  - chore(dependencies): Autobump korkVersion (#6183) (#6192)
  - feat(docker): Add RBAC support to Docker accounts (#6187)
  - chore(dependencies): Autobump korkVersion (#6183)
  - chore(deps): remove duplicate/old fiatVersion (#6191)
  - fix(databaseChangeLog): fix for 'addAfterColumn is not allowed on postgresql' (#6194)
  - chore(dependencies): Autobump korkVersion (#6197)
  - chore(dependencies): Autobump fiatVersion (#6198)
  - chore(dependencies): Autobump korkVersion (#6199)
  - feat(aws): Install AWS CLI v2, upgrade aws-iam-authenticator, remove s3cmd (#6156)
  - fix(gcp): Relaxed health check for GCP accounts (#6200)
  - chore(deps): bump gradle/wrapper-validation-action from 2 to 3 (#6205)
  - feat(build): add fiat-integration module to exercise the just-built docker imageTest docker image (#6206)
  - chore(ecs/dependencies): make spring-boot-starter-test a testImplememtation dependency (#6207)
  - chore(dependencies): Autobump korkVersion (#6208)
  - fix(ClusterController): Fix GetClusters returning only the last 2 providers clusterNames of application (#6210)
  - chore(dependency): unpin mysql-connector-java (#6214)
  - config(googlecloudsdkversion): Upgraded the google cloud sdk version from 412.0.0 to 476.0.0 in clouddriver. (#6216)
  - feat(kubernetes): support label selectors in deploy manifest stages (#6220)
  - fix(tests): refactored existing containerized integration test and added new tests for postgres and mysql (#6221)
  - chore(dependencies): Autobump korkVersion (#6223)
  - chore(dependencies): Autobump korkVersion (#6224)
  - fix(liquibase): fix checkSum errors occurring with spinnaker upgrade (#6217)
  - chore(dependencies): Autobump korkVersion (#6233)
  - chore(dependencies): Autobump fiatVersion (#6234)
  - fix(aws): allow enabledMetrics: [] to enable all metrics (#6238)
  - fix(google): fixing UpsertGoogleAutoscalingPolicyAtomicOperation missing Autowired for objectMapper and cacheView (#6237)
  - chore(build): enable cross compilation plugin for Java 17 (#6226)
  - chore(dependencies): Autobump korkVersion (#6243)
  - chore(dependencies): Autobump korkVersion (#6244)
  - chore(dependencies): Autobump korkVersion (#6245)
  - chore(azure/build): improve test times for azure (#6246)
  - chore(deps): bump docker/build-push-action from 5 to 6 (#6242)
  - feat(aws): support throughput property of block devices (#6248)
  - chore(dependencies): Autobump korkVersion (#6247)
  - fix(kubernetes/job): Fix an edge case where a job can have no pods (#6251)
  - refactor(test): fix scope of setup method while upgrading junit to 5.9.0 (#6249)
  - chore(dependencies): Autobump korkVersion (#6253)
  - feat(kubernetes): Skip applying labels to spec.template.metadata if skipSpecTemplateLabels is true (#6254)
  - perf(cache): Optimise heap usage in KubernetesCachingAgent (#6255)
  - chore(dependency): add explicit byte-buddy dependency while upgrading spockframework to 2.2-groovy-3.0 (#6257)
  - chore(dependencies): Autobump korkVersion (#6258)
  - chore(gcp): Adding STRONG_COOKIE_AFFINITY in gcp LB model (#6259)
  - chore(dependencies): Autobump fiatVersion (#6264)
  - fix(kubernetes): teach deployManifest stages to handle label selectors with generateName (#6265)
  - fix(gha): only bump halyard on master (#6268) (#6270)
  - fix(gha): remove whitespace from BRANCH in release.yml (#6271) (#6273)
  - fix(install): Fixed Debian post install script for aws-iam-authenticator (#6274) (#6275)
  - fix(install): Fix Debian post installation script when awscli2 is already installed or the installation failed previously (#6276) (#6277)
  - fix(aws): Fix AWS CLI v2 for Alpine Linux (#6279) (#6280)
  - fix(cloudfoundry): Update ProcessStats model due to capi-1.84.0 changes (#6283) (#6293)

#### Spinnaker Deck - 1.35.4

  - fix(redblack): fixing redblack onchange values (#10107) (#10109)
  - fix(pipeline): Handle render/validation when stageTimeoutMs is a Spel expression (#10103) (#10104)
  - feat(taskView): Implement opt-in paginated request for TaskView (#10093) (#10096)
  - fix(lambda): Invoke stage excludedArtifactTypes not including the embedded-artifact type (#10097) (#10100)
  - fix(lambdaStages): Exporting Lambda stages based on the feature flag settings (#10085) (#10090)
  - fix(pipelineGraph): Handling exception when requisiteStageRefIds is not defined (#10086) (#10087)
  - chore(deps-dev): bump vite from 2.9.17 to 2.9.18 in /packages/app (#10082)
  - fix(pipelineGraph): Handling exception when requisiteStageRefIds is not defined (#10086)
  - fix(lambdaStages): Exporting Lambda stages based on the feature flag settings (#10085)
  - feat(taskView): Implement opt-in paginated request for TaskView (#10093)
  - fix(lambda): Invoke stage excludedArtifactTypes not including the embedded-artifact type (#10097)
  - fix(pipeline): Handle render/validation when stageTimeoutMs is a Spel expression (#10103)
  - Publish packages to NPM (#10074)
  - fix(redblack): fixing redblack onchange values (#10107)
  - fix(lambda): Export LambdaRoute stage on aws module (#10116)
  - Publish packages to NPM (#10108)
  - feat(pluginsdk): Allow overriding proxy ports in deck dev-proxy (#10115)
  - chore(deps): bump @spinnaker/kayenta from 2.1.0 to 2.3.0 (#10114)
  - chore(deps): bump docker/build-push-action from 5 to 6 (#10121)
  - chore(secrets): adding GHA to sync NPM_AUTH_TOKEN to spinnaker/spinna… (#10122)
  - chore(deps): bump actions/checkout from 2 to 4 (#10123)
  - chore(gcp): Adding STRONG_COOKIE_AFFINITY in gcp LB model (#10124)
  - fix(aws): Fix userData getting lost when cloning an AWS server group that uses launch templates (#6771) (#10132) (#10141)
  - fix(aws): Fix IPv6 addresses being incorrectly associated when cloning server groups that have launch templates enabled (#6979) (#10142) (#10144)

#### Spinnaker Echo - 1.35.4

  - chore(dependencies): Autobump korkVersion (#1419)
  - chore(dependencies): Autobump korkVersion (#1420)
  - chore(dependencies): Autobump korkVersion (#1422)
  - chore(dependencies): Autobump korkVersion (#1423)
  - chore(dependencies): Autobump korkVersion (#1425)
  - chore(dependencies): Autobump fiatVersion (#1427)
  - chore(build): enable cross compilation plugin for Java 17 (#1426)
  - chore(deps): bump docker/build-push-action from 5 to 6 (#1430)
  - chore(dependencies): Autobump korkVersion (#1431)
  - chore(dependencies): Autobump korkVersion (#1432)
  - chore(dependencies): Autobump korkVersion (#1433)
  - feat(SpEL): implement to configure the limit of characters for SpEL expressions (#1429)
  - test(pipelinetriggers): demonstrate behavior of SpEL expression evaluation (#1434)
  - feat(notifications/cdEvents): added support for customData (#1424)
  - chore(dependencies): Autobump korkVersion (#1435)
  - chore(dependencies): Autobump korkVersion (#1436)
  - refactor(amazon_sqs_subscriber): moved AmazonSQSSubscriberSpec (groovy) unit test to AmazonSQSSubscriberTest (java) (#1428)
  - chore(dependencies): Autobump korkVersion (#1437)

