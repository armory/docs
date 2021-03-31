---
title: Configure Applications and Pipelines
linkTitle: "Configure"
description: "Configure your Proof-of-concept pipelines."
weight: 3
---

## Deploy a demo app

Under **Applications**, click on **armory-samples**, then **PIPELINES** from the left-hand menu. There are several integrations pipelines and a single deployment pipeline for you to try out. For now, look to the "basic-deploy-to-kubernetes" pipeline.

This proof of concept pipeline deploys an nginx app to the k3s cluster. Remember that this configuration is only for demo purposes; unless you've deployed Minnaker on an existing k8s cluster all services and apps will  live on the same host, which is not reliable.

1. Click **{{< icon "play" >}} Start Manual Execution**, then **{{< icon "check-circle" >}} Run**. The pipeline has two stages, which you can see by clicking on {{< icon "chevron-right" >}} next to the pipeline.

1. The first stage is a [manual judgment](https://spinnaker.io/guides/tutorials/codelabs/safe-deployments/#adding-a-manual-judgment-to-deployment-pipelines). The process will not continue until you confirm the judgement. Hover over the running task, then click **Continue**:

    ![The manual judgment overlay in a pipeline](/images/overview/demo/ManualJudgment.png)

1. The second stage in the pipeline will depoloy the app to the cluster, based on a provided [Kubernetes Manifest](https://spinnaker.io/guides/user/kubernetes-v2/deploy-manifest/). You can click on the progress bar to see the status:

    ![Details of the deploy stage](/images/overview/demo/DeployManifest.png)

1. Once complete, you can confirm the presence of the service by clicking **{{< icon "th" >}} CLUSTERS** from the left-hand menu:

    ![The Clusters page showing the deployed service](/images/overview/demo/ViewClusters.png)

## Access the deployed app

Remember that in this demo, the production environment is in a k3s cluster running from the same host as Minnaker. In a standard production environment, the app would be accessible via an [Ingress controller](https://kubernetes.io/docs/concepts/services-networking/ingress/) [Load Balancer](https://kubernetes.io/docs/concepts/services-networking/service/#loadbalancer), etc. In order to see our demo app, use a [NodePort](https://kubernetes.io/docs/concepts/services-networking/service/#nodeport) service to expose the app at port 30080.

1. Click **{{< icon "cog" >}} Configure** on the "basic-deploy-to-kubernetes" pipeline. 

1. Select the **Deploy text manifest** stage to view the manifest text:

    ![Configuration of the "Deploy text manifest" stage](/images/overview/demo/PipelineConfiguration.png)

1. Add the following NodePort service definition to the manifest. You can add it above or below the existing content, as long as there is a divider (`---`) in between:

    ```yml
    service definition goes here
    ```