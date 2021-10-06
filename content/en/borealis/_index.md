---
title: "Project Borealis"
exclude_search: true
aliases:
  - /armory-deployments/
---
{{< include "early-access-feature.html" >}}
{{< include "armory-license.md" >}}

Project Borealis uses Armory's hosted cloud services to deploy Kubernetes applications to your Kubernetes clusters. When you execute a deploying through the Borealis CLI, it sends the deployment request to Armory's hosted cloud services. In turn, the cloud services communicate with your Kubernetes cluster using Armory's Remote Network Agent (RNA) to initiate the deployment. On your target cluster, the RNA works with Argo Rollouts to perform the actual deployment.

Borealis supports performing a canary deployment to deploy the app progressively to your cluster by setting percentage thresholds for the deployment. For example, you can deploy the new version of your app to 25% of your target cluster and then wait for a manual judgement or a configurable amount of time. This wait gives you time to assess the impact of your changes. From there, either continue the deployment to the next threshold you set or roll back the deployment.

The whole process can be done through the Borealis CLI directly or as part of tool you already use, such as invoking the Borealis CLI in a Jenkins file.