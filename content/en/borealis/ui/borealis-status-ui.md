---
title: Armory Deployments Status UI
linkTitle: Status UI
description: >
  Monitor the status of your deployments and approve or rollback deployments.

---


## Deployment Status UI

When you navigate to the **Armory Deployments** tab of the UI, you land on the **All Deployments** page, which shows all the apps for a specific Armory Cloud environment. If you don't see a deployment that you're expecting to see, refresh the list or verify the Armory Cloud environment the app belongs to. You can switch environments in the top right menu by clicking on your username. 

On the **All Deployments** page, you can select a specific app to get more details on that app's deployments. This brings up a status pane with basic information that includes the following: 

- Who started the most recent deployment for an app
- When the deployment started
- Deployment health
- Progress and status for the deployment, such as if it is waiting for approval
 
Select **See Full Details** from the status pane on the **All Deployments**, you arrive on the **All Environments** page, which shows all the environments that are part of that deploy file. If a deploy file only contains one environment, you'll only see one on this page.   

You can watch a [demo](https://s.armory.io/BludOJBo) of how the All Deployments page and the details page for a single environment work together to walk you through progressing your deployment.

### All environments

The **All Deployments** page shows you all environments that are being deployed to in a single deploy file. If you click the link that the CLI returns when you trigger the deployment, this is the page you are linked to. It can give you a general idea of the state of the deployment and what environment is currently being deployed to.

{{< figure src="/images/borealis/borealis-multitarget-deploy.jpg" alt="The deployment starts in a dev environment. It then progresses to infosec and staging environments simultaneously. It finishes by deploying to a prod-west environment." >}}

More specifically, this view shows you how deployments are supposed to progress through different environments based on the constraints that are defined in the deploy file. An environment that is waiting for one or more constraints to be satisfied is connected to the preceding deployment by a dotted line and is greyed out.

{{< figure src="/images/borealis/borealis-ui-constraints.jpg" alt="The staging-west environment has constraints that prevent it from starting until they are satisfied." >}}

Clicking on a specific environment brings up a status pane with basic information about that environment. From here, you can see the **Full Details** for that single environment where you can take additional action.

### Single environment

The **Full Details** page for a single environment is where you monitor the progress of the deployment to that environment. If the strategy you specified involves user input, such as a manual approval, this is the page where you can approve or rollback the deployment.

{{< figure src="/images/borealis/borealis-ui-fulldetails.jpg" >}}
