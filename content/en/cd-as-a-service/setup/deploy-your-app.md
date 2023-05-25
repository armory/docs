---
title: Deploy Your Own App
linkTitle:  Deploy Your Own App
description: >
  Create a deployment config file for your app. Deploy two versions of your app to your Kubernetes cluster using Armory CD-as-a-Service.
weight: 20
---

## Learning objectives

In this guide, you build on what you learned in the  CD-as-a-Service [Quickstart]({{< ref "cd-as-a-service/setup/quickstart" >}}) by deploying your own app using the deployment configuration from the Quickstart.

1. [Create your deployment config file](#create-a-deployment-config-file)
1. [Deploy your app](#deploy-your-app)


>If you prefer a web-based, interactive tutorial, see the CD-as-a-Service Console's [**Deploy Your Own App** tutorial](https://next.console.cloud.armory.io/getting-started).

## {{% heading "prereq" %}}

* You have completed the CD-as-a-Service [Quickstart]({{< ref "cd-as-a-service/setup/quickstart" >}}).
* You have created the Kubernetes manifests for your web app.
* You have two versions of your app to deploy.

For this guide, you can use the Remote Network Agent that you created as part of the Quickstart. Instead of deploying Armory's sample app, you deploy your own web app using the CD-as-a-service deployment configuration from the Quickstart. 

### Directory structure

This guide assumes the following directory structure:

```
<my-app>
├── deployment.yaml
└── manifests
    ├── <my-app>-service.yaml
    ├── <my-app>.yaml
    ├── namespace-staging.yaml
    └── namespace-prod.yaml
```

The Kubernetes manifests for deploying your app are in the `manifests` directory. Replace `<my-app>` with the name of your app.

Create your staging namespace in `namespace-staging.yaml` and your prod namespace in `namespace-prod.yaml`.  The deployment config file supports deploying manifests to specific targets, and the deployment config file uses separate namespace manifests to illustrate this feature.

## Create your deployment config file

This deployment config defines the following strategies:

* `rolling`: deploy 100% of the app (staging)
* `trafficSplit`: 75% to the current version and 25% to the new version (prod)

In addition, prod deployment requires a manual approval to begin deployment and another to continue deployment after the traffic split.

Create a `deployment.yaml` file with the following contents:

```yaml
version: v1
kind: kubernetes
application: <your-app-name>
targets:
  staging:  
    account: <your-remote-network-agent-identifier> # the name you gave the RNA when you installed it in your staging cluster
    namespace: <your-namespace-staging> # defined in namespace-staging.yaml
    strategy: rolling
  prod:
    account: <your-remote-network-agent-identifier> # the name you gave the RNA when you installed it in your prod cluster
    namespace: <your-namespace-prod> # defined in namespace-prod.yaml
    strategy: trafficSplit
    constraints:
      dependsOn: ["staging"]
      beforeDeployment:
        - pause:
            untilApproved: true
manifests:
  - path: manifests/my-app.yaml
  - path: manifests/my-app-service.yaml
  - path: manifests/namespace-staging.yaml
    targets: ["staging"]
  - path: manifests/namespace-prod.yaml
    targets: ["prod"]
strategies:
  rolling:
    canary:
      steps:
        - setWeight:
            weight: 100
  trafficSplit:
    canary:
      steps:
        - setWeight:
            weight: 25
        - exposeServices:
            services:
              - <my-app-service>
            ttl:
              duration: 30
              unit: minutes
        - pause:
            untilApproved: true
        - setWeight:
            weight: 100
```

* Replace `account` and `namespace` values with those specific to your environment. 
* Replace `<my-app>` with your app name (or the names of your manifest file)

{{% alert title="Important" color="warning" %}}
For the first deployment of your app, Armory CD-as-a-Service automatically deploys the app to 100% of the cluster since there is no previous version. Subsequent deployments of your app follow the strategy steps defined in your deployment file.
{{% /alert %}}

## Deploy your app

{{% alert title="Important" color="warning" %}}
Armory CD-as-a-Service manages your Kubernetes deployments using ReplicaSet resources. During the initial deployment of your app, CD-as-a-Service deletes the underlying Kubernetes deployment object in a way that leaves behind the ReplicaSet and pods so that there is no actual downtime for your app. These are later deleted when the deployment succeeds.

If your initial deployment fails, you should [manually delete]({{< ref "cd-as-a-service/troubleshooting/tools#initial-deployment-failure-orphaned-replicaset" >}}) the orphaned ReplicaSet.
{{% /alert %}}

### Deploy first version

1. Log in using the CLI.

   ```bash
   armory login
   ```

   The CLI returns a `Device Code` and opens your default browser.  Confirm the code in your browser to complete the login process,.

1. Start the deployment from the root of your directory.

   ```bash
   armory deploy start  -f deployment.yaml
   ```

   The `deploy start` command starts your deployment. The command returns a **Deployment ID** and a link to your deployment details. 

1. Monitor your deployment execution.

   Use the link provided by the CLI to navigate to your deployment details page in the [CD-as-a-Service Console](https://console.cloud.armory.io/deployments). 

1. Issue manual approval.

   Since you defined a manual approval to deploy to prod in your strategy, you need to issue your manual approval using the UI. Once the `staging` deployment has completed, click **Approve** to allow the `prod` deployment to begin. Because this is the first time deploying your app, CD-as-a-Service deploys 100% to your prod environment, skipping the defined `trafficSplit` strategy. CD-as-a-Service uses the `trafficSplit` when deploying subsequent versions of your app.

### Deploy second version

1. Update your Kubernetes manifest to deploy a new version of your app. 
1. Start the deployment from the root of your directory.

   ```bash
   armory deploy start  -f deployment.yaml
   ```

1. Monitor your deployment.  

   Use the link provided by the CLI to observe your deployment's progression in the [CD-as-a-Service Console](https://console.cloud.armory.io/deployments). 

1. Issue manual approvals.

   CD-as-a-Service deploys your resources to `staging`. After those resources have deployed successfully, CD-as-a-Service waits for your manual approval before deploying to `prod`.

   Once the `staging` deployment has completed, click **Approve** to allow the `prod` deployment to begin. Observe the traffic split and preview your web app deployment. Then issue your manual approval to finish deployment.

## How to watch from your terminal

If you want to monitor your deployment in your terminal, use the `--watch` flag to output deployment status.

```bash
armory deploy start  -f deployment.yaml --watch
```

Output is similar to:

```bash
[2023-05-24T13:43:35-05:00] Waiting for deployment to complete. Status UI: https://console.cloud.armory.io/deployments/pipeline/03fe43c6-ddc1-49d8-8116-b01db0ca0c5a?environmentId=82431eae-1244-4855-81bd-9a4bc165f90b
.
[2023-05-24T13:43:46-05:00] Deployment status changed: RUNNING
..
[2023-05-24T13:44:06-05:00] Deployment status changed: AWAITING_APPROVAL
...
[2023-05-24T13:44:36-05:00] Deployment status changed: RUNNING
..
[2023-05-24T13:44:56-05:00] Deployment status changed: AWAITING_APPROVAL
.
[2023-05-24T13:45:06-05:00] Deployment status changed: RUNNING
..
[2023-05-24T13:45:26-05:00] Deployment status changed: SUCCEEDED
[2023-05-24T13:45:26-05:00] Deployment 03fe43c6-ddc1-49d8-8116-b01db0ca0c5a completed with status: SUCCEEDED
[2023-05-24T13:45:26-05:00] Deployment ID: 03fe43c6-ddc1-49d8-8116-b01db0ca0c5a
[2023-05-24T13:45:26-05:00] See the deployment status UI: https://console.cloud.armory.io/deployments/pipeline/03fe43c6-ddc1-49d8-8116-b01db0ca0c5a?environmentId=82431eae-1244-4855-81bd-9a4bc165f90b

```

If you forget to add the `--watch` flag, you can run the `armory deploy status --deploymentID <deployment-id>` command. Use the Deployment ID returned by the `armory deploy start` command. For example:

```bash
armory deploy start -f deployment.yaml
Deployment ID: 9bfb67e9-41c1-41e8-b01f-e7ad6ab9d90e
See the deployment status UI: https://console.cloud.armory.io/deployments/pipeline/9bfb67e9-41c1-41e8-b01f-e7ad6ab9d90e?environmentId=82431eae-1244-4855-81bd-9a4bc165f90b
```

then run:

```bash
armory deploy status --deploymentId 9bfb67e9-41c1-41e8-b01f-e7ad6ab9d90e
```

Output is similar to:

   ```bash
application: sample-application, started: 2023-01-06T20:07:36Z
status: RUNNING
See the deployment status UI: https://console.cloud.armory.io/deployments/pipeline/9bfb67e9-41c1-41e8-b01f-e7ad6ab9d90e? environmentId=82431eae-1244-4855-81bd-9a4bc165f90b
```

This `armory deploy status` command returns a point-in-time status and exits. It does not watch the deployment.

>You must issue manual approvals using the UI. You cannot issue manual approvals using the CLI.

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "gh-action.md" >}}
* {{< linkWithTitle "cd-as-a-service/reference/ref-deployment-file.md" >}}
* {{< linkWithTitle "cd-as-a-service/troubleshooting/tools.md" >}}
* {{< linkWithTitle "add-context-variable.md" >}}
* {{< linkWithTitle "deploy-sample-app.md" >}}

