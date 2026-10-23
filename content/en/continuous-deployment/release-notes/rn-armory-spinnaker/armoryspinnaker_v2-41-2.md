---
title: v2.41.2 Armory Continuous Deployment Release (Spinnaker™ 2026.3.x)
toc_hide: true
version: 2.41.2
date: 2026-10-23
description: >
  Release notes for Armory Continuous Deployment v2.41.1.
---

<!--
MAKE SURE TO ADD 'LTS' OR 'FEATURE' TO THE TITLE TO INDICATE RELEASE CATEGORY.
FOR EXAMPLE, "Armory Continuous Deployment Release LTS" or "Armory Continuous Deployment Release Feature" so users know release category and support time period
-->

## 2026/10/23 release notes

>Note: If you experience production issues after upgrading Armory Continuous Deployment, roll back to a previous working version and report issues to [http://go.armory.io/support](http://go.armory.io/support).

{{% alert color="warning" title="Major upgrade" %}}
Armory CD 2.41.0 moves all AWS integrations to AWS SDK v2, removes Angular from the UI, moves Gate SAML configuration to Spring Security properties, and switches the Google provider to the Compute v1 API. Rebuild and validate custom backend and Deck plugins against 2.41.0; plugins that use removed APIs must be migrated before they can load. Validate this release in a non-production environment and read the [Breaking changes](#breaking-changes) before upgrading.
{{% /alert %}}

## Required Armory Operator version
{{% alert color="warning" title="Important" %}}
[Armory Operator]({{< ref "armory-operator" >}}) has been deprecated and is considered EOL. Please migrate to the [Kustomize]({{< ref "armory-operator-to-kustomize-migration" >}}) method of deployment.
{{% /alert %}}

To install, upgrade, or configure Armory CD 2.41.2, use Armory Operator 1.8.6 or later.

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

### Gate: Spring Security 5 Oauth2 Migration
Gate no longer supports the deprecated OAuth2 annotations and uses the Spring Security 5 DSL. Configure OAuth2 in `gate-local.yml` as follows:

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
          user-info-mapping:
            email: email
            first-name: ''
            last-name: name
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
    base-url: http://opa-server.opa:8181/v1
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

### Spring Boot 3.5 upgrade

Armory CD runs on Spring Boot 3.5. Plugins built against earlier Spring Boot versions, such as 3.0, must be updated to be compatible with this release.

**Actuator metrics export property changes**

If upgrading from a version prior to 2.39.0, note that the metrics export properties have moved:

| Old Property Prefix | New Property Prefix |
|---------------------|---------------------|
| `management.metrics.export.<product>` | `management.<product>.metrics.export` |

**Gate session data cleanup**

If upgrading from a version prior to 2.39.0, flush Gate's Redis session cache before upgrading:

```bash
redis-cli keys "spring:session*" | xargs redis-cli del
```

**Ignored `server.*` properties**

Earlier Spring Boot upgrades removed the following properties. Spring Boot ignores them without an error, so they have no effect if still set:

| Ignored property | Ignored since | Replacement |
|------------------|---------------|-------------|
| `server.max-http-header-size` | Armory CD 2.39.0 (Spring Boot 3.0) | `server.max-http-request-header-size` |
| `server.tomcat.max-http-header-size` | Spring Boot 2.2 | `server.max-http-request-header-size` |
| `server.tomcat.protocolHeader`, `remoteIpHeader`, `internalProxies` | Spring Boot 2.5 | `server.forward-headers-strategy` and `server.tomcat.remoteip.*` |
| `server.tomcat.httpsServerPort` | Never supported | `server.tomcat.remoteip.port-header` (default `X-Forwarded-Port`) |
| `server.session.cookie.*` | Spring Boot 2.0 | `server.servlet.session.cookie.*` |

If you raised the header limit with an old property, services are back on the 8KB default and reject larger headers, such as large SAML or OAuth tokens, with HTTP 400. Set the new property in the `spinnaker` profile to apply it to every service.

For example, this Gate profile:

```yaml
server:
  servlet:
    session:
      timeout: 86400
  session:
    cookie:
      same-site: none
      secure: true
  tomcat:
    max-http-header-size: 256KB
    httpsServerPort: X-Forwarded-Port
    internalProxies: .*
    protocolHeader: X-Forwarded-Proto
    remoteIpHeader: X-Forwarded-For
```

Becomes:

```yaml
server:
  forward-headers-strategy: native
  max-http-request-header-size: 256KB
  servlet:
    session:
      cookie:
        same-site: none
        secure: true
  session:
    timeout-in-seconds: 86400
```

- On Kubernetes, Spring Boot already applies `native` when no strategy is set; setting it explicitly matters on other platforms.
- `native` trusts forwarded headers only from private and loopback addresses. For a load balancer on another address, set `server.tomcat.remoteip.internal-proxies`.
- If your proxy strips a path prefix and sends `X-Forwarded-Prefix`, use `framework` instead. It trusts these headers from any client, so the proxy must overwrite them.
- Gate's session lifetime is set by `server.session.timeout-in-seconds` (default `3600`), not `server.servlet.session.timeout`.

### YAML parsing limits now configurable

Starting with SnakeYAML 1.33, strict safety limits are enforced by default (`maxAliasesForCollections = 50`, `codePointLimit = 3145728`). These can cause large or alias-heavy YAML files such as Kubernetes manifests to fail. Two new properties allow operators to override these limits:

```yaml
snakeyaml:
  max-aliases-for-collections: 500   # default: 50
  code-point-limit: 10485760         # default: 3145728
```

### AWS JDBC Driver Update

The AWS JDBC driver has been updated from the deprecated aws-mysql-jdbc driver (version 1.0.0) to the [AWS Advanced JDBC Wrapper](https://github.com/aws/aws-advanced-jdbc-wrapper).

This update adds support for IAM authentication with AWS Aurora Global Database endpoints. The previous driver did not support global database endpoint format (`*.global.rds.amazonaws.com`) when using IAM authentication, resulting in the error:

```
java.sql.SQLException: Unsupported AWS hostname '<hostname>.global.rds.amazonaws.com'.
Amazon domain name in format *.AWS-Region.rds.amazonaws.com is expected
```

**Note:** Standard database connections (without IAM authentication) continue to work as before and do not require any configuration changes.

**Affected services:** Front50, Orca, Clouddriver, Fiat

#### Configuration for IAM Authentication with Aurora Global Database

If you are using IAM authentication and want to connect to Aurora Global Database endpoints, update your JDBC connection string:

**New JDBC URL format:**

```
jdbc:aws-wrapper:mysql://<GLOBAL_ENDPOINT>:<PORT>/<DATABASE>?wrapperPlugins=iam&globalClusterInstanceHostPatterns=?.<CLUSTER_IDENTIFIER>.<REGION1>.rds.amazonaws.com,?.<CLUSTER_IDENTIFIER>.<REGION2>.rds.amazonaws.com&iamRegion=<CURRENT_REGION>
```

**Example:** If your Aurora Global Database has:
- Global endpoint: `mydb-global.global-xxxxx.global.rds.amazonaws.com`
- Primary (us-west-2): `mydb.cluster-abc123.us-west-2.rds.amazonaws.com`
- Secondary (us-east-1): `mydb.cluster-abc123.us-east-1.rds.amazonaws.com`

Configure the JDBC URL as:
```
jdbc:aws-wrapper:mysql://mydb-global.global-xxxxx.global.rds.amazonaws.com:3306/front50?wrapperPlugins=iam&globalClusterInstanceHostPatterns=?.cluster-abc123.us-west-2.rds.amazonaws.com,?.cluster-abc123.us-east-1.rds.amazonaws.com&iamRegion=us-west-2
```

### Orca: Lambda invoke payload artifact resolution

Lambda invoke stages now support SpEL expression evaluation and expected-artifact binding in payload artifacts.

Previously, Lambda invocation used a custom `LambdaPipelineArtifact` class that did not participate in Orca's standard artifact resolution flow. The artifact was fetched inside Clouddriver's atomic `invokeLambdaFunction` operation, so Orca could not evaluate expressions or bind expected artifacts before invocation.

With this release, a new Orca task `LambdaResolveInvokeArtifactTask` runs before `LambdaInvokeTask` when the feature flag is enabled:

- Reads the `payloadArtifact` from stage context.
- Resolve expected-artifact IDs and evaluate any SpEL expressions.
- Fetches the artifact content.
- Stores the resolved content in stage context as `resolvedPayload`.

`LambdaInvokeTask` then uses `resolvedPayload` and omits `payloadArtifact` when resolution happened, or falls back to the legacy behavior of passing `payloadArtifact` to Clouddriver when `resolvedPayload` is absent.

Enable the feature by setting the following configuration in `orca-local.yml`:

```yaml
stages:
  lambda-invoke:
    resolve-payload-artifact: true
```

### OSS Spinnaker images moved to GHCR

OSS Spinnaker images are no longer published to Google Artifact Registry (GAR) and now pull from GitHub Container Registry (GHCR) at `ghcr.io/spinnaker/`. **Armory CD images continue to be published to Docker Hub** (`docker.io/armory`) and are unaffected. If you consume any OSS Spinnaker images directly alongside your Armory CD deployment, update those image references to point to GHCR before upgrading.

### MySQL 8+ now required

Due to recent SQL library upgrades, MySQL 5.7 is no longer supported and will fail on startup. You must be running MySQL 8.0+ or an equivalent MariaDB version before upgrading.

### Redis/Valkey 7+ now required

Redis or Valkey 7.0+ is required. Older versions are not supported and may cause failures. Armory already deploys Redis 7+ by default — verify your Redis version before upgrading if you manage your own Redis instance.

### Armory Scale Agent (Kubesvc) deprecation notice

The Armory Scale Agent (Kubesvc) is planned for deprecation in the next major release of Armory CD.

### URL trailing-slash handling changed

Due to Spring Boot changes, a new filter has been added that restores lenient handling of trailing slashes. If you have controllers (in plugins or custom code) that only register a trailing-slash route, those controllers may break. You can adjust or disable this filter per service:

```yaml
url-handler:
  trailing-slash:
    enabled: true          # set false to opt out
    path-patterns:
      - "/**"              # narrow if desired
```

It is recommended to update any affected controllers to handle both paths with and without a trailing slash.

### Gate: SAML is configured with native Spring Security properties

SAML connection settings move from custom `saml.*` properties to Spring Boot's `spring.security.saml2.relyingparty.registration.*` ([#7826](https://github.com/spinnaker/spinnaker/pull/7826), [#7833](https://github.com/spinnaker/spinnaker/pull/7833)). See the [full migration guide](https://github.com/spinnaker/spinnaker/blob/main/gate/gate-saml/docs/saml-migration.md).

| Removed property | Replacement |
|---|---|
| `saml.metadata-url` | `spring.security.saml2.relyingparty.registration.<id>.assertingparty.metadata-uri` |
| `saml.issuer-id` | `spring.security.saml2.relyingparty.registration.<id>.entity-id` |
| `saml.registration-id` | The `<id>` key in the registration map |
| `saml.sign-requests` | `spring.security.saml2.relyingparty.registration.<id>.assertingparty.singlesignon.sign-request` |
| `saml.signing-credentials[*]` | `spring.security.saml2.relyingparty.registration.<id>.signing.credentials[*]` |
| `saml.key-store`, `saml.key-store-password`, `saml.key-store-alias-name` | PEM files in `spring.security.saml2.relyingparty.registration.<id>.decryption.credentials[*]` |

`saml.enabled`, `saml.login-processing-url`, `saml.required-roles`, `saml.sort-roles`, `saml.force-lowercase-roles`, and `saml.user-attribute-mapping.*` are unchanged. `saml.login-processing-url` is deprecated, and its default changed from `/saml/{registrationId}` to `/saml/SSO`. If you use a registration ID other than `SSO` and didn't set this property, the login path changes.

If you didn't set `saml.issuer-id`, the service provider entity ID changes: it was `{baseUrl}/saml2/metadata` and is now Spring's default, `{baseUrl}/saml2/service-provider-metadata/{registrationId}`. To keep the previous value, set it explicitly:

```yaml
spring:
  security:
    saml2:
      relyingparty:
        registration:
          SSO:
            entity-id: "{baseUrl}/saml2/metadata"
```

Java keystores are no longer read. This includes the `saml.signing-keystore*` properties. Export the key and certificate to PEM files and reference them under `signing.credentials` or `decryption.credentials`.

Gate still listens on `/saml/SSO` by default, but Spring Boot advertises `/login/saml2/sso/<id>` as the login (ACS) location unless `acs.location` is set. To keep the `/saml/SSO` path without changing your IdP, set **both** `saml.login-processing-url` and `acs.location` in your `gate-local.yml`:

```yaml
saml:
  enabled: true
  login-processing-url: /saml/SSO
  user-attribute-mapping:
    email: email
    roles: memberOf

spring:
  security:
    saml2:
      relyingparty:
        registration:
          SSO:
            acs:
              location: "{baseUrl}/saml/SSO"
            entity-id: spinnaker
            assertingparty:
              metadata-uri: https://idp.example.com/saml/metadata
              singlesignon:
                sign-request: true
            signing:
              credentials:
                - private-key-location: /etc/gate/saml/private_key.pem
                  certificate-location: /etc/gate/saml/certificate.pem
```

To move to the Spring Boot path instead, update your IdP and set:

```yaml
saml:
  login-processing-url: /login/saml2/sso/{registrationId}
```

### AWS SDK v1, Edda, and bastion support removed

All AWS integrations, including credentials, caching agents, operations, Lambda, ECS, S3 secrets, and the config server, now use AWS SDK v2, and the `aws-java-sdk` (v1) dependencies are removed ([#7944](https://github.com/spinnaker/spinnaker/pull/7944)). This replaces the AWS SDK v1 deprecation notice from 2.40.x.

**Edda** support is removed ([#7941](https://github.com/spinnaker/spinnaker/pull/7941)). Clouddriver now calls AWS APIs directly, so plan for the higher API call volume. The following settings are ignored and can be removed from your `clouddriver-local.yml`:

```yaml
aws:
  default-edda-template: ...   # removed
  accounts:
    - name: my-aws-account
      edda: ...                # removed
      edda-enabled: true       # removed
```

**Bastion** credential bootstrapping is removed ([#7922](https://github.com/spinnaker/spinnaker/pull/7922)). Use IAM roles, instance profiles, or IRSA instead, and remove the following settings:

```yaml
bastion:                          # removed, including all child properties
  enabled: true
aws:
  default-bastion-host-template: ... # removed
  accounts:
    - name: my-aws-account
      bastion-host: ...              # removed
      bastion-enabled: true          # removed
```

**Plugins** that use `com.amazonaws.*` types must migrate to `software.amazon.awssdk.*` or bundle their own SDK. Custom SQS/SNS pub/sub handlers (`AmazonPubsubMessageHandler`) now receive `software.amazon.awssdk.services.sqs.model.Message` ([#7912](https://github.com/spinnaker/spinnaker/pull/7912)).

### UI: Angular removed

Angular has been removed from Deck ([#7848](https://github.com/spinnaker/spinnaker/pull/7848) and related PRs). `settings.js` and `settings-local.js` are unchanged.

- Angular-based Deck plugins no longer load and must be rewritten in React.
- Rebuild and test React-based Deck plugins against 2.41.0.

Several provider stage forms lost fields during the migration and were restored before this release (AWS, Azure, Google, App Engine, Oracle).

### Google Cloud: Compute API moved from beta to stable v1

The Google provider now uses the stable Compute v1 API ([#7510](https://github.com/spinnaker/spinnaker/pull/7510)). Before upgrading, check saved GCE deploy, clone, and autoscaling or autohealing policy update stages:
- `partnerMetadata` is no longer applied. Clouddriver strips it and logs a warning. Remove it from pipeline JSON. `resourceManagerTags` is supported but isn't a drop-in replacement.
- `autoHealingPolicy.maxUnavailable` is rejected, including an empty object. Keep only `healthCheck`, `healthCheckKind`, and `initialDelaySec`.
- Regional server groups with `selectZones: true` must list their zones explicitly.

Previous:
```json
{
  "autoHealingPolicy": {
    "healthCheck": "example-health-check",
    "healthCheckKind": "healthCheck",
    "initialDelaySec": 300,
    "maxUnavailable": {
      "fixed": 2
    }
  }
}
```

New:
```json
{
  "autoHealingPolicy": {
    "healthCheck": "example-health-check",
    "healthCheckKind": "healthCheck",
    "initialDelaySec": 300
  }
}
```

Saving a stage in the new Deck can permanently remove `partnerMetadata` and `autoHealingPolicy.maxUnavailable` from the persisted pipeline; a binary rollback doesn't restore them. Retain Front50 pipeline history before editing GCE stages. After rolling back, refresh Google server-group and instance-template caches before clone, edit, or snapshot operations, and don't mutate flexibility-enabled managed instance groups with 2.40.x.

### Kubernetes: old API versions removed

Clouddriver no longer handles `extensions/v1beta1` and `networking.k8s.io/v1beta1` Ingress, `apiextensions.k8s.io/v1beta1` CustomResourceDefinitions, or `batch/v2alpha1` CronJob status ([#7802](https://github.com/spinnaker/spinnaker/pull/7802)). Kubernetes removed all of these by 1.22. Migrate to `networking.k8s.io/v1`, `apiextensions.k8s.io/v1`, and `batch/v1`.

### The upstream Kustomize reference installation now defaults to MySQL

The `spinnaker-kustomize` reference manifests replaced the `components/mariadb` component with `components/mysql` and now deploy MySQL 8 by default ([#7823](https://github.com/spinnaker/spinnaker/pull/7823)). This does not migrate an existing MariaDB database or persistent volume. If you deploy from these upstream manifests, preserve your existing external database configuration or migrate the data before applying the new default component.

### Rosco: Helmfile hooks and post-renderers are blocked by default

Rosco now refuses to bake a `helmfile.yaml`, including any local bases or fragments, that declares `hooks` or post-renderers. It fails closed on content it can't fully parse, and runs helmfile with `HELMFILE_DISABLE_HOOKS=true` and `HELMFILE_DISABLE_INSECURE_FEATURES=true` ([#8015](https://github.com/spinnaker/spinnaker/pull/8015), [#8034](https://github.com/spinnaker/spinnaker/pull/8034)). Remote or templated `bases:` and `helmfiles:` references are rejected, and helmfile's `exec`, `readFile`, and `readDir` functions and remote fetching are disabled. This closes a remote code execution path through bake inputs. If you trust your helmfile sources, opt back in from your `rosco-local.yml`:

```yaml
helmfile:
  allow-hooks-and-post-renderers: true
```

### Halyard removed upstream

**Halyard** has been removed from the OSS codebase ([#7865](https://github.com/spinnaker/spinnaker/pull/7865)). The Armory Operator can still install and upgrade Armory CD 2.41.0, but it is deprecated. Plan your migration to [Kustomize]({{< ref "armory-operator-to-kustomize-migration" >}}) ([armory/spinnaker-kustomize-patches](https://github.com/armory/spinnaker-kustomize-patches)).

### Cloud Foundry uses the v3 API

The Cloud Foundry provider no longer calls any CAPI v2 endpoint; all operations use CAPI v3 ([#7800](https://github.com/spinnaker/spinnaker/pull/7800)). Confirm that your foundations expose the v3 API.

### Armory and community plugins are now built in

The following plugins are now part of Armory CD. Remove them from `spinnaker.extensibility.plugins` (and their repositories) in every service, and their Deck halves from Gate's `spinnaker.extensibility.deck-proxy.plugins`. **Don't load a plugin and its built-in replacement together.**

| Plugin | Built-in replacement |
|---|---|
| Run Multiple Pipelines (`Armory.RunMultiplePipelines`) | Core `runMultiplePipelines` stage ([#7803](https://github.com/spinnaker/spinnaker/pull/7803)). Pipeline JSON is unchanged. |
| Wait For Stable Manifest (`Armory.WaitForStableManifest`) | Core Deploy (Manifest) option `stableManifestTimeoutMinutes` ([#7804](https://github.com/spinnaker/spinnaker/pull/7804)). Rename the plugin's `timeoutMinutes` stage field to `stableManifestTimeoutMinutes`; otherwise stages fall back to 30 minutes. |
| Event Filter (`Armory.EventFilter`) | `armory.event-filter` in `echo-local.yml` |
| Kubernetes Custom Resource Status (`Armory.K8sCustomResourceStatus`) | `armory.k8s-custom-resource-status` in `clouddriver-local.yml` |

See [Echo: Event Filter is built in](#echo-event-filter-is-built-in) and [Clouddriver: Kubernetes Custom Resource Status is built in](#clouddriver-kubernetes-custom-resource-status-is-built-in) for the configuration.

### Plugin API changes

Besides the AWS SDK v2 change above, these plugin-facing changes affect backend plugins:
- The build toolchain moved to Gradle 9 and Kotlin 2.1 ([#7790](https://github.com/spinnaker/spinnaker/pull/7790)).
- `BaseHttpArtifactCredentials.getHeaders(T)` now declares `throws IOException`. Subclasses that call `super.getHeaders(...)` need the same clause ([#7897](https://github.com/spinnaker/spinnaker/pull/7897)).

### Clouddriver: account storage is on by default

`account.storage.enabled` now defaults to `true` ([#7799](https://github.com/spinnaker/spinnaker/pull/7799)). With Clouddriver SQL enabled, the SQL account-definition repository and the AWS, Azure, Docker, Google, Kubernetes, and ECS account-definition sources now turn on automatically. The Credentials API is no longer marked `@Beta`. To keep the previous behavior, add the following to your `clouddriver-local.yml`:

```yaml
account:
  storage:
    enabled: false
```

### Deprecations

- **Front50:** all non-SQL metadata storage (S3, GCS, Azure, Redis, Oracle, Swift) is deprecated and logs a warning at startup. It remains supported through Spinnaker 2027.0.0 and is scheduled for removal after that release. S3 plugin-binary storage isn't affected. Plan your [migration to SQL](https://spinnaker.io/docs/setup/productionize/persistence/front50-sql/#migration) ([#7886](https://github.com/spinnaker/spinnaker/pull/7886)).
- **Orca:** Redis storage of execution data will be removed in Spinnaker 2027.0.0. Move execution storage to SQL. The Redis queue is not affected.
- **Kustomize 3** (the `KUSTOMIZE` render type) is deprecated and logs a warning on each bake. Upstream plans to remove it in the Spinnaker 2026.4.x releases. Use `KUSTOMIZE4` or the new `KUSTOMIZE5` render type ([#7787](https://github.com/spinnaker/spinnaker/pull/7787)). Deck has no option for `KUSTOMIZE5` yet, so set it in the Bake (Manifest) stage JSON:

  ```json
  {
    "type": "bakeManifest",
    "templateRenderer": "KUSTOMIZE5"
  }
  ```

  Rosco runs the `kustomize5` binary by default. To use a different binary, set the path in your `rosco-local.yml`:

  ```yaml
  kustomize:
    v5-executable-path: kustomize5
  ```
- **Spectator:** the native Spectator-to-Stackdriver feed (`spectator.stackdriver.enabled`) is deprecated and will be removed in an upcoming release; Spectator overall is scheduled for removal in 2027.0.0. Migrate instrumentation to Micrometer/OpenTelemetry.

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

{{< include "known-issues/ki-kubesvc-changelog-migration.md" >}}

## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->

### Echo: Event Filter is built in

Echo can skip or trim events before forwarding them to REST endpoints without installing the `Armory.EventFilter` plugin. Remove the plugin and move its `event.filters` list to `armory.event-filter.filters` in your `echo-local.yml`.

Previous:
```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.EventFilter:
        enabled: true
        version: <version>

rest:
  enabled: true

event:
  filters: [...]
```

New:
```yaml
armory:
  event-filter:
    enabled: true
    filters:
      - path: "$.details.type"
        path-value: "orca:stage:starting"
        action: SKIP
        enabled: true
      - path: "$.content.execution.stages[*].context"
        predicate: "$.content.execution.stages[?(@.type == 'deployManifest')]"
        action: TRIM
        enabled: true

rest:
  enabled: true
```

### Clouddriver: Kubernetes Custom Resource Status is built in

Clouddriver evaluates the stability of Kubernetes custom resources without installing the `Armory.K8sCustomResourceStatus` plugin. Remove the plugin and move its `config` block to `armory.k8s-custom-resource-status` in your `clouddriver-local.yml`. The `kind` and `status` rule schema is unchanged.

Previous:
```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.K8sCustomResourceStatus:
        enabled: true
        version: 3.1.2
        config:
          kind: [...]
          status: {...}
```

New:
```yaml
armory:
  k8s-custom-resource-status:
    enabled: true
    kind:
      - name: CronTab.spinnaker.io
        status:
          unavailable:
            conditions:
              - status: "True"
                type: Stalled
    status:
      failed:
        conditions:
          - reason: Reconciling
            status: "True"
            type: Reconciling
```

### Rosco: Kustomize 5, Helmfile 1.7.0, and Packer 1.15.4

Armory Rosco now ships Kustomize 5.8.1 (`kustomize5`), Helmfile 1.7.0 (was 1.6.0), and Packer 1.15.4 (was 1.11.0). Validate custom bake templates, Helmfile inputs, and scripts against the new binaries.

### Gate: Native MCP server

Gate can expose Spinnaker as a [Model Context Protocol](https://modelcontextprotocol.io) server at `/mcp`, so AI assistants can query applications, pipelines, and executions ([#7910](https://github.com/spinnaker/spinnaker/pull/7910)). The server is off by default and read-only when enabled. To enable, add the following to your `gate-local.yml`:

```yaml
mcp:
  server:
    enabled: true
    read-only: true      # set false to allow mutating tools
    audit-log-size: 500
```

Starting with 2.41.1, you can limit which tools the MCP server exposes with `mcp.server.allowed-tools` ([#8184](https://github.com/spinnaker/spinnaker/pull/8184)). When set, tools that aren't listed don't appear in `tools/list` and can't be called. `read-only` still applies to allowlisted mutating tools, and Gate logs a warning at startup for names that don't match a registered tool:

```yaml
mcp:
  server:
    enabled: true
    allowed-tools:
      - get_application
      - get_pipeline_execution
      - get_failed_stages
      - trigger_pipeline
```

### Gate: Private GitHub organization memberships

The GitHub OAuth 2.0 `organization` requirement only sees public organization memberships, so users whose membership is private are rejected. Starting with 2.41.1, Gate can look up the user's membership directly, which includes private memberships ([#8193](https://github.com/spinnaker/spinnaker/pull/8193)). The membership must be active, and the OAuth 2.0 registration needs the `user` or `read:org` scope. This is off by default. To enable, add the following to your `gate-local.yml`:

```yaml
spring:
  security:
    oauth2:
      client:
        registration:
          github:
            provider-requirements:
              organization: my-org
              include-private-memberships: true
```

### Clouddriver: GitHub App authentication for artifacts

`git/repo` and `github/file` artifact accounts can authenticate as a GitHub App. Installation tokens are minted, cached, and refreshed automatically ([#7897](https://github.com/spinnaker/spinnaker/pull/7897)). Configure the app per account in your `clouddriver-local.yml`:

```yaml
artifacts:
  git-repo:
    enabled: true
    accounts:
      - name: my-github-app-repo
        github-app:
          app-id: "123456"
          app-private-key-path: /secrets/gh-app-key.pem   # or an encrypted secret URI
          app-installation-id: "789012"                   # optional; derived from the repository when omitted
          allowed-organizations: [my-org]                 # recommended when app-installation-id is omitted
          # api-base-url: https://ghe.example.com/api/v3
```

GitHub App clones use HTTPS, so `git@…` repository URLs aren't supported with this method.

### Pipelines: Run Multiple Pipelines stage

The `runMultiplePipelines` stage triggers several child pipelines from one stage, with `depends_on` ordering and per-child arguments ([#7803](https://github.com/spinnaker/spinnaker/pull/7803)). For rollback on failure, the downstream application needs a pipeline named `rollbackOnFailure`. Example stage definition:

```yaml
bundle_web:
  appName1:
    arguments:
      app: app1
      tag: 1.1.1
      targetEnv: targetEnv
    child_pipeline: childPipeline
  appName2:
    arguments:
      app: app2
      tag: 1.1.1
      targetEnv: targetEnv
    child_pipeline: childPipeline
    depends_on:
      - appName1
```

### Pipelines: Evaluate Artifacts stage

The new Evaluate Artifacts stage evaluates SpEL inside artifact contents and emits `embedded/base64` artifacts for later stages ([#7845](https://github.com/spinnaker/spinnaker/pull/7845)). Artifacts are evaluated in order, so a later artifact can reference an earlier one.

### Kubernetes: Configurable Deploy (Manifest) stability timeout

The wait for a deployed manifest to become stable, previously fixed at 30 minutes, can be set per Deploy (Manifest) stage in the UI or in the stage JSON ([#7804](https://github.com/spinnaker/spinnaker/pull/7804)):

```json
{
  "type": "deployManifest",
  "stableManifestTimeoutMinutes": 60
}
```

### AWS: Auto Scaling warm pools

A new stage and a server group details section manage Auto Scaling warm pools ([#7852](https://github.com/spinnaker/spinnaker/pull/7852)).

### Helmfile: Environment, namespace, and artifact overrides

Helmfile bake stages expose validated environment and namespace fields ([#7890](https://github.com/spinnaker/spinnaker/pull/7890)) and accept artifacts as value overrides ([8db2ef0](https://github.com/spinnaker/spinnaker/commit/8db2ef0fef)).

### Igor: GitLab CI pipeline triggers

Igor can trigger GitLab CI pipelines when a master has a pipeline trigger token ([#7885](https://github.com/spinnaker/spinnaker/pull/7885)). Add the token to the master in your `igor-local.yml`:

```yaml
gitlab-ci:
  enabled: true
  masters:
    - name: my-gitlab
      address: https://gitlab.example.com
      private-token: <api-token>
      trigger-token: <pipeline-trigger-token>
```

### UI: Global banners

Admins can publish scheduled, site-wide banners ([#7781](https://github.com/spinnaker/spinnaker/pull/7781)). Banners are stored in Redis by Gate. To enable, add the following to your `gate-local.yml`:

```yaml
global-banner:
  enabled: true
  refresh-interval-ms: 60000   # default
  max-message-length: 2000     # default
```

### UI: Account management

Admins can add, edit, and remove Clouddriver accounts from a new page in the UI ([#7799](https://github.com/spinnaker/spinnaker/pull/7799)). The page uses Clouddriver account storage, which is now on by default; see [Clouddriver: account storage is on by default](#clouddriver-account-storage-is-on-by-default).

### UI: Log auto-refresh and trigger execution list

Console output and job log windows can refresh automatically ([#7820](https://github.com/spinnaker/spinnaker/pull/7820)), and the number of executions offered when manually triggering a pipeline is configurable ([#7770](https://github.com/spinnaker/spinnaker/pull/7770)). Git file artifacts also get an org/repo/path URL builder ([#7916](https://github.com/spinnaker/spinnaker/pull/7916)). To change the defaults, add the following to your `settings-local.js`:

```javascript
window.spinnakerSettings.consoleLogRefreshIntervalMs = 30000;     // default
window.spinnakerSettings.maxPipelineTriggerExecutionOptions = 20; // default
```

### Kayenta: ClickHouse metrics store

Kayenta can use ClickHouse as a metrics source ([#7911](https://github.com/spinnaker/spinnaker/pull/7911)). To enable, add the following to your `kayenta-local.yml`:

```yaml
kayenta:
  clickhouse:
    enabled: true
    accounts:
      - name: my-clickhouse
        endpoint-url: https://clickhouse.example.com:8443
        username: <user>
        password: <password>
        database: <database>
        supported-types: [METRICS_STORE]
```

### Clouddriver: Pub/Sub agent scheduler (alpha)

A new, opt-in caching-agent scheduler processes agents in order using Redis Streams and SQL-backed agent state, and publishes per-agent metrics ([#7399](https://github.com/spinnaker/spinnaker/pull/7399)). It replaces the Redis scheduler when enabled. To try it, add the following to your `clouddriver-local.yml`:

```yaml
spring:
  data:
    redis:
      url: redis://valkey:6379

cats:
  pubsub:
    enabled: true
    delay-between-scheduler-runs-ms: 15000
    minutes-before-deleting-marked-for-deletion: 180
    minutes-before-re-queue-of-agents: 20
    max-concurrent-agents: 100
    stream-max-length: 100_000
```

### AWS: Account bootstrapping in each account's region

AWS account bootstrapping can use each account's first configured region (or `default-regions`) instead of the host's region, which helps when Clouddriver runs outside AWS ([#8132](https://github.com/spinnaker/spinnaker/pull/8132)). To enable, add the following to your `clouddriver-local.yml`:

```yaml
aws:
  use-account-regions: true   # default: false
```

### Orca: AWS CodeBuild polling is configurable

The AWS CodeBuild stage's polling interval and timeout are configurable ([#7855](https://github.com/spinnaker/spinnaker/pull/7855)). The defaults match the previous hardcoded values. To change them, add the following to your `orca-local.yml`:

```yaml
tasks:
  monitor-aws-code-build:
    backoff-period: 10000   # milliseconds, default
    timeout: 28800000       # milliseconds (8 hours), default
```

### Spin CLI: API tokens and OAuth2

`spin` supports Gate API tokens ([#7782](https://github.com/spinnaker/spinnaker/pull/7782)) and sends the OAuth2 bearer token on every request ([#7918](https://github.com/spinnaker/spinnaker/pull/7918)).

### Clouddriver: SQL task ordering and schema migration

Clouddriver's SQL task repository now orders task history by a per-task sequence instead of timestamps, and a task's state no longer changes once it is terminal, except to retry a `FAILED_RETRYABLE` task ([#8130](https://github.com/spinnaker/spinnaker/pull/8130)). Previously, completed tasks could be listed as running, and a duplicate request could mark a running task as failed. PostgreSQL can now store the `FAILED_RETRYABLE` state.

On startup, Clouddriver migrates the `tasks` schema: it adds nullable columns, adds the `tasks_current_state_owner_idx` and `tasks_current_state_completed_at_idx` indexes, and replaces the `request_id` index with a unique index. Existing duplicate request IDs are kept and renamed with a `:duplicate:<id>` suffix. On PostgreSQL the indexes aren't created concurrently, so on large installations consider creating them with `CREATE INDEX CONCURRENTLY` before upgrading.

### Fixed issues

- Paging executions by pipeline config ID honors `page` ([#7850](https://github.com/spinnaker/spinnaker/pull/7850)).
- Clouddriver SQL cache: for AWS and ECS, deleting the last resource of a kind now evicts it from the cache ([#8069](https://github.com/spinnaker/spinnaker/pull/8069), [#8072](https://github.com/spinnaker/spinnaker/pull/8072)).
- Dynamic account loading no longer races ([#7791](https://github.com/spinnaker/spinnaker/pull/7791)).
- Regressions from the AWS SDK v2 migration: server group creation times shown as 1970 ([#8141](https://github.com/spinnaker/spinnaker/pull/8141)), ECS clusters returning 400 or losing task-definition fields from the cache ([#7898](https://github.com/spinnaker/spinnaker/pull/7898), [#7899](https://github.com/spinnaker/spinnaker/pull/7899), [#7901](https://github.com/spinnaker/spinnaker/pull/7901)), and ASG clone and Lambda-only application errors ([#7952](https://github.com/spinnaker/spinnaker/pull/7952)).
- AWS bakes no longer fail with `No base image found for os '<os>', vm type 'hvm'` ([#8163](https://github.com/spinnaker/spinnaker/pull/8163)).
- ECS accounts pick up changes to their backing AWS account, such as a new region, without restarting Clouddriver ([#8196](https://github.com/spinnaker/spinnaker/pull/8196)).
- Pipeline stage editors, trigger forms, and execution options no longer show or save stale values after switching stages, editing pipeline JSON, or restoring history ([#8202](https://github.com/spinnaker/spinnaker/pull/8202)).
- Orca no longer loses queue messages for stages with looping tasks, which could leave executions stuck in `RUNNING` ([#7919](https://github.com/spinnaker/spinnaker/pull/7919)).
- Echo compares GitHub webhook signatures in constant time and no longer logs the computed digest ([#8162](https://github.com/spinnaker/spinnaker/pull/8162)).
- Fiat role syncs are faster for installations with many users and restricted resources ([#8136](https://github.com/spinnaker/spinnaker/pull/8136)).
- OSS image packages and shared Java dependencies are updated to address CVEs ([#8181](https://github.com/spinnaker/spinnaker/pull/8181)).

###  Spinnaker community contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker 2026.3.0](https://www.spinnaker.io/changelogs/2026.3.0-changelog/) and [2026.3.1](https://www.spinnaker.io/changelogs/2026.3.1-changelog/) changelogs for details.

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
    commit: 8b8f98f26ee0d6151423bd342482b828b4bc53b0
    version: 2.41.2
  deck:
    commit: 8b8f98f26ee0d6151423bd342482b828b4bc53b0
    version: 2.41.2
  dinghy:
    commit: f22d5925ee1d282a725a5926317f40ff76b1d742
    version: 2.41.2
  echo:
    commit: 8b8f98f26ee0d6151423bd342482b828b4bc53b0
    version: 2.41.2
  fiat:
    commit: 8b8f98f26ee0d6151423bd342482b828b4bc53b0
    version: 2.41.2
  front50:
    commit: 8b8f98f26ee0d6151423bd342482b828b4bc53b0
    version: 2.41.2
  gate:
    commit: 8b8f98f26ee0d6151423bd342482b828b4bc53b0
    version: 2.41.2
  igor:
    commit: 8b8f98f26ee0d6151423bd342482b828b4bc53b0
    version: 2.41.2
  kayenta:
    commit: 8b8f98f26ee0d6151423bd342482b828b4bc53b0
    version: 2.41.2
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 8b8f98f26ee0d6151423bd342482b828b4bc53b0
    version: 2.41.2
  rosco:
    commit: 8b8f98f26ee0d6151423bd342482b828b4bc53b0
    version: 2.41.2
  terraformer:
    commit: 8b8f98f26ee0d6151423bd342482b828b4bc53b0
    version: 2.41.2
timestamp: "2026-10-23 13:17:38"
version: 2.41.2
</code>
</pre>
</details>

### Armory


#### Armory Orca - 2.41.1...2.41.2


#### Armory Kayenta - 2.41.1...2.41.2


#### Armory Dinghy - 2.41.1...2.41.2


#### Armory Igor - 2.41.1...2.41.2


#### Armory Gate - 2.41.1...2.41.2


#### Armory Front50 - 2.41.1...2.41.2


#### Armory Fiat - 2.41.1...2.41.2


#### Armory Echo - 2.41.1...2.41.2


#### Armory Deck - 2.41.1...2.41.2


#### Armory Clouddriver - 2.41.1...2.41.2


#### Armory Terraformer - 2.41.1...2.41.2


#### Armory Rosco - 2.41.1...2.41.2



### Spinnaker

#### Spinnaker Clouddriver - 2026.3.x

- fix(ecs): reload ECS account credentials when their backing AWS account changes ([#8196](https://github.com/spinnaker/spinnaker/pull/8196))
- fix(security): update image packages and shared Java dependencies ([#8181](https://github.com/spinnaker/spinnaker/pull/8181))
- fix(clouddriver): order SQL task state by a per-task sequence and make terminal states final ([#8130](https://github.com/spinnaker/spinnaker/pull/8130))
- fix(clouddriver): cache named-image enums as their AWS wire values ([#8163](https://github.com/spinnaker/spinnaker/pull/8163))

#### Spinnaker Deck - 2026.3.x

- fix(deck): keep pipeline editors in sync with pipeline changes ([#8202](https://github.com/spinnaker/spinnaker/pull/8202))
- fix(security): update image packages and shared Java dependencies ([#8181](https://github.com/spinnaker/spinnaker/pull/8181))

#### Spinnaker Echo - 2026.3.x

- fix(echo): compare GitHub webhook signatures in constant time ([#8162](https://github.com/spinnaker/spinnaker/pull/8162))

#### Spinnaker Fiat - 2026.3.x

- perf(fiat): index restricted resources by group and use sets for service account role checks ([#8136](https://github.com/spinnaker/spinnaker/pull/8136))

#### Spinnaker Front50 - 2026.3.x

#### Spinnaker Gate - 2026.3.x

- feat(gate): optionally check private GitHub organization memberships ([#8193](https://github.com/spinnaker/spinnaker/pull/8193))
- feat(gate): add an allowlist for MCP tools ([#8184](https://github.com/spinnaker/spinnaker/pull/8184))

#### Spinnaker Igor - 2026.3.x

#### Spinnaker Kayenta - 2026.3.x

#### Spinnaker Orca - 2026.3.x

- fix(orca): ack queue messages atomically so a concurrent push survives for stages that have looping tasks ([#7919](https://github.com/spinnaker/spinnaker/pull/7919))

#### Spinnaker Rosco - 2026.3.x

#### Spinnaker Kork (shared libraries)

- fix(security): update image packages and shared Java dependencies ([#8181](https://github.com/spinnaker/spinnaker/pull/8181))
