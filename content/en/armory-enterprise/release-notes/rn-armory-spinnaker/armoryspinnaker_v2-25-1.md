---
title: v2.25.1 Armory Release (OSS Spinnaker™ v1.25.3)
toc_hide: true
version: 02.25.01
description: >
  Release notes for Armory Enterprise
---

## 2021/12/15 Release Notes

> Note: If you're experiencing production issues after upgrading Armory Enterprise, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

For information about what Armory supports for this version, see the [Armory Enterprise Compatibility Matrix]({{< ref "armory-enterprise-matrix-2-25.md" >}}).

## Required Halyard or Operator version
​
To install, upgrade, or configure Armory 2.25.1, use one of the following tools:
- Armory-extended Halyard 1.12 or later
- Armory Operator 1.2.6 or later
​
   For information about upgrading, Operator, see [Upgrade the Operator]({{< ref "op-manage-operator#upgrade-the-operator" >}}).
​
## Security
​
Armory scans the codebase as we develop and release software. For information about CVE scans for this release, see the [Support Portal](https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010414). Note that you must be logged in to the portal to see the information.

This release includes a security fix. For more information, see the Critical Notification that Armory's Support Team sent out on 14 December 2021, contact your Armory account rep, or see this (login required) Support article: https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010520.
​
## Breaking changes

>Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.


{{< include "breaking-changes/bc-k8s-job-suffix.md" >}}
​
{{< include "known-issues/ki-orca-zombie-execution.md" >}}
​
{{< include "breaking-changes/bc-orca-forcecacherefresh.md" >}}
​
## Known issues
​
{{< include "known-issues/ki-bake-var-file.md" >}}
{{< include "known-issues/ki-lambda-ui-caching.md" >}}
{{< include "known-issues/ki-dinghy-pipelineID.md" >}}
​
​
#### Git repo artifact provider cannot checkout SHAs
​
Only branches are currently supported. For more information, see [6363](https://github.com/spinnaker/spinnaker/issues/6363).
​
#### Server groups
<!-- ENG-5847 -->
There is a known issue where you cannot edit AWS server groups with the **Edit** button in the UI. The edit window closes immediately after you open it.
​
**Workaround**: To make changes to your server groups, edit the stage JSON directly by clicking on the **Edit stage as JSON** button.
​
## Highlighted updates
​
This release includes a security fix. For more information, see the Critical Notification that Armory's Support Team sent out on 14 December 2021, contact your Armory account rep, or see this (login required) Support article: https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010520.

###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.25.3](https://spinnaker.io/changelogs/1.25.3-changelog/) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.25.1
timestamp: 2021-12-15 17:23:28
services:
  dinghy:
    version: 2.25.5
    commit: 7feba3a7b859b9595758c7c9e09782e651d9f0f8
  clouddriver:
    version: 2.25.6
    commit: a764fa3dd360655e8ebd9b81e2217fce554f434c
  deck:
    version: 2.25.6
    commit: 3be7d16e0ba22113b38a7e8a1862f9769a119d10
  echo:
    version: 2.25.4
    commit: d4254bb69d38e8bf9216c045c4380933ff4582e1
  terraformer:
    version: 2.25.9
    commit: 4551e4c1976da52d1f96033f2849d97dc4c9131c
  fiat:
    version: 2.25.5
    commit: fe60b6210c6ce00167aa42143a4dffebcf03fb9f
  igor:
    version: 2.25.4
    commit: 670df68838b5183faa5ab42db3559b20bbfb29c9
  front50:
    version: 2.25.4
    commit: 3d2302240be46ca85600e488c20059a9990f13d4
  kayenta:
    version: 2.25.4
    commit: f859543dc93fe2438cca2b7907fde957dde9f64c
  orca:
    version: 2.25.3
    commit: 8f84752ec39945409533737c25beb2a853fa22d0
  gate:
    version: 2.25.7
    commit: eab05d036bef8c391274baa7fb3d294862fad37e
  rosco:
    version: 2.25.8
    commit: 8ef53c816490ac4350813003e098d9ccdff33b0b
  monitoring-daemon:
    version: 2.26.0
  monitoring-third-party:
    version: 2.26.0
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

