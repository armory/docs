---
title: Role-Based Access Control
linktitle: RBAC
description: >
  Learn how Armory Continuous Deployment-as-a-Service implements Role-Based Access Control (RBAC).
---

<!--
No mention of targetGroups, applications because that's not been implemented yet.
Removed grant types, resources, and permissions that haven't been (or won't be) implemented
-->

## Overview of RBAC in CD-as-a-Service

```mermaid
classDiagram
    class Role {
      +String name
      +Tenant tenant
      +List<Grant> grants
    }
    class Grant {
      +GrantType type
      +String resource
      +List<Permission> permissions
    }
    class GrantType {
      <<enumeration>>
      api
    }
    class Permission {
      <<enumeration>>
      full
    }
    class User {
      +List<Role> roles
    }
    class M2MCredential {
      +List<Role> roles
    }
    class Tenant {
      +String name
    }

    Role "1" --> "*" Grant
    Grant "1" --> "*" Permission
    Grant "1" --> "1" GrantType
    Role "1" --> "1" Tenant
    Role "1" --> "1" Tenant
    User "1" --> "*" Role
    M2MCredential "1" --> "*" Role
```


Central to CD-as-a-Service's [RBAC](https://en.wikipedia.org/wiki/Role-based_access_control) implementation is a _Role_, which defines what a user can do within the platform. Each Role has a _Grants_ collection that defines permissions.

The _Organization_ is the **Company** name you enter when signing up. The system-defined _Organization Admin_ role is a platform-wide role that has superuser permissions. CD-as-a-Service assigns this role to the person who creates a new CD-as-a-Service account. In the UI, an Organization Admin role has full access to all screens and functionality. Additionally, the Organization Admin role has full authority to execute all CLI commands. You are able to manually assign the Organization Admin role to all users you invite to your Organization, thus bypassing the need to create custom RBAC roles.

You define your custom RBAC roles in a YAML file that has this structure:

{{< prism lang="yaml" line-numbers="true" >}}
roles:
  - name: <role-name>
    tenant: <tenant-name>
    grants:
      - type: <type>
        resource: <resource>
        permission: <permission>
{{< /prism >}}

You can create an organization-wide role by omitting the `tenant` definition.

### Grants

A _Grant_ has type, resource, and permission attributes.

`type` has a single choice: `api`.

`resource` has the following values:

* `tenant`: When you use `tenant` as the `resource`, the Grant allows access to the tenant that you specify in the `roles.tenant` field. You use `tenant` when you define a [Tenant Admin role](#tenant-admin-role).
* `deployment`: This resource allows the role to deploy using the CLI and manage deployments in the **Deployments** UI. If you omit `roles.tenant`, the role has this Grant across your organization.
* `organization`: You use this resource when you need to create an Organization Admin role that maps to an SSO group. See [SSO groups and RBAC roles](#sso-groups-and-rbac-roles) for more on mapping SSO groups to RBAC roles.

`permission` has one option: `full`.

## Examples

### Tenant Admin role

This example defines three Tenant Admin roles, one for each tenant. Each role has full authority within the specified tenant.

{{< prism lang="yaml" line-numbers="true" >}}
roles:
  - name: Tenant Admin Main
    tenant: main
    grants:
      - type: api
        resource: tenant
        permission: full
  - name: Tenant Admin Finance
    tenant: finance
    grants:
      - type: api
        resource: tenant
        permission: full
  - name: Tenant Admin Commerce
    tenant: commerce
    grants:
      - type: api
        resource: tenant
        permission: full
{{< /prism >}}

If you want to grant a user permission to manage all of your tenants, assign that user the **Organization Admin** role using the UI.

### Deployment roles

This example defines a role that grants permission to use the **Deployments** UI and start deployments using the CLI. The role is bound to the `finance` tenant.

{{< prism lang="yaml" line-numbers="true" >}}
roles:
  - name: Deployer Finance
    tenant: finance
    grants:
      - type: api
        resource: deployment
        permission: full
{{< /prism >}}

This next example defines a role that grants permission to use the **Deployments** UI and start deployments using the CLI across your entire organization. Note that `tenant` is not defined, which makes this an organization-wide role.

{{< prism lang="yaml" line-numbers="true" >}}
roles:
  - name: Deployer All Tenants
    grants:
      - type: api
        resource: deployment
        permission: full
{{< /prism >}}


## Assign roles to users

After you define your roles, you use the CLI to [add your roles]({{< ref "cd-as-a-service/tasks/iam/create-role" >}}) to your CD-as-a-Service Organization. You do all subsequent role management with the CLI, but you [assign roles to users]({{< ref "cd-as-a-service/tasks/iam/manage-role-user" >}}) using the UI.

All users must have at least one role in order to use CD-as-a-Service. You can assign the Organization Admin role or a custom role. If a user has login credentials but no role assigned, the user sees a blank **Deployments** screen after logging in:

{{< figure src="/images/cdaas/user-no-role.png" alt="User sees the Deployments screen with no deployments." height="75%" width="75%">}}

## SSO groups and RBAC roles

>There is no self-service function for integrating your SSO provider. Contact your Armory rep if you want to use SSO with CD-as-a-Service.

You must create your RBAC roles using the same names as your SSO groups. For example, your company has the following groups defined in its SSO provider:

1. Engineering-Lead
1. Engineering-Deployment
1. Engineering-Infra

You want to use those groups in CD-as-a-Service, so you need to create roles for those SSO groups. In the following example, `Engineering-Lead` has a tenant-specific Tenant Admin role, `Engineering-Deployment` has a tenant-specific deployment role, and `Engineering-Infra` has the equivalent of an Organization Admin role.

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
  - name: Engineering-Infra
    grants:
      - type: api
        resource: organization
        permission: full
{{< /prism >}}

During authentication, CD-as-a-Service maps a user's SSO groups to your defined RBAC roles.

{{% alert title="Caution" color="warning" %}}
1. The SSO role does not appear in the UI. You cannot use CD-as-a-Service to assign an SSO role to a user.
1. You cannot use CD-as-a-Service to inspect the SSO groups that a user belongs to.
{{% /alert %}}


## {{% heading "nextSteps" %}}

* Tasks: {{< linkWithTitle "cd-as-a-service/tasks/iam/create-role.md" >}}, {{< linkWithTitle "cd-as-a-service/tasks/iam/update-role.md" >}}, {{< linkWithTitle "cd-as-a-service/tasks/iam/delete-role.md" >}}
* Tutorial: {{< linkWithTitle "cd-as-a-service/tutorials/access-management/rbac-users.md" >}}
* {{< linkWithTitle "cd-as-a-service/troubleshooting/rbac.md" >}}



<br>
<br>


<!--
## Not for primetime
aimee scratchpad


aimee's scratchpad stuff below

<table>
<tr>
<td>deployment.yaml</td>
<td>rbac.yaml</td>
</tr>
<tr>
<td>
{{< prism lang="yaml" line-numbers="true" >}}
version: v1
kind: kubernetes
application: potato-facts
# Map of Deployment Targets, this is set up in a way where
# we can do multi-target deployments (multi-region or multi-cluster)
targets:
  # This in the name of a deployment. Underneath it is its configuration.
  staging:
    # the name of an agent configured account
    account: acme-eks-staging-cluster
    # Optionally override the namespaces that are in the manifests
    namespace: potato-facts
    # This is the key to a strategy under the strategies map
    strategy: rolling
    constraints:
      dependsOn: ["dev"]
      beforeDeployment: []
 prod-east:
    # the name of an agent configured account
    account: acme-eks-prod-east-cluster
    # Optionally override the namespaces that are in the manifests
    namespace: potato-facts
    # This is the key to a strategy under the strategies map
    strategy: mycanary
    constraints:
      dependsOn: ["staging"]
      beforeDeployment:
        - pause:
            untilApproved: true
  prod-west:
    # the name of an agent configured account
    account: acme-eks-prod-west-cluster
    # Optionally override the namespaces that are in the manifests
    namespace: potato-facts
    # This is the key to a strategy under the strategies map
    strategy: myBlueGreen
    constraints:
      dependsOn: ["staging"]
      beforeDeployment:
        - pause:
            untilApproved: true
{{< /prism >}}
</td>
<td>
{{< prism lang="yaml" line-numbers="true" >}}
targetGroups:
  - name: potato-facts
    # optional field, defaults to main
    tenant: main
    targets:
      - name: staging
        account: acme-eks-staging-cluster
        kubernetes:
          namespace: potato-facts
      - name: prod-east
        account: acme-eks-prod-east-cluster
        kubernetes:
          namespace: potato-facts
      - name: prod-west
        account: acme-eks-prod-west-cluster
        kubernetes:
          namespace: potato-facts

roles:
  - name: Potato Facts Role
    # optional field, defaults to main
    tenant: main
    grants:
      - type: account
        resource: acme-eks-dev-cluster
        permission: full
      - type: targetGroup
        resource: potato-facts
        permission: full
      - type: api
        resource: deployment
        permission: full
  - name: Tenant Admin
    # optional field, defaults to main
    tenant: main
    grants:
      - type: api
        resource: tenant
        permission: full
  - name: Organization Admin
    grants:
      - type: api
        resource: organization
        permission: full
  - name: Remote Network Agent
    grants:
      - type: api
        resource: agent-hub
        permission: connect         
{{< /prism >}}
</td>
</tr>
</table>

<br><br><br><br>


deployment.yaml  |  rbac.yaml
--|--
{{% include "cdaas/rbac/snippet-deploy.md" %}}  |  {{% include "cdaas/rbac/snippet-rbac.md" %}}

-->