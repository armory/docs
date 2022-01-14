---
title: Borealis Status UI
linktitle: Status UI
description: >
  Use the Borealis Status UI to interact with and monitor your app deployments, including approving next steps or performing rollbacks.
exclude_search: true
weight: 40
---

The Status UI provides an overview of all the deployments you have access to and their status at a glance. When you select a deployment, you're shown more granular details, such as when the deployment started and who started it.

There are a few main screens in the Status UI that can help orient you:

## 

**All Deployments** shows every single deployment for a specific Armory Cloud environment. (Switch environments in the top right menu by clicking on your username.) 

You can select a specific app to get more details on that app's deployment. This brings up an **Overview** status pane with basic information that includes the following: 

- who started the deploy
- when the deploy started
- health
- status, such as if it is waiting for approval
 
You can get more details and approve or rollback the deployment by selecting **See Full Details ->**.



## Monitor and approve deployments

The **Full Details* page is where you can monitor the progress of your app. If the strategy a deployment uses involves a manual approval, this is the page where you can approve or rollback the deployment.

{{< figure src="static/images/borealis/borealis-ui-fulldetails.jpg" >}}