---
title: v2.40.14 Armory Continuous Deployment Release (Spinnaker™ 2026.2.5)
toc_hide: true
version: 02.40.14
date: 2026-11-19
description: >
  Release notes for Armory Continuous Deployment v2.40.14.
---

<!--
MAKE SURE TO ADD 'LTS' OR 'FEATURE' TO THE TITLE TO INDICATE RELEASE CATEGORY.
FOR EXAMPLE, "Armory Continuous Deployment Release LTS" or "Armory Continuous Deployment Release Feature" so users know release category and support time period
-->

## 2026/11/19 release notes

>Note: If you experience production issues after upgrading Armory Continuous Deployment, roll back to a previous working version and report issues to [http://go.armory.io/support](http://go.armory.io/support).

{{% alert color="success" title="Changes since 2.40.13" %}}
These are the only changes in this release.

**Changes**

- Deck: you can now configure the options in the "Show N executions per pipeline" dropdown. Set `window.spinnakerSettings.executionCountOptions` to an array of numbers (for example, `[5, 10, 25, 100]`) in `settings-local.js`. If the setting is unset or empty, Deck keeps the default options (1, 2, 5, 10, 20, 30, 40, 50, 100, 200).
- Security: the base images are updated to address CVE-2026-114938.
{{% /alert %}}

## Required Armory Operator version
{{% alert color="warning" title="Important" %}}
[Armory Operator]({{< ref "armory-operator" >}}) has been deprecated and will is considered EOL. Please migrate to the [Kustomize]({{< ref "armory-operator-to-kustomize-migration" >}}) method of deployment.
{{% /alert %}}

To install, upgrade, or configure Armory CD 2.40.14, use Armory Operator 1.8.6 or later.

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

**Base image updates for CVEs**

- The base images are updated to address CVE-2026-114938.

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


### UI

#### Configurable pipeline execution count options

Open source Deck hardcodes the options in the "Show N executions per pipeline" dropdown. Armory Deck now reads them from `executionCountOptions` in `settings-local.js`:

```js
window.spinnakerSettings.executionCountOptions = [5, 10, 25, 100];
```

If the setting is unset or empty, Deck uses the default options (1, 2, 5, 10, 20, 30, 40, 50, 100, 200).

###  Spinnaker community contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.40.0](https://www.spinnaker.io/changelogs/1.40.0-changelog/) changelog for details.

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
    commit: 08c2dfae0ac29ccbe9c89cf85b1da064f8f62ca1
    version: 2.40.14
  deck:
    commit: 08c2dfae0ac29ccbe9c89cf85b1da064f8f62ca1
    version: 2.40.14
  dinghy:
    commit: 08c2dfae0ac29ccbe9c89cf85b1da064f8f62ca1
    version: 2.40.14
  echo:
    commit: 08c2dfae0ac29ccbe9c89cf85b1da064f8f62ca1
    version: 2.40.14
  fiat:
    commit: 08c2dfae0ac29ccbe9c89cf85b1da064f8f62ca1
    version: 2.40.14
  front50:
    commit: 08c2dfae0ac29ccbe9c89cf85b1da064f8f62ca1
    version: 2.40.14
  gate:
    commit: 08c2dfae0ac29ccbe9c89cf85b1da064f8f62ca1
    version: 2.40.14
  igor:
    commit: 08c2dfae0ac29ccbe9c89cf85b1da064f8f62ca1
    version: 2.40.14
  kayenta:
    commit: 08c2dfae0ac29ccbe9c89cf85b1da064f8f62ca1
    version: 2.40.14
  monitoring-daemon:
    commit: null
    version: 2.26.0
  monitoring-third-party:
    commit: null
    version: 2.26.0
  orca:
    commit: 08c2dfae0ac29ccbe9c89cf85b1da064f8f62ca1
    version: 2.40.14
  rosco:
    commit: 08c2dfae0ac29ccbe9c89cf85b1da064f8f62ca1
    version: 2.40.14
  terraformer:
    commit: 08c2dfae0ac29ccbe9c89cf85b1da064f8f62ca1
    version: 2.40.14
timestamp: "2026-11-19 14:59:12"
version: 2.40.14
</code>
</pre>
</details>

### Armory


#### Armory Clouddriver - 2.40.13...2.40.14


#### Armory Deck - 2.40.13...2.40.14


#### Armory Rosco - 2.40.13...2.40.14


#### Armory Terraformer - 2.40.13...2.40.14


#### Armory Kayenta - 2.40.13...2.40.14


#### Armory Orca - 2.40.13...2.40.14


#### Armory Gate - 2.40.13...2.40.14


#### Armory Igor - 2.40.13...2.40.14


#### Armory Fiat - 2.40.13...2.40.14


#### Armory Front50 - 2.40.13...2.40.14


#### Armory Dinghy - 2.40.13...2.40.14


#### Armory Echo - 2.40.13...2.40.14



### Spinnaker


#### Spinnaker Clouddriver - 1.40.0


#### Spinnaker Deck - 1.40.0


#### Spinnaker Rosco - 1.40.0


#### Spinnaker Terraformer - 1.40.0


#### Spinnaker Kayenta - 1.40.0


#### Spinnaker Orca - 1.40.0


#### Spinnaker Gate - 1.40.0


#### Spinnaker Igor - 1.40.0


#### Spinnaker Fiat - 1.40.0


#### Spinnaker Front50 - 1.40.0


#### Spinnaker Dinghy - 1.40.0


#### Spinnaker Echo - 1.40.0


