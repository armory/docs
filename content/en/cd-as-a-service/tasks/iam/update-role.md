---
title: Update an RBAC Role
description: >
  Update an RBAC role using Armory CD-as-a-Service's CLI.
categories: ["Guides"]
tags: [ "Access", "RBAC"]
---

## {{% heading "prereq" %}}

* You are an Organization or Tenant Admin within CD-as-a-Service.
* You have read {{< linkWithTitle "cd-as-a-service/concepts/iam/rbac.md" >}}.

## How to update a role

Perform the following to update a role or roles:

1. Update the existing role(s) in your RBAC config file.
1. Log into the CLI and apply the changes:

   {{< prism lang="bash" line-numbers="true" >}}
   armory login
   armory config apply -f <path-to-rbac-config>.yml{{< /prism >}}


For example, you created the following roles:

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
    grants:
      - type: api
        resource: deployment
        permission: full
{{< /prism >}}

You notice that the Tester role has no `tenant` defined, which means the role is organization-wide. Update your config file to add the tenant:

{{< prism lang="yaml" line-numbers="true" line="14" >}}
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

Execute `armory config apply -f <path-to-rbac-config>.yml` to apply your changes.

You can check that you updated your role correctly by running `armory config get`.

>The role name is case insensitive. "DeployM2m" is the same as "DeployM2M", so if you want to change capitalization in a role name, you must delete the role and add a new role with the name's corrected capitalization.

## {{% heading "nextSteps" %}}

* RBAC
   * {{< linkWithTitle "cd-as-a-service/tasks/iam/delete-role.md" >}}

* User Role Management
   * {{< linkWithTitle "cd-as-a-service/tasks/iam/manage-role-user.md" >}}
   * {{< linkWithTitle "cd-as-a-service/tutorials/access-management/rbac-users.md" >}}

* {{< linkWithTitle "cd-as-a-service/troubleshoOting/rbac.md" >}}
