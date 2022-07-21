---
title: v2.20.2 Armory Enterprise Release (Spinnaker v1.20.6)
toc_hide: true
date: 2020-07-01
version: 02.20.02
description: Release notes for Armory Enterprise v2.20.2
---

## 2020/07/1 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a previous working version and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Halyard version

Armory 2.20.2 requires Armory-extended Halyard 1.9.4 or later.

## Breaking changes

{{< include "breaking-changes/bc-k8s-namespace.md" >}}

{{< include "breaking-changes/bc-metrics-name.md" >}}

### HTTP sessions for Gate
Armory 2.19.x and higher include an upgrade to the Spring Boot dependency. This requires you to flush all the Gate sessions for your Spinnaker deployment. For more information, see [Flushing Gate Sessions](https://kb.armory.io/admin/flush-gate-sessions/).

### Scheduled removal of Kubernetes V1 provider
The Kubernetes V1 provider will be removed in Spinnaker 1.21 (Armory 2.21). Please see the [RFC](https://github.com/spinnaker/governance/blob/master/rfc/eol_kubernetes_v1.md) for more details.

Breaking change: Kubernetes accounts with an unspecified providerVersion will now default to V2. Update your Halconfig to specify `providerVersion: v1` for any Kubernetes accounts you are currently using with the V1 provider.

## Known Issues

### Dynamic Accounts for Kubernetes

**Fixed in**: 2.21

There is an issue with Dynamic Accounts for Kubernetes where the following issues occur:

* Agents get removed but still run on schedule.
* Force cache refresh times out.
* If you have the clean up agent setup, your data randomly disappears and reappears.  

These issues do not occur immediately, and you may even see modified accounts appear.

### Vault Secrets and Spring Cloud

If you use Vault Secrets in conjunction with Spring Cloud, skip this version and upgrade to 2.20.3.

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

### Security update

We continue to make Spinnaker's security a top priority. Although several CVEs are resolved, the following still exist:

#### Orca

- CVE-2020-13790

This is an embedded dependency in OpenJDK11. A version of OpenJDK11 that addresses
this CVE has only recently been released, and will be fixed in the next release. The risk to services users is low: the CVE deals with processing jpeg images in the Java Runtime Environment, a task our services do not utilize.

The following CVEs have been recently identified and will be addressed in the next released:

- CVE-2020-14155

#### Clouddriver

The following three CVEs still exist in Clouddriver:

- CVE-2020-1747
- CVE-2017-18342
- CVE-2020-13757
- CVE-2016-10745

All of them are embedded dependencies in the Google Cloud SDK. A version of the Google Cloud SDK addressing these CVEs has not been released. The risk to Clouddriver users is low: all three CVEs deal with untrusted input, which Clouddriver does not provide to the Google Cloud SDK. Additionally, users deploying to other cloud providers are not at risk for this vulernability.

The following CVEs also exist for the service:

- CVE-2020-7014 - deals with an Elasticsearch exploit. Clouddriver only makes use of entity tags and does not allow for token generation or authentication.

## Highlighted Updates

### Armory

Summary of changes in the latest release.

###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes and features across all of Spinnaker's other services. See their changes here:  
[Spinnaker v1.20.6](https://www.spinnaker.io/community/releases/versions/1-20-6-changelog)

## Detailed Updates

### Bill of Materials
Here's the bom for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.20.2
timestamp: "2020-07-01 08:17:14"
services:
    clouddriver:
        commit: ac73b373
        version: 2.20.5
    deck:
        commit: 583083ff
        version: 2.20.4
    dinghy:
        commit: f710446c
        version: 2.20.3
    echo:
        commit: 1f1310e0
        version: 2.20.7
    fiat:
        commit: 8d4db29b
        version: 2.20.3
    front50:
        commit: 4ab036ea
        version: 2.20.5
    gate:
        commit: cfd0be04
        version: 2.20.3
    igor:
        commit: 5bd7a32c
        version: 2.20.8
    kayenta:
        commit: 9d6743d9
        version: 2.20.3
    monitoring-daemon:
        version: 2.20.0
    monitoring-third-party:
        version: 2.20.0
    orca:
        commit: eb40808c
        version: 2.20.2
    rosco:
        commit: 9e974c48
        version: 2.20.3
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


#### Armory Orca - 2.20.1...2.20.2

#### Armory Rosco - 2.20.3...2.20.3


#### Armory Echo - 2.20.4...2.20.7

  - fix(dinghy): fix webhook validations headers to lowercase (#181) (#182)
  - fix(bitbucket): fix bitbucket integration with dinghy (#185) (#187)

#### Armory Deck - 2.20.4...2.20.4


#### Armory Gate - 2.20.3...2.20.3


#### Armory Kayenta - 2.20.3...2.20.3


#### Armory Clouddriver - 2.20.4...2.20.5


#### Dinghy™ - 2.20.3...2.20.3


#### Armory Front50 - 2.20.5...2.20.5


#### Armory Igor - 2.20.7...2.20.8


#### Terraformer™ - 2.20.3...2.20.3


#### Armory Fiat - 2.20.3...2.20.3
