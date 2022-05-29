---
title: Armory Continuous Deployment
weight: 10
no_list: true
description: >
  Guides and release notes for Armory Continuous Deployment products including Armory Continuous Deployment Self-Hosted, Armory Operator, and Armory Scale Agent for Spinnaker and Kubernetes.
---

## What is Armory Continuous Deployment?

{{% alert title="Name Change" color="warning" %}}
Armory products are undergoing name changes. Armory Enterprise is now Armory Continuous Deployment Self-Hosted and Armory Agent for Kubernetes is now Armory Scale Agent for Spinnaker and Kubernetes.

Please excuse our dust as we update the documentation over the coming weeks.
{{% /alert %}}

{{< include "armory-license.md" >}}

Armory helps software teams ship better software, faster. Armory Continuous Deployment (Armory CD) is an enterprise-grade distribution of Spinnaker™ that runs in your Kubernetes cluster. Armory CD is an extension of open source Spinnaker and includes all of those benefits as well as the following:

- [Pipelines as Code (Dinghy)]({{< ref "using-dinghy" >}}) allows you to store Spinnaker pipelines in Github and manage them like you would manage code, including version control, templatization, and modularization. Spinnaker pipelines are flexible and customizable series of deployment stages. Combine all these to rapidly and repeatably scale pipelines in your Spinnaker deployment.
- [Policy Engine]({{< ref "policy-engine-enable" >}}) helps you meet compliance requirements based on custom policies you set. You can configure the Policy Engine to verify that your pipelines meet certain requirements at save time or at runtime.
- [Terraform integration]({{< ref "terraform-use-integration" >}}) allows you to use your existing Terraform scripts to plan and create infrastructure as part a Spinnaker pipeline. You can deploy your application and infrastructure all in a single pipeline.

### What is Spinnaker?

[Spinnaker™](https://www.spinnaker.io) is an open source, multi-cloud Continuous Delivery and Deployment platform that provides a single pane of glass with visibility across your deployment for deployment status, infrastructure, security and compliance, and metrics. By using pipelines, flexible and customizable series of deployment stages, Spinnaker can fit a variety of deployment needs. Spinnaker can deploy to and manage clusters across Amazon Web Services (AWS), Kubernetes, and Google Cloud Platform (GCP). Spinnaker not only enables businesses to move to the cloud but makes it easier for them to adopt the cloud's advantages.

## Additional Armory products

### Kubernetes Operators for installation

The [Armory Operator]({{< ref "armory-operator" >}}) is a Kubernetes Operator that helps you configure, deploy, and update Armory Enterprise on Kubernetes clusters.

The open source [Spinnaker Operator](https://github.com/armory/spinnaker-operator) provides features to deploy and manage open source Spinnaker.

### Armory Scale Agent for Spinnaker and Kubernetes

The [Armory Agent]({{< ref "armory-agent" >}}) is a lightweight, scalable service that monitors your Kubernetes infrastructure and streams changes back to Spinnaker's Clouddriver service.
