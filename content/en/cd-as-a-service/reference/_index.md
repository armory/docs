---
title: Reference
exclude_search: true
weight: 50
---

## Terminology

To help you understand how Armory CD-as-a-Service works, familiarize yourself with the following terms:

- **Environment**: environments are used in two ways for Armory CD-as-a-Service, depending on the context.
  - **CD-as-a-Service Console**: the Armory CD-as-a-Service backend and UI use environments to isolate users and secrets. Users and secrets for one environment do not have access to other environments. That means a user in environment A cannot access secrets or deployments in environment B.
  - **Deployments**: for deployments, an environment is the collection of configs that you configure to tailor the deployment. It consists of characteristics that define how you deploy your app, including the  target Kubernetes cluster, namespace, deployment strategy, and constraints (dependencies). For example, if you create a `prod` environment for your deployment, you can make it dependent on a `dev` environment and add a deployment strategy that protects `prod` untested changes.
- **Deployment/deploy file**: the deployment file is a YAML file that you use to define where you want to deploy to (the environments), what  you want to deploy (the manifests), and how you want to deploy (the strategy). You can generate a template for the file using the Armory CD-as-a-Service CLI. For more information, see the [Deployment File Reference]({{< ref "ref-deployment-file" >}}).