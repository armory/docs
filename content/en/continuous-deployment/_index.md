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

The Armory Operator is a Kubernetes Operator that enables you to [install]({{< ref "continuous-deployment/installation/armory-operator/install-armorycd" >}}) and manage Armory Continuous Deployment on Kubernetes clusters.

Like the Armory Operator, the open source Spinnaker Operator is a Kubernetes Operator that enables you to [install]({{< ref "continuous-deployment/installation/armory-operator/install-spinnaker" >}}) and manage open source Spinnaker.

### Plugins for Spinnaker and Armory CD

{{% readfile "/includes/plugins/plugin-compat-matrix.md" %}}


