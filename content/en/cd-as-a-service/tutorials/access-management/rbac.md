---
title: Role-Based Access Control
linktitle: RBAC
description: >
  Learn how to configure and use Role-Based Access Control (RBAC) in Armory Continuous Deployment-as-a-Service.
draft: true
---

<!-- THIS IS A DRAFT! HUGO DOES NOT COMPILE DRAFTS. I'M LEAVING THIS HERE FOR WHEN TARGET GROUPS ARE DONE -->

## Objectives

You are the CD-as-a-Service Organization Admin and lead a small development team that has one software engineer and one intern.

Your Kubernetes cluster has four environments: `test`, `staging`, `prod-eu`, and `prod-us`.  

Your team has two apps to deploy:

* Prod App - deploy to all environments
* Intern App - the intern's app; deploy to test and staging environments

You want your intern to use CD-as-a-Service to deploy Intern App and monitor the progress on the **Deployments** screen. However, you don't want your intern to deploy Prod App. With CD-as-a-Service's Role-Based Access Control, you can create a role for your team to start deployments and view them in the UI. You can also restrict who deploys the Prod App by creating a app-specific role.

In this tutorial, you learn how to:

* [Fork and clone the repo](#fork-and-clone-the-repo)
* [Connect your cluster](#connect-your-cluster)
* [Create RBAC roles](#create-rbac-roles)


## {{% heading "prereq" %}}

* You have installed `kubectl` and have access to a Kubernetes cluster
* You have [set up your Armory CD-as-a-Service account]({{< ref "get-started" >}}).
* You have [installed the `armory` CLI]({{< ref "cd-as-a-service/setup/cli" >}}).
* You have installed [Helm](https://helm.sh/docs/intro/install/).
* You have a GitHub account so you can fork the sample project.
* You have read the {{< linkWithTitle "cd-as-a-service/concepts/iam/rbac.md" >}} content.
* You have completed the  {{< linkWithTitle "cd-as-a-service/tutorials/deploy-sample-app.md" >}}.

## Fork and clone the repo

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) the  [sample repo](https://github.com/armory/docs-cdaas-sample) to your own GitHub account. Then clone the repo to the machine where you installed `kubectl` and the `armory` CLI.

>This tutorial uses the `tutorial-rbac` branch. Be sure to `git checkout tutorial-rbac` before you continue.

This tutorial is designed to use a single Kubernetes cluster with multiple namespaces to simulate multiple clusters. The `configuration` directory contains a script to connect your Kubernetes cluster to Armory CD-as-a-Service and install the namespaces this tutorial uses.

The repo has deployment files for Prod App (`deploy-prod-app.yml`) and Intern App (`deploy-intern-app.yml`). You can find the Kubernetes manifests for each app in the `manifests` directory.

## Connect your cluster

If you completed the {{< linkWithTitle "deploy-sample-app.md" >}} and have **not** cleaned up your Kubernetes environment by running `/configuration/teardown-helm.sh`, you can skip the remainder of this section.

### Create Client Credentials

Create a new set of Client Credentials for the Remote Network Agents. Name the credentials "docs-sample-rna".

{{< include "cdaas/client-creds.md" >}}

### Install the Remote Network Agents

Configure the sample environments and install the Remote Network Agents in your Kubernetes cluster.

1. Make sure you are connected to the Kubernetes cluster you want to install the sample app on.
1. Log into your Armory CD-as-a-Service environment using the CLI:

   ```bash
   armory login --envName "<envName>"
   ```

   `--envName <envName` is optional. Replace `<envName>` with the name of your Armory CD-as-a-Service environment if you have access to multiple environments.

1. Navigate to the `docs-cdaas-sample/configuration` directory and run the `setup-helm.sh` script using the "docs-sample-rna" Client Credentials you created for this tutorial.

   The script does the following:

      - Creates four namespaces, one for each Remote Network Agent
      - Creates secrets for each RNA namespace using the Client Credentials
      - Uses Helm to install the Remote Network Agents, one in each RNA namespace
      - Creates four namespaces to mimic different deployment target clusters

   ```bash
   bash setup-helm.sh <client-ID> <client-secret>
   ```

   After the script completes successfully, you can view the connected Remote Network Agents on the CD-as-a-Service Console's **Networking** > **Agents** screen.

## Create RBAC roles

You can find the RBAC config file in the `docs-cdaas-sample/rbac` directory.

### User role

Since the default user role is one with no permissions, you should create your roles before you invite your team to CD-as-a-Service.

Your team consists of an engineer and an intern. You want both to start and monitor deployments, so you create a role called "Deployer".

{{< prism lang="yaml" line-numbers="true" line="" >}}
roles:
  - name: Deployer
    tenant: main
    grants:
      - type: api
        resource: deployment
        permission: full
{{< /prism >}}

### App deployment role

Since You want to restrict who deploys Prod App, you need to create a deployment role. A deployment role requires a target deployment group, so begin by defining that target group. You can find the targets in `deploy-prod-app.yml`.

{{< prism lang="yaml" line-numbers="true" line="" >}}
targetGroups:
  - name: ProdAppDeploymentTargetGroup
    tenant: main
    targets:
      - name: test
        account: sample-rna-test-cluster
        kubernetes:
          namespace: sample-test
      - name: staging
        account: sample-rna-staging-cluster
        kubernetes:
          namespace: sample-staging
      - name: prod-eu
        account: sample-rna-prod-eu-cluster
        kubernetes:
          namespace: sample-prod-eu
      - name: prod-us
        account: sample-rna-prod-us-cluster
        kubernetes:
          namespace: sample-prod-us
{{< /prism >}}

Next, add the deployment role for Prod App to the `roles` section.
{{< prism lang="yaml" line-numbers="true" line="8-13" >}}
roles:
  - name: Deployer
    tenant: main
    grants:
      - type: api
        resource: deployment
        permission: full
  - name: ProdAppDeployment
    tenant: main
    grants:
      - type: targetGroup
        resource: ProdAppDeploymentTargetGroup
        permission: full

targetGroups:
  - name: ProdAppDeploymentTargetGroup
    tenant: main
    targets:
      - name: test
        account: sample-rna-test-cluster
        kubernetes:
          namespace: sample-test
      - name: staging
        account: sample-rna-staging-cluster
        kubernetes:
          namespace: sample-staging
      - name: prod-eu
        account: sample-rna-prod-eu-cluster
        kubernetes:
          namespace: sample-prod-eu
      - name: prod-us
        account: sample-rna-prod-us-cluster
        kubernetes:
          namespace: sample-prod-us
{{< /prism >}}

### Add roles using the CLI

After you have defined your roles, you need to add them to using the Armory CLI. Log into the Armory CLI, navigate to `docs-sample-repo/rbac` and execute:

{{< prism lang="bash" >}}
armory config apply -f ./config.yaml
{{< /prism >}}

## Assign RBAC roles
