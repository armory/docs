---
title: v2.39.0 Armory Continuous Deployment Release Feature (Spinnaker™ v2026.1.1)
toc_hide: true
version: 2.39.0
date: 2026-07-07
description: >
  Release notes for Armory Continuous Deployment v2.39.0.
---

## 2026/07/07 release notes

>Note: If you experience production issues after upgrading Armory Continuous Deployment, roll back to a previous working version and report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version
{{% alert color="warning" title="Important" %}}
[Armory Operator]({{< ref "armory-operator" >}}) has been deprecated and will is considered EOL. Please migrate to the [Kustomize]({{< ref "armory-operator-to-kustomize-migration" >}}) method of deployment.
{{% /alert %}}

To install, upgrade, or configure Armory CD 2.39.0, use Armory Operator 1.8.6 or later.

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

If Clouddriver fails to start after this change with a `Table 'kubesvc_cache' already exists` migration error, see [Clouddriver fails to start with a Kubesvc migration error](#clouddriver-fails-to-start-with-a-kubesvc-migration-error) under Known issues.

### Spring Boot 3 upgrade

Armory CD 2.39.0 upgrades from Spring Boot 2.7 to Spring Boot 3.0. This has two immediate operational impacts:

**Actuator metrics export property changes**

The metrics export properties have moved:

| Old Property Prefix | New Property Prefix |
|---------------------|---------------------|
| `management.metrics.export.<product>` | `management.<product>.metrics.export` |

For example, Prometheus configuration keys change from:
```yaml
management.metrics.export.prometheus.*
```
to:
```yaml
management.prometheus.metrics.export.*
```

**Gate session data cleanup required**

Spring Boot 3.0 considers session data cached by Spring Boot 2.7 invalid. Users with cached sessions will be unable to log in until the invalid information is removed. Before upgrading, flush Gate's Redis session cache:

```bash
redis-cli keys "spring:session*" | xargs redis-cli del
```

Open browser windows to Spinnaker must be reloaded after the deployment.

### YAML parsing limits now configurable

Starting with SnakeYAML 1.33, strict safety limits are enforced by default (`maxAliasesForCollections = 50`, `codePointLimit = 3145728`). These can cause large or alias-heavy YAML files such as Kubernetes manifests to fail. Two new properties allow operators to override these limits:

```yaml
snakeyaml:
  max-aliases-for-collections: 500   # default: 50
  code-point-limit: 10485760         # default: 3145728
```

### Docker images moved to GHCR

Spinnaker and Armory CD images are no longer published to Google Artifact Registry (GAR). All images now pull from GitHub Container Registry (GHCR) at `ghcr.io/spinnaker/`. Update any allowlists, pull-through mirrors, or image references in your deployment configuration before upgrading.

### Halyard fully deprecated

Halyard is no longer supported and will not receive patches or updates. Migrate to [spinnaker-kustomize](https://github.com/spinnaker/spinnaker-kustomize-patches) or a similar implementation before upgrading to Armory CD 2.39.0.

## Known issues

{{< include "known-issues/ki-kubesvc-changelog-migration.md" >}}

## Highlighted updates

### Lambda: Naming flexibility and performance

Lambda has received significant improvements to naming flexibility and caching performance.

**Naming:** A new flag allows deploying Lambda functions without the default application-name prefix applied by Spinnaker. This can be set independently in Clouddriver and Orca:

```yaml
# clouddriver-local.yml
aws:
  lambda:
    prefixApplicationNameToFunction: false
```

```yaml
# orca-local.yml
lambda:
  prefixApplicationNameToFunction: false
```

**Performance:** Lambda APIs previously loaded all functions into memory then filtered by account or region. This has been corrected so only the relevant data is loaded. Additionally, Lambda function metadata is now cached in a dedicated application table using moniker tags, reducing load on the shared cache. To disable tag-based caching:

```yaml
# clouddriver-local.yml
aws:
  lambda:
    setMonikerTags: false
```

### Kubernetes secret engine support

Spinnaker can now store and resolve secrets from Kubernetes. Reference a Kubernetes secret in any Spinnaker configuration using the encrypted syntax:

```
encrypted:k8s!n:<secretName>!k:<secretKey>
```

To enable, add the following to your `spinnaker-local.yml`:

```yaml
spinnaker:
  secrets:
    kubernetes:
      enabled: true
```

This uses the local pod credentials. To reference a secret in a different namespace, append `!ns:<namespace>` to the reference. See [PR #7603](https://github.com/spinnaker/spinnaker/pull/7603) for full details.

### GCP: Certificate map support for load balancers

Clouddriver now supports caching and managing certificate maps on GCP HTTP(S) load balancers, enabling migration from legacy SSL certificate configurations to certificate maps.

### Fiat: Performance improvements

Two significant performance improvements have been made to Fiat role synchronization:

1. **Sync latching** — Cross-pod sync coordination is restored with a fixed locking mechanism, preventing concurrent full-sync storms in HA deployments.
2. **Parallel Redis operations** — Fiat now parallelizes Redis get and put operations during sync, significantly reducing sync time.

Recommended configuration for `fiat-local.yml`:

```yaml
fiat:
  write-mode:
    enabled: true
    synchronization-config:
      enabled: true
      prefix: "spinnaker:fiat"
    sync-delay-ms: 600000
    sync-failure-delay-ms: 600000
    sync-delay-timeout-ms: 30000
    retry-interval-ms: 10000
  redis:
    repository:
      sync-threads: 16   # default: number of available processors
```

And in `front50-local.yml` to avoid triggering full syncs on every service account save:

```yaml
fiat:
  disableRoleSyncWhenSavingServiceAccounts: true
```

In testing, this configuration has reduced sync time from hours to minutes.

### ECS: On-demand cache performance

ECS on-demand APIs now load account data via targeted cache calls instead of loading all data and filtering afterwards. This significantly reduces memory usage, database throughput, and overall impact on Spinnaker when a large number of accounts are deployed and ECS deployments are in progress.

### Admin API: Kill zombie executions

A new admin endpoint allows operators to cancel zombie pipeline executions directly via the API without needing to port-forward to Orca. The endpoint is available to users with the Admin role.

###  Spinnaker community contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker 2026.1.1](https://www.spinnaker.io/changelogs/2026.1.1-changelog/) changelog for details.

Notable upstream changes included in this release span OSS versions 2025.3.3 through 2026.1.1:
- Spring Boot 2.7 → 3.0 upgrade across all services
- Apache HttpClient 4.x → 5.x upgrade
- Spring Boot 3.0 → 3.1.12 security patch upgrade
- Gate: SAML wiring and allowedAccounts fixes; x509/SAML SecurityFilterChain conflict resolved
- Gate: IAP authentication fixed post Spring Boot 3 upgrade
- Gate: Void orca endpoints now return 200 instead of 500
- Echo: Microsoft Teams webhook URL doubling in Retrofit2 migration fixed
- Echo: GitHub status conversion exception fixed
- Clouddriver: Eureka Retrofit2 leading-slash API fix
- Fiat: GitHub App authentication support for team/group sync
- gitrepo: Special character combination URL handling fixed
- YAML: Safe constructor enforcement across multiple classes
- Deck: Execution selection preserved when editing form fields

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
    commit: 8f40c99bd0979c73db2c003b9dccc00dd960551b
    version: 2.39.0
  deck:
    commit: 8f40c99bd0979c73db2c003b9dccc00dd960551b
    version: 2.39.0
  dinghy:
    commit: babaa4704f1df8a6f6b42e533716396c8a0f529b
    version: 2.39.0
  echo:
    commit: 8f40c99bd0979c73db2c003b9dccc00dd960551b
    version: 2.39.0
  fiat:
    commit: 8f40c99bd0979c73db2c003b9dccc00dd960551b
    version: 2.39.0
  front50:
    commit: 8f40c99bd0979c73db2c003b9dccc00dd960551b
    version: 2.39.0
  gate:
    commit: 8f40c99bd0979c73db2c003b9dccc00dd960551b
    version: 2.39.0
  igor:
    commit: 8f40c99bd0979c73db2c003b9dccc00dd960551b
    version: 2.39.0
  kayenta:
    commit: 8f40c99bd0979c73db2c003b9dccc00dd960551b
    version: 2.39.0
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 8f40c99bd0979c73db2c003b9dccc00dd960551b
    version: 2.39.0
  rosco:
    commit: 8f40c99bd0979c73db2c003b9dccc00dd960551b
    version: 2.39.0
  terraformer:
    commit: babaa4704f1df8a6f6b42e533716396c8a0f529b
    version: 2.39.0
timestamp: "2026-06-19 19:27:18"
version: 2.39.0
</code>
</pre>
</details>

### Armory


#### Armory Clouddriver - 2.38.2...2.39.0

- fix(ecs): Fix ecs on demand perf loading issue ([#7667](https://github.com/spinnaker/spinnaker/pull/7667))
- fix(lambda): Lambda APIs when only account or region were still loading all data THEN filtering ([#7644](https://github.com/spinnaker/spinnaker/pull/7644))
- feat(lambda): Make application names work with Lambda ([#7655](https://github.com/spinnaker/spinnaker/pull/7655))
- feat(provider/google): Add certificateMap support for GCE HTTP(S) load balancers ([#7475](https://github.com/spinnaker/spinnaker/pull/7475))
- feat(clouddriver-artifacts): configurable artifact support at build time ([#7356](https://github.com/spinnaker/spinnaker/pull/7356))
- fix(clouddriver/eureka): remove leading slashes from all the retrofit2 api interfaces ([#7652](https://github.com/spinnaker/spinnaker/pull/7652))


#### Armory Dinghy - 2.38.2...2.39.0


#### Armory Rosco - 2.38.2...2.39.0


#### Armory Deck - 2.38.2...2.39.0

- fix(deck): Preserve execution selection when editing form fields ([#7439](https://github.com/spinnaker/spinnaker/pull/7439))


#### Armory Echo - 2.38.2...2.39.0

- fix(echo): Fix Microsoft Teams webhook URL doubling in Retrofit2 migration ([#7718](https://github.com/spinnaker/spinnaker/pull/7718))
- fix(echo): GitHub status conversion exception ([#7701](https://github.com/spinnaker/spinnaker/pull/7701))
- feat(echo): add OTLP/gRPC transport for CDEvents notifications ([#7554](https://github.com/spinnaker/spinnaker/pull/7554))
- feat(echo): add mTLS support for OTLP/gRPC CDEvents transport ([#7561](https://github.com/spinnaker/spinnaker/pull/7561))


#### Armory Fiat - 2.38.2...2.39.0

- chore(change): Adopt latching for fiat role sync ([#7647](https://github.com/spinnaker/spinnaker/pull/7647))
- chore(change): Improve parallelization of redis fiat get and put ([#7648](https://github.com/spinnaker/spinnaker/pull/7648))
- fix(fiat): make prefix permissions case-insensitive ([#7361](https://github.com/spinnaker/spinnaker/pull/7361))
- feat(change): Add GitHub App Authentication Support for Team Membership ([#7337](https://github.com/spinnaker/spinnaker/pull/7337))


#### Armory Front50 - 2.38.2...2.39.0


#### Armory Gate - 2.38.2...2.39.0

- fix(gate/web): return 200 instead of 500 for void orca endpoints ([#7574](https://github.com/spinnaker/spinnaker/pull/7574))
- fix(gate): rename x509 SecurityFilterChain bean to prevent SAML override when both are enabled ([#7539](https://github.com/spinnaker/spinnaker/pull/7539))
- fix(saml): Fix wiring issue on saml; add full end-to-end integration test using keycloak & htmlunitdriver ([#7525](https://github.com/spinnaker/spinnaker/pull/7525))
- fix(saml): Restore allowedAccounts ([#7453](https://github.com/spinnaker/spinnaker/pull/7453))
- fix(iap): Fix iap auth post spring 3.0 upgrade ([#7503](https://github.com/spinnaker/spinnaker/pull/7503))
- feat(admin): Admin controller for killing pipelines & is admin API check ([#7313](https://github.com/spinnaker/spinnaker/pull/7313))


#### Armory Terraformer - 2.38.2...2.39.0


#### Armory Igor - 2.38.2...2.39.0

- feat(igor): allow overriding artifact extensions in Artifactory monitors ([#7535](https://github.com/spinnaker/spinnaker/pull/7535))


#### Armory Kayenta - 2.38.2...2.39.0

- fix(kayenta): Send Authorization header proactively for Prometheus-compatible APIs ([#7464](https://github.com/spinnaker/spinnaker/pull/7464))


#### Armory Orca - 2.38.2...2.39.0


### Spinnaker


#### Spinnaker Clouddriver - 2026.1.1

- fix(ecs): Fix ecs on demand perf loading issue ([#7667](https://github.com/spinnaker/spinnaker/pull/7667))
- fix(lambda): Lambda APIs when only account or region were still loading all data THEN filtering ([#7644](https://github.com/spinnaker/spinnaker/pull/7644))
- feat(lambda): Make application names work with Lambda ([#7655](https://github.com/spinnaker/spinnaker/pull/7655))
- feat(provider/google, deck/google): Add certificateMap support for GCE HTTP(S) load balancers ([#7475](https://github.com/spinnaker/spinnaker/pull/7475))
- feat(clouddriver-artifacts): configurable artifact support at build time ([#7356](https://github.com/spinnaker/spinnaker/pull/7356))
- fix(clouddriver/eureka): remove leading slashes from all the retrofit2 api interfaces ([#7652](https://github.com/spinnaker/spinnaker/pull/7652))
- fix(cats-sql): make SqlUnknownAgentCleanupAgent sharding-aware ([#7431](https://github.com/spinnaker/spinnaker/pull/7431))


#### Spinnaker Deck - 2026.1.1

- fix(deck): Preserve execution selection when editing form fields ([#7439](https://github.com/spinnaker/spinnaker/pull/7439))
- fix(deck): fix artifact not bound error on deck ([#7371](https://github.com/spinnaker/spinnaker/pull/7371))
- fix(deck/pipeline): pass raw pipeline config to MetadataPageContent for V2 templated pipelines ([#7537](https://github.com/spinnaker/spinnaker/pull/7537))


#### Spinnaker Echo - 2026.1.1

- fix(echo): Fix Microsoft Teams webhook URL doubling in Retrofit2 migration ([#7718](https://github.com/spinnaker/spinnaker/pull/7718))
- fix(echo): GitHub status conversion exception ([#7701](https://github.com/spinnaker/spinnaker/pull/7701))
- feat(echo): add OTLP/gRPC transport for CDEvents notifications ([#7554](https://github.com/spinnaker/spinnaker/pull/7554))
- feat(echo): add mTLS support for OTLP/gRPC CDEvents transport ([#7561](https://github.com/spinnaker/spinnaker/pull/7561))
- fix(echo): actually increment trigger.errors.accessdenied counter ([#7388](https://github.com/spinnaker/spinnaker/pull/7388))


#### Spinnaker Fiat - 2026.1.1

- chore(change): Adopt latching for fiat role sync ([#7647](https://github.com/spinnaker/spinnaker/pull/7647))
- chore(change): Improve parallelization of redis fiat get and put ([#7648](https://github.com/spinnaker/spinnaker/pull/7648))
- fix(fiat): make prefix permissions case-insensitive ([#7361](https://github.com/spinnaker/spinnaker/pull/7361))
- fix(fiat): Minor potential issue if groups return list ever was null ([#7611](https://github.com/spinnaker/spinnaker/pull/7611))
- feat(change): Add GitHub App Authentication Support for Team Membership ([#7337](https://github.com/spinnaker/spinnaker/pull/7337))
- fix(gcp): Fiat batch queries on rate limit would randomly fail ([#7385](https://github.com/spinnaker/spinnaker/pull/7385))


#### Spinnaker Front50 - 2026.1.1


#### Spinnaker Gate - 2026.1.1

- fix(gate/web): return 200 instead of 500 for void orca endpoints ([#7574](https://github.com/spinnaker/spinnaker/pull/7574))
- fix(gate): rename x509 SecurityFilterChain bean to prevent SAML override when both are enabled ([#7539](https://github.com/spinnaker/spinnaker/pull/7539))
- fix(saml): Fix wiring issue on saml; add full end-to-end integration test using keycloak & htmlunitdriver ([#7525](https://github.com/spinnaker/spinnaker/pull/7525))
- fix(saml): Restore allowedAccounts ([#7453](https://github.com/spinnaker/spinnaker/pull/7453))
- fix(iap): Fix iap auth post spring 3.0 upgrade ([#7503](https://github.com/spinnaker/spinnaker/pull/7503))
- fix(gate/web): include additional exception message in AdminController.killZombie ([#7575](https://github.com/spinnaker/spinnaker/pull/7575))
- feat(admin): Admin controller for killing pipelines & is admin API check ([#7313](https://github.com/spinnaker/spinnaker/pull/7313))
- fix(oauth2): re-implement ExternalAuthTokenFilter to fix spin-cli login ([#7392](https://github.com/spinnaker/spinnaker/pull/7392))


#### Spinnaker Igor - 2026.1.1

- feat(igor): allow overriding artifact extensions in Artifactory monitors ([#7535](https://github.com/spinnaker/spinnaker/pull/7535))


#### Spinnaker Kayenta - 2026.1.1

- fix(kayenta): Send Authorization header proactively for Prometheus-compatible APIs ([#7464](https://github.com/spinnaker/spinnaker/pull/7464))


#### Spinnaker Orca - 2026.1.1

- fix(orca-core): fix evaluateVariables stage when evaluation has already failed prior ([#7372](https://github.com/spinnaker/spinnaker/pull/7372))
- fix(orca): Include pipeline config context in template variable validation errors ([#7354](https://github.com/spinnaker/spinnaker/pull/7354))
- fix(queue): pass true for restoreOriginalContext in StageExecution.withAuth ([#7357](https://github.com/spinnaker/spinnaker/pull/7357))
- fix(orca/web): properly deserialize webhook status code ([#7367](https://github.com/spinnaker/spinnaker/pull/7367))


#### Spinnaker Rosco - 2026.1.1

- fix(rosco/helmfile): fix command line arguments list when multiple values files are provided ([#7351](https://github.com/spinnaker/spinnaker/pull/7351))


#### Spinnaker Dinghy - 2026.1.1


#### Spinnaker Terraformer - 2026.1.1
