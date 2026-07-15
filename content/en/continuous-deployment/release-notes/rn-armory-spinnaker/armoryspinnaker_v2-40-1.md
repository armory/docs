---
title: v2.40.1 Armory Continuous Deployment Release Feature (Spinnaker™ v2026.2.2)
toc_hide: true
version: 2.40.1
date: 2026-07-15
description: >
  Release notes for Armory Continuous Deployment v2.40.1.
---

## 2026/07/15 release notes

>Note: If you experience production issues after upgrading Armory Continuous Deployment, roll back to a previous working version and report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version
{{% alert color="warning" title="Important" %}}
[Armory Operator]({{< ref "armory-operator" >}}) has been deprecated and will is considered EOL. Please migrate to the [Kustomize]({{< ref "armory-operator-to-kustomize-migration" >}}) method of deployment.
{{% /alert %}}

To install, upgrade, or configure Armory CD 2.40.1, use Armory Operator 1.8.6 or later.

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

### Spring Boot 3.5 upgrade

Armory CD 2.40.1 upgrades to Spring Boot 3.5, the latest supported release. This is a major upgrade from Spring Boot 3.0 introduced in Armory CD 2.39.0. Plugins built against earlier Spring Boot versions will need to be updated to be compatible with this release.

**Actuator metrics export property changes** (introduced in 2.39.0)

If upgrading from a version prior to 2.39.0, note that the metrics export properties have moved:

| Old Property Prefix | New Property Prefix |
|---------------------|---------------------|
| `management.metrics.export.<product>` | `management.<product>.metrics.export` |

**Gate session data cleanup** (introduced in 2.39.0)

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

### Docker images moved to GHCR

Spinnaker and Armory CD images are no longer published to Google Artifact Registry (GAR). All images now pull from GitHub Container Registry (GHCR) at `ghcr.io/spinnaker/`. Update any allowlists, pull-through mirrors, or image references in your deployment configuration before upgrading.

### Halyard fully deprecated

Halyard is no longer supported and will not receive patches or updates. Migrate to [spinnaker-kustomize](https://github.com/spinnaker/spinnaker-kustomize-patches) or a similar implementation.

### MySQL 8+ now required

Due to recent SQL library upgrades, MySQL 5.7 is no longer supported and will fail on startup. You must be running MySQL 8.0+ or an equivalent MariaDB version before upgrading to Armory CD 2.40.1.

### AWS SDK v1 deprecated

AWS SDK v2 support has been introduced across Spinnaker services. AWS SDK v1 is expected to be removed in an upcoming release. If you have custom implementations using SDK v1, begin migrating to the v2 integrations now.

### EDDA support removed

EDDA is no longer supported and will be removed once the AWS SDK v2 migration is complete. If you rely on EDDA, contact the Spinnaker Slack community before upgrading.

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

## Known issues

No known issues at this time.

## Highlighted updates

### Gate: API token authentication

Spinnaker now supports first-class, revocable API tokens for authenticating programmatic requests against Gate. Tokens are minted, listed, and revoked through a new self-service UI in Deck, persisted in Redis by Gate, and resolved on every inbound request by a dedicated Spring Security chain.

The feature is **off by default**. To enable, add the following to your `gate-local.yml`:

```yaml
api-tokens:
  enabled: true
```

Key capabilities:
- **Per-credential revocation** — revoking one token does not affect other tokens for the same user or service account
- **Bounded lifetime** — user tokens always expire; admin-tunable max lifetimes (90 days for users, 365 days for service accounts by default)
- **IAP-compatible** — tokens use the `X-Spinnaker-Token: spk_…` header, which flows cleanly through GCP IAP
- **Operator observability** — a new `gate.requests` counter tagged with `authType`, `principalKind`, `method`, `statusCode`, and `status`

### ECS: Major performance improvements

ECS caching agents have been migrated to AWS SDK v2 and significantly optimized. Previously, several agents loaded all data for all accounts into memory before filtering. These agents now load only the data relevant to the requested account, significantly reducing memory footprint and database throughput for deployments with large numbers of ECS accounts.

### Microsoft Teams: Jinja template support

The Microsoft Teams notification integration now uses configurable Jinja templates to determine notification payloads, replacing the previously hardcoded message format. Two templates are provided out of the box and can be overridden:

- `event-notification.jinja`
- `pipeline-notification.jinja`

To override with custom templates, set the template path in your `echo-local.yml`:

```yaml
microsoftteams:
  enabled: true
  templatePath: /opt/spinnaker/config/teams-templates
```

**Note:** `status` is now a required field on pipeline notification templates. Users on legacy Outlook webhook endpoints will receive deprecation warnings in logs — see the [migration guide](https://github.com/jasonmcintosh/spinnaker/blob/179e86695004fc8ec6c41ccc5b848a59a2154af1/echo/echo-notifications/src/main/resources/templates/microsoftteams/MIGRATION_GUIDE.md) for details.

### Igor: Jenkins job cancellation

When a Spinnaker pipeline is cancelled, any associated Jenkins job triggered by that pipeline is now also cancelled automatically.

### Webhooks: Stage timeout support

Webhook stages now respect the overridden `stageTimeoutMs` value set on the stage configuration. Previously this value was ignored, causing webhook stages to run until the global timeout elapsed.

### AWS SDK v2: Credentials bridge for non-AWS environments

The AWS SDK v2 credential path now bridges v1 credentials to v2, fixing credential discovery in non-AWS environments such as GKE pods using STS assume-role. Previously the v2 path used `DefaultCredentialsProvider` which could not discover credentials in these environments. All configured v1 `AWSCredentialsProvider` instances (including STS assume-role with token refresh) are now adapted for use by the v2 SDK.

###  Spinnaker community contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker 2026.2.2](https://www.spinnaker.io/changelogs/2026.2.2-changelog/) changelog for details.

Notable upstream changes included in this release span OSS versions 2026.2.0 through 2026.2.2:
- Spring Boot upgraded to 3.5 (latest supported release)
- Gradle 8 upgrade
- UI build system migrated from yarn/npm to pnpm
- ECS caching agents migrated to AWS SDK v2
- API token authentication support added to Gate
- Microsoft Teams Jinja template notifications
- Jenkins job cancellation on pipeline cancel
- Webhook stage timeout now respected
- CVE dependency upgrades (2026.2.2)
- Kayenta stage UI formatting fix (2026.2.2)

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
    commit: e099cb401ee08c956cd23ff1871e2d403263f479
    version: 2.40.1
  deck:
    commit: e099cb401ee08c956cd23ff1871e2d403263f479
    version: 2.40.1
  dinghy:
    commit: e099cb401ee08c956cd23ff1871e2d403263f479
    version: 2.40.1
  echo:
    commit: e099cb401ee08c956cd23ff1871e2d403263f479
    version: 2.40.1
  fiat:
    commit: e099cb401ee08c956cd23ff1871e2d403263f479
    version: 2.40.1
  front50:
    commit: e099cb401ee08c956cd23ff1871e2d403263f479
    version: 2.40.1
  gate:
    commit: e099cb401ee08c956cd23ff1871e2d403263f479
    version: 2.40.1
  igor:
    commit: e099cb401ee08c956cd23ff1871e2d403263f479
    version: 2.40.1
  kayenta:
    commit: e099cb401ee08c956cd23ff1871e2d403263f479
    version: 2.40.1
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: e099cb401ee08c956cd23ff1871e2d403263f479
    version: 2.40.1
  rosco:
    commit: e099cb401ee08c956cd23ff1871e2d403263f479
    version: 2.40.1
  terraformer:
    commit: e099cb401ee08c956cd23ff1871e2d403263f479
    version: 2.40.1
timestamp: "2026-07-15 12:34:36"
version: 2.40.1
</code>
</pre>
</details>

### Armory


#### Armory Clouddriver - 2.40.0...2.40.1

- fix(perf): ECS loaded ALL data for ALL accounts then filtered ([#7672](https://github.com/spinnaker/spinnaker/pull/7672))
- feat(ecs): migrate ECS caching agents to AWS SDK v2 ([#7742](https://github.com/spinnaker/spinnaker/pull/7742))
- fix(docker): Fixes an issue with RBAC around docker images ([#7746](https://github.com/spinnaker/spinnaker/pull/7746))
- feat(aws): make AmazonClientProvider bilingual (v1 + v2 SDK) ([#7705](https://github.com/spinnaker/spinnaker/pull/7705))


#### Armory Dinghy - 2.40.0...2.40.1


#### Armory Rosco - 2.40.0...2.40.1


#### Armory Deck - 2.40.0...2.40.1

- feat(api-tokens): add API token authentication support UI


#### Armory Echo - 2.40.0...2.40.1

- feat(teams): Allow adaptive and custom templates for MS Teams messages using Jinja ([#7741](https://github.com/spinnaker/spinnaker/pull/7741))
- feat(echo): add trace hierarchy, stage names and customData promotion to OTLP CDEvents spans


#### Armory Fiat - 2.40.0...2.40.1


#### Armory Front50 - 2.40.0...2.40.1


#### Armory Gate - 2.40.0...2.40.1

- feat(api-tokens): add API token authentication support ([#7683](https://github.com/spinnaker/spinnaker/pull/7683))
- fix(mvc): UrlHandlerFilter to trailing slash handle route matching ([#7755](https://github.com/spinnaker/spinnaker/pull/7755))


#### Armory Terraformer - 2.40.0...2.40.1


#### Armory Igor - 2.40.0...2.40.1

- fix(jenkins): cancel Jenkins job when Spinnaker pipeline is cancelled ([#7752](https://github.com/spinnaker/spinnaker/pull/7752))


#### Armory Kayenta - 2.40.0...2.40.1

- fix(kayenta): Fix kayenta stage UI formatting ([#7779](https://github.com/spinnaker/spinnaker/pull/7779))


#### Armory Orca - 2.40.0...2.40.1

- fix(orca): Pipeline bulk save breaks with managed service accounts ([#7688](https://github.com/spinnaker/spinnaker/pull/7688))
- chore(change): Fixes #7282: honor `stageTimeoutMs` in `CreateWebhookTask` ([#7689](https://github.com/spinnaker/spinnaker/pull/7689))


### Spinnaker


#### Spinnaker Clouddriver - 2026.2.2

- fix(perf): ECS loaded ALL data for ALL accounts then filtered ([#7672](https://github.com/spinnaker/spinnaker/pull/7672))
- feat(ecs): migrate ECS caching agents to AWS SDK v2 ([#7742](https://github.com/spinnaker/spinnaker/pull/7742))
- fix(docker): Fixes an issue with RBAC around docker images ([#7746](https://github.com/spinnaker/spinnaker/pull/7746))
- feat(aws): make AmazonClientProvider bilingual (v1 + v2 SDK) ([#7705](https://github.com/spinnaker/spinnaker/pull/7705))
- fix(aws): bridge v1 credentials to v2 in AmazonCredentials.getV2CredentialsProvider() ([#7766](https://github.com/spinnaker/spinnaker/pull/7766))


#### Spinnaker Deck - 2026.2.2

- feat(api-tokens): add API token authentication support UI


#### Spinnaker Echo - 2026.2.2

- feat(teams): Allow adaptive and custom templates for MS Teams messages using Jinja ([#7741](https://github.com/spinnaker/spinnaker/pull/7741))
- feat(echo): add trace hierarchy, stage names and customData promotion to OTLP CDEvents spans
- fix(echo): Fix Microsoft Teams webhook URL doubling in Retrofit2 migration ([#7718](https://github.com/spinnaker/spinnaker/pull/7718))
- fix(echo): GitHub status conversion exception ([#7701](https://github.com/spinnaker/spinnaker/pull/7701))


#### Spinnaker Fiat - 2026.2.2


#### Spinnaker Front50 - 2026.2.2


#### Spinnaker Gate - 2026.2.2

- feat(api-tokens): add API token authentication support ([#7683](https://github.com/spinnaker/spinnaker/pull/7683))
- fix(mvc): UrlHandlerFilter to trailing slash handle route matching ([#7755](https://github.com/spinnaker/spinnaker/pull/7755))


#### Spinnaker Igor - 2026.2.2

- fix(jenkins): cancel Jenkins job when Spinnaker pipeline is cancelled ([#7752](https://github.com/spinnaker/spinnaker/pull/7752))


#### Spinnaker Kayenta - 2026.2.2

- fix(kayenta): Fix kayenta stage UI formatting ([#7779](https://github.com/spinnaker/spinnaker/pull/7779))
- chore(cves): Upgrade various deps based on security scans ([#7775](https://github.com/spinnaker/spinnaker/pull/7775))


#### Spinnaker Orca - 2026.2.2

- fix(orca): Pipeline bulk save breaks with managed service accounts ([#7688](https://github.com/spinnaker/spinnaker/pull/7688))
- chore(change): Fixes #7282: honor `stageTimeoutMs` in `CreateWebhookTask` ([#7689](https://github.com/spinnaker/spinnaker/pull/7689))


#### Spinnaker Rosco - 2026.2.2


#### Spinnaker Dinghy - 2026.2.2


#### Spinnaker Terraformer - 2026.2.2
