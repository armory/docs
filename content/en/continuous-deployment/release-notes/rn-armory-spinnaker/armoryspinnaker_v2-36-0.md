---
title: v2.36.0 Armory Continuous Deployment Release (Spinnaker™ v1.36.1)
toc_hide: true
version: 2.36.0
date: 2025-02-12
description: >
  Release notes for Armory Continuous Deployment v2.36.0.
---

<!-- 
MAKE SURE TO ADD 'LTS' OR 'FEATURE' TO THE TITLE TO INDICATE RELEASE CATEGORY. 
FOR EXAMPLE, "Armory Continuous Deployment Release LTS" or "Armory Continuous Deployment Release Feature" so users know release category and support time period 
-->

## 2025/02/12 release notes

>Note: If you experience production issues after upgrading Armory Continuous Deployment, roll back to a previous working version and report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory CD 2.36.0, use Armory Operator 1.70 or later.

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

The following configuration properties have been restructured:

Previous Configuration:

'''
tasks:
  days-of-execution-history:  
  number-of-old-pipeline-executions-to-include:
'''

New configuration format

'''
tasks:
  controller:
    days-of-execution-history:
    number-of-old-pipeline-executions-to-include:
    optimize-execution-retrieval: <boolean>
    max-execution-retrieval-threads:
    max-number-of-pipeline-executions-to-process:
    execution-retrieval-timeout-seconds:
'''

These changes improve query performance and execution retrieval efficiency, particularly for large-scale pipeline applications.

[Performance Improvements for SQL Backend](#performance-improvements-for-sql-backend)

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

### Performance Improvements for Pipeline Executions

This release includes several optimizations to improve pipeline execution times, particularly for complex pipeline structures.

Key Improvements

1. Memorize the `anyUpstreamStagesFailed` extension function to improve time complexity from exponential to linear
2. Optimize `getAncestorsImpl` to reduce time complexity by a factor of N, where N is the number of stages in a pipeline
3. Optimize `StartStageHandler` to only call withAuth (which calls getAncestorsImpl) when

These enhancements significantly reduce pipeline execution time, with the most notable gains observed in dense pipeline graphs. For example, in the `ComplexPipeline.kt` test scenario, execution time improved from not completing at all to approximately `160ms`.

*[PR 4824](https://github.com/spinnaker/orca/pull/4824)*

### Performance Improvements for SQL Backend

This release enhances the performance of SQL-backed pipeline queries by optimizing database operations, particularly for the API call:

'''
/applications/{application}/pipelines?expand=false&limit=2
'''

which is frequently initiated by Deck and forwarded through Gate to Orca.

Key Improvements

- Improved Query Efficiency: Optimized the retrieval of pipeline execution data, significantly reducing database query times.
- Refactored `TaskController`: Externalized configuration properties to allow better flexibility and tuning.
- Enhanced `getPipelinesForApplication()`
  - Limits the number of pipeline config IDs queried.
  - Processes multiple pipeline config IDs simultaneously.
  - Introduces multi-threading to handle batches efficiently.

*[PR 4804](https://github.com/spinnaker/orca/pull/4804)*

### Feature: Read Connection Pool for SQL Execution Repository

This release introduces support for a dedicated read connection pool for specific read-only database queries in `SqlExecutionRepository`

Key Improvements

1. New "read" Connection Pool: Allows read operations to be routed to a separate connection pool.
2. Configurable Read Pool: Users can define an additional read connection pool in the SQL configuration.
3. Ensures Data Consistency: Some read queries still rely on recently written data and are not yet converted to use a read replica due to potential replication lag.

Configuration Example

To enable the read connection pool, add the following configuration:
'''
sql:
  connectionPools:
    default:
      <...>
    read:
      jdbcUrl: jdbc:...
      user: orca_service
      password:
      connectionTimeoutMs:
      validationTimeoutMs:
      maxPoolSize:
      minIdle:
      maxLifetimeMs:
      idleTimeoutMs:
'''

*[PR 4803](https://github.com/spinnaker/orca/pull/4803)*

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
    version: 2.36.0
  deck:
    commit: da852d30ae5d29448b8546c3a55e799ef08bec8a
    version: 2.36.0
  dinghy:
    commit: 50041173d1a043493409059e7fa5d7a1a80fb553
    version: 2.36.0
  echo:
    commit: 4c2efbbb9e57b64a1a4fa85aef8eeccc8aaa80a7
    version: 2.36.0
  fiat:
    commit: bd424d60f055e6694aeaf74af5b92862932b09c3
    version: 2.36.0
  front50:
    commit: 9e2606c2d386d00b18b76104564b6467ea2010d3
    version: 2.36.0
  gate:
    commit: cc3f1b3059533feb0bc770eebde4f2c0714c7800
    version: 2.36.0
  igor:
    commit: c5540e0bfe83bb87fa8896c7c7924113c17453b4
    version: 2.36.0
  kayenta:
    commit: 1dab7bb6f4156bdf7f15ef74722139e07ceb4581
    version: 2.36.0
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 9fa8bf04e3b5882c0b03d0309684ef0cd00a64c0
    version: 2.36.0
  rosco:
    commit: 80f1885bcd93da023fdb858d563cc24ccadce276
    version: 2.36.0
  terraformer:
    commit: 9756bee07eaabbb25b54812996314c22554ec1c0
    version: 2.36.0
timestamp: "2025-02-12 14:24:22"
version: 2.36.0
</code>
</pre>
</details>

### Armory


#### Armory Rosco - 2.35.0...2.36.0

  - fix(java): fix merge conflict (#697)
  - chore(java): Migrate to Java 17 (#695) (#696)
  - chore(cd): update base service version to rosco:2024.08.06.19.21.17.release-1.35.x (#694)
  - chore(cd): update armory-commons version to 3.17.3 (#689)
  - chore(cd): update base service version to rosco:2024.08.06.19.21.17.master (#683)
  - chore(base): bump latest rosco from 1.36.0 (#706)
  - fix(actions): use password secret for cd artifacts (#710)
  - fix(bake): use reflection to get values from AWSBakeHandler (#712)
  - chore(cd): update base service version to rosco:2024.11.25.15.38.22.release-1.36.x (#704)
  - chore(cd): update base service version to rosco:2025.01.07.21.12.49.release-1.36.x (#714)
  - chore(cd): update base service version to rosco:2025.01.23.05.53.10.release-1.36.x (#716)
  - chore(cd): update armory-commons version to 3.18.1 (#720)

#### Armory Fiat - 2.35.0...2.36.0

  - chore(cd): update base service version to fiat:2024.08.06.19.16.43.release-1.35.x (#635)
  - chore(cd): update armory-commons version to 3.17.3 (#630)
  - chore(cd): update base service version to fiat:2024.08.06.19.16.43.master (#624)
  - chore(base): bump latest fiat 1.36.0 and migrate jdk 17 (#642)
  - chore(cd): update base service version to fiat:2025.01.07.20.44.13.release-1.36.x (#647)

#### Terraformer™ - 2.35.0...2.36.0


#### Armory Kayenta - 2.35.0...2.36.0

  - chore(java): migrate to java 17 (#560) (#561)
  - chore(cd): update armory-commons version to 3.17.3 (#557)
  - chore(cd): update base service version to kayenta:2024.08.13.23.14.13.master (#551)
  - chore(base): bump latest kayenta from 1.36.0 (#569)
  - chore(cd): update base service version to kayenta:2025.01.22.19.32.21.release-1.36.x (#574)

#### Armory Clouddriver - 2.35.0...2.36.0

  - chore(cd): update base service version to clouddriver:2024.12.13.19.41.27.release-1.35.x (#1203)
  - chore(java): Migrate to java 17 (#1187) (#1188)
  - chore(java): compile base service with Java 17 (#1183) (#1186)
  - chore(cd): update base service version to clouddriver:2024.10.15.15.18.20.release-1.35.x (#1185)
  - chore(cd): update base service version to clouddriver:2024.08.27.16.52.09.release-1.35.x (#1182)
  - chore(cd): update armory-commons version to 3.17.3 (#1174)
  - chore(cd): update base service version to clouddriver:2024.08.27.16.04.19.master (#1170)
  - chore(cd): update base service version to clouddriver:2024.09.24.14.04.48.master (#1176)
  - chore(cd): update base service version to clouddriver:2024.09.25.16.01.39.master (#1178)
  - chore(base): bump latest clouddriver 1.36.0 (#1195)
  - chore(cd): update base service version to clouddriver:2024.12.12.19.01.29.release-1.36.x (#1200)
  - chore(cd): update base service version to clouddriver:2024.12.13.19.41.15.release-1.36.x (#1201)
  - chore(cd): update base service version to clouddriver:2025.01.03.19.54.54.release-1.36.x (#1206)
  - chore(cd): update base service version to clouddriver:2025.01.06.21.18.32.release-1.36.x (#1208)
  - chore(cd): update base service version to clouddriver:2025.01.06.22.20.00.release-1.36.x (#1210)
  - chore(cd): update base service version to clouddriver:2025.01.21.16.56.34.release-1.36.x (#1212)
  - chore(cd): update armory-commons version to 3.18.1 (#1215)
  - chore(base): bump latest jar from OS clouddriver in 1.36 (#1219)

#### Dinghy™ - 2.35.0...2.36.0


#### Armory Orca - 2.35.0...2.36.0

  - chore(cd): update base orca version to 2024.12.11.15.53.21.release-1.35.x (#967)
  - chore(java): migrate to java 17 (#949) (#951)
  - chore(dep): update base to 2024.08.13.08.26.10.release-1.35.x (#950)
  - chore(cd): update armory-commons version to 3.17.3 (#940)
  - chore(cd): update base orca version to 2024.08.28.15.02.07.master (#936)
  - chore(cd): update base orca version to 2024.09.25.16.57.42.master (#946)
  - chore(base): update base to latest orca 1.36.0 (#959)
  - chore(cd): update base orca version to 2024.12.11.15.53.17.release-1.36.x (#968)
  - chore(base): bump latest orca from 1.36.x (#972)
  - chore(cd): update base orca version to 2025.01.22.18.18.13.release-1.36.x (#976)
  - chore(cd): update armory-commons version to 3.18.1 (#981)
  - feat(cherry-picks): adding selected improvements to 1.36.x release (#983)

#### Armory Echo - 2.35.0...2.36.0

  - chore(java): migrate to jdk 17 (backport #750) (#751)
  - chore(cd): update armory-commons version to 3.17.3 (#743)
  - chore(cd): update base service version to echo:2024.08.13.08.15.00.master (#736)
  - chore(cd): update base service version to echo:2024.09.24.15.23.12.master (#744)
  - chore(cd): update base service version to echo:2024.09.25.15.02.35.master (#745)
  - chore(cd): update base service version to echo:2024.09.25.16.45.58.master (#746)
  - chore(cd): update base service version to echo:2024.09.26.20.47.13.master (#747)
  - chore(cd): update base service version to echo:2024.10.15.15.58.45.master (#748)
  - chore(java): upgrade to jre 17 (#749)
  - chore(java): migrate to jdk 17 (#750)
  - chore(cd): update base service version to echo:2024.11.05.16.26.31.master (#752)
  - chore(cd): update base service version to echo:2024.11.06.17.44.10.master (#753)
  - chore(base): update base to latest 1.36.0 and refactor (#758)
  - chore(java): remove java 11 references (#759)
  - chore(cd): update base service version to echo:2025.01.22.17.19.28.release-1.36.x (#765)
  - chore(cd): update base service version to echo:2025.01.22.18.37.26.release-1.36.x (#766)
  - chore(cd): update armory-commons version to 3.18.1 (#768)

#### Armory Front50 - 2.35.0...2.36.0

  - chore(cd): update base service version to front50:2024.08.23.16.11.34.release-1.35.x (#724)
  - chore(cd): update armory-commons version to 3.17.3 (#719)
  - chore(cd): update base service version to front50:2024.08.23.15.47.09.master (#714)
  - chore(cd): update base service version to front50:2024.09.23.18.38.12.master (#720)
  - chore(cd): update base service version to front50:2024.09.25.15.04.28.master (#721)
  - chore(cd): update base service version to front50:2024.09.25.16.44.47.master (#722)
  - chore(base): bump latest front50 from 1.36.0 (#735)
  - chore(cd): update base service version to front50:2025.01.07.21.06.13.release-1.36.x (#740)
  - chore(cd): update base service version to front50:2025.01.07.21.17.30.release-1.36.x (#741)
  - chore(cd): update base service version to front50:2025.01.22.18.05.44.release-1.36.x (#744)
  - chore(cd): update armory-commons version to 3.18.1 (#747)

#### Armory Igor - 2.35.0...2.36.0

  - chore(cd): update base service version to igor:2024.08.13.08.13.54.release-1.35.x (#634)
  - chore(cd): update armory-commons version to 3.17.3 (#628)
  - chore(cd): update base service version to igor:2024.08.13.08.13.54.master (#622)
  - chore(base): bump latest igor from 1.36.0 (#643)
  - chore(cd): update base service version to igor:2025.01.22.18.04.21.release-1.36.x (#652)
  - chore(cd): update armory-commons version to 3.18.1 (#655)

#### Armory Gate - 2.35.0...2.36.0

  - chore(base): bump base 1.35 and migrate to jdk17 (#766)
  - chore(cd): update armory-commons version to 3.17.3 (#755)
  - chore(cd): update base service version to gate:2024.08.23.19.46.38.master (#749)
  - chore(cd): update base service version to gate:2024.08.30.14.26.46.master (#751)
  - chore(cd): update base service version to gate:2024.09.11.14.27.15.master (#756)
  - chore(cd): update base service version to gate:2024.09.12.19.51.06.master (#757)
  - chore(cd): update base service version to gate:2024.09.12.23.00.50.master (#758)
  - chore(cd): update base service version to gate:2024.09.19.19.02.50.master (#759)
  - chore(base): bump latest gate from 1.36.0 (#776)
  - fix(okhttp): replace OkClient with Ok3Client to match OS gate (#783)
  - chore(cd): update base service version to gate:2025.01.22.18.05.19.release-1.36.x (#789)
  - chore(cd): update base service version to gate:2025.02.11.20.51.46.release-1.36.x (#793)

#### Armory Deck - 2.35.0...2.36.0

  - chore(cd): update base deck version to 2024.0.0-20240808170143.master (#1429)
  - chore(cd): update base deck version to 2024.0.0-20240911164312.master (#1430)
  - chore(cd): update base deck version to 2024.0.0-20240912172834.master (#1432)
  - chore(cd): update base deck version to 2024.0.0-20240912182910.master (#1433)
  - chore(base): bump latest deck from 1.36.0 (#1439)
  - chore(cd): update base deck version to 2025.0.0-20250121171131.release-1.36.x (#1446)
  - chore(base): bump latest deck in all spinnaker packages (#1449)


### Spinnaker


#### Spinnaker Rosco - 1.36.1

  - chore(dependencies): Autobump korkVersion (#1105)
  - chore(dependencies): Autobump korkVersion (#1108)
  - chore(dependencies): Autobump korkVersion (#1109)
  - chore(dependencies): Autobump korkVersion (#1110)
  - chore(dependencies): Autobump korkVersion (#1111)
  - chore(dependencies): Autobump korkVersion (#1112)
  - chore(dependencies): Autobump korkVersion (#1113)
  - fix(install): fix packer version check in post install script. (#1115)
  - chore(java): Full Java 17 support only (#1116)
  - chore(dependencies): Autobump korkVersion (#1117)
  - chore(dependencies): Autobump korkVersion (#1118)
  - chore(upgrades): Update OS to latest supported releases (#1119)
  - fix(gceBakeHandler): Updating Image name pattern to match googlecompute pre/post 1.1.2 plugin (#1122) (#1123)
  - fix(openapi): Rewrite Swagger to OpenAPI annotations (#1126) (#1129)
  - chore(dependencies): Autobump korkVersion (#1130)
  - fix(install): Fixed packer version check for packer installation (#1121) (#1128)

#### Spinnaker Fiat - 1.36.1

  - chore(dependencies): Autobump korkVersion (#1178)
  - chore(dependencies): Autobump korkVersion (#1179)
  - chore(dependencies): Autobump korkVersion (#1180)
  - chore(dependencies): Autobump korkVersion (#1181)
  - chore(dependencies): Autobump korkVersion (#1182)
  - chore(dependencies): Autobump korkVersion (#1184)
  - fix(retrofit): remove all com.squareup.okhttp dependencies (#1185)
  - chore(dependencies): Autobump korkVersion (#1187)
  - chore(java): Full Java 17 support only (#1186)
  - chore(dependencies): Autobump korkVersion (#1188)
  - chore(upgrades): Update OS to latest supported releases (#1189)
  - fix(openapi): Rewrite Swagger to OpenAPI annotations (#1192) (#1197)
  - chore(dependencies): Autobump korkVersion (#1198)

#### Spinnaker Kayenta - 1.36.1

  - chore(dependencies): Autobump orcaVersion (#1057)
  - chore(dependencies): Autobump orcaVersion (#1060)
  - refactor(dependency): add explicit dependency of google-http-client-jackson2 in kayenta-google while upgrading spockframework 2.3 (#1061)
  - chore(dependencies): Autobump orcaVersion (#1062)
  - refactor(retrofit): replace com.squareup.okhttp.OkHttpClient with okhttp3.OkHttpClient (#1063)
  - refactor(retrofit): remove all com.squareup.okhttp dependencies (#1064)
  - chore(java): Full Java 17 support only (#1065)
  - chore(java): remove duplicate targetJava17 property (#1066)
  - chore(upgrades): Update OS to latest supported releases (#1067)
  - chore(dependencies): Autobump orcaVersion (#1068)
  - chore(upgrade): Migrate to openapi swagger spec (#1046) (#1074)
  - chore(dependencies): Autobump orcaVersion (#1075)

#### Spinnaker Clouddriver - 1.36.1

  - feat(aws): CleanupAlarmsAgent with an optional user-defined name pattern (#6317) (#6318)
  - fix(cloudfoundry): Update ProcessStats model due to capi-1.84.0 changes (#6283) (#6293)
  - fix(aws): Fix AWS CLI v2 for Alpine Linux (#6279) (#6280)
  - fix(install): Fix Debian post installation script when awscli2 is already installed or the installation failed previously (#6276) (#6277)
  - fix(install): Fixed Debian post install script for aws-iam-authenticator (#6274) (#6275)
  - fix(gha): remove whitespace from BRANCH in release.yml (#6271) (#6273)
  - fix(gha): only bump halyard on master (#6268) (#6270)
  - fix(kubernetes): teach deployManifest stages to handle label selectors with generateName (#6265)
  - fix(gha): only bump halyard on master (#6268)
  - fix(gha): remove whitespace from BRANCH in release.yml (#6271)
  - fix(install): Fixed Debian post install script for aws-iam-authenticator (#6274)
  - fix(install): Fix Debian post installation script when awscli2 is already installed or the installation failed previously (#6276)
  - fix(install): Removed install_awscli2 function from Debian post install script (#6278)
  - fix(aws): Fix AWS CLI v2 for Alpine Linux (#6279)
  - fix(cloudfoundry): Update ProcessStats model due to capi-1.84.0 changes (#6283)
  - chore(dependencies): Autobump korkVersion (#6284)
  - chore(dependencies): Autobump fiatVersion (#6285)
  - perf(ecs): Narrowing the cache search for the ECS provider on views (#6256)
  - chore(dependencies): Autobump korkVersion (#6286)
  - feat(gce): support resource-manager-tags in GCE deployment (#6287)
  - chore(dependencies): Autobump korkVersion (#6289)
  - feat(gce): add support for hyperdisk in GCE (#6288)
  - chore(dependencies): Autobump korkVersion (#6295)
  - feat(gce): add partnerMetadata in instanceProperties for GCE deployment (#6297)
  - chore(azure): Adding a verifyAccountHealth configuration (#6296)
  - chore(dependencies): Autobump korkVersion (#6298)
  - refactor(retrofit): replace OkClient with Ok3Client (#6299)
  - refactor(retrofit): remove all com.squareup.okhttp dependencies (#6301)
  - chore(java): Full jaa 17 only
  - chore(java): Full java 17 only
  - chore(java): Remove cross compilation flag
  - chore(java): Full Java 17 support only
  - chore(dependencies): Autobump korkVersion (#6302)
  - chore(dependencies): Autobump korkVersion (#6303)
  - chore(upgrades): Update OS to latest supported releases (#6304)
  - chore(dependencies): Autobump fiatVersion (#6305)
  - fix(ecs): Cloudwatch alarms cleanup on destroy ecs group (#6315) (#6316)
  - feat(aws): CleanupAlarmsAgent with an optional user-defined name pattern (#6317) (#6319)
  - fix(ecs): Alarms with custom dimensions should be processed (#6324) (#6325)
  - fix(mergify): Mergify config needs adjusting for latest mergify releases (#6321) (#6326)
  - fix(openapi): Rewrite Swagger to OpenAPI annotations (#6309) (#6330)
  - chore(dependencies): Autobump korkVersion (#6331)
  - fix(google): Add partner metadata on instanceTemplate properties (#6334) (#6335)
  - chore(dependencies): Autobump fiatVersion (#6336)

#### Spinnaker Orca - 1.36.1


#### Spinnaker Echo - 1.36.1

  - refactor(test): fix test failure due to NullPointerException during upgrade of groovy 4.x (#1444)
  - chore(dependencies): Autobump korkVersion (#1443)
  - chore(dependencies): Autobump korkVersion (#1446)
  - chore(dependencies): Autobump fiatVersion (#1447)
  - chore(dependencies): Autobump korkVersion (#1448)
  - chore(dependencies): Autobump korkVersion (#1449)
  - chore(dependencies): Autobump korkVersion (#1450)
  - chore(dependencies): Autobump korkVersion (#1452)
  - refactor(retrofit): replace OkClient with Ok3Client (#1453)
  - feat(notifications/cdEvents): added support for customData at pipeline notification config level. (#1445)
  - fix(notifications/cdEvents): Fixed CDEvents notification for ManualJudgment (#1451)
  - fix(retrofit): remove all com.squareup.okhttp dependencies (#1454)
  - chore(dependencies): Autobump korkVersion (#1455)
  - chore(java): Full Java 17 support only (#1457)
  - chore(dependencies): Autobump korkVersion (#1456)
  - chore(upgrades): Update OS to latest supported releases (#1458)
  - chore(dependencies): Autobump fiatVersion (#1459)
  - chore(dependencies): Autobump korkVersion (#1467)
  - chore(dependencies): Autobump fiatVersion (#1469)

#### Spinnaker Front50 - 1.36.1

  - fix(gha): only bump halyard on master (#1490) (#1492)
  - chore(dependencies): Autobump fiatVersion (#1487)
  - feat(batchUpdate): enhance batch update functionality (#1483)
  - fix(gha): only bump halyard on master (#1490)
  - fix(front50-gcs): Fix ObjectType filenames for GCS Front50 persistent store (#1493)
  - chore(dependencies): Autobump korkVersion (#1499)
  - chore(dependencies): Autobump korkVersion (#1500)
  - chore(dependencies): Autobump fiatVersion (#1501)
  - chore(dependencies): Autobump korkVersion (#1502)
  - chore(dependencies): Autobump korkVersion (#1503)
  - chore(dependencies): Autobump korkVersion (#1505)
  - chore(dependencies): Autobump korkVersion (#1506)
  - feat(pipeline): add a pipelineNameFilter query param to the /pipelines/{application} endpoint (#1504)
  - chore(dependencies): Autobump korkVersion (#1508)
  - chore(java): Full Java 17 support only (#1507)
  - chore(dependencies): Autobump korkVersion (#1509)
  - chore(upgrades): Update OS to latest supported releases (#1510)
  - chore(dependencies): Autobump fiatVersion (#1511)
  - chore(build): create empty commit
  - fix(openapi): Rewrite Swagger to OpenAPI annotations (#1514) (#1521)
  - chore(dependencies): Autobump korkVersion (#1522)
  - chore(dependencies): Autobump fiatVersion (#1524)

#### Spinnaker Igor - 1.36.1

  - chore(dependencies): Autobump korkVersion (#1275)
  - chore(dependencies): Autobump korkVersion (#1276)
  - chore(dependencies): Autobump fiatVersion (#1277)
  - chore(dependencies): Autobump korkVersion (#1278)
  - chore(dependencies): Autobump korkVersion (#1279)
  - chore(dependencies): Autobump korkVersion (#1280)
  - chore(dependencies): Autobump korkVersion (#1281)
  - refactor(retrofit): replace OkClient with Ok3Client (#1282)
  - chore(build): target Java 17 bytecode (#1283)
  - chore(build): purge Java 11 (#1285)
  - refactor(retrofit): remove all com.squareup.okhttp dependencies (#1286)
  - chore(dependencies): Autobump korkVersion (#1287)
  - chore(dependencies): Autobump korkVersion (#1288)
  - chore(upgrades): Update OS to latest supported releases (#1289)
  - chore(dependencies): Autobump fiatVersion (#1290)
  - chore(dependencies): Autobump korkVersion (#1298)
  - chore(dependencies): Autobump fiatVersion (#1303)

#### Spinnaker Gate - 1.36.1

  - Pipeline config batch update (#1823)
  - feat(instrumentation): add instrumentation around echo event handling (#1824)
  - refactor(web/test): remove hard-coded port numbers from EchoServiceTest (#1828)
  - feat(web): add a config property that allows front50 to be the source of truth for applications (#1825)
  - feat(gate): copy the MDC to async controller method handler threads (#1829)
  - feat(web): populate the MDC when the ApplicationService gathers information from front50 and clouddriver (#1830)
  - chore(dependencies): Autobump korkVersion (#1832)
  - chore(dependencies): Autobump korkVersion (#1833)
  - chore(dependencies): Autobump fiatVersion (#1834)
  - fix(web): invoke pipeline config exception handling (#1831)
  - chore(dependencies): Autobump korkVersion (#1835)
  - perf(web): Query for individual pipelines (#1836)
  - chore(dependencies): Autobump korkVersion (#1837)
  - chore(dependencies): Autobump korkVersion (#1840)
  - chore(web): remove unused code from CleanupService (#1841)
  - fix(core): fix the issues caused due to the use of SpinnakerRetrofitErrorHandler in building FiatService (#1838)
  - chore(dependencies): Autobump korkVersion (#1843)
  - feat(pipelines): add pipelineNameFilter to /{application}/pipelineConfigs endpoint (#1839)
  - refactor(retrofit): replace OkClient with Ok3Client (#1844)
  - refactor(retrofit): remove all com.squareup.okhttp dependencies (#1845)
  - feat(gate-web): Add delete session tokens from redis endpoint (#1827)
  - chore(java): Upgrade fully to java 17 (#1846)
  - chore(dependencies): Autobump korkVersion (#1847)
  - chore(dependencies): Autobump korkVersion (#1848)
  - chore(upgrades): Update OS to latest supported releases (#1849)
  - chore(dependencies): Autobump fiatVersion (#1850)
  - fix(openapi): Uses openrewrite to convert swagger to openapi annotations (#1813) (#1859)
  - chore(dependencies): Autobump korkVersion (#1860)
  - chore(dependencies): Autobump fiatVersion (#1862)
  - fix(swagger): ensure byteArrayHttpMessageConverter is the first converter to render swagger UI (#1865) (#1867)

#### Spinnaker Deck - 1.36.1

  - fix(aws): Fix userData getting lost when cloning an AWS server group that uses launch templates (#6771) (#10132) (#10141)
  - chore(gcp): Adding STRONG_COOKIE_AFFINITY in gcp LB model (#10124)
  - fix(aws): Fix userData getting lost when cloning an AWS server group that uses launch templates (#6771) (#10132)
  - fix(aws): Fix IPv6 addresses being incorrectly associated when cloning server groups that have launch templates enabled (#6979) (#10142)
  - chore: Remove dead link from README (#10129)
  - feat(evaluateVariables stage) Made fetch exec history on evaluateVariables stage configurable (#10143)
  - feat(gce): support resourceManagerTags in instance template (#10146)
  - chore(deps): bump peter-evans/create-pull-request from 6 to 7 (#10147)
  - feat(gce): add support for hyperdisk in GCE (#10149)
  - feat(google): add support for partnerMetadata in GCE servergroup (#10150)
  - chore(deps): bump jpoehnelt/secrets-sync-action from 1.9.0 to 1.10.0 (#10148)
  - feat(deployManifest): Adding skipSpecTemplateLabels option (#10152)
  - fix(google): Add partner metadata on clone (#10161) (#10162)

