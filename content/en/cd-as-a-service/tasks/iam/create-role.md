---
title: Create an RBAC Role
description: >
  Create an RBAC role using Armory CD-as-a-Service's CLI.
---
<!-- content is geared towareds creating a User role since the other types haven't been implemented yet -->

## Create a new RBAC role

By default, a new user has no permission to access functionality within CD-as-a-Service. You can assign a new user the Organization Admin role or create a custom role that defines what the user can see and do in the UI as well as from the CLI.

>All users can start a deployment.

## {{% heading "prereq" %}}

* You are an Organization or Tenant Admin within CD-as-a-Service.
* You have read {{< linkWithTitle "cd-as-a-service/concepts/iam/rbac.md" >}}.

## How to create a custom role

You define your roles in a YAML file using the following structure:

{{< prism lang="yaml" line-numbers="true" line="" >}}
roles:
  - name: <role-name>
    tenant: <tenant-name>
    grants:
      - type: <grant-type>
        resource: <resource-type>
        permission: <permission-type>
{{< /prism >}}

* `name`: (Required); String; name of the role
* `tenant`: (Optional); String; name of the tenant; if omitted, the role is an organization-wide role, not bound to a specific tenant
* `grants`: (Required)(Dictionary)

   * `type`: (Required); String; `api`
   * `resource`: (Required); String; one of `organization`, `tenant`, or `deployment`
   * `permission`: (Required); String; `full`

After you have defined your roles, use the CLI to add those roles to CD-as-a-Service.

{{< prism lang="bash" line-numbers="true" line="" >}}
armory login
armory config apply -f <path-to-rbac-config>.yml
{{< /prism >}}

You can check that you created your roles correctly by running `armory config get`.

>**Organization Admin** is a system-defined role that does not appear in your RBAC config.

### User role examples

**Tenant Admin**

A user with this role can access every screen in the `main` tenant and deploy apps using the CLI.

{{< prism lang="yaml" line-numbers="true" line="" >}}
roles:
  - name: Tenant Admin
    tenant: main
    grants:
      - type: api
        resource: tenant
        permission: full
{{< /prism >}}

**Deployer**

A user with this role can only access the **Deployments** screen in the UI and deploy apps using the CLI.

{{< prism lang="yaml" line-numbers="true" line="" >}}
roles:
  - name: Deployer
    tenant: main
    grants:
      - type: api
        resource: deployment
        permission: full
{{< /prism >}}

## SSO roles

If your organization uses SSO with CD-as-a-Service, you must create your roles using the same names as your SSO groups. For example, your company has the following groups defined in its SSO provider:

1. Engineering-Infra
1. Engineering-Release
1. Engineering-InfoSec

You want to use those groups in CD-as-a-Service, so you need to create roles for those SSO groups. In the following example, `Engineering-Infra` has a Tenant Admin role. `Engineering-Release` and `Engineering-InfoSec` have tenant-scoped deployment roles.

{{< prism lang="yaml" line-numbers="true" line="" >}}
roles:
  - name: Engineering-Infra
    tenant: main
    grants:
      - type: api
        resource: tenant
        permission: full
  - name: Engineering-InfoSec
    tenant: main
    grants:
      - type: api
        resource: deployment
        permission: full
  - name: Engineering-Release
    tenant: main
    grants:
      - type: api
        resource: deployment
        permission: full
{{< /prism >}}

## {{% heading "nextSteps" %}}

* RBAC
   * {{< linkWithTitle "cd-as-a-service/tasks/iam/update-role.md" >}}
   * {{< linkWithTitle "cd-as-a-service/tasks/iam/delete-role.md" >}}
   * {{< linkWithTitle "cd-as-a-service/concepts/deployment/role-based-manual-approval.md" >}}

* User Role Management
   * {{< linkWithTitle "cd-as-a-service/tasks/iam/manage-role-user.md" >}}
   * {{< linkWithTitle "cd-as-a-service/tutorials/access-management/rbac-users.md" >}}


* {{< linkWithTitle "cd-as-a-service/troubleshooting/rbac.md" >}}
