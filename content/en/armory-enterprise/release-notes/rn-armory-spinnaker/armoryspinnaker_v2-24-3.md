---
title: v2.24.3 Armory Enterprise Release
toc_hide: true
version: 02.24.03
description: >
  Release notes for Armory Enterprise v2.24.3 
---

> 2.24.x is not a supported version.

## 2021/12/14 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a previous working version and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.24.3, use one of the following tools:

- Armory-extended Halyard 1.10 or later
- Armory Operator 1.2.1 or later
   For information about upgrading, Operator, see [Upgrade the Operator]({{< ref "op-manage-operator#upgrade-the-operator" >}}).

## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, see the [Support Portal](https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010414). Note that you must be logged in to the portal to see the information.

This release includes a security fix. For more information, see the Critical Notification that Armory's Support Team sent out on 14 December 2021, contact your Armory account rep, or see this (login required) Support article: https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010520.

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->
> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

{{< include "breaking-changes/bc-k8s-job-suffix.md" >}}

<!-- Moved this to Breaking changes instead of KI. Didn't bother renaming it. -->
{{< include "known-issues/ki-orca-zombie-execution.md" >}}

{{< include "breaking-changes/bc-orca-forcecacherefresh.md" >}}


## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->
{{< include "known-issues/ki-bake-var-file.md" >}}
{{< include "known-issues/ki-lambda-ui-caching.md" >}}
{{< include "known-issues/ki-dinghy-modules.md" >}}

## Highlighted updates

This release includes a security fix. For more information, see the Critical Notification that Armory's Support Team sent out on 14 December 2021, contact your Armory account rep, or see this (login required) Support article: https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010520.
