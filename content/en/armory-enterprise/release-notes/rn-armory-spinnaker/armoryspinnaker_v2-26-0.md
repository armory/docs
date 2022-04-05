---
title: v2.26.0 Armory Enterprise Release (OSS Spinnaker™ v1.26.3)
toc_hide: true
version: 02.26.00
description: >
  Release notes for Armory Enterprise v2.26.0
---

## 2021/05/20 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

For information about what Armory supports for this version, see the [Armory Enterprise v2.26 compatibility matrix](https://v2-26.docs.armory.io/docs/feature-status/armory-enterprise-matrix/).

## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.26.0, use one of the following tools:

- Armory-extended Halyard 1.12 or later
  - 2.26.x is the last minor release that you can use Halyard to install or manage. Future releases require the Armory Operator. For more information, see [Halyard Deprecation]({{< ref "halyard-deprecation" >}}).
- Armory Operator 1.2.6 or later

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

#### Suffixes for the Kubernetes Run Job stage

The `kubernetes.jobs.append-suffix` parameter no longer works. The removal of this parameter was previously announced as part of a [breaking change](https://docs.armory.io/docs/release-notes/rn-armory-spinnaker/armoryspinnaker_v2-22-0/#suffix-no-longer-added-to-jobs-created-by-kubernetes-run-job-stage) in Armory 2.22.

To continue adding a random suffix to jobs created by the Kubernetes Run Job stage, use the `metadata.generateName` field in your Kubernetes job manifests. For more information, see [Generated values](https://kubernetes.io/docs/reference/using-api/api-concepts/#generated-values).

{{< include "breaking-changes/bc-k8s-version-pre1-16.md" >}}

{{< include "breaking-changes/bc-k8s-infra-buttons.md" >}}

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

{{< include "known-issues/ki-bake-var-file.md" >}}
{{< include "known-issues/ki-lambda-ui-caching.md" >}}
{{< include "known-issues/ki-artifact-binding-spel.md" >}}
{{< include "known-issues/ki-dinghy-pipelineID.md" >}}

#### Pipelines as Code
<!-- maybe: BOB-30287 yes:BOB-30274 PUX-405-->
If you experiencing issues with Pipelines as Code after upgrading to 2.26.0, upgrade to 2.26.1 when it is available.

## Fixed issues

* Fixed an issue where you could not edit AWS server groups with the **Edit** button in the UI. The edit window closed immediately after you opened it.
* Fixed an issue where names for ECS server groups were not being recognized.
* Fixed an issue where the first deployment of a manifest that used a blue/green strategy failed to find the service load balancer. This occurred if the service is in the same manifest as the workload getting deployed.
* Fixed an issue where an error occurred when deleting a CRD through the UI.
* Fixed an issue where some caching agents for the SQL agent scheduler never executed. This could lead to the UI not reflecting changes caused by pipelines or pipelines not running if they were configured to use a Docker trigger. This issue affected all cloud providers and Docker triggers.
* Fixed an issue in the Deploy stage when the Docker container was selected and image was set, the artifact information was not saved in JSON format. Now the  artifact information is written to the `expectedArtifact` attribute.

## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->

### Artifacts - Git repo

The Git repo artifact provider has been improved.

#### SHA support

The Git repo provider can now checkout SHAs. Previously, the provider could only checkout branches.

#### Caching Git repo artifacts

The provider can now cache Git repo artifacts. Clouddriver, the service that connects to artifact providers, clones the Git repo the first time a pipeline needs it and then caches the repo for a configured retention time. Each subsequent time the pipeline needs to use that Git repo artifact, Clouddriver does a `git pull` to fetch updates rather than cloning the entire repo again. This behavior is especially useful if you have a large repo.

Clouddriver deletes the cloned Git repo when the configured retention time expires.

This is an opt-in feature that is disabled by default. See [Enable git pull support](https://spinnaker.io/setup/artifacts/gitrepo/#enable-git-pull-support) for how to enable and configure this feature.

### Application metrics for Canary Analysis

The Dynatrace integration for Canary Analysis now supports the `resolution` parameter for queries. This parameter is optional. Here is an example query that contains the resolution:

`parameter`: `metricSelector=ext:dyna.test.memory:filter(eq(namespace,${location}))&resolution=10m`

For more information, see [Get Data Points](https://www.dynatrace.com/support/help/dynatrace-api/environment-api/metric-v2/get-data-points/).

### Cloud Foundry

* General performance improvements.
* Improved the resiliency of the Cloud Foundry provider by adding retries when a socket timeout occurs.
* Armory Enterprise now supports configuration options related to timeouts. To use these timeouts, add the following snippet to `clouddriver-local`.yml (Halyard) or the `cloudfoundry` section of your SpinnakerService manifest (Operator):

   ```yaml
   cloudfoundry:
     client:
       readtimeout: 5000ms # Replace with the timeout you want to use
       writetimeout: 5000ms # Replace with the timeout you want to use
       connectiontimeout: 5000ms # Replace with the timeout you want to use
       retries: 3 # Replace with the number of retries you want to use
   ```

- Improved the observability for the Cloud Foundry provider. You can see metrics related to Cloud Foundry through the tool you use for observability into the performance of Armory Enterprise. Look for metrics that start with the following: `cf.okhttp.requests`.

### Performance

Improved start times for air-gapped environments by fixing an issue that caused the `enableDefaultRepositories` config to not work. This led to a situation where air-gapped environments had to wait for the timeout. The config works now. If you set `enableDefaultRepositories` to false, Armory Enterprise no longer attempts to connect to the plugin repositories maintained by the Spinnaker community.

### Plugin framework

The following changes to the Plugin Framework may affect you if you are developing plugins for Armory Enterprise or Spinnaker:

- If you depend on Spinnaker jars, you need to change your dependency coordinates from `com.netflix.spinnaker.<service>` to `io.spinnaker.<service>`.
- When working on Deck, you can now replace the literal `process.env.NODE_ENV` with the current environment variable value. This is useful for libraries such as React that expect this to be set to production or development.

### Terraform Integration stage

- The integration now supports Terraform versions up to 0.15.1.
- The container for the Terraformer service now includes the GCloud SDK and `anthos-cli`.
- All the Terraform binaries bundled as part of the integration have been updated in accordance with [HCSEC-2021-12](https://discuss.hashicorp.com/t/terraform-updates-for-hcsec-2021-12/23570) to address potential issues from the Codecov incident.


###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.26.3](https://spinnaker.io/changelogs/1.26.3-changelog/) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.26.0
timestamp: "2021-05-20 02:28:34"
services:
    clouddriver:
        commit: e4612edb
        version: 2.26.6
    deck:
        commit: 68f37740
        version: 2.26.5
    dinghy:
        commit: a4c17545
        version: 2.26.1
    echo:
        commit: 6c7077ba
        version: 2.26.5
    fiat:
        commit: d5ddf6e9
        version: 2.26.6
    front50:
        commit: d08d6cc1
        version: 2.26.7
    gate:
        commit: e77d91d7
        version: 2.26.5
    igor:
        commit: ee5df451
        version: 2.26.6
    kayenta:
        commit: 3ea94181
        version: 2.26.5
    monitoring-daemon:
        version: 2.26.0
    monitoring-third-party:
        version: 2.26.0
    orca:
        commit: 157b115a
        version: 2.26.12
    rosco:
        commit: 2187403f
        version: 2.26.8
    terraformer:
        commit: 8f31c968
        version: 2.26.3
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Deck - 2.25.3...2.26.5

  - feat(terraform): Adds custom marker icon (#747)
  - chore(build): update to 1.25.3 (#761)
  - fix(changelog-link): add value and url (#764)
  - chore(release): update deck for 2.26.x (#775)
  - chore(deps): sync 1.26.3 (#783) (#784)
  - chore(core): disable pipeline tags feature until it's considered stable (#788) (#789)

#### Armory Clouddriver - 2.25.3...2.26.6

  - [create-pull-request] automated change (#296)
  - feat(git): Added git binaries to docker images (#311)
  - chore(githubactions): update aquasec version (#313)
  - [create-pull-request] automated change (#315)
  - [create-pull-request] automated change (#326)
  - [create-pull-request] automated change (#329) (#330)

#### Armory Igor - 2.25.2...2.26.6

  - Update gradle.properties (#209)
  - fix(dependencies): update armory-commons (#221) (#222)

#### Armory Orca - 2.25.2...2.26.12

  - Sync with CD branch, update CD branch with Orca version updates (#233)
  - Update sync_cd.yml (#243)
  - feat(cd): move all cd work to master (#244)
  - fix(cd): fixes workflow and updates init.gradle for new maven coordinates (#245)
  - fix(cd): PR should have a title that title checker will be happy with (#247)
  - chore(cd): update base orca version to 2021.03.24.00.52.35.master (#250)
  - add label to base service update PRs (#251)
  - feat(cd): publish every image to docker registry & openshift (#252)
  - fix(cd): docker images should be named orca-armory, not orca (#255)
  - feat(cd): use latest gradle plugin, images get tagged as armory-io/orca-armory (#257)
  - fix(cd): fix dockerhub login (#258)
  - feat(cd): switch docker ns prefix from armory-io to armory (#260)
  - [create-pull-request] automated change (#261)
  - feat(cloud): adding interceptor for multitenant services (#259)
  - chore(cd): update base orca version to 2021.04.02.21.36.17.master (#263)
  - chore(cd): update base orca version to 2021.04.13.10.30.00.master (#267)
  - chore(cd): auto approve base update pull requests (#270)
  - use Astrolabe's GH token for base update PRs (#273)
  - chore(cd): update base orca version to 2021.04.14.11.40.00.master (#274)
  - feat(cd): use variables action (#275)
  - chore(cd): update base orca version to 2021.04.19.11.07.00.master (#276)
  - chore(cd): update base orca version to 2021.04.21.11.27.00.master (#277)
  - chore(cd): update base orca version to 2021.04.23.02.16.26.master (#278)
  - [create-pull-request] automated change (#280)
  - chore(cd): update base orca version to 2021.4.23.21.50.9.master (#281)
  - [create-pull-request] automated change (#282)
  - chore(build): update group id to match new location (#291)
  - [create-pull-request] automated change (#295)
  - chore(cd): revert invalid baseServiceVersion (#294)
  - chore(cd): update base orca version to 2021.04.28.21.37.41.master (#296)
  - [create-pull-request] automated change (#301) (#302)
  - chore(cd): update base orca version to 2021.05.06.23.02.43.release-1.26.x (#306)
  - chore(cd): handle release branch builds and updates (#305) (#307)
  - chore(cd): test release process
  - chore(cd): fetch full github history on build
  - chore(cd): update base orca version to 2021.05.07.15.54.14.release-1.26.x (#309)

#### Dinghy™ - 2.25.1...2.26.1

  - fix(crash_on_module_updates): remove call to log.fatal() (#366)
  - feat(multi_tenant): refactor internal project to work with multi-tenant  (#375)
  - fix(config): bit more err checking on initial config load (#377)
  - Feat(add_dist_tracing): Enables tracing for internal dinghy (#376)
  - Feat(add_yeti_client): Adds client for pulling remote config from Yeti (#374)
  - Feat(enable_caching_and_yeti_remote_source): Adds the yeti remote source and caching for remote configs.  (#383)
  - chore(oss): bump oss version (#413)
  - chore(dependencies): updating oss version (backport #415) (#416)

#### Armory Fiat - 2.25.3...2.26.6

  - chore(build): Autobump armory-commons: 3.8.1 (#181)
  - [create-pull-request] automated change (#197)
  - [create-pull-request] automated change (#208)
  - [create-pull-request] automated change (#211) (#212)

#### Armory Gate - 2.25.5...2.26.5

  - fix(keel): add default keel endpoints. (#258)
  - chore(githubactions): update aquasec version (#262)
  - [create-pull-request] automated change (#264)
  - [create-pull-request] automated change (#266)
  - chore(build): Autobump armory-commons: 3.9.1 (#268)
  - chore(build): Autobump armory-commons: 3.9.2 (#279)
  - [create-pull-request] automated change (#282) (#283)

#### Armory Rosco - 2.25.2...2.26.8

  - fix(baking): Only try cancelling jobs that are confirmed to exist (#226)
  - fix(inttest): fixing vpc and subnets because recreation (#230)
  - fix(infra): Ignoring K8 test due to Docker Hub rate limits (#233)
  - Update Dockerfile (#236)
  - [create-pull-request] automated change (#234)
  - [create-pull-request] automated change (#246)
  - [create-pull-request] automated change (#249) (#250)
  - fix(timezone): set timezone for tzdata (backport #259) (#261)
  - chore(docker): update rosco baking utilities to match OSS (#253) (#257)

#### Terraformer™ - 2.25.0...2.26.3

  - fix(build): set up Go in github action (#369)
  - chore(build): add gcloud sdk + anthoscli (#374)
  - chore(versions): add terraform 13.6 through 14.10 (#376)
  - security(versions): secure terraform binaries (#390)
  - chore(build): kick off new build (#395)
  - chore(versions): update tf installer to use new hashi keys (#396) (#402)

#### Armory Echo - 2.25.2...2.26.5

  - chore(build): Autobump armory-commons: 3.9.1 (#317)
  - [create-pull-request] automated change (#328)
  - [create-pull-request] automated change (#331) (#332)

#### Armory Front50 - 2.25.2...2.26.7

  - [create-pull-request] automated change (#243)
  - [create-pull-request] automated change (#255)
  - [create-pull-request] automated change (#258) (#259)
  - fix(tests): use artifactory to avoid docker rate limits (#261) (#262)

#### Armory Kayenta - 2.25.2...2.26.5

  - feat(dynatrace): adding support for resolution parameter (#224)
  - feat(build): publish kayenta armory artifacts (#232)
  - [create-pull-request] automated change (#234)
  - chore(build): Autobump armory-commons: 3.9.3 (backport #248) (#249)

