---
title: v2.38.2 Armory Continuous Deployment Release (Spinnaker™ v2025.3.2)
toc_hide: true
version: 2.38.2
date: 2026-06-23
description: >
  Release notes for Armory Continuous Deployment v2.38.2.
---

## 2026/06/23 release notes

>Note: If you experience production issues after upgrading Armory Continuous Deployment, roll back to a previous working version and report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version
{{% alert color="warning" title="Important" %}}
[Armory Operator]({{< ref "armory-operator" >}}) has been deprecated and will is considered EOL. Please migrate to the [Kustomize]({{< ref "armory-operator-to-kustomize-migration" >}}) method of deployment.
{{% /alert %}}

To install, upgrade, or configure Armory CD 2.38.2, use Armory Operator 1.8.6 or later.

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

### Gate: Spring Security 5 Oauth2 Migration
Armory CD 2.38.0 removes deprecate Oauth2 annotations and uses Spring Security 5 DSL. In order to configure oauth2 in `gate-local.yml` have changed to:

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
The following configuration properties have been restructured in `orca-local.yml`:

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

### Policy Engine (OPA) is now built into Armory CD

The Policy Engine is now built into the Armory CD distribution. The `Armory.PolicyEngine` plugin and the `armory.opa` configuration block are replaced by a native `armory.policy-engine` block. Remove the `Armory.PolicyEngine` plugin from `spinnaker.extensibility.plugins` in every service that had it configured and update the configuration block in `clouddriver-local.yml`, `front50-local.yml`, and any other service profile that references OPA:

Previous:
```yaml
armory:
  opa:
    enabled: true
    url: http://opa-server.opa:8181/v1
```

New:
```yaml
armory:
  policy-engine:
    enabled: true
    baseurl: http://opa-server.opa:8181/v1
```

The OPA server deployment and policies are unchanged.

### Kubernetes Agent (Kubesvc) is now built into Armory CD

The Scale Agent plugin (`Armory.Kubesvc`) is now built into the Armory CD Clouddriver image. The plugin, its repository, and the top-level `kubesvc:` configuration block must be replaced by the native `armory.kubesvc:` block in `clouddriver-local.yml`:

Previous:
```yaml
kubesvc:
  cluster: kubernetes

spinnaker:
  extensibility:
    plugins:
      Armory.Kubesvc:
        enabled: true
        version: 0.16.2
        extensions:
          armory.kubesvc:
            enabled: true
    repositories:
      armory-agent:
        url: https://raw.githubusercontent.com/armory-io/agent-k8s-spinplug-releases/master/repositories.json
```

New:
```yaml
armory:
  kubesvc:
    enabled: true
    cluster: kubernetes
```

All sub-properties (grpc, cache, heartbeat, operations, credentials) stay the same — only the parent key changes. Remove `Armory.Kubesvc` from `spinnaker.extensibility.plugins` and `armory-agent` from `spinnaker.extensibility.repositories`. The Armory Agent **service** deployed in target clusters is unchanged.

### Clouddriver: AWS SDK v2 upgrade
`S3ArtifactValidator`'s `validate` method signature has changed when `clouddriver-artifacts` was upgraded to AWS SDK v2. Any custom implementations of this interface need to be updated accordingly. Echo, Front50, and Igor were also upgraded to AWS SDK v2 in this release.

## Known issues

## Highlighted updates

### Security enhancement: gitrepo allowed hosts restriction

GitRepo artifact accounts now support an `allowedHosts` flag to restrict which hosts are accessible. This allows administrators to limit GitRepo calls to internal servers only. This can be configured per account in your `clouddriver-local.yml`:

```yaml
artifacts:
  gitrepo:
    enabled: true
    accounts:
      - name: gitrepo_account
        allowedHosts:
          - github.mycompany.com
          - gitlab.mycompany.com
```

### Clouddriver: Long-lived Lambda operations

Due to network constraints, most long-lived connections end after 5 minutes. AWS supports TCP keep-alive which, in combination with operating system configurations, allows requests to live longer. This release adds a new configuration option in your `clouddriver-local.yml`:

```yaml
aws:
  lambda:
    tcpKeepAlive: true
```

For operating system configuration and information, see [AWS Documentation](https://aws.amazon.com/blogs/networking-and-content-delivery/implementing-long-running-tcp-connections-within-vpc-networking/).

### Clouddriver: gRPC/HTTP2 support for GCP load balancers

You can now set up and configure gRPC/HTTP2 health check settings on GCP load balancers.

### Clouddriver: Account management API support for Azure

The Account management API now supports Azure accounts in addition to AWS, ECS, GCP, and Kubernetes. To enable dynamic Azure account loading, add the following to your `clouddriver-local.yml`:

```yaml
account:
  storage:
    enabled: true
  azure:
    enabled: true
credentials:
  poller:
    enabled: true
    types:
      azure:
        reloadFrequencyMs: 60000
```

### Gate: Execution query enhancements

This release adds a `pipelineNameFilter` query parameter when retrieving pipeline executions, allowing users to filter executions by pipeline name. A new `GET /executions/failedStages` endpoint is also available for querying failed stage information.

### Orca: Correct cancellation status

This release fixes an issue where cancelling a pipeline execution did not always set the correct terminal status.

### Orca/SQL: Retrieve newest pipeline executions

The SQL execution repository now retrieves the newest pipeline executions rather than relying on unpaged ordering, improving consistency for execution history queries.

### SQL: Compressed executions table

The SQL query layer now references only the compressed executions table, reducing query overhead for pipeline execution data.

### Fiat: Synchronized full role sync

Fiat full role synchronization is now synchronized across Fiat instances, preventing concurrent full-sync operations in HA deployments.

### Clouddriver: URL validation hardening

This release tightens URL validation handling on underscore and authority patterns for artifact accounts and webhook restrictions, matching the upstream security hardening.

### GCP: Accelerator pagination fix

This release fixes missing pagination tokens on GCP accelerator lookups.

### Clouddriver: kubectl download URL update

The kubectl download URL used by Clouddriver has been updated.

### Security enhancement: Url Filtering/Restriction capabilities on Artifact accounts
Starting in Armory Continuous Deployment 2.36.5, we have enabled to capability to filter/restrict urls that can be accessed per artifact accounts.
This feature provides a safeguard around user input of remote urls when artifact accounts are in used in the context of a pipeline execution.

An example configuration for `clouddriver-local.yml` can be found below which can be added per artifact account (http, github, helm):
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

### Clouddriver: Account management API enhancement  for AWS, ECS and GCP accounts
OSS Spinnaker 1.28 introduced the [account management API feature](https://spinnaker.io/docs/setup/other_config/accounts/) for loading, storing, updating, and otherwise managing Clouddriver account configurations from a database.
In Armory CD 2.38.x the Account management API has been enhanced to support AWS, ECS and GCP accounts. To enable this functionality please use the following configuration in your `clouddriver-local.yml`:

```yaml
account:
  storage:
    enabled: true
  aws:
    enabled: true
  ecs:
    enabled: true
  google:
    enabled: true
credentials: #Enable the credentials poller per provider congifuration enabled in the Account Managment API
  poller:
    enabled: true
    types:
      kubernetes:
        reloadFrequencyMs: 60000
      aws:
        reloadFrequencyMs: 60000
      ecs:
        reloadFrequencyMs: 60000
      google:
        reloadFrequencyMs: 60000
```

[Clouddriver PR7238](https://github.com/spinnaker/spinnaker/pull/7238)
[Clouddriver PR7247](https://github.com/spinnaker/spinnaker/pull/7247)
[Clouddriver PR7270](https://github.com/spinnaker/spinnaker/pull/7270)


### Clouddriver AWS accounts assume-role enhancement
Introduce in OSS Spinnaker 1.37.0 a configurable retry and backoff logic for AWS credentials parsing has been added.
Additionally a configurable per account (or default) sessionDurationSeconds property has been added in `clouddriver-local.yml`.
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

### Helm OCI Registry Chart Support
Docker registry provider now supports adding OCI-based registries hosting Helm repositories. This feature allows
users to download and bake Helm charts hosted in OCI-compliant registries (such as Docker Hub).

Related PRs:
- https://github.com/spinnaker/spinnaker/pull/7069
- https://github.com/spinnaker/spinnaker/pull/7089
- https://github.com/spinnaker/spinnaker/pull/7113

To enable the Helm OCI support in a Docker Registry account set a list of OCI repositories in the `helmOciRepositories`
of the Docker Registry account configuration. The `helmOciRepositories` is a list of repository names in the format `<registry>/<repository>`. For example in your `clouddriver-local.yml`:
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
A new configuration has been added to exclude execution retrieval for disabled pipelines in Front50. This can be enabled in your `orca-local.yml` with:
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
This feature is only available for SQL execution repositories and is configurable in your `front50-local.yml` as bellow:
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

Additionally, the following configuration options have been added that allow admins to specify globablly the backoff period in your `orca-local.yml`:
```
tasks.global.backOffPeriod:
tasks.<cloud provider>.backOffPeriod:
tasks.<cloud provider>.<account name>.backOffPeriod:
```

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

To enable the read connection pool, add the following configuration in your `orca-local.yml`:
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
Retrofit1 clients from the following spinnaker services have been upgraded to retrofit2. With this release, retrofit2 upgrade of all spinnaker services is completed.
Any internal plugins that rely on retrofit1 clients will need to be upgraded to retrofit2.

A new CallAdapter named LegacySignatureCallAdapter has been introduced in Kork to provide support for legacy Retrofit
method signatures. This adapter enables the use of Retrofit interfaces that do not return Call<..>, similar to how
Retrofit 1 worked. Both Kayenta and Halyard leveraged this feature during their Retrofit 2 upgrades, allowing them to
maintain their existing method signatures without wrapping them in Call<..> or using Retrofit2SyncCall.execute()

- https://github.com/spinnaker/spinnaker/pull/7088


###  Spinnaker community contributions

Armory CD 2.38.2 tracks the latest published upstream `2025.3.x` patch line.

Upstream references:
- [Spinnaker 2025.3.0](https://www.spinnaker.io/changelogs/2025.3.0-changelog/)
- [Spinnaker 2025.3.1](https://www.spinnaker.io/changelogs/2025.3.1-changelog/)
- [Spinnaker 2025.3.2](https://www.spinnaker.io/changelogs/2025.3.2-changelog/)

Notable upstream changes:
- Clouddriver: AWS SDK v2 upgrade for artifacts, Echo, Front50, and Igor.
- Clouddriver: Long-lived Lambda operations via TCP keep-alive.
- Clouddriver: gRPC/HTTP2 health check support for GCP load balancers.
- Clouddriver: Azure dynamic account loading via Account API.
- Gate: New `pipelineNameFilter` parameter and `GET /executions/failedStages` endpoint.
- Orca: Correct cancellation status and improved SQL execution retrieval.
- SQL: Compressed executions table reference.
- Fiat: Synchronized full role sync across instances.
- Security: gitrepo allowed hosts restriction and URL validation hardening.
- GCP: Accelerator pagination token fix.
- Clouddriver: Updated kubectl download URL.

## Detailed updates

### Bill Of Materials (BOM)

<details><summary>Expand to see the BOM</summary>
<pre class=\"highlight\">
<code>artifactSources:
  dockerRegistry: docker.io/armory
dependencies:
  redis:
    commit: null
    version: 2:2.8.4-2
services:
  clouddriver:
    commit: ec8a581ff19f5e5d65cdabc357fc0558b2b6efde
    version: 2.38.2
  deck:
    commit: ec8a581ff19f5e5d65cdabc357fc0558b2b6efde
    version: 2.38.2
  dinghy:
    commit: babaa4704f1df8a6f6b42e533716396c8a0f529b
    version: 2.38.2
  echo:
    commit: ec8a581ff19f5e5d65cdabc357fc0558b2b6efde
    version: 2.38.2
  fiat:
    commit: ec8a581ff19f5e5d65cdabc357fc0558b2b6efde
    version: 2.38.2
  front50:
    commit: ec8a581ff19f5e5d65cdabc357fc0558b2b6efde
    version: 2.38.2
  gate:
    commit: ec8a581ff19f5e5d65cdabc357fc0558b2b6efde
    version: 2.38.2
  igor:
    commit: ec8a581ff19f5e5d65cdabc357fc0558b2b6efde
    version: 2.38.2
  kayenta:
    commit: ec8a581ff19f5e5d65cdabc357fc0558b2b6efde
    version: 2.38.2
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: ec8a581ff19f5e5d65cdabc357fc0558b2b6efde
    version: 2.38.2
  rosco:
    commit: ec8a581ff19f5e5d65cdabc357fc0558b2b6efde
    version: 2.38.2
  terraformer:
    commit: babaa4704f1df8a6f6b42e533716396c8a0f529b
    version: 2.38.2
timestamp: \"2026-06-19 10:58:13\"
version: 2.38.2
</code>
</pre>
</details>

### Armory


#### Armory Gate - 2.38.1...2.38.2

- feat(gate): add a pipelineNameFilter query parameter when getting pipeline executions (upstream [#7315](https://github.com/spinnaker/spinnaker/pull/7315))
- feat(gate): add GET /executions/failedStages endpoint (upstream [#7300](https://github.com/spinnaker/spinnaker/pull/7300))
- perf(gate): increase performance of the GET /{application}/pipelineConfigs/{pipelineName:.+} endpoint (upstream [#7314](https://github.com/spinnaker/spinnaker/pull/7314))

#### Armory Igor - 2.38.1...2.38.2

- refactor(aws): upgrade igor to aws sdk v2 (upstream [#7283](https://github.com/spinnaker/spinnaker/pull/7283))

#### Armory Dinghy - 2.38.1...2.38.2


#### Armory Kayenta - 2.38.1...2.38.2


#### Armory Orca - 2.38.1...2.38.2

- fix(cancel): set the status correctly when cancelling a pipeline execution (upstream [#7296](https://github.com/spinnaker/spinnaker/pull/7296))
- fix(sql): Retrieve the newest pipeline executions (upstream [#7320](https://github.com/spinnaker/spinnaker/pull/7320))
- fix(sql): only reference the compressed executions table (upstream [#7327](https://github.com/spinnaker/spinnaker/pull/7327))
- refactor(sql): Simplify sql query in retrievePipelineExecutionDetailsForApplication (upstream [#7309](https://github.com/spinnaker/spinnaker/pull/7309))

#### Armory Rosco - 2.38.1...2.38.2


#### Armory Clouddriver - 2.38.1...2.38.2

- refactor(aws): upgrade clouddriver-artifacts module to aws sdk v2 (upstream [#7301](https://github.com/spinnaker/spinnaker/pull/7301))
- feat(lambda): Add configuration for tcpKeepAlive on the AWS Lambda client (upstream [#7308](https://github.com/spinnaker/spinnaker/pull/7308))
- feat(azure): Implement Azure dynamic account loading (upstream [#7269](https://github.com/spinnaker/spinnaker/pull/7269))
- feat(gcp): Add GRPC and HTTP/2 support for GCP load balancers (upstream [#7253](https://github.com/spinnaker/spinnaker/pull/7253))
- fix(gcp): Fix missing pagination token on accelerator lookups (upstream [#7435](https://github.com/spinnaker/spinnaker/pull/7435))
- fix(gitrepo): Fix git repo validation (upstream [#7544](https://github.com/spinnaker/spinnaker/pull/7544))
- fix(validation): Fixes some url validation handling on underscores (upstream [#7441](https://github.com/spinnaker/spinnaker/pull/7441))
- fix(kubectl): update kubectl download URL (upstream [#7474](https://github.com/spinnaker/spinnaker/pull/7474))

#### Armory Deck - 2.38.1...2.38.2


#### Armory Fiat - 2.38.1...2.38.2

- feat(roles): make fiat full role sync synchronized across fiat instances (upstream [#7115](https://github.com/spinnaker/spinnaker/pull/7115))

#### Armory Terraformer - 2.38.1...2.38.2


#### Armory Echo - 2.38.1...2.38.2

- refactor(aws): upgrade echo from aws sdk v1 to v2 (upstream [#7243](https://github.com/spinnaker/spinnaker/pull/7243))

#### Armory Front50 - 2.38.1...2.38.2

- refactor(aws): upgrade front50 to aws sdk v2 (upstream [#7250](https://github.com/spinnaker/spinnaker/pull/7250))
- fix(s3): always configure region in s3 client, when specified (upstream [#7268](https://github.com/spinnaker/spinnaker/pull/7268))


### Spinnaker


#### Spinnaker Gate - 2025.3.2


#### Spinnaker Igor - 2025.3.2


#### Spinnaker Dinghy - 2025.3.2


#### Spinnaker Kayenta - 2025.3.2


#### Spinnaker Orca - 2025.3.2


#### Spinnaker Rosco - 2025.3.2


#### Spinnaker Clouddriver - 2025.3.2


#### Spinnaker Deck - 2025.3.2


#### Spinnaker Fiat - 2025.3.2


#### Spinnaker Terraformer - 2025.3.2


#### Spinnaker Echo - 2025.3.2


#### Spinnaker Front50 - 2025.3.2

