---
title: "Load Balancers"
summary: "Load balancers are one of the basic concepts in Spinnaker."
linkTitle: "Load Balancers"
---

A Load Balancer is associated with an ingress protocol and port range. It balances traffic among instances in its Server Groups. Optionally, you can enable health checks for a load balancer, with flexibility to define health criteria and specify the health check endpoint.

## Requirements

- Before you create a Load Balancer, your Security Group will already need to exist.


## Create a Load Balancer

Step 1: After you select your Application, click on the Load Balancers tab.

Step 2: Click the “Create Load Balancer” button.

![](/images/Image 2017-03-24 at 4.50.37 PM.png)

Step 3: The Stack and Detail should be kept in mind when creating the pipeline because the pipeline’s deployment of server group should be using the same Stack and Detail.


## Delete a Load Balancer

Note: You can only delete Load Balancers if they do not have any instances attached to them.

Step 1: Go to your Load Balancers in your Applications.

Step 2: Select a Load Balancer, then to the right a column with the Load Balancer’s details should appear. Select the drop down menu and press “Delete”.

![](/images/Image 2017-03-24 at 4.56.31 PM.png)
