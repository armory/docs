---
title: v2.27.8-rc4 Armory Release (OSS Spinnaker™ v1.27.4)
toc_hide: true
date: 2023-03-22
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
description: >
  Release notes for Armory Continuous Deployment v2.27.8-rc4. A beta release is not meant for installation in production environments.

---

## 2023/03/22 Release Notes

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

To install, upgrade, or configure Armory 2.27.8-rc4, use Armory Operator 1.70 or later.

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
[Spinnaker v1.27.4](https://www.spinnaker.io/changelogs/1.27.4-changelog/) changelog for details.

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
    commit: a3347ca5e207273abe60ca48e98bf494e6d8d359
    version: 2.27.8-rc4
  deck:
    commit: 57f5d89f15f6f9ddc5c3f4554e4b0a3bb6f03e2b
    version: 2.27.8-rc4
  dinghy:
    commit: d9146416b57d6c7008cfe6323ba3b0e6527181d0
    version: 2.27.8-rc4
  echo:
    commit: b220bcaa01be72ca2c4489203bc5ceb53d83e8af
    version: 2.27.8-rc4
  fiat:
    commit: e23c8b8a65463100c7075b1aacc140a0e0dc5216
    version: 2.27.8-rc4
  front50:
    commit: 5e1fe36c4b8df29cc9cb4d7af581a44b0ca44e59
    version: 2.27.8-rc4
  gate:
    commit: 9cd1a1174ee0bd19577ffdbd6aa11ad432a67082
    version: 2.27.8-rc4
  igor:
    commit: ebfdd8b8068fe1ff1ba3e7c25cd2b0c0fa803bd9
    version: 2.27.8-rc4
  kayenta:
    commit: 822b3339a4dbbccb9a135c102d8ba1ff199d49ec
    version: 2.27.8-rc4
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 2aa5a723767a5972a3b31278a1dcf5af32e66b99
    version: 2.27.8-rc4
  rosco:
    commit: 8b94ccff09fe762d896df9052e4199af6dd9b666
    version: 2.27.8-rc4
  terraformer:
    commit: 736ece67b4a52a612262cbe844d1edd3ad176d19
    version: 2.27.8-rc4
timestamp: "2023-03-22 15:19:48"
version: 2.27.8-rc4
</code>
</pre>
</details>

### Armory


#### Armory Fiat - 2.27.8-rc3...2.27.8-rc4


#### Armory Deck - 2.27.8-rc3...2.27.8-rc4


#### Terraformer™ - 2.27.8-rc3...2.27.8-rc4


#### Dinghy™ - 2.27.8-rc3...2.27.8-rc4


#### Armory Front50 - 2.27.8-rc3...2.27.8-rc4


#### Armory Gate - 2.27.8-rc3...2.27.8-rc4


#### Armory Echo - 2.27.8-rc3...2.27.8-rc4


#### Armory Igor - 2.27.8-rc3...2.27.8-rc4


#### Armory Orca - 2.27.8-rc3...2.27.8-rc4


#### Armory Kayenta - 2.27.8-rc3...2.27.8-rc4


#### Armory Rosco - 2.27.8-rc3...2.27.8-rc4


#### Armory Clouddriver - 2.27.8-rc3...2.27.8-rc4

  - chore(cd): update base service version to clouddriver:2023.03.21.20.22.35.release-1.27.x (#822)


### Spinnaker


#### Spinnaker Fiat - 1.27.4


#### Spinnaker Deck - 1.27.4


#### Spinnaker Front50 - 1.27.4


#### Spinnaker Gate - 1.27.4


#### Spinnaker Echo - 1.27.4


#### Spinnaker Igor - 1.27.4


#### Spinnaker Orca - 1.27.4


#### Spinnaker Kayenta - 1.27.4


#### Spinnaker Rosco - 1.27.4


#### Spinnaker Clouddriver - 1.27.4

  - fix(core): Renamed a query parameter for template tags (#5906) (#5907)

