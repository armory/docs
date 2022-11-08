---
title: Manage a User's RBAC Role
linkTitle: Manage User's Role
description: >
  Assign and revoke a user's RBAC role in Armory CArmory CD-as-a-Service.
---

## {{% heading "prereq" %}}

* You are an Organization or Tenant Admin within CD-as-a-Service.
* You have [created RBAC roles]({{< ref "cd-as-a-service/tasks/iam/create-role.md" >}}) for your users.

## How to assign a role

1. Access the [CD-as-a-Service Console](https://console.cloud.armory.io).
1. Navigate to **Access Management** > **Users**.
1. Find the user you want to update. Click the **pencil icon** to open the **Edit User** screen.
1. In the **Edit User** screen, place your cursor in the **Roles** field and click.
1. Select a role from the drop-down list. Repeat if you want to assign the user more than one role. Selected roles appear below the **Roles** drop-down list.
1. Click the **Save Roles** button.

## How to revoke a role

1. Access the [CD-as-a-Service Console](https://console.cloud.armory.io).
1. Navigate to **Access Management** > **Users**.
1. Find the user you want to update. Click the **pencil icon** to open the **Edit User** screen.
1. In the **Edit User** screen, you can see a user's roles listed below the **Roles** field.
1. Each assigned role has an **x** next to it. Click the **x** to remove the role.

{{< figure src="/images/cdaas/user-role-delete.jpg" alt="User role with arrow pointing at 'x' to delete" >}}


>Make sure your user has at least one role!

## {{% heading "nextSteps" %}}

* RBAC
   * {{< linkWithTitle "cd-as-a-service/tasks/iam/update-role.md" >}}
   * {{< linkWithTitle "cd-as-a-service/tasks/iam/delete-role.md" >}}

* User Role Management
   * {{< linkWithTitle "cd-as-a-service/tutorials/access-management/rbac-users.md" >}} tutorial

* {{< linkWithTitle "cd-as-a-service/troubleshooting/rbac.md" >}}
