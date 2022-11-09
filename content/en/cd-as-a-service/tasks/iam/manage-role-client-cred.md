---
title: Manage a Client Credential's RBAC Role
linkTitle: Manage Credential's Role
description: >
  Assign and revoke a Client Credential's RBAC role in Armory CArmory CD-as-a-Service.
---

## {{% heading "prereq" %}}

* You are an Organization or Tenant Admin within CD-as-a-Service.
* You are familiar with [RBAC in CD-as-a-Service]({{< ref "cd-as-a-service/concepts/iam/rbac.md" >}})
* You have [created a Client Credential]({{< ref "cd-as-a-service/tasks/iam/client-creds" >}}).

## How to assign a role

1. Access the [CD-as-a-Service Console](https://console.cloud.armory.io).
1. Navigate to **Access Management** > **Client Credentials**.
1. Find the credential you want to update. Click the **pencil icon** to open the **Update** screen.
1. In the **Update** screen, place your cursor in the **Select Roles** field and click.
1. Select a role from the drop-down list. Repeat if you want to assign the credential more than one role. Selected roles appear below the **Select Roles** drop-down list.
1. Click the **Update Credential** button.

## How to revoke a role

1. Access the [CD-as-a-Service Console](https://console.cloud.armory.io).
1. Navigate to **Access Management** > **Client Credentials**.
1. Find the Client Credential you want to update. Click the **pencil icon** to open the **Update** screen.
1. In the **Update** screen, you can see a credential's roles listed below the **Select Roles** field.
1. Each assigned role has an **x** next to it. Click the **x** to revoke the role.

>Make sure your Client Credential has at least one role!

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "cd-as-a-service/troubleshooting/rbac.md" >}}
