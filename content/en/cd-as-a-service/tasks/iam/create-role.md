---
title: Create an RBAC Role
description: >
  Create an RBAC role using Armory CD-as-a-Service's CLI.
---
<!-- content is geared towareds creating a User role since the other types haven't been implemented yet -->

## Create a new RBAC role

By default, a new user has no permission to access CD-as-a-Service. So before you invite a user, you need to create a role that defines what the user can see and do in the UI as well as from the CLI.

>All users can start a deployment.

## {{% heading "prereq" %}}

* You are an Organization or Tenant Admin within CD-as-a-Service.

## How to create a role

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

If your organization uses SSO with CD-as-a-Service, you must create your roles using the same names as your SSO roles. For example, your company has the following roles defined in its SSO provider:

1. Engineering-Lead
1. Engineering-Deployment
1. Engineering-Core
1. Engineering-Intern

You want to use the Engineering-Deployment and Engineering-Lead roles in CD-as-a-Service, so you need to create roles for those SSO roles. In the following example, `Engineering-Lead` has a Tenant Admin role and `Engineering-Deployment` has a deployment role.

{{< prism lang="yaml" line-numbers="true" line="" >}}
roles:
  - name: Engineering-Lead
    tenant: main
    grants:
      - type: api
        resource: tenant
        permission: full
  - name: Engineering-Deployment
    tenant: main
    grants:
      - type: api
        resource: deployment
        permission: full
{{< /prism >}}

{{% alert title="SSO Gotchas" color="warning" %}}
1. The role does not appear in the UI.
1. You cannot use CD-as-a-Service to inspect the SSO groups that a user belongs to.
{{% /alert %}}

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "cd-as-a-service/tasks/iam/invite-users.md" >}}
* {{< linkWithTitle "cd-as-a-service/tasks/iam/update-role.md" >}}
* {{< linkWithTitle "cd-as-a-service/tasks/iam/delete-role.md" >}}
