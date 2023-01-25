---
title: Bake Azure Images in an Armory CD or Spinnaker Pipeline
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

## Configure your bake using an Azure managed image

1. Add a **Bake** stage in your pipeline.
1. In the **Bake Configuration** section:

   1. Select your account from the **Account** list.
   1. Select a region in the **Regions** list.
   1. Select **Managed Images**.
   1. Select an image from the **Managed Image** list, which contains the images from your Azure account.
      {{< figure src="/images/user-guides/azure/select-managed-image.png" alt="Select a managed image." >}}

   1. If you choose a Linux image, you need to select the distro in the **Package Type** field. 

      * **DEB**: For example, Debian and Ubuntu
      * **RPM**: For example, CentOS and Fedora

   1. In the **Packages** field, add any packages you want to install in the image. This is a space-delimited list.
   1. Select a value in the **Base Label** list.
   1. Add a name to the **Base Name** field.
      {{< figure src="/images/user-guides/azure/managed-bake-fields.png" alt="Managed image bake configuration." >}}

1. Save and execute your pipeline.

## Configure your bake using Azure image attributes

You can configure your bake configuration using an image's Publisher, Offer, and SKU, which you can find using the [Azure CLI](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/cli-ps-findimage) or [Azure PowerShell](https://learn.microsoft.com/en-us/azure/virtual-machines/windows/cli-ps-findimage). 


1. Add a **Bake** stage in your pipeline.
1. In the **Bake Configuration** section:

   1. Select your account from the **Account** list.
   1. Select a region in the **Regions** list.
   1. Select **Custom Image**.
   1. Enter the image's Publisher in the **Publisher** field.
   1. Enter the image's Offer in the **Offer** field.
   1. Enter the image's SKU in the **SKU** field.
   1. Select a value in the **OS Type** list.
   1. If you are using a Linux image, you need to select the distro in the **Package Type** field. 

      * **DEB**: For example, Debian and Ubuntu
      * **RPM**: For example, CentOS and Fedora

   1. In the **Packages** field, add any packages you want to install in the image. This is a space-delimited list.
   1. Select a value in the **Base Label** list.
   1. Add a name to the **Base Name** field.
      {{< figure src="/images/user-guides/azure/custom-bake-fields.png" alt="Custom image bake configuration." >}}

1. Save and execute your pipeline.
