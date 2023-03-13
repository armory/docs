---
title: Create a Temporary Preview Link to Deployed Service
linkTitle: Create Preview Links
description: >
  Create a temporary public preview link to a deployed service for testing.
---

## Overview

 Create a temporary public preview link to a deployed service to verify HTTP services after their deployment. The created link is generated with a random domain prefix and automatically expires after a pre-configured period.

 ## {{% heading "prereq" %}}

 You are using a canary deployment strategy.

 ## Expose your services

In your deployment file, add an `exposeServices` step to `strategies.<strategyName>.canary.steps`.

{{< include "cdaas/deploy/preview-link-details.md" >}}