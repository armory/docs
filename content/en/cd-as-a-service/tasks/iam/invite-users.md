---
title: Invite Users to Armory Continuous Deployment-as-a-Service
linktitle: Invite Users
exclude_search: true
description: >
  Use the Armory CD-as-a-Service Console to invite users to your environment.
---

## Overview

For your users to get access to Armory CD-as-a-Service, you must invite them to your environment. This grants them access to the Armory CD-as-a-Service UI. Depending on their permissions, they may have access to the **Configuration UI** and the **Status UI**.

## {{% heading "prereq" %}}

You need a user's name and email address. Note that the email domain must match your organization's format. For example, users that work for Acme (which uses `username@acme.com`) must have `@acme.com` email addresses. They are automatically added to your organization once they accept the invite and complete the sign up.

## How to invite a user

1. Access the [CD-as-a-Service Console](https://console.cloud.armory.io).
1. Navigate to **Access Management** > **Users**.
1. Click **Invite Users**
1. Enter the new user's full name in the **Name** field and the user's email address in the **Email** field.
1. Click **Send Invitation**.
1. A modal window opens. Review the information and click **OK** to send the information or **Cancel** to return to the previous screen.

The new user receives an email with instructions for accessing the CD-as-a-Service Console.

<!--
## {{% heading "nextSteps" %}}
-->