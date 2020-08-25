---
title: "Armory Documentation"
linkTitle: "Documentation"
weight: 10
menu:
  main:
    weight: 10
---
[Spinnaker™](https://www.spinnaker.io) is an open source, multi-cloud Continuous Delivery and Deployment platform that provides a single pane of glass with visibility across your deployment for deployment status, infrastructure, security and compliance, and metrics. By using pipelines, flexible and customizable series of deployment stages, Spinnaker can fit a variety of deployment needs. Spinnaker can deploy to and manage clusters across Amazon Web Services (AWS), Kubernetes, and Google Cloud Platform (GCP). Spinnaker not only enables businesses to move to the cloud but makes it easier for them to adopt the cloud's advantages.

Armory helps software teams ship better software, faster. The Armory platform includes an enterprise-grade distribution of Spinnaker. It is preconfigured and runs in your Kubernetes cluster. The platform is an extension of open source Spinnaker and includes all those benefits as well as the following:

- [Pipeline as Code (Dinghy)]({{< ref "using-dinghy" >}}) allows you to store Spinnaker pipelines in Github and manage them like you would manage code, including version control, templatization, and modularization. Spinnaker pipelines are flexible and customizable series of deployment stages. Combine all these to rapidly and repeatably scale pipelines in your Spinnaker deployment.
- [Armory Operator for Spinnaker]({{< ref "operator" >}}) helps you configure, deploy, and update Spinnaker on Kubernetes clusters. The proprietary Armory Operator has extended functionality not available in the Open Source Spinnaker Operator. 
- [Policy Engine]({{< ref "policy-engine" >}}) helps you meet compliance requirements based on custom policies you set. You can configure the Policy Engine to verify that your pipelines meet certain requirements at save time or at runtime.
- [Terraform integration]({{< ref "terraform-use-integration" >}}) allows you to use your existing Terraform scripts to plan and create infrastructure as part a Spinnaker pipeline. You can deploy your application and infrastructure all in a single pipeline.
- [Pipelines as CRD (PaCRD)]({{< ref "pacrd" >}}) is a Kubernetes controller that manages the lifecycle of Spinnaker applications and pipelines as objects within your cluster. PaCRD extends Kubernetes functionality to support Spinnaker Application and Pipeline objects that can be observed for changes through a mature lifecycle management API. (Experimental feature).
