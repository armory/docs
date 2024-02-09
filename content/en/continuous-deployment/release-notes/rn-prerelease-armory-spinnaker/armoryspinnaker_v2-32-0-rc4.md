---
title: v2.32.0-rc4 Armory Continuous Deployment Release (Spinnaker™ v1.32.3)
toc_hide: true
date: 2024-02-09
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
description: >
  Release notes for Armory Continuous Deployment v2.32.0-rc4. A beta release is not meant for installation in production environments.

---

## 2024/02/09 release notes

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

To install, upgrade, or configure Armory CD 2.32.0-rc4, use Armory Operator 1.70 or later.

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
    version: 2.32.0-rc4
  deck:
    commit: e7c8c0982afe9a49ab6c3d230f3aaa38e874eb30
    version: 2.32.0-rc4
  dinghy:
    commit: a257cbcab26643a18cdfab24bff3a5e1ef651a27
    version: 2.32.0-rc4
  echo:
    commit: b69e483d8f0c99da6ad21dacdc897e17257fe092
    version: 2.32.0-rc4
  fiat:
    commit: 2c0d010ce00d9519b316e15af734a05835df1048
    version: 2.32.0-rc4
  front50:
    commit: c68b97b642a6d9168d361d74dad373e565850f5d
    version: 2.32.0-rc4
  gate:
    commit: 1f96d4f238c63798cf34e818760ffb25b3a4b009
    version: 2.32.0-rc4
  igor:
    commit: fe40091df01e89e9abc4b6b761002397c4022298
    version: 2.32.0-rc4
  kayenta:
    commit: af68e872b806eb49f4f0071187f998f18f04c3c2
    version: 2.32.0-rc4
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: a575354cf39559e9784baad086e26f55fb2cb6ac
    version: 2.32.0-rc4
  rosco:
    commit: 776c66208dd16ad41defad3d0b6d8bcc3dbba24d
    version: 2.32.0-rc4
  terraformer:
    commit: 58c3386295676fccf44aa9d38c69e1e0482109ca
    version: 2.32.0-rc4
timestamp: "2024-02-08 19:30:17"
version: 2.32.0-rc4
</code>
</pre>
</details>

### Armory


#### Armory Front50 - 2.32.0-rc3...2.32.0-rc4


#### Armory Fiat - 2.32.0-rc3...2.32.0-rc4


#### Armory Kayenta - 2.32.0-rc3...2.32.0-rc4


#### Armory Rosco - 2.32.0-rc3...2.32.0-rc4


#### Armory Clouddriver - 2.32.0-rc3...2.32.0-rc4


#### Armory Gate - 2.32.0-rc3...2.32.0-rc4


#### Armory Orca - 2.32.0-rc3...2.32.0-rc4

  - Update RunTerraformTask.java

#### Armory Igor - 2.32.0-rc3...2.32.0-rc4


#### Dinghy™ - 2.32.0-rc3...2.32.0-rc4


#### Armory Echo - 2.32.0-rc3...2.32.0-rc4


#### Armory Deck - 2.32.0-rc3...2.32.0-rc4


#### Terraformer™ - 2.32.0-rc3...2.32.0-rc4

  - fixes for planfile (#545) (#546)


### Spinnaker


#### Spinnaker Front50 - 1.32.3


#### Spinnaker Fiat - 1.32.3


#### Spinnaker Kayenta - 1.32.3


#### Spinnaker Rosco - 1.32.3


#### Spinnaker Clouddriver - 1.32.3


#### Spinnaker Gate - 1.32.3


#### Spinnaker Orca - 1.32.3


#### Spinnaker Igor - 1.32.3


#### Spinnaker Echo - 1.32.3


#### Spinnaker Deck - 1.32.3


