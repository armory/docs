---
title: "Project Borealis"
exclude_search: true
aliases:
  - /armory-deployments/
---
{{< include "early-access-feature.html" >}}
{{< include "armory-license.md" >}}

Project Borealis uses Armory's hosted cloud services to deploy Kubernetes applications to your clusters. When you use the Borealis CLI to deploy your application, the CLI sends the deployment request to Armory's hosted cloud services. In turn, the cloud services communicate with your Kubernetes cluster using Armory's Remote Network Agent (RNA) to initiate the deployment. On your target cluster, the RNA works with Argo Rollouts to perform the actual deployment. For a more in-depth look at Borealis, see [Architecture]{{< ref "architecture-borealis" >}}.

As part of the early access program, Borealis supports performing a canary deployment. The canary deployment  deploys an app progressively to your cluster. You set weights (percentage thresholds) for the deployment and a pause after each weight is met. Borealis progresses through these steps until your app is fully deployed. For example, you can deploy the new version of your app to 25% of your target cluster and then wait for a manual judgement or a configurable amount of time. This pause gives you time to assess the impact of your changes. From there, either continue the deployment to the next weight you set or roll back the deployment if you notice an issue.

Using Borealis involves two parts:

1. Preparing your deployment target as described in [Get Started with Project Borealis]({{< ref "borealis-org-get-started" >}}). This ony needs to be done once per deployment target.
2. Using the Borealis CLI to deploy your app, either manually or programmatically.

You can do the whole deployment process using the Borealis CLI directly while you are working on defining how you want to deploy apps. When you're ready to scale, integrate Borealis with your existing tools (such as GitHub or Jenkins) to deploy programmatically. 

To start, review the [Requirements]{{< ref "borealis-requirements" >}}.
