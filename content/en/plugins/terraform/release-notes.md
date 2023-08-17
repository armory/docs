---
title: Terraform Integration Plugin Release Notes
linkTitle: Release Notes
weight: 99
description: >
  Armory Terraform Integration plugin for Spinnaker and Armory Continuous Deployment release notes.
---


## 2.26.5

### **Show** Added to Terraform Integration Stage

There is a new Terraform action available as part of the Terraform Integration stage. This action is the equivalent of running the Terraform ```show``` command with Terraform. The JSON output from your planfile can be used in subsequent stages.

To use the stage, select **Terraform** for the stage type and **Show** as the action in the Stage Configuration UI. Note that the **Show** stage depends on your **Plan** stage. For more information, see [Show Stage section in the Terraform Integration docs]({{< ref "plugins/terraform/use#example-terraform-integration-stage" >}}).

### Terraform remote backends provided by Terraform Cloud and Terraform Enterprise

Terraform now supports remote backends provided by Terraform Cloud and Terraform Enterprise - see [Remote Backends section in the Terraform Integration docs]({{< ref "terraform-enable-integration#remote-backends" >}}).


