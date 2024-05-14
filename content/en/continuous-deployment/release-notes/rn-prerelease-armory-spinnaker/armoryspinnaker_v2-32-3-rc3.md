---
title: v2.32.3-rc3 Armory Continuous Deployment Release (Spinnaker™ v1.32.4)
toc_hide: true
date: 2024-05-14
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
description: >
  Release notes for Armory Continuous Deployment v2.32.3-rc3. A beta release is not meant for installation in production environments.

---

## 2024/05/14 release notes

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

To install, upgrade, or configure Armory CD 2.32.3-rc3, use Armory Operator 1.8.6 or later.

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

### AWS Lambda plugin migrated to OSS
Starting from Armory version 2.32.0 (OSS version 1.32.0), the AWS Lambda plugin has been migrated to OSS codebase.
If you are using the AWS Lambda plugin, you will need to disable/remove it when upgrading to Armory version 2.32.0+ to
avoid compatibility issues.

Additionally, the AWS Lambda stages are now enabled using the Deck feature flag `feature.lambdaAdditionalStages = true;`
as shown in the configuration block below.
{{< highlight yaml "linenos=table,hl_lines=12" >}}
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      deck:
        settings-local.js: |
          ...
          window.spinnakerSettings.feature.functions = true;
          // Enable the AWS Lambda pipeline stages in Deck using the feature flag
          window.spinnakerSettings.feature.lambdaAdditionalStages = true; 
          ...
      clouddriver:
        aws:
          enabled: true
          features:
            lambda:
              enabled: true
      ## Remove the AWS Lambda plugin from the Armory CD configuration.
      #gate:
      #  spinnaker:
      #    extensibility:
      #      deck-proxy:
      #        enabled: true
      #        plugins:
      #          Aws.LambdaDeploymentPlugin:
      #            enabled: true
      #            version: <version>
      #      repositories:
      #        awsLambdaDeploymentPluginRepo:
      #          url: https://raw.githubusercontent.com/spinnaker-plugins/aws-lambda-deployment-plugin-spinnaker/master/plugins.json  
      #orca:
      #  spinnaker:
      #    extensibility:
      #      plugins:
      #        Aws.LambdaDeploymentPlugin:
      #          enabled: true
      #          version: <version>
      #          extensions:
      #            Aws.LambdaDeploymentStage:
      #              enabled: true
      #      repositories:
      #        awsLambdaDeploymentPluginRepo:
      #          id: awsLambdaDeploymentPluginRepo
      #          url: https://raw.githubusercontent.com/spinnaker-plugins/aws-lambda-deployment-plugin-spinnaker/master/plugins.json
{{< /highlight >}}


Related OSS PRs:
- https://github.com/spinnaker/orca/pull/4449
- https://github.com/spinnaker/deck/pull/9988



## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->

### Terraformer support for AWS S3 Artifact Store
OSS Spinnaker 1.32.0 introduced support for [artifact storage](https://spinnaker.io/changelogs/1.32.0-changelog/#artifact-store) 
with AWS S3. This feature compresses `embdedded/base64` artifacts to `remote/base64` and uploads them to an AWS S3 bucket significantly 
reducing the artifact size in the execution context. 

Armory version 2.32.0 adds support for the same feature for the Terraform Integration stage.

>Note: The artifact-store feature is disabled by default. To enable the artifact-store feature the following configuration is required:
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

When enabling the artifact-store feature it is recommended to deploy the services in this order:
1. Clouddriver service
2. Terraformer service
3. Orca service
4. Rosco service

### Enable Jenkins job triggers for jobs located sub-folders
When defining a Jenkins job in a sub-folder, the path contains forward slashes. By enabling this feature, Armory CD will be
able to trigger Jenkins jobs located in sub-folders, correctly matching the job path.
```yaml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      echo:
        feature:
          igor:
            jobNameAsQueryParameter: true
      orca:
        feature:
          igor:
            jobNameAsQueryParameter: true
      igor:
        feature:
          igor:
            jobNameAsQueryParameter: true
```

### Pipeline As Code: Bitbucket fallback support for default branch
By default, Dinghy uses the `master` branch in your repository and fallbacks to `main` if `master` doesn’t exist.
If you wish to use a different branch in your repository, you can configure that using the `repoConfig` tag in your YAML configuration.
```yaml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      dinghy:
        repoConfig:
        - branch: some_branch
          provider: bitbucket-server
          repo: my-bitbucket-repository
```

### Performance improvements for the search executions API operations
The search executions API operations have been optimized to improve performance and reduce the time taken to search for pipelines by triggerType or eventId.

### RunJob stage improvement
RunJob stage now persist any External Log links after the deletion of the pods. This enhancement ensures that the External Log links are available even after the pods are deleted.




###  Spinnaker community contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.32.4](https://www.spinnaker.io/changelogs/1.32.4-changelog/) changelog for details.

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
    commit: 7d9e31043c8baa81afb59a2a30aee2235b7e90ab
    version: 2.32.3-rc3
  deck:
    commit: 19096fa607fabd0fd8865b18739eab577b4b7a9b
    version: 2.32.3-rc3
  dinghy:
    commit: f5b14ffba75721322ada662f2325e80ec86347de
    version: 2.32.3-rc3
  echo:
    commit: 9d2abeeea4341e5ba94654925ba6488a9038af3f
    version: 2.32.3-rc3
  fiat:
    commit: 5e1839ef81812c439fb37b411bd3b381131c8c40
    version: 2.32.3-rc3
  front50:
    commit: ba318cd2c445f14e5d6c3db87fa1658549385403
    version: 2.32.3-rc3
  gate:
    commit: c6654ca6e316eef474c59296120d3f9f34eb0bdf
    version: 2.32.3-rc3
  igor:
    commit: 9339ab63ab3d85ebcb00131033d19f26ad436f05
    version: 2.32.3-rc3
  kayenta:
    commit: bccd150fcc8a7cb7df537ec6269bce5d2843c703
    version: 2.32.3-rc3
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: ddbe104b0a3e32406c3bac38ea2b8c0c04605825
    version: 2.32.3-rc3
  rosco:
    commit: dfe611ffdd2cf9ae7c524fb9970af47350ca5e96
    version: 2.32.3-rc3
  terraformer:
    commit: 2dc7666ca2d25acb85ab2b9f8efc864599061c45
    version: 2.32.3-rc3
timestamp: "2024-05-13 20:39:58"
version: 2.32.3-rc3
</code>
</pre>
</details>

### Armory


#### Armory Kayenta - 2.32.3-rc2...2.32.3-rc3


#### Armory Echo - 2.32.3-rc2...2.32.3-rc3


#### Armory Orca - 2.32.3-rc2...2.32.3-rc3


#### Armory Fiat - 2.32.3-rc2...2.32.3-rc3


#### Armory Gate - 2.32.3-rc2...2.32.3-rc3


#### Terraformer™ - 2.32.3-rc2...2.32.3-rc3


#### Armory Clouddriver - 2.32.3-rc2...2.32.3-rc3


#### Armory Rosco - 2.32.3-rc2...2.32.3-rc3


#### Armory Deck - 2.32.3-rc2...2.32.3-rc3

  - chore(cd): update base deck version to 2024.0.0-20240510152918.release-1.32.x (#1412)
  - chore(cd): update base deck version to 2024.0.0-20240513181456.release-1.32.x (#1416)

#### Dinghy™ - 2.32.3-rc2...2.32.3-rc3


#### Armory Igor - 2.32.3-rc2...2.32.3-rc3


#### Armory Front50 - 2.32.3-rc2...2.32.3-rc3



### Spinnaker


#### Spinnaker Kayenta - 1.32.4


#### Spinnaker Echo - 1.32.4


#### Spinnaker Orca - 1.32.4


#### Spinnaker Fiat - 1.32.4


#### Spinnaker Gate - 1.32.4


#### Spinnaker Clouddriver - 1.32.4


#### Spinnaker Rosco - 1.32.4


#### Spinnaker Deck - 1.32.4

  - fix(pipeline): Handle render/validation when stageTimeoutMs is a Spel expression (#10103) (#10106)
  - fix(redblack): fixing redblack onchange values (#10107) (#10111)

#### Spinnaker Igor - 1.32.4


#### Spinnaker Front50 - 1.32.4


