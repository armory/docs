---
title: Role-Based Manual Approval
description: >
  Learn how role-based manual approvals in Armory Continuous Deployment-as-a-Service can enforce your SDLC's approval processes.
categories: ["Concepts"]
tags: ["Deployment", "RBAC", "Approvals"]
---

## Overview of role-based manual approval in Armory CD-as-a-Service

You can use role-based manual approvals to enforce approval processes within your SDLC. For example, if a release manager must provide a signoff before production deployment, you can create a "Release Managers" role and configure a manual approval to require approval by that role.

## {{% heading "prereq" %}}

* You have read {{< linkWithTitle "cd-as-a-service/concepts/iam/rbac.md" >}}.

## How role-based manual approval works

Any manual approval can be role-based. In your deployment manifest, you add a `requiresRoles` field to specify which roles can issue the approval.

{{< prism lang="yaml" line-numbers="true" line="" >}}
...
pause:
  untilApproved: true
  requiresRoles: []
...
{{< /prism >}}

- `requiresRoles`: list of RBAC roles

  - The list must have at least one entry.
  - Omitting this field means that any user with access to the deployment can issue the approval.

### Rules

* Users assigned any of the roles in the list can issue the approval. The **Approve** button is disabled if the user doesn't have the correct role.
* Users assigned the Organization Admin role can issue an approval in any deployment regardless of tenant.
* Users assigned a [Tenant Admin role]({{< ref "cd-as-a-service/concepts/iam/rbac#tenant-admin-role" >}}) can issue an approval in any deployment in their specific tenant.

## {{%  heading "nextSteps" %}}

* {{< linkWithTitle "cd-as-a-service/tasks/deploy/role-based-manual-approval.md" >}}