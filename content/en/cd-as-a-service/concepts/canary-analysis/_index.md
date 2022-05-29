---
title: Canary Concepts
linkTitle: Canary
description: >
  Learn how Armory Continuous Deployment-as-a-Service supports canary strategies.
exclude_search: true
draft: true
---

Armory CD-as-a-Service supports performing canary deployments. The canary deployment strategy deploys an app progressively to your cluster based on a set of steps that you configure. You set weights (percentage thresholds) for how the deployment should progress and a pause after each weight is met. Armory CD-as-a-Service works through these steps until your app is fully deployed. For example, you can deploy the new version of your app to 25% of your target cluster and then wait for a manual judgement or a configurable amount of time. This pause gives you time to assess the impact of your changes. From there, either continue the deployment to the next weight you set or roll back the deployment if you notice an issue.