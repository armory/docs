---
title: v2.26.4 Armory Release (OSS Spinnaker™ v1.26.6)
toc_hide: true
version: 02.26.04
description: >
  Release notes for Armory Enterprise v2.26.4
---

## 2021/12/15 Release Notes

> Note: If you're experiencing production issues after upgrading Armory Enterprise, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Halyard or Operator version
​
To install, upgrade, or configure Armory 2.26.4, use one of the following tools:
​
- Armory-extended Halyard 1.12 or later
  - 2.26.x is the last minor release that you can use Halyard to install or manage. Future releases require the Armory Operator. For more information, see [Halyard Deprecation]({{< ref "halyard-deprecation" >}}).
​
- Armory Operator 1.2.6 or later
​
   For information about upgrading, Operator, see [Upgrade the Operator]({{< ref "op-manage-operator#upgrade-the-operator" >}}).
​
​
## Security
​
Armory scans the codebase as we develop and release software. For information about CVE scans for this release, see the [Support Portal](https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010414). Note that you must be logged in to the portal to see the information.

This release includes a security fix. For more information, see the Critical Notification that Armory's Support Team sent out on 14 December 2021, contact your Armory account rep, or see this (login required) Support article: https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010520.
​
## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->
​
{{< include "breaking-changes/bc-java-tls-mysql.md" >}}
​
{{< include "breaking-changes/bc-k8s-version-pre1-16.md" >}}
​
{{< include "breaking-changes/bc-k8s-infra-buttons.md" >}}
​
## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->
​
{{< include "known-issues/ki-bake-var-file.md" >}}
{{< include "known-issues/ki-artifact-binding-spel.md" >}}
{{< include "known-issues/ki-dinghy-gh-notifications.md" >}}
​
## Highlighted updates
​
This release includes a security fix. For more information, see the Critical Notification that Armory's Support Team sent out on 14 December 2021, contact your Armory account rep, or see this (login required) Support article: https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010520.

