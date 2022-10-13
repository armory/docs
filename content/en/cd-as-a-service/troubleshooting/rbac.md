---
title: Troubleshoot Role-Based Access Control in CD-as-a-Service
linktitle: RBAC
description: >
  Solutions for user issues in Armory Continuous Deployment-as-a-Service.
---

## User sees blank **Deployments** screen

{{< figure src="/images/cdaas/user-no-role.png" alt="User sees Deployments screen with no deployments" >}}

### Why this happens

The user doesn't have an RBAC role. This happens when:

* The Org or Tenant Admin doesn't assign a role when inviting the user.
* The Org or Tenant Admin deletes a role and doesn't assign a new role to affected users.

### Fix

Assign a role to the affected user.