---
title: v2.38.0-rc2 Armory Continuous Deployment Release (Spinnaker™ v1.38.0)
toc_hide: true
date: 2025-10-16
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
description: >
  Release notes for Armory Continuous Deployment v2.38.0-rc2. A beta release is not meant for installation in production environments.

---

## 2025/10/16 release notes

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

To install, upgrade, or configure Armory CD 2.38.0-rc2, use Armory Operator 1.70 or later.

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

### Gate: Spring Security 5 Oauth2 Migration
Armory CD 2.38.0 removes deprecate Oauth2 annotations and uses Spring Security 5 DSL. In order to configure oauth2 in gate have changed to:

## Google Oauth configuration
```yaml
spring: 
  security:
    oauth2:
      client:
        registration:
          google:
            client-id: <client-id>
            client-secret: <client-secret>
            authorization-grant-type: authorization_code
            redirect-uri: "https://<your-domain>/login/oauth2/code/google"
            scope: profile,email,openid
            client-name: google
        provider:
          google:
            authorization-uri: https://accounts.google.com/o/oauth2/auth
            token-uri: https://oauth2.googleapis.com/token
            user-info-uri: https://www.googleapis.com/oauth2/v3/userinfo
            user-name-attribute: sub
```
## Github Oauth2 configuration
```yaml
spring:
  security:
    oauth2:
      client:
        registration:
          userInfoMapping:
            email: email
            firstName: ''
            lastName: name
            username: login
          github:
            client-id: <client-id>
            client-secret: <client-secret>
            authorization-grant-type: authorization_code
            redirect-uri: "https://<your-domain>/login/oauth2/code/github"
            scope: user,email
            client-name: github
        provider:
          github:
            authorization-uri: https://github.com/login/oauth/authorize
            token-uri: https://github.com/login/oauth/access_token
            user-info-uri: https://api.github.com/user
            user-name-attribute: login
```

### Orca: Tasks configuration changes
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

[Orca: Performance Improvements for SQL Backend](#orca-performance-improvements-for-sql-backend)

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->

### Security enhancement: Url Filtering/Restriction capabilities on Artifact accounts
Starting in Armory Continuous Deployment 2.36.5, we have enabled to capability to filter/restrict urls that can be accessed per artifact accounts.
This feature provides a safeguard around user input of remote urls when artifact accounts are in used in the context of a pipeline execution.

An example configuration for clouddriver-local.yml can be found below which can be added per artifact account (http, github, helm):
```yaml
artifacts:
  http:
    enabled: true
    accounts:
      - name: http_account
        urlRestrictions:
          allowedDomains:
          - mydomain.com
          - raw.github.com
          - api.github.com
          rejectLocalhost: true #default value
          rejectLinkLocal: true #default value
          rejectVerbatimIps: true #default value
          rejectedIps: [] #default value
```

By default the configuration blocks any local CIDR ranges (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16), localhost, link local and raw IPs.
For full configuration details please refer to this [configuration class](https://github.com/spinnaker/spinnaker/blob/main/clouddriver/clouddriver-artifacts/src/main/java/com/netflix/spinnaker/clouddriver/artifacts/config/HttpUrlRestrictions.java)

### Clouddriver: Account management API enhancement  for ECS and GCP accounts


### Clouddriver AWS accounts assume-role enhancement
Introduce in OSS Spinnaker 1.37.0 a configurable retry and backoff logic for AWS credentials parsing has been added.
Additionally a configurable per account (or default) sessionDurationSeconds property has been added. 
```yaml
aws:
  loadAccounts:
    maxRetries: 10
    backOffInMs: 5000
    exponentialBackoff: false
    exponentialBackoffMultiplier: 2
    exponentialBackOffIntervalMs: 10000
  defaultSessionDurationSeconds: (no default value)
```

[PR6342](https://github.com/spinnaker/clouddriver/pull/6342)
[PR6344](https://github.com/spinnaker/clouddriver/pull/6344)

### Orca: Webhook stage improvements and security features


```yaml
orca:
  webhooks:
    allowList: ["https://hooks.company.com"]
    maxRequestSizeBytes: 1048576
    maxResponseSizeBytes: 1048576
    followRedirects: false
    timeoutSeconds: 60
    audit:
      enabled: true

```

### Helm OCI Registry Chart Support
Docker registry provider now supports adding OCI-based registries hosting Helm repositories. This feature allows
users to download and bake Helm charts hosted in OCI-compliant registries (such as Docker Hub).

Related PRs:
- https://github.com/spinnaker/spinnaker/pull/7069
- https://github.com/spinnaker/spinnaker/pull/7089
- https://github.com/spinnaker/spinnaker/pull/7113

To enable the Helm OCI support in a Docker Registry account set a list of OCI repositories in the `helmOciRepositories`
of the Docker Registry account configuration. The `helmOciRepositories` is a list of repository names in the format `<registry>/<repository>`. For example:
```yaml
dockerRegistry:
  enabled: true
  primaryAccount: dockerhub   # Must be one of the configured docker accounts
  accounts:
    - name: dockerhub
      requiredGroupMembership: []
      providerVersion: V1
      permissions: {}
      address: https://index.docker.io  # (Required). The registry address you want to pull and deploy images from; e.g. https://index.docker.io
      username: <username>   # Your docker registry email (often this only needs to be well-formed, rather than be a real address)
      password: <password>
      cacheIntervalSeconds: 30          # (Default: 30). How many seconds elapse between polling your docker registry.
      clientTimeoutMillis: 60000        # (Default: 60000). Timeout time in milliseconds for this repository.
      cacheThreads: 1                   # (Default: 1). How many threads to cache all provided repos on. Really only useful if you have a ton of repos.
      paginateSize: 100                 # (Default: 100). Paginate size for the docker repository _catalog endpoint.
      sortTagsByDate: false             # (Default: false). Sort tags by creation date.
      trackDigests: false               # (Default: false). Track digest changes. This is not recommended as it consumes a high QPM, and most registries are flaky.
      insecureRegistry: false           # (Default: false). Treat the docker registry as insecure (don’t validate the ssl cert).
      repositories:
        - "registry/repository"         # (Default: []). An optional list of repositories to cache Docker images from. If not provided, Spinnaker will attempt to read accessible repositories from the registries _catalog endpoint
      helmOciRepositories:
        - "registry/HelmOciRepository" # (Default: []). An optional list of Helm OCI-Based repositories to cache helm charts from.
```

For every account with non-empty `helmOciRepositories` list, Clouddriver will cache the Helm charts from the specified OCI repositories.

The cached Helm OCI charts are defined as a new Artifact type named `helm/image` and can be used to bake Helm OCI-based charts in Spinnaker pipelines.

#### Defining retention policy for downloaded helm/image charts in Clouddriver
Optionally, users can define a retention policy for Helm OCI charts downloaded in a Clouddriver instance. This functionality
is disabled by default and it is useful for users that want to keep a local copy of a Helm OCI based chart without the need
to download it every time it is used in a pipeline. The retention policy is defined in the `clouddriver-local.yml` configuration file:
```
artifacts:
   helm-oci:
    clone-retention-minutes: 60
    clone-retention-max-bytes: 104857600 # 100MB
```

* `clone-retention-minutes:` Default: 0. How much time to keep the downloaded helm/image chart. Values are:
  * 0: no retention.
  * -1: retain forever.
  * any whole number of minutes, such as `60`.
* `clone-retention-max-bytes:` Default: 104857600 (100 MB). Maximum amount of disk space to use for downloaded helm/image charts. When the
  maximum amount of space is reached, Clouddriver deletes the clones after returning the artifact to the pipeline, just as if retention were disabled.

#### Defining Triggers for helm/image artifacts in Spinnaker pipelines
To trigger a Spinnaker pipeline on a new version of a Helm OCI-based chart, users will need to enable the Igor poller for the `helm/image` artifact type.
This can be done by adding the following configuration to the `igor-local.yml` file:
```
helm-oci-docker-registry:
  enabled: true
```

Additionally, a new trigger type (named `helm/oci`) has been implemented to allow pipelines to be triggered by new versions of `helm/image` artifacts.
```
  "triggers": [
    {
      "account": "<accountName>",
      "enabled": true,
      "organization": "<org>",
      "registry": "index.docker.io",
      "repository": "org/repositoryName",
      "type": "helm/oci"
    }
  ],
```


### Orca: Limit the execution retrieval of Disabled pipelines
A new configuration has been added to exclude execution retrieval for disabled pipelines in Front50. This can be enabled with:
```yaml
tasks:
   controller:
      excludeExecutionsOfDisabledPipelines: false|true  # Defaults to false
```
When enabled, Orca will call Front50 with the `enabledPipelines=true` query parameter, which returns only the
enabled pipelines for an application (Front50 [PR1520](https://github.com/spinnaker/front50/pull/1520)). This helps reduce
load for applications with numerous pipelines, especially when obsolete, disabled pipelines are retained for historical reasons.

*Orca [PR4819](https://github.com/spinnaker/orca/pull/4819)*
### Front50: Scheduled agent for Disabling unused pipelines
An agent has been introduced to detect and disable unused or unexecuted pipelines within an application.
This agent checks pipelines that have not been executed for the past `thresholdDays` days and disables them in Front50.
This feature is only available for SQL execution repositories and is configurable as bellow:
```yaml
pollers:
  unused-pipelines-disable:
    enabled: false | true  # default: false
    intervalSec: 3600  # default: 3600
    thresholdDays: 365  # default: 365
    dryRun: false | true  # default: true. When true an info is logged about the intention to disable a pipelineConfigId in the application evaluated
```
*Front50 [PR1520](https://github.com/spinnaker/front50/pull/1520)*

### Orca: New Pipeline stage configuration `backOffPeriodMs`
A new configuration option `backOffPeriodMs` has been added to the pipeline stage configuration. This option allows users
to specify a back-off period in milliseconds for stages that may need to retry operations after a failure. Before this,
pipeline authors had no control over the backoff period. It came from either spinnaker configuration properties or
implementations of RetryableTask.getDynamicBackoffPeriod.

Additionally, the following configuration options have been added that allow admins to specify globablly the backoff period:
{{< highlight yaml "linenos=table,hl_lines=9-11" >}}
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      orca:
        tasks.global.backOffPeriod:
        tasks.<cloud provider>.backOffPeriod:
        tasks.<cloud provider>.<account name>.backOffPeriod:
{{< /highlight >}}

*Orca [PR 4841](https://github.com/spinnaker/orca/pull/4841)*


### Orca: Performance Improvements for Pipeline Executions

This release includes several optimizations to improve pipeline execution times, particularly for complex pipeline structures.

Key Improvements

1. Memorize the `anyUpstreamStagesFailed` extension function to improve time complexity from exponential to linear
2. Optimize `getAncestorsImpl` to reduce time complexity by a factor of N, where N is the number of stages in a pipeline
3. Optimize `StartStageHandler` to only call withAuth (which calls getAncestorsImpl) when

These enhancements significantly reduce pipeline execution time, with the most notable gains observed in dense pipeline graphs. For example, in the `ComplexPipeline.kt` test scenario, execution time improved from not completing at all to approximately `160ms`.

*Orca [PR 4824](https://github.com/spinnaker/orca/pull/4824)*

### Orca: Performance Improvements for SQL Backend

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

*Orca [PR 4804](https://github.com/spinnaker/orca/pull/4804)*

### Orca: Read Connection Pool for SQL Execution Repository

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

*Orca [PR 4803](https://github.com/spinnaker/orca/pull/4803)*


### Migration of Retrofit1 to Retrofit2 for all services


###  Spinnaker community contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the following changelogs for details:
- [Spinnaker v1.37.0](https://spinnaker.io/changelogs/1.37.0-changelog/)
- [Spinnaker v1.38.0](https://spinnaker.io/changelogs/1.38.0-changelog/)
- [Spinnaker v1.38.0/2025.0.0](https://spinnaker.io/changelogs/1.38.0-changelog/)
- [Spinnaker 2025.1.0](https://spinnaker.io/changelogs/2025.1.0-changelog/)
- [Spinnaker 2025.2.0](https://spinnaker.io/changelogs/2025.2.0-changelog/)

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
    commit: 84dd609c94a99524dd30604d3cd10b24a08a9bfa
    version: 2.38.0-rc2
  deck:
    commit: 84dd609c94a99524dd30604d3cd10b24a08a9bfa
    version: 2.38.0-rc2
  dinghy:
    commit: babaa4704f1df8a6f6b42e533716396c8a0f529b
    version: 2.38.0-rc2
  echo:
    commit: 84dd609c94a99524dd30604d3cd10b24a08a9bfa
    version: 2.38.0-rc2
  fiat:
    commit: 84dd609c94a99524dd30604d3cd10b24a08a9bfa
    version: 2.38.0-rc2
  front50:
    commit: 84dd609c94a99524dd30604d3cd10b24a08a9bfa
    version: 2.38.0-rc2
  gate:
    commit: 84dd609c94a99524dd30604d3cd10b24a08a9bfa
    version: 2.38.0-rc2
  igor:
    commit: 84dd609c94a99524dd30604d3cd10b24a08a9bfa
    version: 2.38.0-rc2
  kayenta:
    commit: 84dd609c94a99524dd30604d3cd10b24a08a9bfa
    version: 2.38.0-rc2
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 84dd609c94a99524dd30604d3cd10b24a08a9bfa
    version: 2.38.0-rc2
  rosco:
    commit: 84dd609c94a99524dd30604d3cd10b24a08a9bfa
    version: 2.38.0-rc2
  terraformer:
    commit: babaa4704f1df8a6f6b42e533716396c8a0f529b
    version: 2.38.0-rc2
timestamp: "2025-10-16 11:21:28"
version: 2.38.0-rc2
</code>
</pre>
</details>

### Armory


#### Armory Kayenta - 2.38.0-rc1...2.38.0-rc2


#### Armory Dinghy - 2.38.0-rc1...2.38.0-rc2


#### Armory Orca - 2.38.0-rc1...2.38.0-rc2


#### Armory Echo - 2.38.0-rc1...2.38.0-rc2


#### Armory Igor - 2.38.0-rc1...2.38.0-rc2


#### Armory Rosco - 2.38.0-rc1...2.38.0-rc2


#### Armory Fiat - 2.38.0-rc1...2.38.0-rc2


#### Armory Front50 - 2.38.0-rc1...2.38.0-rc2


#### Armory Clouddriver - 2.38.0-rc1...2.38.0-rc2


#### Armory Deck - 2.38.0-rc1...2.38.0-rc2


#### Armory Gate - 2.38.0-rc1...2.38.0-rc2


#### Armory Terraformer - 2.38.0-rc1...2.38.0-rc2



### Spinnaker


#### Spinnaker Kayenta - 1.38.0


#### Spinnaker Dinghy - 1.38.0


#### Spinnaker Orca - 1.38.0


#### Spinnaker Echo - 1.38.0


#### Spinnaker Igor - 1.38.0


#### Spinnaker Rosco - 1.38.0


#### Spinnaker Fiat - 1.38.0


#### Spinnaker Front50 - 1.38.0


#### Spinnaker Clouddriver - 1.38.0


#### Spinnaker Deck - 1.38.0


#### Spinnaker Gate - 1.38.0


#### Spinnaker Terraformer - 1.38.0


