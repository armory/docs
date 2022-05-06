---
title: Client Credentials
linktitle: Client Credentials
exclude_search: true
description: >
  Create Client Credentials using the Console.
---

## Create service account credentials

Client credentials are machine-to-machine credentials that the Borealis CLI uses to authenticate with Armory's hosted cloud services when you use the CLI as part of an automated workflow. These credentials are passed through the `clientID` and `clientSecret` parameters.

To create service account credentials, perform the following steps:

{{< include "aurora-borealis/borealis-client-creds.md" >}}

Armory recommends that you store these credentials in a secret engine that is supported by the tool you want to integrate Borealis with.