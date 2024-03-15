---
title: v2.31.1-rc2 Armory Continuous Deployment Release (Spinnaker™ v1.31.3)
toc_hide: true
date: 2024-03-15
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
description: >
  Release notes for Armory Continuous Deployment v2.31.1-rc2. A beta release is not meant for installation in production environments.

---

## 2024/03/15 release notes

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

To install, upgrade, or configure Armory CD 2.31.1-rc2, use Armory Operator 1.70 or later.

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

### Clouddriver and Spring Cloud

The Spring Boot version has been upgraded, introducing a backwards incompatible change to the way configuration is loaded in Spinnaker. Users will need to set the ***spring.cloud.config.enabled*** property to ***true*** in the service settings of Clouddriver to preserve existing behavior. All of the other configuration blocks remain the same.

**Affected versions**: Armory CD 2.30.0 and later

## Deprecations

Reference [Feature Deprecations and end of support]({{< ref "continuous-deployment/feature-status/deprecations/" >}})

## Early access features enabled by default

### **New**: doNotEval SPeL expression

- This feature introduces a new SpEL `doNotEval` method that includes the received JSON object with the `NotEvaluableExpression` class.
- The `toJson` method (and others in the future) do not evaluate expressions and do not throw exceptions for instances of the `NotEvaluableExpression` class.
- See the Spinnaker doc's [doNotEval SPeL expression changelog note](https://spinnaker.io/changelogs/1.30.0-changelog/#donoteval-spel-helper) for more details regarding this feature flag.

### Automatically cancel Jenkins jobs

You now have the ability to cancel triggered Jenkins jobs when a pipeline is canceled, giving you more control over your full Jenkins workflow. Learn more this [Spinnaker changelog](https://spinnaker.io/changelogs/1.29.0-changelog/#orca).

### Enhanced BitBucket Server pull request handling

Trigger pipelines natively when pull requests are opened in BitBucket with newly added events including PR opened, deleted, and declined. See [Triggering pipelines with Bitbucket Server](https://spinnaker.io/docs/guides/user/pipeline/triggers/bitbucket-events/) in the Spinnaker docs for details

## Early access features enabled manually

### **New**: Pipeline Triggers: only cache enabled pipelines with enabled triggers of specific types

Enabling this flag may allow Echo to better utilize its cache, improving overall pipeline trigger performance for frequently used pipelines. See the [pull request](https://github.com/spinnaker/echo/pull/1292) for more information regarding this feature flag.

### **New**: Option to disable healthcheck for Google provider

Added the option to disable the healthcheck for Google provider similar to AWS and Kubernetes.

### Helm parameters

Spinnaker users baking Helm charts can now use SpEL expression parameters for **API Version** and **Kubernetes Version** in the Bake Manifest stage so that they can conditionally deploy different versions of artifacts depending on the target cluster API and Kubernetes versions. To learn more about this exciting new feature, see [Helm Parameters](https://spinnaker.io/docs/guides/user/kubernetes-v2/deploy-helm/#configure-api-versions-and-a-kubernetes-version) in the Spinnaker docs.

### Dynamic rollback timeout

To make the dynamic timeout available, you need to enable the feature flag in Orca and Deck. Add this block to  your `orca.yml` file if you want to enable the dynamic rollback timeout feature:

```yaml
rollback:
  timeout:
    enabled: true
```

In Orca, the feature flag overrides the default value rollback timeout - 5 min - with a UI input from the user.

In Deck, the feature flag enhances the Rollback Cluster stage UI with timeout input.

`window.spinnakerSettings.feature.dynamicRollbackTimeout = true;`

The default is used if there is no value set in the UI.

### Run Pipelines-as-Code with permissions scoped to a specific service account

Enhancing Pipelines-as-Code to upsert a pipeline using an Orca call instead of a Front50 call, to mimic the calls from Deck. By default, it is disabled. To enable, set the following in `dinghy.yml`:

```upsertPipelineUsingOrcaTaskEnabled: true```

### Pipelines-as-Code PR checks

This feature, when enabled, verifies if the author of a commit that changed app parameters has sufficient WRITE permission for that app. You can specify a list of authors whose permissions are not valid. This option’s purpose is to skip permissions checks for bots and tools.

See [Permissions check for a commit]({{< ref "plugins/pipelines-as-code/install/configure#permissions-check-for-a-commit" >}}) for details.

### Pipelines-as-Code multi-branch enhancement

Now you can configure Pipeline-as-Code to pull Pipelines-as-Code files from multiple branches on the same repo. Cut out the tedious task of managing multiple repos. Use a single repo for application pipelines. See [Multiple branches]({{<  ref "plugins/pipelines-as-code/install/configure#multiple-branches" >}}) for how to enable and configure this feature.

### Terraform template fix

Armory fixed an issue with SpEL expression failures appearing while using Terraformer to serialize data from a Terraform Plan execution. With this feature flag fix enabled, you are able to use the Terraform template file provider. Open a support ticket if you need this fix.

## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->

### Spring Boot

As part of the modernization effort, Spring Boot has been updated to 2.5. Note that there is no expected change for end users due to this change. Plugin developers may need to update their projects to work with 2.31.0+.

### Clouddriver

- Changed the validation Clouddriver runs before performing operations for the Kubernetes provider. The *kinds* and *omitKinds* fields on a Kubernetes account definition no longer restrict what Kubernetes kinds can be deployed by Clouddriver; instead, these fields now only control what kinds Clouddriver caches. Armory CD operators should ensure that Kubernetes RBAC controls are used to restrict what kinds Armory CD can deploy.
- Bumped aws-cli to 1.22 to enable FIPS compliance configuration options.
  
### Deck

- Added Cloud Run manifest functionality in Deck.
- Made the *StageFailureMessage* component overridable, which enables the ability to override the red error box in the component of a plugin.
- Added the ability to allow plugins to provide custom icon components.
  - Enables plugins to use the Icon component with a custom icon.  Currently the Icon component is limited to only icons defined in *iconsByName.*
- For the Helm bake feature, added additional input fields where the user can fill in details of the API's versions. These input fields are not be pre-populated with versions of the target cluster available in the environment.  They become part of the bake result. Added *API_VERSIONS_ENABLED* env variable flag.

### Echo

- Added a new configuration flag: *pipelineCache.filterFront50Pipelines* that defaults to false. When false, Echo caches all pipelines Front50. When true, it only caches enabled pipelines with enabled triggers of specific types. – The types that Echo knows how to trigger, along with some changes to the logic for handling manual executions so they continue to function. This is typically a very small subset of all pipelines.

### Fiat

- Added the ability to register *SpinnakerRetrofitErrorHandler* with each Retrofit.RestAdapter and replaces each RetrofitError catch block with a catch-block using SpinnakerServerException or the appropriate subclass. This change does not alter any of this service's behavior, it merely allows error messages to surface even when the error was thrown in a microservice more than one network call from the service in which the request originated. This is part of an effort to consume *SpinnakerRetrofitErrorHandler* in each Spinnaker microservice, as detailed in [this Github issue](https://github.com/spinnaker/spinnaker/issues/5473).

### Front50

- Added optional query params to the GET /pipelines endpoint.
- Return all pipelines triggered when the given pipeline configuration ID completes with the given status. Initially used in this [PR](https://github.com/spinnaker/orca/pull/4448).
- Added three new config flags to each object type under service-storage.
   - Two of the three are performance improvements which you can read about in the Spinnaker 1.31.0 [changelog](https://spinnaker.io/changelogs/1.31.0-changelog/#front50)

### Kayenta

- Added a storage service migrator.
   - Added the ability to migrate account credentials and account configurations data from S3/GCS to MySQL/PostgreSQL and vice versa
   - See the [PR comment](https://github.com/spinnaker/kayenta/pull/940#issue-1639273840) for instructions on how to use these properties (in kayenta-local.yml) to enable the data migration and MySQL or PostgreSQL data source.
 
### Orca

- Added a new configuration flag: *front50.useTriggeredByEndpoint* that defaults to false. When false, Orca queries Front50 for all pipelines each time a pipeline execution completes. When true, Orca only queries for pipelines triggered when a specific pipeline completes which is potentially a very small subset of all pipelines.

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

###  Spinnaker community contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.31.3](https://www.spinnaker.io/changelogs/1.31.3-changelog/) changelog for details.

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
    commit: cb7a25cc5d610afc67346cf25af98082566e38f6
    version: 2.31.1-rc2
  deck:
    commit: 1dd95e4ef5ed631f24253bf917200c3cf52655af
    version: 2.31.1-rc2
  dinghy:
    commit: 1bbb649f71d128d167229d72a1c94aa480f99684
    version: 2.31.1-rc2
  echo:
    commit: abefa81c6eac597a0db45e33ebaebd464cfdc5df
    version: 2.31.1-rc2
  fiat:
    commit: f1079f69f0184aae517680c48283cf9a52c9cf26
    version: 2.31.1-rc2
  front50:
    commit: 13814c48944265261af52c3929a4b96fc6c45add
    version: 2.31.1-rc2
  gate:
    commit: abfb0120ca617cb5806c7f2082ab4f8e9d7190b2
    version: 2.31.1-rc2
  igor:
    commit: a66db7a9037a4ddec4e131ec0b0bb137956a9395
    version: 2.31.1-rc2
  kayenta:
    commit: 18b22f0e9ca778f354ec5ac8255d0014ba6339ff
    version: 2.31.1-rc2
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: e46aab32af0ec1031eb216fc3fa2cf00f957aea0
    version: 2.31.1-rc2
  rosco:
    commit: 9812503db8271e32cd5d7960db12441fa8a39494
    version: 2.31.1-rc2
  terraformer:
    commit: 50082463ccd180cb4763078671a105ab70dee5e6
    version: 2.31.1-rc2
timestamp: "2024-03-14 18:17:56"
version: 2.31.1-rc2
</code>
</pre>
</details>

### Armory


#### Armory Orca - 2.31.1-rc1...2.31.1-rc2

  - chore(cd): update armory-commons version to 3.14.4 (#832)
  - chore(cd): update armory-commons version to 3.14.5 (#835)
  - chore(cd): update base orca version to 2024.03.11.15.12.53.release-1.31.x (#843)
  - chore(cd): update base orca version to 2024.03.14.15.56.51.release-1.31.x (#848)
  - chore(cd): update base orca version to 2024.03.14.16.21.01.release-1.31.x (#849)

#### Terraformer™ - 2.31.1-rc1...2.31.1-rc2


#### Armory Fiat - 2.31.1-rc1...2.31.1-rc2


#### Armory Igor - 2.31.1-rc1...2.31.1-rc2

  - chore(cd): update armory-commons version to 3.14.4 (#578)
  - chore(cd): update armory-commons version to 3.14.5 (#580)
  - chore(cd): update base service version to igor:2024.03.14.15.50.26.release-1.31.x (#589)

#### Armory Deck - 2.31.1-rc1...2.31.1-rc2


#### Armory Echo - 2.31.1-rc1...2.31.1-rc2

  - chore(cd): update armory-commons version to 3.14.4 (#691)
  - chore(cd): update armory-commons version to 3.14.5 (#693)
  - chore(cd): update base service version to echo:2024.03.14.14.32.38.release-1.31.x (#701)
  - chore(cd): update base service version to echo:2024.03.14.16.01.06.release-1.31.x (#702)

#### Armory Rosco - 2.31.1-rc1...2.31.1-rc2

  - chore(cd): update armory-commons version to 3.14.4 (#645)
  - chore(cd): update armory-commons version to 3.14.5 (#646)

#### Armory Kayenta - 2.31.1-rc1...2.31.1-rc2

  - chore(cd): update armory-commons version to 3.14.4 (#521)
  - chore(cd): update armory-commons version to 3.14.5 (#522)

#### Armory Front50 - 2.31.1-rc1...2.31.1-rc2

  - chore(cd): update armory-commons version to 3.14.4 (#657)
  - chore(cd): update armory-commons version to 3.14.5 (#658)
  - Updating force dependency on com.google.cloud:google-cloud-storage:1.108.0 (#663) (#664)

#### Armory Clouddriver - 2.31.1-rc1...2.31.1-rc2

  - chore(cd): update armory-commons version to 3.14.4 (#1081)
  - chore(cd): update base service version to clouddriver:2024.02.27.14.37.01.release-1.31.x (#1082)
  - chore(cd): update armory-commons version to 3.14.5 (#1085)

#### Armory Gate - 2.31.1-rc1...2.31.1-rc2

  - chore(cd): update armory-commons version to 3.14.4 (#701)
  - chore(cd): update armory-commons version to 3.14.5 (#702)

#### Dinghy™ - 2.31.1-rc1...2.31.1-rc2

  - chore(dependencies): v0.0.0-20240213103436-d0dc889db2c6 (backport #529) (#531)


### Spinnaker


#### Spinnaker Orca - 1.31.3

  - feat(servergroup): Allow users to opt-out of the target desired size check when verifying if the instances scaled up or down successfully (#4649) (#4652)
  - feat(jenkins): Enable Jenkins job triggers for jobs in sub-folders (#4618) (#4633)
  - fix(jenkins): Enable properties and artifacts with job name as query parameter (#4661) (#4677)

#### Spinnaker Fiat - 1.31.3


#### Spinnaker Igor - 1.31.3

  - fix(jenkins): Enable properties and artifacts with job name as query parameter (#1230) (#1240)

#### Spinnaker Deck - 1.31.3


#### Spinnaker Echo - 1.31.3

  - feat(jenkins): Enable Jenkins job triggers for jobs in sub-folders (#1373) (#1380)
  - fix(jenkins): Enable properties and artifacts with job name as query parameter (#1393) (#1403)

#### Spinnaker Rosco - 1.31.3


#### Spinnaker Kayenta - 1.31.3


#### Spinnaker Front50 - 1.31.3


#### Spinnaker Clouddriver - 1.31.3

  - fix: Change the agent type name to not include the account name since this would generate LOTS of tables and cause problems long term (#6158) (#6164)

#### Spinnaker Gate - 1.31.3


