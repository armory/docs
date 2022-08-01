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

### Update kubernetes v2 provider accounts that use the aws-iam-authenticator

**Impact**

Any kubernetes v2 provider account that uses the aws-iam-authenticator needs to be updated to use client.authentication.k8s.io/v1beta1.

**Introduced in**: Armory CD 2.28.0

### Update kubectl to 1.20

**Impact**

With 2.28 of Spinnaker, we’ve updated the kubectl binary to a 1.20 release.  You may have potential caching issues as a result due to certain resources in K8s being removed and/or no longer supported.  It’s recommended to look for failures in your log files and exclude resources that don’t match your target cluster.  For example, adding “PodPreset” to the “omitKinds” on your K8s account configs would cause Spinnaker to skip trying to cache resources that no longer be able to be cached in newer kubernetes releases.


**Introduced in**: Armory CD 2.28.0

### Pipelines as Code Slack notifications stop working

**Impact**

After upgrading to 2.27.x, your Pipelines as Code Slack notifications may stop working even though they were working previously.

**Hotfix**

See the [Dinghy Slack Notifications not working](https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010573&sys_kb_id=c0befa03dbd2811079f53ec8f496192a&spa=1) KB article for the Hotfix.

**Introduced in**: Armory CD 2.27.0

### Java 11.0.11+, TLS 1.1 communication failure

> This is an issue between Java 11.0.11 and TLSv1.1. Only installations using TLSv1.1 will encounter communication failures between services when those services upgrade to Java 11.0.11+.

TLSv1.1 was deprecated in March of 2020 and reached end-of-life in March of 2021. You should no longer be using TLSv1.1 for secure communication.

Oracle released Java 11.0.11 in April of 2021. Java 11.0.11 dropped support for TLSv1.1. See the Java [release notes](https://www.oracle.com/java/technologies/javase/11all-relnotes.html#JDK-8202343) for details.

**Impact**

Any services running under Java 11.0.11+ **and** using TLSv1.1 will encounter a communication failure. For example, you will see a communication failure between an Armory CD service running under Java 11.0.1 and MySQL 5.7 if the MySQL driver is using TLSv1.1.

The version of Java depends on the version used by the Docker container's OS. Most Armory CD services are using Alpine 3.11 or 3.12, which **does not** use Java 11.0.11. However, Alpine 3.11 is end-of-life in November of 2021, and 3.12 is end-of-life in May of 2022. There is no guarantee that Java 11.0.11+ won’t be added to those container images by some other manner. **You should modify your TLSv1.1 environment now** so you don't encounter communication failures.

**Fix**

Choose the option that best fits your environment.

1. Disable TLSv1.1 and enable TLSv1.2 (preferred):

   See Knowledge Base articles [Disabling TLS 1.1 in Spinnaker and Specifying the Protocols to be used](https://support.armory.io/support?sys_kb_id=6d38e4bfdba47c1079f53ec8f49619c2&id=kb_article_view&sysparm_rank=2&sysparm_tsqueryId=f93349771b3d385013d4fe6fdc4bcb35) and [How to fix TLS error "Reason: extension (5) should not be presented in certificate_request"](https://support.armory.io/support?sys_kb_id=e06335f11b202c1013d4fe6fdc4bcbf8&id=kb_article_view&sysparm_rank=1&sysparm_tsqueryId=3b0341771b3d385013d4fe6fdc4bcb6a).

1. Add a query parameter to the MySQL JDBC URIs:

   ```
   ?enabledTLSProtocols=TLSv1.2
   ```

   Note that this only fixes communication between Armory CD and MySQL.

   See [MySQL communication failure when using TSL1.1](https://support.armory.io/support?id=kb_article&sysparm_article=KB0010376) for more information.


### Kubernetes version for deployment targets

Armory CD 2.26 no longer supports Kubernetes deployment targets prior to version 1.16.  

**Impact**

Any Kubernetes deployment target must run version 1.16 or higher. If you try to deploy to clusters older than 1.16, you may see errors like the following in the UI:

{{< figure src="/images/release/226/bc-k8s-version-pre1-16.jpg" alt="The UI shows an Unexpected Task Failure error." height="50%" width="50%" >}}

Additionally, errors like the following appear in the Clouddriver logs:

```
2021-05-04 21:17:16.032 WARN 1 --- [0.0-7002-exec-9] c.n.s.c.k.c.ManifestController : Failed to read manifest

com.netflix.spinnaker.clouddriver.kubernetes.op.handler.UnsupportedVersionException: No replicaSet is supported at api version extensions/v1beta1
at com.netflix.spinnaker.clouddriver.kubernetes.op.handler.KubernetesReplicaSetHandler.status(KubernetesReplicaSetHandler.java:98) ~[clouddriver-kubernetes.jar:na]
```

```
2021-05-05 14:29:09.653 WARN 1 --- [utionAction-538] c.n.s.c.k.c.a.KubernetesCachingAgent : kubernetes/KubernetesCoreCachingAgent[1/1]: Failure adding relationships for service

com.netflix.spinnaker.clouddriver.kubernetes.op.handler.UnsupportedVersionException: No replicaSet is supported at api version extensions/v1beta1
at com.netflix.spinnaker.clouddriver.kubernetes.op.handler.KubernetesReplicaSetHandler.getPodTemplateLabels(KubernetesReplicaSetHandler.java:167)
```

**Workaround**

If you are affected by this change, perform the following tasks to update your applications:

- Upgrade the Kubernetes clusters that you are trying to deploy to. They must run version 1.16 or higher.
- If you have manifest files using deprecated APIs, update them to use newer APIs. For more information on which APIs are deprecated in each Kubernetes version and how to migrate, see the [Kubernetes Deprecated API Migration Guide](https://kubernetes.io/docs/reference/using-api/deprecation-guide/).

**Introduced in**: Armory CD 2.26.0

### Kubernetes infrastructure in the UI

Starting in 2.26, the UI has been updated to more closely follow immutable infrastructure principles.

When you navigate to the **Infrastructure** tab in the UI for an application that has the Kubernetes provider configured, actions that change the Kubernetes infrastructure (such as **Create** or **Delete**), including Clusters, Load Balancers, and Firewalls, are no longer available.

**Impact**

Users do not see these actions in the UI by default. You must configure the UI to display them if you want your users to be able to perform them through the UI.

**Workaround**

Whether or not these actions are available in the UI is controlled by the following property in `settings-local.yml`:

```yaml
window.spinnakerSettings.kubernetesAdHocInfraWritesEnabled = <boolean>;
```

This setting does not completely prevent users from modifying Kubernetes infrastructure through Armory CD. To do so, you must use the Policy Engine and write policies using the `spinnaker.http.authz` package.

If you use the Policy Engine to control which user roles can see the UI actions and be able to use them, you must set this property to `true`. Setting the value to `false` hides the buttons for all users regardless of whether you grant specific users access to the buttons through the Policy Engine.

This property affects Kubernetes infrastructure only. The behavior is slightly different depending on if the application has only the Kubernetes provider configured or Kubernetes and other providers, such as AWS.

If the application only has the Kubernetes provider configured, the following applies:

- When set to `true`, this property causes the UI to function as it did in previous releases. This allows people to manually create and delete Kubernetes infrastructure from the UI.
- When set to `false`, this property causes the actions to be unavailable to users. This prevents users from manually creating and deleting Kubernetes infrastructure from the UI. The users can still view the infrastructure but cannot make changes through the UI.

If the application includes Kubernetes and other providers, the following applies:

- When set to `true`, this property causes the UI to function as it did in previous releases. This allows people to manually create and delete Kubernetes infrastructure from the UI. Users can continue to select whether they want to create Kubernetes or other infrastructure in the UI.
- When set to `false`, this property causes Kubernetes to be unavailable as an option when trying to modify infrastructure from the UI. Users can still make changes to infrastructure for the application from cloud providers, such as AWS, but not Kubernetes.

**Introduced in**: Armory CD 2.26.0

### Halyard deprecation

Halyard is no longer supported for installing Armory CD 2.27.0 and later. Use the Operator. For more information, see [Halyard Deprecation]({{< ref "halyard-deprecation" >}}).

#### Plugin compatibility

Due to changes in the underlying services, older versions of some plugins may not work with Armory CD 2.28.x or later.

The following table lists the plugins and their required minimum version:

|  Plugin |  Version  |
|---------|-----------|
| [Armory Agent for Kubernetes Clouddriver Plugin](h{{< ref "agent-plugin" >}}") | 0.11.0 |
| App Name | 0.2.0 |
| [AWS Lambda](https://github.com/spinnaker-plugins/aws-lambda-deployment-plugin-spinnaker/releases) | 1.0.10   |
| [Evaluate Artifacts](https://github.com/armory-plugins/evaluate-artifacts-releases/releases) | 0.1.1 |
| [External Accounts](https://github.com/armory-plugins/external-accounts/releases) | 0.3.0 |
| [Observability Plugin](https://github.com/armory-plugins/armory-observability-plugin/releases) | 1.3.1 |
| [Policy Engine](https://github.com/armory-plugins/policy-engine-releases/releases) | 0.2.2 |


## Known issues

### SpEL expressions and artifact binding

There is an issue where it appears that SpEL expressions are not being evaluated properly in artifact declarations (such as container images) for events such as the Deploy Manifest stage. What is actually happening is that an artifact binding is overriding the image value.

**Workaround**:

2.27.x or later: Disable artifact binding by adding the following parameter to the stage JSON: `enableArtifactBinding: false`.

2.26.x or later: Change the artifact binding behavior in `spec.spinnakerConfig.profiles.clouddriver` (Operator) or  `clouddriver-local.yml` (Halyard) to the following, which causes artifacts to only bind the version when the tag is missing:

```yaml
kubernetes:
  artifact-binding:
    docker-image: match-name-only
```

This setting only binds the version when the tag is missing, such as `image: nginx` without a version number.

**Affected versions**: Armory CD 2.26.x and later

### Pipelines as Code GitHub comments

There is a known issue where Pipelines as Code can generate hundreds of comments in a GitHub Pull Request (PR) when updates are made, such as when a module that is used by multiple `dinghyfiles` gets changed. These comments may prevent the GitHub UI from loading or related API calls may lead to rate limiting.

**Affected versions**: Armory CD 2.26.x and later

**Workaround**:

You can either manually resolve the comments so that you can merge any PRs or turn the notifications that Pipelines as Code sends to GitHub.

For information about about how to disable this functionality, see [GitHub Notifications]({{< ref "dinghy-enable#github-notifications" >}}).

<!-- armory-admin/dinghy-enable also has a warning in the github notifications section -->

### Secrets do not work with Spring Cloud Config

If you enable [Spring Cloud Config](https://spring.io/projects/spring-cloud-config), all the properties
(e.g. [Docker](https://github.com/spinnaker/clouddriver/blob/1d442d40e1a1eac851288fd1d45e7f19177896f9/clouddriver-docker/src/main/java/com/netflix/spinnaker/config/DockerRegistryConfiguration.java#L58))
using [Secrets]({{< ref "armory-enterprise/armory-admin/secrets" >}})
are not resolved when Spring Cloud tries to refresh.

**Affected versions**: Armory CD 2.26.x and later

**Known Affected providers in Clouddriver**:

* Kubernetes
* Cloudfoundry
* Docker

**Workaround**:

Do not use secrets for properties that are annotated with `@RefreshScope`.


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


