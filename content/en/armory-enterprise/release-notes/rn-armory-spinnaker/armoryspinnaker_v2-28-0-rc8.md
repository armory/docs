---
title: v2.28.0-rc8 Armory Release (OSS Spinnaker™ v1.28.0)
toc_hide: true
version: 02.28.0rc8
hidden: true
description: >
  Release notes for Armory Enterprise v2.28.0-rc8
---

## 2022/06/23 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Disclaimer

{{< include "lts-beta.md" >}}

## Required Operator version

To install, upgrade, or configure Armory 2.28.0-rc8, use one of the following tools:

- Armory Operator 1.6.0 or later

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

{{< include "breaking-changes/bc-dinghy-slack.md" >}}

{{< include "breaking-changes/bc-java-tls-mysql.md" >}}

{{< include "breaking-changes/bc-k8s-version-pre1-16.md" >}}

{{< include "breaking-changes/bc-k8s-infra-buttons.md" >}}

{{< include "breaking-changes/bc-hal-deprecation.md" >}}

#### Plugin compatibility

{{< include "breaking-changes/bc-plug-version-lts-228.md" >}}

## Known issues

* Clicking the "Create Server Group" button does not work for an AWS provider.

{{< include "known-issues/ki-bake-var-file.md" >}}

{{< include "known-issues/ki-artifact-binding-spel.md" >}}

{{< include "known-issues/ki-dinghy-gh-notifications.md" >}}

{{< include "known-issues/ki-secrets-and-spring-cloud.md" >}}

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
  
### Maximum Concurrent Pipeline Executions
Added support for max concurrent pipeline executions. If concurrent pipeline execution is enabled, pipelines will queue when the max concurrent pipeline executions is reached. Any queued pipelines will be allowed to run once the number of running pipeline executions drops below the max. If the max is set to 0, then pipelines will not queue.
  
### Terraform Show Stage
There is a new Terraform Show stage available as part of the Terraform Integration. This stage is the equivalent of running the terraform show command with Terraform. The JSON output from your planfile can be used in subsequent stages.

To use the stage, select Terraform for the stage type and Show as the action in the stage configuration UI. Note that the Show stage depends on your Plan stage. For more information, see [Show Stage section in the Terraform Integration docs]({{< ref "terraform-use-integration#example-terraform-integration-stage" >}}).

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

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.28.0](https://www.spinnaker.io/changelogs/1.28.0-changelog/) changelog for details.

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
    commit: e8c9c4ef055315d1271e1805241c08fbe2629725
    version: 2.28.0-rc8
  deck:
    commit: 693348595c771625ac4bdc5224921b5882578d79
    version: 2.28.0-rc8
  dinghy:
    commit: 403640bc88ad42cc55105bff773408d5f845e49c
    version: 2.28.0-rc8
  echo:
    commit: 488477dd85edfc6206337bb31f76892e641d1803
    version: 2.28.0-rc8
  fiat:
    commit: 9aca7990e68cc8022a55af31db7df1d04e02de4c
    version: 2.28.0-rc8
  front50:
    commit: f818ac4ce606e4b4f74f3cada4f4bc173a949b50
    version: 2.28.0-rc8
  gate:
    commit: 472e2dd8a37e85403b1c934d194d0c4862d97a96
    version: 2.28.0-rc8
  igor:
    commit: 5ea6da54f840ecaffa72d62386d9efd7bb54e0fe
    version: 2.28.0-rc8
  kayenta:
    commit: ebc7a92d06ed18b93233a6c887fe9acfd85ccc8c
    version: 2.28.0-rc8
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 877733807a0661adef388e9ad45f79506428e2fe
    version: 2.28.0-rc8
  rosco:
    commit: 8878e069687bfd229bd00907ede66dfe1b73d2e0
    version: 2.28.0-rc8
  terraformer:
    commit: c3c07a7c4f09752409183f906fb9fa5458e7d602
    version: 2.28.0-rc8
timestamp: "2022-06-14 17:24:09"
version: 2.28.0-rc8
</code>
</pre>
</details>

### Armory


#### Armory Front50 - 2.27.0...2.28.0-rc8


#### Armory Deck - 2.27.0...2.28.0-rc8


#### Armory Fiat - 2.27.0...2.28.0-rc8


#### Armory Gate - 2.27.0...2.28.0-rc8


#### Armory Igor - 2.27.0...2.28.0-rc8


#### Armory Clouddriver - 2.27.0...2.28.0-rc8


#### Armory Orca - 2.27.0...2.28.0-rc8


#### Armory Kayenta - 2.27.0...2.28.0-rc8


#### Armory Rosco - 2.27.0...2.28.0-rc8


#### Dinghy™ - 2.27.0...2.28.0-rc8


#### Armory Echo - 2.27.0...2.28.0-rc8


#### Terraformer™ - 2.27.0...2.28.0-rc8


