---
title: v2.26.2 Armory Release (OSS Spinnaker™ v1.26.6)
toc_hide: true
version: 02.26.02
description: >
  Release notes for Armory Enterprise v2.26.2 
---

## 2021/09/03 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.26.2, use one of the following tools:

- Armory-extended Halyard 1.12 or later
  - 2.26.x is the last minor release that you can use Halyard to install or manage. Future releases require the Armory Operator. For more information, see [Halyard Deprecation]({{< ref "halyard-deprecation" >}}).

- Armory Operator 1.2.6 or later

   For information about upgrading, Operator, see [Upgrade the Operator]({{< ref "op-manage-operator#upgrade-the-operator" >}}).


## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, see the [Support Portal](https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010414). Note that you must be logged in to the portal to see the information.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

{{< include "breaking-changes/bc-java-tls-mysql.md" >}}

{{< include "breaking-changes/bc-k8s-version-pre1-16.md" >}}

{{< include "breaking-changes/bc-k8s-infra-buttons.md" >}}

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

{{< include "known-issues/ki-bake-var-file.md" >}}

## Highlighted updates

<!--
Each item category (such as UI) under here should be an h3 (###). List the following info that service owners should be able to provide:
- Major changes or new features we want to call out for Armory and OSS. Changes should be grouped under end user understandable sections. For example, instead of Deck, use UI. Instead of Fiat, use Permissions.
- Fixes to any known issues from previous versions that we have in release notes. These can all be grouped under a Fixed issues H3.
-->
### Artifacts 

This release includes the following improvements for git-based artifact providers:

* The GitRepo artifact provider now supports token files. Use the `tokenFile:` (Operator) or `--token-file` (Halyard) parameters to specify a token file.
* The GitHub, GitLab, and GitRepo artifact providers now support token files that are dynamically updated. The token file is automatically reloaded when Armory Enterprise makes a request.

### AWS ECS

Resolved an issue where the subnets and server groups were not being cached.

### AWS Lambda 

> These improvements require version 1.0.8 of the AWS Lambda Plugin in addition to Armory Enterprise 2.26.2.

This release includes the following new features and improvements for the Lambda provider:

* Fixed an issue where a [UI bug](https://github.com/spinnaker/spinnaker/issues/6271) related to the caching agent prevented Lambda functions from being displayed in the UI when there are no other clusters associated with the Application.
* Improved cache performance including fixes to cache issues found in 2.24.2
* New configuration properties that give you greater control over how Armory Enterprise behaves when connection or cache issues occur.

Configure the following properties in your Operator manifest (`spinnakerservice.yml` by default). Note that all these properties are optional and use the default if omitted. 

`spec.spinnakerConfig.profiles.orca.spinnaker.`:

- `cloudDriverReadTimeout`: Integer. The timeout (in seconds) when attempting to read from Lambda. (Defaults to 60 seconds.)
- `cloudDriverConnectTimeout`: Integer. The connection timeout (in seconds) when trying to connect to AWS Lambda from Clouddriver. (Defaults to 15 seconds.)
- `cacheRefreshRetryWaitTime`: Integer. The time (in seconds) to wait between retries when attempting to refresh the Lambda cache stored in Clouddriver. (Defaults to 15 seconds.)
- `cacheOnDemandRetryWaitTime`: Integer. The time (in seconds) to wait between retries when attempting to refresh the cache on-demand. (Defaults to 15 seconds.)

For example:

```yaml
# This example only shows the location of the properties. The rest of the manifest is omitted for brevity.
spec:
  spinnakerConfig:
    profiles:
      orca:
        lambdaPluginConfig:
          cloudDriverReadTimeout: 30
          cloudDriverConnectTimeout: 10
          cacheRefreshRetryWaitTime: 10
          CacheOnDemandRetryWaitTime: 10
```

`spec.spinnakerConfig.profiles.clouddriver.aws.lambda.`:

- `retry.timeout`: Integer. The time (in minutes) that Clouddriver will wait before timing out when attempting to connect to the Lambda client. (Defaults to 15 minutes.)
- `concurrency.threads`: Integer. The maximum number of threads to use for calls to the Lambda client. (Defaults to 10 threads.) 

For example:

```yaml
# This example only shows the location of the properties. The rest of the manifest is omitted for brevity.
spec:
  spinnakerConfig:
    profiles:
      clouddriver:
        aws:
          enabled: true
          lambda:
            enabled: true
            retry:              
              timeout: 10  
            concurrency:                   
              threads: 5  
```

### Pipelines as Code

#### Strict JSON Validation

Pipelines as Code (PaC) will now attempt a strict JSON validation of template modules and pipelines to catch certain syntactical errors sooner. This behavior may break existing users that make heavy use of template language constructs. If you find that behavior has changed and need to revert to the previous parsing behavior, add the `jsonValidationDisabled` config to your PaC profile:

```yaml
spec:
  spinnakerConfig:
    profiles:
      dinghy:
        jsonValidationDisabled: true
```

#### Event notifications honor global config

PaC will now honor configurations that define a self-hosted GitHub Enterprise instance when sending GitHub notifications. No configuration change is necessary for this fix to take effect.

### Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.26.6](https://www.spinnaker.io/changelogs/1.26.6-changelog/) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.26.2
timestamp: "2021-09-02 18:30:45"
services:
    clouddriver:
        commit: 942f74be6aa77ebd34f9183437171848e3b9fd35
        version: 2.26.19
    deck:
        commit: a2296787ab03efc53c85d03cbf8eecddedab6094
        version: 2.26.9
    dinghy:
        commit: 0796be13e88a77c72d94d4e0538a4fab152366b8
        version: 2.26.10
    echo:
        commit: b2f76d93f06a0434987fb00daa77a22396c54658
        version: 2.26.10
    fiat:
        commit: 6aba766ef74c6fe186d7f047095a775936bef71f
        version: 2.26.11
    front50:
        commit: 8bdd585434b9bde9834bf580d96fdd42d12dc933
        version: 2.26.12
    gate:
        commit: 1d66c8a302ed4bf7ad07ce3944b7d7e43baae0a0
        version: 2.26.10
    igor:
        commit: 4f76b327913693263e18a670dc8782d77bbc8ee1
        version: 2.26.10
    kayenta:
        commit: 4f668d1297a5d205d516667c1af6902d0d9f380f
        version: 2.26.11
    monitoring-daemon:
        version: 2.26.0
    monitoring-third-party:
        version: 2.26.0
    orca:
        commit: 6b547ff4ac81742d1c4cb7fab713a16f6deefd34
        version: 2.26.16
    rosco:
        commit: 1dfc60f1f70ccdadc2cc03ff9f27b5ca39bb9c39
        version: 2.26.14
    terraformer:
        commit: d20745f6ac1fb87b876dbd255b0b26004fb0341a
        version: 2.26.12
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Fiat - 2.26.10...2.26.11


#### Armory Front50 - 2.26.11...2.26.12

#### Terraformer™ - 2.26.9...2.26.12

#### Armory Clouddriver - 2.26.12...2.26.19

  - chore(cd): update base service version to clouddriver:2021.07.28.19.49.01.release-1.26.x (#381)
  - chore(cd): update base service version to clouddriver:2021.07.28.23.39.00.release-1.26.x (#382)
  - chore(cd): update base service version to clouddriver:2021.07.29.00.03.42.release-1.26.x (#383)
  - chore(cd): update base service version to clouddriver:2021.07.29.00.21.10.release-1.26.x (#384)
  - chore(cd): update base service version to clouddriver:2021.08.17.07.55.22.release-1.26.x (#396)
  - chore(cd): update base service version to clouddriver:2021.08.18.19.46.18.release-1.26.x (#397)

#### Armory Deck - 2.26.7...2.26.9

  - chore(cd): update base deck version to 2021.0.0-20210820171135.release-1.26.x (#1112)

#### Armory Rosco - 2.26.13...2.26.14


#### Armory Igor - 2.26.9...2.26.10


#### Armory Gate - 2.26.9...2.26.10


#### Armory Kayenta - 2.26.10...2.26.11


#### Dinghy™ - 2.26.6...2.26.10

  - fix(notif): honor github endpoint in notifier constructor (backport #447) (#448)
  - fix(build): add dinghy to stackfile (#449)

#### Armory Orca - 2.26.15...2.26.16

  - chore(cd): update base orca version to 2021.08.17.08.55.02.release-1.26.x (#354)

#### Armory Echo - 2.26.9...2.26.10

