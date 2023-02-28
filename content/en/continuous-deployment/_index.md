---
title: Armory Continuous Deployment
weight: 10
no_list: true
description: >
  Guides and release notes for Armory Continuous Deployment products including Armory Continuous Deployment Self-Hosted, Armory Operator, and Armory Scale Agent for Spinnaker and Kubernetes.
---

## What is Armory Continuous Deployment?

{{% alert title="Name Changes" color="warning" %}}
Armory products are undergoing name changes. The new name for Armory Enterprise is Armory Continuous Deployment Self-Hosted, and Armory Agent for Kubernetes is now Armory Scale Agent for Spinnaker and Kubernetes.

Please excuse our dust as we update the documentation over the coming weeks.
{{% /alert %}}

{{< include "armory-license.md" >}}

{{< include "what-is-armorycd.md" >}}

### What is Spinnaker?

[Spinnaker™](https://www.spinnaker.io) is an open source, multi-cloud Continuous Delivery and Deployment platform that provides a single pane of glass with visibility across your deployment for deployment status, infrastructure, security and compliance, and metrics. By using pipelines, flexible and customizable series of deployment stages, Spinnaker can fit a variety of deployment needs. Spinnaker can deploy to and manage clusters across Amazon Web Services (AWS), Kubernetes, and Google Cloud Platform (GCP). Spinnaker not only enables businesses to move to the cloud but makes it easier for them to adopt the cloud's advantages.

## Additional Armory products

### Kubernetes Operators for installation

The [Armory Operator]({{< ref "armory-operator" >}}) is a Kubernetes Operator that helps you configure, deploy, and update Armory Enterprise on Kubernetes clusters.

The open source [Spinnaker Operator](https://github.com/armory/spinnaker-operator) provides features to deploy and manage open source Spinnaker.

### Armory Scale Agent for Spinnaker and Kubernetes

The {{< linkWithTitle "plugins/scale-agent/_index.md" >}} is a lightweight, scalable service that monitors your Kubernetes infrastructure and streams changes back to Spinnaker's Clouddriver service.
