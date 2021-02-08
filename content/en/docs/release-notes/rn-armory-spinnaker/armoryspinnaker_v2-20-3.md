---
title: v2.20.3 Armory Release (OSS Spinnaker v1.20.6)
toc_hide: true
date: 2020-07-07
version: 02.20.03
---

## 2020/07/07 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Operator and Halyard version

Armory 2.20.3 requires one of the following:

* Armory-extended Halyard 1.9.4 or later.
* Armory Operator 1.0.2 or later.

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

This issue only occurs if you upgrade to 2.19.x or later and then downgrade to a version earlier than 2.19.x.

**Workaround**

You can resolve this issue by rolling back changes to the MySQL database. For more information, see [MySQL Table Name Change Error When Rolling Back Spinnaker (Undo Renamed Values)](https://kb.armory.io/s/article/SQL-Migration-Rollback-Undo-Renamed-Tables).

### Pipelines as code

- Webhook secret validation is broken in this version. Please skip this version if you use this feature.
- Slack notification when pipelines are updated is broken. Please skip this version if you use this feature.

### Security update

We continue to make Spinnaker's security a top priority. Although several CVEs are resolved, the following still exist:

#### Multiple services

`CVE-2020-5410` was resolved in a previous version of Armory; however, this CVE introduced a regression for users of Spring Cloud and has been rolled back. Armory will continue to monitor releases for a fix.

#### Orca

- CVE-2020-13790

This is an embedded dependency in OpenJDK11. A version of OpenJDK11 that addresses
this CVE has only recently been released. The CVE will be fixed in an upcoming release. The risk to services users is low. The CVE deals with processing `jpeg` images in the Java Runtime Environment, a task Spinnaker services do not perform.

The following CVEs have been recently identified and will be addressed in an upcoming release:

- CVE-2020-14155

#### Clouddriver

The following CVEs still exist in Clouddriver:

- CVE-2020-1747
- CVE-2017-18342
- CVE-2020-13757
- CVE-2016-10745

All of them are embedded dependencies in the Google Cloud SDK. A version of the Google Cloud SDK addressing these CVEs has not been released. The risk to Clouddriver users is low. All four CVEs deal with untrusted input, which Clouddriver does not provide to the Google Cloud SDK. Additionally, users deploying to other cloud providers are not at risk for this vulnerability.

The following CVE also exist for Clouddriver:

- CVE-2020-7014 deals with an Elasticsearch exploit related to token generation. Clouddriver only makes use of entity tags and does not allow for token generation or authentication.

#### Terraformer

Armory has identified and is triaging the following CVEs in Terraformer, the service for the Terraform integration:

- CVE-2020-14422
- CVE-2020-13757

## Highlighted Updates

### Armory

2.20.3 is a security focused release. For details about new features and functionality added to Armory 2.20.x, see the release notes for [Armory 2.20.0]({{< ref armoryspinnaker_v2-20-0 >}}).

###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes and features across all of Spinnaker's other services. See their changes here:  
[Spinnaker v1.20.6](https://www.spinnaker.io/community/releases/versions/1-20-6-changelog)

## Detailed Updates

### Bill of Materials
Here's the bom for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.20.3
timestamp: "2020-07-07 08:05:38"
services:
    clouddriver:
        commit: 43f0eb32
        version: 2.20.6
    deck:
        commit: 583083ff
        version: 2.20.4
    dinghy:
        commit: f710446c
        version: 2.20.3
    echo:
        commit: 47858e3e
        version: 2.20.9
    fiat:
        commit: f4c3cc15
        version: 2.20.4
    front50:
        commit: 66dda373
        version: 2.20.6
    gate:
        commit: 8437e3b7
        version: 2.20.4
    igor:
        commit: 69ca5136
        version: 2.20.9
    kayenta:
        commit: 06ba114e
        version: 2.20.4
    monitoring-daemon:
        version: 2.20.0
    monitoring-third-party:
        version: 2.20.0
    orca:
        commit: 1c66db43
        version: 2.20.3
    rosco:
        commit: 5e3f7e91
        version: 2.20.4
    terraformer:
        commit: f1867f44
        version: 2.20.4
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Gate - 2.20.3...2.20.4


#### Armory Rosco - 2.20.3...2.20.4


#### Terraformer™ - 2.20.3...2.20.4

  - fix(git/repo): support symlinks when unpacking tarball archives (#192) (#194)

#### Armory Clouddriver - 2.20.5...2.20.5


#### Armory Kayenta - 2.20.3...2.20.3


#### Armory Fiat - 2.20.3...2.20.4


#### Armory Front50 - 2.20.5...2.20.6


#### Dinghy™ - 2.20.3...2.20.3


#### Armory Igor - 2.20.8...2.20.9


#### Armory Orca - 2.20.2...2.20.3


#### Armory Deck - 2.20.4...2.20.4


#### Armory Echo - 2.20.7...2.20.8

  - fix(github): fix conflicting bean with upstream (#194) (#195)
