---
title: v2.36.0-rc4 Armory Continuous Deployment Release (Spinnaker™ v1.36.1)
toc_hide: true
date: 2025-02-05
version: 2.36.0
description: >
  Release notes for Armory Continuous Deployment v2.36.0-rc4. A beta release is not meant for installation in production environments.

---

## 2025/02/05 release notes

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

To install, upgrade, or configure Armory CD 2.36.0-rc4, use Armory Operator 1.70 or later.

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

## Highlighted updates

### Java upgrades 

Java 17 is now the default source and target. Java 11 support has been removed entirely. Please note you may need to add the following JAVA_OPTS options: `--add-exports=java.base/sun.security.x509=ALL-UNNAMED --add-exports=java.base/sun.security.pkcs=ALL-UNNAMED --add-exports=java.base/sun.security.rsa=ALL-UNNAMED` to clouddriver if using GCP accounts due to credentials parsing of certificates. These can set in the [service-settings config](https://spinnaker.io/docs/reference/halyard/custom/#custom-service-settings) . These configs are likely to be added to the defaults in all future releases

{{< highlight yaml "linenos=table,hl_lines=10" >}}
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    service-settings:
      clouddriver: 
        env:
          JAVA_OPTS: "--add-exports=java.base/sun.security.x509=ALL-UNNAMED --add-exports=java.base/sun.security.pkcs=ALL-UNNAMED --add-exports=java.base/sun.security.rsa=ALL-UNNAMED"
{{< /highlight >}}

### Enhanced pipeline batch update feature

#### Gate

Adds a new enpdoint, `POST /pipelines/bulksave`, which can take a list of pipeline configurations to save. The endpoint will return a response that indicates how many of the saves were successful, how many failed, and what the failures are. The structure is

'''
[
   "successful_pipelines_count"  : <int>,
   "successful_pipelines"        : <List<String>>,
   "failed_pipelines_count"      : <int>,
   "failed_pipelines"            : <List<Map<String, Object>>>
]
'''

There are a few config knobs which control some bulk save functionality. The gate endpoint invokes an orca asynchronous process to manage saving the pipelines and polls until the orca operations are complete.

'''
controller:
  pipeline:
    bulksave:
      # the max number of times gate will poll orca to check for task status
      max-polls-for-task-completion: <int>
      # the interval at which gate will poll orca.
      taskCompletionCheckIntervalMs: <int>
'''

#### Orca

Updates Orca’s SavePipelineTask to support bulk saves using the updated functionality in the front50 bulk save endpoint.

With https://github.com/spinnaker/orca/pull/4781, keys from the stage context’s outputs section can now be removed (there by reducing the context size significantly). At present the following tasks support this feature:

* PromoteManifestKatoOutputsTask
* WaitOnJobCompletionTask
* ResolveDeploySourceManifestTask
* BindProducedArtifactsTask


The PR https://github.com/spinnaker/orca/pull/4788 introduced a new CheckIfApplicationExists task that is added to various pipeline stages to check if the application defined in the pipeline stage context is known to front50 and/or clouddriver. The following config knobs are provided so that all of these stages can be individually configured to not perform this check if needed. Default value is set to false for all of them.

{{< highlight yaml "linenos=table,hl_lines=9-28" >}}
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      orca:
        tasks:
          clouddriver:
            promoteManifestKatoOutputsTask:
              excludeKeysFromOutputs:
              - outputs.createdArtifacts
              - outputs.manifests
              - outputs.boundArtifacts
            waitOnJobCompletionTask:
              excludeKeysFromOutputs:
              - jobStatus
              - completionDetails
            resolveDeploySourceManifestTask:
              excludeKeysFromOutputs:
              - manifests
              - requiredArtifacts
              - optionalArtifacts
          core:
            bindProducedArtifactsTask:
              excludeKeysFromOutputs:
              - artifacts
{{< /highlight >}}

Separate config knobs are also provided at the AbstractCheckIfApplicationExistsTask level to determine if clouddriver needs to be queried for the application or not. It is by default set to true, so it is an opt-out capability. the config property is:

'''
tasks:
  clouddriver:
    checkIfApplicationExistsTask:
      checkClouddriver: false   # default is true
'''

This feature runs in audit mode by default which means if checkIfApplicationExistsTask finds no application, a warning message is logged. But when audit mode is disabled through the following property, pipelines fail if application is not found:

'''
tasks:
    clouddriver:
      checkIfApplicationExistsTask:
        auditModeEnabled: false  # default is true
'''

#### Front50

Batch update operation in front50 is now atomic. Deserialization issues are addressed.
Configurable controls are added to decide whether cache should be refreshed while checking for duplicate pipelines:

{{< highlight yaml "linenos=table,hl_lines=9-12" >}}
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      front50:
        controller:
          pipeline:
            save:
              refreshCacheOnDuplicatesCheck: false // default is true 
{{< /highlight >}}

Batch update call now responds with a status of succeeded and failed pipelines info. The response will be a map containing information in the following format:

'''
[
    "successful_pipelines_count"  : <int>,
    "successful_pipelines"        : <List<String>>,
    "failed_pipelines_count"      : <int>,
    "failed_pipelines"            : <List<Map<String, Object>>> 
]
'''

Here the value for `successful_pipelines` is the list of successful pipeline names whereas the value for `failed_pipelines` is the list of failed pipelines expressed as maps.

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->




###  Spinnaker community contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.36.1](https://www.spinnaker.io/changelogs/1.36.1-changelog/) changelog for details.

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
    commit: e52a253da499f54ea951d46472ee20ada1326d1a
    version: 2.36.0-rc4
  deck:
    commit: da852d30ae5d29448b8546c3a55e799ef08bec8a
    version: 2.36.0-rc4
  dinghy:
    commit: 50041173d1a043493409059e7fa5d7a1a80fb553
    version: 2.36.0-rc4
  echo:
    commit: 4c2efbbb9e57b64a1a4fa85aef8eeccc8aaa80a7
    version: 2.36.0-rc4
  fiat:
    commit: bd424d60f055e6694aeaf74af5b92862932b09c3
    version: 2.36.0-rc4
  front50:
    commit: 9e2606c2d386d00b18b76104564b6467ea2010d3
    version: 2.36.0-rc4
  gate:
    commit: c866fd92e6ae109fc31f0f75b456a205c722e2cf
    version: 2.36.0-rc4
  igor:
    commit: c5540e0bfe83bb87fa8896c7c7924113c17453b4
    version: 2.36.0-rc4
  kayenta:
    commit: 1dab7bb6f4156bdf7f15ef74722139e07ceb4581
    version: 2.36.0-rc4
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 9fa8bf04e3b5882c0b03d0309684ef0cd00a64c0
    version: 2.36.0-rc4
  rosco:
    commit: 80f1885bcd93da023fdb858d563cc24ccadce276
    version: 2.36.0-rc4
  terraformer:
    commit: 9756bee07eaabbb25b54812996314c22554ec1c0
    version: 2.36.0-rc4
timestamp: "2025-02-05 12:35:00"
version: 2.36.0-rc4
</code>
</pre>
</details>

### Armory


#### Armory Fiat - 2.36.0-rc3...2.36.0-rc4


#### Armory Front50 - 2.36.0-rc3...2.36.0-rc4


#### Armory Deck - 2.36.0-rc3...2.36.0-rc4


#### Armory Gate - 2.36.0-rc3...2.36.0-rc4


#### Armory Orca - 2.36.0-rc3...2.36.0-rc4

  - feat(cherry-picks): adding selected improvements to 1.36.x release (#983)

#### Armory Igor - 2.36.0-rc3...2.36.0-rc4


#### Armory Rosco - 2.36.0-rc3...2.36.0-rc4


#### Terraformer™ - 2.36.0-rc3...2.36.0-rc4


#### Dinghy™ - 2.36.0-rc3...2.36.0-rc4


#### Armory Clouddriver - 2.36.0-rc3...2.36.0-rc4


#### Armory Echo - 2.36.0-rc3...2.36.0-rc4


#### Armory Kayenta - 2.36.0-rc3...2.36.0-rc4



### Spinnaker


#### Spinnaker Fiat - 1.36.1


#### Spinnaker Front50 - 1.36.1


#### Spinnaker Deck - 1.36.1


#### Spinnaker Gate - 1.36.1


#### Spinnaker Orca - 1.36.1


#### Spinnaker Igor - 1.36.1


#### Spinnaker Rosco - 1.36.1


#### Spinnaker Clouddriver - 1.36.1


#### Spinnaker Echo - 1.36.1


#### Spinnaker Kayenta - 1.36.1


