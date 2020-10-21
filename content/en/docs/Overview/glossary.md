---
title: Glossary
weight: 100
---

Below is a list of words and phrases as they apply to Spinnaker and their definitions, including any additional information that may be helpful.

## Amazon Web Services

Amazon Web Services (AWS) is a cloud services provider from Amazon that offers computing power, database storage, content delivery and additional functionalities to businesses that operate in the cloud. For Spinnaker purposes, think of AWS as a data center but instead of being physical servers it is in the cloud.

## Amazon Machine Images

Amazon Machine Images (AMIs) are predetermined 'templates' for instances that can be used to launch an instance of a virtual server. They generally include the configurations for the instance (Operating System, application server, applications), the permissions and Secrets that control which AWS accounts can access the instances, and a block device mapping that specifies the volumes to attach to the instance when it is launched.

## Application

An [application]({{< ref "application-screen" >}}) inside Spinnaker™ represents what you would typically find in a single [code repository](#Code-Repository) - and in many cases, an application maps directly to a microservice.

## Auto-Scaling Group

An auto-scaling group (ASG) contains a collection of [EC2](#elastic_compute_cloud) instances that share similar characteristics and are treated as a logical grouping for the purposes of instance scaling and management.

## Authorization

Authorization (Auth) is the level of access to APIs that a user, application or role has within your [AWS](#Amazon_Web_Services) account. This is usually configured by your administrator.

## Baking

The term '[Baking]({{< ref "baking-images" >}})' is used within Spinnaker to refer to the process of creating machine images, usually with [AMIs](#Amazon_Machine_Images).

## Cloud

Short for cloud computing, the cloud as we refer to it is internet-based computing that provides processing resources (e.g.; database storage, networks, servers, applications) on demand to devices connected to the internet.

## Clouddriver

A sub-service within Spinnaker. See the [Spinnaker Architecture](https://www.spinnaker.io/reference/architecture/) for more information.

## Cluster

A server group is a regional view of servers, whereas a cluster is a world-wide view of server groups.

## Code repository

A source code repository is a private or public storage location for file archive and web hosting, used for source codes of software or web pages.

## Continuous Delivery

Continuous Delivery (CD) is an engineering approach for DevOps teams to produce software in short cycles: building, testing, and releasing software at a fast and frequent pace in order to iterate as quickly as possible.

## Continuous Integration

Continuous Integration (CI) is a development practice where software developers merge their separate changes and updates to a main source code repository - usually multiple times a day.

## Deck

A sub-service within Spinnaker. See the [Spinnaker Architecture](https://www.spinnaker.io/reference/architecture/) for more information.

## Debian package

Debian packages (deb) are two tar archives contained in standard Unix ar archives - one holds the control information and the other contains the data used for installation.

## Detail

For cluster and server group configurations, 'Detail' is usually any additional piece of user-defined information you want to label your cluster and server group(s) with.

## Echo

A sub-service within Spinnaker. See the [Spinnaker Architecture](https://www.spinnaker.io/reference/architecture/) for more information.

## Elastic Compute Cloud

Elastic Compute Cloud (EC2) is part of the AWS cloud platform, a "pay as you go" virtual computer renting system that contains preconfigured software and applications requested by the user.

## Execution

When a pipeline runs, the end result is called an execution.

## Gate

A sub-service within Spinnaker. See the [Spinnaker Architecture](https://www.spinnaker.io/reference/architecture/) for more information.

## Igor

A sub-service within Spinnaker. See the [Spinnaker Architecture](https://www.spinnaker.io/reference/architecture/) for more information.

## Infrastructure version

The infrastructure's version number; such as v011, v012, etc. This is automatically appended and is not user defined.

In AWS, Spinnaker will name your ASGs and Launch Configurations according to the naming convention mentioned above (ie. "armoryspinnaker-prod-polling-v015").

Please note that if your user definition includes a hyphen, it will disrupt the naming convention.

#### Jenkins

[Jenkins]({{< ref "working-with-jenkins" >}}) is an open source automation server that can package applications for distribution. Spinnaker pipelines can be [triggered]trigger) from a build on Jenkins.

#### Load balancer

For Spinnaker's purposes, a [load balancer]({{< ref "load-balancers" >}}) is a service that automatically distributes incoming traffic across all instances. The one most commonly used within AWS is the Elastic Load Balancer (ELB).

#### Orca

A sub-service within Spinnaker. See the [Spinnaker Architecture](https://www.spinnaker.io/reference/architecture/) for more information.

#### Pipeline

A pipeline in Spinnaker is a series of stages linked together that can be executed serially or in parallel. All pipelines are defined in the context of an application. A typical pipeline will contain stages for "creating images", "testing", and "deploying". The process of "creating images" is also commonly referred to as a "bake".

Learn to create [your first pipeline here]({{< ref "your-first-pipeline" >}}).

#### Project

A project inside Spinnaker is a logical grouping of applications. For example, we might create a project called "Spinnaker" and its applications would be "Deck", "Orca", "Clouddriver", etc. Spinnaker provides a helpful dashboard view using Deck for each project to visualize its applications and status of each application contained within it.

#### Rosco

A sub-service within Spinnaker. See the [Spinnaker Architecture](https://www.spinnaker.io/reference/architecture/) for more information.

#### Scale server group

Reduce the total number of server groups remaining in the cluster.

#### Server group

From an Amazon Web Service (AWS) point of view, a server group is represented by an auto-scaling group (ASGs). All applications that are deployed by Spinnaker are deployed to server groups.

#### Shrink server group

Reduce the number of instances in a particular server group.

#### Stack

You can think of a 'Stack' as a tag you give to anything that you want to be integrated together. Environments are usually a good example of something you would tag with a Stack. If you have an app that has an ELB, a Cache, and an [ASG](#auto-scaling-group), usually you would want to run integration tests on your staging environment separately from your production environment. In that case, you would give the staging ELB, Cache, and ASG all the "staging" stack, while prod ELB, Cache, and ASG would be the "prod" stack.

Note that Stack names are defined by the user in the Spinnaker configuration User Interface (UI).

#### Stage

Within a pipeline, the tasks that pipeline performs are called stages.

#### Trigger

A trigger is the entry point to a [pipeline](#pipeline) - when a pipeline is triggered, it attempts to [execute](#execution).
