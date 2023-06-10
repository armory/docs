---
title: Invite a User
linktitle: Invite a User
description: >
  Use the Armory CD-as-a-Service Console to invite a user to your CD-as-a-Service organization.
categories: ["Guides"]
tags: [ "Access", "RBAC"]
---

## Overview

For your users to get access to Armory CD-as-a-Service, you must invite them to your organization. This grants them access to the Armory CD-as-a-Service UI. Depending on their permissions, they may have access to different parts of the UI.

## {{% heading "prereq" %}}

1. You are familiar with the concepts discussed in {{< linkWithTitle "cd-as-a-service/concepts/architecture/orgs-tenants.md" >}}.
1. You need to create at least one role or your user won't be able to access CD-as-a-Service. See {{< linkWithTitle "cd-as-a-service/tasks/iam/create-role.md" >}}.
1. You need the user's name and email address. Note that the email domain must match your organization's format. For example, users that work for Acme (which uses `username@acme.com`) must have `@acme.com` email addresses. Users are automatically added to your organization once they accept the invite and complete the sign up.

{{% alert title="Important" color="warning" %}}
* **A user can belong to only one CD-as-as-Service Organization (company account)**. If you try to invite a person that already belongs to another org, you get a `409 Conflict: The user already exists` error. 
* A user can have access to multiple tenants within a single org.
{{% /alert %}}

## How to invite a user

1. Access the [CD-as-a-Service Console](https://console.cloud.armory.io).
1. Navigate to **Access Management** > **Users**.
1. Click **Invite Users**
1. Enter the new user's full name in the **Name** field and the user's email address in the **Email** field.
1. Select at least one role from the **Roles** drop down list.
1. Click **Send Invitation**.
1. A modal window opens. Review the information and click **OK** to send the information or **Cancel** to return to the previous screen.

The new user receives an email with instructions for accessing the CD-as-a-Service Console.


## {{% heading "nextSteps" %}}

* RBAC
   * {{< linkWithTitle "cd-as-a-service/tasks/iam/update-role.md" >}}
   * {{< linkWithTitle "cd-as-a-service/tasks/iam/delete-role.md" >}}

* User Role Management
   * {{< linkWithTitle "cd-as-a-service/tasks/iam/manage-role-user.md" >}}
   * {{< linkWithTitle "cd-as-a-service/tutorials/access-management/rbac-users.md" >}}

* {{< linkWithTitle "cd-as-a-service/troubleshooting/rbac.md" >}}
