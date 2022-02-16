---
linkTitle: Load Balancers
title: Load Balancers in Spinnaker
weight: 25
description: Learn how to control ingress in Spinnaker with load balancers.
---

## What is a load balancer?

A load balancer is associated with an ingress protocol and port range. It balances traffic among instances in its server groups. Optionally, you can enable health checks for a load balancer, with flexibility to define health criteria and specify the health check endpoint.

## Requirements

- Before you create a load balancer, your Security Group will already need to exist.

## Create a load balancer

Step 1: After you select your Application, click on the Load Balancers tab.

Step 2: Click the "Create Load Balancer" button.

![Highlight the "Create Load Balancer" button](/images/overview/create-load-balancer.png)

Step 3: The Stack and Detail should be kept in mind when creating the pipeline because the pipeline's deployment of server group should be using the same Stack and Detail.

## Delete a load balancer

Note: You can only delete Load Balancers if they do not have any instances attached to them.

Step 1: Go to your Load Balancers in your Applications.

Step 2: Select a Load Balancer, then to the right a column with the Load Balancer's details should appear. Select the drop down menu and press "Delete".

![Highlight the "Delete" option for a load balancer](/images/overview/delete-load-balancer.png)
