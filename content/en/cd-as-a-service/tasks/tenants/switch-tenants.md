---
title: View and Switch Tenants
description: >
  View and switch tenants in your Armory CD-as-a-Service organization.
---

## {{% heading "prereq" %}}

* You have a [custom Tenant Admin role]({{< ref "cd-as-a-service/tasks/iam/create-role#user-role-examples" >}}) that applies to more than one tenant **or** you have the Organization Admin role.
* You have installed the CLI and are logged into CD-as-a-Service.

## View tenants

You can use the CLI to view your tenants:

{{< prism lang="bash" line-numbers="true" >}}
armory config get
{{< /prism >}}

Output shows the list of tenants. When you only have the default tenant, the output is:

{{< prism lang="bash" line-numbers="true" >}}
tenants:
 - main
{{< /prism >}}

You can also use the UI to view the list of tenants you can access. See the [Switch tenants](#switch-tenants) section.

## Switch tenants

You use the UI to switch to the tenant whose resources you want to see. CD-as-a-Service displays the **Switch Tenants* user content menu item when you have access to multiple tenants.

{{< figure src="/images/cdaas/ui-switch-tenant.jpg" alt="Switch Tenant." >}}

1. Access your user context menu.
1. Hover over **Switch Tenant** to display a list of accessible tenants. 
1. Click the tenant you want to switch to.

