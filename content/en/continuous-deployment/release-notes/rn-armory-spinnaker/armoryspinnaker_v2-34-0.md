---
title: v2.34.0 Armory Continuous Deployment Release (Spinnaker™ v1.32.4)
toc_hide: true
version: 2.34.0
date: 2024-07-18
description: >
  Release notes for Armory Continuous Deployment v2.34.0.
---

<!-- 
MAKE SURE TO ADD 'LTS' OR 'FEATURE' TO THE TITLE TO INDICATE RELEASE CATEGORY. 
FOR EXAMPLE, "Armory Continuous Deployment Release LTS" or "Armory Continuous Deployment Release Feature" so users know release category and support time period 
-->

## 2024/07/18 release notes

>Note: If you experience production issues after upgrading Armory Continuous Deployment, roll back to a previous working version and report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Armory Operator version

To install, upgrade, or configure Armory CD 2.34.0, use Armory Operator 1.8.6 or later.

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.
### Swagger UI endpoint change
API documentation implementing swagger has been upgraded to use Springfox 3.0.0.

Breaking Change: Swagger-ui endpoint changed from /swagger-ui.html to /swagger-ui/index.html.

### Kubernetes API version change for `client.authentication.k8s.io`
kubectl in the latest releases has removed support for external auth flows using the apiVersion: client.authentication.k8s.io/v1alpha1 exec API.

Breaking Change: Update your kubeconfig files to use the v1beta1 apiVersion: `client.authentication.k8s.io/v1beta1`

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->
### Spinnaker 2.34.0 Front50 GCS object store issue
Spinnaker 2.34.0 includes a known issue in Front50 that causes issues with GCS object store configurations. This issue affects:
- When GCS is used as a persistent store
- When GCS is used in a dual repository configuration

This is resolved in Spinnaker 2.34.1.

## Highlighted updates
<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->
### Spring Boot 2.6.15

Spring Boot 2.6 considers session data cached by previous Spring Boot versions invalid. Therefore, users with cached 
sessions will be unable to log in until the invalid information is removed from the cache. 

Open browser windows to Spinnaker are unresponsive after the deployment until they’re reloaded. 
Once Gate is updated to the new Armory CD version please execute:
```bash
$ redis-cli keys "spring:session*" | xargs redis-cli del
```
on Gate’s redis instance removes the cached session information.

### Lambda Operations
Introduced in OSS Spinnaker 1.33.0 and included in the 2.34.0 release, Armory CD now supports configurable Invocation timeouts 
and retries for Lambda operations. Previously the SDK would restrict timeouts despite any configuration to 55 seconds.

To set the timeout and retry values, add the following to your `clouddriver-local.yml`:

{{< highlight yaml "linenos=table,hl_lines=13-15" >}}
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      clouddriver:
        aws:
          features:
            lambda:
              enabled: true
          lambda:
            invokeTimeoutMs: 4000000
            retries: 3
{{< /highlight >}}

### Changes in S3 Artifact Store configuration
OSS Spinnaker 1.32.0 introduced support for [artifact storage](https://spinnaker.io/changelogs/1.32.0-changelog/#artifact-store)
with AWS S3. This feature compresses `embdedded/base64` artifacts to `remote/base64` and uploads them to an AWS S3 bucket significantly
reducing the artifact size in the execution context.

Armory version 2.32.0 added support for the same feature for the Terraform Integration stage.

In Armory CD version 2.34.0, the S3 Artifact Store configuration flags have been modified to support either store 
or retrieval or both of remote artifacts.

#### Configuration in 2.32.x
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

#### Configuration in 2.34.0 (Store/Get)
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
          type: s3
          s3:
            enabled: true
            region: <S3Bucket Region>
            bucket: <S3Bucket Name>
```

#### Configuration in 2.34.0 (Get only)
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
          type: s3
          s3:
            enabled: false
            region: <S3Bucket Region>
            bucket: <S3Bucket Name>
```

### Dinghy support for delete stale pipelines
Dinghy now support deleting stale pipelines - Any pipelines in the Spinnaker application that are not part of the `dinghyfile`.

These pipelines are identified and deleted automatically when the `dinghyfile` is updated and processed. You can set 
the `deleteStalePipelines` flag to `true` in the `dinghyfile` to enable this feature.

```json
{
  "application": "yourspinnakerapplicationname",
  "deleteStalePipelines": true,
  "pipelines": [
  ]
}
```

###  Spinnaker community contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.34.3](https://www.spinnaker.io/changelogs/1.34.3-changelog/) changelog for details.

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
    commit: 94c77a6b398a40993e6fba92e5692393d8f22564
    version: 2.34.0
  deck:
    commit: 63cd2960432f7921cecefc634bc5b187473832fe
    version: 2.34.0
  dinghy:
    commit: fbba492fb3d6c116d75f9ca959f6b5d84ab473a6
    version: 2.34.0
  echo:
    commit: 23909434bf95a0891a5ab256e5fccf5d7d8b6ed3
    version: 2.34.0
  fiat:
    commit: e8be593635189433704d0a7945fa1335c24ac896
    version: 2.34.0
  front50:
    commit: cce826e7cc2203970da4ebd37ccd9a91d9b39790
    version: 2.34.0
  gate:
    commit: 313be459112c23139adf1ef2717a850cc7797485
    version: 2.34.0
  igor:
    commit: e327e854cd7487881c15f4005f739b69ca4d7850
    version: 2.34.0
  kayenta:
    commit: 840e7e93fbc83c7704895307fe057b84d14776f2
    version: 2.34.0
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: b52430340a82dd536d4e6d13c5b9b44962452ff2
    version: 2.34.0
  rosco:
    commit: 23db1000615781164ae3042eed3ef8cf298d7da4
    version: 2.34.0
  terraformer:
    commit: 559abc8056e0f1c90d6bc737c57688f7c747c0ba
    version: 2.34.0
timestamp: "2024-07-18 11:24:58"
version: 2.34.0
</code>
</pre>
</details>

### Armory


#### Armory Clouddriver - 2.32.3...2.34.0
- chore(cd): update base service version to clouddriver:2024.06.27.18.12.36.release-1.34.x (#1142)
- chore(cd): update base service version to clouddriver:2024.06.11.19.47.52.release-1.34.x (#1136)
- chore(cd): update base service version to clouddriver:2024.06.11.18.46.36.release-1.34.x (#1135)
- chore(cd): update base service version to clouddriver:2024.06.11.17.42.55.release-1.34.x (#1134)
- chore(cd): update base service version to clouddriver:2024.05.15.14.49.18.release-1.34.x (#1126)
- chore(cd): update base service version to clouddriver:2024.05.07.00.11.46.release-1.34.x (#1122)
- chore(cd): update armory-commons version to 3.16.2 (#1118)
- chore(cd): update base service version to clouddriver:2024.04.29.20.13.35.master (#1115)
- chore(cd): update base service version to clouddriver:2024.04.28.03.54.41.master (#1114)
- chore(cd): update base service version to clouddriver:2024.04.27.02.58.24.master (#1113)
- chore(cd): update base service version to clouddriver:2024.04.27.01.17.51.master (#1112)
- chore(cd): update base service version to clouddriver:2024.04.19.15.06.51.master (#1111)
- chore(cd): update base service version to clouddriver:2024.04.17.23.18.25.master (#1110)
- chore(cd): update base service version to clouddriver:2024.04.17.22.30.27.master (#1109)
- chore(cd): update base service version to clouddriver:2024.04.17.00.31.11.master (#1108)
- chore(cd): update base service version to clouddriver:2024.04.16.23.02.06.master (#1107)
- chore(cd): update base service version to clouddriver:2024.04.15.21.03.44.master (#1106)
- chore(cd): update base service version to clouddriver:2024.04.15.20.20.47.master (#1105)
- chore(cd): update base service version to clouddriver:2024.04.15.19.37.30.master (#1104)
- chore(cd): update base service version to clouddriver:2024.04.14.20.52.16.master (#1103)
- chore(cd): update base service version to clouddriver:2024.04.10.16.09.12.master (#1102)
- chore(cd): update base service version to clouddriver:2024.04.01.21.11.56.master (#1101)
- Updating Armory commons and gradle jar (#1100)
- chore(cd): update base service version to clouddriver:2024.03.28.00.24.09.master (#1099)
- Upgrading Gradle to match OSS (#1098)
- chore(cd): update base service version to clouddriver:2024.03.21.17.22.01.master (#1097)
- Update clouddriver-package.gradle (#1096)
- chore(build): Updating Dockerfile with base image (#1095)
- chore(cd): update base service version to clouddriver:2024.03.12.21.36.12.master (#1094)
- chore(cd): update base service version to clouddriver:2024.03.12.20.05.36.master (#1093)
- chore(cd): update base service version to clouddriver:2024.03.12.16.58.43.master (#1092)
- chore(cd): update base service version to clouddriver:2024.03.03.18.17.58.master (#1089)
- chore(cd): update base service version to clouddriver:2024.02.29.20.32.42.master (#1087)
- chore(cd): update base service version to clouddriver:2024.02.28.05.46.02.master (#1084)
- chore(cd): update base service version to clouddriver:2024.02.27.06.01.15.master (#1080)
- chore(cd): update base service version to clouddriver:2024.02.27.06.00.03.master (#1079)
- chore(cd): update base service version to clouddriver:2024.02.27.04.32.59.master (#1078)
- chore(cd): update base service version to clouddriver:2024.02.27.04.01.47.master (#1077)
- chore(cd): update base service version to clouddriver:2024.02.27.01.13.36.master (#1076)
- chore(cd): update base service version to clouddriver:2024.02.05.19.55.21.master (#1075)
- chore(cd): update base service version to clouddriver:2024.02.02.20.34.05.master (#1074)
- chore(cd): update base service version to clouddriver:2024.02.02.18.14.52.master (#1073)
- chore(cd): update base service version to clouddriver:2024.02.01.20.44.50.master (#1071)
- chore(cd): update base service version to clouddriver:2024.01.30.17.34.14.master (#1070)
- chore(cd): update base service version to clouddriver:2024.01.25.16.36.56.master (#1069)
- chore(cd): update armory-commons version to 3.15.1 (#1067)
- chore(cd): update base service version to clouddriver:2024.01.23.16.49.59.master (#1065)
- chore(cd): update base service version to clouddriver:2024.01.10.19.37.05.master (#1060)
- chore(cd): update base service version to clouddriver:2024.01.08.22.53.58.master (#1059)
- chore(cd): update base service version to clouddriver:2024.01.08.18.58.47.master (#1058)
- chore(cd): update base service version to clouddriver:2024.01.04.21.23.43.master (#1057)
- chore(cd): update base service version to clouddriver:2024.01.02.19.12.40.master (#1056)
- chore(cd): update base service version to clouddriver:2024.01.01.22.40.29.master (#1055)
- chore(cd): update base service version to clouddriver:2024.01.01.21.46.33.master (#1054)
- chore(cd): update base service version to clouddriver:2023.12.12.10.42.47.master (#1052)
- chore(cd): update base service version to clouddriver:2023.12.08.18.19.18.master (#1051)
- chore(cd): update base service version to clouddriver:2023.12.05.22.20.46.master (#1050)
- chore(cd): update base service version to clouddriver:2023.12.01.23.18.40.master (#1049)
- chore(cd): update base service version to clouddriver:2023.12.01.22.25.17.master (#1048)
- chore(cd): update base service version to clouddriver:2023.12.01.21.32.00.master (#1047)
- chore(cd): update base service version to clouddriver:2023.12.01.17.07.46.master (#1046)
- chore(cd): update base service version to clouddriver:2023.12.01.10.02.06.master (#1045)
- chore(cd): update base service version to clouddriver:2023.11.29.21.04.30.master (#1044)
- chore(cd): update base service version to clouddriver:2023.11.29.16.53.23.master (#1043)
- chore(cd): update base service version to clouddriver:2023.11.28.21.32.22.master (#1042)
- chore(cd): update base service version to clouddriver:2023.11.28.17.55.30.master (#1041)
- chore(cd): update base service version to clouddriver:2023.11.27.16.25.40.master (#1039)
- chore(cd): update base service version to clouddriver:2023.11.22.01.22.04.master (#1035)
- chore(cd): update base service version to clouddriver:2023.11.22.00.37.26.master (#1034)
- chore(cd): update base service version to clouddriver:2023.11.21.21.57.48.master (#1033)
- chore(cd): update base service version to clouddriver:2023.11.20.22.10.09.master (#1032)
- chore(cd): update base service version to clouddriver:2023.11.20.20.59.25.master (#1028)
- chore(cd): update base service version to clouddriver:2023.11.20.18.24.24.master (#1027)
- chore(cd): update base service version to clouddriver:2023.11.17.21.14.48.master (#1026)
- chore(cd): update base service version to clouddriver:2023.11.16.18.01.55.master (#1025)
- chore(cd): update base service version to clouddriver:2023.11.16.17.03.59.master (#1024)
- chore(cd): update base service version to clouddriver:2023.11.14.22.02.04.master (#1023)
- chore(cd): update base service version to clouddriver:2023.11.14.12.10.10.master (#1022)
- chore(cd): update base service version to clouddriver:2023.11.13.19.38.37.master (#1021)
- chore(cd): update base service version to clouddriver:2023.11.13.18.40.37.master (#1020)
- chore(cd): update base service version to clouddriver:2023.11.13.16.27.25.master (#1019)
- chore(cd): update base service version to clouddriver:2023.11.10.20.28.35.master (#1018)
- chore(cd): update base service version to clouddriver:2023.11.10.17.31.13.master (#1017)
- chore(cd): update base service version to clouddriver:2023.11.08.15.10.17.master (#1015)
- chore(cd): update base service version to clouddriver:2023.11.02.20.26.25.master (#1014)
- chore(cd): update base service version to clouddriver:2023.11.01.10.42.41.master (#1013)
- chore(cd): update base service version to clouddriver:2023.11.01.05.43.07.master (#1012)
- chore(cd): update base service version to clouddriver:2023.10.30.04.36.21.master (#1011)
- chore(cd): update base service version to clouddriver:2023.10.20.18.33.36.master (#1010)
- chore(cd): update base service version to clouddriver:2023.10.17.23.10.42.master (#1009)
- chore(cd): update base service version to clouddriver:2023.10.11.20.46.03.master (#1008)
- chore(cd): update base service version to clouddriver:2023.10.11.05.59.16.master (#1006)

#### Dinghy™ - 2.32.3...2.34.0
- chore: Bumps and delete support (#533) (#535)
- chore(dependencies): v0.0.0-20240213103436-d0dc889db2c6 (#529)
- chore(dependencies): updated oss dinghy version to v0.0.0-20240213103436-d0dc889db2c6 (#525)
-

#### Terraformer™ - 2.32.3...2.34.0


#### Armory Echo - 2.32.3...2.34.0
- chore(build): Updating Build dependencies (#724)
- chore(cd): update armory-commons version to 3.16.2 (#716)
- chore(cd): update base service version to echo:2024.04.27.02.26.26.master (#712)
- chore(cd): update base service version to echo:2024.04.17.17.22.23.master (#710)
- chore(cd): update base service version to echo:2024.04.16.22.32.13.master (#709)
- chore(cd): update base service version to echo:2024.04.06.04.28.27.master (#708)
- chore(cd): update base service version to echo:2024.04.01.18.07.48.master (#707)
- chore(cd): update base service version to echo:2024.03.29.22.03.53.master (#706)
- chore(armory-commons): Updating Armory commons version (#705)
- chore(cd): update base service version to echo:2024.03.21.16.46.18.master (#704)
- chore(build): Updating Dockerfile with base image  (#703)
- chore(cd): update armory-commons version to 3.15.1 (#675)
- chore(cd): update base service version to echo:2023.11.21.19.54.25.master (#656)
- chore(cd): update base service version to echo:2023.11.20.21.36.20.master (#655)
- chore(cd): update base service version to echo:2023.11.20.17.49.29.master (#654)
- chore(cd): update base service version to echo:2023.11.14.21.27.23.master (#653)
- chore(cd): update base service version to echo:2023.11.13.18.24.24.master (#652)
- chore(cd): update base service version to echo:2023.11.10.19.48.01.master (#651)
- chore(cd): update base service version to echo:2023.11.02.19.51.25.master (#650)
- fix: Upgrade grpc-netty-shaded to address the service initialization failure issue. (#647) (#649)
- chore(cd): update base service version to echo:2023.10.30.00.07.35.master (#646)
- chore(cd): update base service version to echo:2023.10.26.17.17.05.master (#644)
- chore(cd): update base service version to echo:2023.10.20.17.42.30.master (#643)
- chore(cd): update base service version to echo:2023.10.17.22.53.33.master (#642)
- chore(cd): update base service version to echo:2023.10.17.20.02.09.master (#641)
- chore(feat): Support ARM with docker buildx - SAAS-1953 (#637)
- chore(cd): update base service version to echo:2023.10.06.16.03.18.master (#639)
- chore(cd): update base service version to echo:2023.10.04.16.06.56.master (#638)
- chore(cd): update base service version to echo:2023.10.01.16.50.11.master (#635)
- chore(cd): update base service version to echo:2023.10.01.16.41.14.master (#634)
- chore(cd): update base service version to echo:2023.10.01.16.33.03.master (#633)
- chore(cd): update base service version to echo:2023.10.01.16.24.40.master (#632)
- chore(cd): update base service version to echo:2023.10.01.16.16.00.master (#631)


#### Armory Deck - 2.32.3...2.34.0
- chore(cd): update base deck version to 2024.0.0-20240610151915.release-1.34.x (#1420)
- chore(cd): update base deck version to 2024.0.0-20240513181436.release-1.34.x (#1417)
- chore(cd): update base deck version to 2024.0.0-20240510163512.release-1.34.x (#1413)
- chore(cd): update base deck version to 2024.0.0-20240509180831.release-1.34.x (#1410)
- chore(cd): update base deck version to 2024.0.0-20240507163358.release-1.34.x (#1407)
- chore(cd): update base deck version to 2024.0.0-20240425133611.master (#1402)
- chore(cd): update base deck version to 2024.0.0-20240425080204.master (#1401)
- chore(cd): update base deck version to 2024.0.0-20240416204716.master (#1399)
- chore(cd): update base deck version to 2024.0.0-20240416085052.master (#1398)
- chore(cd): update base deck version to 2024.0.0-20240415191135.master (#1397)
- chore(cd): update base deck version to 2024.0.0-20240401180625.master (#1396)
- chore(cd): update base deck version to 2024.0.0-20240201174104.master (#1393)
- chore(cd): update base deck version to 2024.0.0-20240201154858.master (#1392)
- build(action): pass version to fix build (#1390)
- chore(cd): update base deck version to 2024.0.0-20240117174813.master (#1384)
- chore(cd): update base deck version to 2024.0.0-20240101195346.master (#1383)
- chore(cd): update base deck version to 2023.0.0-20231222191848.master (#1382)
- chore(cd): update base deck version to 2023.0.0-20231207192034.master (#1381)
- chore(cd): update base deck version to 2023.0.0-20231207095504.master (#1378)
- chore(cd): update base deck version to 2023.0.0-20231201183254.master (#1377)
- chore(cd): update base deck version to 2023.0.0-20231201180115.master (#1375)
- chore(cd): update base deck version to 2023.0.0-20231201100402.master (#1374)
- chore(cd): update base deck version to 2023.0.0-20231130182135.master (#1373)
- chore(cd): update base deck version to 2023.0.0-20231130162716.master (#1372)
- chore(cd): update base deck version to 2023.0.0-20231130121012.master (#1371)
- chore(cd): update base deck version to 2023.0.0-20231116193005.master (#1368)
- chore(cd): update base deck version to 2023.0.0-20231114100915.master (#1367)
- chore(cd): update base deck version to 2023.0.0-20231110022032.master (#1366)
- chore(cd): update base deck version to 2023.0.0-20231101175540.master (#1365)
- chore(cd): update base deck version to 2023.0.0-20231024132143.master (#1362)
- chore(cd): update base deck version to 2023.0.0-20231016213838.master (#1358)
- fix(action): upgrade node version to match OSS (#1356)

#### Armory Rosco - 2.32.3...2.34.0
- Revert "Fix permissions on container (#675)" (#676)
- Fix permissions on container (#675)
- chore(build): Updating Build dependencies (#671) (#672)
- chore(cd): update base service version to rosco:2024.04.18.17.06.07.release-1.34.x (#666)
- chore(cd): update armory-commons version to 3.16.2 (#664)
- chore(cd): update base service version to rosco:2024.04.18.16.53.13.master (#659)
- chore(cd): update base service version to rosco:2024.04.06.04.30.30.master (#658)
- chore(cd): update base service version to rosco:2024.04.01.17.13.30.master (#657)
- chore(cd): update base service version to rosco:2024.03.26.04.36.13.master (#656)
- chore(build): Updating Dockerfile with base image (#653)
- chore(cd): update base service version to rosco:2024.02.23.17.50.10.master (#642)
- chore(cd): update base service version to rosco:2024.02.21.18.12.33.master (#640)
- chore(cd): update base service version to rosco:2024.02.20.07.03.39.master (#639)
- chore(cd): update base service version to rosco:2024.02.09.15.36.10.master (#637)
- chore(cd): update base service version to rosco:2024.02.07.19.18.48.master (#636)
- chore(cd): update base service version to rosco:2024.02.05.05.09.50.master (#635)
- chore(cd): update base service version to rosco:2024.02.05.04.14.03.master (#634)
- fix(ci): Removing integration tests as not stable (#627)
- chore(cd): update base service version to rosco:2023.11.14.21.27.05.master (#601)
- chore(cd): update base service version to rosco:2023.11.13.18.24.40.master (#600)
- chore(cd): update base service version to rosco:2023.11.10.19.53.01.master (#599)
- fix(cve): Fixing CVE-2023-24538 CVE-2023-24540 (#596)
- chore(cd): update base service version to rosco:2023.11.02.19.54.28.master (#595)
- chore(cd): update base service version to rosco:2023.10.30.03.05.30.master (#594)
- chore(feat): Support ARM with docker buildx - SAAS-1953 (#584)
- chore(cd): update base service version to rosco:2023.10.09.14.38.32.master (#586)

#### Armory Kayenta - 2.32.3...2.34.0
- chore(cd): update base service version to kayenta:2024.06.14.19.10.09.release-1.34.x (#543)
- chore(build): Updating Build dependencies (#544) (#545)
- chore(cd): update base service version to kayenta:2024.04.01.18.08.38.master (#530)
- chore(cd): update base service version to kayenta:2024.03.20.14.47.07.master (#528)
- chore(build): Updating Dockerfile with base image  (#527)
- chore(cd): update base service version to kayenta:2024.02.20.06.20.45.master (#520)
- chore(cd): update base service version to kayenta:2024.02.06.18.05.30.master (#519)
- chore(cd): update base service version to kayenta:2024.02.05.19.15.22.master (#518)
- chore(cd): update base service version to kayenta:2024.02.01.16.30.14.master (#515)
- chore(cd): update armory-commons version to 3.15.1 (#511)
- chore(cd): update base service version to kayenta:2024.01.12.16.21.50.master (#506)
- chore(cd): update base service version to kayenta:2024.01.10.18.51.11.master (#505)
- chore(cd): update base service version to kayenta:2024.01.01.19.52.30.master (#504)
- chore(cd): update base service version to kayenta:2023.12.05.22.25.32.master (#500)
- chore(cd): update base service version to kayenta:2023.12.01.16.29.19.master (#497)
- chore(cd): update base service version to kayenta:2023.12.01.16.20.40.master (#496)
- chore(cd): update base service version to kayenta:2023.12.01.09.56.52.master (#494)
- chore(cd): update base service version to kayenta:2023.11.22.03.11.43.master (#493)

#### Armory Gate - 2.32.3...2.34.0
- chore(cd): update base service version to gate:2024.04.17.02.19.43.release-1.34.x (#734)
- chore(build): Updating Build dependencies (#732) (#733)
- chore(cd): update armory-commons version to 3.16.2 (#721)
- Updating Armory commons and gradle jar (#714)
- chore(build): Updating Dockerfile with base image (#710)
- Fixing header plugin reference (#684)
- Removing Instance registration from Gate (#677)
- chore(cd): update armory-commons version to 3.15.1 (#674)
- chore(cd): update base service version to gate:2023.11.21.19.56.21.master (#654)
- chore(cd): update base service version to gate:2023.11.20.21.38.07.master (#653)
- chore(cd): update base service version to gate:2023.11.15.18.44.06.master (#652)
- chore(cd): update base service version to gate:2023.11.14.21.32.23.master (#651)
- chore(cd): update base service version to gate:2023.11.13.18.53.08.master (#650)
- chore(cd): update base service version to gate:2023.11.13.18.31.24.master (#649)
- chore(cd): update base service version to gate:2023.11.10.19.54.05.master (#648)
- chore(cd): update base service version to gate:2023.11.06.16.41.58.master (#647)
- chore(cd): update base service version to gate:2023.11.02.19.56.35.master (#646)
- chore(cd): update base service version to gate:2023.10.30.00.10.25.master (#645)
- chore(cd): update base service version to gate:2023.10.20.17.45.11.master (#644)
- chore(cd): update base service version to gate:2023.10.17.22.55.10.master (#643)
- chore(cd): update base service version to gate:2023.10.17.20.06.22.master (#642)
- chore(feat): Support ARM with docker buildx - SAAS-1953 (#640)
- chore(cd): update base service version to gate:2023.10.04.14.06.55.master (#639)
- chore(cd): update base service version to gate:2023.10.02.10.18.38.master (#637)
- chore(cd): update base service version to gate:2023.10.02.10.06.07.master (#636)
- chore(cd): update base service version to gate:2023.10.02.09.54.57.master (#635)
- chore(cd): update base service version to gate:2023.10.02.09.44.13.master (#634)
- chore(cd): update base service version to gate:2023.10.02.09.29.18.master (#633)

#### Armory Igor - 2.32.3...2.34.0
- chore(build): Updating Build dependencies (#613) (#614)
- chore(cd): update armory-commons version to 3.16.2 (#606)
- chore(cd): update base service version to igor:2024.04.27.02.25.13.master (#602)
- chore(cd): update base service version to igor:2024.04.16.22.31.21.master (#600)
- chore(cd): update base service version to igor:2024.04.06.04.28.03.master (#599)
- chore(cd): update base service version to igor:2024.04.01.04.34.59.master (#598)
- Updating gradle jar (#597)
- chore(cd): update base service version to igor:2024.03.26.21.17.26.master (#596)
- Preparing Jenkins ChangeSet/Cause to be contributed to OSS (#595)
- chore(cd): update base service version to igor:2024.03.23.00.21.14.master (#594)
- chore(cd): update base service version to igor:2024.03.21.20.18.57.master (#593)
- chore(cd): update base service version to igor:2024.03.21.20.03.53.master (#592)
- chore(cd): update base service version to igor:2024.03.21.16.45.24.master (#591)
- chore(cd): update base service version to igor:2024.03.12.20.07.19.master (#588)
- chore(build): Updating Dockerfile with base image (#590)
- chore(cd): update base service version to igor:2024.02.26.18.28.26.master (#576)
- chore(cd): update base service version to igor:2024.02.22.17.19.30.master (#574)
- chore(cd): update base service version to igor:2024.02.19.20.17.04.master (#572)
- chore(cd): update base service version to igor:2024.02.07.19.47.17.master (#571)
- chore(cd): update base service version to igor:2024.02.05.04.13.32.master (#570)
- chore(cd): update base service version to igor:2024.02.02.19.02.47.master (#569)
- chore: OS Updates (#516)
- chore(cd): update base service version to igor:2024.01.28.17.58.42.master (#563)
- chore(cd): update armory-commons version to 3.15.1 (#560)
- chore(cd): update base service version to igor:2024.01.05.23.42.17.master (#553)
- chore(cd): update base service version to igor:2024.01.04.20.38.26.master (#552)
- chore(cd): update base service version to igor:2024.01.02.18.59.20.master (#551)
- chore(cd): update base service version to igor:2024.01.01.19.47.05.master (#550)
- chore(cd): update base service version to igor:2023.12.22.16.57.46.master (#549)
- chore(cd): update base service version to igor:2023.12.20.18.00.11.master (#547)
- chore(cd): update base service version to igor:2023.12.20.17.19.58.master (#546)
- chore(cd): update base service version to igor:2023.12.20.17.03.29.master (#545)
- chore(cd): update base service version to igor:2023.12.12.09.59.13.master (#544)
- chore(cd): update base service version to igor:2023.12.05.21.36.31.master (#543)
- chore(cd): update base service version to igor:2023.12.01.10.13.33.master (#542)
- chore(cd): update base service version to igor:2023.12.01.09.55.03.master (#541)
- chore(cd): update base service version to igor:2023.11.28.17.22.52.master (#540)
- chore(cd): update base service version to igor:2023.11.22.00.04.55.master (#538)
- chore(feat): Support ARM with docker buildx - SAAS-1953 (#524)
- chore(cd): update base service version to igor:2023.10.04.14.08.12.master (#523)
- chore(cd): update base service version to igor:2023.10.01.17.22.32.master (#521)
- chore(cd): update base service version to igor:2023.10.01.17.09.34.master (#520)
- chore(cd): update base service version to igor:2023.10.01.16.59.10.master (#519)
- chore(cd): update base service version to igor:2023.10.01.16.48.40.master (#518)
- chore(cd): update base service version to igor:2023.10.01.16.39.00.master (#517)

#### Armory Front50 - 2.32.3...2.34.0
- chore(build): Updating Build dependencies (#697) (#698)
- chore(cd): update base service version to front50:2024.06.18.14.36.38.release-1.34.x (#696)
- chore(cd): update armory-commons version to 3.16.2 (#685)
- chore(cd): update base service version to front50:2024.04.29.15.39.38.master (#682)
- chore(cd): update base service version to front50:2024.04.28.03.20.59.master (#681)
- chore(cd): update base service version to front50:2024.04.27.00.45.16.master (#680)
- chore(cd): update base service version to front50:2024.04.19.02.36.56.master (#679)
- chore(cd): update base service version to front50:2024.04.16.22.32.00.master (#678)
- chore(cd): update base service version to front50:2024.04.07.23.11.07.master (#677)
- chore(cd): update base service version to front50:2024.04.06.04.27.40.master (#676)
- chore(cd): update base service version to front50:2024.04.04.17.04.27.master (#675)
- chore(cd): update base service version to front50:2024.04.03.15.42.24.master (#674)
- chore(cd): update base service version to front50:2024.04.01.18.07.35.master (#673)
- Updating Armory commons and gradle jar (#672)
- chore(cd): update base service version to front50:2024.03.21.16.45.10.master (#671)
- chore(build): Updating Dockerfile with base image (#670)
- chore(cd): update base service version to front50:2024.03.12.17.35.53.master (#669)
- chore(cd): update base service version to front50:2024.03.12.16.24.08.master (#668)
- Updating force dependency on com.google.cloud:google-cloud-storage:1.108.0 (#663)
- chore(cd): update base service version to front50:2024.03.03.17.42.35.master (#661)
- chore(cd): update base service version to front50:2024.02.27.05.27.41.master (#656)
- chore(cd): update base service version to front50:2024.02.22.17.18.49.master (#654)
- chore(cd): update base service version to front50:2024.02.20.17.53.04.master (#653)
- chore(cd): update base service version to front50:2024.02.08.08.30.49.master (#651)
- chore(cd): update base service version to front50:2024.02.05.04.13.13.master (#650)
- chore(cd): update base service version to front50:2024.02.02.19.02.51.master (#649)
- chore(cd): update base service version to front50:2024.02.01.16.11.56.master (#646)
- chore(cd): update armory-commons version to 3.15.1 (#643)
- chore: Front50 OS upgrade (#604)
- chore(cd): update base service version to front50:2024.01.05.23.42.35.master (#638)
- chore(cd): update base service version to front50:2024.01.04.20.38.03.master (#637)
- chore(cd): update base service version to front50:2024.01.02.18.59.32.master (#636)
- chore(cd): update base service version to front50:2024.01.01.19.49.07.master (#635)
- chore(cd): update base service version to front50:2023.12.23.17.39.44.master (#634)
- chore(cd): update base service version to front50:2023.12.12.09.59.08.master (#632)
- chore(cd): update base service version to front50:2023.12.05.21.35.59.master (#631)
- chore(cd): update base service version to front50:2023.12.01.16.41.08.master (#630)
- chore(cd): update base service version to front50:2023.12.01.09.58.07.master (#629)
- chore(cd): update base service version to front50:2023.11.28.17.22.41.master (#628)
- chore(cd): update base service version to front50:2023.11.22.00.53.22.master (#627)
- chore(cd): update base service version to front50:2023.11.22.00.05.06.master (#626)
- chore(cd): update base service version to front50:2023.11.20.21.37.41.master (#624)
- chore(cd): update base service version to front50:2023.11.20.17.51.21.master (#623)
- chore(cd): update base service version to front50:2023.11.14.21.29.17.master (#622)
- chore(cd): update base service version to front50:2023.11.13.18.26.35.master (#621)
- chore(cd): update base service version to front50:2023.11.10.21.06.29.master (#620)
- chore(cd): update base service version to front50:2023.11.10.19.56.12.master (#619)
- chore(cd): update base service version to front50:2023.11.02.19.58.46.master (#618)
- chore(cd): update base service version to front50:2023.10.30.00.11.22.master (#617)
- chore(cd): update base service version to front50:2023.10.20.17.47.46.master (#616)
- chore(cd): update base service version to front50:2023.10.17.22.54.47.master (#615)
- chore(cd): update base service version to front50:2023.10.17.20.07.46.master (#614)


#### Armory Fiat - 2.32.3...2.34.0
- chore(build): Updating Build dependencies (#614)
- chore(cd): update armory-commons version to 3.16.2 (#606)
- chore(cd): update base service version to fiat:2024.04.27.01.37.20.master (#602)
- chore(cd): update base service version to fiat:2024.04.06.04.25.40.master (#600)
- fix(build): Updating vault addr for gradle build (#597)
- chore(cd): update base service version to fiat:2024.04.01.17.07.04.master (#596)
- Updating gradle jar (#595)
- chore(cd): update base service version to fiat:2024.03.21.16.43.41.master (#594)
- chore(build): Updating Dockerfile with base image (#593)
- Fixing Integration tests (#588)
- chore(cd): update base service version to fiat:2024.02.07.19.26.24.master (#578)
- chore(cd): update base service version to fiat:2024.02.05.04.12.57.master (#577)
- chore(cd): update base service version to fiat:2024.02.02.19.01.47.master (#576)
- chore(cd): update base service version to fiat:2024.02.01.17.05.49.master (#574)
- chore(cd): update armory-commons version to 3.15.1 (#570)
- chore(cd): update base service version to fiat:2024.01.05.23.41.30.master (#566)
- chore(cd): update base service version to fiat:2024.01.04.20.37.33.master (#565)
- chore(cd): update base service version to fiat:2024.01.02.18.58.32.master (#564)
- chore(cd): update base service version to fiat:2024.01.01.19.51.44.master (#563)
- chore(cd): update base service version to fiat:2023.12.22.15.44.41.master (#562)
- chore(cd): update base service version to fiat:2023.12.05.21.35.14.master (#561)
- chore(cd): update base service version to fiat:2023.12.01.16.26.11.master (#560)
- chore(cd): update base service version to fiat:2023.12.01.16.18.32.master (#559)
- chore(cd): update base service version to fiat:2023.12.01.16.09.54.master (#558)
- chore(cd): update base service version to fiat:2023.12.01.09.56.22.master (#557)
- chore(cd): update base service version to fiat:2023.11.28.18.18.48.master (#556)
- chore(cd): update base service version to fiat:2023.11.28.17.19.21.master (#555)
- chore(cd): update base service version to fiat:2023.11.22.00.53.43.master (#554)

#### Armory Orca - 2.32.3...2.34.0

- chore(cd): update base orca version to 2024.07.17.09.05.39.release-1.34.x (#924)
- chore(build): Updating Build dependencies (#911)
- chore(cd): update base orca version to 2024.06.12.02.19.43.release-1.34.x (#899)
- chore(cd): update base orca version to 2024.06.11.23.58.30.release-1.34.x (#898)
- chore(cd): update base orca version to 2024.06.11.17.07.47.release-1.34.x (#896)
- chore(cd): update base orca version to 2024.05.09.17.57.44.release-1.34.x (#888)
- chore(cd): update armory-commons version to 3.16.2 (#883)
- chore(cd): update base orca version to 2024.04.29.19.19.52.master (#880)
- chore(cd): update base orca version to 2024.04.29.16.29.08.master (#879)
- chore(cd): update base orca version to 2024.04.27.02.30.03.master (#877)
- chore(cd): update base orca version to 2024.04.25.13.50.22.master (#875)
- chore(cd): update base orca version to 2024.04.24.18.43.23.master (#874)
- chore(cd): update base orca version to 2024.04.19.15.05.09.master (#873)
- chore(cd): update base orca version to 2024.04.18.16.22.33.master (#872)
- chore(cd): update base orca version to 2024.04.17.17.21.57.master (#871)
- chore(cd): update base orca version to 2024.04.16.22.34.47.master (#870)
- chore(cd): update base orca version to 2024.04.16.21.38.54.master (#869)
- chore(cd): update base orca version to 2024.04.16.13.59.24.master (#868)
- chore(cd): update base orca version to 2024.04.15.20.08.34.master (#866)
- chore(cd): update base orca version to 2024.04.15.04.26.46.master (#864)
- Fixing docker task after gradle upgrade (#863)
- chore(cd): update base orca version to 2024.04.06.04.32.03.master (#861)
- chore(cd): update base orca version to 2024.04.01.18.07.02.master (#859)
- Updating Armory commons and gradle jar (#858)
- chore(cd): update base orca version to 2024.03.28.16.27.46.master (#857)
- chore(cd): update base orca version to 2024.03.22.17.37.27.master (#854)
- chore(cd): update base orca version to 2024.03.21.16.50.28.master (#853)
- chore(build): Updating Dockerfile with base image (#851)
- chore(cd): update base orca version to 2024.02.23.19.06.04.master (#828)
- chore(cd): update base orca version to 2024.02.23.01.17.40.master (#827)
- chore(cd): update base orca version to 2024.02.23.00.50.00.master (#826)
- chore(cd): update base orca version to 2024.02.22.17.55.18.master (#825)
- chore(cd): update base orca version to 2024.02.22.16.05.46.master (#824)
- Changing to a Spinnaker known type (#821)
- chore(cd): update base orca version to 2024.02.07.21.28.21.master (#820)
- chore(cd): update base orca version to 2024.02.05.21.07.46.master (#819)
- chore(cd): update base orca version to 2024.02.05.04.19.15.master (#818)
- chore(cd): update base orca version to 2024.02.02.19.08.07.master (#817)
- chore(cd): update base orca version to 2024.02.01.18.07.15.master (#814)
- chore(cd): update base orca version to 2024.02.01.16.25.27.master (#813)
- chore(cd): update base orca version to 2024.02.01.16.11.06.master (#812)
- chore(cd): update base orca version to 2024.01.31.18.02.11.master (#811)
- fix(teraformer): Fixing NPE on artifact binding for Terraformer (#809)
- chore(cd): update base orca version to 2024.01.29.15.51.20.master (#807)
- chore(cd): update armory-commons version to 3.15.1 (#804)
- chore(cd): update base orca version to 2024.01.10.17.10.48.master (#800)
- chore(cd): update base orca version to 2024.01.08.17.32.19.master (#799)
- chore(cd): update base orca version to 2024.01.05.23.47.32.master (#798)
- chore(cd): update base orca version to 2024.01.04.20.44.00.master (#797)
- chore(cd): update base orca version to 2024.01.03.22.08.01.master (#796)
- chore(cd): update base orca version to 2024.01.02.19.05.35.master (#795)
- chore(cd): update base orca version to 2024.01.01.19.48.39.master (#794)
- chore(cd): update base orca version to 2023.12.23.17.53.55.master (#793)
- chore(cd): update base orca version to 2023.12.22.16.59.22.master (#792)
- fix(liquibase): upgraded armory-commons to upgrade liquibase (#790)
- chore(cd): update base orca version to 2023.12.12.10.03.50.master (#789)
- chore(cd): update base orca version to 2023.12.07.19.22.03.master (#788)
- chore(cd): update base orca version to 2023.12.05.21.41.46.master (#787)
- chore(cd): update base orca version to 2023.12.01.16.48.30.master (#786)
- chore(cd): update base orca version to 2023.12.01.15.06.58.master (#785)
- chore(cd): update base orca version to 2023.12.01.09.05.34.master (#784)
- chore(cd): update base orca version to 2023.11.28.17.29.13.master (#783)
- chore(cd): update base orca version to 2023.11.24.14.27.38.master (#782)
- chore(cd): update base orca version to 2023.11.22.16.05.23.master (#781)
- chore(cd): update base orca version to 2023.11.22.00.54.46.master (#780)
- chore(cd): update base orca version to 2023.11.22.00.08.19.master (#779)
- chore(cd): update base orca version to 2023.11.21.22.12.18.master (#778)
- chore(cd): update base orca version to 2023.11.20.22.16.16.master (#775)
- chore(cd): update base orca version to 2023.11.20.19.10.04.master (#774)
- chore(cd): update base orca version to 2023.11.17.17.47.00.master (#773)
- chore(cd): update base orca version to 2023.11.17.16.37.53.master (#772)
- chore(cd): update base orca version to 2023.11.17.16.26.04.master (#771)
- chore(cd): update base orca version to 2023.11.17.16.13.17.master (#770)
- chore(cd): update base orca version to 2023.11.14.21.32.18.master (#769)
- chore(cd): update base orca version to 2023.11.13.18.29.48.master (#768)
- chore(cd): update base orca version to 2023.11.10.19.59.54.master (#767)
- chore(cd): update base orca version to 2023.11.06.18.06.14.master (#761)
- chore(cd): update base orca version to 2023.11.05.19.30.38.master (#760)
- chore(cd): update base orca version to 2023.11.03.16.37.40.master (#759)
- chore(cd): update base orca version to 2023.11.02.20.02.41.master (#758)
- chore(cd): update base orca version to 2023.10.30.21.33.51.master (#757)
- chore(cd): update base orca version to 2023.10.30.17.58.20.master (#756)
- chore(cd): update base orca version to 2023.10.30.03.06.33.master (#755)
- chore(cd): update base orca version to 2023.10.27.14.36.30.master (#754)
- chore(cd): update base orca version to 2023.10.20.17.53.21.master (#753)
- chore(cd): update base orca version to 2023.10.17.22.57.08.master (#749)
- chore(cd): update base orca version to 2023.10.17.20.09.56.master (#748)

### Spinnaker
- Release notes for OSS Spinnaker [1.33.0](https://spinnaker.io/changelogs/1.33.0-changelog)
- Release notes for OSS Spinnaker [1.34.0](https://spinnaker.io/changelogs/1.34.0-changelog)

#### Spinnaker Clouddriver - 1.34.3


#### Spinnaker Echo - 1.34.3


#### Spinnaker Deck - 1.34.3


#### Spinnaker Rosco - 1.34.3


#### Spinnaker Kayenta - 1.34.3


#### Spinnaker Gate - 1.34.3


#### Spinnaker Igor - 1.34.3


#### Spinnaker Front50 - 1.34.3


#### Spinnaker Fiat - 1.34.3


#### Spinnaker Orca - 1.34.3

  - fix(sqlExecutionRepo): Return compressed columns when enabled for retrieve pipelines with configId (backport #4765) (#4766)

