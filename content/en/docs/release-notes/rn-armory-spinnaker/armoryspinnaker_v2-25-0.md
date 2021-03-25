---
title: v2.25.0 Armory Release (OSS Spinnaker™ v1.25.3)
toc_hide: true
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping --> 
description: >
  Release notes for the Armory Platform
---

## 2021/03/120 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.25.0, use one of the following tools:

- Armory-extended Halyard <PUT IN A VERSION NUMBER> or later
- Armory Operator <PUT IN A VERSION NUMBER> or later

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->




###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.25.3](https://www.spinnaker.io/community/releases/versions/1-25-3-changelog) changelog for details.

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

