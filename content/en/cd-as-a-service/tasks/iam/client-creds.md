---
title: Create Client Credentials
linktitle: Client Credentials
description: >
  Create machine-to-machine client credentials and assign RBAC roles to them in Armory CD-as-a-Service.
---

## Overview

A Client Credential is a machine-to-machine credential that the CLI uses to authenticate with your Armory CD-as-a-Service environment when you trigger deployments as part of an external automated workflow. You pass the credential through the `clientID` and `clientSecret` parameters.

Additionally, a Remote Network Agent uses a Client Credential for authentication when communicating with CD-as-a-Service.

## Create a Client Credential

{{< include "cdaas/client-creds.md" >}}

Armory recommends that you store credentials in a secret engine that is supported by the tool you want to integrate with CD-as-a-Service.

