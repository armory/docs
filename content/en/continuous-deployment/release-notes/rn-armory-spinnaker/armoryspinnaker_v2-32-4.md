---
title: v2.32.4 Armory Continuous Deployment Release (Spinnaker™ v1.32.0)
toc_hide: true
version: 2.32.4
date: 2024-08-30
description: >
  Release notes for Armory Continuous Deployment v2.32.4.
---

<!-- 
MAKE SURE TO ADD 'LTS' OR 'FEATURE' TO THE TITLE TO INDICATE RELEASE CATEGORY. 
FOR EXAMPLE, "Armory Continuous Deployment Release LTS" or "Armory Continuous Deployment Release Feature" so users know release category and support time period 
-->

## 2024/08/30 release notes

>Note: If you experience production issues after upgrading Armory Continuous Deployment, roll back to a previous working version and report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory CD 2.32.4, use Armory Operator 1.8.6 or later.

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

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

### Performance improvements for the search executions API operations
The search executions API operations have been optimized to improve performance and reduce the time taken to search for pipelines by triggerType or eventId.

### RunJob stage improvement
RunJob stage now persist any External Log links after the deletion of the pods. This enhancement ensures that the External Log links are available even after the pods are deleted.

### Task View loading support for Paginated requests
Task View now supports paginated requests for loading tasks. This enhancement ensures that the Task View loads tasks more efficiently,
avoiding timeouts when loading an application with high number of tasks.  

To enable this feature, set the `window.spinnakerSettings.tasksViewLimitPerPage = <number>` flag to the desired number in the `settings-local.js` deck profile. For example:

{{< highlight yaml "linenos=table,hl_lines=11" >}}
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
          window.spinnakerSettings.tasksViewLimitPerPage = 100; 
          ...
{{< /highlight >}}


###  Spinnaker community contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.32.4](https://www.spinnaker.io/changelogs/1.32.4-changelog/) changelog for details.


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
    commit: 2736c8796b346d892fb68180ed1534cd882c5f6c
    version: 2.32.4
  deck:
    commit: 9f22fea76ec0ce4ad425a09fd5793372d077f243
    version: 2.32.4
  dinghy:
    commit: f5b14ffba75721322ada662f2325e80ec86347de
    version: 2.32.4
  echo:
    commit: e376d0eb3f19fd3027820bb013b0fbf9fee98e55
    version: 2.32.4
  fiat:
    commit: b674ce72dc02d7e39008bfbf2a551b3d1cc9544e
    version: 2.32.4
  front50:
    commit: b774859c8e27ebfd90455cf0e5f3583eb9afe5d4
    version: 2.32.4
  gate:
    commit: 9a3705729990d170a142b297d2df150fac71bf0f
    version: 2.32.4
  igor:
    commit: c4e429724d83aae802796cda7c5d9b39ce6efba1
    version: 2.32.4
  kayenta:
    commit: bccd150fcc8a7cb7df537ec6269bce5d2843c703
    version: 2.32.4
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 9feaae8ddcf27315da951b4a51ffc7f0c4d4ffe6
    version: 2.32.4
  rosco:
    commit: dfe611ffdd2cf9ae7c524fb9970af47350ca5e96
    version: 2.32.4
  terraformer:
    commit: 709bc0b11d21230009e34a3229443e943db9036f
    version: 2.32.4
timestamp: "2024-08-29 13:18:29"
version: 2.32.4
</code>
</pre>
</details>

### Armory


#### Armory Igor - 2.32.3...2.32.4

  - chore(build): Updating Build dependencies (#613) (#624)

#### Armory Echo - 2.32.3...2.32.4

  - chore(build): Updating Build dependencies (#723) (#739)

#### Armory Kayenta - 2.32.3...2.32.4


#### Armory Fiat - 2.32.3...2.32.4

  - chore(build): Updating Build dependencies (#613) (#626)

#### Armory Deck - 2.32.3...2.32.4

  - chore(cd): update base deck version to 2024.0.0-20240610151853.release-1.32.x (#1421)
  - chore(cd): update base deck version to 2024.0.0-20240808191000.release-1.32.x (#1427)

#### Armory Rosco - 2.32.3...2.32.4


#### Armory Clouddriver - 2.32.3...2.32.4

  - chore(cd): update base service version to clouddriver:2024.05.15.16.46.29.release-1.32.x (#1127)
  - chore(cd): update base service version to clouddriver:2024.06.05.17.20.53.release-1.32.x (#1129)
  - chore(build): Updating Build dependencies (#1140) (#1169)
  - chore(cd): update base service version to clouddriver:2024.08.08.19.07.30.release-1.32.x (#1156)

#### Armory Front50 - 2.32.3...2.32.4

  - chore(cd): update base service version to front50:2024.06.11.18.14.17.release-1.32.x (#692)
  - chore(build): Updating Build dependencies (#697) (#713)
  - chore(cd): update base service version to front50:2024.08.23.02.19.43.release-1.32.x (#715)

#### Armory Gate - 2.32.3...2.32.4

  - chore(build): Updating Build dependencies (#732) (#750)

#### Terraformer™ - 2.32.3...2.32.4

  - chore(terraformer): Backport fixes (#571) (#573)

#### Armory Orca - 2.32.3...2.32.4

  - chore(cd): update base orca version to 2024.06.10.16.25.01.release-1.32.x (#893)
  - chore(build): Updating Build dependencies (#911) (#935)

#### Dinghy™ - 2.32.3...2.32.4



### Spinnaker


#### Spinnaker Kayenta - 1.32.4
- fix(stackdriver): handle null timeSeries and empty points (backport #1047) (#1048)

#### Spinnaker Echo - 1.32.4


#### Spinnaker Orca - 1.32.4

- fix(check-pre-condition): CheckPrecondition doesn't evaluate expression correctly after upstream stages get restarted (#4682) (#4719)
- fix(jenkins): Wrong Job name encoding in query params for Artifacts/Properties (#4722) (#4725)
- fix(blueGreen): Scaling replicaSets should not be considered for deletion (#4728) (#4732)
- feat(build): add orca-integration module to exercise the just-built docker image (backport #4721) (#4737)

#### Spinnaker Fiat - 1.32.4


#### Spinnaker Gate - 1.32.4


#### Spinnaker Clouddriver - 1.32.4

- fix(gcp): Relaxed health check for GCP accounts (#6200) (#6204)
- fix(ClusterController): Fix GetClusters returning only the last 2 providers clusterNames of application (#6210) (#6211)
- feat(build): add clouddriver-integration module to exercise the just-built docker imageTest docker image (backport #6206) (#6222) 
- chore(gcp): Adding STRONG_COOKIE_AFFINITY in gcp LB model (#6259) (#6260)


#### Spinnaker Rosco - 1.32.4


#### Spinnaker Deck - 1.32.4

- fix(lambda): Invoke stage excludedArtifactTypes not including the embedded-artifact type (#10097) (#10102)
- feat(taskView): Implement opt-in paginated request for TaskView (backport #10093) (#10094)
- fix(pipeline): Handle render/validation when stageTimeoutMs is a Spel expression (#10103) (#10106)
- fix(redblack): fixing redblack onchange values (#10107) (#10111)
- fix(lambda): Export LambdaRoute stage on aws module (#10116) (#10117)
- chore(gcp): Adding STRONG_COOKIE_AFFINITY in gcp LB model (#10124) (#10125)

#### Spinnaker Igor - 1.32.4


#### Spinnaker Front50 - 1.32.4

- fix(front50-gcs): Fix ObjectType filenames for GCS Front50 persistent store (#1493) (#1496)
- fix(migrator): GCS to SQL migrator APPLICATION_PERMISSION objectType fix (#1466) (#1472)
