---
linkTitle: Armory CD
title: Enable the Terraform Integration Stage in Armory Continuous Deployment
weight: 1
description: >
  Learn how to enable the Terraform Integration stage in Armory CD so that your app developers can provision infrastructure using Terraform as part of their delivery pipelines.
---
![Proprietary](/images/proprietary.svg)


## Overview of enabling Terraform Integration

Enabling the Terraform Integration stage consists of these steps:

1. [Configure Armory CD](#configure-armory-cd)
1. [Enable Terraform Integration](#enable-terraform-integration)
1. [Apply the update](#apply-the-update)

### Compatibility

{{< include "plugins/pac/compat-matrix.md" >}}

## {{% heading "prereq" %}}

You have read the [Terraform Integration Overview]({{< ref "plugins/terraform/_index.md" >}}).

{{< include "plugins/terraform/terraform-prereqs.md" >}}

## Configure Armory CD

### Configure Redis

{{< include "plugins/terraform/config-redis.md" >}}

### Configure your artifact account

{{< include "plugins/terraform/config-artifact-acct.md" >}}

### Configure additional repos

{{< include "plugins/terraform/configure-optional-repos.md" >}}

## Enable Terraform Integration

Add to your Armory CD configuration:

```yaml
spec:
  spinnakerConfig:
    config:
      armory:
        terraform:
          enabled: true
```

## Apply the update

After you finish your Terraform Integration configuration, perform the following steps:

1. Apply the changes:

   Assuming that Armory CD lives in the namespace `spinnaker` and the `SpinnakerService` manifest is named `spinnakerservice.yml`:

   ```bash
   kubectl -n spinnaker apply -f spinnakerservice.yml
   ```

1. Confirm that the Terraform Integration service (Terraformer) is deployed with your Armory CD deployment:

   ```bash
   kubectl get pods -n <your-spinnaker-namespace>
   ```

   In the command output, look for a line similar to the following:

   ```bash
   spin-terraformer-d4334g795-sv4vz    2/2     Running            0          0d
   ```

## {{% heading "nextSteps" %}}

{{< include "plugins/terraform/whats-next.md" >}}