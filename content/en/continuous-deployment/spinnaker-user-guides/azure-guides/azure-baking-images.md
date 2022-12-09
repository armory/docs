---
title: Bake Azure Managed Images in a Spinnaker Pipeline
linkTitle: Bake an Azure Managed Image
description: >
  Create a pipeline that bakes an Azure Managed Image.
aliases:
  - /spinnaker_user_guides/azure-baking/
  - /user-guides/azure-baking-images/
  - /user-guides/azure_baking_images/
  - /user_guides/azure-baking-images/
  - /user_guides/azure_baking_images/
  - /spinnaker_user_guides/azure_baking_images/
  - /spinnaker_user_guides/azure-baking-images/
  - /spinnaker-user-guides/azure_baking_images/
  - /docs/spinnaker-user-guides/azure-baking-images/
---

>The phrase "baking images" is used within Armory and Spinnaker<sup>TM</sup> to refer to the process of creating virtual machine images.

## Prerequisites for baking managed images

- You are familiar with creating [applications]({{< ref "your-first-application" >}}) and [pipelines]({{< ref "your-first-pipeline" >}}).
- You are deploying to Azure Portal.


## Example of how to bake a managed image in a pipeline


## Troubleshooting

### Could not get lock `/var/lib/dpkg/lock-frontend`  

We tried several workarounds and at the end this error got solved by itself  
We believe it is an azure issue  
If you get this error you can just wait and retry
