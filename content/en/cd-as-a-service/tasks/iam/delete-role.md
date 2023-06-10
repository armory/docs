---
title: Delete an RBAC Role
description: >
  Delete an RBAC role using Armory CD-as-a-Service's CLI.
categories: ["Guides"]
tags: [ "Access", "RBAC"]
---

## {{% heading "prereq" %}}

* You are an Organization or Tenant Admin within CD-as-a-Service.
* You have read {{< linkWithTitle "cd-as-a-service/concepts/iam/rbac.md" >}}.

## How to delete a role

Perform the following to delete a role or roles:

1. Add `allowAutoDelete: true` to the top of your RBAC config file.
1. Remove the role(s) from your RBAC config file.
1. Log into the CLI and apply the changes:

   {{< prism lang="bash" line-numbers="true" >}}
   armory login
   armory config apply -f <path-to-rbac-config>.yml{{< /prism >}}


For example, you have a config file with the following roles:

{{< prism lang="yaml" line-numbers="true" line="" >}}
roles:
  - name: Tenant Admin
    tenant: main
    grants:
      - type: api
        resource: tenant
        permission: full
  - name: Deployer
    tenant: main
    grants:
      - type: api
        resource: deployment
        permission: full
  - name: Tester
    tenant: main
    grants:
      - type: api
        resource: deployment
        permission: full
{{< /prism >}}

You want to delete the Tester role. Update your config file by adding `autodelete: true` to the top and removing the Tester role entry:

{{< prism lang="yaml" line-numbers="true" line="" >}}
allowAutoDelete: true
roles:
  - name: Tenant Admin
    tenant: main
    grants:
      - type: api
        resource: tenant
        permission: full
  - name: Deployer
    tenant: main
    grants:
      - type: api
        resource: deployment
        permission: full
{{< /prism >}}

Execute `armory config apply -f <path-to-rbac-config>.yml` to apply your changes.

You can check that you deleted your role by running `armory config get`.

When you delete a role, that role is removed from existing users. You can accidentally remove the ability for your users to perform actions within CD-as-a-Service. A user with no role can still log into the UI but only sees a blank **Deployments** screen:
{{< figure src="/images/cdaas/user-no-role.png" >}}

## {{% heading "nextSteps" %}}

* User Role Management
   * {{< linkWithTitle "cd-as-a-service/tasks/iam/manage-role-user.md" >}}
   * {{< linkWithTitle "cd-as-a-service/tutorials/access-management/rbac-users.md" >}}

* {{< linkWithTitle "cd-as-a-service/troubleshoOting/rbac.md" >}}