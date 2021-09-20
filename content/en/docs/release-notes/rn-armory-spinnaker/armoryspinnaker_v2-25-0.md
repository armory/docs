---
title: v2.25.0 Armory Release (OSS Spinnaker™ v1.25.3)
toc_hide: true
version: 02.25.00
description: >
  Release notes for Armory Enterprise
---

## 2021/03/25 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

For information about what Armory supports for this version, see the [Armory Enterprise Compatibility Matrix]({{< ref "armory-enterprise-matrix-2-25.md" >}}).

## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.25.0, use one of the following tools:
- Armory-extended Halyard 1.12 or later
- Armory Operator 1.2.6 or later

   For information about upgrading, Operator, see [Upgrade the Operator]({{< ref "op-manage-operator#upgrade-the-operator" >}}).

## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, see the [Support Portal](https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010414). Note that you must be logged in to the portal to see the information.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->
> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.


{{< include "breaking-changes/bc-k8s-job-suffix.md" >}}

<!-- Moved this to Breaking changes instead of KI. Didn't bother renaming it. -->
{{< include "known-issues/ki-orca-zombie-execution.md" >}}

{{< include "breaking-changes/bc-orca-forcecacherefresh.md" >}}

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

{{< include "known-issues/ki-bake-var-file.md" >}}
{{< include "known-issues/ki-lambda-ui-caching.md" >}}

#### Git repo artifact provider cannot checkout SHAs

Only branches are currently supported. For more information, see [6363](https://github.com/spinnaker/spinnaker/issues/6363).

#### Server groups
<!-- ENG-5847 -->
There is a known issue where you cannot edit AWS server groups with the **Edit** button in the UI. The edit window closes immediately after you open it.

**Workaround**: To make changes to your server groups, edit the stage JSON directly by clicking on the **Edit stage as JSON** button.

### Fixed issues

- Fixed an issue where Pipelines as Code fails unexpectedly when updating modules.
- Fixed an issue where usernames were not deduplicated properly because of case sensitivity.
- Fixed a start up issue that occurs when `spinnaker.base-url.www` is not set
- Fixed an issue that occurs when a user enters a value for the **Manifest** field and then deletes it. This caused the resulting stage config to use `"manifest":""`. The manifest now defaults to `spinnaker.yml`.
- Fixed an issue where a Jenkins stage stalls with a "Wait For Jenkins Job Start" message if the stage is canceled and restarted within a certain time frame.

## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->

### Artifacts

#### Improved performance for Git repo artifacts

Armory now uses the git binary instead of jgit. This change adds support for shallow clones, allowing for faster downloads. No changes to existing accounts configuration are needed. Note that there is a known issue related to this change: it does not currently support checkouts using a SHA.

#### Filter for caching Docker registries

Docker accounts now support a new configuration parameter: `repositoriesRegex`. When used, only the repositories that match the pattern get cached. This is useful for Docker accounts that have a large number of repositories or accounts where repositories are added frequently. As repositories are added, you do not need to update the list of repositories that you configured.

This feature requires either Armory Operator 1.2.6 (or later) or Armory-extended Halyard 1.12 (or later). For more information, see [Docker Artifacts]({{< ref "artifacts-docker-connect.md" >}}).

### Authz

Access to a service account is now granted if any authorization predicate allows it. The previous behavior 

### Baking images

The Packer version that is bundled with Rosco, the baking service, has been updated. Rosco now supports the AWS parameter `assume_role` in Packer templates.

### CI system

#### Jenkins

The integration between Armory and Jenkins has been improved: 

* You can configure the orchestration service Orca so that it updates the description of a running Jenkins build and generates a backlink. For more information, see [Enabling Backlinks from Jenkins to Spinnaker](https://spinnaker.io/setup/ci/jenkins/#enabling-backlinks-from-jenkins-to-spinnaker).
* You can now update the job description of a running or completed Jenkins job through the API.

### Clouddriver

Improved the performance of health checks for the Clouddriver pod by running them in different threads. Previously, the Clouddriver pod did not report a Ready state until after all Kubernetes accounts verified connectivity through a kubectl get namespaces call.

### Deployment targets

#### Cloud Foundry

The following improvements have been made to the Cloud Foundry provider:

* Armory now supports the ability to deploy Docker images to Cloud Foundry like any other application. 
* There is a new stage that supports more granular service bindings. More specifically, if a service needs additional information in order to make a binding successful, you can now customize that information in the Service Binding Stage.
* Applications during deployment will now bind to their services before completely building the droplet. This allows the deployments to avoid an additional costly restage operation. Not all applications require restages after binding, but this change improves performance for applications that do require restages. 

### SpEL

Armory now supports the following for SpEL expressions:

- `resolvedArtifacts`, which returns all the resolved stage artifacts
- `canaryConfigNameToId`, which takes a canary config name and converts it to an ID





###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.25.3](https://spinnaker.io/changelogs/1.25.3-changelog/) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.25.0
timestamp: "2021-03-25 09:28:32"
services:
    clouddriver:
        commit: de3aa3f0
        version: 2.25.3
    deck:
        commit: 516bcf0a
        version: 2.25.3
    dinghy:
        commit: 522e67e5
        version: 2.25.1
    echo:
        commit: 3a098acc
        version: 2.25.2
    fiat:
        commit: ca75f0d0
        version: 2.25.3
    front50:
        commit: 502b753e
        version: 2.25.2
    gate:
        commit: "47352833"
        version: 2.25.5
    igor:
        commit: 252dbd5c
        version: 2.25.2
    kayenta:
        commit: "72616529"
        version: 2.25.2
    monitoring-daemon:
        version: 2.25.0
    monitoring-third-party:
        version: 2.25.0
    orca:
        commit: 53f48823
        version: 2.25.2
    rosco:
        commit: 272f4f82
        version: 2.25.2
    terraformer:
        commit: 5dcae243
        version: 2.25.0
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Deck - 2.24.3...2.25.3

  - feat(terraformer): hide sections when output is selected (#712)
  - chore(deps): bump to new OSS 1.24.2 bom (#713)
  - feat(envuuid): send env uuid in header for dinghy events (#715)
  - feat(dinghy): add pull request URL (#718)
  - Fix(Terraform): Console Output UX (#723)
  - fix(terraformer): console logs output enhancement (#725)
  - ES-581: Fixes hamburger menu alignment (#738)
  - feat(dinghy): add new content tab to show processed dinghyfiles.  (#744)
  - feat(dinghyEvents): add author information, refactor code (#745)
  - fix(terraformer): ensure Ignore Locking sets the correct json value (#749)
  - chore(build): update to 1.25.3 (#761) (#762)

#### Armory Clouddriver - 2.24.23...2.25.3

  - feat(docker): adding ecr utility to get an ecr token (#235)
  - fix(dep/springboot): downgrade spring-boot to SR4 (#249)
  - fix(config): reverted spring.profile sytax to SR4 syntax (#251)
  - fix(dependencies): downgrade resilience4j to match OSS (#253)
  - fix(dep/springboot): revert downgrade spring-boot to SR4 (#249) (#257)
  - chore(build): use Armory commons BOM, remove some unused constraints (#271)
  - chore(dependencies): exclude tencent, huawei, oracle, yandex, move junit/logback to bom (#274)
  - chore(build): bump google sdk to fix CVE-2019-17638 and CVE-2020-27216 (#280)
  - feat(git): Added git binaries to docker images (#311) (#312)

#### Armory Orca - 2.24.13...2.25.2

  - chore(build): use armory commons BOM (#208)
  - chore(dependencies): use armory commons bom (#212)

#### Armory Rosco - 2.24.12...2.25.2

  - fix(fargate-job-executor): ensure that aws credentials are refreshed … (#164)
  - fix(fargate): add default to awsIamRole (#167)
  - chore(build): use armory commons bom  (#185)
  - feat(tests): add coveralls test coverage reporting (#174)
  - chore(dependencies): use armory commons bom (#192)
  - fix(test): fix integration tests (#194)
  - chore(fargate): remove caller from remote jobs and update int test infra to us… (#196)
  - fix(build): revert change to gradle GHA build file (#198)
  - fix(fargate-job-executor): Initialize logs to a default message when fargate jobs are initing, fall back to stored logs when there is a failure to get logs from CW (#197)
  - fix(packer-command-factory): Adding a Fargate specific PackerCommandF… (#200)
  - chore(dependencies): removes webjars. (#206)

#### Dinghy™ - 2.24.10...2.25.1

  - feat(sqlsupport): full sql support (#300)
  - feat(parser): sprig functions support (#311)
  - fix(liquibase): liquibase will be executed by dinghy since it has the secrets (#314)
  - fix(validations): pr validations fixes (#317)
  - feat(pullrequest-url): add pullrequest url for dinghy events.  (#323)
  - feat(appmetadata): appmetadata in spec will add those fields to applications (#324)
  - fix(liquibase): Dinghy 2.24 not working in SQL mode (#325)
  - fix(pipelines): Add parameter for SpEl Expression version (#340)
  - feat(Post_multiple_comments_for_lengthy_logs): Breaks up long log messages into multiple GitHub comments to prevent a 422 (#347)
  - chore(infrastructure): manage infrastructure for centralized Dinghy with terraform.  (#350)
  - feat(add_new_relic_support): Added the New Relic agent to dinghy and … (#352)
  - chore(build): bump go-yaml-tools (#343)
  - fix(crash_on_module_updates): adds check to verify a 200 status code on comment post prior to postin the reaction (#358)

#### Armory Gate - 2.24.14...2.25.5

  - chore(dependencies): use armory commons bom (#223)
  - chore(dependencies): exclude test libraries from runtime (#232)
  - test(web): Test health format, remove groovy, spock (#234)
  - fix(test/url): Add urls to tests Spinnaker bump version1615369808 (#257)
  - fix(keel): add default keel endpoints. (#258) (#259)

#### Terraformer™ - 2.24.4...2.25.0

  - chore(metrics): Migrate to Prometheus metrics with go-metrics  (#301)
  - fix(cve): remove scp until OpenSSH_8.4+ is available (#307)
  - feat(metrics): Add Prometheus metrics for artifacts fetched, artifact latency, artif… (#308)
  - Revert "feat(metrics): Add Prometheus metrics for artifacts fetched, artifact latency, artif… (#308)" (#315)
  - fix(metrics): Fix panic caused by disabled metrics in Terraformer config (#317)
  - feat(metrics): add redis persistence metrics (#313)
  - feat(metrics): add persistence loop and job executor metrics (#322)
  - chore(gitrepo): add more tests for tar writing from clouddriver (#310)
  - chore(int-tests): update clouddriver version (#320)
  - feat(tests): add coveralls test coverage (#312)
  - feat(metrics): add redis key miss metrics and fix redis latency metric (#324)
  - fix(tests): gitignore profile.cov file (#323)
  - feat(metrics): Improve executor's oldest job accuracy (#326)
  - chore(metrics): update go-spec to 0.0.3 so gauge metrics won't be prefixed with the host name (#327)
  - fix(cve): Alpine > 3.13 to fix glib and openssh cves (#328)
  - fix(profiles): support passing vars via TF_VAR (#339)
  - chore(logs): go-spec JSON logger refactor (#343)
  - fix(tests): fix code coverage badge on readme (#344)
  - chore(build): bump go-yaml-tools version (#350)
  - fix(build): kick off build (#370)

#### Armory Igor - 2.24.9...2.25.2

  - chore(build): use armory commons bom (#177)
  - feat(tests): add coveralls test coverage reporting (#164)
  - chore(build): rely on armory-commons (#183)
  - chore(build): update scan action version (#195)

#### Armory Echo - 2.24.11...2.25.2

  - feat(dinghy): send environment uuid to dinghy (#263)
  - chore(build): use armory-commons BOM (#282)
  - chore(dependencies): move junit/logback to bom (#285)

#### Armory Fiat - 2.24.12...2.25.3

  - chore(build): use armory commons BOM (#156)
  - chore(dependencies): use armory commons bom (#162)
  - Update gradle.properties (#193)

#### Armory Front50 - 2.24.12...2.25.2

  - chore(build): use armory commons BOM (#202)
  - feat(tests): add coveralls test coverage reporting (#193)
  - chore(dependencies): use armory commons bom (#208)
  - chore(build): upgrade scan action version (#228)

#### Armory Kayenta - 2.24.14...2.25.2

  - fix(cve): fix 2020-5408 force security-core to 5.2.4 (#163)
  - Update gradle.yml
  - fix(test): re adding dynatrace on integration tests (#171)
  - chore(build): use armory commons BOM (#183)
  - chore(dependencies): use armory commons bom (#189)
  - fix(dynatrace): fix parse of datapoints values (#204)
  - fix(dynatrace): add test to verify values conversion (#209)
  - feat(dynatrace): adding support for resolution parameter (#224) (#227)

