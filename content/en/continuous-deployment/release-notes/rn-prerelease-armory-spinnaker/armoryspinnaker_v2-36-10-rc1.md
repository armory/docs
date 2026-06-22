---
title: v2.36.10-rc1 Armory Continuous Deployment Release (Spinnaker™ v1.36.0)
toc_hide: true
date: 2026-06-22
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
description: >
  Release notes for Armory Continuous Deployment v2.36.10-rc1. A beta release is not meant for installation in production environments.

---

## 2026/06/22 release notes

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
{{% alert color="warning" title="Important" %}}
[Armory Operator]({{< ref "armory-operator" >}}) has been deprecated and will is considered EOL. Please migrate to the [Kustomize]({{< ref "armory-operator-to-kustomize-migration" >}}) method of deployment.
{{% /alert %}}

To install, upgrade, or configure Armory CD 2.36.10-rc1, use Armory Operator 1.8.6 or later.

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
[Spinnaker v1.36.0](https://www.spinnaker.io/changelogs/1.36.0-changelog/) changelog for details.

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
    commit: c981c5944ee4180577c439c65065b137853ff1ad
    version: 2.36.10-rc1
  deck:
    commit: 6652a558d0ebf2ccde6de2dfef2c2816d184ac47
    version: 2.36.10-rc1
  dinghy:
    commit: d36fdf5b496b18212275686d4c9069d72c9dbeb1
    version: 2.36.10-rc1
  echo:
    commit: 9ff1559a08ed6851c036ff1f51bde20e1eb36248
    version: 2.36.10-rc1
  fiat:
    commit: e77853e0322014f3b3f8911d9d6f2431830c192c
    version: 2.36.10-rc1
  front50:
    commit: 5f8f39172e88b3abe49bab28e2fcb786b8653bf0
    version: 2.36.10-rc1
  gate:
    commit: f99a459232f70e19a719a1962f7c6fcee9218750
    version: 2.36.10-rc1
  igor:
    commit: 30cab7aaabdfe08c05c37146ab644555cf413513
    version: 2.36.10-rc1
  kayenta:
    commit: 2ce818eed3873004412758a0f731cf8420df8594
    version: 2.36.10-rc1
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 58be0a3718da2b8d032372354bcddc4a1353e96a
    version: 2.36.10-rc1
  rosco:
    commit: aa56135eacf66b69f15fd1ef8e0b0fac525de625
    version: 2.36.10-rc1
  terraformer:
    commit: 8453d42107fda5f0c315c8459f523e9182805832
    version: 2.36.10-rc1
timestamp: "2026-06-19 14:27:30"
version: 2.36.10-rc1
</code>
</pre>
</details>

### Armory


#### Armory Gate - 2.36.9...2.36.10-rc1


#### Armory Terraformer - 2.36.9...2.36.10-rc1


#### Armory Clouddriver - 2.36.9...2.36.10-rc1


#### Armory Dinghy - 2.36.9...2.36.10-rc1


#### Armory Deck - 2.36.9...2.36.10-rc1


#### Armory Orca - 2.36.9...2.36.10-rc1


#### Armory Rosco - 2.36.9...2.36.10-rc1


#### Armory Echo - 2.36.9...2.36.10-rc1


#### Armory Igor - 2.36.9...2.36.10-rc1


#### Armory Fiat - 2.36.9...2.36.10-rc1


#### Armory Kayenta - 2.36.9...2.36.10-rc1


#### Armory Front50 - 2.36.9...2.36.10-rc1



### Spinnaker


#### Spinnaker Gate - 1.36.0


#### Spinnaker Terraformer - 1.36.0


#### Spinnaker Clouddriver - 1.36.0


#### Spinnaker Dinghy - 1.36.0


#### Spinnaker Deck - 1.36.0


#### Spinnaker Orca - 1.36.0


#### Spinnaker Rosco - 1.36.0


#### Spinnaker Echo - 1.36.0


#### Spinnaker Igor - 1.36.0


#### Spinnaker Fiat - 1.36.0


#### Spinnaker Kayenta - 1.36.0


#### Spinnaker Front50 - 1.36.0


