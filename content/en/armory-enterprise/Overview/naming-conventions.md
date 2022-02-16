---
title: Spinnaker Nomenclature and Naming Conventions
linkTitle: Naming Conventions
weight: 5
description: >
  Spinnaker™ terminology
---

## Nomenclature

### Application

An application inside Spinnaker represents what you would typically find in a single code repository - and in many cases, an application maps directly to a microservice.

![The Spinnaker Applications view](/images/overview/application.png)

### Cluster
A server group is a regional view of servers, whereas a cluster is a world-wide view of server groups.

![The Spinnaker Cluster view](/images/overview/cluster.png)

### Execution
When a pipeline runs, the end result is called an execution.

![The Spinnaker Executions view](/images/overview/execution.png)

### Pipeline
A pipeline in Spinnaker is a series of stages linked together that can be executed serially or in parallel. All pipelines are defined in the context of an application. A typical pipeline will contain stages for “creating images”, “testing”, and “deploying”. The process of “creating images” is also commonly referred to as a “bake”.

![The Spinnaker Pipeline view](/images/overview/pipeline.png)

### Project
A project inside Spinnaker is a logical grouping of applications. For example, we might create a project called “Spinnaker” and its applications would be “Deck”, “Orca”, “Clouddriver”, etc. Spinnaker provides a helpful dashboard view for each project to visualize its applications and status of each application contained within it.

![The Spinnaker Project Dashboard](/images/overview/project-dashboard.png)

### Server Group
From an Amazon Web Service (AWS) point of view, a server group is represented by an auto-scaling group (ASGs). All applications that are deployed by Spinnaker are deployed to server groups.

![](/images/overview/cluster.png)

### Stage
Within a pipeline, the tasks that pipeline performs are called stages.

![](/images/overview/pipeline.png)

### Trigger
A trigger is the entry point to a pipeline.

![](/images/overview/trigger.png)


## Spinnaker Naming Conventions

Spinnaker has very specific naming conventions that help it identify resources in your cloud account.

Clusters and server groups follow the convention `application_name-stack-detail-infrastructure_version`  


### Application
The 'Name' is the name of your application in Spinnaker.

### Stack
You can think of a 'Stack' as a tag you give to anything that you want to be integrated together. Environments are usually a good example of something you would tag with a Stack. If you have an app that has an ELB, a Cache, and an ASG, usually you would want to run integration tests on your staging environment separately from your production environment. In that case, you would give the staging ELB, Cache, and ASG all the “staging” stack, while prod ELB, Cache, and ASG would be the “prod” stack.

Note that Stack names are defined by the user in the Spinnaker configuration User Interface (UI).

### Detail
Detail is also user-defined and can be any additional piece of information you want to label your cluster and server group with.

### Infrastructure Version
The infrastructure's version number; such as v011, v012, etc. This is automatically appended and is not user defined.

In AWS, Spinnaker will name your ASGs and Launch Configurations according to the naming convention mentioned above (ie. “armoryspinnaker-prod-polling-v015”).

![](/images/Image-2017-03-24-at-3.10.53-PM.png)

Please note that if your user definition includes a hyphen, it will disrupt the naming convention.
