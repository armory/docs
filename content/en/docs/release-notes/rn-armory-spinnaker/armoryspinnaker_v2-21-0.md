---
title: v2.21.0 Armory Release (OSS Spinnaker™ v1.21.2)
toc_hide: true
date: 2020-07-31
version: 02.21.00
---

## 2020/07/31 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Halyard or Operator version

Armory 2.21.0 requires one of the following:
* Armory-extended Halyard 1.9.4 or later.
* Armory Operator 1.0.2 or later.

## Breaking changes

{{< include "breaking-changes/bc-k8s-namespace.md" >}}

{{< include "breaking-changes/bc-metrics-name.md" >}}

#### HTTP sessions for Gate
Armory 2.19.x and higher include an upgrade to the Spring Boot dependency. This requires you to flush all the Gate sessions for your Spinnaker deployment. For more information, see [Flushing Gate Sessions](https://kb.armory.io/admin/flush-gate-sessions/).

#### Scheduled removal of Kubernetes V1 provider
The Kubernetes V1 provider has been removed in Spinnaker 1.21 (Armory 2.21). Please see the [RFC](https://github.com/spinnaker/governance/blob/master/rfc/eol_kubernetes_v1.md) for more details.

If you still have any jobs that use the V1 provider, you will encounter an error. For more information, see [Cloud providers](#cloud-providers).

## Known Issues

{{< include "known-issues/ki-custom-job-stage.md" >}}

{{< include "known-issues/ki-saml-authn.md" >}}

#### Security update

We continue to make Spinnaker's security a top priority. Although several CVEs are resolved, the following still exist:

##### Multiple services

`CVE-2020-5410` was resolved in a previous version of Spinnaker; however, this CVE introduced a regression for users of Spring Cloud and has been rolled back. Armory will continue to monitor releases for a fix.

##### Orca

The following CVEs have been recently identified and will be addressed in an upcoming release:

- CVE-2020-7692

##### Clouddriver

The following CVEs still exist in Clouddriver:

- CVE-2017-18342
- CVE-2020-1747
- CVE-2019-17638
- CVE-2020-13757
- CVE-2016-10745

All of them are embedded dependencies in the Google Cloud SDK. A version of the Google Cloud SDK addressing these CVEs has not been released. The risk to Clouddriver users is low. All four CVEs deal with untrusted input, which Clouddriver does not provide to the Google Cloud SDK. Additionally, users deploying to other cloud providers are not at risk for this vulnerability.

The following CVE also exists for Clouddriver:

- CVE-2020-7014 deals with an Elasticsearch exploit related to token generation. Clouddriver only makes use of entity tags and does not allow for token generation or authentication.

The following CVEs will be triaged as part of a future release:
- CVE-2020-7692

##### Terraformer

Armory has identified and is triaging the following CVEs in Terraformer, the service for the Terraform integration:

- CVE-2020-15778

## Highlighted Updates

There have also been numerous enhancements, fixes and features across all of Spinnaker's services. The following summaries describe changes and Armory's assessment of how they might impact your use of Spinnaker.

For more information about the changes from the Open Source Community, see [Spinnaker v1.21.2](https://www.spinnaker.io/community/releases/versions/1-21-2-changelog).

### Authorization

This section describes changes to Fiat, Spinnaker's authorization service:

**Change**: Add support for extension resources. [daf58f5f](https://github.com/spinnaker/fiat/commit/daf58f5fd1fdc9f02f1920e13ca1d0e483b42680)
* **Impact**: This change allows Fiat to serve / evaluate permissions for arbitrary resources. This adds additional functionality to the Plugins framework for Spinnaker. For an example, see [File Resource Provider Plugin](https://github.com/spinnaker-plugin-examples/fileResourceProvider).


### Baking

This section describes changes to Rosco, Spinnaker's image bakery:

**Change**: Updated Packer to version 1.4.5. [0091cc1d](https://github.com/spinnaker/rosco/commit/0091cc1dc30eee002115b684806393e9c7dc437d)
* **Impact**: You can now run more than one instance of Packer's Docker Builder at a time. Resolves [this issue](https://github.com/hashicorp/packer/issues/7904).

### CI integration

This section describes changes to Igor, Spinnaker's service that integrates with CI systems:

**Change**: Resolved [5803](https://github.com/spinnaker/spinnaker/issues/5803) where Jenkins stages fail because Igor could not find a property file. [7c47ce3f](https://github.com/spinnaker/igor/commit/7c47ce3fece8120fc53c615a9683f4ce0070ea4b)
* **Impact**: Igor now automatically retries fetching the property file from Jenkins when encountering a 404.  Igor will retry up to 5 times with 2 seconds non-exponential backoff.

### Cloud providers

This section describes changes to Clouddriver, Spinnaker's cloud connector service:

**Change**: Legacy Kubernetes (V1) provider removed from Spinnaker. Armory 2.20 (OSS 1.20) was the final release that included support for the V1 provider.
* **Impact**: Migrate all Kubernetes accounts to the standard V2 provider before upgrading. If you have any jobs still using the v1 provider, you will encounter error messages:

   ```
   2020-07-31 22:11:55.146  WARN 1 --- [           main] ConfigServletWebServerApplicationContext : Exception encountered during context initialization - cancelling refresh attempt: org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name 'configurationRefreshListener' defined in URL [jar:file:/opt/clouddriver/lib/clouddriver-web-6.10.0-20200625140019.jar!/com/netflix/spinnaker/clouddriver/listeners/ConfigurationRefreshListener.class]: Unsatisfied dependency expressed through constructor parameter 0; nested exception is org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'kubernetesV2ProviderSynchronizable': Invocation of init method failed; nested exception is java.lang.IllegalArgumentException: The legacy Kubernetes provider (V1) is no longer supported. Please migrate all Kubernetes accounts to the standard provider (V2).
   ```

   The above message will be followed by the following error that occurs repeatedly:
   <details><summary>Show the error message</summary>

   ```
   q2020-07-31 22:12:31.005 ERROR 1 --- [gentScheduler-0] c.n.s.c.r.c.ClusteredAgentScheduler      : Unable to run agents
    redis.clients.jedis.exceptions.JedisConnectionException: Could not get a resource from the pool
        at redis.clients.jedis.util.Pool.getResource(Pool.java:59) ~[jedis-3.1.0.jar:na]
        at redis.clients.jedis.JedisPool.getResource(JedisPool.java:234) ~[jedis-3.1.0.jar:na]
        at com.netflix.spinnaker.kork.jedis.telemetry.InstrumentedJedisPool.getResource(InstrumentedJedisPool.java:60) ~[kork-jedis-7.45.9.jar:7.45.9]
        at com.netflix.spinnaker.kork.jedis.telemetry.InstrumentedJedisPool.getResource(InstrumentedJedisPool.java:26) ~[kork-jedis-7.45.9.jar:7.45.9]
        at com.netflix.spinnaker.kork.jedis.JedisClientDelegate.withCommandsClient(JedisClientDelegate.java:54) ~[kork-jedis-7.45.9.jar:7.45.9]
        at com.netflix.spinnaker.cats.redis.cluster.ClusteredAgentScheduler.acquireRunKey(ClusteredAgentScheduler.java:183) ~[cats-redis-6.10.0-20200625140019.jar:6.10.0-20200625140019]
        at com.netflix.spinnaker.cats.redis.cluster.ClusteredAgentScheduler.acquire(ClusteredAgentScheduler.java:136) ~[cats-redis-6.10.0-20200625140019.jar:6.10.0-20200625140019]
        at com.netflix.spinnaker.cats.redis.cluster.ClusteredAgentScheduler.runAgents(ClusteredAgentScheduler.java:163) ~[cats-redis-6.10.0-20200625140019.jar:6.10.0-20200625140019]
        at com.netflix.spinnaker.cats.redis.cluster.ClusteredAgentScheduler.run(ClusteredAgentScheduler.java:156) ~[cats-redis-6.10.0-20200625140019.jar:6.10.0-20200625140019]
        at java.base/java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:515) ~[na:na]
        at java.base/java.util.concurrent.FutureTask.runAndReset(FutureTask.java:305) ~[na:na]
        at java.base/java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.run(ScheduledThreadPoolExecutor.java:305) ~[na:na]
        at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1128) ~[na:na]
        at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:628) ~[na:na]
        at java.base/java.lang.Thread.run(Thread.java:834) ~[na:na]
   Caused by: java.lang.IllegalStateException: Pool not open
        at org.apache.commons.pool2.impl.BaseGenericObjectPool.assertOpen(BaseGenericObjectPool.java:759) ~[commons-pool2-2.7.0.jar:2.7.0]
        at org.apache.commons.pool2.impl.GenericObjectPool.borrowObject(GenericObjectPool.java:402) ~[commons-pool2-2.7.0.jar:2.7.0]
        at org.apache.commons.pool2.impl.GenericObjectPool.borrowObject(GenericObjectPool.java:349) ~[commons-pool2-2.7.0.jar:2.7.0]
        at redis.clients.jedis.util.Pool.getResource(Pool.java:50) ~[jedis-3.1.0.jar:na]
        ... 14 common frames omitted
   ```
   </details>

   Here is the YAML for an example V1 provider:

   <details><summary>Show the config</summary>
   <pre><code>
   - name: kubernetes
     requiredGroupMembership: []
     providerVersion: V1
     permissions: {}
     dockerRegistries:
       - accountName: gcr
         namespaces: []
       - accountName: dockerhub
         namespaces: []
     context: gke_cloud-hooli_us-central1-c_armory-kube
     configureImagePullSecrets: true
     cacheThreads: 1
     namespaces:
       - staging
       - default
       - demo
       - dev
       - platform
     omitNamespaces: []
     kinds: []
     omitKinds:
       - podPreset
     customResources: []
     cachingPolicies: []
     kubeconfigFile: encrypted:s3!r:us-west-2!b:hooli-halyard-secrets!f:eng-prod/kubeconfig.gke.armorykube
     checkPermissionsOnStartup: false
     liveManifestCalls: true
     oauthScopes: []
     oAuthScopes: []
   </code></pre>
   </details>

**Change**: The Alicloud, DC/OS, and Oracle cloud providers are excluded from OSS Spinnaker 1.21 because they no longer meet Spinnaker's cloud provider requirements. For more information about these requirements, see [Cloud Provider Requirements](https://github.com/spinnaker/governance/blob/master/cloud-provider-requirements.md).
* **Impact**: If you use one of these cloud providers and cannot migrate to a supported provider, do not upgrade to Armory 2.21 (OSS 1.21). Clouddriver providers are created and maintained by each cloud provider. Contact your cloud provider to review the requirements for inclusion in the Spinnaker project.

### Dynamic accounts

2.21 resolves a previous known issue with Dynamic accounts for Kubernetes where the following occurs:

* Agents that get removed but still run on schedule.
* Force cache refresh times out.
* If you have the clean up agent setup, your data randomly disappears and reappears.  

### Eventing

This section describes changes to Echo, Spinnaker's event service:

**Change**: Add action conditions for Git triggers. [715693a](https://github.com/spinnaker/echo/commit/715693a02869edcbc37d0159e4c5f518eab6e7c8)
* **Impact**: You can now filter triggers on Git webhooks. Add an actions section to the pipeline JSON to filter what type of actions can trigger the pipeline. The following example configures a pipeline to only trigger when a pull request is closed:
   ```json
   "triggers: [
      {
         "actions": [
            "pull_request:closed"
         ],
         "branch": "",
         "enabled": true,
         "project": "MyProject",
         "slug": "MyRepository",
         "source": "github",
         "type": "git"
      }
   ],
   ```

**Change**: Usage statistics for Spinnaker are now collected by default. The Open Source Spinnaker project collects this information to inform the development of Spinnaker. It is anonymized before it gets sent and then aggregated. For more information about these metrics or to view them, see [Usage Statistics](https://spinnaker.io/community/stats/#usage-statistics).
* **Impact**:  If you want to turn the usage statistics off, see [How is the data collected](https://spinnaker.io/community/stats/#how-is-the-data-collected).

**Change**: Add ability to suppress triggers at runtime. [7aebc7a3](https://github.com/spinnaker/echo/commit/7aebc7a319706ec3ec2d94d2102ea4b219a63707)
* **Impact**: This change adds the following properties that can be used in `echo.yml`:
   * `scheduler.suppressTriggers`: (Default: `false`) Allows suppressing event triggers from the CRON scheduler.
   * `scheduler.compensationJob.suppressTriggers`: (Default: `false`) Allows suppressing event triggers from the compensation job (missed CRON scheduler).

   You might use these properties when you are running two instances of Echo that are both running the scheduler for redundancy. Both Echos need to be current in situations where you need to switch the Echo service being used, but only one of them need to trigger events at any given time.

   These properties are backed by the DynamicConfigService and can be modified at runtime.

### Metadata persistence

This section describes changes to Front50, Spinnaker's metadata repository:

**Change**: Ability to overwrite an application config entirely through the API. [2cf86b34](https://github.com/spinnaker/front50/commit/2cf86b34d40f847208a1a55bee352bc731fd1b6b)
* **Impact**: New API functionality!

**Change**: Ability to validate application names when applications are created or modified through the API. [2cf86b34](https://github.com/spinnaker/front50/commit/2cf86b34d40f847208a1a55bee352bc731fd1b6b)
* **Impact**: When you submit an application name through the API instead of Deck, Spinnaker can now validate the name to ensure that the name only contains allowed characters. This behavior is off by default. To enable this validation, add the following config to `front50-local.yml`:

   ```yaml
   validation:
    applicationNameValidator:
        validationRegex: "^.*$"
        validationMessage: "<Optional. Message to display to user if the application name contains disallowed characters.">
   ```

**Change**: Front50 now only attempts to sync authorization permissions if Fiat is enabled.
* **Impact**: Fewer unncessary log messages.

### Pipelines as Code

Pipelines as Code now supports Pull Request (PR) Validation for GitHub. When a PR is submitted, you can ensure that the `dinghyfile` is valid by enabling this feature.

For more information, see [Pull Request Validation]({{< ref "dinghy-enable#pull-request-validations" >}}).

### Task orchestration

This section describes changes to Orca, Spinnaker's task orchestration service:

**Change**: Add function `pipelineIdInApplication` to Pipeline Expressions, which allows you to fetch the ID of a pipeline given its name and its application name. [febb6f68](https://github.com/spinnaker/orca/commit/febb6f68c4c9dcfd5aba82eab587add2fae2b11d)
* **Impact**: This function is useful when running a dependent pipeline that fails in a different application.

**Change**: **AWS** -- Pass the AWS account to Clouddriver when retrieving images. [9eadf5e6](https://github.com/spinnaker/orca/commit/9eadf5e68ca1b535f8fe562b5f870ce962c6e242)
* **Impact**: This modifies the behavior of the Find Image from Tags stage. You can configure the stage to look for images in a specific AWS account if the following config is set in the stage JSON: `imageOwnerAccount`.

**Change**: Expose the `amiName` property in bake stage output (if present). [ee99ba11](https://github.com/spinnaker/orca/commit/ee99ba114aff96ab37654336922a2ac75da7ad6c)
* **Impact**: You can access `amiName` in downstream stages.

**Change**: **AWS** -- Add exported environment variables in the CodeBuild stage context. [2ab7032e](https://github.com/spinnaker/orca/commit/2ab7032e28303d4b23ecde8ba6286ded0147d52c)
* **Impact**:  Allows end users to consume the environment variables exported from CodeBuild build stage by specifying a pipeline expression like `${#stage('AWS CodeBuild')['context']['buildInfo']['exportedEnvironmentVariables']}`.

**Change**: Merge collections when merging stage outputs. [f44ba60f](https://github.com/spinnaker/orca/commit/f44ba60fd8eaa89f3d5b10a1f335df07e4dd0b35)
* **Impact**: More data may be available in the pipeline execution history. This changes the behavior of stage outputs. Previously, stage outputs overwrote each other if duplicates were present. Now, stage outputs concatenate collections from duplicate keys.

**Change**: Add a dynamic toggle for sending full pipeline executions between Spinnaker services. [54a0ff85](https://github.com/spinnaker/orca/commit/54a0ff8586433905e9d1d4a93023ff9ecd33cef2)
* **Impact**: Large pipeline executions can generate a lot of tasks, which generates Echo traffic that includes the full execution payload. This option allows for a reduced payload size. To turn this feature on, add the following config to Echo:
   ```yaml
   echo:
      ...
      events:
         includeFullExecution: true
      ...
   ```


### UI

This section describes changes to Deck, Spinnaker's UI:

**Change**: Improved UI for child pipeline failures. Previously, failures in pipelines that run as stages of other pipelines were difficult to debug.  [a2af93f](https://github.com/spinnaker/deck/commit/a2af93fd961323fbea611a97bf7c0bbbb82c9828)
* **Impact**: There is now a modal to surface failed child pipeline execution details. You can enable this feature by adding the following config to `settings-local.js`:
   ```
   window.spinnakerSettings.feature.executionMarkerInformationModal = true;
   ```
   This feature will be on by default in Armory 2.21 (Open Source Spinnaker 1.22).

**Change**: There is now only a single Artifacts UI. The legacy Artifacts UI is no longer available.
* **Impact**: The flag `legacyArtifactsEnabled` to revert to the legacy Artifacts UI is no longer supported and should be removed from your configs.


## Detailed Updates

### Bill of Materials
Here's the bom for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.21.0
timestamp: "2020-07-31 20:23:22"
services:
    clouddriver:
        commit: f97b7cc2
        version: 2.21.1
    deck:
        commit: 8c42b95f
        version: 2.21.3
    dinghy:
        commit: 780d019d
        version: 2.21.1
    echo:
        commit: 880b43b4
        version: 2.21.1
    fiat:
        commit: 4e293ee1
        version: 2.21.1
    front50:
        commit: 9b3d3bac
        version: 2.21.0
    gate:
        commit: c17b7686
        version: 2.21.2
    igor:
        commit: b5662632
        version: 2.21.1
    kayenta:
        commit: c67e13d7
        version: 2.21.0
    monitoring-daemon:
        version: 2.21.0
    monitoring-third-party:
        version: 2.21.0
    orca:
        commit: d49aeea4
        version: 2.21.0
    rosco:
        commit: 1c0b7e7c
        version: 2.21.1
    terraformer:
        commit: be026f2c
        version: 2.21.3
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Orca - 2.20.5...2.21.0

  - chore(version): Generate build-info properties file (#104)
  - fix(build): explicitly set armory commons version (#116)
  - fix(build): force nebula version (#120)

#### Armory Deck - 2.20.4...2.21.3

  - fix(commons): rollback version of commons (#616)
  - chore(release): update to oss 1.21.2-rc1 (#633) (#634)
  - chore(build): push images to dockerhub (#631) (#635)
  - fix(header): remove custom angular header shim (#636) (#637)

#### Armory Fiat - 2.20.6...2.21.1

  - chore(version): upgrade armory commons, armory settings plugin and JDK github actions to generate build-info properties file (#57)
  - fix(release): set nebula release version (#73)
  - chore(core): update fiat.yml config 1.20->1.21 (#92) (#93)

#### Armory Clouddriver - 2.20.8...2.21.1

  - chore(version): upgrade armoryCommons & armory.settings plugin to generate build-info.properties file (#131)
  - fix(build): explicitly set armory commons version (#150)
  - fix(build): Add gcloud app-engine-go component (#156)
  - fix(dynamicAccounts): Port fix of caching agents deleted on refresh (#173)
  - chore(build): python3, remove curl, groff, less, aws 1.18.109, kubectl 1.17.7 (#175) (#176)

#### Armory Igor - 2.20.11...2.21.1

  - chore(version): Generate build-info properties file (#65)
  - chore(cve): fix CVE-2020-13692 (#75)
  - chore(build): fix nebula issue (#78)
  - chore(deps): change armory-commons import to -all (#86)
  - fix(build): explicitly set armory commons version (#92)
  - chore(core): update igor.yml config (#113) (#114)

#### Terraformer - 2.20.8...2.21.3

  - fix(profiles): dont evaluate permissions on a nil Profile (#183)
  - fix(profiles): test verifying no error thrown when profile is nil (#185)
  - chore(deps): update plank version (#186)
  - fix(git/repo): support symlinks when unpacking tarball archives (#192)
  - feat(terraform): require terraform version (#197)
  - fix(artifacts): retrieve artifacts by name || reference (#199)
  - chore(tests): beginning of integration test fram (#198)
  - chore(versions): maintain image with all versions (#203)
  - chore(versions): manual exec versions workflow (#206)
  - chore(build): fix build and push action name (#208)
  - chore(versions): fix docker action again (#209)
  - chore(versions): fix image name (#210)
  - chore(docker): use cache image for tf versions (#204)
  - chore(integration): trigger integration tests (#214)
  - chore(test): trigger integration tests (#219)
  - fix(artifacts): use one method for consistent download/reading (#217)
  - chore(environment): add image pull secret (#222)
  - chore(security): upgrade to alpine:3.12 (#226) (#227)

#### Dinghy - 2.20.6...2.21.1

  - feat(slacknotifications): Send slack applications notifications (#228)
  - fix(notifications): Fixed slack notification (#242)
  - feat(prvalidation): repository processing and PR validations (#241)
  - fix(prval): bugfix for PR validation (#249)
  - fix(bitbucket): Fix Bitbucket integration (#252)

#### Armory Kayenta - 2.20.6...2.21.0

  - chore(version): upgrade armory commons, armory settings plugin and JDK github actions to generate build-info properties file (#77)
  - fix(release): set nebula release version (#92)

#### Armory Echo - 2.20.12...2.21.1

  - chore(version): upgrade armory commons, armory settings and JDK on guthub actions (#158)
  - chore(build): update nebula plugin to fix release task (#173)
  - chore(deps): change armory-commons import to -all (#176)
  - fix(dinghy): fix webhook validations headers to lowercase (#181)
  - fix(bitbucket): fix bitbucket integration with dinghy (#185)
  - fix(build): explicitly set armory commons version (#190)
  - fix(github): fix conflicting bean with upstream (#194)
  - feat(plugin-metrics): adds support for proxying plugin events to the debug endpoint (#198)
  - fix(plugin-metrics): speed up test (#199)

#### Armory Front50 - 2.20.8...2.21.0

  - chore(version): Generate build-info properties file. (#92)
  - chore(cve): force commons-collections and postgresql (#107)
  - chore(deps): upgrade nebula plugin (#110)

#### Armory Rosco - 2.20.6...2.21.1

  - chore(version): upgrade armory commons, armory settings plugin and JDK github action to generate build-info properties file (#58)
  - chore(dependencies): bump spinnaker release
  - fix(release): set nebula release version (#71)
  - fix(release): use armorycommons to set nebula version (#73)
  - fix(rosco): updated config from  1.20.x..1.21.x (#89) (#90)

#### Armory Gate - 2.20.4...2.21.2

  - fix(terraformer): propagate auth to profiles call (#123)
  - chore(version): upgrade armory commons, armory settings plugin and JDK github actions to generate build-info properties file. (#117)
  - chore(build): fix nebula issue (#149) (#150)
  - fix(configs): adding redis configs (#152) (#153)
  - chore(build): push images to dockerhub (#151) (#154)

