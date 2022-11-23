---
title: v2.28.0 Armory CD Release (Spinnaker™ v1.28.0)
toc_hide: true
version: 02.28.0
hidden: true
description: >
  Release notes for Armory Continuous Deployment (Armory CD) v2.28.0
---

## 2022/07/20 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "op-manage-spinnaker#rollback-armory-enterprise" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Operator version

To install, upgrade, or configure Armory 2.28.0, use one of the following tools:

- Armory Operator 1.6.0 or later

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

{{< include "breaking-changes/bc-orca-rdbms-configured-utf8.md" >}}

{{< include "breaking-changes/bc-k8s-v2-provider-aws-iam-auth.md" >}}

{{< include "breaking-changes/bc-kubectl-120.md" >}}

{{< include "breaking-changes/bc-java-tls-communication-failure.md" >}}

{{< include "breaking-changes/bc-k8s-version-pre1-16.md" >}}

{{< include "breaking-changes/bc-k8s-infra-buttons.md" >}}

{{< include "breaking-changes/bc-hal-deprecation.md" >}}

#### Plugin compatibility

Due to changes in the underlying services, older versions of some plugins may not work with Armory CD 2.28.x or later.

The following table lists the plugins and their required minimum version:

| Plugin                                                                                             | Version |
| -------------------------------------------------------------------------------------------------- | ------- |
| [Armory Agent for Kubernetes Clouddriver Plugin](h{{< ref "agent-plugin" >}}")                     | 0.11.0  |
| App Name                                                                                           | 0.2.0   |
| [AWS Lambda](https://github.com/spinnaker-plugins/aws-lambda-deployment-plugin-spinnaker/releases) | 1.0.10  |
| [Evaluate Artifacts](https://github.com/armory-plugins/evaluate-artifacts-releases/releases)       | 0.1.1   |
| [External Accounts](https://github.com/armory-plugins/external-accounts/releases)                  | 0.3.0   |
| [Observability Plugin](https://github.com/armory-plugins/armory-observability-plugin/releases)     | 1.3.1   |
| [Policy Engine](https://github.com/armory-plugins/policy-engine-releases/releases)                 | 0.2.2   |


## Known issues

{{< include "known-issues/ki-app-attr-not-configured.md" >}}

{{< include "known-issues/ki-app-eng-acct-auth.md" >}}

{{< include "known-issues/ki-403-permission-err.md" >}}

{{< include "known-issues/ki-spel-expr-art-binding.md" >}}

{{< include "known-issues/ki-pipelines-as-code-gh-comments.md" >}}

{{< include "known-issues/ki-secrets-and-spring-cloud.md" >}}

### Supported Terraform Versions

Armory removed support for older, non-supported versions of Terraform (older than 0.13).

## Highlighted updates

### General Fixes
  * Added the ability to limit a specific pipeline from executing more than a certain number of instances in parallel by using a setting similar to the already available limitConcurrent setting.
  * Added support for cancelling Google Cloud Build Account.
  * To allow better customizations of CloseableHttpClient, adding HttpClientProperties as an additional property in UserConfiguredUrlRestrictions that we can use in HttpClientUtils. This will allow us to enable/disable retry options and configure other HttpClient options. For example, you will now be able to configure httpClientProperties.
  * When allowDeleteActive: true, then in the ShrinkCluster stage, disableCluster step is performed before shrinking the cluster.
  * The Google Cloud Platform RETRY_ERROR_CODES list is modified to include 429 , 503 error codes.
  * Updated account permission check to check for WRITE instead of EXECUTE because account permissions do not currently have
EXECUTE defined as a potential permission type.
  * Refactor of launch template roll out config into its own class for reuse and readability.
  * Use new Github teams API as old one has been deprecated.
  * Prevent oauth2 redirect loops.
  * Transition restarted stages to NOT_STARTED so there is visual indication on Deck, and don't allow multiple queuing of the same restarted stage
  * Bring back template validation messages in Deck.
  * Bump the JVM version used by all appropriate services to ensure all services are using the same JVM version.

### Maximum Concurrent Pipeline Executions
Added support for max concurrent pipeline executions. If concurrent pipeline execution is enabled, pipelines will queue when the max concurrent pipeline executions is reached. Any queued pipelines will be allowed to run once the number of running pipeline executions drops below the max. If the max is set to 0, then pipelines will not queue.

### **Show** Added to Terraform Integration Stage
There is a new Terraform action available as part of the Terraform Integration stage. This action is the equivalent of running the Terraform ```show``` command with Terraform. The JSON output from your planfile can be used in subsequent stages.

To use the stage, select **Terraform** for the stage type and **Show** as the action in the Stage Configuration UI. Note that the **Show** stage depends on your **Plan** stage. For more information, see [Show Stage section in the Terraform Integration docs]({{< ref "terraform-use-integration#example-terraform-integration-stage" >}}).

### Terraform remote backends provided by Terraform Cloud and Terraform Enterprise
Terraform now supports remote backends provided by Terraform Cloud and Terraform Enterprise - see [Remote Backends section in the Terraform Integration docs]({{< ref "terraform-enable-integration#remote-backends" >}}).

### Clouddriver
  * Improvements to Docker Registry Account Management, including integration of Docker Registry Clouddriver accounts to take advantage of the new self-service on-boarding account management API.
  * Updated account management API to refactor some things in preparation for user secrets support along. Updated the type discriminator handling for account definitions.
  * Access to Bitbucket through token files without having to restart Clouddriver.
  * Added an experimental API for storing and loading account credentials definitions from an external durable store such as a SQL database. Secrets can be referenced through the existing Kork SecretEngine API which will be fetched on demand. Initial support is for Kubernetes accounts given the lack of existing Kubernetes cluster federation standards compared to other cloud providers, though this API is made generic to allow for other cloud provider APIs to participate in this system.
  * To extend the memory feature, a boolean flag is introduced in the validateInstanceType.
  * Added a Fiat configuration option for the Account Management API in Clouddriver for listing which roles are allowed to manage accounts in the API.

### Performance
 * Fix in Lambda to remove parallel streams to improve performance.
 * Refactor(artifacts/s3) - share the AmazonS3 client in S3ArtifactCredentials across downloads instead of constructing a new one for each download. There is likely a performance win from this, but the primary motivation was to make it easier to test.

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->




###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services.

## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>artifactSources:
  dockerRegistry: docker.io/armory
dependencies:
  redis:
    commit: null
    version: 2:2.8.4-2
services:
  clouddriver:
    commit: adbe01b56d31389c9cad1274b894c740835c3834
    version: 2.28.0
  deck:
    commit: 108847b83576abf24d437a0c89015a65f337ec54
    version: 2.28.0
  dinghy:
    commit: 403640bc88ad42cc55105bff773408d5f845e49c
    version: 2.28.0
  echo:
    commit: 488477dd85edfc6206337bb31f76892e641d1803
    version: 2.28.0
  fiat:
    commit: 5728f3484b01459e9b246117cdfbb54f9d00768c
    version: 2.28.0
  front50:
    commit: 1bc61a77916acf5bf7b13041005e730bdac8cd8e
    version: 2.28.0
  gate:
    commit: 938dccc232f849bae4446376579a39755267904b
    version: 2.28.0
  igor:
    commit: c10937f0110f81bd2f17dfea79bfbf01f53598a5
    version: 2.28.0
  kayenta:
    commit: 7bfe2c300432c865f10f07985d81decb58b1ee48
    version: 2.28.0
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 30ca83945081107105b9186461730988fabd11d5
    version: 2.28.0
  rosco:
    commit: 36a55d07da5f25fc385e67922e35f387f13a6fb1
    version: 2.28.0
  terraformer:
    commit: c3c07a7c4f09752409183f906fb9fa5458e7d602
    version: 2.28.0
timestamp: "2022-07-19 18:54:16"
version: 2.28.0
</code>
</pre>
</details>

### Armory


#### Terraformer™ - 2.27.3...2.28.0


#### Armory Clouddriver - 2.27.3...2.28.0


#### Armory Rosco - 2.27.3...2.28.0


#### Armory Deck - 2.27.3...2.28.0


#### Armory Front50 - 2.27.3...2.28.0


#### Dinghy™ - 2.27.3...2.28.0


#### Armory Kayenta - 2.27.3...2.28.0


#### Armory Echo - 2.27.3...2.28.0


#### Armory Orca - 2.27.3...2.28.0


#### Armory Gate - 2.27.3...2.28.0


#### Armory Igor - 2.27.3...2.28.0


#### Armory Fiat - 2.27.3...2.28.0


