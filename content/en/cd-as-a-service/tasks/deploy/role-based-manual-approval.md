---
title: Configure Role-Based Manual Approval
description: >
  Implement role-based manual deployment approval in Armory Continuous Deployment-as-a-Service.
---

## {{% heading "prereq" %}}

* You have read {{< linkWithTitle "cd-as-a-service/concepts/deployment/role-based-manual-approval.md" >}}.


## Configure role-based manual approval

In your deployment manifest, add a `requiresRole` field to your manual approval.

{{< prism lang="yaml" line-numbers="true" line="" >}}
...
pause:
  untilApproved: true
  requiresRoles: []
...
{{< /prism >}}

- `requiresRoles`: list of RBAC roles; must have at least one entry

For example, if you want only users with an "Approver" or "Lead Tester" role to be able to issue a manual approval, you would add those roles to the `requiresRole` list:

{{< prism lang="yaml" line-numbers="true" line="" >}}
...
pause:
  untilApproved: true
  requiresRoles: ["Approver", "Lead Tester"]
...
{{< /prism >}}

## {{%  heading "nextSteps" %}}

* {{< linkWithTitle "cd-as-a-service/troubleshooting/rbac.md" >}}