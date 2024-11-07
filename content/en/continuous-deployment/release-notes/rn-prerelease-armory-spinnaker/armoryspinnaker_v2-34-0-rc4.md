---
title: v2.34.0-rc4 Armory Continuous Deployment Release (Spinnaker™ v1.34.3)
toc_hide: true
date: 2024-07-17
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
description: >
  Release notes for Armory Continuous Deployment v2.34.0-rc4. A beta release is not meant for installation in production environments.

---

## 2024/07/17 release notes

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

To install, upgrade, or configure Armory CD 2.34.0-rc4, use Armory Operator 1.8.6 or later.

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.
### Swagger UI endpoint change
API documentation implementing swagger has been upgraded to use Springfox 3.0.0.

Breaking Change: Swagger-ui endpoint changed from /swagger-ui.html to /swagger-ui/index.html.

### Kubernetes API version change for `client.authentication.k8s.io`
kubectl in the latest releases has removed support for external auth flows using the apiVersion: client.authentication.k8s.io/v1alpha1 exec API.

Breaking Change: Update your kubeconfig files to use the v1beta1 apiVersion: `client.authentication.k8s.io/v1beta1`

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

## Highlighted updates
<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->
### Spring Boot 2.6.15

Spring Boot 2.6 considers session data cached by previous Spring Boot versions invalid. Therefore, users with cached 
sessions will be unable to log in until the invalid information is removed from the cache. 

Open browser windows to Spinnaker are unresponsive after the deployment until they’re reloaded. 
Once Gate is updated to the new Armory CD version please execute:
```bash
$ redis-cli keys "spring:session*" | xargs redis-cli del
```
on Gate’s redis instance removes the cached session information.

### Lambda Operations
Introduced in OSS Spinnaker 1.33.0 and included in the 2.34.0-rc4 release, Armory CD now supports configurable Invocation timeouts 
and retries for Lambda operations. Previously the SDK would restrict timeouts despite any configuration to 55 seconds.

To set the timeout and retry values, add the following to your `clouddriver-local.yml`:

{{< highlight yaml "linenos=table,hl_lines=12-14" >}}
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      clouddriver:
        aws:
          features:
            lambda:
              enabled: true
          lambda:
            invokeTimeoutMs: 4000000
            retries: 3
{{< /highlight >}}

### Changes in S3 Artifact Store configuration
OSS Spinnaker 1.32.0 introduced support for [artifact storage](https://spinnaker.io/changelogs/1.32.0-changelog/#artifact-store)
with AWS S3. This feature compresses `embdedded/base64` artifacts to `remote/base64` and uploads them to an AWS S3 bucket significantly
reducing the artifact size in the execution context.

Armory version 2.32.0 added support for the same feature for the Terraform Integration stage.

In Armory CD version 2.34.0-rc4, the S3 Artifact Store configuration flags have been modified to support either store 
or retrieval or both of remote artifacts.

#### Configuration in 2.32.x
```yaml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      spinnaker:
        artifact-store:
          enabled: true
          s3:
            enabled: true
            region: <S3Bucket Region>
            bucket: <S3Bucket Name>
```

#### Configuration in 2.34.0-rc4 (Store/Get)
```yaml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      spinnaker:
        artifact-store:
          type: s3
          s3:
            enabled: true
            region: <S3Bucket Region>
            bucket: <S3Bucket Name>
```

#### Configuration in 2.34.0-rc4 (Get only)
```yaml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      spinnaker:
        artifact-store:
          type: s3
          s3:
            enabled: false
            region: <S3Bucket Region>
            bucket: <S3Bucket Name>
```

### Dinghy support for delete stale pipelines
Dinghy now support deleting stale pipelines - Any pipelines in the Spinnaker application that are not part of the `dinghyfile`.

These pipelines are identified and deleted automatically when the `dinghyfile` is updated and processed. You can set 
the `deleteStalePipelines` flag to `true` in the `dinghyfile` to enable this feature.

```json
{
  "application": "yourspinnakerapplicationname",
  "deleteStalePipelines": true,
  "pipelines": [
  ]
}
```

###  Spinnaker community contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.34.3](https://www.spinnaker.io/changelogs/1.34.3-changelog/) changelog for details.

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
    commit: 94c77a6b398a40993e6fba92e5692393d8f22564
    version: 2.34.0-rc4
  deck:
    commit: 63cd2960432f7921cecefc634bc5b187473832fe
    version: 2.34.0-rc4
  dinghy:
    commit: fbba492fb3d6c116d75f9ca959f6b5d84ab473a6
    version: 2.34.0-rc4
  echo:
    commit: 23909434bf95a0891a5ab256e5fccf5d7d8b6ed3
    version: 2.34.0-rc4
  fiat:
    commit: e8be593635189433704d0a7945fa1335c24ac896
    version: 2.34.0-rc4
  front50:
    commit: cce826e7cc2203970da4ebd37ccd9a91d9b39790
    version: 2.34.0-rc4
  gate:
    commit: 313be459112c23139adf1ef2717a850cc7797485
    version: 2.34.0-rc4
  igor:
    commit: e327e854cd7487881c15f4005f739b69ca4d7850
    version: 2.34.0-rc4
  kayenta:
    commit: 840e7e93fbc83c7704895307fe057b84d14776f2
    version: 2.34.0-rc4
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: b52430340a82dd536d4e6d13c5b9b44962452ff2
    version: 2.34.0-rc4
  rosco:
    commit: 23db1000615781164ae3042eed3ef8cf298d7da4
    version: 2.34.0-rc4
  terraformer:
    commit: 559abc8056e0f1c90d6bc737c57688f7c747c0ba
    version: 2.34.0-rc4
timestamp: "2024-07-17 11:24:58"
version: 2.34.0-rc4
</code>
</pre>
</details>

### Armory


#### Armory Clouddriver - 2.34.0-rc2...2.34.0-rc4


#### Dinghy™ - 2.34.0-rc2...2.34.0-rc4


#### Terraformer™ - 2.34.0-rc2...2.34.0-rc4


#### Armory Echo - 2.34.0-rc2...2.34.0-rc4


#### Armory Deck - 2.34.0-rc2...2.34.0-rc4


#### Armory Rosco - 2.34.0-rc2...2.34.0-rc4


#### Armory Kayenta - 2.34.0-rc2...2.34.0-rc4


#### Armory Gate - 2.34.0-rc2...2.34.0-rc4


#### Armory Igor - 2.34.0-rc2...2.34.0-rc4


#### Armory Front50 - 2.34.0-rc2...2.34.0-rc4


#### Armory Fiat - 2.34.0-rc2...2.34.0-rc4


#### Armory Orca - 2.34.0-rc2...2.34.0-rc4

  - chore(cd): update base orca version to 2024.07.17.09.05.39.release-1.34.x (#924)


### Spinnaker


#### Spinnaker Clouddriver - 1.34.3


#### Spinnaker Echo - 1.34.3


#### Spinnaker Deck - 1.34.3


#### Spinnaker Rosco - 1.34.3


#### Spinnaker Kayenta - 1.34.3


#### Spinnaker Gate - 1.34.3


#### Spinnaker Igor - 1.34.3


#### Spinnaker Front50 - 1.34.3


#### Spinnaker Fiat - 1.34.3


#### Spinnaker Orca - 1.34.3

  - fix(sqlExecutionRepo): Return compressed columns when enabled for retrieve pipelines with configId (backport #4765) (#4766)

