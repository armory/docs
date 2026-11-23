---
title: v2.42.0 Armory Continuous Deployment Release (Spinnaker™ 2026.4.x)
toc_hide: true
version: 02.42.00
date: 2026-11-23
description: >
  Release notes for Armory Continuous Deployment v2.42.0.
---

<!--
MAKE SURE TO ADD 'LTS' OR 'FEATURE' TO THE TITLE TO INDICATE RELEASE CATEGORY.
FOR EXAMPLE, "Armory Continuous Deployment Release LTS" or "Armory Continuous Deployment Release Feature" so users know release category and support time period
-->

## 2026/11/23 release notes

>Note: If you experience production issues after upgrading Armory Continuous Deployment, roll back to a previous working version and report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version
{{% alert color="warning" title="Important" %}}
[Armory Operator]({{< ref "armory-operator" >}}) has been deprecated and is considered EOL. Please migrate to the [Kustomize]({{< ref "armory-operator-to-kustomize-migration" >}}) method of deployment.
{{% /alert %}}

To install, upgrade, or configure Armory CD 2.42.0, use Armory Operator 1.8.6 or later.

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

### Clouddriver: namespace allow-list and artifact account URL restrictions
- Kubernetes: the namespace allow-list is now enforced when a request omits the namespace. A missing namespace is treated as `default`, so requests that relied on an omitted namespace can be rejected if `default` isn't allowed for the account ([#7998](https://github.com/spinnaker/spinnaker/pull/7998)).
- Artifact accounts that use credentials must set `urlRestrictions.allowedDomains`. The restrictions check every address a hostname resolves to ([#8171](https://github.com/spinnaker/spinnaker/pull/8171), [#8099](https://github.com/spinnaker/spinnaker/pull/8099)).

### Clouddriver: removed configuration, providers, and classes
- `redis.scheduler: sort` and `redis.parallelism` are removed ([#8073](https://github.com/spinnaker/spinnaker/pull/8073)).
- The Titus ([#8095](https://github.com/spinnaker/spinnaker/pull/8095)) and Yandex ([#8186](https://github.com/spinnaker/spinnaker/pull/8186)) providers are removed.
- `awsobjectmapper` is removed, which drops AWS SDK v1 ([#8020](https://github.com/spinnaker/spinnaker/pull/8020), [#8038](https://github.com/spinnaker/spinnaker/pull/8038)), and `ProviderCacheConfiguration` is deleted ([#8106](https://github.com/spinnaker/spinnaker/pull/8106)). Rebuild custom plugins that use them.
- The default `kubectl` is now 1.36. Versions 1.30 through 1.37 are bundled ([#8183](https://github.com/spinnaker/spinnaker/pull/8183)).

### Keel: Titus resources are deleted on first startup
The Keel migration for the Titus removal permanently deletes Titus resources on first startup ([#8095](https://github.com/spinnaker/spinnaker/pull/8095)). Back up the database before upgrading.

### Orca: Jenkins task classes renamed
The Jenkins task classes are renamed to the generic `*BuildJobTask` names ([#8205](https://github.com/spinnaker/spinnaker/pull/8205)). Update custom plugins or stage definitions that reference the old class names.

### Fiat: upgrade clients before Fiat
Fiat clients must be upgraded before Fiat. Upgrade the clients to Spinnaker 2026.3.2 or 2026.2.5 first, or upgrade services one at a time with Gate first and Fiat last ([#8253](https://github.com/spinnaker/spinnaker/pull/8253)).

### Gate: GitHub organization check needs `read:org`
The GitHub organization check now needs the `read:org` scope and organization approval of the OAuth app ([#8187](https://github.com/spinnaker/spinnaker/pull/8187)). Remove the `include-private-memberships` flag from your `gate-local.yml`, because it's no longer used.

### Igor: Jackson date serialization setting fails startup
Igor fails to start if `spring.jackson.serialization.write_dates_as_timestamps` is set. Remove the setting.

### Kayenta and Deck: upgrade together
Kayenta and Deck must be upgraded together for the unified canary `template` field ([#7900](https://github.com/spinnaker/spinnaker/pull/7900)). The guided canary forms are deprecated and will be removed after Spinnaker 2027.1.x.

### Spring Boot 4 and Jackson 3
Spinnaker services moved to Spring Boot 4.1.1 ([#7996](https://github.com/spinnaker/spinnaker/pull/7996)). Jackson 3 changes some configuration keys, and empty `{}` blocks now bind as empty values. Delete empty blocks from your service configuration and review any `spring.jackson.*` keys. Rebuild custom plugins against this release.

### UI: Deck build tooling moved to Vite
Deck builds use Vite 7 instead of Webpack and Rollup ([#8118](https://github.com/spinnaker/spinnaker/pull/8118), [#8119](https://github.com/spinnaker/spinnaker/pull/8119)), and tests use Vitest and React Testing Library ([#8121](https://github.com/spinnaker/spinnaker/pull/8121), [#8124](https://github.com/spinnaker/spinnaker/pull/8124)). Migrate Deck plugins to `vite.config.js` and `@spinnaker/scripts`.

### kork-stackdriver metrics push removed
The kork-stackdriver metrics push is removed ([#8107](https://github.com/spinnaker/spinnaker/pull/8107)).

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

### Clouddriver: new capabilities

- Opt-in native ECS deployments ([#8210](https://github.com/spinnaker/spinnaker/pull/8210)).
- Provenance annotations on deployed Kubernetes resources ([#8100](https://github.com/spinnaker/spinnaker/pull/8100)) and custom resource health ([#8102](https://github.com/spinnaker/spinnaker/pull/8102)).
- Label selectors for artifact lookups ([#8045](https://github.com/spinnaker/spinnaker/pull/8045)), Gitea artifacts ([#8153](https://github.com/spinnaker/spinnaker/pull/8153)), and Fiat permissions for artifact accounts ([#7892](https://github.com/spinnaker/spinnaker/pull/7892)).
- AWS connection-tracking timeouts ([#8104](https://github.com/spinnaker/spinnaker/pull/8104)), ECS monitoring configuration ([#8048](https://github.com/spinnaker/spinnaker/pull/8048), [#8049](https://github.com/spinnaker/spinnaker/pull/8049)), and region-aware AWS bootstrap ([#8132](https://github.com/spinnaker/spinnaker/pull/8132)).
- GCP regional external load balancers ([#7749](https://github.com/spinnaker/spinnaker/pull/7749)).

### Pipelines: GitLab CI stage and Orca improvements

- A GitLab CI stage ([#8222](https://github.com/spinnaker/spinnaker/pull/8222)). Igor forwards trigger variables to GitLab CI ([#8259](https://github.com/spinnaker/spinnaker/pull/8259)).
- Opt-in hyphenated SpEL variables ([#7983](https://github.com/spinnaker/spinnaker/pull/7983)).
- Stage metric tags ([#8005](https://github.com/spinnaker/spinnaker/pull/8005)) and a metric for system errors when starting executions ([#8140](https://github.com/spinnaker/spinnaker/pull/8140)).
- Pipeline search can include deleted pipelines with `includeDeletedPipelines` ([#8027](https://github.com/spinnaker/spinnaker/pull/8027)).

### Echo: Gitea webhooks

Echo handles Gitea webhooks ([#8153](https://github.com/spinnaker/spinnaker/pull/8153)). Git webhook artifacts are derived only from the webhook payload ([#8171](https://github.com/spinnaker/spinnaker/pull/8171)).

### Gate: sign-in page, MCP, and webhooks

- A branded sign-in page for basic auth and LDAP ([#8084](https://github.com/spinnaker/spinnaker/pull/8084), [#8212](https://github.com/spinnaker/spinnaker/pull/8212)).
- The MCP tool allow-list ([#8184](https://github.com/spinnaker/spinnaker/pull/8184)) and an MCP startup fix ([#7987](https://github.com/spinnaker/spinnaker/pull/7987)).
- Webhooks forward headers and the raw body ([#8160](https://github.com/spinnaker/spinnaker/pull/8160)).

### Fiat: artifact accounts and performance

Artifact accounts are a Fiat resource ([#7892](https://github.com/spinnaker/spinnaker/pull/7892)). Role syncs are faster ([#8093](https://github.com/spinnaker/spinnaker/pull/8093), [#8136](https://github.com/spinnaker/spinnaker/pull/8136), [#8137](https://github.com/spinnaker/spinnaker/pull/8137)), and the new `fiat.redis.repository` settings let Fiat skip unchanged writes. `MOST_SPECIFIC` prefix resolution no longer depends on order ([#8261](https://github.com/spinnaker/spinnaker/pull/8261)).

### Front50: pipeline save concurrency check

The `staleCheck` optimistic-concurrency check on pipeline saves is fixed ([#8022](https://github.com/spinnaker/spinnaker/pull/8022)). It's off by default behind a flag, and `spin` opts in ([#8023](https://github.com/spinnaker/spinnaker/pull/8023)).

### UI: dark theme and manifest views

- A dark theme ([#8194](https://github.com/spinnaker/spinnaker/pull/8194)).
- Brotli and gzip compression for assets ([#8175](https://github.com/spinnaker/spinnaker/pull/8175)).
- Pipelines can be discovered by project tag ([#7934](https://github.com/spinnaker/spinnaker/pull/7934)).
- Manifest names appear in Deploy status ([#8044](https://github.com/spinnaker/spinnaker/pull/8044)), load balancers have copy-to-clipboard and FQDN ([#8094](https://github.com/spinnaker/spinnaker/pull/8094)), and stored manifests render as YAML ([#8025](https://github.com/spinnaker/spinnaker/pull/8025), [#8156](https://github.com/spinnaker/spinnaker/pull/8156)).

### Platform

- Spinnaker builds with Java 25 ([#8014](https://github.com/spinnaker/spinnaker/pull/8014)).
- A SQL-backed artifact store ([#8000](https://github.com/spinnaker/spinnaker/pull/8000)) and a Redis-backed pub/sub foundation ([#8031](https://github.com/spinnaker/spinnaker/pull/8031)).
- Per-service CycloneDX SBOMs, starting with Clouddriver ([#8019](https://github.com/spinnaker/spinnaker/pull/8019)).

### Fixed issues

- Clouddriver: task store reliability ([#8130](https://github.com/spinnaker/spinnaker/pull/8130), [#8172](https://github.com/spinnaker/spinnaker/pull/8172), [#8173](https://github.com/spinnaker/spinnaker/pull/8173), [#8111](https://github.com/spinnaker/spinnaker/pull/8111), [#8129](https://github.com/spinnaker/spinnaker/pull/8129), [#8110](https://github.com/spinnaker/spinnaker/pull/8110), [#8154](https://github.com/spinnaker/spinnaker/pull/8154)), AWS SDK v2 caching ([#8141](https://github.com/spinnaker/spinnaker/pull/8141), [#8163](https://github.com/spinnaker/spinnaker/pull/8163)), ECS ([#8196](https://github.com/spinnaker/spinnaker/pull/8196), [#8052](https://github.com/spinnaker/spinnaker/pull/8052), [#7960](https://github.com/spinnaker/spinnaker/pull/7960)), Google retries and caching ([#8280](https://github.com/spinnaker/spinnaker/pull/8280), [#8281](https://github.com/spinnaker/spinnaker/pull/8281), [#8061](https://github.com/spinnaker/spinnaker/pull/8061)), Kubernetes caching ([#8054](https://github.com/spinnaker/spinnaker/pull/8054), [#8059](https://github.com/spinnaker/spinnaker/pull/8059)), and full cache eviction across providers ([#8062](https://github.com/spinnaker/spinnaker/pull/8062) through [#8072](https://github.com/spinnaker/spinnaker/pull/8072), [#8083](https://github.com/spinnaker/spinnaker/pull/8083)).
- Orca: the queue-ack race ([#7919](https://github.com/spinnaker/spinnaker/pull/7919)), Redis retry handling ([#8002](https://github.com/spinnaker/spinnaker/pull/8002)), pipeline trigger search pagination and filters ([#8026](https://github.com/spinnaker/spinnaker/pull/8026)), execution status and cancellation ([#8174](https://github.com/spinnaker/spinnaker/pull/8174), [#8208](https://github.com/spinnaker/spinnaker/pull/8208), [#8211](https://github.com/spinnaker/spinnaker/pull/8211)), Retrofit2 gaps ([#8144](https://github.com/spinnaker/spinnaker/pull/8144)), SQL connection reuse ([#8236](https://github.com/spinnaker/spinnaker/pull/8236)), and foreign-partition checks ([#8135](https://github.com/spinnaker/spinnaker/pull/8135)). Stored manifest references keep their kind, name, and namespace ([#7999](https://github.com/spinnaker/spinnaker/pull/7999)).
- Echo: null type/schema ([#8235](https://github.com/spinnaker/spinnaker/pull/8235)), cron compensation ([#8221](https://github.com/spinnaker/spinnaker/pull/8221)), the SQS subscriber ([#8220](https://github.com/spinnaker/spinnaker/pull/8220)), and the telemetry version ([#7966](https://github.com/spinnaker/spinnaker/pull/7966)). Echo compares GitHub signatures in constant time ([#8162](https://github.com/spinnaker/spinnaker/pull/8162)).
- Igor: build property parsing ([#8278](https://github.com/spinnaker/spinnaker/pull/8278)), and Jenkins 303 already-queued redirects are accepted ([#8105](https://github.com/spinnaker/spinnaker/pull/8105)).
- Rosco: bake polling continues after an error ([#8217](https://github.com/spinnaker/spinnaker/pull/8217)), and the Ubuntu image has a writable home directory ([#7967](https://github.com/spinnaker/spinnaker/pull/7967)).
- Fiat: GitHub App role sync ([#8224](https://github.com/spinnaker/spinnaker/pull/8224), [#8229](https://github.com/spinnaker/spinnaker/pull/8229)).
- Front50: the plugin binary cache ([#8262](https://github.com/spinnaker/spinnaker/pull/8262)) and cache refresh ([#8228](https://github.com/spinnaker/spinnaker/pull/8228)).
- Kayenta: DataSource auto-configuration exclusion ([#8252](https://github.com/spinnaker/spinnaker/pull/8252)) and GCS prefix collisions ([#8282](https://github.com/spinnaker/spinnaker/pull/8282), [#8285](https://github.com/spinnaker/spinnaker/pull/8285)).
- UI: manifest editor clipping ([#7920](https://github.com/spinnaker/spinnaker/pull/7920)), the deployment details link ([#8004](https://github.com/spinnaker/spinnaker/pull/8004)), the Formik manifest selector ([#8213](https://github.com/spinnaker/spinnaker/pull/8213)), pipeline editor sync ([#8202](https://github.com/spinnaker/spinnaker/pull/8202)), Run Pipeline parameters ([#8128](https://github.com/spinnaker/spinnaker/pull/8128)), hidden SpEL in deployment targets ([#8003](https://github.com/spinnaker/spinnaker/pull/8003)), stale `index.html` and settings ([#8263](https://github.com/spinnaker/spinnaker/pull/8263)), performance with many accounts ([#8273](https://github.com/spinnaker/spinnaker/pull/8273)), graceful Apache stop ([#8288](https://github.com/spinnaker/spinnaker/pull/8288)), and `virtualizationType` case sensitivity ([#7973](https://github.com/spinnaker/spinnaker/pull/7973)).

###  Spinnaker community contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker 2026.4.0](https://www.spinnaker.io/changelogs/2026.4.0-changelog/) changelog for details.

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
    commit: 860376dd717717b0861d4ba1844f09540ed8a5c1
    version: 2.42.0
  deck:
    commit: 860376dd717717b0861d4ba1844f09540ed8a5c1
    version: 2.42.0
  dinghy:
    commit: 18d8ca386dd06e1b82df2be8523768a7fa7a5e57
    version: 2.42.0
  echo:
    commit: 860376dd717717b0861d4ba1844f09540ed8a5c1
    version: 2.42.0
  fiat:
    commit: 860376dd717717b0861d4ba1844f09540ed8a5c1
    version: 2.42.0
  front50:
    commit: 860376dd717717b0861d4ba1844f09540ed8a5c1
    version: 2.42.0
  gate:
    commit: 860376dd717717b0861d4ba1844f09540ed8a5c1
    version: 2.42.0
  igor:
    commit: 860376dd717717b0861d4ba1844f09540ed8a5c1
    version: 2.42.0
  kayenta:
    commit: 860376dd717717b0861d4ba1844f09540ed8a5c1
    version: 2.42.0
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 860376dd717717b0861d4ba1844f09540ed8a5c1
    version: 2.42.0
  rosco:
    commit: 860376dd717717b0861d4ba1844f09540ed8a5c1
    version: 2.42.0
  terraformer:
    commit: 16a62864783126d5c7413fb08a97e2ffc2894d31
    version: 2.42.0
timestamp: "2026-11-23 15:23:05"
version: 2.42.0
</code>
</pre>
</details>

### Armory


#### Armory Gate - 2.41.0...2.42.0


#### Armory Igor - 2.41.0...2.42.0


#### Armory Kayenta - 2.41.0...2.42.0


#### Armory Orca - 2.41.0...2.42.0


#### Armory Terraformer - 2.41.0...2.42.0


#### Armory Dinghy - 2.41.0...2.42.0


#### Armory Rosco - 2.41.0...2.42.0


#### Armory Clouddriver - 2.41.0...2.42.0


#### Armory Deck - 2.41.0...2.42.0


#### Armory Echo - 2.41.0...2.42.0


#### Armory Fiat - 2.41.0...2.42.0


#### Armory Front50 - 2.41.0...2.42.0



### Spinnaker


#### Spinnaker Gate - 1.42.0


#### Spinnaker Igor - 1.42.0


#### Spinnaker Kayenta - 1.42.0


#### Spinnaker Orca - 1.42.0


#### Spinnaker Terraformer - 1.42.0


#### Spinnaker Dinghy - 1.42.0


#### Spinnaker Rosco - 1.42.0


#### Spinnaker Clouddriver - 1.42.0


#### Spinnaker Deck - 1.42.0


#### Spinnaker Echo - 1.42.0


#### Spinnaker Fiat - 1.42.0


#### Spinnaker Front50 - 1.42.0


