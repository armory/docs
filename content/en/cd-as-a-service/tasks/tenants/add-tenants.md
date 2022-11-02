---
title: Add Tenants
description: >
  Add tenants to your Armory CD-as-a-Service organization.
---

## {{% heading "prereq" %}}

* You have the Organization Admin role.
* You have installed the CLI and are logged into CD-as-a-Service.

## Create tenants

Every organization has a `main` tenant. You can create one or more additional tenants using a YAML file and the CLI. Your YAML file should have the following structure:

{{< prism lang="yaml" line-numbers="true" line="" >}}
tenants:
  - <tenant-name-1>
  - <tenant-name-2>
{{< /prism >}}

Run the following command to add those tenants:

{{< prism lang="yaml" line-numbers="true" line="" >}}
armory config apply -f <path-to-tenant-config.yaml>
{{< /prism >}}

## Example

In the following example, you create tenants for two applications and a sandbox.

1. Create a file called `config.yaml`.
1. Add the following content:

   {{< prism lang="yaml" line-numbers="true" line="" >}}
   tenants:
     - potato-facts-app
     - sample-app
     - sandbox{{< /prism >}}

   Save your file.  

1. Run the following command from the directory where you saved your `config.yaml` file:

   {{< prism lang="yaml" line-numbers="true" line="" >}}
   armory config apply -f config.yaml{{< /prism >}}

   Output should be:

   {{< prism lang="bash" line-numbers="true" >}}
   Created tenant: potato-facts-app
   Created tenant: sample-app
   Created tenant: sandbox{{< /prism >}}

1. Confirm your tenants have been added:

   {{< prism lang="bash" line-numbers="true" >}}
   armory config get{{< /prism >}}

   Output should be:

   {{< prism lang="bash" line-numbers="true" >}}
   tenants:
    - main
    - potato-facts-app
    - sample-app
    - sandbox{{< /prism >}}

## {{% heading "nextSteps" %}}

{{< linkWithTitle "cd-as-a-service/tasks/tenants/switch-tenants.md" >}}
