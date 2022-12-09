---
title: Cloud Foundry as a Deployment Target in Spinnaker
linkTitle: Cloud Foundry as Deployment Target
description: Learn how Spinnaker interacts with Cloud Foundry.
weight: 1
---

## How Spinnaker interacts with Cloud Foundry

{{< figure width="618" height="207" src="/images/cf/CloudFoundrySpinnaker.png"  alt="Spinnaker - Cloud Foundry Deployment Design"  caption="<i>Spinnaker - Cloud Foundry Deployment Design</i>">}}

Spinnaker has caching agents for Cloud Foundry Server Groups, Load Balancers, and Spaces. In order to perform caching and operations, these caching agents communicate directly with the Cloud Foundry Cloud Controller via its REST API. The caching agents run on a specific interval, typically every 30 seconds. You can read more about caching agents in the {{< linkWithTitle "caching-agents-concept.md" >}} guide.

## Cloud Foundry as a deployment target

**Cloud Foundry administrators** should configure the minimal amount of permissions required by Spinnaker to successfully function. This typically means the Cloud Foundry account has `Space Developer` permissions for at least one organization/space. In some cases, it may make sense to have one account for the entire Foundation, but this configuration isn't normal or desired for security reasons.

**Spinnaker administrators** can configure one or more Cloud Foundry accounts as cloud providers.

**Spinnaker users** can use a Cloud Foundry account as a deployment target. Users can perform Cloud Foundry operations by using the Cloud Foundry [stages](https://spinnaker.io/reference/pipeline/stages/#cloud-foundry) in their pipelines.


## {{% heading "nextSteps" %}}

* {{< linkWithTitle "add-cf-account.md" >}}
* {{< linkWithTitle "best-practices-cf.md" >}}