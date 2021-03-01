---
title: v2.23.0 Armory Release (OSS Spinnaker™ v1.23.2)
toc_hide: true
date: 2020-11-20
version: 02.23.00
---

## 2020/11/20 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).
> 
## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.23.0, use one of the following tools:

- Armory-extended Halyard 1.10.0 or later
- Armory Operator 1.2.1 or later

## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, contact your Armory account representative.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->


{{< include "breaking-changes/bc-k8s-job-suffix.md" >}}

{{< include "breaking-changes/bc-orca-forcecacherefresh.md" >}}

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->
#### Clouddriver resources

There is a known issue with Clouddriver that affects the performance of the Armory Platform, causing it to consume more resources. This can lead to a situation where pods do not have enough resources to start.

{{< include "known-issues/ki-orca-zombie-execution.md" >}}
{{< include "known-issues/ki-lambda-ui-caching.md" >}}

### Fixed issues

All the [known issues from the previous release (v2.22.2)]( {{< ref "armoryspinnaker_v2-22-2#known-issues" >}}) have been fixed:

* _Orca Plugins using Plugin SDK_ has been addressed in the [Plugin V2 framework](#plugin-v2-framework)
* _Spinnaker `liveManifestCalls` set to true can cause major pipeline errors_
* _GCE predictive autoscaling exception_


## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H4.
-->

### Artifacts

#### Helm repo indexes are now supported for artifacts

You can provide `helm/index` as a type when specifying an artifact path.

#### Versions now supported in artifacts using Oracle Objects

In the artifact selection UI, you can use `#` after the artifact to indicate the version you want to use. For example:

![oci version](/images/release/223/oci-buckets.png)

### Baking

The bundled Packer version has been upgraded to 1.6.4.

### Configuration

#### Dynamic Accounts

Spinnaker reads account definitions (cloud providers, CI, metric stores, etc.) from Spring properties. This works well in a world with a handful of accounts that rarely change but causes operational pain when provisioning accounts dynamically or with account information stored externally. See the Spinnaker Account Management [proposal](https://github.com/spinnaker/governance/blob/master/rfc/account-management.md?rgh-link-date=2020-09-29T21%3A29%3A49Z) for details.

The following providers can support loading credentials dynamically:

- CloudFoundry
- Kubernetes
- AWS

### Canary analysis with Dynatrace

See the {{< linkWithTitle "kayenta-canary-dynatrace.md" >}} guide for how to configure and use this new feature.

### Deployment targets - AWS

#### Support `externalID` for granting access to your AWS resources to a third party

Spinnaker can assume a role into third party resources (delegated access) that require AWS [external IDs](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-user_externalid.html). To configure an AWS provider, add the `externalId` property when specifying the `accountId` and `assumeRole` properties. For example:

```yaml
aws:
  name: delegated-prod
  accountId: 1234
  assumeRole: role/spinnaker
  externalId: "unique ID assigned to Armory"
```

#### Enabling AWS Lambda in configurations has changed

The `lambda.enabled` key has now moved under `features`.

Old:

```yaml
aws:
  lambda:
    enabled: true
  accounts:
    - name: test
      lambdaEnabled: true
```

New:

```yaml
aws:
  features:
    lambda:
      enabled: true
  accounts:
    - name: test
      lambdaEnabled: true
```

#### Fixes

There have been several fixes for Launch Templates and for the Lambda provider. See the [open source changelog](https://spinnaker.io/community/releases/versions/1-23-2-changelog#fixes-1).

### Deployment targets - Google

#### Google AppEngine add deploy global configuration stage

This new stage was created in order to support various configuration settings for an app engine application. You can find these settings in Google Cloud's [Configuration Files](https://cloud.google.com/appengine/docs/standard/python/configuration-files) content.

For example, `appengine` supports cron configuration. You can update or deploy cron configuration similar to how you deploy services. This stage replicates the functionality offered and allows you to deploy cron, dispatch, index, and queue configuration files to your `appengine` environments.

![stage example](/images/release/223/appengine-stage.png)

### Load Balancers

#### Support for AWS cross zone load balancing for Network Load Balancers
Spinnaker now supports the AWS cross zone load balancing setting. You’ll see a new checkbox in the UI when configuring NLBs. This is turned on by default for new load NLBs.

### Plugins

#### Plugin V2 Framework

The v2 plugin framework is now in place! The V2 plugin framework simplifies configuration of plugins and includes many quality of life changes for plugin developers interested in making spring based plugins. See [V2 Compatibility](https://github.com/spinnaker/kork/blob/master/kork-plugins/V2-COMPATIBILITY.md) for details.

### Storage

#### Support for Redis SSL connection paths

To turn on SSL, add an `s` to `redis://` in the connection string:

```yaml
redis:
  connection: rediss://localhost:6379
```

### User Interface

#### Support for displaying colors in console outputs

#### Pipelines can now be triggered by Helm Charts when they are published

![Helm automated trigger](/images/release/223/helm-trigger02.png)

![Helm execution parm](/images/release/223/helm-trigger.png)

#### Clusters page

If multiple containers exist for a server group, pods get collapsed by default.

###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the   
[Spinnaker v1.23.2](https://www.spinnaker.io/community/releases/versions/1-23-2-changelog) changelog for details.


## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.23.0
timestamp: "2020-11-20 15:20:46"
services:
    clouddriver:
        commit: a941921d
        version: 2.23.24
    deck:
        commit: f3a47075
        version: 2.23.8
    dinghy:
        commit: 2437ecbb
        version: 2.23.4
    echo:
        commit: 17b5072e
        version: 2.23.3
    fiat:
        commit: 9bdf56a1
        version: 2.23.2
    front50:
        commit: 71810ee6
        version: 2.23.3
    gate:
        commit: ccd981fb
        version: 2.23.2
    igor:
        commit: 3932c3ec
        version: 2.23.1
    kayenta:
        commit: d4ae95aa
        version: 2.23.2
    monitoring-daemon:
        version: 2.23.0
    monitoring-third-party:
        version: 2.23.0
    orca:
        commit: 3d0b945c
        version: 2.23.9
    rosco:
        commit: 76ab237d
        version: 2.23.4
    terraformer:
        commit: 3287d6fc
        version: 2.23.1
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Orca - 2.22.2...2.23.9

  - feat(plugins): include plugin downloader and plugin manifest (#144)
  - chore(aquasec): updating to show scan results in comments (#152)
  - feat(manifests): adding manifests for staging (#153)
  - fix(manifest): Updating deployment manifest (#154)
  - feat(chore): add rules for auto armory-common autobumps (#156)
  - fix(chore): typo for regex autobump (#157)
  - chore(spinnakerRelease): updated to support 2.23.x
  - use master-20200921140017
  - feat(ubi): add build for ubi image. (#159)
  - feat(ubi): update ubi LICENSES. (#161)
  - fix(ubi): deploy ubi to jfrog. (#162)
  - fix(GHA): set-env deprecated (bp #170) (#171)
  - Revert "fix(spinnakerBump): AutoBump Spinnaker Versions/ArmoryCommons Versions (bp #169)" (#173)

#### Armory Clouddriver - 2.22.11...2.23.24

  - feat(chore): add rules for auto armory-common autobumps (#197)
  - fix(chore): typo for regex autobump (#198)
  - feat(cve): Aquasec action version bump (#201)
  - feat(ubi): add build for ubi image. (#202)
  - fix(mergify): automerges when 'ready to merge' label is added
  - fix(docker): downgrade aws-iam-authenticator (#205)
  - fix(docker): python downgrade (#212)
  - chore(build): resolve CVEs and reduce docker layers (#213)
  - fix(ubi): deploy ubi to jfrog. (#214)
  - chore(spinnakerRelease): updated to support 2.23.x (#204)
  - use master-20201029170017
  - empty commit to bump versions
  - empty commit to bump versions
  - empty commit to bump versions
  - update using master-20201109170017
  - fix(GHA): set-env deprecated (bp #224) (#225)

#### Armory Fiat - 2.22.3...2.23.2

  - feat(plugins): include plugin downloader and plugin manifest (#98)
  - chore(aquasec): updating to show scan results in comments (#104)
  - feat(chore): add rules for auto armory-common autobumps (#106)
  - fix(chore): typo for regex autobump (#107)
  - feat(ubi): add build for ubi image. (#109)
  - feat(ubi): update ubi LICENSES. (#110)
  - fix(ubi): deploy ubi to jfrog. (#111)
  - fix(build): force 2.23.x release (#121)
  - chore(build): trying to get 2.23 out the door (#123)
  - chore(build): release-2.23.x has v2.23.0 tag on it (#124)

#### Armory Front50 - 2.22.2...2.23.3

  - feat(plugins): include plugin downloader and plugin manifest (#142)
  - chore(build): upgrade scan action (#148)
  - feat(chore): add rules for auto armory-common autobumps (#150)
  - feat(ubi): add build for ubi image. (#154)
  - fix(ubi): deploy ubi to jfrog. (#155)
  - fix(GHA): set-env deprecated (bp #165) (#166)

#### Armory Igor - 2.22.3...2.23.1

  - feat(plugins): include plugin downloader and plugin manifest (#119)
  - chore(build): upgrade scan action (#125)
  - feat(chore): add rules for auto armory-common autobumps (#127)
  - fix(chore): typo for regex autobump (#128)
  - fix(ubi): deploy ubi to jfrog. (#130)
  - fix(ubi): fix release version. (#132)
  - fix(GHA): set-env deprecated (bp #141) (#142)
  - fix(build): force build (#144)

#### Armory Rosco - 2.22.5...2.23.4

  - feat(plugins): include plugin downloader and plugin manifest (#95)
  - chore(build): upgrade scan action (#101)
  - chore(integration): add helm & kustomize tests (#102)
  - feat(chore): add rules for auto armory-common autobumps (#104)
  - fix(chore): typo for regex autobump (#105)
  - feat(ubi): add build for ubi image. (#107)
  - feat(kustomize): update version of kustomize used (#108)
  - chore(licenses): update ubi LICENSES. (#111)
  - fix(kustomize): Update kustomize with latest bug fixes (#113)
  - chore(e2e): added basic aws ami bake e2e test (#117)
  - feature(jobs): k8s job executor (#121)
  - feat(tests): adding integration test that checks packer hcl template support (#124)
  - feat(test): adding int test to bake with SSM on a private subnet (#125)
  - chore(docs): adding walkthrough to run packer with ssm on rosco (#126)
  - fix(GHA): set-env deprecated (#129)
  - feat(fargate-job-executor): add fargate job executor (#127)
  - feat(fargate-job-executor): merge master to include the Fargate Job Executor in the 2.23.x releases (#134)
  - fix(build): force build with tag (#139)
  - fix(build): force build with tag (#139) (#140)

#### Armory Gate - 2.22.3...2.23.2

  - fix(dependencies): remove * + and x for reproducible builds (#170)
  - feat(chore): add rules for auto armory-common autobumps (#172)
  - fix(chore): typo for regex autobump (#173)
  - feat(ubi): add build for ubi image. (#176)
  - fix(mergify): automerges when 'ready to merge' label is added
  - feat(plugins): deck proxy integration test (#137)
  - fix(ubi): deploy ubi to jfrog. (#177)
  - chore(release): merge master into 2.23 branch (#188)

#### Armory Deck - 2.22.7...2.23.8

  - feat(mptv2): add feature flag for mptv2 && upgrade to oss 1.22.x (#649)
  - feat(build): add details on how to build from a OSS forked release branch (#652)
  - feat(chore): add rules for auto armory-common autobumps (#657)
  - chore(mergify): fix autobump for armory-commons (#658)
  - chore(spinnakerRelease): updated to support 2.23.x
  - feat(settings.js): add a comment on why to keep MPTV2 feature flag
  - feat(settings.js): add a comment on why to keep MPTV2 feature flag (#664)
  - fix(package.json): added missing package
  - fix(deps): remove unused dependency with AGPL license (#665)
  - feat(ubi): add build for ubi image. (#662)
  - fix(ubi): deploy ubi to jfrog. (#666)
  - feat(build): use 1.23.0-master-20201012170017-rc1
  - fix(typo): an egregious typo in the Terraform help text (#669)
  - chore(spinnakerRelease): updated to support 2.23.x using master-20200918230017 (#663)
  - feat(kayenta): extending kayenta module to add dynatrace UI (#675) (#678)
  - chore(release): merge master into 2.23 ahead of release (#683)
  - fix(dinghy): fix NPE for commits and files. (#684) (#685)

#### Dinghy™ - 2.22.0...2.23.4

  - feat(chore): add rules for auto armory-common autobumps (#273)
  - fix(chore): typo for regex autobump (#274)
  - feat(ubi): add build for ubi image. (#276)
  - fix(ubi): deploy ubi to jfrog. (#277)
  - feat(permissions): support update application permissions (#280)
  - feat(logevents): logevents changes for deck ui integration (#284)
  - fix(nilcommits): fix nil commits for deck ui (#286) (#287)
  - fix(nofiles): only show file changes in logevents (#289) (#290)
  - feat(mainbranch): main branch support switch when master fails (#292) (#293)

#### Armory Echo - 2.22.2...2.23.3

  - feat(plugins): include plugin downloader and pluginManifest (#219)
  - fix(plugins): Don't fail when debug service is not provided because diagnostics.enabled is false (#224)
  - chore(aquasec): updating to show scan results in comments (#229)
  - feat(chore): add rules for auto armory-common autobumps (#231)
  - fix(chore): typo for regex autobump (#232)
  - feat(ubi): add build for ubi image. (#234)
  - feat(ubi): update ubi LICENSES. (#235)
  - fix(ubi): deploy ubi to jfrog. (#236)
  - fix(GHA): set-env deprecated (bp #244) (#245)
  - Revert "fix(spinnakerBump): AutoBump Spinnaker Versions/ArmoryCommons Versions (bp #243)" (#247)
  - Mergify/bp/release 2.23.x/pr 243 (#248)

#### Terraformer™ - 2.22.2...2.23.1

  - chore(build): upgrade scan action (#248)
  - feat(tests): apply and destroy commands (#249)
  - fix(test): fix input for destroy command test (#252)
  - feat(integration): add test for git ssh modules with named profiles (#254)
  - feat(chore): add rules for auto armory-common autobumps (#256)
  - fix(chore): typo for regex autobump (#257)
  - fix(plan): add targets to plan command (#262)
  - chore(versions): terraform 0.13.1,0.13.2,0.13.3 (#261)
  - fix(tests): compare array elements instead of string (#263)
  - fix(targets): add targets to destroy command (#265)
  - feat(ubi): add build for ubi image. (#260)
  - fix(ubi): deploy ubi to jfrog. (#266)
  - chore(cve): fix CVE-2020-13757 (#272)
  - fix(GHA): set-env deprecated (#276)
  - fix(build): force build (#279)

#### Armory Kayenta - 2.22.3...2.23.2

  - feat(plugins): include plugin downloader and plugin manifest (#116)
  - feat(chore): add rules for auto armory-common autobumps (#123)
  - fix(chore): typo for regex autobump (#124)
  - fix(cve): CVE fixes CVE-2020-9484 and CVE-2020-7692 (#128)
  - Dynatrace(feat): implementation for dynatrace kayenta (#127)
  - feat(ubi): add build for ubi image. (#126)
  - fix(ubi): deploy ubi to jfrog. (#132)
  - feat(aquasec): upgrade aquasec image, and adding feat to publish comments about aquasec analysis (#134)
  - fix(build): Build/release 2.23.x/oss 1.23.2 (#146)

