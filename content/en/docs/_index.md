---
title: "Armory Docs"
linkTitle: "Docs"
weight: 10
menu:
  main:
    weight: 10
---

{{< include "armory-license.md" >}}

[Spinnaker™](https://www.spinnaker.io) is an open source, multi-cloud Continuous Delivery and Deployment platform that provides a single pane of glass with visibility across your deployment for deployment status, infrastructure, security and compliance, and metrics. By using pipelines, flexible and customizable series of deployment stages, Spinnaker can fit a variety of deployment needs. Spinnaker can deploy to and manage clusters across Amazon Web Services (AWS), Kubernetes, and Google Cloud Platform (GCP). Spinnaker not only enables businesses to move to the cloud but makes it easier for them to adopt the cloud's advantages.

Armory helps software teams ship better software, faster. Armory Enterprise includes an enterprise-grade distribution of Spinnaker. It is preconfigured and runs in your Kubernetes cluster. It is an extension of open source Spinnaker and includes all those benefits as well as the following:

- [Pipelines as Code (Dinghy)]({{< ref "using-dinghy" >}}) allows you to store Spinnaker pipelines in Github and manage them like you would manage code, including version control, templatization, and modularization. Spinnaker pipelines are flexible and customizable series of deployment stages. Combine all these to rapidly and repeatably scale pipelines in your Spinnaker deployment.
- [Policy Engine]({{< ref "policy-engine-enable" >}}) helps you meet compliance requirements based on custom policies you set. You can configure the Policy Engine to verify that your pipelines meet certain requirements at save time or at runtime.
- [Armory Operator]({{< ref "armory-operator" >}}) is a Kubernetes Operator that helps you configure, deploy, and update Armory on Kubernetes clusters. There are two versions of the Armory Operator: the open source [Spinnaker Operator](https://github.com/armory/spinnaker-operator), which installs open source Spinnaker; and the Armory Operator, which is proprietary, install Armory, and has extended functionality not available in the Spinnaker Operator.
- [Terraform integration]({{< ref "terraform-use-integration" >}}) allows you to use your existing Terraform scripts to plan and create infrastructure as part a Spinnaker pipeline. You can deploy your application and infrastructure all in a single pipeline.
- [Pipelines as CRD (PaCRD)]({{< ref "pacrd" >}}) is a Kubernetes controller that manages the lifecycle of Armory applications and pipelines as objects within your cluster. PaCRD extends Kubernetes functionality to support Spinnaker Application and Pipeline objects that can be observed for changes through a mature lifecycle management API. (Experimental feature).
