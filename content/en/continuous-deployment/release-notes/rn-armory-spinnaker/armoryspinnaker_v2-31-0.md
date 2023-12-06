---
title: v2.31.0 Armory Continuous Deployment Feature Release (Spinnaker™ v1.31.3)
toc_hide: true
version: 2.31.0
date: 2023-12-05
description: >
  Release notes for Armory Continuous Deployment v2.31.0. This is a Feature release with 6-month support.
---

## 2023/12/05 Release Notes

> Note: If you're experiencing production issues after upgrading Armory CD, roll back to a previous working version and report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory 2.31.0, use Armory Operator 1.70 or later.

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

{{< include "breaking-changes/bc-plugin-compatibility-2-30-0.md" >}}

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

### Clouddriver and Spring Cloud

The Spring Boot version has been upgraded, introducing a backwards incompatible change to the way configuration is loaded in Spinnaker. Users will need to set the ***spring.cloud.config.enabled*** property to ***true*** in the service settings of Clouddriver to preserve existing behavior. All of the other configuration blocks remain the same.

**Affected versions**: Armory CD 2.30.0 and later

## Deprecations

Reference [Feature Deprecations and end of support]({{< ref "continuous-deployment/feature-status/deprecations/" >}})

## Early access features enabled by default

### **New**: doNotEval SPeL expression

- This feature introduces a new SpEL `doNotEval` method that includes the received JSON object with the `NotEvaluableExpression` class.
- The `toJson` method (and others in the future) do not evaluate expressions and do not throw exceptions for instances of the `NotEvaluableExpression` class.
- See the Spinnaker doc's [doNotEval SPeL expression changelog note](https://spinnaker.io/changelogs/1.30.0-changelog/#donoteval-spel-helper) for more details regarding this feature flag.

### Automatically cancel Jenkins jobs

You now have the ability to cancel triggered Jenkins jobs when a pipeline is canceled, giving you more control over your full Jenkins workflow. Learn more this [Spinnaker changelog](https://spinnaker.io/changelogs/1.29.0-changelog/#orca).

### Enhanced BitBucket Server pull request handling

Trigger pipelines natively when pull requests are opened in BitBucket with newly added events including PR opened, deleted, and declined. See [Triggering pipelines with Bitbucket Server](https://spinnaker.io/docs/guides/user/pipeline/triggers/bitbucket-events/) in the Spinnaker docs for details

## Early access features enabled manually

### **New**: Pipeline Triggers: only cache enabled pipelines with enabled triggers of specific types

Enabling this flag may allow Echo to better utilize its cache, improving overall pipeline trigger performance for frequently used pipelines. See the [pull request](https://github.com/spinnaker/echo/pull/1292) for more information regarding this feature flag.

### **New**: Option to disable healthcheck for Google provider

Added the option to disable the healthcheck for Google provider similar to AWS and Kubernetes.

### Helm parameters

Spinnaker users baking Helm charts can now use SpEL expression parameters for **API Version** and **Kubernetes Version** in the Bake Manifest stage so that they can conditionally deploy different versions of artifacts depending on the target cluster API and Kubernetes versions. To learn more about this exciting new feature, see [Helm Parameters](https://spinnaker.io/docs/guides/user/kubernetes-v2/deploy-helm/#configure-api-versions-and-a-kubernetes-version) in the Spinnaker docs.

### Dynamic rollback timeout

To make the dynamic timeout available, you need to enable the feature flag in Orca and Deck. Add this block to  your `orca.yml` file if you want to enable the dynamic rollback timeout feature:

```yaml
rollback:
  timeout:
    enabled: true
```

In Orca, the feature flag overrides the default value rollback timeout - 5 min - with a UI input from the user.

In Deck, the feature flag enhances the Rollback Cluster stage UI with timeout input.

`window.spinnakerSettings.feature.dynamicRollbackTimeout = true;`

The default is used if there is no value set in the UI.

### Run Pipelines-as-Code with permissions scoped to a specific service account

Enhancing Pipelines-as-Code to upsert a pipeline using an Orca call instead of a Front50 call, to mimic the calls from Deck. By default, it is disabled. To enable, set the following in `dinghy.yml`:

```upsertPipelineUsingOrcaTaskEnabled: true```

### Pipelines-as-Code PR checks

This feature, when enabled, verifies if the author of a commit that changed app parameters has sufficient WRITE permission for that app. You can specify a list of authors whose permissions are not valid. This option’s purpose is to skip permissions checks for bots and tools.

See [Permissions check for a commit]({{< ref "plugins/pipelines-as-code/install/configure#permissions-check-for-a-commit" >}}) for details.

### Pipelines-as-Code multi-branch enhancement

Now you can configure Pipeline-as-Code to pull Pipelines-as-Code files from multiple branches on the same repo. Cut out the tedious task of managing multiple repos. Use a single repo for application pipelines. See [Multiple branches]({{<  ref "plugins/pipelines-as-code/install/configure#multiple-branches" >}}) for how to enable and configure this feature.

### Terraform template fix

Armory fixed an issue with SpEL expression failures appearing while using Terraformer to serialize data from a Terraform Plan execution. With this feature flag fix enabled, you are able to use the Terraform template file provider. Open a support ticket if you need this fix.

## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->

### Spring Boot

As part of the modernization effort, Spring Boot has been updated to 2.5. Note that there is no expected change for end users due to this change. Plugin developers may need to update their projects to work with 2.31.0+.

### Clouddriver

- Changed the validation Clouddriver runs before performing operations for the Kubernetes provider. The *kinds* and *omitKinds* fields on a Kubernetes account definition no longer restrict what Kubernetes kinds can be deployed by Clouddriver; instead, these fields now only control what kinds Clouddriver caches. Armory CD operators should ensure that Kubernetes RBAC controls are used to restrict what kinds Armory CD can deploy.
- Bumped aws-cli to 1.22 to enable FIPS compliance configuration options.
  
### Deck

- Added Cloud Run manifest functionality in Deck.
- Made the *StageFailureMessage* component overridable, which enables the ability to override the red error box in the component of a plugin.
- Added the ability to allow plugins to provide custom icon components.
  - Enables plugins to use the Icon component with a custom icon.  Currently the Icon component is limited to only icons defined in *iconsByName.*
- For the Helm bake feature, added additional input fields where the user can fill in details of the API's versions. These input fields are not be pre-populated with versions of the target cluster available in the environment.  They become part of the bake result. Added *API_VERSIONS_ENABLED* env variable flag.

### Echo

- Added a new configuration flag: *pipelineCache.filterFront50Pipelines* that defaults to false. When false, Echo caches all pipelines Front50. When true, it only caches enabled pipelines with enabled triggers of specific types. – The types that Echo knows how to trigger, along with some changes to the logic for handling manual executions so they continue to function. This is typically a very small subset of all pipelines.

### Fiat

- Added the ability to register *SpinnakerRetrofitErrorHandler* with each Retrofit.RestAdapter and replaces each RetrofitError catch block with a catch-block using SpinnakerServerException or the appropriate subclass. This change does not alter any of this service's behavior, it merely allows error messages to surface even when the error was thrown in a microservice more than one network call from the service in which the request originated. This is part of an effort to consume *SpinnakerRetrofitErrorHandler* in each Spinnaker microservice, as detailed in [this Github issue](https://github.com/spinnaker/spinnaker/issues/5473).

### Front50

- Added optional query params to the GET /pipelines endpoint.
- Return all pipelines triggered when the given pipeline configuration ID completes with the given status. Initially used in this [PR](https://github.com/spinnaker/orca/pull/4448).
- Added three new config flags to each object type under service-storage.
   - Two of the three are performance improvements which you can read about in the Spinnaker 1.31.0 [changelog](https://spinnaker.io/changelogs/1.31.0-changelog/#front50)

### Kayenta

- Added a storage service migrator.
   - Added the ability to migrate account credentials and account configurations data from S3/GCS to MySQL/PostgreSQL and vice versa
   - See the [PR comment](https://github.com/spinnaker/kayenta/pull/940#issue-1639273840) for instructions on how to use these properties (in kayenta-local.yml) to enable the data migration and MySQL or PostgreSQL data source.
 
### Orca

- Added a new configuration flag: *front50.useTriggeredByEndpoint* that defaults to false. When false, Orca queries Front50 for all pipelines each time a pipeline execution completes. When true, Orca only queries for pipelines triggered when a specific pipeline completes which is potentially a very small subset of all pipelines.



###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.31.3](https://www.spinnaker.io/changelogs/1.31.3-changelog/) changelog for details.

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
    commit: 1db66b13244c3d25b48e767992c5bb7730772271
    version: 2.31.0
  deck:
    commit: 1dd95e4ef5ed631f24253bf917200c3cf52655af
    version: 2.31.0
  dinghy:
    commit: 362913af0c5d00eee5ea3b157274cabbef920c43
    version: 2.31.0
  echo:
    commit: a700e1233d1eca8642b54413c87860737662d4c2
    version: 2.31.0
  fiat:
    commit: f1079f69f0184aae517680c48283cf9a52c9cf26
    version: 2.31.0
  front50:
    commit: 5db553c003950174757e6438ba024b6a4b51c9ed
    version: 2.31.0
  gate:
    commit: 1a4fc24d3d4870c375f6bc10fe6892c6b39a789e
    version: 2.31.0
  igor:
    commit: e94591b4172e7d75ce94db23ebed5deb756af92d
    version: 2.31.0
  kayenta:
    commit: 4a528f19b704cc0f25295daef56d27b78a84a25e
    version: 2.31.0
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: b1a6fe2247ef18f6239b3ab90b101197c57314c4
    version: 2.31.0
  rosco:
    commit: a30386ed64ae490e4788fe80b453528731a923bd
    version: 2.31.0
  terraformer:
    commit: 50082463ccd180cb4763078671a105ab70dee5e6
    version: 2.31.0
timestamp: "2023-11-23 15:13:30"
version: 2.31.0
</code>
</pre>
</details>

### Armory


#### Armory Gate - 2.30.0...2.31.0

  - chore(cd): update armory-commons version to 3.13.3 (#559)
  - fix(tests): Fix JUnit tests (#558)
  - chore(cd): update base service version to gate:2023.04.07.01.27.28.release-1.30.x (#553)
  - chore(cd): update armory-commons version to 3.13.2 (#554)
  - chore(cd): update armory-commons version to 3.13.1 (#537)
  - revert(header): update plugins.json with newest header version (#484)
  - chore(cd): update base service version to gate:2023.04.17.18.59.00.master (#557)
  - chore(cd): update base service version to gate:2023.05.02.16.41.37.master (#560)
  - chore(cd): update base service version to gate:2023.05.02.16.49.52.master (#561)
  - chore(cd): update base service version to gate:2023.05.12.14.58.29.master (#562)
  - chore(cd): update base service version to gate:2023.05.18.17.05.02.master (#564)
  - chore(cd): update base service version to gate:2023.05.25.21.38.35.master (#565)
  - chore(cd): update base service version to gate:2023.06.02.20.01.30.master (#566)
  - chore(cd): update base service version to gate:2023.06.05.20.11.44.master (#567)
  - chore(cd): update base service version to gate:2023.06.12.23.37.52.master (#568)
  - chore(cd): update base service version to gate:2023.06.13.05.17.05.master (#569)
  - chore(cd): update base service version to gate:2023.06.16.09.48.18.master (#570)
  - chore(cd): update base service version to gate:2023.06.17.10.05.03.master (#571)
  - chore(cd): update base service version to gate:2023.06.26.17.12.12.master (#572)
  - chore(cd): update base service version to gate:2023.06.28.20.06.44.master (#573)
  - chore(armory-commons): upgrading armory-commons to 3.14.0-rc.3 (#583)
  - chore(cd): update armory-commons version to 3.14.2 (#586)
  - chore(cd): update base service version to gate:2023.08.28.17.15.40.release-1.31.x (#600)
  - chore(cd): update base service version to gate:2023.08.29.05.01.02.release-1.31.x (#604)
  - fix: esapi CVE scan report (#602) (#605)
  - chore(cd): update base service version to gate:2023.09.01.15.43.46.release-1.31.x (#607)
  - chore(ci): removed aquasec scan action (#616) (#621)
  - chore(feat): Support ARM with docker buildx - SAAS-1953 (#640) (#641)

#### Armory Front50 - 2.30.0...2.31.0

  - chore(cd): update base service version to front50:2023.05.22.19.11.48.release-1.30.x (#548)
  - chore(cd): update armory-commons version to 3.13.3 (#538)
  - chore(cd): update base service version to front50:2023.04.27.18.45.08.release-1.30.x (#541)
  - chore(cd): update armory-commons version to 3.13.2 (#533)
  - chore(cd): update armory-commons version to 3.13.1 (#514)
  - chore(cd): update base service version to front50:2023.04.07.01.28.32.release-1.30.x (#532)
  - chore(dockerfile): upgrade to latest alpine image (#434)
  - chore(cd): update base service version to front50:2023.04.05.11.05.16.master (#529)
  - chore(cd): update base service version to front50:2023.04.21.14.37.41.master (#540)
  - chore(cd): update base service version to front50:2023.05.02.05.06.08.master (#542)
  - chore(armory-commons): upgrading armory-commons to 3.14.0-rc.3 (#564)
  - chore(cd): update base service version to front50:2023.07.18.21.40.31.master (#563)
  - chore(cd): update armory-commons version to 3.14.2 (#567)
  - chore(cd): update base service version to front50:2023.08.28.17.17.25.release-1.31.x (#580)
  - chore(cd): update base service version to front50:2023.08.29.04.59.48.release-1.31.x (#581)
  - chore(cd): update base service version to front50:2023.09.05.18.25.32.release-1.31.x (#584)
  - chore(ci): removed aquasec scan action (#590) (#593)
  - chore(feat): Support ARM with docker buildx - SAAS-1953 (#612) (#613)

#### Armory Rosco - 2.30.0...2.31.0

  - chore(cd): update armory-commons version to 3.13.3 (#528)
  - chore(cd): update base service version to rosco:2023.04.05.11.40.04.release-1.30.x (#523)
  - chore(cd): update armory-commons version to 3.13.1 (#508)
  - feat(dockerfile): add Kustomize 4 to Dockerfiles (#434)
  - fix(rosco): added missing rosco-core dependency and upgrading embedded redis for tests (#456)
  - chore(packer): copied templates and config from oss (#457)
  - chore(cd): update base service version to rosco:2022.11.10.16.54.39.master (#458)
  - chore(cd): update base service version to rosco:2022.11.15.19.33.07.master (#459)
  - chore(cd): update base service version to rosco:2022.11.16.17.50.30.master (#460)
  - chore(cd): update base service version to rosco:2022.11.17.15.34.54.master (#461)
  - chore(cd): update base service version to rosco:2022.11.18.18.20.19.master (#462)
  - chore(cd): update base service version to rosco:2022.11.19.01.16.08.master (#463)
  - chore(cd): update base service version to rosco:2022.11.19.16.30.34.master (#464)
  - chore(cd): update base service version to rosco:2022.11.22.14.31.01.master (#466)
  - chore(azure): copying config from oss, upgrading centos (#465)
  - chore(cd): update base service version to rosco:2022.11.24.15.56.54.master (#469)
  - chore(cd): update base service version to rosco:2022.12.08.14.30.19.master (#472)
  - chore(cd): update base service version to rosco:2022.12.08.20.50.39.master (#473)
  - chore(cd): update base service version to rosco:2022.12.09.00.48.23.master (#476)
  - chore(cd): update base service version to rosco:2022.12.09.02.57.42.master (#477)
  - chore(cd): update base service version to rosco:2022.12.09.06.01.36.master (#478)
  - chore(cd): update base service version to rosco:2022.12.09.17.27.05.master (#479)
  - fix(build): Add javax.validation dependency (#480)
  - chore(cd): update base service version to rosco:2022.12.15.16.52.34.master (#481)
  - chore(cd): update base service version to rosco:2022.12.22.04.48.59.master (#482)
  - chore(cd): update base service version to rosco:2023.01.12.21.47.32.master (#485)
  - chore(cd): update base service version to rosco:2023.01.23.17.14.17.master (#487)
  - chore(cd): update base service version to rosco:2023.01.27.00.40.58.master (#488)
  - chore(cd): update base service version to rosco:2023.01.30.16.28.07.master (#489)
  - chore(cd): update base service version to rosco:2023.02.08.19.46.54.master (#490)
  - chore(cd): update base service version to rosco:2023.02.08.22.19.58.master (#491)
  - chore(cd): update base service version to rosco:2023.02.08.23.30.28.master (#492)
  - chore(cd): update base service version to rosco:2023.02.09.00.57.01.master (#493)
  - chore(cd): update base service version to rosco:2023.02.09.06.34.37.master (#494)
  - chore(cd): update base service version to rosco:2023.02.16.16.48.52.master (#495)
  - chore(cd): update base service version to rosco:2023.02.20.19.50.47.master (#496)
  - chore(cd): update armory-commons version to 3.9.5 (#505)
  - chore(armory-commons): upgrading armory-commons to 3.14.0-rc.3 (#549)
  - chore(cd): update armory-commons version to 3.14.2 (#552)
  - chore(ci): removed aquasec scan action (#565) (#567)
  - chore(cd): update base service version to rosco:2023.08.28.17.15.52.release-1.31.x (#562)
  - chore(feat): Support ARM with docker buildx - SAAS-1953 (backport #584) (#587)
  - chore(cd): update base service version to rosco:2023.10.18.06.02.57.release-1.31.x (#590)

#### Terraformer™ - 2.30.0...2.31.0

  - chore(alpine): Update alpine version (#497)
  - chore(ci): removing aquasec scans on push (#517) (#518)
  - chore(ci): removed aquasec scan action (#510) (#511)
  - chore(feat): Support ARM with docker buildx - SAAS-1953 (backport #525) (#526)
  - Minor changes for Terraform tag name (#527) (#528)
  - fix(cd): Fix terraform build fail (#529) (#530)
  - Fix build cd artifact erro, no space lef on the device (#531) (#532)

#### Armory Clouddriver - 2.30.0...2.31.0

  - chore(cd): update base service version to clouddriver:2023.05.30.19.45.40.release-1.30.x (#882)
  - chore(cd): update armory-commons version to 3.13.5 (#874)
  - chore(cd): update armory-commons version to 3.13.4 (#869)
  - chore(cd): update armory-commons version to 3.13.3 (#867)
  - chore(cd): update armory-commons version to 3.13.2 (#861)
  - chore(cd): update base service version to clouddriver:2023.04.07.02.16.05.release-1.30.x (#860)
  - chore(cd): update base service version to clouddriver:2023.04.06.10.03.44.release-1.30.x (#859)
  - chore(cd): update base service version to clouddriver:2023.04.05.14.02.06.release-1.30.x (#856)
  - chore(cd): update base service version to clouddriver:2023.03.24.23.48.26.release-1.30.x (#839)
  - chore(cd): update armory-commons version to 3.13.1 (#837)
  - chore(cd): update base service version to clouddriver:2023.03.18.00.04.47.master (#818)
  - chore(cd): update base service version to clouddriver:2023.03.21.00.31.33.master (#819)
  - chore(cd): update base service version to clouddriver:2023.03.21.19.49.36.master (#820)
  - chore(cd): update base service version to clouddriver:2023.03.22.20.00.03.master (#824)
  - chore(cd): update base service version to clouddriver:2023.03.23.21.01.03.master (#827)
  - chore(cd): update base service version to clouddriver:2023.03.24.23.48.26.master (#828)
  - chore(cd): update base service version to clouddriver:2023.03.29.20.10.21.master (#834)
  - chore(cd): update base service version to clouddriver:2023.03.30.15.20.14.master (#835)
  - chore(cd): update base service version to clouddriver:2023.03.30.16.52.08.master (#838)
  - chore(cd): update base service version to clouddriver:2023.03.31.19.56.29.master (#840)
  - chore(cd): update base service version to clouddriver:2023.03.31.22.03.23.master (#841)
  - chore(cd): update base service version to clouddriver:2023.03.31.22.50.54.master (#842)
  - chore(cd): update base service version to clouddriver:2023.04.01.00.13.01.master (#843)
  - chore(cd): update base service version to clouddriver:2023.04.01.03.32.05.master (#845)
  - chore(cd): update base service version to clouddriver:2023.04.01.04.39.47.master (#846)
  - chore(cd): update base service version to clouddriver:2023.04.01.05.26.14.master (#847)
  - chore(cd): update base service version to clouddriver:2023.04.01.06.46.40.master (#848)
  - chore(cd): update base service version to clouddriver:2023.04.02.04.27.18.master (#849)
  - chore(cd): update base service version to clouddriver:2023.04.02.05.24.21.master (#850)
  - chore(cd): update base service version to clouddriver:2023.04.02.06.10.44.master (#851)
  - chore(cd): update base service version to clouddriver:2023.04.03.15.54.26.master (#852)
  - chore(cd): update base service version to clouddriver:2023.04.03.17.05.33.master (#853)
  - Bumped aws-cli to 1.22 for FIPS compliance (#854)
  - chore(cd): update base service version to clouddriver:2023.04.05.11.43.53.master (#855)
  - chore(cd): update base service version to clouddriver:2023.04.05.21.36.10.master (#857)
  - chore(cd): update base service version to clouddriver:2023.04.17.19.36.00.master (#865)
  - chore(cd): update base service version to clouddriver:2023.05.02.05.46.22.master (#871)
  - chore(cd): update base service version to clouddriver:2023.05.04.00.42.22.master (#872)
  - chore(cd): update base service version to clouddriver:2023.05.11.19.04.48.master (#873)
  - chore(cd): update base service version to clouddriver:2023.05.18.17.41.51.master (#875)
  - chore(cd): update base service version to clouddriver:2023.05.19.23.07.09.master (#876)
  - chore(cd): update base service version to clouddriver:2023.05.25.22.18.08.master (#877)
  - chore(cd): update base service version to clouddriver:2023.05.30.17.49.03.master (#879)
  - chore(cd): update base service version to clouddriver:2023.06.02.19.20.42.master (#884)
  - chore(cd): update base service version to clouddriver:2023.06.05.20.51.02.master (#885)
  - chore(cd): update armory-commons version to 3.14.2 (#911)
  - chore(cd): update base service version to clouddriver:2023.07.21.18.25.26.release-1.31.x (#915)
  - fix: AWS CLI pip installation (#918) (#924)
  - chore(cd): update base service version to clouddriver:2023.08.28.14.14.40.release-1.31.x (#939)
  - chore(cd): update base service version to clouddriver:2023.08.28.17.52.39.release-1.31.x (#941)
  - chore(cd): update base service version to clouddriver:2023.08.29.05.45.59.release-1.31.x (#942)
  - chore(cd): update base service version to clouddriver:2023.09.08.18.30.47.release-1.31.x (#968)
  - chore(cd): update base service version to clouddriver:2023.09.20.19.42.06.release-1.31.x (#981)
  - chore(ci): removed aquasec scan action (#971) (#982)
  - fix: CVE-2023-37920 (#977) (#993)
  - chore(feat): Support ARM with docker buildx - SAAS-1953 (backport #999) (#1004)
  - chore(cd): update base service version to clouddriver:2023.11.20.21.43.26.release-1.31.x (#1030)
  - chore(cd): update base service version to clouddriver:2023.11.22.08.49.50.release-1.31.x (#1037)

#### Dinghy™ - 2.30.0...2.31.0

  - chore(ci): removed aquasec scan action (#489) (#491)
  - chore(ci): removing aquasec scans for any push (#497) (#498)
  - chore(feat): Support ARM with docker buildx - SAAS-1953 (backport #504) (#511)
  - fix: Builds (#512) (#515)

#### Armory Fiat - 2.30.0...2.31.0

  - fix(okhttp): Decrypt properties before creating client. (#501)
  - chore(cd): update base service version to fiat:2023.07.21.15.45.35.release-1.30.x (#496)
  - chore(cd): update armory-commons version to 3.13.5 (#478)
  - chore(cd): update armory-commons version to 3.13.3 (#475)
  - chore(cd): update armory-commons version to 3.13.2 (#471)
  - chore(cd): update base service version to fiat:2023.04.05.11.36.40.release-1.30.x (#470)
  - chore(cd): update armory-commons version to 3.13.1 (#456)
  - chore(cd): update base service version to fiat:2023.02.20.19.50.58.master (#437)
  - chore(armory-commons): upgrading armory-commons to 3.14.0-rc.3 (#497)
  - chore(cd): update armory-commons version to 3.14.2 (#500)
  - fix(okhttp): Decrypt properties before creating client. (#501) (#504)
  - chore(ci): removed aquasec scan action (#523) (#525)
  - chore(feat): Support ARM with docker buildx - SAAS-1953 (#540) (#541)
  - chore(cd): update base service version to fiat:2023.08.28.17.11.42.release-1.31.x (#519)

#### Armory Igor - 2.30.0...2.31.0

  - chore(cd): update armory-commons version to 3.13.3 (#452)
  - chore(cd): update armory-commons version to 3.13.2 (#449)
  - chore(cd): update base service version to igor:2023.04.07.01.27.38.release-1.30.x (#448)
  - chore(cd): update armory-commons version to 3.13.1 (#431)
  - chore(cd): update base service version to igor:2022.09.14.15.59.58.master (#368)
  - chore(cd): update armory-commons version to 3.14.2 (#475)
  - chore(ci): removed aquasec scan action (#495) (#507)
  - chore(feat): Support ARM with docker buildx - SAAS-1953 (#524) (#525)
  - fix: NoSuchMethodError exception in JenkinsClient. (#377) (#529)
  - chore(cd): update base service version to igor:2023.08.29.04.59.43.release-1.31.x (#488)

#### Armory Echo - 2.30.0...2.31.0

  - chore(cd): update armory-commons version to 3.13.5 (#583)
  - chore(cd): update armory-commons version to 3.13.4 (#580)
  - chore(cd): update armory-commons version to 3.13.3 (#578)
  - chore(cd): update armory-commons version to 3.13.2 (#575)
  - chore(cd): update base service version to echo:2023.04.07.01.30.15.release-1.30.x (#573)
  - chore(cd): update base service version to echo:2023.04.05.11.38.02.release-1.30.x (#572)
  - chore(cd): update armory-commons version to 3.13.1 (#558)
  - chore(cd): update base service version to echo:2023.02.20.21.09.15.master (#539)
  - chore(cd): update armory-commons version to 3.14.2 (#601)
  - chore(ci): removed aquasec scan action (#618) (#621)
  - chore(cd): update base service version to echo:2023.08.29.05.00.24.release-1.31.x (#612)
  - chore(feat): Support ARM with docker buildx - SAAS-1953 (backport #637) (#640)
  - fix: Upgrade grpc-netty-shaded to address the service initialization failure issue. (#647) (#648)

#### Armory Kayenta - 2.30.0...2.31.0

  - chore(cd): update armory-commons version to 3.13.5 (#439)
  - fix: Remove whitespace when defining spring properties (#437) (#438)
  - fix(config): add missing exclude spring config (#435) (#436)
  - fix: Update path of main class. (#432)
  - chore(refactoring): refactored setting default system properties (#429)
  - chore(cd): update armory-commons version to 3.13.3 (#428)
  - chore(cd): update base service version to kayenta:2023.04.13.23.42.23.release-1.30.x (#427)
  - chore(cd): update armory-commons version to 3.13.2 (#424)
  - chore(cd): update base service version to kayenta:2023.01.24.16.10.35.master (#387)
  - fix: Update path of main class. (#432) (#433)
  - fix(config): add missing exclude spring config (#435)
  - fix: Remove whitespace when defining spring properties (#437)
  - chore(cd): update armory-commons version to 3.14.2 (#456)
  - chore(ci): removed aquasec scan action (#469) (#470)
  - Update buildx for build gradle and action workflow (#484) (#485)
  - chore(cd): update base service version to kayenta:2023.08.29.15.29.59.release-1.31.x (#464)

#### Armory Deck - 2.30.0...2.31.0

  - chore(cd): update base deck version to 2023.0.0-20230621174859.release-1.30.x (#1335)
  - chore(cd): update base deck version to 2023.0.0-20230321144223.release-1.30.x (#1331)
  - chore(cd): update base deck version to 2023.0.0-20230220132814.master (#1300)
  - chore(alpine): Upgrade alpine version (#1302)
  - chore(cd): update base deck version to 2023.0.0-20230308202716.master (#1305)
  - chore(cd): update base deck version to 2023.0.0-20230309231023.master (#1306)
  - chore(cd): update base deck version to 2023.0.0-20230310120132.master (#1307)
  - chore(cd): update base deck version to 2023.0.0-20230315120430.master (#1308)
  - chore(cd): update base deck version to 2023.0.0-20230321144223.master (#1309)
  - chore(cd): update base deck version to 2023.0.0-20230329194405.master (#1310)
  - chore(cd): update base deck version to 2023.0.0-20230330162636.master (#1311)
  - chore(cd): update base deck version to 2023.0.0-20230331215046.master (#1312)
  - chore(cd): update base deck version to 2023.0.0-20230331223352.master (#1313)
  - chore(cd): update base deck version to 2023.0.0-20230331235900.master (#1317)
  - chore(cd): update base deck version to 2023.0.0-20230401002322.master (#1318)
  - chore(build): only run security scans on PR merge (#1319)
  - chore(cd): update base deck version to 2023.0.0-20230401030506.master (#1320)
  - chore(cd): update base deck version to 2023.0.0-20230402044748.master (#1322)
  - chore(cd): update base deck version to 2023.0.0-20230402051752.master (#1323)
  - chore(cd): update base deck version to 2023.0.0-20230402053723.master (#1324)
  - chore(cd): update base deck version to 2023.0.0-20230403112432.master (#1325)
  - chore(ci): removed aquasec scan action (#1340) (#1344)
  - chore(alpine): Fix Deck to support ARM processor - SAAS-1953 (backport #1341) (#1355)
  - fix(action): upgrade node version to match OSS (#1356) (#1357)
  - chore(cd): update base deck version to 2023.0.0-20231018060056.release-1.31.x (#1361)
  - chore(cd): update base deck version to 2023.0.0-20231024154256.release-1.31.x (#1363)

#### Armory Orca - 2.30.0...2.31.0

  - chore(cd): update base orca version to 2023.06.29.14.44.25.release-1.30.x (#658)
  - chore(cd): update base orca version to 2023.06.20.15.55.26.release-1.30.x (#656)
  - chore(cd): update base orca version to 2023.05.18.14.27.05.release-1.30.x (#644)
  - chore(cd): update armory-commons version to 3.13.5 (#642)
  - chore(cd): update armory-commons version to 3.13.4 (#637)
  - chore(cd): update armory-commons version to 3.13.3 (#635)
  - chore(build): Backport missing build changes (#634)
  - chore(cd): update armory-commons version to 3.13.2 (#630)
  - chore(cd): update base orca version to 2023.04.07.01.52.33.release-1.30.x (#629)
  - chore(cd): update armory-commons version to 3.13.1 (#613)
  - chore(cd): update base orca version to 2022.04.01.22.15.58.master (#459)
  - chore(cd): update armory-commons version to 3.14.2 (#671)
  - chore(cd): update base orca version to 2023.07.21.15.43.04.release-1.31.x (#675)
  - chore(cd): update base orca version to 2023.08.28.20.04.29.release-1.31.x (#687)
  - chore(cd): update base orca version to 2023.08.29.05.07.45.release-1.31.x (#688)
  - chore(ci): removed aquasec scan action (#695) (#705)
  - chore(cd): update base orca version to 2023.09.22.14.30.27.release-1.31.x (#711)
  - chore(cd): update base orca version to 2023.09.22.18.05.39.release-1.31.x (#714)
  - chore(ci): removing docker build and aquasec scans (#715)
  - fix(terraformer): Ignoring logs from the Terraformer stage context (#740) (#742)
  - chore(cd): update base orca version to 2023.10.10.16.08.51.release-1.31.x (#743)
  - fix(ci): added release.version to docker build (#745)
  - chore(feat): Support ARM with docker buildx - SAAS-1953 (backport #704) (#746)
  - chore(cd): update base orca version to 2023.10.18.06.01.58.release-1.31.x (#751)
  - chore(cd): update base orca version to 2023.11.06.18.16.18.release-1.31.x (#763)
  - chore(cd): update base orca version to 2023.11.07.16.19.53.release-1.31.x (#765)
  - chore(build): trigger 2.31.x build (#777)


### Spinnaker


#### Spinnaker Gate - 1.31.3

  - chore(dependencies): Autobump korkVersion (#1649)
  - chore(dependencies): Autobump fiatVersion (#1630)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1634)
  - chore(dependencies): Autobump fiatVersion (#1635)
  - chore(gha): update to docker/login-action@v2 to stay up to date (#1636)
  - chore(dependencies): Autobump korkVersion (#1637)
  - chore(dependencies): Autobump fiatVersion (#1638)
  - feat(gha): configure dependabot to keep github actions up to date (#1639)
  - chore(deps): bump google-github-actions/auth from 0 to 1 (#1641)
  - chore(deps): bump actions/checkout from 2 to 3 (#1642)
  - chore(deps): bump google-github-actions/upload-cloud-storage from 0 to 1 (#1644)
  - chore(deps): bump docker/build-push-action from 3 to 4 (#1640)
  - chore(deps): bump actions/setup-java from 2 to 3 (#1643)
  - chore(gha): replace action for creating github releases (#1645)
  - chore(gha): replace deprecated set-output commands with environment files (#1646)
  - chore(dependencies): Autobump korkVersion (#1647)
  - chore(dependencies): Autobump korkVersion (#1648)
  - chore(dependencies): Autobump korkVersion (#1652)
  - fix(web/test): move GateConfigAuthenticatedRequestFilterTest out of the com.netflix.spinnaker.gate.config package (#1655)
  - chore(dependencies): Autobump korkVersion (#1654)
  - fix(web/test): remove race in FunctionalSpec (#1657)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1658)
  - chore(dependencies): Autobump korkVersion (#1659)
  - chore(dependencies): Autobump korkVersion (#1661)
  - chore(dependencies): Autobump fiatVersion (#1662)
  - chore(dependencies): Autobump korkVersion (#1695)
  - chore(dependencies): Autobump fiatVersion (#1697)
  - fix(cachingFilter: Allow disabling the content caching filter (#1699) (#1701)

#### Spinnaker Front50 - 1.31.3

  - fix(validator): Fix NPE when traffic management is not defined in a deployment manifest (#1253) (#1254)
  - chore(dependencies): Autobump fiatVersion (#1248)
  - chore(dependencies): don't create an autobump PR for halyard on a front50 release branch (#1115) (#1247)
  - chore(dependencies): Autobump korkVersion (#1246)
  - chore(dependencies): Autobump fiatVersion (#1225)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1229)
  - chore(dependencies): Autobump fiatVersion (#1230)
  - chore(gha): update to docker/login-action@v2 to stay up to date (#1231)
  - chore(dependencies): Autobump korkVersion (#1232)
  - chore(dependencies): Autobump fiatVersion (#1233)
  - feat(gha): configure dependabot to keep github actions up to date (#1234)
  - chore(deps): bump actions/checkout from 2 to 3 (#1235)
  - chore(deps): bump google-github-actions/upload-cloud-storage from 0 to 1 (#1238)
  - chore(deps): bump peter-evans/repository-dispatch from 1 to 2 (#1236)
  - chore(deps): bump docker/build-push-action from 3 to 4 (#1237)
  - chore(deps): bump actions/setup-java from 2 to 3 (#1239)
  - chore(gha): replace action for creating github releases (#1240)
  - chore(deps): bump google-github-actions/auth from 0 to 1 (#1242)
  - chore(dependencies): Autobump korkVersion (#1243)
  - chore(dependencies): Autobump korkVersion (#1244)
  - chore(gha): replace deprecated set-output commands with environment files (#1241)
  - chore(dependencies): Autobump korkVersion (#1245)
  - chore(dependencies): Autobump korkVersion (#1250)
  - feat(core + sql): Optimize cache refresh (#1249)
  - feat(pipelines): add new GET /pipelines/triggeredBy/{id:.+}/{status} endpoint (#1251)
  - feat(web): add optional query params to the GET /pipelines endpoint (#1252)
  - fix(validator): Fix NPE when traffic management is not defined in a deployment manifest (#1253)
  - chore(dependencies): Autobump korkVersion (#1255)
  - perf(sql): add index on last_modified_at (#1256)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1258)
  - refactor(deprecation): remove deprecated gradle constructs/features from front50 in order to upgrade gradle 7 (#1257)
  - fix(migrations): do not migrate redblack pipelines without stages (#1259)
  - chore(dependencies): Autobump korkVersion (#1262)
  - chore(dependencies): Autobump korkVersion (#1263)
  - chore(dependencies): Autobump fiatVersion (#1264)
  - fix(web): check trigger.getType() for null before invoking equals method (#1277) (#1278)
  - fix(core): tolerate items with null ids (#1276) (#1280)
  - fix(core): skip existing items with null ids in StorageServiceSupport.fetchAllItemsOptimized (#1279) (#1281)
  - chore(dependencies): Autobump korkVersion (#1299)
  - chore(dependencies): Autobump fiatVersion (#1300)
  - fix(dependency): fix dependency version leak of google-api-services-storage from kork in front50-web (#1302) (#1384)

#### Spinnaker Rosco - 1.31.3

  - fix(manifests/test): add org.junit.jupiter:junit-jupiter-engine as a test runtime dependency (#963)
  - chore(dependencies): Autobump spinnakerGradleVersion (#964)
  - chore(gha): update to docker/login-action@v2 to stay up to date (#965)
  - chore(gha): replace action for creating github releases (#966)
  - fix(gha): remove empty env block (#967)
  - fix(gha): remove refs/tags from github release names (#968)
  - chore(gha): use checkout@v3 to stay up to date (#969)
  - feat(gha): configure dependabot to keep github actions up to date (#970)
  - chore(deps): bump google-github-actions/auth from 0 to 1 (#972)
  - chore(deps): bump docker/build-push-action from 3 to 4 (#973)
  - chore(deps): bump google-github-actions/upload-cloud-storage from 0 to 1 (#971)
  - chore(dependencies): Autobump korkVersion (#974)
  - chore(dependencies): Autobump korkVersion (#975)
  - chore(dependencies): Autobump korkVersion (#976)
  - chore(dependencies): Autobump korkVersion (#977)
  - refactor(retrofit2): Use retrofit2.x client instead of retrofit1.9 for artifact fetch from clouddriver (#953)
  - refactor(web/test): V2BakeryControllerWithClouddriverServiceTest cleanup (#979)
  - chore(dependencies): Autobump korkVersion (#981)
  - refactor(retrofit2): use retrofit2 client to clouddriver API calls instead of retrofit1.9 (#980)
  - chore(dependencies): Autobump korkVersion (#982)
  - refactor(manifests): use new methods in manifest exception handling (#983)
  - chore(dependencies): Autobump spinnakerGradleVersion (#985)
  - chore(dependencies): Autobump korkVersion (#987)
  - chore(dependencies): Autobump korkVersion (#988)
  - chore(dependencies): Autobump korkVersion (#1014)
  - feat(helm/bake): Add additional input fields where we can fill in details of the APIs versions (#1020) (#1030)

#### Spinnaker Clouddriver - 1.31.3

  - chore(dependencies): Autobump fiatVersion (#5943)
  - fix(metrics): revert metric names to pre-Java (#5936) (#5942)
  - chore(dependencies): don't create an autobump PR for halyard on a clouddriver release branch (#5677) (#5939)
  - chore(dependencies): Autobump korkVersion (#5938)
  - chore(dependencies): Autobump fiatVersion (#5912)
  - chore(dependencies): Autobump spinnakerGradleVersion (#5918)
  - chore(dependencies): Autobump fiatVersion (#5919)
  - chore(gha): update to docker/login-action@v2 to stay up to date (#5920)
  - chore(dependencies): Autobump korkVersion (#5921)
  - chore(dependencies): Autobump fiatVersion (#5922)
  - feat(gha): configure dependabot to keep github actions up to date (#5923)
  - chore(deps): bump actions/cache from 2 to 3 (#5926)
  - chore(deps): bump actions/checkout from 2 to 3 (#5924)
  - chore(gha): replace action for creating github releases (#5929)
  - chore(deps): bump peter-evans/repository-dispatch from 1 to 2 (#5925)
  - chore(deps): bump actions/setup-java from 2 to 3 (#5928)
  - chore(deps): bump docker/build-push-action from 3 to 4 (#5927)
  - chore(gha): replace deprecated set-output commands with environment files (#5930)
  - chore(deps): bump github/codeql-action from 1 to 2 (#5932)
  - chore(deps): bump google-github-actions/upload-cloud-storage from 0 to 1 (#5931)
  - chore(deps): bump google-github-actions/auth from 0 to 1 (#5933)
  - chore(dependencies): Autobump korkVersion (#5934)
  - chore(dependencies): Autobump korkVersion (#5935)
  - chore(dependencies): Autobump korkVersion (#5937)
  - fix(metrics): revert metric names to pre-Java (#5936)
  - chore(dependencies): Autobump korkVersion (#5944)
  - chore(dependencies): Autobump korkVersion (#5946)
  - fix(aws): standardize retry logic in LocalFileUserDataProvider.isLegacyUdf (#5947)
  - feat(kubernetes): skip checking and allow operations on all kinds (#5949)
  - chore(dependencies): Autobump spinnakerGradleVersion (#5951)
  - refactor(deprecation): remove deprecated gradle constructs/features from clouddriver in order to upgrade gradle 7 (#5950)
  - chore(dependencies): Autobump korkVersion (#5952)
  - fix(aws): ECS Service Tagging broken (#5954)
  - chore(dependencies): Autobump korkVersion (#5961)
  - chore(dependencies): Autobump fiatVersion (#5962)
  - fix(gce): remove the duplicate cache attribute "subnet" and update the test (#5977) (#5984)
  - fix(builds): Backport flag for installing aws cli (#6009)
  - chore(dependencies): Autobump korkVersion (#6010)
  - chore(dependencies): Autobump fiatVersion (#6011)
  - fix: Fix docker build in GHA by removing some of the GHA tools (#6033) (#6036)
  - fix(lambda): Lambda is leaking threads on agent refreshes.  remove the custom threadpool (#6048) (#6049)
  - fix(cats): passing incorrect redis config into interval provider (#6105) (#6108)
  - feat(gcp): provide a configurable option to bypass gcp account health check. (backport #6093) (#6097)

#### Spinnaker Fiat - 1.31.3

  - chore(dependencies): Autobump korkVersion (#1050)
  - chore(dependencies): Autobump korkVersion (#1033)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1035)
  - feat(exceptions): Add SpinnakerRetrofitErrorHandler and replace RetrofitError catch blocks (#1034)
  - chore(gha): update to docker/login-action@v2 to stay up to date (#1036)
  - chore(dependencies): Autobump korkVersion (#1037)
  - feat(gha): configure dependabot to keep github actions up to date (#1038)
  - chore(deps): bump actions/setup-java from 2 to 3 (#1039)
  - chore(deps): bump google-github-actions/upload-cloud-storage from 0 to 1 (#1040)
  - chore(deps): bump actions/checkout from 2 to 3 (#1043)
  - chore(deps): bump peter-evans/repository-dispatch from 1 to 2 (#1041)
  - chore(deps): bump google-github-actions/auth from 0 to 1 (#1042)
  - chore(gha): replace action for creating github releases (#1044)
  - chore(gha): replace deprecated set-output commands with environment files (#1045)
  - chore(deps): bump docker/build-push-action from 3 to 4 (#1046)
  - chore(dependencies): Autobump korkVersion (#1047)
  - chore(dependencies): Autobump korkVersion (#1048)
  - chore(dependencies): Autobump korkVersion (#1049)
  - chore(dependencies): Autobump korkVersion (#1051)
  - chore(dependencies): Autobump korkVersion (#1052)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1054)
  - refactor(test): prefix redis:5-alpine images with library/ (#1055)
  - chore(dependencies): Autobump korkVersion (#1056)
  - chore(dependencies): Autobump korkVersion (#1057)
  - fix(roles-sync): fix CallableCache's NPE exception for caching synchronization strategy (#1077) (#1081)
  - fix(ssl): Removed unused deprecated okHttpClientConfig from retrofitConfig. (#1082) (#1092)
  - chore(dependencies): Autobump korkVersion (#1095)

#### Spinnaker Igor - 1.31.3

  - chore(dependencies): Autobump korkVersion (#1120)
  - chore(dependencies): Autobump fiatVersion (#1099)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1103)
  - chore(dependencies): Autobump fiatVersion (#1105)
  - chore(gha): update to docker/login-action@v2 to stay up to date (#1106)
  - chore(dependencies): Autobump korkVersion (#1107)
  - chore(dependencies): Autobump fiatVersion (#1108)
  - feat(gha): configure dependabot to keep github actions up to date (#1109)
  - chore(deps): bump actions/setup-java from 2 to 3 (#1111)
  - chore(deps): bump google-github-actions/upload-cloud-storage from 0 to 1 (#1110)
  - chore(deps): bump google-github-actions/auth from 0 to 1 (#1112)
  - chore(deps): bump docker/build-push-action from 2 to 4 (#1114)
  - chore(deps): bump actions/checkout from 2 to 3 (#1113)
  - chore(gha): replace action for creating github releases (#1115)
  - chore(gha): replace deprecated set-output commands with environment files (#1116)
  - chore(dependencies): Autobump korkVersion (#1117)
  - chore(dependencies): Autobump korkVersion (#1118)
  - chore(dependencies): Autobump korkVersion (#1119)
  - chore(dependencies): Autobump korkVersion (#1122)
  - chore(dependencies): Autobump korkVersion (#1123)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1127)
  - feat(travis): Add another Travis termination string (#1131)
  - chore(dependencies): Autobump korkVersion (#1132)
  - chore(dependencies): Autobump korkVersion (#1133)
  - chore(dependencies): Autobump fiatVersion (#1134)
  - chore(dependencies): Autobump korkVersion (#1162)
  - chore(dependencies): Autobump fiatVersion (#1163)

#### Spinnaker Echo - 1.31.3

  - chore(dependencies): Autobump korkVersion (#1288)
  - chore(dependencies): Autobump fiatVersion (#1268)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1272)
  - chore(dependencies): Autobump fiatVersion (#1273)
  - chore(gha): update to docker/login-action@v2 to stay up to date (#1274)
  - chore(dependencies): Autobump korkVersion (#1275)
  - chore(dependencies): Autobump fiatVersion (#1276)
  - feat(gha): configure dependabot to keep github actions up to date (#1277)
  - chore(deps): bump docker/build-push-action from 2 to 4 (#1279)
  - chore(deps): bump google-github-actions/auth from 0 to 1 (#1280)
  - chore(deps): bump google-github-actions/upload-cloud-storage from 0 to 1 (#1278)
  - chore(deps): bump actions/setup-java from 2 to 3 (#1282)
  - chore(deps): bump actions/checkout from 2 to 3 (#1281)
  - chore(gha): replace action for creating github releases (#1283)
  - chore(gha): replace deprecated set-output commands with environment files (#1284)
  - chore(dependencies): Autobump korkVersion (#1285)
  - chore(dependencies): Autobump korkVersion (#1286)
  - chore(dependencies): Autobump korkVersion (#1287)
  - chore(dependencies): Autobump korkVersion (#1291)
  - feat(pipelinetriggers): only cache enabled pipelines with enabled triggers of specific types (#1292)
  - chore(dependencies): Autobump korkVersion (#1293)
  - chore(dependencies): Autobump spinnakerGradleVersion (#1296)
  - chore(dependencies): Autobump korkVersion (#1297)
  - chore(dependencies): Autobump korkVersion (#1298)
  - chore(dependencies): Autobump fiatVersion (#1299)
  - fix(gha): Fix github status log and add tests (#1316) (#1318)
  - chore(dependencies): Autobump korkVersion (#1333)
  - chore(dependencies): Autobump fiatVersion (#1334)

#### Spinnaker Kayenta - 1.31.3

  - fix(signalfx): Fixed metric type missing due to duplicated field from parent class (#957) (#958)
  - chore(dependencies): Autobump orcaVersion (#956)
  - chore(dependencies): Autobump orcaVersion (#941)
  - chore(dependencies): Autobump spinnakerGradleVersion (#945)
  - chore(gha): update to docker/login-action@v2 to stay up to date (#946)
  - chore(dependencies): Autobump orcaVersion (#947)
  - feat(gha): configure dependabot to keep github actions up to date (#948)
  - chore(deps): bump actions/checkout from 2 to 3 (#949)
  - chore(deps): bump google-github-actions/upload-cloud-storage from 0 to 1 (#950)
  - chore(deps): bump google-github-actions/auth from 0 to 1 (#953)
  - chore(deps): bump actions/setup-java from 2 to 3 (#951)
  - chore(deps): bump docker/build-push-action from 3 to 4 (#952)
  - chore(gha): replace action for creating github releases (#954)
  - chore(gha): replace deprecated set-output commands with environment files (#955)
  - feat: SPLAT-582: Add a storage data migrator. (#940)
  - fix(signalfx): Fixed metric type missing due to duplicated field from parent class (#957)
  - feat: Add API endpoint to remove account credentials by account name(id) (#939)
  - chore(dependencies): Autobump spinnakerGradleVersion (#960)
  - refactor(deprecation): remove deprecated gradle constructs/features from kayenta in order to upgrade gradle 7 (#961)
  - chore(dependencies): Autobump orcaVersion (#966)
  - fix(orca): Fix orca contributors status. (backport #977) (#980)
  - chore(dependencies): Autobump orcaVersion (#983)

#### Spinnaker Deck - 1.31.3

  - Publish packages to NPM (#9955)
  - chore(dependencies): Autobump spinnakerGradleVersion (#9957)
  - chore(gha): update to docker/login-action@v2 to stay up to date (#9958)
  - chore(gha): replace deprecated set-output commands (#9952)
  - feat(gha): configure dependabot to keep github actions up to date (#9959)
  - chore(deps): bump actions/github-script from 0.9.0 to 6.4.0 (#9962)
  - chore(deps): bump google-github-actions/upload-cloud-storage from 0 to 1 (#9966)
  - chore(deps): bump peter-evans/create-pull-request from 3 to 4 (#9964)
  - chore(deps): bump docker/build-push-action from 3 to 4 (#9963)
  - chore(deps): bump google-github-actions/auth from 0 to 1 (#9965)
  - chore(gha): replace action for creating github releases (#9961)
  - chore(deps): bump actions/setup-node from 1 to 3 (#9967)
  - chore(deps): bump actions/cache from 1 to 3 (#9970)
  - chore(deps): bump actions/setup-java from 2 to 3 (#9969)
  - chore(deps): bump actions/checkout from 2 to 3 (#9968)
  - fix: UI crashes when running pipeline(s) with many stages. (#9960)
  - Publish packages to NPM (#9972)
  - chore(build): update to Node 14 and es2019 (#9981)
  - chore(build): fix typo in GHA (#9982)
  - Node 14 fix (#9983)
  - feat(provider/google): Added Cloud Run manifest functionality in Deck. (#9971)
  - chore(deps): bump peter-evans/create-pull-request from 4 to 5 (#9985)
  - chore(deps): bump actions/github-script from 6.4.0 to 6.4.1 (#9986)
  - Publish packages to NPM (#9984)
  - update(rolling red/black) remove experimental label (#9987)
  - fix(angular): fix missed AngularJS bindings (#9989)
  - Publish packages to NPM (#9990)
  - fix(ecs): VPC Subnet dropdown fix in ecs server group creation.
  - feat(deck): make StageFailureMessage component overridable (#9994)
  - chore(build): fix package bump PR action (#9995)
  - Publish packages to NPM (#9993)
  - chore(dependencies): Autobump spinnakerGradleVersion (#9996)
  - fix(core/pipeline): Pipeline builder-pipeline action dropdown closing not properly (#9999)
  - feat(icons): allow plugins to provide custom icon components (#10001)
  - Publish packages to NPM (#10000)
  - Revert "fix(core): conditionally hide expression evaluation warning messages (#9771)" (#10021) (#10023)
  - fix: Scaling bounds should parse float not int (#10026) (#10032)
  - feat(helm/bake): Add additional input fields where we can fill in details of the APIs versions (#10036) (#10047)
  - fix: Updating Lambda functions available Runtimes (#10055)

#### Spinnaker Orca - 1.31.3

  - fix(queue): fix ability to cancel a zombied execution (#4473) (#4478)
  - fix(queue): Manual Judgment propagation (#4474)
  - fix(deployment): fixed missing namespace while fetching manifest details from clouddriver (#4453) (#4457)
  - chore(dependencies): Autobump korkVersion (#4444) (#4446)
  - chore(dependencies): Autobump korkVersion (#4444)
  - chore(dependencies): Autobump fiatVersion (#4417)
  - Fix/manual judgment concurrent execution (#4410)
  - chore(dependencies): Autobump spinnakerGradleVersion (#4427)
  - chore(dependencies): Autobump fiatVersion (#4428)
  - chore(gha): update to docker/login-action@v2 to stay up to date (#4429)
  - chore(dependencies): Autobump korkVersion (#4430)
  - chore(dependencies): Autobump fiatVersion (#4431)
  - feat(gha): configure dependabot to keep github actions up to date (#4432)
  - chore(deps): bump peter-evans/create-pull-request from 3 to 4 (#4433)
  - chore(deps): bump google-github-actions/upload-cloud-storage from 0 to 1 (#4436)
  - chore(deps): bump docker/build-push-action from 3 to 4 (#4435)
  - chore(deps): bump google-github-actions/auth from 0 to 1 (#4437)
  - chore(deps): bump actions/setup-java from 2 to 3 (#4434)
  - chore(gha): replace action for creating github releases (#4438)
  - chore(deps): bump peter-evans/repository-dispatch from 1 to 2 (#4440)
  - chore(deps): bump actions/checkout from 2 to 3 (#4441)
  - chore(dependencies): Autobump korkVersion (#4442)
  - chore(dependencies): Autobump korkVersion (#4443)
  - chore(gha): replace deprecated set-output commands with environment files (#4439)
  - chore(dependencies): Autobump korkVersion (#4447)
  - feat(front50): call front50's GET /pipelines/triggeredBy/{pipelineId}/{status} endpoint (#4448)
  - chore(deps): bump peter-evans/create-pull-request from 4 to 5 (#4450)
  - chore(dependencies): Autobump korkVersion (#4451)
  - fix(waiting-executions) : concurrent waiting executions doesn't follow FIFO (#4415)
  - fix(deployment): fixed missing namespace while fetching manifest details from clouddriver (#4453)
  - chore(dependencies): Autobump spinnakerGradleVersion (#4458)
  - chore(dependencies): Autobump korkVersion (#4459)
  - chore(dependencies): Autobump korkVersion (#4461)
  - chore(dependencies): Autobump fiatVersion (#4464)
  - fix(queue): fix ability to cancel a zombied execution (#4473) (#4477)
  - fix(artifacts): consider requiredArtifactIds in expected artifacts when trigger is pipeline type (#4489) (#4491)
  - chore(dependencies): Autobump korkVersion (#4513)
  - chore(dependencies): Autobump fiatVersion (#4514)
  - fix: duplicate entry exception for correlation_ids table. (#4521) (#4531)
  - fix(vpc): add data annotation to vpc (#4534) (#4537)
  - fix(front50): teach MonitorPipelineTask to handle missing/null execution ids (#4555) (#4561)
  - feat(helm/bake): Add additional input fields where we can fill in details of the APIs versions (#4546) (#4564)
  - fix(artifacts): Parent and child pipeline artifact resolution (backport #4575) (#4582)
  - fix(artifacts): Automated triggers with artifact constraints are broken if you have 2 or more of the same type (backport #4579) (#4587)

