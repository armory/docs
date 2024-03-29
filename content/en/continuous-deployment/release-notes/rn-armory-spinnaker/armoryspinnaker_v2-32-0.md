---
title: v2.32.0 Armory Continuous Deployment Feature Release (Spinnaker™ v1.32.3)
toc_hide: true
version: 2.32.0
date: 2024-02-09
description: >
  Release notes for Armory Continuous Deployment v2.32.0.
---

<!-- 
MAKE SURE TO ADD 'LTS' OR 'FEATURE' TO THE TITLE TO INDICATE RELEASE CATEGORY. 
FOR EXAMPLE, "Armory Continuous Deployment Release LTS" or "Armory Continuous Deployment Release Feature" so users know release category and support time period 
-->

## 2024/02/09 release notes

>Note: If you experience production issues after upgrading Armory Continuous Deployment, roll back to a previous working version and report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory CD 2.32.0, use Armory Operator 1.8.6 or later.

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

### RetrofitError thrown on login
In versions 2.32.0 and 2.32.1 of Spinnaker, there is an issue with x509 authentication that affects certificates without roles. Certificates lacking roles will fail to authenticate in these versions. However, certificates with roles are not affected and will continue to function properly. Users relying on x509 authentication are advised to exercise caution when upgrading to versions 2.32.0 and 2.32.1. It's recommended to wait for version 2.32.2 or a later release, which includes a fix for this issue. Testing the upgrade in a non-production environment is advisable to ensure smooth operation.

### AWS Lambda plugin migrated to OSS
Starting from Armory version 2.32.0 (OSS version 1.32.0), the AWS Lambda plugin has been migrated to OSS codebase.
If you are using the AWS Lambda plugin, you will need to disable/remove it when upgrading to Armory version 2.32.0+ to
avoid compatibility issues.

Additionally, the AWS Lambda stages are now enabled using the Deck feature flag `feature.lambdaAdditionalStages = true;`
as shown in the configuration block below.
{{< highlight yaml "linenos=table,hl_lines=12" >}}
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      deck:
        settings-local.js: |
          ...
          window.spinnakerSettings.feature.functions = true;
          // Enable the AWS Lambda pipeline stages in Deck using the feature flag
          window.spinnakerSettings.feature.lambdaAdditionalStages = true; 
          ...
      clouddriver:
        aws:
          enabled: true
          features:
            lambda:
              enabled: true
      ## Remove the AWS Lambda plugin from the Armory CD configuration.
      #gate:
      #  spinnaker:
      #    extensibility:
      #      deck-proxy:
      #        enabled: true
      #        plugins:
      #          Aws.LambdaDeploymentPlugin:
      #            enabled: true
      #            version: <version>
      #      repositories:
      #        awsLambdaDeploymentPluginRepo:
      #          url: https://raw.githubusercontent.com/spinnaker-plugins/aws-lambda-deployment-plugin-spinnaker/master/plugins.json  
      #orca:
      #  spinnaker:
      #    extensibility:
      #      plugins:
      #        Aws.LambdaDeploymentPlugin:
      #          enabled: true
      #          version: <version>
      #          extensions:
      #            Aws.LambdaDeploymentStage:
      #              enabled: true
      #      repositories:
      #        awsLambdaDeploymentPluginRepo:
      #          id: awsLambdaDeploymentPluginRepo
      #          url: https://raw.githubusercontent.com/spinnaker-plugins/aws-lambda-deployment-plugin-spinnaker/master/plugins.json
{{< /highlight >}}

Related OSS PRs:
- https://github.com/spinnaker/orca/pull/4449
- https://github.com/spinnaker/deck/pull/9988

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->
### With S3 artifact storage enabled Terraformer stages break when authentication is set on applications
The Terraform Integration stage does not support Applications that have RBAC rules enabled (Application roles) with the AWS S3 Artifact Store feature enabled.
Customers that enable the AWS S3 Artifact Store feature and have Application level RBAC rules will experience issues with 
the Terraform Integration stage leading to pipeline failures with `Failed to fetch artifact` errors, similar to:
```
level=error msg="Error executing job c5b8edb5-7944-49ac-adb4-26875e999030: failed to stage directory for terraform execution:
There was a problem downloading an artifact type: remote/base64, reference: ref://myapp/c01487060c05cc2c31301c41c5811ca4ea02310e03bd02e879f13f87ec43c221 - failed to fetch artifact.
```
This will be resolved in 2.32.1 release of Armory CD. Customers are advised to contact Armory Support for assistance on working around this issue on 2.32.0

## Highlighted updates
<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->
### Terraformer support for AWS S3 Artifact Store
OSS Spinnaker 1.32.0 introduced support for [artifact storage](https://spinnaker.io/changelogs/1.32.0-changelog/#artifact-store) 
with AWS S3. This feature compresses `embdedded/base64` artifacts to `remote/base64` and uploads them to an AWS S3 bucket significantly 
reducing the artifact size in the execution context. 

Armory version 2.32.0 adds support for the same feature for the Terraform Integration stage.

>Note: The artifact-store feature is disabled by default. To enable the artifact-store feature the following configuration is required:
```yaml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      spinnaker:
        artifact-store:
        enabled: true
        s3:
          enabled: true
          region: <S3Bucket Region>
          bucket: <S3Bucket Name>
```

When enabling the artifact-store feature it is recommended to deploy the services in this order:
1. Clouddriver service
2. Terraformer service
3. Orca service
4. Rosco service

### Enable Jenkins job triggers for jobs located sub-folders
When defining a Jenkins job in a sub-folder, the path contains forward slashes. By enabling this feature, Armory CD will be
able to trigger Jenkins jobs located in sub-folders, correctly matching the job path.
```yaml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      echo:
        feature:
          igor:
            jobNameAsQueryParameter: true
      orca:
        feature:
          igor:
            jobNameAsQueryParameter: true
      igor:
        feature:
          igor:
            jobNameAsQueryParameter: true
```

### Pipeline As Code: Bitbucket fallback support for default branch
By default, Dinghy uses the `master` branch in your repository and fallbacks to `main` if `master` doesn’t exist.
If you wish to use a different branch in your repository, you can configure that using the `repoConfig` tag in your YAML configuration.
```yaml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      dinghy:
        repoConfig:
        - branch: some_branch
          provider: bitbucket-server
          repo: my-bitbucket-repository
```


###  Spinnaker community contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.32.3](https://www.spinnaker.io/changelogs/1.32.3-changelog/) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

<details><summary>Expand to see the BOM</summary>
<pre class="highlight">
<code>artifactSources:
  dockerRegistry: docker.io/armory
dependencies:
  redis:
    commit: null
    version: 2:2.8.4-2
services:
  clouddriver:
    commit: 27d2b5f64b07ae03a49edac6f3e937b06f15d1bf
    version: 2.32.0
  deck:
    commit: e7c8c0982afe9a49ab6c3d230f3aaa38e874eb30
    version: 2.32.0
  dinghy:
    commit: f5b14ffba75721322ada662f2325e80ec86347de
    version: 2.32.0
  echo:
    commit: d7483b6acd82b7b7a8053a1ec66aa9897930dbea
    version: 2.32.0
  fiat:
    commit: 2c0d010ce00d9519b316e15af734a05835df1048
    version: 2.32.0
  front50:
    commit: c68b97b642a6d9168d361d74dad373e565850f5d
    version: 2.32.0
  gate:
    commit: 1f96d4f238c63798cf34e818760ffb25b3a4b009
    version: 2.32.0
  igor:
    commit: fe40091df01e89e9abc4b6b761002397c4022298
    version: 2.32.0
  kayenta:
    commit: af68e872b806eb49f4f0071187f998f18f04c3c2
    version: 2.32.0
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 538b577c932e3c67af7db78f28fa3ee0209e934b
    version: 2.32.0
  rosco:
    commit: 776c66208dd16ad41defad3d0b6d8bcc3dbba24d
    version: 2.32.0
  terraformer:
    commit: 58c3386295676fccf44aa9d38c69e1e0482109ca
    version: 2.32.0
timestamp: "2024-02-13 16:21:59"
version: 2.32.0
</code>
</pre>
</details>

### Armory


#### Armory Deck - 2.31.0...2.32.0

- chore(cd): update base deck version to 2023.0.0-20231018060056.release-1.31.x (#1361)
- fix(action): upgrade node version to match OSS (#1356) (#1357)
- chore(alpine): Fix Deck to support ARM processor - SAAS-1953 (backport #1341) (#1355)
- chore(ci): removed aquasec scan action (#1340) (#1344)
- chore(cd): update base deck version to 2023.0.0-20230403112432.master (#1325)
- chore(ci): removed aquasec scan action (#1340) (#1387)
- chore: OS updates (#1354) (#1388)
- chore(alpine): Fix Deck to support ARM processor - SAAS-1953 (backport #1341) (#1386)
- fix(action): upgrade node version to match OSS (#1356) (#1385)
- chore(cd): update base deck version to 2023.0.0-20231024141913.release-1.32.x (#1380)
- chore(oss): Sync oss with release-2.32-x  (#1389)
- build(action): pass version to fix build (#1390) (#1391)
- chore(cd): update base deck version to 2023.0.0-20231024141913.release-1.32.x (#1395)

#### Armory Fiat - 2.31.0...2.32.0

- chore(feat): Support ARM with docker buildx - SAAS-1953 (#540) (#541)
- chore(ci): removed aquasec scan action (#523) (#525)
- fix(okhttp): Decrypt properties before creating client. (#501) (#504)
- chore(cd): update armory-commons version to 3.14.2 (#500)
- chore(armory-commons): upgrading armory-commons to 3.14.0-rc.3 (#497)
- chore(ci): removed aquasec scan action (#523) (#569)
- chore: OS Updates (#532) (#568)
- chore(feat): Support ARM with docker buildx - SAAS-1953 (backport #540) (#567)
- chore(cd): update armory-commons version to 3.15.2 (#572)
- chore(cd): update base service version to 2023.08.24.21.54.55.master (#573)

#### Armory Clouddriver - 2.31.0...2.32.0

- chore(cd): update base service version to clouddriver:2023.11.20.21.43.26.release-1.31.x (#1030)
- chore(feat): Support ARM with docker buildx - SAAS-1953 (backport #999) (#1004)
- fix: CVE-2023-37920 (#977) (#993)
- chore(ci): removed aquasec scan action (#971) (#982)
- chore(cd): update base service version to clouddriver:2023.09.20.19.42.06.release-1.31.x (#981)
- chore(cd): update base service version to clouddriver:2023.09.08.18.30.47.release-1.31.x (#968)
- chore(cd): update base service version to clouddriver:2023.08.29.05.45.59.release-1.31.x (#942)
- chore(cd): update base service version to clouddriver:2023.08.28.17.52.39.release-1.31.x (#941)
- chore(cd): update base service version to clouddriver:2023.08.28.14.14.40.release-1.31.x (#939)
- fix: AWS CLI pip installation (#918) (#924)
- chore(cd): update base service version to clouddriver:2023.07.21.18.25.26.release-1.31.x (#915)
- chore(cd): update armory-commons version to 3.14.2 (#911)
- chore(cd): update base service version to clouddriver:2023.06.05.20.51.02.master (#885)
- chore(cd): update base service version to clouddriver:2023.11.22.08.49.43.release-1.32.x (#1053)
- fix: Enable bootstrap mechanism disabled and deprecated starting with spring cloud 2020.0.0 (#888) (#1061)
- fix: CVE-2023-37920 (#977) (#1062)
- chore(feat): Support ARM with docker buildx - SAAS-1953 (backport #999) (#1064)
- chore(cd): update armory-commons version to 3.15.2 (#1068)

#### Armory Front50 - 2.31.0...2.32.0

- chore(ci): removed aquasec scan action (#590) (#593)
- chore(cd): update base service version to front50:2023.09.05.18.25.32.release-1.31.x (#584)
- chore(cd): update base service version to front50:2023.08.29.04.59.48.release-1.31.x (#581)
- chore(cd): update base service version to front50:2023.08.28.17.17.25.release-1.31.x (#580)
- chore(cd): update armory-commons version to 3.14.2 (#567)
- chore(cd): update base service version to front50:2023.07.18.21.40.31.master (#563)
- chore(cd): update base service version to front50:2023.09.05.18.32.03.release-1.32.x (#633)
- chore: Front50 OS upgrade (#604) (#639)
- chore(feat): Support ARM with docker buildx - SAAS-1953 (backport #612) (#642)
- chore(cd): update armory-commons version to 3.15.2 (#645)

#### Armory Orca - 2.31.0...2.32.0

- chore(cd): update base orca version to 2023.11.07.16.19.53.release-1.31.x (#765)
- chore(cd): update base orca version to 2023.11.06.18.16.18.release-1.31.x (#763)
- chore(cd): update base orca version to 2023.10.18.06.01.58.release-1.31.x (#751)
- chore(feat): Support ARM with docker buildx - SAAS-1953 (backport #704) (#746)
- fix(ci): added release.version to docker build (#745)
- chore(cd): update base orca version to 2023.10.10.16.08.51.release-1.31.x (#743)
- fix(terraformer): Ignoring logs from the Terraformer stage context (#740) (#742)
- chore(ci): removing docker build and aquasec scans (#715)
- chore(cd): update base orca version to 2023.09.22.18.05.39.release-1.31.x (#714)
- chore(cd): update base orca version to 2023.09.22.14.30.27.release-1.31.x (#711)
- chore(ci): removed aquasec scan action (#695) (#705)
- chore(cd): update base orca version to 2023.08.29.05.07.45.release-1.31.x (#688)
- chore(cd): update base orca version to 2023.08.28.20.04.29.release-1.31.x (#687)
- chore(cd): update base orca version to 2023.07.21.15.43.04.release-1.31.x (#675)
- chore(cd): update armory-commons version to 3.14.2 (#671)
- chore(cd): update base orca version to 2022.04.01.22.15.58.master (#459)
- chore(cd): update base orca version to 2023.11.07.00.08.45.release-1.32.x (#791)
- fix(terraformer): Ignoring logs from the Terraformer stage context (#740) (#802)
- chore(feat): Support ARM with docker buildx - SAAS-1953 (backport #704) (#801)
- chore(cd): update armory-commons version to 3.15.2 (#805)
- chore(build): pull latest changes from master (#806)
- fix(terraformer): Fixing NPE for artifact binding (#810)
- Update RunTerraformTask.java
- feat(jenkins): Enable Jenkins job triggers for jobs in sub-folders (#822)

#### Armory Kayenta - 2.31.0...2.32.0

- Update buildx for build gradle and action workflow (#484) (#485)
- chore(ci): removed aquasec scan action (#469) (#470)
- chore(cd): update armory-commons version to 3.14.2 (#456)
- fix: Remove whitespace when defining spring properties (#437)
- chore: OS Updates (#476) (#508)
- fix(dev): renaming package of main class to run kayenta locally (#452) (#509)
- chore(cd): update base service version to kayenta:2023.11.22.03.11.43.master (#493) (#510)
- chore(feat): Support ARM arch - SAAS-1953 (backport #484) (#507)
- chore(cd): update armory-commons version to 3.15.2 (#513)
- Update gradle.properties (#514)

#### Armory Echo - 2.31.0...2.32.0

- chore(feat): Support ARM with docker buildx - SAAS-1953 (backport #637) (#640)
- chore(cd): update base service version to echo:2023.08.29.05.00.24.release-1.31.x (#612)
- chore(ci): removed aquasec scan action (#618) (#621)
- chore(cd): update armory-commons version to 3.14.2 (#601)
- chore(cd): update base service version to echo:2023.02.20.21.09.15.master (#539)
- fix: Upgrade grpc-netty-shaded to address the service initialization failure issue. (#647) (#649) (#672)
- chore(feat): Support ARM with docker buildx - SAAS-1953 (backport #637) (#674)
- chore(cd): update base service version to echo:2023.09.27.02.27.14.master (backport #630) (#673)
- chore(cd): update armory-commons version to 3.15.2 (#677)
- chore(cd): update base service version to echo:2023.08.29.18.12.32.master (#678)
- chore(cd): update base service version to echo:2024.02.13.00.21.09.release-1.32.x (#684)

#### Armory Gate - 2.31.0...2.32.0

- chore(ci): removed aquasec scan action (#616) (#621)
- chore(cd): update base service version to gate:2023.09.01.15.43.46.release-1.31.x (#607)
- fix: esapi CVE scan report (#602) (#605)
- chore(cd): update base service version to gate:2023.08.29.05.01.02.release-1.31.x (#604)
- chore(cd): update base service version to gate:2023.08.28.17.15.40.release-1.31.x (#600)
- chore(cd): update armory-commons version to 3.14.2 (#586)
- chore(armory-commons): upgrading armory-commons to 3.14.0-rc.3 (#583)
- Updating Banner plugin to 0.2.0 (#630) (#672)
- chore: OS Upgrades (#629) (#671)
- chore(feat): Support ARM with docker buildx - SAAS-1953 (backport #640) (#670)
- chore(cd): update base service version to gate:2023.09.01.15.44.50.release-1.32.x (#664)
- chore(cd): update armory-commons version to 3.15.2 (#676)
- Removing Instance registration from Gate (#677) (#678)
- Fixnig armory header plugin (#681)
- fix(header): Fix local repo for Armory.Header (#682)
- Fixing header plugin reference (#684) (#685)
- chore(cd): update base service version to gate:2024.02.01.16.29.20.release-1.32.x (#689)

#### Terraformer™ - 2.31.0...2.32.0

- fix(cd): Fix terraform build fail (#529) (#530)
- Minor changes for Terraform tag name (#527) (#528)
- chore(feat): Support ARM with docker buildx - SAAS-1953 (backport #525) (#526)
- chore(ci): removed aquasec scan action (#510) (#511)
- chore(ci): removing aquasec scans on push (#517) (#518)
- chore(alpine): Update alpine version (#497)
- chore(cd): Merge master to release-2.32.x branch (#540)
- fix(remote/artifacts): Adding support to fetch remote artifacts from clouddriver (#543) (#544)
- fixes for planfile (#545) (#546)

#### Armory Igor - 2.31.0...2.32.0

- fix: NoSuchMethodError exception in JenkinsClient. (#377) (#529)
- chore(feat): Support ARM with docker buildx - SAAS-1953 (#524) (#525)
- chore(ci): removed aquasec scan action (#495) (#507)
- chore(cd): update armory-commons version to 3.14.2 (#475)
- chore(cd): update base service version to igor:2022.09.14.15.59.58.master (#368)
- fix: NoSuchMethodError exception in JenkinsClient. (#377) (#558)
- chore(feat): Support ARM with docker buildx - SAAS-1953 (backport #524) (#557)
- chore(cd): update base service version to igor:2024.01.22.15.24.36.release-1.32.x (#554)
- chore(cd): update armory-commons version to 3.15.2 (#562)
- chore: OS Updates (#516) (#566)

#### Dinghy™ - 2.31.0...2.32.0

- chore(feat): Support ARM with docker buildx - SAAS-1953 (backport #504) (#511)
- chore(ci): removing aquasec scans for any push (#497) (#498)
- chore(ci): removed aquasec scan action (#489) (#491)
- chore(alpine): Upgrade alpine version (#481)
- chore(ci): removing aquasec scans for any push (#497) (#519)
- fix: Builds (backport #512) (#521)
- chore(feat): Support ARM with docker buildx - SAAS-1953 (backport #504) (#520)
- feat(stash): bumped oss dinghy version to introduce upgraded downloaded logic for BitBucket/Stash (#524)
- chore(dependencies): updated oss dinghy version (backport #525) (#527)
- chore(dependencies): v0.0.0-20240213103436-d0dc889db2c6 (backport #529) (#532)

#### Armory Rosco - 2.31.0...2.32.0

- chore(feat): Support ARM with docker buildx - SAAS-1953 (backport #584) (#587)
- chore(cd): update base service version to rosco:2023.08.28.17.15.52.release-1.31.x (#562)
- chore(ci): removed aquasec scan action (#565) (#567)
- chore(cd): update armory-commons version to 3.14.2 (#552)
- chore(armory-commons): upgrading armory-commons to 3.14.0-rc.3 (#549)
- chore(cd): update armory-commons version to 3.15.2 (#626)
- chore(feat): Support ARM with docker buildx - SAAS-1953 (backport #584) (#622)
- fix(ci): Removing integration tests as not stable (#627) (#628)
- chore(cd): update base service version to rosco:2023.10.18.06.02.52.release-1.32.x (#616)


### Spinnaker


#### Spinnaker Deck - 1.32.3

- feat(helm/bake): Add additional input fields where we can fill in details of the APIs versions (#10036) (#10047)
- fix: Scaling bounds should parse float not int (#10026) (#10032)
- Revert "fix(core): conditionally hide expression evaluation warning messages (#9771)" (#10021) (#10023)
- Publish packages to NPM (#10000)
- chore(dependencies): Autobump spinnakerGradleVersion (#10002)
- chore(dependencies): Autobump spinnakerGradleVersion (#10004)
- feat(lambda): Migrate Lambda plugin to OSS (#9988)
- chore(dependencies): Autobump spinnakerGradleVersion (#10006)
- chore(build): upgrade to Gradle 7.6.1 (#10008)
- fix(core/pipeline): Resolved issue getting during pipeline save with spaces in pipeline name. (#10009)
- feat(cdevents-webhooks) : CDEvents Webhook type in Automated Triggers type (#9977)
- fix(security): don't expose server information on error pages (#10010)
- feat(artifacts): Add support for artifact store views and calls (#10011)
- feat(kubernetes): Add Deck stage for Rolling Restart (#10012)
- chore(dependencies): Autobump spinnakerGradleVersion (#10013)
- feat(stages/bakeManifests): add helmfile support (#9998)
- Publish packages to NPM (#10005)
- feat(core): set Cancellation Reason to be expanded by default (#10018)
- Revert "fix(core): conditionally hide expression evaluation warning messages (#9771)" (#10021) (#10022)
- fix: Scaling bounds should parse float not int (#10026) (#10033)
- fix(kubernetes): export rollout restart stage so it's actually available for use (#10037) (#10043)
- feat(helm/bake): Add additional input fields where we can fill in details of the APIs versions (#10036) (#10048)
- fix(lambda): available Runtimes shared between Deploy stage and Functions tab (#10050) (#10054)

#### Spinnaker Fiat - 1.32.3

- fix(ssl): Removed unused deprecated okHttpClientConfig from retrofitConfig. (#1082) (#1092)
- fix(roles-sync): fix CallableCache's NPE exception for caching synchronization strategy (#1077) (#1081)
- chore(dependencies): Autobump korkVersion (#1057)
- feat(fiat): Suppress application details when updating permissions (#1060)
- feat(ldap): Support for handling DN based multiloaded roles (#1058)
- chore(build): upgrade gradle to 7.6.1 (#1059)
- chore(dependencies): Autobump korkVersion (#1061)
- chore(dependencies): Autobump spinnakerGradleVersion (#1062)
- chore(dependencies): Autobump korkVersion (#1063)
- chore(dependencies): Autobump korkVersion (#1064)
- chore(dependencies): Autobump spinnakerGradleVersion (#1065)
- chore(dependencies): Autobump spinnakerGradleVersion (#1067)
- chore(preview): remove preview feature of version ordering (VERSION_ORDERING_V2) for gradle dependencies (#1068)
- feat(fiat) - Cache fetched LDAP roles to speed up role syncs. (#1066)
- chore(dependencies): Autobump korkVersion (#1070)
- chore(dependencies): Autobump korkVersion (#1071)
- chore(dependencies): Autobump korkVersion (#1072)
- refactor(tests): convert junit4 based testcases to junit5 and clean up in fiat (#1073)
- chore(dependencies): Autobump korkVersion (#1074)
- chore(dependencies): Autobump korkVersion (#1075)
- fix(ldap): fixed sporadic occurrence of InvalidCacheLoadException (#1076)
- fix(roles-sync): fix CallableCache's NPE exception for caching synchronization strategy (#1077)
- chore(dependencies): Autobump spinnakerGradleVersion (#1078)
- chore(dependencies): Autobump korkVersion (#1083)
- chore(dependencies): Autobump korkVersion (#1084)
- chore(dependencies): Autobump korkVersion (#1085)
- chore(dependencies): Autobump korkVersion (#1086)
- fix(ssl): Removed unused deprecated okHttpClientConfig from retrofitConfig. (#1082)
- chore(dependencies): Autobump korkVersion (#1093)
- chore(dependencies): Autobump korkVersion (#1094)

#### Spinnaker Clouddriver - 1.32.3

- fix(cats): passing incorrect redis config into interval provider (#6105) (#6108)
- fix(lambda): Lambda is leaking threads on agent refreshes.  remove the custom threadpool (#6048) (#6049)
- fix: Fix docker build in GHA by removing some of the GHA tools (#6033) (#6036)
- chore(dependencies): Autobump fiatVersion (#6011)
- chore(dependencies): Autobump korkVersion (#6010)
- fix(builds): Backport flag for installing aws cli (#6009)
- fix(gce): remove the duplicate cache attribute "subnet" and update the test (#5977) (#5984)
- chore(dependencies): Autobump fiatVersion (#5962)
- chore(dependencies): Autobump korkVersion (#5964)
- chore(dependencies): Autobump spinnakerGradleVersion (#5965)
- chore(build): upgrade gradle to 7.6.1 (#5966)
- chore(dependencies): Autobump korkVersion (#5967)
- chore(dependencies): Autobump korkVersion (#5968)
- feat: Add the possibility to update the default handler for the Global Resource Property Registry. (#5963)
- chore(dependencies): Autobump spinnakerGradleVersion (#5969)
- chore(dependencies): Autobump spinnakerGradleVersion (#5970)
- chore(preview): remove preview feature of version ordering (VERSION_ORDERING_V2) for gradle dependencies (#5974)
- chore(dependencies): Autobump korkVersion (#5975)
- chore(dependencies): Autobump korkVersion (#5978)
- chore(dependencies): Autobump korkVersion (#5979)
- feat(artifacts): Adds ArtifactStore logic to clouddriver (#5976)
- chore(dependencies): Autobump korkVersion (#5980)
- chore(dependencies): Autobump korkVersion (#5981)
- chore(dependencies): Autobump spinnakerGradleVersion (#5983)
- perf(cache): Optimise heap usage in SqlCache (#5982)
- fix(gce): remove the duplicate cache attribute "subnet" and update the test (#5977)
- refactor(tests): convert junit4 based testcases to junit5 and clean up in clouddriver (#5987)
- feat(integration-tests): increase kubernetes integration test coverage (#5990)
- chore(dependencies): Autobump korkVersion (#5991)
- chore(dependencies): Autobump korkVersion (#5992)
- chore(dependencies): Autobump korkVersion (#5993)
- chore(kubectl): upgrade kubectl version from 1.20.6 to 1.22.17 (#5953)
- chore(upgrades): Upgrade Ubuntu to latest release and fixes aws cli i… (#5996)
- chore(awscli): Bump AWS CLI and fix install of AWS CLI (#5995)
- chore(dependencies): Autobump korkVersion (#5994)
- chore(dependencies): Autobump korkVersion (#6005)
- chore(os): Update download location and get the kubectl the same between ubuntu and slim (#6003)
- chore(dependencies): Autobump fiatVersion (#6012)
- fix: Fix docker build in GHA by removing some of the GHA tools (#6033) (#6037)
- fix(lambda): Lambda is leaking threads on agent refreshes.  remove the custom threadpool (#6048) (#6050)
- fix(cats): passing incorrect redis config into interval provider (#6105) (#6109)
- feat(gcp): provide a configurable option to bypass gcp account health check. (backport #6093) (#6096)

#### Spinnaker Front50 - 1.32.3

- chore(dependencies): Autobump fiatVersion (#1300)
- chore(dependencies): Autobump korkVersion (#1299)
- fix(core): skip existing items with null ids in StorageServiceSupport.fetchAllItemsOptimized (#1279) (#1281)
- fix(core): tolerate items with null ids (#1276) (#1280)
- fix(web): check trigger.getType() for null before invoking equals method (#1277) (#1278)
- chore(dependencies): Autobump fiatVersion (#1264)
- chore(build): upgrade gradle to 7.6.1 (#1265)
- chore(dependencies): Autobump korkVersion (#1266)
- chore(dependencies): Autobump spinnakerGradleVersion (#1267)
- chore(dependencies): Autobump korkVersion (#1268)
- chore(dependencies): Autobump korkVersion (#1269)
- chore(dependencies): Autobump spinnakerGradleVersion (#1270)
- chore(dependencies): Autobump spinnakerGradleVersion (#1271)
- chore(preview): remove preview feature of version ordering (VERSION_ORDERING_V2) for gradle dependencies (#1272)
- chore(dependencies): Autobump korkVersion (#1273)
- feat(sql): add configuration property sql.healthIntervalMillis (#1275)
- fix(core): tolerate items with null ids (#1276)
- fix(web): check trigger.getType() for null before invoking equals method (#1277)
- fix(core): skip existing items with null ids in StorageServiceSupport.fetchAllItemsOptimized (#1279)
- chore(dependencies): Autobump korkVersion (#1282)
- chore(dependencies): Autobump korkVersion (#1283)
- chore(dependencies): Autobump korkVersion (#1284)
- chore(dependencies): Autobump korkVersion (#1285)
- chore(build): update default containers to JRE 17 (#1274)
- chore(dependencies): Autobump spinnakerGradleVersion (#1286)
- chore(dependencies): Autobump korkVersion (#1287)
- chore(dependencies): Autobump korkVersion (#1288)
- chore(dependencies): Autobump korkVersion (#1289)
- chore(dependencies): Autobump korkVersion (#1290)
- chore(dependencies): Autobump korkVersion (#1297)
- chore(dependencies): Autobump korkVersion (#1298)
- chore(dependencies): Autobump fiatVersion (#1301)
- fix(dependency): fix dependency version leak of google-api-services-storage from kork in front50-web (#1302) (#1385)

#### Spinnaker Orca - 1.32.3

- fix(artifacts): Parent and child pipeline artifact resolution (backport #4575) (#4582)
- feat(helm/bake): Add additional input fields where we can fill in details of the APIs versions (#4546) (#4564)
- fix(front50): teach MonitorPipelineTask to handle missing/null execution ids (#4555) (#4561)
- fix(vpc): add data annotation to vpc (#4534) (#4537)
- fix: duplicate entry exception for correlation_ids table. (#4521) (#4531)
- chore(dependencies): Autobump fiatVersion (#4514)
- chore(dependencies): Autobump korkVersion (#4513)
- fix(artifacts): consider requiredArtifactIds in expected artifacts when trigger is pipeline type (#4489) (#4491)
- fix(queue): fix ability to cancel a zombied execution (#4473) (#4477)
- chore(dependencies): Autobump fiatVersion (#4464)
- feat(mpt-v1): Support for jinja expressions in stages (#4462)
- chore(dependencies): Autobump korkVersion (#4465)
- chore(dependencies): Autobump spinnakerGradleVersion (#4466)
- chore(build): upgrade gradle to 7.6.1 (#4463)
- chore(dependencies): Autobump korkVersion (#4467)
- chore(dependencies): Autobump spinnakerGradleVersion (#4468)
- feat(lambda): migrate stages from AWS Lambda plugin to OSS (#4449)
- fix(queue): Manual Judgment propagation (#4469)
- chore(dependencies): Autobump spinnakerGradleVersion (#4472)
- fix(queue): fix ability to cancel a zombied execution (#4473)
- chore(dependencies): Autobump korkVersion (#4480)
- chore(dependencies): Autobump korkVersion (#4482)
- chore(dependencies): Autobump korkVersion (#4483)
- feat(artifacts): Add ArtifactStore to orca (#4481)
- refactor(tests): convert junit4 based test cases to junit5, clean up and unpin mockito in orca (#4484)
- chore(dependencies): Autobump korkVersion (#4485)
- chore(dependencies): Autobump korkVersion (#4486)
- chore(dependencies): Autobump spinnakerGradleVersion (#4488)
- feat(orca-bakery/manfests): add helmfile support (#4460)
- fix(artifacts): consider requiredArtifactIds in expected artifacts when trigger is pipeline type (#4489)
- feat(provider/google): Added cloudrun manifest functionality in orca. (#4396)
- chore(dependencies): Autobump korkVersion (#4499)
- chore(dependencies): Autobump korkVersion (#4500)
- chore(dependencies): Autobump korkVersion (#4501)
- chore(dependencies): Autobump korkVersion (#4502)
- fix(expressions): fetch labels from actually deployed manfiest (#4508)
- chore(dependencies): Autobump korkVersion (#4511)
- chore(dependencies): Autobump korkVersion (#4512)
- chore(dependencies): Autobump fiatVersion (#4515)
- fix: duplicate entry exception for correlation_ids table. (#4521) (#4530)
- fix(vpc): add data annotation to vpc (#4534) (#4538)
- fix(front50): teach MonitorPipelineTask to handle missing/null execution ids (#4555) (#4559)
- feat(helm/bake): Add additional input fields where we can fill in details of the APIs versions (#4546) (#4565)
- fix(artifacts): Parent and child pipeline artifact resolution (backport #4575) (#4583)
- fix(artifacts): Automated triggers with artifact constraints are broken if you have 2 or more of the same type (backport #4579) (#4588)
- feat(jenkins): Enable Jenkins job triggers for jobs in sub-folders (#4618) (#4634)

#### Spinnaker Kayenta - 1.32.3

- fix(orca): Fix orca contributors status. (backport #977) (#980)
- chore(dependencies): Autobump orcaVersion (#966)
- chore(dependencies): Autobump spinnakerGradleVersion (#968)
- chore(build): upgrade gradle to 7.6.1 (#967)
- chore(dependencies): Autobump spinnakerGradleVersion (#969)
- chore(dependencies): Autobump spinnakerGradleVersion (#970)
- chore(preview): remove preview feature of version ordering (VERSION_ORDERING_V2) for gradle dependencies (#971)
- chore(dependencies): Autobump spinnakerGradleVersion (#973)
- chore(dependencies): Autobump orcaVersion (#974)
- feat(exceptions): Add SpinnakerRetrofitErrorHandler and replace RetrofitError catch blocks (#972)
- fix(orca): Fix orca contributors status. (#977)
- chore(dependencies): Autobump orcaVersion (#984)
- chore(dependencies): Autobump orcaVersion (#1002)

#### Spinnaker Echo - 1.32.3

- chore(dependencies): Autobump korkVersion (#1333)
- fix(gha): Fix github status log and add tests (#1316) (#1318)
- chore(dependencies): Autobump fiatVersion (#1299)
- chore(dependencies): Autobump korkVersion (#1301)
- chore(dependencies): Autobump spinnakerGradleVersion (#1302)
- chore(build): upgrade gradle to 7.6.1 (#1300)
- chore(dependencies): Autobump korkVersion (#1303)
- chore(dependencies): Autobump korkVersion (#1304)
- chore(dependencies): Autobump spinnakerGradleVersion (#1305)
- chore(dependencies): Autobump spinnakerGradleVersion (#1306)
- chore(preview): remove preview feature of version ordering (VERSION_ORDERING_V2) for gradle dependencies (#1307)
- chore(dependencies): Autobump korkVersion (#1308)
- feat(cdevents-webhooks) : Consume CDEvents webhook API implementation (#1290)
- chore(dependencies): Autobump korkVersion (#1309)
- chore(dependencies): Autobump korkVersion (#1310)
- refactor(tests): convert junit4 based testcases to junit5 and clean up in echo (#1311)
- chore(dependencies): Autobump korkVersion (#1312)
- chore(dependencies): Autobump korkVersion (#1313)
- chore(dependencies): Autobump spinnakerGradleVersion (#1314)
- fix(gha): Fix github status log and add tests (#1316)
- chore(dependencies): Autobump korkVersion (#1321)
- chore(dependencies): Autobump korkVersion (#1322)
- feat(rest/circuit-breaker): Optimize Circuit Breaker in Rest Events (#1315)
- chore(dependencies): Autobump korkVersion (#1323)
- chore(dependencies): Autobump korkVersion (#1324)
- chore(dependencies): Autobump korkVersion (#1331)
- chore(dependencies): Autobump korkVersion (#1332)
- chore(dependencies): Autobump fiatVersion (#1335)
- feat(jenkins): Enable Jenkins job triggers for jobs in sub-folders (#1373) (#1381)

#### Spinnaker Gate - 1.32.3

- chore(dependencies): Autobump fiatVersion (#1697)
- chore(dependencies): Autobump korkVersion (#1695)
- chore(dependencies): Autobump fiatVersion (#1662)
- chore(dependencies): Autobump korkVersion (#1664)
- chore(dependencies): Autobump spinnakerGradleVersion (#1665)
- chore(build): upgrade gradle to 7.6.1 (#1660)
- chore(dependencies): Autobump korkVersion (#1666)
- chore(dependencies): Autobump korkVersion (#1667)
- chore(dependencies): Autobump spinnakerGradleVersion (#1668)
- chore(dependencies): Autobump spinnakerGradleVersion (#1669)
- cleanup(preview): remove preview feature of version ordering (VERSION_ORDERING_V2) for gradle dependencies (#1670)
- chore(dependencies): Autobump korkVersion (#1672)
- fix(retrofit): use OkHttpClient from Kork (#1673)
- Migration of various Groovy classes to Java (#1663)
- chore(dependencies): Autobump korkVersion (#1675)
- chore(dependencies): Autobump korkVersion (#1676)
- feat(artifacts): Add new ArtifactStore endpoints (#1674)
- refactor(tests): convert junit4 based test cases to junit5 and clean up in gate (#1677)
- chore(dependencies): Autobump korkVersion (#1678)
- chore(dependencies): Autobump korkVersion (#1679)
- chore(dependencies): Autobump spinnakerGradleVersion (#1680)
- chore(cleanup): Removing un-implemented dead code (#1681)
- chore(dependencies): Autobump korkVersion (#1682)
- chore(dependencies): Autobump korkVersion (#1683)
- chore(dependencies): Autobump korkVersion (#1684)
- chore(dependencies): Autobump korkVersion (#1685)
- feat(cdevents-webhooks) : Consume  CDEvents webhook API implementation (#1651)
- chore(dependencies): Autobump korkVersion (#1692)
- chore(dependencies): Autobump korkVersion (#1693)
- fix(md): update env model to have post deploy (#1576)
- chore(dependencies): Autobump fiatVersion (#1698)
- fix(cachingFilter: Allow disabling the content caching filter (#1699) (#1702)
- fix: Fix git trigger issue caused by a misconfig of the object mapper when creating the echo retrofit service (#1756) (#1757)

#### Spinnaker Igor - 1.32.3

- chore(dependencies): Autobump korkVersion (#1162)
- chore(dependencies): Autobump fiatVersion (#1134)
- chore(dependencies): Autobump spinnakerGradleVersion (#1137)
- chore(build): upgrade gradle to 7.6.1 (#1135)
- chore(dependencies): Autobump korkVersion (#1136)
- chore(dependencies): Autobump korkVersion (#1138)
- chore(dependencies): Autobump spinnakerGradleVersion (#1139)
- chore(dependencies): Autobump spinnakerGradleVersion (#1140)
- chore(preview): remove preview feature of version ordering (VERSION_ORDERING_V2) for gradle dependencies (#1141)
- chore(dependencies): Autobump korkVersion (#1142)
- chore(dependencies): Autobump korkVersion (#1144)
- chore(dependencies): Autobump korkVersion (#1145)
- refactor(tests): convert junit4 based testcases to junit5 and clean up in igor (#1146)
- chore(dependencies): Autobump korkVersion (#1147)
- chore(dependencies): Autobump korkVersion (#1148)
- chore(build): default containers to JRE 17 (#1143)
- chore(dependencies): Autobump spinnakerGradleVersion (#1149)
- chore(dependencies): Autobump korkVersion (#1150)
- chore(dependencies): Autobump korkVersion (#1151)
- chore(dependencies): Autobump korkVersion (#1152)
- chore(dependencies): Autobump korkVersion (#1153)
- chore(dependencies): Autobump korkVersion (#1160)
- chore(dependencies): Autobump korkVersion (#1161)
- chore(dependencies): Autobump fiatVersion (#1164)
- fix(java17): remove long-deprecated import that doesn't work with JRE17 (#1170) (#1171)
- fix(java17): add Jackson converter to RestAdapters to avoid Gson (#1174) (#1176)
- fix(java17): stop accessing private fields, run tests using JRE17 (#1173) (#1175)
- feat(jenkins): Enable Jenkins job triggers for jobs in sub-folders (#1204) (#1216)

#### Spinnaker Rosco - 1.32.3

- chore(dependencies): Autobump korkVersion (#1014)
- chore(dependencies): Autobump korkVersion (#988)
- chore(dependencies): Autobump korkVersion (#990)
- chore(dependencies): Autobump spinnakerGradleVersion (#991)
- chore(build): upgrade gradle to 7.6.1 (#989)
- chore(dependencies): Autobump korkVersion (#992)
- chore(dependencies): Autobump korkVersion (#993)
- chore(dependencies): Autobump spinnakerGradleVersion (#994)
- chore(dependencies): Autobump spinnakerGradleVersion (#995)
- chore(preview): remove preview feature of version ordering (VERSION_ORDERING_V2) for gradle dependencies (#996)
- chore(dependencies): Autobump korkVersion (#997)
- chore(dependencies): Autobump korkVersion (#999)
- chore(dependencies): Autobump korkVersion (#1000)
- feat(artifacts): Add ArtifactStore to rosco (#998)
- refactor(tests): convert junit4 based testcases to junit5 and clean up in rosco (#1001)
- chore(dependencies): Autobump korkVersion (#1002)
- chore(dependencies): Autobump korkVersion (#1003)
- feat(manifests/helmfile): add helmfile templating engine (#986)
- chore(dependencies): Autobump spinnakerGradleVersion (#1004)
- chore(dependencies): Autobump korkVersion (#1005)
- chore(dependencies): Autobump korkVersion (#1006)
- chore(dependencies): Autobump korkVersion (#1007)
- chore(dependencies): Autobump korkVersion (#1008)
- chore(dependencies): Autobump korkVersion (#1012)
- chore(dependencies): Autobump korkVersion (#1013)
- feat(helm/bake): Add additional input fields where we can fill in details of the APIs versions (#1020) (#1031)
