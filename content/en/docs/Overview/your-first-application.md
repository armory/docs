---
title: "Your First Application in Spinnaker"
linkTitle: Your First Application
weight: 30
description: >
  Create an application in Spinnaker.
---

## What is an application in Spinnaker?

Spinnaker™ is organized around the concept of applications. An application in Spinnaker is a collection of clusters, which in turn are collections of server groups. The application also includes firewalls and load balancers.

An application represents the service which you are going to deploy using Spinnaker, all configuration for that service, and all the infrastructure on which it will run.

## The Spinnaker landing page

When you first log in to Spinnaker, the landing page should look like this:

![](/images/Image-2017-03-24-at-3.15.34-PM.png)

The navigation bar at the top allows you to access Projects, Applications, and
Infrastructure. The search bar allows you to search through your Infrastructure.
(this search bar will find everything in all of your AWS Infrastructure)

Spinnaker should scan all of your infrastructure and create applications for
anything that it finds. If you enter an application this way that was not
configured by Spinnaker, it should state that the application has not been
configured.

Note: The naming convention that you have been using is not necessarily the same one that Spinnaker uses, but accessing your applications through Spinnaker should allow you to configure it to your preferences.
Remember that Spinnaker considers an application to be anything you would put into a single code repository.


## Making an application

**Step 1:** Enter Applications from your Navigation bar.

**Step 2:** Click the “Actions” button and select from the drop-down menu “Create Application”

![](/images/Image-2017-03-24-at-3.20.41-PM.png)

**Step 3:** Fill out the pop-up form with desired user definitions.

![](/images/Image-2017-03-24-at-3.22.30-PM.png)

Notes:
-  The name of the application cannot have hyphens. Using a hyphen in the application name interferes with the naming convention. This applies to all types of applications except for those that use the Kubernetes V2 provider to deploy.
- The Account(s) can include your AWS account and your Docker registry.
- When you create an application in Spinnaker, consider it to be anything you would put into a single code repository.

**Step 4:** After you fill out the form you should see this:

![](/images/Image-2017-03-24-at-3.26.40-PM.png)

**Step 5:** If you wish to modify the settings for the application, click on “Config” for configurations.

Note that by now you should have created an application, but as you have not created a pipeline and executed it, nothing should show up yet.


## Deleting an application

Go to your application, click on “Config” and scroll all the way down. There will be a prompt to confirm if you would like to delete your application.

![](/images/Image-2017-03-24-at-3.28.14-PM.png)
