---
title: v2.36.1 Armory Continuous Deployment Release (Spinnaker™ v1.36.1)
toc_hide: true
version: 2.36.1
date: 2025-02-20
description: >
  Release notes for Armory Continuous Deployment v2.36.1.
---

<!-- 
MAKE SURE TO ADD 'LTS' OR 'FEATURE' TO THE TITLE TO INDICATE RELEASE CATEGORY. 
FOR EXAMPLE, "Armory Continuous Deployment Release LTS" or "Armory Continuous Deployment Release Feature" so users know release category and support time period 
-->

## 2025/02/20 release notes

>Note: If you experience production issues after upgrading Armory Continuous Deployment, roll back to a previous working version and report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory CD 2.36.1, use Armory Operator 1.8.6 or later.

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

The following configuration properties have been restructured:

Previous Configuration:

```yaml
tasks:
  days-of-execution-history:  
  number-of-old-pipeline-executions-to-include:
```

New configuration format

```yaml
tasks:
  controller:
    days-of-execution-history:
    number-of-old-pipeline-executions-to-include:
    optimize-execution-retrieval: <boolean>
    max-execution-retrieval-threads:
    max-number-of-pipeline-executions-to-process:
    execution-retrieval-timeout-seconds:
```

These changes improve query performance and execution retrieval efficiency, particularly for large-scale pipeline applications.

[Performance Improvements for SQL Backend](#performance-improvements-for-sql-backend)

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

### Echo Filter enabled pipelines feature
Spinnaker OSS Version 1.31.0 introduced a feature to filter pipelines from front50 , that was disabled by default.
Version 1.35.0 enabled it by default , which is not recommended and can cause issues with automated triggers.
In Armory CD 2.36.2 we recommend to explicitly disable this feature by setting the following configuration:

```
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      echo:
        pipelineCache:
          filterFront50Pipelines: false 
```

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

```
/applications/{application}/pipelines?expand=false&limit=2
```

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
```yaml
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
```

*[PR 4803](https://github.com/spinnaker/orca/pull/4803)*

### Enhanced pipeline batch update feature

#### Gate

Adds a new enpdoint, `POST /pipelines/bulksave`, which can take a list of pipeline configurations to save. The endpoint will return a response that indicates how many of the saves were successful, how many failed, and what the failures are. The structure is

```
[
   "successful_pipelines_count"  : <int>,
   "successful_pipelines"        : <List<String>>,
   "failed_pipelines_count"      : <int>,
   "failed_pipelines"            : <List<Map<String, Object>>>
]
```

There are a few config knobs which control some bulk save functionality. The gate endpoint invokes an orca asynchronous process to manage saving the pipelines and polls until the orca operations are complete.

```yaml
controller:
  pipeline:
    bulksave:
      # the max number of times gate will poll orca to check for task status
      max-polls-for-task-completion: <int>
      # the interval at which gate will poll orca.
      taskCompletionCheckIntervalMs: <int>
```

#### Orca

Updates Orca’s SavePipelineTask to support bulk saves using the updated functionality in the front50 bulk save endpoint.

With [Orca PR 4781](https://github.com/spinnaker/orca/pull/4781), keys from the stage context’s outputs section can now be removed (there by reducing the context size significantly). At present the following tasks support this feature:

* PromoteManifestKatoOutputsTask
* WaitOnJobCompletionTask
* ResolveDeploySourceManifestTask
* BindProducedArtifactsTask


The [Orca PR 4788](https://github.com/spinnaker/orca/pull/4788) introduced a new CheckIfApplicationExists task that is added to various pipeline stages to check if the application defined in the pipeline stage context is known to front50 and/or clouddriver. The following config knobs are provided so that all of these stages can be individually configured to not perform this check if needed. Default value is set to false for all of them.

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

```yaml
tasks:
  clouddriver:
    checkIfApplicationExistsTask:
      checkClouddriver: false   # default is true
```

This feature runs in audit mode by default which means if checkIfApplicationExistsTask finds no application, a warning message is logged. But when audit mode is disabled through the following property, pipelines fail if application is not found:

```yaml
tasks:
  clouddriver:
    checkIfApplicationExistsTask:
      auditModeEnabled: false  # default is true
```

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

```
[
  "successful_pipelines_count"  : <int>,
  "successful_pipelines"        : <List<String>>,
  "failed_pipelines_count"      : <int>,
  "failed_pipelines"            : <List<Map<String, Object>>>
]
```

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
    version: 2.36.1
  deck:
    commit: 1c97b782e123ee219673c245878aeb59e87b0a06
    version: 2.36.1
  dinghy:
    commit: 50041173d1a043493409059e7fa5d7a1a80fb553
    version: 2.36.1
  echo:
    commit: 4c2efbbb9e57b64a1a4fa85aef8eeccc8aaa80a7
    version: 2.36.1
  fiat:
    commit: bd424d60f055e6694aeaf74af5b92862932b09c3
    version: 2.36.1
  front50:
    commit: 9e2606c2d386d00b18b76104564b6467ea2010d3
    version: 2.36.1
  gate:
    commit: cc3f1b3059533feb0bc770eebde4f2c0714c7800
    version: 2.36.1
  igor:
    commit: c5540e0bfe83bb87fa8896c7c7924113c17453b4
    version: 2.36.1
  kayenta:
    commit: 1dab7bb6f4156bdf7f15ef74722139e07ceb4581
    version: 2.36.1
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 9fa8bf04e3b5882c0b03d0309684ef0cd00a64c0
    version: 2.36.1
  rosco:
    commit: 80f1885bcd93da023fdb858d563cc24ccadce276
    version: 2.36.1
  terraformer:
    commit: 9756bee07eaabbb25b54812996314c22554ec1c0
    version: 2.36.1
timestamp: "2025-02-20 12:49:12"
version: 2.36.1
</code>
</pre>
</details>

### Armory


#### Armory Igor - 2.36.0...2.36.1


#### Terraformer™ - 2.36.0...2.36.1


#### Armory Rosco - 2.36.0...2.36.1


#### Armory Gate - 2.36.0...2.36.1


#### Armory Echo - 2.36.0...2.36.1


#### Armory Deck - 2.36.0...2.36.1

  - fix(metadata): Reverting MetadataFilterOverride (#1450) (#1451)

#### Armory Orca - 2.36.0...2.36.1


#### Armory Kayenta - 2.36.0...2.36.1


#### Dinghy™ - 2.36.0...2.36.1


#### Armory Front50 - 2.36.0...2.36.1


#### Armory Clouddriver - 2.36.0...2.36.1


#### Armory Fiat - 2.36.0...2.36.1



### Spinnaker


#### Spinnaker Igor - 1.36.1


#### Spinnaker Rosco - 1.36.1


#### Spinnaker Gate - 1.36.1


#### Spinnaker Echo - 1.36.1


#### Spinnaker Deck - 1.36.1


#### Spinnaker Orca - 1.36.1


#### Spinnaker Kayenta - 1.36.1


#### Spinnaker Front50 - 1.36.1


#### Spinnaker Clouddriver - 1.36.1


#### Spinnaker Fiat - 1.36.1


