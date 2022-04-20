---
title: "Cloud Admin (Preview)"
description: Administer your Armory Cloud environment
draft: true
aliases:
  - /docs/armory-cloud-admin/
---
![Proprietary](/images/proprietary.svg)
{{% alert title="Info" color="primary" %}}{{< include "saas-status.md" >}}{{% /alert %}}

## Overview

Armory Cloud is a Software as a Service (SaaS) platform for continuous delivery that integrates with your existing tools. As a SaaS solution, Armory Cloud gives you the ability to deliver software without the maintenance overhead of having to maintain your own continuous delivery tools.

The three components of Armory Cloud are the Armory Cloud Console, Armory Cloud API, and Armory Enterprise:

- Armory Cloud Console is the administrator portal for Armory Cloud where you perform configuration tasks, such as adding a new deployment target or managing your configuration secrets. Use it to configure your Armory Cloud Platform instance and integrations with your existing tools.
- Armory Cloud API gives you a way to programmatically configure admin settings.
- Armory Platform, which includes Spinnaker™ and Armory's enterprise extensions, is where your app developers create and manage their delivery pipelines with the environments defined in the Cloud Console.

In addition to building a SaaS platform, Armory is also developing and iterating on new features that benefit app developers when crafting their delivery pipelines. For information about those features, see [Armory Cloud Preview]({{< ref "armory-cloud-preview" >}}).
