---
title: v2.27.0 Armory Enterprise Release (Spinnaker™ v1.27.0)
toc_hide: true
version: 02.27.00
description: >
  Release notes for Armory Enterprise v2.27.0 Beta. A beta release is not meant for installation in production environments.
---

## 2021/09/30 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Disclaimer

{{< include "lts-beta.md" >}}

## Required Operator version

To install, upgrade, or configure Armory 2.27.0, use the following Operator version:

* Armory Operator 1.4.0 or later

For information about upgrading, Operator, see [Upgrade the Operator]({{< ref "op-manage-operator#upgrade-the-operator" >}}). Using Halyard to install version 2.27.0 or later is not suported. For more information, see [Halyard Deprecation]({{< ref "halyard-deprecation" >}}).

## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, see the [Support Portal](https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010414). Note that you must be logged in to the portal to see the information.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

{{< include "breaking-changes/bc-dinghy-slack.md" >}}

{{< include "breaking-changes/bc-java-tls-mysql.md" >}}

{{< include "breaking-changes/bc-k8s-version-pre1-16.md" >}}

{{< include "breaking-changes/bc-k8s-infra-buttons.md" >}}

#### Halyard deprecation

Halyard is no longer supported for installing Armory Enterprise 2.27.0 and later. Use the Operator. For more information, see [Halyard Deprecation]({{< ref "halyard-deprecation" >}}).

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

{{< include "known-issues/ki-bake-var-file.md" >}}
{{< include "known-issues/ki-artifact-binding-spel.md" >}}
{{< include "known-issues/ki-dinghy-gh-notifications.md" >}}

#### NullPointerException in Clouddriver

The following NPE occurs in the Clouddriver service:

```
Error creating bean with name 'kubesvcCredentialsLoader': Invocation of init method failed; nested exception is java.lang.NullPointerException
```

To resolve the issue, set the following property to `false` in your Operator manifest: `spec.spinnakerConfig.profiles.clouddriver.armory.cloud.enabled`.


## Highlighted updates

### Armory Agent for Kubernetes

Armory Enterprise 2.27.0 requires an updated version of the Agent Clouddriver Plugin. The minimum plugin version required is `v0.10.0`.

### Deployment targets

#### AWS Lambda

> Note that these updates also require v1.0.8 of the AWS Lambda plugin.

- Fixed an issue in the UI where a stack trace gets displayed when you try to view functions. <!--BOB-30359-->
- Fixed an issue where the UI did not show functions for an application when there are no configured clusters. Functions now appear instead of a 404 error. <!--BOB-30260-->
- Caching behavior and performance have been improved. The changes include fixes for the following issues:
  - The Lambda API returns request conflicts (HTTP status 409).
  - Event Source Mapping of ARNs fails after initially succeeding. This occured during the Lambda Event Configuration Task.
  - Underscores (_) in environment variable names caused validation errors.
  - An exception related to event configs occurred intermittently during the Lambda Event Configuration Task.
  - Lambda function creation using the Deploy Lambda stage failed causing subsequent runs of the pipeline to encounter an error that states the function already exists.
  - The Lambda Cache Refresh Task did not refresh the cache. This led to issues where downstream tasks referenced older versions.
  - A permission issue  caused the Infrastructure view in the UI (Deck) to not display Lambda functions.

#### Cloud Foundry

- An Unbind Service Stage has been added to the Cloud Foundry provider. Services must be unbound before they can be deleted. Use this stage prior to a Destroy Service stage. Alternatively, you can unbind all services before they are deleted in the Destroy Service stage by selecting the checkbox in the stage to do this. <!--PIT-98 BOB-30233-->
- Improved error handling when a Deploy Service stage fails <!--BOB-30273-->
- The Cloud Foundry provider now supports the following manifest attributes:
  - Processes Health
  - Timeout
  - Random route

#### General improvements

The Clouddriver service is now more resilient when starting. Previously, the service failed to start if an account that gets added has permission errors. <!-- BOB-30131-->

###  Environment registration

When you log in to the UI, you will be prompted to register your environment. When you register an environment, Armory provides you with a client ID and client secret that you add to your Operator manifest.

Registration is required for certain features to work.

Note that registration does not automatically turn on Armory Diagnostics. This means that registration does not send information about your apps and pipelines to Armory. If you are sending diagnostic information to Armory, registering your deployment ensures that Armory can know which logs are yours, improving Armory's ability to provide support.

For more information, see [Environment Registration]({{< ref "ae-instance-reg" >}}).



## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.27.0
timestamp: "2021-09-29 20:37:22"
services:
    clouddriver:
        commit: bb36d57f5d79748a5983d069042228b71cbdd85d
        version: 2.27.0
    deck:
        commit: 8912ef4f4a4f171384497b787aee0e83847ffd5c
        version: 2.27.0
    dinghy:
        commit: 71f2ed003fe6b75d8e4f43e800725f2ff3a8a1fe
        version: 2.27.0
    echo:
        commit: 5ec4a67ff921c2bdefc776dda03a0780ff853bcf
        version: 2.27.0
    fiat:
        commit: f8c8d79e98205675c20bf87c38ca649bf77bf794
        version: 2.27.0
    front50:
        commit: 99e2f8a099d6485f2399235c5c55ee97f856faac
        version: 2.27.0
    gate:
        commit: 9d3414eb703125b86025db79f12f360f4b722153
        version: 2.27.0
    igor:
        commit: 9f4db42f060f6fb45aad4c038525d71528a2f9f5
        version: 2.27.0
    kayenta:
        commit: 20e287e64c98b4dcd19acd9e6fbb00e28cc49561
        version: 2.27.0
    monitoring-daemon:
        version: 2.26.0
    monitoring-third-party:
        version: 2.26.0
    orca:
        commit: 658d6de1e212cbf30181dd30e86283bccf481004
        version: 2.27.0
    rosco:
        commit: ff3b0cc47cca46f764c81ef2dee9456ad1b48b8f
        version: 2.27.0
    terraformer:
        commit: 23fad54614db0040074a0176066eefae38e9dc4a
        version: 2.27.0
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Echo - 2.26.11...2.27.0

  - [create-pull-request] automated change (#331)
  - [create-pull-request] automated change (#337)
  - chore(cd): add GitHub actions for new release process (#341)
  - [create-pull-request] automated change (#342)
  - chore(cd): update base service version to echo:2021.06.01.18.51.36.master (#344)
  - chore(cd): update base service version to echo:2021.06.25.19.58.23.master (#347)
  - chore(cd): update base service version to echo:2021.07.27.04.46.54.master (#353)
  - chore(cd): update base service version to echo:2021.07.28.17.53.43.master (#354)
  - chore(cd): update base service version to echo:2021.07.28.18.54.59.master (#355)
  - chore(cd): update base service version to echo:2021.07.30.21.02.30.master (#356)
  - chore(cd): update base service version to echo:2021.08.03.20.43.30.master (#357)
  - chore(cd): update base service version to echo:2021.08.04.20.13.00.master (#358)
  - fix(build): remove redhat publishing (#363)
  - chore(build): remove platform build (#367)
  - [create-pull-request] automated change (#351) (#371)

#### Armory Deck - 2.26.10...2.27.0

  - chore(deps): sync 1.26.3 (#783)
  - feat(build): auto-merge OSS settings.js with armory settings (#785)
  - feat(build): oss-package-synchronizer accepts a target commit (#786)
  - chore(core): disable pipeline tags feature until it's considered stable (#788)
  - feat(build): simple function for adding new armory feature flag (#787)
  - feat(build): github actions for deck CD (#792)
  - chore(cd): update base deck version to 2021.0.0-20210527174655.master (#793)
  - chore(cd): update base deck version to 2021.0.0-20210528160633.master (#794)
  - chore(cd): update base deck version to 2021.0.0-20210528233327.master (#795)
  - chore(cd): update base deck version to 2021.0.0-20210531223647.master (#796)
  - chore(cd): update base deck version to 2021.0.0-20210531230855.master (#797)
  - chore(cd): update base deck version to 2021.0.0-20210601012537.master (#798)
  - chore(cd): update base deck version to 2021.0.0-20210601021451.master (#799)
  - chore(cd): update base deck version to 2021.0.0-20210601163547.master (#800)
  - chore(cd): update base deck version to 2021.0.0-20210601171037.master (#802)
  - chore(cd): update base deck version to 2021.0.0-20210601213056.master (#803)
  - chore(cd): update base deck version to 2021.0.0-20210601231217.master (#804)
  - chore(cd): update base deck version to 2021.0.0-20210601233230.master (#805)
  - chore(cd): update base deck version to 2021.0.0-20210602035620.master (#806)
  - chore(cd): update base deck version to 2021.0.0-20210602160342.master (#807)
  - chore(cd): update base deck version to 2021.0.0-20210602194515.master (#808)
  - chore(cd): update base deck version to 2021.0.0-20210602234732.master (#809)
  - chore(cd): update base deck version to 2021.0.0-20210603000433.master (#810)
  - chore(cd): update base deck version to 2021.0.0-20210603050341.master (#811)
  - chore(cd): update base deck version to 2021.0.0-20210603204359.master (#812)
  - chore(cd): update base deck version to 2021.0.0-20210603212155.master (#813)
  - chore(cd): update base deck version to 2021.0.0-20210603223319.master (#815)
  - chore(cd): update base deck version to 2021.0.0-20210604014609.master (#816)
  - chore(cd): update base deck version to 2021.0.0-20210604024713.master (#817)
  - chore(cd): update base deck version to 2021.0.0-20210604033542.master (#818)
  - chore(cd): update base deck version to 2021.0.0-20210604125911.master (#820)
  - chore(cd): update base deck version to 2021.0.0-20210604162806.master (#821)
  - chore(cd): update base deck version to 2021.0.0-20210604182550.master (#822)
  - chore(cd): update base deck version to 2021.0.0-20210604211019.master (#825)
  - chore(cd): update base deck version to 2021.0.0-20210604235005.master (#826)
  - chore(cd): update base deck version to 2021.0.0-20210605012054.master (#827)
  - chore(cd): update base deck version to 2021.0.0-20210605190703.master (#828)
  - chore(cd): update base deck version to 2021.0.0-20210606000206.master (#829)
  - chore(cd): update base deck version to 2021.0.0-20210607184256.master (#830)
  - chore(cd): update base deck version to 2021.0.0-20210607190125.master (#831)
  - chore(cd): update base deck version to 2021.0.0-20210607203141.master (#833)
  - chore(cd): update base deck version to 2021.0.0-20210607221106.master (#834)
  - chore(cd): update base deck version to 2021.0.0-20210607233041.master (#835)
  - chore(cd): update base deck version to 2021.0.0-20210608015324.master (#836)
  - chore(build): add action for building artifacts in expected format fo… (#824)
  - chore(cd): update base deck version to 2021.0.0-20210608205622.master (#837)
  - chore(cd): update base deck version to 2021.0.0-20210608205622.master (#838)
  - chore(cd): update base deck version to 2021.0.0-20210608205622.master (#839)
  - chore(cd): update base deck version to 2021.0.0-20210608205622.master (#840)
  - chore(cd): update base deck version to 2021.0.0-20210609005214.master (#841)
  - chore(cd): update base deck version to 2021.0.0-20210609011324.master (#842)
  - chore(cd): update base deck version to 2021.0.0-20210609013525.master (#843)
  - chore(cd): update base deck version to 2021.0.0-20210609054300.master (#846)
  - chore(cd): update base deck version to 2021.0.0-20210609164424.master (#848)
  - chore(cd): update base deck version to 2021.0.0-20210609183352.master (#849)
  - chore(cd): update base deck version to 2021.0.0-20210610035158.master (#850)
  - chore(cd): update base deck version to 2021.0.0-20210610161940.master (#851)
  - chore(cd): update base deck version to 2021.0.0-20210610161940.master (#852)
  - chore(cd): update base deck version to 2021.0.0-20210610180857.master (#853)
  - chore(cd): update base deck version to 2021.0.0-20210610193205.master (#854)
  - chore(cd): update base deck version to 2021.0.0-20210610200231.master (#855)
  - chore(cd): update base deck version to 2021.0.0-20210610205949.master (#857)
  - chore(cd): update base deck version to 2021.0.0-20210610231608.master (#858)
  - chore(cd): update base deck version to 2021.0.0-20210610234543.master (#860)
  - chore(cd): update base deck version to 2021.0.0-20210611010230.master (#862)
  - chore(cd): update base deck version to 2021.0.0-20210611010230.master (#861)
  - chore(cd): update base deck version to 2021.0.0-20210611010230.master (#863)
  - chore(cd): update base deck version to 2021.0.0-20210611010230.master (#864)
  - chore(cd): update base deck version to 2021.0.0-20210611010230.master (#865)
  - chore(cd): update base deck version to 2021.0.0-20210611012226.master (#872)
  - chore(cd): update base deck version to 2021.0.0-20210611170127.master (#873)
  - chore(cd): update base deck version to 2021.0.0-20210611170127.master (#874)
  - chore(cd): update base deck version to 2021.0.0-20210611170127.master (#875)
  - chore(cd): update base deck version to 2021.0.0-20210611170127.master (#876)
  - chore(cd): update base deck version to 2021.0.0-20210611170127.master (#877)
  - chore(cd): update base deck version to 2021.0.0-20210611170127.master (#878)
  - chore(cd): update base deck version to 2021.0.0-20210611170127.master (#879)
  - chore(cd): update base deck version to 2021.0.0-20210611172441.master (#880)
  - chore(cd): update base deck version to 2021.0.0-20210611172441.master (#886)
  - chore(cd): update base deck version to 2021.0.0-20210611172441.master (#885)
  - chore(cd): update base deck version to 2021.0.0-20210611172441.master (#884)
  - chore(cd): update base deck version to 2021.0.0-20210611172441.master (#883)
  - chore(cd): update base deck version to 2021.0.0-20210611172441.master (#882)
  - chore(cd): update base deck version to 2021.0.0-20210611172441.master (#881)
  - chore(cd): update base deck version to 2021.0.0-20210611172441.master (#887)
  - chore(cd): update base deck version to 2021.0.0-20210611172441.master (#888)
  - chore(cd): update base deck version to 2021.0.0-20210611212624.master (#889)
  - chore(cd): update base deck version to 2021.0.0-20210611212624.master (#890)
  - chore(cd): update base deck version to 2021.0.0-20210611212624.master (#891)
  - chore(cd): update base deck version to 2021.0.0-20210611212624.master (#892)
  - chore(cd): update base deck version to 2021.0.0-20210611212624.master (#893)
  - chore(cd): update base deck version to 2021.0.0-20210611212624.master (#894)
  - chore(cd): update base deck version to 2021.0.0-20210611214141.master (#897)
  - chore(cd): update base deck version to 2021.0.0-20210611214141.master (#899)
  - chore(cd): update base deck version to 2021.0.0-20210611214141.master (#898)
  - chore(cd): update base deck version to 2021.0.0-20210611224900.master (#916)
  - chore(cd): update base deck version to 2021.0.0-20210611224900.master (#917)
  - chore(cd): update base deck version to 2021.0.0-20210611224900.master (#918)
  - chore(cd): update base deck version to 2021.0.0-20210611224900.master (#919)
  - chore(cd): update base deck version to 2021.0.0-20210611224900.master (#921)
  - chore(cd): update base deck version to 2021.0.0-20210611224900.master (#920)
  - chore(cd): update base deck version to 2021.0.0-20210614195956.master (#923)
  - chore(cd): update base deck version to 2021.0.0-20210615024356.master (#926)
  - chore(cd): update base deck version to 2021.0.0-20210615024356.master (#928)
  - chore(cd): update base deck version to 2021.0.0-20210615024356.master (#927)
  - chore(cd): update base deck version to 2021.0.0-20210615024356.master (#930)
  - chore(cd): update base deck version to 2021.0.0-20210615024356.master (#931)
  - chore(cd): update base deck version to 2021.0.0-20210615171447.master (#941)
  - chore(cd): update base deck version to 2021.0.0-20210615171447.master (#942)
  - chore(cd): update base deck version to 2021.0.0-20210615171447.master (#944)
  - chore(cd): update base deck version to 2021.0.0-20210615171447.master (#943)
  - chore(cd): update base deck version to 2021.0.0-20210615171447.master (#945)
  - chore(cd): update base deck version to 2021.0.0-20210615171447.master (#946)
  - chore(cd): update base deck version to 2021.0.0-20210615171447.master (#947)
  - chore(cd): update base deck version to 2021.0.0-20210615171447.master (#948)
  - chore(cd): update base deck version to 2021.0.0-20210615171447.master (#949)
  - chore(cd): update base deck version to 2021.0.0-20210615185113.master (#950)
  - chore(cd): update base deck version to 2021.0.0-20210615185113.master (#951)
  - chore(cd): update base deck version to 2021.0.0-20210615185113.master (#952)
  - chore(cd): update base deck version to 2021.0.0-20210615185113.master (#953)
  - chore(cd): update base deck version to 2021.0.0-20210615185113.master (#954)
  - chore(cd): update base deck version to 2021.0.0-20210615185113.master (#955)
  - chore(cd): update base deck version to 2021.0.0-20210615185113.master (#956)
  - chore(cd): update base deck version to 2021.0.0-20210615212730.master (#957)
  - chore(cd): update base deck version to 2021.0.0-20210615212730.master (#958)
  - chore(cd): update base deck version to 2021.0.0-20210615212730.master (#959)
  - chore(cd): update base deck version to 2021.0.0-20210615212730.master (#961)
  - chore(cd): update base deck version to 2021.0.0-20210615212730.master (#960)
  - chore(cd): update base deck version to 2021.0.0-20210615212730.master (#962)
  - chore(cd): update base deck version to 2021.0.0-20210615212730.master (#963)
  - chore(cd): update base deck version to 2021.0.0-20210615221357.master (#964)
  - chore(cd): update base deck version to 2021.0.0-20210615221357.master (#965)
  - chore(cd): update base deck version to 2021.0.0-20210615221357.master (#967)
  - chore(cd): update base deck version to 2021.0.0-20210615221357.master (#966)
  - chore(cd): update base deck version to 2021.0.0-20210615221357.master (#968)
  - chore(cd): update base deck version to 2021.0.0-20210615221357.master (#969)
  - chore(cd): update base deck version to 2021.0.0-20210615221357.master (#970)
  - chore(cd): update base deck version to 2021.0.0-20210615221357.master (#971)
  - chore(cd): update base deck version to 2021.0.0-20210615221357.master (#972)
  - chore(cd): update base deck version to 2021.0.0-20210622113441.master (#1005)
  - chore(cd): update base deck version to 2021.0.0-20210623120859.master (#1007)
  - chore(cd): update base deck version to 2021.0.0-20210622113441.master (#1006)
  - chore(astrolabe): manual retrigger astrolabe (#1008)
  - chore(cd): update base deck version to 2021.0.0-20210623203040.master (#1009)
  - chore(cd): update base deck version to 2021.0.0-20210624174125.master (#1010)
  - fix(oss-sync): update path for settings.js (#1011)
  - chore(cd): update base deck version to 2021.0.0-20210628211343.master (#1012)
  - chore(cd): update base deck version to 2021.0.0-20210630194004.master (#1013)
  - chore(cd): update base deck version to 2021.0.0-20210630221034.master (#1015)
  - chore(cd): update base deck version to 2021.0.0-20210701004408.master (#1017)
  - chore(cd): update base deck version to 2021.0.0-20210701041113.master (#1018)
  - chore(cd): update base deck version to 2021.0.0-20210701052357.master (#1019)
  - chore(cd): update base deck version to 2021.0.0-20210701060337.master (#1020)
  - chore(cd): update base deck version to 2021.0.0-20210701180553.master (#1022)
  - chore(cd): update base deck version to 2021.0.0-20210701185703.master (#1024)
  - chore(cd): update base deck version to 2021.0.0-20210701192057.master (#1025)
  - chore(cd): update base deck version to 2021.0.0-20210702073818.master (#1027)
  - chore(cd): update base deck version to 2021.0.0-20210702080610.master (#1028)
  - chore(cd): update base deck version to 2021.0.0-20210702205937.master (#1029)
  - chore(cd): update base deck version to 2021.0.0-20210702205937.master (#1030)
  - chore(cd): update base deck version to 2021.0.0-20210703053712.master (#1032)
  - chore(cd): update base deck version to 2021.0.0-20210706163736.master (#1033)
  - chore(cd): update base deck version to 2021.0.0-20210706170848.master (#1034)
  - chore(cd): update base deck version to 2021.0.0-20210706231658.master (#1035)
  - chore(cd): update base deck version to 2021.0.0-20210707194926.master (#1037)
  - chore(cd): update base deck version to 2021.0.0-20210707230417.master (#1038)
  - fix(build): fix build  (#1048)
  - chore(cd): update base deck version to 2021.0.0-20210715221518.master (#1049)
  - chore(cd): update base deck version to 2021.0.0-20210715230300.master (#1050)
  - chore(cd): update base deck version to 2021.0.0-20210716185820.master (#1051)
  - chore(cd): update base deck version to 2021.0.0-20210716192405.master (#1052)
  - chore(cd): update base deck version to 2021.0.0-20210716202156.master (#1054)
  - chore(cd): update base deck version to 2021.0.0-20210716233025.master (#1055)
  - chore(cd): update base deck version to 2021.0.0-20210717001336.master (#1057)
  - chore(cd): update base deck version to 2021.0.0-20210717004717.master (#1059)
  - chore(cd): update base deck version to 2021.0.0-20210717201030.master (#1061)
  - chore(cd): update base deck version to 2021.0.0-20210717204003.master (#1062)
  - chore(cd): update base deck version to 2021.0.0-20210717212426.master (#1064)
  - chore(cd): update base deck version to 2021.0.0-20210718013530.master (#1066)
  - chore(cd): update base deck version to 2021.0.0-20210718175310.master (#1067)
  - chore(cd): update base deck version to 2021.0.0-20210719130655.master (#1068)
  - chore(cd): update base deck version to 2021.0.0-20210719194216.master (#1069)
  - chore(cd): update base deck version to 2021.0.0-20210719195603.master (#1070)
  - chore(cd): update base deck version to 2021.0.0-20210719205037.master (#1071)
  - chore(cd): update base deck version to 2021.0.0-20210719221057.master (#1072)
  - fix(build): fix build issue when loading settings.js (#1084)
  - feat(ArmoryHeader): Moves ArmoryHeader to a plugin (#1078)
  - chore(cd): update base deck version to 2021.0.0-20210728184707.master (#1086)
  - Revert "feat(ArmoryHeader): Moves ArmoryHeader to a plugin (#1078)" (#1085)
  - chore(cd): update base deck version to 2021.0.0-20210728202652.master (#1087)
  - chore(cd): update base deck version to 2021.0.0-20210728211232.master (#1088)
  - chore(cd): update base deck version to 2021.0.0-20210802234339.master (#1090)
  - chore(cd): update base deck version to 2021.0.0-20210803214002.master (#1091)
  - chore(cd): update base deck version to 2021.0.0-20210804173152.master (#1092)
  - feat(ArmoryHeader): ES-757 Moves ArmoryHeader to a plugin (#1089) (#1098)
  - fix(build): remove redhat publishing (#1108)
  - chore(build): remove platform build (#1115)
  - chore(cd): update base deck version to 2021.0.0-20210922221618.release-1.27.x (#1117)
  - chore(cd): update base deck version to 2021.0.0-20210927173853.release-1.27.x (#1121)
  - chore(build): bump presentation package (backport #1122) (#1123)

#### Terraformer™ - 2.26.13...2.27.0

  - chore(versions): update tf installer to use new hashi keys (#396)
  - feat(cd): add workflow for building cd images (#407)
  - chore(tests): retrieve secrets from s3, not vault (#418)
  - task(tf_versions): update tf bundled versions script to use new key-server (#417)
  - feat(tf): New TF versions support (#412)
  - task(tf_versions): update dockerfile with new keyserver (#421)
  - Revert "task(tf_versions): update dockerfile with new keyserver (#421)" (#427)
  - task(tf_versions): update tf bundled versions script to use new key (#428)
  - feat(tf): Add support for newer TF versions (#432) (#435)
  - chore(build): remove platform build (#439)
  - Adding 1.0.6 and 1.0.7 in terrafomer (#441) (#442)
  - rebuild artifacts (#443)

#### Armory Igor - 2.26.11...2.27.0

  - fix(dependencies): update armory-commons (#221)
  - chore(cd): add GitHub actions for new release process (#230)
  - chore(cd): update base service version to igor:2021.06.01.18.52.28.master (#232)
  - chore(cd): update base service version to igor:2021.06.25.19.58.37.master (#234)
  - chore(cd): update base service version to igor:2021.06.29.06.49.30.master (#235)
  - chore(cd): update base service version to igor:2021.07.27.04.45.52.master (#240)
  - chore(cd): update base service version to igor:2021.07.30.21.09.03.master (#241)
  - chore(cd): update base service version to igor:2021.08.03.20.44.01.master (#242)
  - chore(cd): update base service version to igor:2021.08.04.20.12.17.master (#243)
  - chore(cd): update base service version to igor:2021.08.04.22.36.51.master (#244)
  - fix(build): remove redhat publishing (#251)
  - chore(build): remove platform build (#256)
  - chore(build): bump armory-commons 3.9.6 (#260) (#261)

#### Armory Fiat - 2.26.12...2.27.0

  - [create-pull-request] automated change (#211)
  - chore(mergify): use squash commits for gradle.properties automerges (#170)
  - chore(cd): add GitHub actions for new release process (#221)
  - [create-pull-request] automated change (#222)
  - chore(cd): update base service version to fiat:2021.06.01.18.50.11.master (#225)
  - chore(cd): update base service version to fiat:2021.06.25.19.56.43.master (#228)
  - chore(cd): update base service version to fiat:2021.07.28.17.50.54.master (#234)
  - chore(cd): update base service version to fiat:2021.07.28.23.33.10.master (#236)
  - chore(cd): update base service version to fiat:2021.07.30.21.00.09.master (#237)
  - chore(cd): update base service version to fiat:2021.08.03.20.41.28.master (#238)
  - chore(cd): update base service version to fiat:2021.08.04.20.12.31.master (#239)
  - chore(cd): update base service version to fiat:2021.08.04.22.35.43.master (#240)
  - fix(build): remove redhat publishing (#245)
  - chore(cd): update base service version to fiat:2021.09.13.21.09.19.release-1.27.x (#253)
  - chore(build): remove platform build (#250)

#### Armory Gate - 2.26.11...2.27.0

  - [create-pull-request] automated change (#282)
  - chore(build): Autobump armory-commons: 3.9.4 (#289)
  - [create-pull-request] automated change (#294)
  - feat(enable_plank_endpoints): Add routes that allows plank to talk to… (#286)
  - chore(cd): add GitHub actions for new release process (#293)
  - chore(build): mergify should squash, not merge (#297)
  - chore(cd): update base service version to gate:2021.06.02.13.31.43.master (#296)
  - chore(cd): update base service version to gate:2021.06.10.17.48.16.master (#299)
  - chore(cd): update base service version to gate:2021.06.25.19.58.32.master (#301)
  - chore(cd): update base service version to gate:2021.07.28.17.58.01.master (#311)
  - chore(cd): update base service version to gate:2021.07.30.21.01.12.master (#313)
  - chore(cd): update base service version to gate:2021.08.03.20.43.25.master (#314)
  - feat(armory): bake in instance registration (#315) (#318)
  - fix(build): remove redhat publishing (#319)
  - chore(build): remove platform build (#325)

#### Armory Front50 - 2.26.13...2.27.0

  - [create-pull-request] automated change (#258)
  - fix(tests): use artifactory to avoid docker rate limits (#261)
  - chore(cd): add GitHub actions for new release process (#270)
  - [create-pull-request] automated change (#266)
  - chore(cd): update base service version to front50:2021.06.01.18.52.03.master (#275)
  - chore(cd): update base service version to front50:2021.06.11.20.02.06.master (#276)
  - chore(cd): update base service version to front50:2021.06.24.14.23.33.master (#278)
  - chore(cd): update base service version to front50:2021.06.24.18.04.21.master (#279)
  - chore(cd): update base service version to front50:2021.06.25.19.56.35.master (#280)
  - chore(policy-engine): delete policy engine extension (#281)
  - chore(cd): update base service version to front50:2021.07.02.16.21.55.master (#288)
  - chore(test): re-enable gha integration tests (#289)
  - chore(cd): update base service version to front50:2021.07.09.15.29.35.master (#291)
  - chore(cd): update base service version to front50:2021.07.16.20.56.46.master (#292)
  - chore(cd): update base service version to front50:2021.07.20.15.00.46.master (#293)
  - chore(cd): update base service version to front50:2021.07.20.21.00.54.master (#294)
  - chore(cd): update base service version to front50:2021.07.23.20.43.49.master (#295)
  - chore(cd): update base service version to front50:2021.07.27.03.46.54.master (#296)
  - chore(cd): update base service version to front50:2021.07.30.21.01.22.master (#297)
  - chore(cd): update base service version to front50:2021.08.03.20.42.06.master (#298)
  - chore(cd): update base service version to front50:2021.08.04.16.34.29.master (#299)
  - fix(build): remove redhat publishing (#303)
  - [create-pull-request] automated change (#285) (#315)
  - chore(cd): update base service version to front50:2021.09.29.20.16.57.release-1.27.x (#317)

#### Armory Orca - 2.26.17...2.27.0

  - [create-pull-request] automated change (#301)
  - chore(cd): handle release branch builds and updates (#305)
  - chore(cd): update base orca version to 2021.05.10.04.33.58.master (#310)
  - chore(cd): fetch full github history on build (#308)
  - chore(cd): update base orca version to 2021.05.12.19.53.00.master (#311)
  - chore(cd): update base orca version to 2021.05.13.04.51.55.master (#312)
  - chore(cd): update base orca version to 2021.05.13.15.14.35.master (#313)
  - chore(cd): update base orca version to 2021.05.14.21.16.52.master (#316)
  - chore(cd): update base orca version to 2021.05.19.18.05.35.master (#320)
  - chore(cd): update base orca version to 2021.05.21.16.40.44.master (#321)
  - chore(cd): update base orca version to 2021.05.25.13.17.14.master (#322)
  - [create-pull-request] automated change (#317)
  - [create-pull-request] automated change (#323)
  - chore(cd): update base orca version to 2021.06.08.23.43.43.master (#328)
  - chore(cd): update base orca version to 2021.06.25.20.08.27.master (#330)
  - chore(cd): update base orca version to 2021.06.28.20.31.46.master (#331)
  - chore(cd): update base orca version to 2021.07.06.16.43.42.master (#337)
  - chore(cd): update base orca version to 2021.07.07.21.31.05.master (#338)
  - chore(cd): update base orca version to 2021.07.12.19.27.07.master (#339)
  - chore(cd): update base orca version to 2021.07.12.21.19.37.master (#340)
  - chore(cd): update base orca version to 2021.07.21.18.29.12.master (#341)
  - chore(cd): update base orca version to 2021.07.28.02.01.51.master (#345)
  - chore(cd): update base orca version to 2021.07.30.21.57.07.master (#346)
  - chore(cd): update base orca version to 2021.08.03.20.49.52.master (#347)
  - chore(cd): update base orca version to 2021.08.04.20.42.51.master (#348)
  - chore(cd): update base orca version to 2021.08.04.22.43.31.master (#349)
  - chore(cd): update base orca version to 2021.08.17.09.13.42.release-1.27.x (#353)
  - chore(cd): update base orca version to 2021.08.17.09.13.42.release-1.27.x (#353) (#356)
  - chore(build): remove platform build (#363)

#### Armory Clouddriver - 2.26.20...2.27.0

  - [create-pull-request] automated change (#329)
  - [create-pull-request] automated change (#336)
  - chore(cd): add GitHub actions for new release process (#341)
  - [create-pull-request] automated change (#342)
  - chore(cd): update base service version to clouddriver:2021.06.10.18.53.43.master (#345)
  - chore(cd): update base service version to clouddriver:2021.06.15.15.29.33.master (#346)
  - chore(cd): update base service version to clouddriver:2021.06.18.15.27.15.master (#347)
  - fix(anthoscli): re-enables Anthos CLI (#335)
  - chore(cd): update base service version to clouddriver:2021.06.23.20.26.19.master (#349)
  - chore(cd): update base service version to clouddriver:2021.06.24.00.25.39.master (#350)
  - chore(cd): update base service version to clouddriver:2021.06.24.16.26.56.master (#351)
  - chore(cd): update base service version to clouddriver:2021.06.24.20.51.41.master (#352)
  - chore(cd): update base service version to clouddriver:2021.06.25.00.13.45.master (#353)
  - chore(cd): update base service version to clouddriver:2021.06.25.20.05.10.master (#354)
  - chore(cd): update base service version to clouddriver:2021.06.25.20.22.11.master (#355)
  - chore(cd): update base service version to clouddriver:2021.06.25.22.32.09.master (#356)
  - chore(cd): update base service version to clouddriver:2021.06.29.00.33.28.master (#357)
  - chore(cd): update base service version to clouddriver:2021.06.29.07.15.45.master (#358)
  - chore(policy-engine): delete policy engine extension (#359)
  - chore(cd): update base service version to clouddriver:2021.07.02.17.27.14.master (#365)
  - chore(cd): update base service version to clouddriver:2021.07.02.17.47.07.master (#366)
  - [create-pull-request] automated change (#364)
  - chore(cd): update base service version to clouddriver:2021.07.07.17.21.04.master (#368)
  - chore(cd): update base service version to clouddriver:2021.07.07.21.49.04.master (#370)
  - chore(cd): update base service version to clouddriver:2021.07.09.17.49.05.master (#371)
  - chore(cd): update base service version to clouddriver:2021.07.12.22.17.59.master (#372)
  - chore(cd): update base service version to clouddriver:2021.07.15.16.45.35.master (#373)
  - chore(cd): update base service version to clouddriver:2021.07.19.20.29.24.master (#375)
  - chore(cd): update base service version to clouddriver:2021.07.19.23.59.16.master (#376)
  - chore(cd): update base service version to clouddriver:2021.07.21.02.06.12.master (#377)
  - chore(cd): update base service version to clouddriver:2021.07.22.19.45.47.master (#378)
  - chore(cd): update base service version to clouddriver:2021.07.22.22.52.30.master (#379)
  - chore(cd): update base service version to clouddriver:2021.07.26.14.18.33.master (#380)
  - chore(cd): update base service version to clouddriver:2021.08.02.17.18.43.master (#385)
  - chore(cd): update base service version to clouddriver:2021.08.03.20.50.53.master (#386)
  - chore(cd): update base service version to clouddriver:2021.08.04.20.25.32.master (#387)
  - chore(cd): update base service version to clouddriver:2021.08.04.22.46.02.master (#388)
  - fix(build): remove redhat publishing (#404)
  - chore(cd): update base service version to clouddriver:2021.09.09.15.14.45.release-1.27.x (#427)
  - chore(build): remove platform build (#425)
  - chore(cd): update base service version to clouddriver:2021.09.09.20.20.09.release-1.27.x (#428)
  - chore(cd): update base service version to clouddriver:2021.09.09.20.49.04.release-1.27.x (#429)
  - chore(cd): update base service version to clouddriver:2021.09.09.21.51.17.release-1.27.x (#431)
  - chore(cd): update base service version to clouddriver:2021.09.09.23.19.36.release-1.27.x (#434)
  - chore(cd): update base service version to clouddriver:2021.09.10.07.54.18.release-1.27.x (#435)
  - chore(cd): update base service version to clouddriver:2021.09.10.19.12.54.release-1.27.x (#436)
  - chore(cd): update base service version to clouddriver:2021.09.10.19.30.00.release-1.27.x (#437)
  - chore(cd): update base service version to clouddriver:2021.09.17.17.07.24.release-1.27.x (#444)
  - chore(cd): update base service version to clouddriver:2021.09.17.18.53.51.release-1.27.x (#446)

#### Armory Rosco - 2.26.15...2.27.0

  - [create-pull-request] automated change (#249)
  - chore(docker): update rosco baking utilities to match OSS (#253)
  - fix(timezone): set timezone for tzdata (#259)
  - [create-pull-request] automated change (#262)
  - [create-pull-request] automated change (#268)
  - Disable legacy integration tests (#270)
  - chore(cd): add GitHub actions for new release process (#266)
  - chore(cd): update base service version to rosco:2021.06.01.18.50.05.master (#274)
  - chore(cd): update base service version to rosco:2021.06.25.19.56.51.master (#282)
  - chore(gha): re-enable integration tests (#287)
  - chore(cd): update base service version to rosco:2021.07.21.01.47.58.master (#291)
  - chore(cd): update base service version to rosco:2021.07.21.22.21.44.master (#292)
  - chore(cd): update base service version to rosco:2021.07.30.20.59.55.master (#293)
  - chore(cd): update base service version to rosco:2021.08.03.20.41.14.master (#294)

#### Armory Kayenta - 2.26.12...2.27.0

  - [create-pull-request] automated change (#248)
  - feat(cloudwatch): add assume role feat and cleanup dependencies (#233)
  - chore(cd): add GitHub actions for new release process (#258)
  - [create-pull-request] automated change (#259)
  - chore(cd): update base service version to kayenta:2021.05.21.22.22.05.master (#262)
  - chore(cd): update base service version to kayenta:2021.06.25.20.02.40.master (#264)
  - chore(cd): update base service version to kayenta:2021.07.21.22.27.06.master (#271)
  - chore(cd): update base service version to kayenta:2021.08.04.20.19.22.master (#272)
  - fix(build): remove redhat publishing (#274)
  - fix(build): remove redhat publishing (#274) (#276)
  - fix(build): nebula issues (#277)
  - chore(build): remove platform build (#278)

#### Dinghy™ - 2.26.11...2.27.0

  - chore(dependencies): updating oss version (#415)
  - chore(lambda): publish dinghy lambda (#418)
  - fix(infrastructure): create new aws_iam_role for each workspace (#419)
  - fix(build): use correct reference for artifact uploaded to s3 (#420)
  - fix(build): add correct reference (#421)
  - feat(use_gate): Configures the yeti source provider to generate a pla… (#422)
  - fix(PipelineID): bump dinghy oss (#427)
  - fix(local_modules_not_working_in_template_repo): updating internal build to pull in OSS fix BOB-30183 (#429)
  - feat(cd): add workflow for building cd images (#435)
  - fix(parsing_errors_when_using_yaml): upgrade to version of OSS dinghy that includes this fix BOB-30150 (#436)
  - feat(add_dinghyignore): upgrade oss dinghy version (#439)
  - feat(add_flag_for_json_validation): upgrade to latest version of OSS dinghy PUX-405 (#441)
  - fix(notif): honor github endpoint in notifier constructor (#447)
  - fix(ubi): removing ubi publishing (#450) (#452)
  - chore(build): remove platform build (#454)

