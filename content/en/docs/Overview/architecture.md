---
title: Spinnaker™ Architecture
linkTitle: "Architecture"
weight: 10
description: "The services that work together in Spinnaker™"
aliases:
  - /spinnaker-install-admin-guides/architecture/
---

## Armory Enterprise architecture

Armory Enterprise is an enterprise version of open source [Spinnaker](https://spinnaker.io/). It is composed of several microservices for resiliency and follows the single-responsibility principle. It allows for faster iteration on each individual component and a more pluggable architecture for custom components.

![Architecture Diagram](/images/overview/SpinnakerArchitecture.png)

## Armory Enterprise microservices

### Clouddriver

Clouddriver is a core component of Armory Enterprise and facilitates the interaction between a given cloud provider such as AWS, GCP or Kubernetes. There is a common interface that is used so that additional cloud providers can be added.

### Deck

Deck is the UI for interactive and visualizing the state of cloud resources.  It depends on Gate to interact with the cloud providers.

### Echo

Echo is the service for Spinnaker which manages notifications, alerts and scheduled pipelines (Cron). It can also propagate these events out to other REST endpoints such as an Elastic Search, Splunk's HTTP Event Collector or a custom event collector/processor.

### Fiat

Fiat is the microservice responsible for authorization (authz) for the other microservices. By default, it is not enabled, so users are able to perform any action in Armory Enterprise.

### Front50

Front50 is the persistent datastore for Spinnaker. Most notabily pipelines, configurations, and jobs.

### Gate

Gate is the front-end API that is exposed to the users of your Spinnaker instance. It also manages authentication and authorization for sub-service APIs and resources with Spinnaker.  All communication between the UI and the back-end services happen through Gate.  You can find a list of the endpoints available through Swagger:  `http://${GATE_HOST}:8084/swagger-ui.html`

### Igor

Igor is a wrapper API which communicates with Jenkins.  It is responsible for kicking-off jobs and reporting the state of running or completing jobs.

### Kayenta

Kayenta is Spinnaker's canary analysis service, integrating with 3rd party monitoring services such as Datadog or Prometheus.

### Orca

Orca is responsible for the orchestration of pipelines, stages, and tasks within Armory Enterprise. Orca acts as the "traffic cop" within Armory Enterprise making sure that sub-services, their executions and states are passed along correctly.

The smallest atomic unit within Orca is a task - stages are composed of tasks and pipelines are composed of stages.  

### Rosco

Rosco is the "bakery" service. It is a wrapper around Hashicorp's Packer command line tool which bakes images for AWS, GCP, Docker, Azure, and [other builders](https://www.packer.io/docs/builders).

## Armory Enterprise proprietary microservices
![Proprietary](/images/proprietary.svg)

### Armory Agent for Kubernetes

The [Armory Agent]({{< ref "armory-agent" >}}) is a lightweight, scalable service that monitors your Kubernetes infrastructure and streams changes back to the Clouddriver service.

### Dinghy

[Dinghy]({{< ref "dinghy-enable" >}}) is the microservice used to manage Pipelines as Code. It supports two main capabilities:

* Automatically synchronizing pipeline definitions from an external Github or BitBucket repository to Armory.
* Creating a library of pipeline modules (components) that can be templatized and used in Dinghy-managed pipeline definitions.

### Policy Engine

The [Armory Policy Engine]({{< ref "policy-engine-enable" >}}) is designed to allow enterprises more complete control of their software delivery process by providing them with the hooks necessary to perform more extensive verification of their pipelines and processes in Spinnaker. This policy engine is backed by Open Policy Agent(OPA) and uses input style documents to perform validation of pipelines during save time and runtime

### Terraformer

[Terraformer]({{< ref "terraform-enable-integration" >}}) is the microservice behind Armory's Terraform Integration. It allows Armory to natively use your infrastructure-as-code Terraform scripts as part of a deployment pipeline.

## Installation and management
![Proprietary](/images/proprietary.svg)

### Armory Operator

The [Armory Operator]({{< ref "armory-operator" >}}) is a Kubernetes Operator that makes it easy to install, deploy, and upgrade Armory Enterprise.

### Armory Halyard

[Armory-extended Halyard]({{< ref "armory-halyard" >}}) is a versatile command line interface (CLI) to configure and deploy Armory Enterprise in Kubernetes or any cloud environment.