---
title: Get Started with Blue/Green Deployment
linktitle: Blue/Green Deployment
description: >
  This guide walks you through how to deploy using a blue/green strategy.
weight: 40  
exclude_search: true
---

## Blue/Green deployment overview

A blue/green strategy shifts traffic from the running version of your software to a new version of your software. The Armory CD-as-a-Service blue/green strategy follows these steps:

1. Armory CD-as-a-Service deploys a new version of your software without exposing it to external traffic.
1. Armory CD-as-a-Service executes one or more user-defined steps in parallel. These steps are pre-conditions for exposing the new version of your software to traffic. For example, you may want to run automated metric analysis or wait for manual approval.
1. After all pre-conditions complete successfully, Armory CD-as-a-Service redirects all traffic to the new software version. At this stage of the deployment, the old version of your software is still running but is not receiving external traffic.
1. Next, Armory CD-as-a-Service executes one or more user-defined steps in parallel. These steps are pre-conditions for tearing down the old version of your software. For example, you may want to pause for an hour or wait for an additional automated metric analysis.
1. After all pre-conditions complete successfully, Armory CD-as-a-Service tears down the old version of your software.

## {{% heading "prereq" %}}

This quick start assumes that you completed the prior two quick starts that taught you how to register a cluster with Armory CD-as-a-Service and how to deploy an app with the CLI.

To complete this quick start, you need the following:

- Access to a Kubernetes cluster where you can install the Remote Network Agent (RNA). This cluster acts as the deployment target for the sample app. You can reuse the clusters from the previous quick starts if you want or stand up a new one.
- You need to deploy a [Kubernetes Service object](https://kubernetes.io/docs/concepts/services-networking/service/) that sends traffic to the current version of your application. This is the `trafficManagement.kubernetes.activeService` field in the YAML configuration.
- (Optional) You can also create a `previewService` Kubernetes Service object so you can programmatically or manually observe the new version of your software before exposing it to traffic via the `activeService`.

## Add blue/green to your deployment

1. In your deploy file, go to the `strategies` section.
1. Create a new strategy named `blue-green-deploy-strat` like the following:

   ```yaml
   strategies:
    blue-green-deploy-strat
      blueGreen:
        redirectTrafficAfter:
          - pause:
              untilApproved: true
        shutDownOldVersionAfter:
          - pause:
              untilApproved: true
   ```

   See the [Deployment File Reference]({{< ref "ref-deployment-file#bluegreen-fields" >}}) for an explanation of these fields.

   This strategy is configured to pause for manual judgment before redirecting traffic to your new app version as well as before shutting down your old version. You could instead choose to pause for a duration of time.

1. Change the value of `targets.<targetName>.strategy` for one or more of your deployment targets to `blue-green-deploy-strat`.

   ```yaml
   ...
   targets:
    <targetName>:
      account: <agentIdentifier>
      namespace: <namespace>
      strategy: blue-green-deploy-strat
    ...
    ```
1. Create a traffic management configuration for your `activeService` and `previewService`:

   ```yaml
   ...
   trafficManagement:
     - targets: ['<targetName>']
       kubernetes:
         - activeService: myAppActiveService
           previewService: myAppPreviewService
   ...
   ```
   
   The values for `activeService` and `previewService` must match the names of the Kubernetes Service objects you created to route traffic to the current and preview versions of your application.

1. Save the file

## Redeploy your app

Make a change to your app, such as the number of replicas, and redeploy it with the CLI:

```bash
armory deploy start  -f <your-deploy-file>.yaml
```

Monitor the progress and **Approve & Continue** or **Roll back** the blue/green deployment in the UI.



