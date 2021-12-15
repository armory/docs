---
title: v2.25.1 Armory Release (OSS Spinnaker™ v1.25.3)
toc_hide: true
version: 02.25.01
description: >
  Release notes for Armory Enterprise
---

## 2021/12/15 Release Notes

> Note: If you're experiencing production issues after upgrading Armory Enterprise, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

For information about what Armory supports for this version, see the [Armory Enterprise Compatibility Matrix]({{< ref "armory-enterprise-matrix-2-25.md" >}}).

## Required Halyard or Operator version
​
To install, upgrade, or configure Armory 2.25.1, use one of the following tools:
- Armory-extended Halyard 1.12 or later
- Armory Operator 1.2.6 or later
​
   For information about upgrading, Operator, see [Upgrade the Operator]({{< ref "op-manage-operator#upgrade-the-operator" >}}).
​
## Security
​
Armory scans the codebase as we develop and release software. For information about CVE scans for this release, see the [Support Portal](https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010414). Note that you must be logged in to the portal to see the information.

This release includes a security fix. For more information, see the Critical Notification that Armory's Support Team sent out on 14 December 2021, contact your Armory account rep, or see this (login required) Support article: https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010520.
​
## Breaking changes

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.
​
​
{{< include "breaking-changes/bc-k8s-job-suffix.md" >}}
​
{{< include "known-issues/ki-orca-zombie-execution.md" >}}
​
{{< include "breaking-changes/bc-orca-forcecacherefresh.md" >}}
​
## Known issues
​
{{< include "known-issues/ki-bake-var-file.md" >}}
{{< include "known-issues/ki-lambda-ui-caching.md" >}}
{{< include "known-issues/ki-dinghy-pipelineID.md" >}}
​
​
#### Git repo artifact provider cannot checkout SHAs
​
Only branches are currently supported. For more information, see [6363](https://github.com/spinnaker/spinnaker/issues/6363).
​
#### Server groups
<!-- ENG-5847 -->
There is a known issue where you cannot edit AWS server groups with the **Edit** button in the UI. The edit window closes immediately after you open it.
​
**Workaround**: To make changes to your server groups, edit the stage JSON directly by clicking on the **Edit stage as JSON** button.
​
## Highlighted updates
​
This release includes a security fix. For more information, see the Critical Notification that Armory's Support Team sent out on 14 December 2021, contact your Armory account rep, or see this (login required) Support article: https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010520.