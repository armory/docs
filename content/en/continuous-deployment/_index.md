---
title: Armory Continuous Deployment
weight: 10
no_list: true
description: >
  Guides and release notes for Armory Continuous Deployment Self-Hosted and the Armory Operators.
---

## What is Armory Continuous Deployment?

{{< include "armory-license.md" >}}

{{< include "what-is-armorycd.md" >}}

### What is Spinnaker?

[Spinnaker™](https://www.spinnaker.io) is an open source, multi-cloud Continuous Delivery and Deployment platform that provides a single pane of glass with visibility across your deployment for deployment status, infrastructure, security and compliance, and metrics. By using pipelines, flexible and customizable series of deployment stages, Spinnaker can fit a variety of deployment needs. Spinnaker can deploy to and manage clusters across Amazon Web Services (AWS), Kubernetes, and Google Cloud Platform (GCP). Spinnaker not only enables businesses to move to the cloud but makes it easier for them to adopt the cloud's advantages.

## Additional Armory products

### Kubernetes Operators for installation
{{% alert color="warning" title="Important" %}}
[Armory Operator]({{< ref "armory-operator" >}}) has been deprecated and will is considered EOL. Please migrate to the [Kustomize]({{< ref "armory-operator-to-kustomize-migration" >}}) method of deployment.
{{% /alert %}}

The [Armory Operator]({{< ref "armory-operator" >}}) is a Kubernetes Operator that helps you configure, deploy, and update Armory Continuous Deployment on Kubernetes clusters.

The open source [Spinnaker Operator](https://github.com/armory/spinnaker-operator) provides features to deploy and manage open source Spinnaker.

### Plugins for Spinnaker and Armory CD

{{% readfile "/includes/plugins/plugin-compat-matrix.md" %}}


