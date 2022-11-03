---
title: View and Switch Tenants
description: >
  View and switch tenants in your Armory CD-as-a-Service organization.
---

## {{% heading "prereq" %}}

* You have installed the CLI and are logged into CD-as-a-Service.

## View tenants

>Non-Admin users only see tenants that they belong to. If users don't have a role belonging to a particular tenant, they don't see those tenants.

You can use the CLI to view your tenants:

{{< prism lang="bash" line-numbers="true" >}}
armory config get
{{< /prism >}}

Output shows the list of tenants. When you only have access to the default tenant, the output is:

{{< prism lang="bash" line-numbers="true" >}}
tenants:
 - main
{{< /prism >}}

You can also use the UI to view the list of tenants you can access. See the [Switch tenants](#switch-tenants) section.

## Switch tenants

You use the UI to switch to the tenant whose resources you want to see. CD-as-a-Service only displays the **Switch Tenants* user content menu item when you have access to more than one tenant.

{{< figure src="/images/cdaas/ui-switch-tenant.jpg" alt="Switch Tenant." >}}

1. Access your user context menu.
1. Hover over **Switch Tenant** to display a list of accessible tenants.
1. Click the tenant you want to switch to.

