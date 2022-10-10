---
title: Create RBAC User Roles
linktitle: RBAC User Roles
description: >
  Learn how to configure and use Role-Based Access Control (RBAC) for end users in Armory Continuous Deployment-as-a-Service.
---

## Objectives

You are the CD-as-a-Service Organization Admin and lead a small development team that you want to invite to use CD-as-a-Service. Before you add your team, you need to create roles that define what a user can see in the UI.


In this tutorial, you learn how to:

* [Define RBAC roles](#create-rbac-roles) in a YAML file.
* Assign a role to a new user


## {{% heading "prereq" %}}

* You have [set up your Armory CD-as-a-Service account]({{< ref "get-started" >}}).
* You have [installed the `armory` CLI]({{< ref "cd-as-a-service/setup/cli" >}}).
* You have read the {{< linkWithTitle "cd-as-a-service/concepts/iam/rbac.md" >}} content.

## Define RBAC roles

