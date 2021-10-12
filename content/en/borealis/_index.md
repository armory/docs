---
title: "Project Borealis"
exclude_search: true
aliases:
  - /armory-deployments/
---
{{< include "early-access-feature.html" >}}
{{< include "armory-license.md" >}}

Project Borealis uses Armory's hosted cloud services to deploy Kubernetes applications to your clusters. When you execute a deploying through the Borealis CLI, it sends the deployment request to Armory's hosted cloud services. In turn, the cloud services communicate with your Kubernetes cluster using Armory's Remote Network Agent (RNA) to initiate the deployment. On your target cluster, the RNA works with Argo Rollouts to perform the actual deployment.

As part of the early access program, Borealis supports performing a canary deployment. The canary deployment  deploys an app progressively to your cluster. You set weights (percentage thresholds) for the deployment and a pause after each weight is met. Borealis progresses through these steps until your app is fully deployed. For example, you can deploy the new version of your app to 25% of your target cluster and then wait for a manual judgement or a configurable amount of time. This pause gives you time to assess the impact of your changes. From there, either continue the deployment to the next weight you set or roll back the deployment if you notice an issue.

The whole process can be done through the Borealis CLI directly or as part of tool you already use, such as invoking the Borealis CLI in a Jenkins pipeline.