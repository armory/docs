---
title: v2.20.0 Armory Release (OSS Spinnaker v1.20.5)
toc_hide: true
date: 2020-06-19
version: 02.20.00
---

## 2020/06/19 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Halyard version

Armory 2.20.x requires Armory-extended Halyard 1.8.3 or later.

## Breaking changes

{{< include "breaking-changes/bc-metrics-name.md" >}}

### HTTP sessions for Gate
Armory 2.19.x and higher include an upgrade to the Spring Boot dependency. This requires you to flush all the Gate sessions for your Spinnaker deployment. For more information, see [Flushing Gate Sessions](https://kb.armory.io/admin/flush-gate-sessions/).

### Scheduled removal of Kubernetes V1 provider
The Kubernetes V1 provider will be removed in Spinnaker 1.21 (Armory 2.21). Please see the [RFC](https://github.com/spinnaker/governance/blob/master/rfc/eol_kubernetes_v1.md) for more details.

Breaking change: Kubernetes accounts with an unspecified providerVersion will now default to V2. Update your Halconfig to specify `providerVersion: v1` for any Kubernetes accounts you are currently using with the V1 provider.

## Known Issues

### Dynamic Accounts for Kubernetes

There is an issue with Dynamic Accounts for Kubernetes where the following issues occur:

* Agents get removed but still run on schedule.
* Force cache refresh times out.
* If you have the clean up agent setup, your data randomly disappears and reappears.  

These issues do not occur immediately, and you may even see modified accounts appear.

### Vault secrets

If you use Vault secrets, you should not use this version and instead update to v2.20.3.

### Pipelines as code behavior change for application spec

If you use Pipelines as code, skip Armory 2.20.0 and wait for 2.20.4.

Dinghy, the Pipelines as code service, creates an application for a pipeline in a dinghyfile if the application doesn't exist. You can specify an initial permission specification for the application as [documented here]({{< ref "using-dinghy#application-permissions" >}}).

Previously, the application specification is not updated if the application already exists. This means that after the initial application creation, no further changes to it get made by Dinghy even if you change the application spec in the `dinghyfile`.

This behavior was changed in 2.20.0. In 2.20.0, Dinghy saves your application every time there is a change to a `dinghyfile`. This change in behavior may break some workflows.

### Pipelines as code webhook validation

Webhook secret validation is broken in this version. Please skip this version if you use this feature.

### Upgrading from 2.18.x with MySQL used for Front50 renames the plugin_artifacts table
As a part of the upgrade from 2.18.x to 2.19.x, the table **plugin_artifacts** gets renamed to `plugin_info`. Downgrades from 2.19.x to 2.18.x do not revert the table name. The table remains named `plugin_info`, preventing access to the table.  

You will see errors similar to the following:

```
2020-06-22 21:52:27.001  INFO 1 --- [           main] .s.f.m.p.DefaultPluginArtifactRepository : Warming Cache
2020-06-22 21:52:27.723 ERROR 1 --- [           main] .s.f.m.p.DefaultPluginArtifactRepository : Unable to warm cache: {}

org.springframework.jdbc.BadSqlGrammarException: jOOQ; bad SQL grammar [select max(last_modified_at) as `last_modified_at` from plugin_artifacts]; nested exception is java.sql.SQLSyntaxErrorException: Table 'front50_kinnon.plugin_artifacts' doesn't exist
	at org.jooq_3.12.3.MYSQL.debug(Unknown Source) ~[na:na]
	at org.springframework.jdbc.support.SQLExceptionSubclassTranslator.doTranslate(SQLExceptionSubclassTranslator.java:93) ~[spring-jdbc-5.1.14.RELEASE.jar:5.1.14.RELEASE]
```  

This issue only occurs if you upgrade to 2.19.x and then downgrade.

**Workaround**

You can resolve this issue by rolling back changes to the MySQL database. For more information, see [MySQL Table Name Change Error When Rolling Back Spinnaker (Undo Renamed Values)](https://kb.armory.io/s/article/SQL-Migration-Rollback-Undo-Renamed-Tables).

### Pipelines as code

- Webhook secret validation is broken in this version. Please skip this version if you use this feature.
- Slack notification when pipelines are updated is broken. Please skip this version if you use this feature.

## Highlighted Updates

### Armory

### Terraform integration Named Profiles

The Terraform integration now supports Profiles that allow you control which users have the ability to reference certain kinds of external sources, such as a private remote repository, when creating pipelines.

Supported credentials:
* AWS
* SSH
* Static

Additionally, you can enforce authz for any Named Profile you create.

For more information, see [Named Profiles]({{< ref "terraform-enable-integration#named-profiles" >}}).

### Pipelines as code

Application-level notifications are now available for Pipelines as code. When the Dinghy, the service for Pipelines as code, sends a notification, it will send it to application-level Slack channels.

### Clouddriver

The Plugins framework now supports cloud provider plugins. You can see an example for Nomad in the Plugins example [repo](https://github.com/spinnaker-plugin-examples/nomadPlugin).

### Cloud Foundry

Improved latency for large Cloud Foundry deployments with the Space Caching Agent.

### Security update

This releases focuses on making Spinnaker more secure. Although several CVEs are resolved, the following still exist:

#### General

- CVE-2020-13790

This is an embedded dependency in OpenJDK11. A version of OpenJDK11 that addresses
this CVE has only recently been released, and will be fixed in the next release. The risk to services users is low: the CVE deals with processing jpeg images in the Java Runtime Environment, a task our services donot utilize.

The following list of CVEs will be addressed in the next release:

- CVE-2020-5410
- CVE-2020-13757

#### Clouddriver

The following three CVEs still exist in Clouddriver:

- CVE-2020-1747
- CVE-2017-18342
- CVE-2016-10745

All three are embedded dependencies in the Google Cloud SDK. A version of the Google Cloud SDK addressing these CVEs has not been released. The risk to Clouddriver users is low: all three CVEs deal with untrusted input, which Clouddriver does not provide to the Google Cloud SDK. Additionally, users deploying to other cloud providers are not at risk for this vulernability.

The following CVEs also exist for the service:

- CVE-2020-7014 - deals with an Elasticsearch exploit. Clouddriver only makes use of entity tags and does not allow for token generation or authentication.

###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes and features across all of Spinnaker's other services. See their changes here:  
[Spinnaker v1.20.5](https://www.spinnaker.io/community/releases/versions/1-20-5-changelog)

### Open source highlights

#### Kubernetes V2 Run Job Stage

Spinnaker 1.20 no longer automatically adds a unique suffix to the name of jobs. Prior to this release, the Kubernetes V2 Run Job stage added a unique suffix to the name of the deployed job, with no ability to control or configure this behavior.

To continue having a random suffix added to the job name, set the metadata.generateName field instead of metadata.name, which causes the Kubernetes API to append a random suffix to the name.

If a job sets metadata.name directly, that name will be used without modification for each execution of the job. As jobs are immutable, each execution of the stage will delete any existing job with the supplied name before creating the job.

#### Kustomize Enabled by Default

Starting in Spinnaker 1.20, Kustomize support in Spinnaker is GA, and the Kustomize option in the Bake (Manifest) stage is enabled by default. Previously, the Kustomize option in the Bake (Manifest) stage was hidden behind a feature flag.

#### Support for Hiding Arbitrary Stages from End Users

In this release, all stages that are not provider-specific will be exposed by default. Operators can now choose to hide any stages from end-users using [Deck’s `hiddenStages` setting](https://www.spinnaker.io/guides/operator/hiding-stages/#hiding-stages). The flags to enable the Gremlin, Travis, Wercker, and Create Load Balancers stages are no longer supported in Spinnaker 1.20 or Halyard 1.35. If using a version of Spinnaker prior to 1.20 with Halyard 1.35, you may still enable the `travis`, `wercker`, and `infrastructureStages` flags by setting them in your `settings-local.js`.

#### Docker Registry Changing

Spinnaker’s Docker containers are now hosted on `us-docker.pkg.dev/spinnaker-community`. Previously, they were hosted on `gcr.io/spinnaker-marketplace`.

#### ECS Support for Load Balancer Views and Task Health Status in Deployments

In this release, users can now view the load balancers, listeners and target groups associated with their ECS services within the Load Balancers Infrastructure tab.

Also in this release, pipeline deployments now take into account container health checks and the overall task health status before determining a service to be up. If using a prior version, pipeline deployments would consider the service healthy once the tasks were started, but potentially prior to the container health checks running. This could lead to prematurely marking a deployment as successful.


## Detailed Updates



### Bill of Materials
Here's the bom for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>
version: 2.20.0
timestamp: "2020-06-19 08:01:13"
services:
    clouddriver:
        commit: 6d1cfe10
        version: 2.20.1
    deck:
        commit: 121fba95
        version: 2.20.3
    dinghy:
        commit: bb5b15e2
        version: 2.20.1
    echo:
        commit: 74ed4f27
        version: 2.20.1
    fiat:
        commit: f7c1d974
        version: 2.20.2
    front50:
        commit: ed4b3b62
        version: 2.20.3
    gate:
        commit: 69ba2895
        version: 2.20.2
    igor:
        commit: eef1ee6b
        version: 2.20.3
    kayenta:
        commit: 4b9f2d68
        version: 2.20.2
    monitoring-daemon:
        version: 2.20.0
    monitoring-third-party:
        version: 2.20.0
    orca:
        commit: 3d2cf0a1
        version: 2.20.1
    rosco:
        commit: 59a9a00b
        version: 2.20.2
    terraformer:
        commit: 5b00d7a6
        version: 2.20.3
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Front50 - 2.19.12...2.20.2

  - armory commons updates (#38)
  - fix(mergify): fix rules (#49)
  - fix(plugins): add plugins dir (#52)
  - chore(cve): fix CVE-2019-17495 CVE (#83)
  - chore(build): update build w/ aquasec scan (#85)
  - fix(opa): fix conflicting beans (#90)
  - chore(actions): update github workflow (#96)
  - fix(security): resolve CVE-2020-1695 relating to resteasy-jaxrs (#99)
  - chore(deps): update dependencies (#106)

#### Armory Gate - 2.19.11...2.20.2

  - chore(commons): Armory commons bump (#92)
  - Java 11 and gradle plugin update (#91)
  - fix(mergify): fix rules (#103)
  - fix(plugins): add plugins dir (#106)
  - chore(cve): CVE fixes (#108)
  - chore(build): update build add aquasec scan (#110)
  - fix(cve): exclude converter-simplexml lib due to CVE-2017-1000190. (#114)
  - chore(deps): update dependencies (#125)

#### Armory Kayenta - 2.19.13...2.20.2

  - fix(mergify): fix rules (#59)
  - fix(mergify): fix rules (#60)
  - fix(plugins): add plugins dir (#64)
  - chore(cve): fix CVE-2019-17495 CVE (#67)
  - fix(dependencies): Exclude the dependencies that I manaully determined that Kayenta defines itself from the armory-commons bom platform so that Kayenta has the version or orca and kork that it expects (#66)
  - fix(dependencies): tweak deps so that the right orca and kork are used and port oss integration tests so that dep issues pop up in CI (#70)
  - chore(build): update to use aquasec scan (#72)
  - chore(build): update github workflow (#78)
  - chore(release): master -> 2.20.x (#87)

#### Armory Orca - 2.19.14...2.20.1

  - feat(terraformer): add save toggle config (#72)
  - chore(config): update default redis endpoint (#78)
  - chore(mergify): automatically merge backports from @mergifyio (#80)
  - fix(orca.yaml): copied from 1.19.x (#84)
  - fix(terraformer): just pass through the var instead of setting it (#86)
  - fix(mergify): fix rules (#89)
  - fix(plugins): add plugins dir (#94)
  - feat(terraformer): pass selected profile to backend (#93)
  - chore(aquasec): update build to scan using aquasec (#100)
  - feat(terraformer): send spinnaker user on createJob request (#102)
  - chore(version): Generate build-info properties file (#104) (#109)

#### Armory Deck - 2.19.12...2.20.3

  - fix(mptv2): restore feature flag (#586)
  - fix(mergify): fix rules (#589)
  - feat(ui-help): add docs widget to deck (#593)
  - feat(plugins): copy plugins manifest to right location for serving (#592)
  - Revert "feat(ui-help): add docs widget to deck (#593)" (#594)
  - chore(build): update build add aquasec scan (#595)
  - fix(terraform): fix stage version selector (#599)
  - chore(build): remove Xray scan (#601)
  - chore(release): update to oss 1.19.11 (#605)
  - fix(canary): use hotfixed v0.0.89 deck-kayenta from artifactory until OSS release is created and backported. (#608)
  - chore(release): update to oss 1.20.5 (#612) (#613)
  - chore(release): update to oss 1.20.5-rc2 (#614) (#615)
  - fix(commons): rollback version of commons (#616) (#617)

#### Armory Echo - 2.19.14...2.20.1

  - chore(commons): Bump armory commons (#126)
  - fix(build): Restrict Hibernate validator to 6.1.x (#130)
  - feature(mergify): First stab at a mergify build (#132)
  - chore(readme): add \n to match formatting (#133)
  - updated rule to allow mergify prs to be auto approved on fixes backported (#135)
  - fix merge conflicts from release
  - fix(echo.yaml): copied from 1.19.x (#143)
  - feat(dinghy): Support for webhook secrets in dinghy (#138)
  - fix(mergify): fix rules (#147)
  - fix(plugins): add plugins dir (#151)
  - feat(aquasec): Trying aquasec scanner (#153)
  - chore(actions): update github workflow (#160)
  - chore(release): master -> 2.20.x (#166)

#### Armory Rosco - 2.19.13...2.20.2

  - fix(mergify): fix rules (#41)
  - feat(docker): include changes from 1.18.x->1.19.x (bp #45) (#46)
  - fix(plugins): add plugins dir (#47)
  - chore(build): update to aquasec scan (#50)
  - chore(cve): fix CVE-2019-17495 CVE (#49)
  - chore(cve): fix for CVE-2017-18640 (#55)
  - chore(build): update github workflow (#60)
  - chore(release): upgrade deps (#66)

#### Terraformer™ - 1.0.13...2.20.1

  - refactor(terraform): split terraform code into pkg (#143)
  - chore(docker): setup docker image build to debug terraformer via dlv (#144)
  - refactor(version): refactor executable path (#146)
  - feat(profiles): add static credential support (#145)
  - refactor(command): support command outputs (#147)
  - refactor(terraform): reduce code duplication (#148)
  - feat(terraform): output planfile as json (#149)
  - feat(artifacts): support b64 artifacts as var file (#150)
  - feat(aws): support aws keypair as cred type (#151)
  - feat(profiles): support assume role for aws (#152)
  - fix(apply): don't assume planfile (#153)
  - chore(build): update to use aquasec scan (#154)
  - revert(show): revert changes to plan command (#158)
  - fix(builder): actually inject environment (#159)
  - chore(dockerfile): add kubectl and aws-iam-authenticator to image (#160)
  - build(security): apk del gnupg after installing tf versions; fixes cv… (#161)
  - fix(docker): remove pip3 from image for cve (#163)
  - fix(persistence): write plan file before marking complete (#165)
  - chore(actions): update github workflow (#167)
  - chore(deps): update go-yaml-tools to latest (#169)
  - feat(profiles): add authorization to named profiles (#173)
  - fix(profiles): refactor authz a bit (#174)
  - fix(tests): fix slice equality check for named profiles (#175)
  - feat(profiles): add more error logging for profiles authz (#176)
  - fix(profile_api): return empty slice if no profiles (#177)
  - chore(apis): use common response writers (#179)
  - feat(profile): add default Fiat baseUrl (#178)
  - feat(main): refactor main (#180)
  - refactor(profile): decouple profile from config (#181)
  - fix(profiles): dont evaluate permissions on a nil Profile (#183) (#184)

#### Dinghy™ - 2.19.13...2.20.1

  - chore(build): update Dinghy (#201)
  - feat(vendor): upgrade base dinghy, but don't upgrade go-gitlab (#204)
  - fix(mergify): fix rules (#207)
  - fix(dinghy) fix conditionals and rawdata (#210)
  - fix(security): Fix for CVE-2019-18276 (#211)
  - chore(build): update build w/ aquasec scan (#212)
  - feat(validation): refIds and stagerefIds fields for stages are validated (#218)
  - Added support for local_module, validation for requisitestageref and fixed a bug regarding app creation throwing an error message (#221)
  - Added git commit status and bug fix for app creation (#223)
  - chore(deps): update dinghy to latest (#225)
  - feat(slacknotifications): Send slack applications notifications (#228) (#230)

#### Armory Fiat - 2.19.13...2.20.2

  - chore(commons): Armory commons bump (#36)
  - fix(mergify): fix rules (#42)
  - fix(plugins): add plugins dir (#46)
  - chore(cve): fix CVE-2019-17495 CVE (#48)
  - chore(build): update build add aquasec scan (#50)
  - chore(build): add missing task dockerPush (#54)
  - chore(actions): update github workflow (#58)
  - chore(release): master -> 2.20.x (#68)

#### Armory Clouddriver - 2.19.20...2.20.1

  - Java 11 and gradle plugin update (#74)
  - fix(jvm): Switched to java 11 (#77)
  - fix(bumps): Spinnaker bump version (#88)
  - fix(clouddriver.yaml): copied from 1.19.x (#94)
  - fix(mergify): fix rules (#98)
  - fix(plugins): add plugins dir (#103)
  - chore(cve): Upgrade to AWS 1.18.13 - resolves CVE-2020-1747 (#105)
  - chore(cve): Fully remove anthoscli, CVE-2019-18658 (#107)
  - chore(cve): workaround for CVE-2019-17495 (#109)
  - chore(build): update build add aquasec scan (#116)
  - chore(build): add missing task dockerPush (#118)
  - fix(opa): fix opa bean conflict (#125)
  - fix(opa): fix NPE when no upstream validator found (#127)
  - feat(container): add docker hub publish on successful scan (#132)
  - chore(vulnerabilities): resolve CVEs and other security issues (#129)
  - chore(release): master -> 2.20.x (#142)

#### Armory Igor - 2.19.12...2.20.2

  - chore(dockerfile): changes from 1.18.x -> 1.19.x (#48)
  - fix(mergify): fix rules (#54)
  - fix(cve): CVE-2020-11612 (#55)
  - fix(plugins): add plugins dir (#58)
  - chore(build): update to use aquasec scan (#60)
  - chore(build): update github workflow (#67)
  - chore(release): master -> 2.20.x (#74)
