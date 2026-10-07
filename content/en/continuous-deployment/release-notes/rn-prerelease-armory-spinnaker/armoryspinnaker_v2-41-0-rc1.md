---
title: v2.41.0-rc1 Armory Continuous Deployment Release (Spinnaker™ 2026.3.x)
toc_hide: true
date: 2026-09-10
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
description: >
  Release notes for Armory Continuous Deployment v2.41.0-rc1. A beta release is not meant for installation in production environments.

---

## 2026/09/10 release notes

## Disclaimer

This pre-release software is to allow limited access to test or beta versions of the Armory services (“Services”) and to provide feedback and comments to Armory regarding the use of such Services. By using Services, you agree to be bound by the terms and conditions set forth herein.

Your Feedback is important and we welcome any feedback, analysis, suggestions and comments (including, but not limited to, bug reports and test results) (collectively, “Feedback”) regarding the Services. Any Feedback you provide will become the property of Armory and you agree that Armory may use or otherwise exploit all or part of your feedback or any derivative thereof in any manner without any further remuneration, compensation or credit to you. You represent and warrant that any Feedback which is provided by you hereunder is original work made solely by you and does not infringe any third party intellectual property rights.

Any Feedback provided to Armory shall be considered Armory Confidential Information and shall be covered by any confidentiality agreements between you and Armory.

You acknowledge that you are using the Services on a purely voluntary basis, as a means of assisting, and in consideration of the opportunity to assist Armory to use, implement, and understand various facets of the Services. You acknowledge and agree that nothing herein or in your voluntary submission of Feedback creates any employment relationship between you and Armory.

Armory may, in its sole discretion, at any time, terminate or discontinue all or your access to the Services. You acknowledge and agree that all such decisions by Armory are final and Armory will have no liability with respect to such decisions.

YOUR USE OF THE SERVICES IS AT YOUR OWN RISK. THE SERVICES, THE ARMORY TOOLS AND THE CONTENT ARE PROVIDED ON AN “AS IS” BASIS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED. ARMORY AND ITS LICENSORS MAKE NO REPRESENTATION, WARRANTY, OR GUARANTY AS TO THE RELIABILITY, TIMELINESS, QUALITY, SUITABILITY, TRUTH, AVAILABILITY, ACCURACY OR COMPLETENESS OF THE SERVICES, THE ARMORY TOOLS OR ANY CONTENT. ARMORY EXPRESSLY DISCLAIMS ON ITS OWN BEHALF AND ON BEHALF OF ITS EMPLOYEES, AGENTS, ATTORNEYS, CONSULTANTS, OR CONTRACTORS ANY AND ALL WARRANTIES INCLUDING, WITHOUT LIMITATION (A) THE USE OF THE SERVICES OR THE ARMORY TOOLS WILL BE TIMELY, UNINTERRUPTED OR ERROR-FREE OR OPERATE IN COMBINATION WITH ANY OTHER HARDWARE, SOFTWARE, SYSTEM OR DATA, (B) THE SERVICES AND THE ARMORY TOOLS AND/OR THEIR QUALITY WILL MEET CUSTOMER”S REQUIREMENTS OR EXPECTATIONS, (C) ANY CONTENT WILL BE ACCURATE OR RELIABLE, (D) ERRORS OR DEFECTS WILL BE CORRECTED, OR (E) THE SERVICES, THE ARMORY TOOLS OR THE SERVER(S) THAT MAKE THE SERVICES AVAILABLE ARE FREE OF VIRUSES OR OTHER HARMFUL COMPONENTS. CUSTOMER AGREES THAT ARMORY SHALL NOT BE RESPONSIBLE FOR THE AVAILABILITY OR ACTS OR OMISSIONS OF ANY THIRD PARTY, INCLUDING ANY THIRD-PARTY APPLICATION OR PRODUCT, AND ARMORY HEREBY DISCLAIMS ANY AND ALL LIABILITY IN CONNECTION WITH SUCH THIRD PARTIES.

IN NO EVENT SHALL ARMORY, ITS EMPLOYEES, AGENTS, ATTORNEYS, CONSULTANTS, OR CONTRACTORS BE LIABLE UNDER THIS AGREEMENT FOR ANY CONSEQUENTIAL, SPECIAL, LOST PROFITS, INDIRECT OR OTHER DAMAGES, INCLUDING BUT NOT LIMITED TO LOST PROFITS, LOSS OF BUSINESS, COST OF COVER WHETHER BASED IN CONTRACT, TORT (INCLUDING NEGLIGENCE), OR OTHERWISE, EVEN IF ARMORY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES AND NOTWITHSTANDING ANY FAILURE OF ESSENTIAL PURPOSE OF ANY LIMITED REMEDY. IN ANY EVENT, ARMORY, ITS EMPLOYEES’, AGENTS’, ATTORNEYS’, CONSULTANTS’ OR CONTRACTORS’ AGGREGATE LIABILITY UNDER THIS AGREEMENT FOR ANY CLAIM SHALL BE STRICTLY LIMITED TO $100.00. SOME STATES DO NOT ALLOW THE LIMITATION OR EXCLUSION OF LIABILITY FOR INCIDENTAL OR CONSEQUENTIAL DAMAGES, SO THE ABOVE LIMITATION OR EXCLUSION MAY NOT APPLY TO YOU.

You acknowledge that Armory has provided the Services in reliance upon the limitations of liability set forth herein and that the same is an essential basis of the bargain between the parties.


{{% alert color="warning" title="Major upgrade" %}}
Armory CD 2.41.0-rc1 moves all AWS integrations to AWS SDK v2, removes Angular from the UI, moves Gate SAML configuration to Spring Security properties, and switches the Google provider to the Compute v1 API. Rebuild and validate custom backend and Deck plugins against 2.41.0; plugins that use removed APIs must be migrated before they can load. Validate this release in a non-production environment and read the [Breaking changes](#breaking-changes) before upgrading.
{{% /alert %}}

## Required Armory Operator version
{{% alert color="warning" title="Important" %}}
[Armory Operator]({{< ref "armory-operator" >}}) has been deprecated and is considered EOL. Please migrate to the [Kustomize]({{< ref "armory-operator-to-kustomize-migration" >}}) method of deployment.
{{% /alert %}}

To install, upgrade, or configure Armory CD 2.41.0-rc1, use Armory Operator 1.8.6 or later.

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

### Fixed issues

- Paging executions by pipeline config ID honors `page` ([#7850](https://github.com/spinnaker/spinnaker/pull/7850)).
- Clouddriver SQL cache: for AWS and ECS, deleting the last resource of a kind now evicts it from the cache ([#8069](https://github.com/spinnaker/spinnaker/pull/8069), [#8072](https://github.com/spinnaker/spinnaker/pull/8072)).
- Dynamic account loading no longer races ([#7791](https://github.com/spinnaker/spinnaker/pull/7791)).
- Regressions from the AWS SDK v2 migration: server group creation times shown as 1970 ([#8141](https://github.com/spinnaker/spinnaker/pull/8141)), ECS clusters returning 400 or losing task-definition fields from the cache ([#7898](https://github.com/spinnaker/spinnaker/pull/7898), [#7899](https://github.com/spinnaker/spinnaker/pull/7899), [#7901](https://github.com/spinnaker/spinnaker/pull/7901)), and ASG clone and Lambda-only application errors ([#7952](https://github.com/spinnaker/spinnaker/pull/7952)).

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
    commit: a844d8f06e9838d30e1f4403ee447ed8f275b610
    version: 2.41.0-rc1
  deck:
    commit: a844d8f06e9838d30e1f4403ee447ed8f275b610
    version: 2.41.0-rc1
  dinghy:
    commit: f22d5925ee1d282a725a5926317f40ff76b1d742
    version: 2.41.0-rc1
  echo:
    commit: a844d8f06e9838d30e1f4403ee447ed8f275b610
    version: 2.41.0-rc1
  fiat:
    commit: a844d8f06e9838d30e1f4403ee447ed8f275b610
    version: 2.41.0-rc1
  front50:
    commit: a844d8f06e9838d30e1f4403ee447ed8f275b610
    version: 2.41.0-rc1
  gate:
    commit: a844d8f06e9838d30e1f4403ee447ed8f275b610
    version: 2.41.0-rc1
  igor:
    commit: a844d8f06e9838d30e1f4403ee447ed8f275b610
    version: 2.41.0-rc1
  kayenta:
    commit: a844d8f06e9838d30e1f4403ee447ed8f275b610
    version: 2.41.0-rc1
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: a844d8f06e9838d30e1f4403ee447ed8f275b610
    version: 2.41.0-rc1
  rosco:
    commit: a844d8f06e9838d30e1f4403ee447ed8f275b610
    version: 2.41.0-rc1
  terraformer:
    commit: 789d7eaeb20ddd2544efad606ce885ff1424d34d
    version: 2.41.0-rc1
timestamp: "2026-09-10 13:45:50"
version: 2.41.0-rc1
</code>
</pre>
</details>

### Armory

#### Armory Clouddriver - 2.40.0...2.41.0-rc1

- feat(k8s-custom-resource-plugin): include the Kubernetes custom resource status extension
- fix(armory-agent): fix Armory Agent compatibility

#### Armory Deck - 2.40.0...2.41.0-rc1

#### Armory Dinghy - 2.40.0...2.41.0-rc1

#### Armory Echo - 2.40.0...2.41.0-rc1

- feat(event filter): built-in event filter (`armory.event-filter`)
- fix(webhooks): prevent response-wrapper deserialization failures when forwarding Armory webhooks

#### Armory Fiat - 2.40.0...2.41.0-rc1

#### Armory Front50 - 2.40.0...2.41.0-rc1

#### Armory Gate - 2.40.0...2.41.0-rc1

- fix(policy-engine): deserialize OPA authorization responses without a `message`

#### Armory Igor - 2.40.0...2.41.0-rc1

#### Armory Kayenta - 2.40.0...2.41.0-rc1

#### Armory Orca - 2.40.0...2.41.0-rc1

#### Armory Rosco - 2.40.0...2.41.0-rc1

- feat(packer): add Kustomize 5 and bump Packer and Helmfile
- fix(packer): install the Amazon, Azure, and Google Compute Packer plugins in the image

#### Armory Terraformer - 2.40.0...2.41.0-rc1

- fix(terraformer): prevent concurrent log reads from racing with command output and returning empty output
- fix(terraformer): defensive operation on large repo extraction

#### Armory deployment profiles

- feat(profiles): add Halconfig profiles for every packaged service

### Spinnaker

<!-- Generated from upstream/release-2026.3.x 61d833eee3..ad8ddfeb8b minus PRs backported to release-2026.2.x. CI, test,
     and dependency-bot commits are omitted. A PR touching several services appears under each one. -->

#### Spin CLI

- fix(spin): send Bearer token on all API requests when using oauth2 auth ([#7918](https://github.com/spinnaker/spinnaker/pull/7918))
- feat(spin): Add ApiToken support to the spin cli ([#7782](https://github.com/spinnaker/spinnaker/pull/7782))

#### Spinnaker Clouddriver - 2026.3.x

- fix(clouddriver): cache AWS SDK v2 timestamps as epoch millis ([#8141](https://github.com/spinnaker/spinnaker/pull/8141))
- chore(aws): Allow aws init calls to be made based on accounts region ([#8132](https://github.com/spinnaker/spinnaker/pull/8132))
- fix(aws): support full cache eviction to fix stale-cache bug ([#8069](https://github.com/spinnaker/spinnaker/pull/8069))
- fix(ecs): opt in to full cache eviction and delete redundant manual eviction ([#8072](https://github.com/spinnaker/spinnaker/pull/8072))
- fix(rosco): create writable home dir for spinnaker system user in Dockerfile.ubuntu ([#7967](https://github.com/spinnaker/spinnaker/pull/7967))
- fix(clouddriver): Fix UnsupportedOperationException/NullPointerException regressions from AWS SDK v2 migration ([#7952](https://github.com/spinnaker/spinnaker/pull/7952))
- chore(aws): Flip credentials to AWS SDK v2 and remove aws-java-sdk (v1) entirely ([#7944](https://github.com/spinnaker/spinnaker/pull/7944))
- feat(aws): migrate remaining v1 EC2/AutoScaling client calls to SDK v2 ([#7942](https://github.com/spinnaker/spinnaker/pull/7942))
- chore(aws): remove Edda dynamic-proxy client and credential/config plumbing ([#7941](https://github.com/spinnaker/spinnaker/pull/7941))
- chore(aws): Migrate Route53 to AWS SDK v2 ([#7939](https://github.com/spinnaker/spinnaker/pull/7939))
- chore(aws): Migrate S3 to AWS SDK v2 ([#7938](https://github.com/spinnaker/spinnaker/pull/7938))
- chore(aws): Migrate CloudWatch alarms and AutoScaling scaling policies to AWS SDK v2 ([#7937](https://github.com/spinnaker/spinnaker/pull/7937))
- chore(aws): Migrate remaining v1 ELB client usage in ASG atomic operations to SDK v2 ([#7936](https://github.com/spinnaker/spinnaker/pull/7936))
- chore(aws): Migrate rest of services to SDKv2 ([#7933](https://github.com/spinnaker/spinnaker/pull/7933))
- chore(aws): Migrate ELB classic + ELBv2 to AWS SDK v2 ([#7932](https://github.com/spinnaker/spinnaker/pull/7932))
- chore(titus): Migrate remaining v1 AWS SDK model type usage to SDK v2 ([#7930](https://github.com/spinnaker/spinnaker/pull/7930))
- chore(aws): Migrate AutoScaling client and ASG/AutoScaling caching agents to AWS SDK v2 ([#7929](https://github.com/spinnaker/spinnaker/pull/7929))
- chore(ecs): Migrate remaining v1 EC2 SDK model type usage to SDK v2 ([#7931](https://github.com/spinnaker/spinnaker/pull/7931))
- chore(aws): Migrate EC2 client and EC2-only caching agents to AWS SDK v2 ([#7928](https://github.com/spinnaker/spinnaker/pull/7928))
- chore(aws): More sdkv2 migration stuff.  A few calls that didn't need the SDK v2 stuff. ([#7923](https://github.com/spinnaker/spinnaker/pull/7923))
- chore(aws): Migrate most of ECS to SDKv2 ([#7925](https://github.com/spinnaker/spinnaker/pull/7925))
- chore(aws): Migrate secrets and config server off of v1 sdk.  Also remove "dead" bastion configurations ([#7922](https://github.com/spinnaker/spinnaker/pull/7922))
- chore(aws): Lambda migration to AWS SDK v2 ([#7924](https://github.com/spinnaker/spinnaker/pull/7924))
- feat(clouddriver-aws): migrate SNS, SQS, SWF, Support, CloudFormation to AWS SDK v2 ([#7903](https://github.com/spinnaker/spinnaker/pull/7903))
- feat(ecs): migrate atomic operations and scalable targets to AWS SDK v2 ([#7896](https://github.com/spinnaker/spinnaker/pull/7896))
- feat(artifacts): support GitHub App authentication for git/repo and github/file artifact accounts ([#7897](https://github.com/spinnaker/spinnaker/pull/7897))
- feat(provider/google, deck/google): GCE Compute v1 migration and instance flexibility policy ([#7510](https://github.com/spinnaker/spinnaker/pull/7510))
- feat(ecs): migrate TargetHealthCachingAgent to AWS SDK v2 ELBv2 ([#7895](https://github.com/spinnaker/spinnaker/pull/7895))
- fix(ecs): re-describe task definitions cached in a degraded form ([#7901](https://github.com/spinnaker/spinnaker/pull/7901))
- fix(ecs): stop dropping fields when reading cached task definitions ([#7899](https://github.com/spinnaker/spinnaker/pull/7899))
- fix(ecs): read cached task containers with the SDK v2 model ([#7898](https://github.com/spinnaker/spinnaker/pull/7898))
- feat(ecs): migrate ECS core agents to AWS SDK v2 EcsClient ([#7759](https://github.com/spinnaker/spinnaker/pull/7759))
- feat(aws): Warm pool support ([#7852](https://github.com/spinnaker/spinnaker/pull/7852))
- feat(accounts): Add a UI to help with adding/removing accounts ([#7799](https://github.com/spinnaker/spinnaker/pull/7799))
- chore(lambda): Migrate from v1 to v2 aws sdk ([#7827](https://github.com/spinnaker/spinnaker/pull/7827))
- fix(deck): restore regressions after Angular removal ([#7832](https://github.com/spinnaker/spinnaker/pull/7832))
- feat(cloudfoundry): migrate RouteService and ConfigService from v2 to v3 API ([#7800](https://github.com/spinnaker/spinnaker/pull/7800))
- feat(cats): Concept for a pub/sub scheduler. ([#7399](https://github.com/spinnaker/spinnaker/pull/7399))
- feat(gradle): Upgrade to gradle 9 (bumps kotlin to 2.1 release) ([#7790](https://github.com/spinnaker/spinnaker/pull/7790))
- feat(kubernetes): Bump SDK and tests to remove OLD kubernetes support.  Removes some long dead API response handling and manifest handling ([#7802](https://github.com/spinnaker/spinnaker/pull/7802))
- fix(accounts): Fix a race condition on dynamic accounts loading ([#7791](https://github.com/spinnaker/spinnaker/pull/7791))

#### Spinnaker Deck - 2026.3.x

- fix(deck): Case-insensitve on virtualizationType comparison ([#7973](https://github.com/spinnaker/spinnaker/pull/7973))
- fix(deck): scope rxjs override so lerna publish doesn't crash ([#7972](https://github.com/spinnaker/spinnaker/pull/7972))
- fix(amazon): fix AMI selection in Create Server Group image picker ([#7965](https://github.com/spinnaker/spinnaker/pull/7965))
- fix(ecs): populate imageId when scoping docker image find by account ([#7964](https://github.com/spinnaker/spinnaker/pull/7964))
- fix(deck): Instance types response filtering case-mismatch ([#7963](https://github.com/spinnaker/spinnaker/pull/7963))
- fix(ecs): fix Create Server Group crash on ECS applications ([#7961](https://github.com/spinnaker/spinnaker/pull/7961))
- fix(ui): fix crash in CreatableSelect when used as a single-value select ([#7962](https://github.com/spinnaker/spinnaker/pull/7962))
- fix(appengine): restore dropped fields on server group stages ([#7957](https://github.com/spinnaker/spinnaker/pull/7957))
- fix(oracle): restore all pipeline stage config fields dropped by Angular removal ([#7958](https://github.com/spinnaker/spinnaker/pull/7958))
- fix(google): restore Platform Health Override on disable/enable server group stages ([#7956](https://github.com/spinnaker/spinnaker/pull/7956))
- fix(amazon): restore pipeline stage config fields dropped by Angular removal ([#7955](https://github.com/spinnaker/spinnaker/pull/7955))
- fix(ui): Fix two UI bugs, one on aws bake stage handling, one on new accounts UI styling ([#7954](https://github.com/spinnaker/spinnaker/pull/7954))
- chore(aws): remove Edda dynamic-proxy client and credential/config plumbing ([#7941](https://github.com/spinnaker/spinnaker/pull/7941))
- feat(kayenta): Add clickhouse as a canary provider ([#7911](https://github.com/spinnaker/spinnaker/pull/7911))
- feat(deck): Add org/repo/path URL builder for git file artifacts ([#7916](https://github.com/spinnaker/spinnaker/pull/7916))
- feat(provider/google, deck/google): GCE Compute v1 migration and instance flexibility policy ([#7510](https://github.com/spinnaker/spinnaker/pull/7510))
- feat(helmfile): Adds the ability to use artifacts as helmfile overrides ([8db2ef0](https://github.com/spinnaker/spinnaker/commit/8db2ef0fef))
- feat(helmfile): Expose environment and namespace arguments.  Add some validation around them and helper text ([#7890](https://github.com/spinnaker/spinnaker/pull/7890))
- chore(deck): update dependencies ([#7879](https://github.com/spinnaker/spinnaker/pull/7879))
- feat(aws): Warm pool support ([#7852](https://github.com/spinnaker/spinnaker/pull/7852))
- feat(accounts): Add a UI to help with adding/removing accounts ([#7799](https://github.com/spinnaker/spinnaker/pull/7799))
- feat(orca/deck): add runMultiplePipelines stage from Armory multiple-pipelines plugin ([#7803](https://github.com/spinnaker/spinnaker/pull/7803))
- feat(evaluateArtifacts): Add evaluateArtifacts stage - SpeL enabled embdedded artifacts ([#7845](https://github.com/spinnaker/spinnaker/pull/7845))
- refactor(deck): remove Angular ([#7848](https://github.com/spinnaker/spinnaker/pull/7848))
- refactor(deck): delete dead Angular production graph ([#7847](https://github.com/spinnaker/spinnaker/pull/7847))
- refactor(deck): remove Angular reactive and modal facades ([#7846](https://github.com/spinnaker/spinnaker/pull/7846))
- refactor(deck): remove Angular service facade consumers ([#7842](https://github.com/spinnaker/spinnaker/pull/7842))
- refactor(deck): remove Angular router facade consumers ([#7839](https://github.com/spinnaker/spinnaker/pull/7839))
- refactor(deck): remove ngimport runtime bridge ([#7837](https://github.com/spinnaker/spinnaker/pull/7837))
- refactor(deck): register Core routes directly ([#7836](https://github.com/spinnaker/spinnaker/pull/7836))
- feat(kubernetes): Enable a dynamic timeout on manifest stabilize operations. ([#7804](https://github.com/spinnaker/spinnaker/pull/7804))
- fix(deck): restore regressions after Angular removal ([#7832](https://github.com/spinnaker/spinnaker/pull/7832))
- refactor(deck): replace Angular bootstrap ([#7831](https://github.com/spinnaker/spinnaker/pull/7831))
- refactor(deck): remove Angular-owned UI seams ([#7829](https://github.com/spinnaker/spinnaker/pull/7829))
- refactor(deck): remove React Angular bridges ([#7825](https://github.com/spinnaker/spinnaker/pull/7825))
- feat(logs): Add an autorefresh logs button thing to do logs ([#7820](https://github.com/spinnaker/spinnaker/pull/7820))
- refactor(deck): remove Angular from parts of core ([#7807](https://github.com/spinnaker/spinnaker/pull/7807))
- refactor(deck): remove Angular from app canary ([#7798](https://github.com/spinnaker/spinnaker/pull/7798))
- chore(deck): Update jquery & jquery-ui ([#7808](https://github.com/spinnaker/spinnaker/pull/7808))
- refactor(deck): remove Angular from google ([#7797](https://github.com/spinnaker/spinnaker/pull/7797))
- refactor(deck): remove Angular from ECS ([#7809](https://github.com/spinnaker/spinnaker/pull/7809))
- refactor(deck): remove Angular from amazon ([#7794](https://github.com/spinnaker/spinnaker/pull/7794))
- refactor(deck): remove Angular from titus ([#7796](https://github.com/spinnaker/spinnaker/pull/7796))
- refactor(deck): remove Angular from azure ([#7795](https://github.com/spinnaker/spinnaker/pull/7795))
- refactor(deck/appengine+oracle): remove angular from appengine and oracle ([#7773](https://github.com/spinnaker/spinnaker/pull/7773))
- feat(globalBanners): Adding a Global Banner functionality managed by admins ([#7781](https://github.com/spinnaker/spinnaker/pull/7781))
- refactor(deck): remove angular dependency from dcos and cloudrun ([#7772](https://github.com/spinnaker/spinnaker/pull/7772))
- feat(core): make pipeline-trigger execution dropdown limit configurable ([#7770](https://github.com/spinnaker/spinnaker/pull/7770))
- Remove Angular dependency from Docker/CF/Huawei/Tencent ([#7771](https://github.com/spinnaker/spinnaker/pull/7771))
- feat(deck/kubernetes): remove angular dependency ([#7765](https://github.com/spinnaker/spinnaker/pull/7765))

#### Spinnaker Echo - 2026.3.x

- chore(aws): Migrate secrets and config server off of v1 sdk.  Also remove "dead" bastion configurations ([#7922](https://github.com/spinnaker/spinnaker/pull/7922))
- chore(groovy): Migrate pipeline triggers tests to groovy ([#7894](https://github.com/spinnaker/spinnaker/pull/7894))
- feat(gradle): Upgrade to gradle 9 (bumps kotlin to 2.1 release) ([#7790](https://github.com/spinnaker/spinnaker/pull/7790))
- fix(cdevents): Fix empty cdevents status response issue ([#7818](https://github.com/spinnaker/spinnaker/pull/7818))

#### Spinnaker Fiat - 2026.3.x

- feat(gradle): Upgrade to gradle 9 (bumps kotlin to 2.1 release) ([#7790](https://github.com/spinnaker/spinnaker/pull/7790))

#### Spinnaker Front50 - 2026.3.x

- chore(aws): Flip credentials to AWS SDK v2 and remove aws-java-sdk (v1) entirely ([#7944](https://github.com/spinnaker/spinnaker/pull/7944))
- chore(aws): Migrate secrets and config server off of v1 sdk.  Also remove "dead" bastion configurations ([#7922](https://github.com/spinnaker/spinnaker/pull/7922))
- feat(front50): deprecate non-SQL metadata storage backends ([#7886](https://github.com/spinnaker/spinnaker/pull/7886))
- feat(gradle): Upgrade to gradle 9 (bumps kotlin to 2.1 release) ([#7790](https://github.com/spinnaker/spinnaker/pull/7790))

#### Spinnaker Gate - 2026.3.x

- fix(gate): let JsonHttpMessageConverter hand back raw JSON bodies as String ([#8126](https://github.com/spinnaker/spinnaker/pull/8126))
- fix(gate-mcp): serialize MCP resource results to JSON strings ([#7987](https://github.com/spinnaker/spinnaker/pull/7987))
- feat(mcp): Add a spinnaker native MCP server ([#7910](https://github.com/spinnaker/spinnaker/pull/7910))
- feat(accounts): Add a UI to help with adding/removing accounts ([#7799](https://github.com/spinnaker/spinnaker/pull/7799))
- fix(saml): Restore login URL to allow the old paths to continue to work for now while providing a path forward ([#7833](https://github.com/spinnaker/spinnaker/pull/7833))
- chore(cleanup): Migrate custom saml to spring ([#7826](https://github.com/spinnaker/spinnaker/pull/7826))
- feat(gradle): Upgrade to gradle 9 (bumps kotlin to 2.1 release) ([#7790](https://github.com/spinnaker/spinnaker/pull/7790))
- fix(cdevents): Fix empty cdevents status response issue ([#7818](https://github.com/spinnaker/spinnaker/pull/7818))
- feat(globalBanners): Adding a Global Banner functionality managed by admins ([#7781](https://github.com/spinnaker/spinnaker/pull/7781))

#### Spinnaker Igor - 2026.3.x

- feat(gitlab-ci): Add pipeline trigger, cancel, and StoppableBuildService interface ([#7885](https://github.com/spinnaker/spinnaker/pull/7885))
- feat(gradle): Upgrade to gradle 9 (bumps kotlin to 2.1 release) ([#7790](https://github.com/spinnaker/spinnaker/pull/7790))

#### Spinnaker Kayenta - 2026.3.x

- chore(aws): Migrate S3 to AWS SDK v2 ([#7938](https://github.com/spinnaker/spinnaker/pull/7938))
- feat(kayenta): Add clickhouse as a canary provider ([#7911](https://github.com/spinnaker/spinnaker/pull/7911))
- fix(signalfx): Move from signalfx library to standard retrofit to remove an old dep issue. ([#7893](https://github.com/spinnaker/spinnaker/pull/7893))
- chore(aws): Move kayenta from v1 to v2 of the AWS SDK. ([#7887](https://github.com/spinnaker/spinnaker/pull/7887))
- feat(gradle): Upgrade to gradle 9 (bumps kotlin to 2.1 release) ([#7790](https://github.com/spinnaker/spinnaker/pull/7790))

#### Spinnaker Orca - 2026.3.x

- chore(aws): remove Edda dynamic-proxy client and credential/config plumbing ([#7941](https://github.com/spinnaker/spinnaker/pull/7941))
- chore(aws): Move orca and kork from sdk v1 to v2 ([#7891](https://github.com/spinnaker/spinnaker/pull/7891))
- feat(aws): Warm pool support ([#7852](https://github.com/spinnaker/spinnaker/pull/7852))
- feat(orca/deck): add runMultiplePipelines stage from Armory multiple-pipelines plugin ([#7803](https://github.com/spinnaker/spinnaker/pull/7803))
- fix(orca): honor the page parameter when paging pipeline executions by config id ([#7850](https://github.com/spinnaker/spinnaker/pull/7850))
- feat(orca/igor): make MonitorAwsCodeBuildTask backoffPeriod and timeout configurable ([#7855](https://github.com/spinnaker/spinnaker/pull/7855))
- feat(evaluateArtifacts): Add evaluateArtifacts stage - SpeL enabled embdedded artifacts ([#7845](https://github.com/spinnaker/spinnaker/pull/7845))
- feat(kubernetes): Enable a dynamic timeout on manifest stabilize operations. ([#7804](https://github.com/spinnaker/spinnaker/pull/7804))
- feat(cats): Concept for a pub/sub scheduler. ([#7399](https://github.com/spinnaker/spinnaker/pull/7399))
- feat(gradle): Upgrade to gradle 9 (bumps kotlin to 2.1 release) ([#7790](https://github.com/spinnaker/spinnaker/pull/7790))

#### Spinnaker Rosco - 2026.3.x

- fix(rosco): create writable home dir for spinnaker system user in Dockerfile.ubuntu ([#7967](https://github.com/spinnaker/spinnaker/pull/7967))
- feat(helmfile): Adds the ability to use artifacts as helmfile overrides ([8db2ef0](https://github.com/spinnaker/spinnaker/commit/8db2ef0fef))
- feat(helmfile): Expose environment and namespace arguments.  Add some validation around them and helper text ([#7890](https://github.com/spinnaker/spinnaker/pull/7890))
- feat(gradle): Upgrade to gradle 9 (bumps kotlin to 2.1 release) ([#7790](https://github.com/spinnaker/spinnaker/pull/7790))

#### Spinnaker Kork (shared libraries)

- chore(aws): Flip credentials to AWS SDK v2 and remove aws-java-sdk (v1) entirely ([#7944](https://github.com/spinnaker/spinnaker/pull/7944))
- feat(aws): migrate remaining v1 EC2/AutoScaling client calls to SDK v2 ([#7942](https://github.com/spinnaker/spinnaker/pull/7942))
- chore(aws): Migrate S3 to AWS SDK v2 ([#7938](https://github.com/spinnaker/spinnaker/pull/7938))
- chore(aws): More sdkv2 migration stuff.  A few calls that didn't need the SDK v2 stuff. ([#7923](https://github.com/spinnaker/spinnaker/pull/7923))
- fix(aws): Fix wiring issue with autoconfiguration - changed to a non-autowiring library ([#7927](https://github.com/spinnaker/spinnaker/pull/7927))
- chore(aws): Migrate secrets and config server off of v1 sdk.  Also remove "dead" bastion configurations ([#7922](https://github.com/spinnaker/spinnaker/pull/7922))
- feat(pubsub/aws): migrate kork-pubsub-aws from AWS SDK v1 to v2 ([#7912](https://github.com/spinnaker/spinnaker/pull/7912))
- feat(artifacts): support GitHub App authentication for git/repo and github/file artifact accounts ([#7897](https://github.com/spinnaker/spinnaker/pull/7897))
- feat(provider/google, deck/google): GCE Compute v1 migration and instance flexibility policy ([#7510](https://github.com/spinnaker/spinnaker/pull/7510))
- chore(aws): Move orca and kork from sdk v1 to v2 ([#7891](https://github.com/spinnaker/spinnaker/pull/7891))
- feat(cats): Concept for a pub/sub scheduler. ([#7399](https://github.com/spinnaker/spinnaker/pull/7399))
- fix(accounts): Fix a race condition on dynamic accounts loading ([#7791](https://github.com/spinnaker/spinnaker/pull/7791))
