---
title: v2.31.0-rc2 Armory Release (OSS Spinnaker™ v1.31.2)
toc_hide: true
date: 2023-11-03
version: <!-- version in 00.00.00 format ex 02.23.01 for sorting, grouping -->
description: >
  Release notes for Armory Continuous Deployment v2.31.0-rc2. A beta release is not meant for installation in production environments.

---

## 2023/11/03 Release Notes

## Disclaimer

This pre-release software is to allow limited access to test or beta versions of the Armory services (“Services”) and to provide feedback and comments to Armory regarding the use of such Services. By using Services, you agree to be bound by the terms and conditions set forth herein.

Your Feedback is important and we welcome any feedback, analysis, suggestions and comments (including, but not limited to, bug reports and test results) (collectively, “Feedback”) regarding the Services. Any Feedback you provide will become the property of Armory and you agree that Armory may use or otherwise exploit all or part of your feedback or any derivative thereof in any manner without any further remuneration, compensation or credit to you. You represent and warrant that any Feedback which is provided by you hereunder is original work made solely by you and does not infringe any third party intellectual property rights.

Any Feedback provided to Armory shall be considered Armory Confidential Information and shall be covered by any confidentiality agreements between you and Armory.

You acknowledge that you are using the Services on a purely voluntary basis, as a means of assisting, and in consideration of the opportunity to assist Armory to use, implement, and understand various facets of the Services. You acknowledge and agree that nothing herein or in your voluntary submission of Feedback creates any employment relationship between you and Armory.

Armory may, in its sole discretion, at any time, terminate or discontinue all or your access to the Services. You acknowledge and agree that all such decisions by Armory are final and Armory will have no liability with respect to such decisions.

YOUR USE OF THE SERVICES IS AT YOUR OWN RISK. THE SERVICES, THE ARMORY TOOLS AND THE CONTENT ARE PROVIDED ON AN “AS IS” BASIS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED. ARMORY AND ITS LICENSORS MAKE NO REPRESENTATION, WARRANTY, OR GUARANTY AS TO THE RELIABILITY, TIMELINESS, QUALITY, SUITABILITY, TRUTH, AVAILABILITY, ACCURACY OR COMPLETENESS OF THE SERVICES, THE ARMORY TOOLS OR ANY CONTENT. ARMORY EXPRESSLY DISCLAIMS ON ITS OWN BEHALF AND ON BEHALF OF ITS EMPLOYEES, AGENTS, ATTORNEYS, CONSULTANTS, OR CONTRACTORS ANY AND ALL WARRANTIES INCLUDING, WITHOUT LIMITATION (A) THE USE OF THE SERVICES OR THE ARMORY TOOLS WILL BE TIMELY, UNINTERRUPTED OR ERROR-FREE OR OPERATE IN COMBINATION WITH ANY OTHER HARDWARE, SOFTWARE, SYSTEM OR DATA, (B) THE SERVICES AND THE ARMORY TOOLS AND/OR THEIR QUALITY WILL MEET CUSTOMER”S REQUIREMENTS OR EXPECTATIONS, (C) ANY CONTENT WILL BE ACCURATE OR RELIABLE, (D) ERRORS OR DEFECTS WILL BE CORRECTED, OR (E) THE SERVICES, THE ARMORY TOOLS OR THE SERVER(S) THAT MAKE THE SERVICES AVAILABLE ARE FREE OF VIRUSES OR OTHER HARMFUL COMPONENTS. CUSTOMER AGREES THAT ARMORY SHALL NOT BE RESPONSIBLE FOR THE AVAILABILITY OR ACTS OR OMISSIONS OF ANY THIRD PARTY, INCLUDING ANY THIRD-PARTY APPLICATION OR PRODUCT, AND ARMORY HEREBY DISCLAIMS ANY AND ALL LIABILITY IN CONNECTION WITH SUCH THIRD PARTIES.

IN NO EVENT SHALL ARMORY, ITS EMPLOYEES, AGENTS, ATTORNEYS, CONSULTANTS, OR CONTRACTORS BE LIABLE UNDER THIS AGREEMENT FOR ANY CONSEQUENTIAL, SPECIAL, LOST PROFITS, INDIRECT OR OTHER DAMAGES, INCLUDING BUT NOT LIMITED TO LOST PROFITS, LOSS OF BUSINESS, COST OF COVER WHETHER BASED IN CONTRACT, TORT (INCLUDING NEGLIGENCE), OR OTHERWISE, EVEN IF ARMORY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES AND NOTWITHSTANDING ANY FAILURE OF ESSENTIAL PURPOSE OF ANY LIMITED REMEDY. IN ANY EVENT, ARMORY, ITS EMPLOYEES’, AGENTS’, ATTORNEYS’, CONSULTANTS’ OR CONTRACTORS’ AGGREGATE LIABILITY UNDER THIS AGREEMENT FOR ANY CLAIM SHALL BE STRICTLY LIMITED TO $100.00. SOME STATES DO NOT ALLOW THE LIMITATION OR EXCLUSION OF LIABILITY FOR INCIDENTAL OR CONSEQUENTIAL DAMAGES, SO THE ABOVE LIMITATION OR EXCLUSION MAY NOT APPLY TO YOU.

You acknowledge that Armory has provided the Services in reliance upon the limitations of liability set forth herein and that the same is an essential basis of the bargain between the parties.


## Required Armory Operator version

To install, upgrade, or configure Armory 2.31.0-rc2, use Armory Operator 1.70 or later.

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

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
[Spinnaker v1.31.2](https://www.spinnaker.io/changelogs/1.31.2-changelog/) changelog for details.

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
    commit: 33d6e81178123f1d0bf3441075c1bc18f9d951c2
    version: 2.31.0-rc2
  deck:
    commit: 1dd95e4ef5ed631f24253bf917200c3cf52655af
    version: 2.31.0-rc2
  dinghy:
    commit: 5d44db0f3b4815075a90ef7121df6b830a39e6d5
    version: 2.31.0-rc2
  echo:
    commit: a2e32fc4b93e5472cc5d09d24a30fb8467fdc7d3
    version: 2.31.0-rc2
  fiat:
    commit: d0f268bfbcd374bfc104e0fd95d6c76d0d0a5770
    version: 2.31.0-rc2
  front50:
    commit: 5db553c003950174757e6438ba024b6a4b51c9ed
    version: 2.31.0-rc2
  gate:
    commit: 1a4fc24d3d4870c375f6bc10fe6892c6b39a789e
    version: 2.31.0-rc2
  igor:
    commit: 3c9dd843c3eddbfaa529f054b2df73de938391ca
    version: 2.31.0-rc2
  kayenta:
    commit: 291ff224d1098f34823010ba2335e16ae149d39b
    version: 2.31.0-rc2
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: c64d5d70447e60ebaa7686d3588fa7738938063c
    version: 2.31.0-rc2
  rosco:
    commit: a30386ed64ae490e4788fe80b453528731a923bd
    version: 2.31.0-rc2
  terraformer:
    commit: 50082463ccd180cb4763078671a105ab70dee5e6
    version: 2.31.0-rc2
timestamp: "2023-11-03 15:52:38"
version: 2.31.0-rc2
</code>
</pre>
</details>

### Armory


#### Armory Front50 - 2.31.0-rc1...2.31.0-rc2

  - chore(feat): Support ARM with docker buildx - SAAS-1953 (#612) (#613)

#### Armory Kayenta - 2.31.0-rc1...2.31.0-rc2

  - Update buildx for build gradle and action workflow (#484) (#485)

#### Terraformer™ - 2.31.0-rc1...2.31.0-rc2

  - chore(ci): removed aquasec scan action (#510) (#511)
  - chore(feat): Support ARM with docker buildx - SAAS-1953 (backport #525) (#526)
  - Minor changes for Terraform tag name (#527) (#528)
  - fix(cd): Fix terraform build fail (#529) (#530)
  - Fix build cd artifact erro, no space lef on the device (#531) (#532)

#### Armory Deck - 2.31.0-rc1...2.31.0-rc2

  - chore(alpine): Fix Deck to support ARM processor - SAAS-1953 (backport #1341) (#1355)
  - fix(action): upgrade node version to match OSS (#1356) (#1357)
  - chore(cd): update base deck version to 2023.0.0-20231018060056.release-1.31.x (#1361)
  - chore(cd): update base deck version to 2023.0.0-20231024154256.release-1.31.x (#1363)

#### Armory Clouddriver - 2.31.0-rc1...2.31.0-rc2

  - chore(feat): Support ARM with docker buildx - SAAS-1953 (backport #999) (#1004)

#### Armory Gate - 2.31.0-rc1...2.31.0-rc2

  - chore(feat): Support ARM with docker buildx - SAAS-1953 (#640) (#641)

#### Armory Fiat - 2.31.0-rc1...2.31.0-rc2

  - chore(feat): Support ARM with docker buildx - SAAS-1953 (#540) (#541)

#### Armory Rosco - 2.31.0-rc1...2.31.0-rc2

  - chore(feat): Support ARM with docker buildx - SAAS-1953 (backport #584) (#587)
  - chore(cd): update base service version to rosco:2023.10.18.06.02.57.release-1.31.x (#590)

#### Dinghy™ - 2.31.0-rc1...2.31.0-rc2


#### Armory Orca - 2.31.0-rc1...2.31.0-rc2

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

#### Armory Echo - 2.31.0-rc1...2.31.0-rc2

  - chore(feat): Support ARM with docker buildx - SAAS-1953 (backport #637) (#640)

#### Armory Igor - 2.31.0-rc1...2.31.0-rc2



### Spinnaker


#### Spinnaker Front50 - 1.31.2


#### Spinnaker Kayenta - 1.31.2


#### Spinnaker Deck - 1.31.2

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

#### Spinnaker Clouddriver - 1.31.2


#### Spinnaker Gate - 1.31.2


#### Spinnaker Fiat - 1.31.2


#### Spinnaker Rosco - 1.31.2

  - feat(helm/bake): Add additional input fields where we can fill in details of the APIs versions (#1020) (#1030)

#### Spinnaker Orca - 1.31.2

  - chore(dependencies): Autobump korkVersion (#4252)
  - Fix for size (#4242)
  - fix(dependency): Issue of missing javax.validation and hibernate-validator dependencies while upgrading the spring cloud to Hoxton.SR12 in kork (#4254)
  - chore(ci): Upload halconfigs to GCS on Tag push (#4256)
  - chore(dependencies): Autobump korkVersion (#4257)
  - chore(dependencies): Autobump korkVersion (#4258)
  - feat(stageExecution): supporting extra custom tags for stage execution metrics (#4255)
  - fix(ci): fetch previous tag from git instead of API (#4263)
  - chore(ci): Mergify - merge Autobumps on release-* (#4264)
  - fix(cfn): Fix detection of empty CloudFormation changesets (#4270)
  - chore(dependencies): Autobump korkVersion (#4272)
  - fix(tasks): Fix MonitorPipelineTask regression (#4271)
  - chore(dependencies): Autobump korkVersion (#4273)
  - chore(dependencies): Autobump korkVersion (#4275)
  - feat(orca): add Kustomize 4 support (#4280)
  - fix(restart-pipeline) : CheckPrecondition doesn't evaluate expression correctly when upstream stages get restarted (#4278)
  - chore(tests): redact some data in test (#4281)
  - feat(webhook): Allow webhook retries for selected status codes (#4276)
  - chore(dependencies): Autobump korkVersion (#4282)
  - chore(dependencies): Autobump fiatVersion (#4283)
  - chore(dockerfile): upgrade to latest alpine image (#4284)
  - refactor(groovy): migrating Clouddriver services to Java (#4269)
  - chore(build): Build docker images for multiple architectures (#4288)
  - fix(clouddriver): fix property binding for Clouddriver (#4290)
  - chore(dependencies): Autobump korkVersion (#4291)
  - fix(preconfiguredJobs): Resource requests on custom stage | Error: got "map", expected "string" (#4295)
  - feat(igor): Stop Jenkins job when job name has slashes in the job name (#4294)
  - chore(dependencies): Autobump fiatVersion (#4296)
  - fix(sql): Wrong indentation for rollback in database changelog (#4297)
  - fix(stageExecution): In MJ stages find the correct authenticated user… (#4289)
  - feat(orchestration): provide a way to allow only certain configured ad-hoc operations to be performed (#4195)
  - chore(dependencies): Autobump korkVersion (#4298)
  - chore(dependencies): Autobump fiatVersion (#4299)
  - chore(dependencies): Autobump fiatVersion (#4300)
  - chore(dependencies): Autobump korkVersion (#4302)
  - chore(dependencies): Autobump korkVersion (#4304)
  - chore(dependencies): Autobump korkVersion (#4308)
  - fix(stageExecution): In evaluable variable stage restart scenario variables are not cleaned properly (#16) (#4307)
  - feat(cloudrun): Adding cloudrun provider in orca. (#4279)
  - chore(kubernetes): stop specifying the version of io.kubernetes:client-java (#4310)
  - feat(cloudrun): Adding cloudrun provider in orca. (#4311)
  - chore(dependencies): Autobump korkVersion (#4313)
  - fix(config): restore prior visibility of methods on CloudDriverConfigurationProperties class (#4317)
  - fix(artifacts): Expected Artifacts should be trigger specific (#4322)
  - feat(bakery): add includeCRDs in Helm Bake request (#4324)
  - fix(config): add back public visibility for ClouddriverRetrofitBuilder class (#4331)
  - feat(kubernetes events in orca): Exposes kubernetes events in orca for enhanced logging (#4301)
  - fix(orca): display task exception messages (#4259)
  - feat(bakery): Clean up cached data created by Rosco. (#4323)
  - feat(kubernetes): Introduce blue/green traffic management strategy (#4332)
  - chore(dependencies): Autobump spinnakerGradleVersion (#4337)
  - fix(tasks): Fix MonitorKayentaCanaryTask on results data map (#4312)
  - chore(dependencies): Autobump korkVersion (#4342)
  - chore(dependencies): Autobump korkVersion (#4343)
  - feat(Azure): Update createBakeTask for managed and custom images. (#4336)
  - chore(dependencies): Autobump korkVersion (#4352)
  - feat(AWS): Get the rollback timeout value from stage data. (#4353)
  - feat(k8s): Add support of Deployment kind for Blue/Green deployments. (#4355)
  - refactor(web): Clean up redundant spring property in gradle file (#4359)
  - chore(dependencies): Autobump korkVersion (#4360)
  - chore(dependencies): Autobump korkVersion (#4361)
  - chore(dependencies): Autobump korkVersion (#4362)
  - chore(dependencies): Autobump korkVersion (#4363)
  - chore(dependencies): remove dependency on groovy-all where straightforward (#4364)
  - chore(dependencies): Autobump korkVersion (#4365)
  - feat(bakery): add tasks.monitor-bake.timeout-millis configuration property for MonitorBakeTask timeout (#4367)
  - chore(front50): Make Monitor Pipeline Task timeout overridable (#4347)
  - Fix orca bakery (#4370)
  - chore(dependencies): Autobump spinnakerGradleVersion (#4371)
  - fix(stageExecution): Extend MJ auth propagate logic for exhaustive cases (#4368)
  - feat(tasks): Capture task output data from clouddriver (#4374)
  - fix(dependency): Issue with keiko-redis-spring module while upgrading the spring boot 2.5.x (#4375)
  - chore(dependencies): Autobump korkVersion (#4376)
  - chore(web): clean up for spring property setup (#4377)
  - chore(dependencies): Autobump korkVersion (#4378)
  - chore(dependencies): Autobump korkVersion (#4380)
  - chore(dependencies): Autobump korkVersion (#4381)
  - feat(config): allow configuration of writeable clouddriver endpoints by account and/or cloudProvider (#4287)
  - fix(timeout): Added feature flag for rollback timeout ui input. (#4383)
  - chore(dependencies): Autobump korkVersion (#4390)
  - chore(dependencies): Autobump korkVersion (#4391)
  - chore(dependencies): Autobump korkVersion (#4392)
  - chore(dependencies): Autobump korkVersion (#4393)
  - chore(dependencies): Autobump korkVersion (#4394)
  - chore(dependencies): Autobump korkVersion (#4398)
  - chore(dependencies): Autobump korkVersion (#4399)
  - fix(waiting-executions) : Waiting executions doesn't follow FIFO (#4356)
  - fix(artifacts): Be more lenient when filtering expected artifacts (#4397)
  - fix(artifacts): Stop copying expectedArtifactIds to child pipelines (#4404)
  - Revert "feat(k8s): Add support of Deployment kind for Blue/Green deployments." (#4407)
  - chore(dependencies): Autobump korkVersion (#4411)
  - feat(igor): Default the feature flag which sends the job name as query parameter to on (#4412)
  - chore(dependencies): Autobump korkVersion (#4413)
  - Fix/blue green deploy (#4414)
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

#### Spinnaker Echo - 1.31.2


#### Spinnaker Igor - 1.31.2


