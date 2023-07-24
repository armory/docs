---
title: Create Client Credentials
description: >
  Create machine-to-machine credentials and assign RBAC roles to them in Armory CD-as-a-Service.
categories: ["Guides"]
tags: [ "Access", "Credentials"]
---

## Overview

A _Client Credential_ is a machine-to-machine credential that the CLI uses to authenticate with CD-as-a-Service when you trigger deployments as part of an external automated workflow. You pass the credential through the `clientID` and `clientSecret` parameters.

Additionally, a Remote Network Agent uses a Client Credential for authentication when communicating with CD-as-a-Service.

## {{% heading "prereq" %}}

* You are an Organization or Tenant Admin within CD-as-a-Service.
* You are familiar with {{< linkWithTitle "cd-as-a-service/concepts/architecture/orgs-tenants.md" >}} and [RBAC in CD-as-a-Service]({{< ref "cd-as-a-service/concepts/iam/rbac.md" >}})


## Create a Client Credential

{{< include "cdaas/client-creds.md" >}}

Armory recommends that you store credentials in a secret engine that is supported by the tool you want to integrate with CD-as-a-Service.

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "cd-as-a-service/tasks/iam/manage-role-client-cred.md" >}}
* {{< linkWithTitle "cd-as-a-service/troubleshooting/rbac.md" >}}
