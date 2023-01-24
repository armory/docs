---
title: Bake Azure Managed and Custom Images in an Armory CD or Spinnaker Pipeline
linkTitle: Bake Azure Image
description: >
  Create an Armory Continuous Deployment or Spinnaker pipeline that bakes an Azure image.
---

## {{% heading "prereq" %}}

* You are familiar with:

  * Creating [applications]({{< ref "your-first-application" >}}) and [pipelines]({{< ref "your-first-pipeline" >}})
  * [Baking images](https://spinnaker.io/docs/setup/other_config/bakery/) in Spinnaker
  * [Virtual machines and images in Azure](https://learn.microsoft.com/en-us/azure/virtual-machines/)

* You are deploying to [Azure Portal](https://learn.microsoft.com/en-us/azure/azure-portal/) and have [configured your Azure account](https://spinnaker.io/docs/setup/install/providers/azure/) in Spinnaker.

## How to bake using a managed image

1. Add a **Bake** stage in your pipeline.
1. In the **Bake Configuration** section:

   1. Select your account from the **Account** list.
   1. Select a region in the **Regions** list.
   1. Select **Managed Images**
   1. Select an image from the **Managed Image** list, which contains the images from your Azure account.
      {{< figure src="/images/user-guides/azure/select-managed-image.png" alt="Select a managed image." >}}

   1. If you choose a Linux image, you need to select the distro in the **Package Type** field. 

      * **DEB**: For example, Debian and Ubuntu
      * **RPM**: For example, CentOS and Fedora

   1. Add any packages you want to install in the **Packages** field.
   1. Select a value in the **Base Label** list.
   1. Add a name to the **Base Name** field.
      {{< figure src="/images/user-guides/azure/managed-bake-fields.png" alt="Bake configuration." >}}

1. Save and execute your pipeline.

## How to bake using a custom image


## Troubleshooting

### Could not get lock `/var/lib/dpkg/lock-frontend`  

We tried several workarounds and at the end this error got solved by itself  
We believe it is an azure issue  
If you get this error you can just wait and retry
