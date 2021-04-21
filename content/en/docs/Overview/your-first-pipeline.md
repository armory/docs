---
linkTitle: "Your First Pipeline"
title: "Your First Pipeline in Spinnaker"
weight: 35
description: >
  Create your first pipeline, which bakes an Amazon Machine Image (AMI).
---

## What is a pipeline in Spinnaker?

The pipeline is the key deployment management construct in Spinnaker™. It consists of a sequence of actions, known as stages. You can pass parameters from stage to stage along the pipeline.

You can start a pipeline manually, or you can configure it to be automatically triggered by an event, such as a Jenkins job completing, a new Docker image appearing in your registry, a CRON schedule, or a stage in another pipeline.

## Prerequisites:

- A Jenkins Master configured by your administrator
- A Jenkins job that archives a Debian package
- A security group within AWS with appropriate permissions
- A Load Balancer

## How to create a pipeline

In this example we will create a pipeline that takes the Debian package produced by a Jenkins job and uses it to create an [Amazon Machine Image (AMI)](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html) before deploying that image to a server group.

1. After selecting your Application, click the Pipelines category.

   ![An empty Pipelines view](/images/overview/your-first-pipeline/empty-pipelines.png)

1. On this page, click **Configure a new pipeline**.

1. Provide a name for your new pipeline and click **{{< icon "check-circle" >}} Create**.

1. On the Pipeline page you will see:

   - A visual representation of your pipeline and its stages (you should only have configurations at the beginning)
   - Execution Options
   - Automated Triggers
   - Parameters
   - Notifications
   - Description

   ![A new pipeline](/images/overview/your-first-pipeline/first-pipeline-view.png)

### Add a trigger

1. Define how your pipeline will be triggered. Scroll down to the **Automated Triggers** section and click **{{< icon "plus-circle" >}} Add Trigger**. This section will allow you to select a Type:

   ![Automated Trigger Types](/images/overview/your-first-pipeline/automated-trigger-types.png)

1. For this example we will select Jenkins. By adding a trigger we are defining how our pipeline will be initiated.

   ![A new Jenkins trigger](/images/overview/your-first-pipeline/jenkins-trigger.png)

   **Note:** The Property File is an important topic that will be covered in a [separate guide]({{< ref "working-with-jenkins#property-file" >}}).

1. Before you test your pipeline, you may want to consider enabling or disabling the trigger via the checkbox at the bottom.

### Add a Bake stage

1. Now we add our first stage: Baking an AMI. Click the **{{< icon "plus-circle" >}} Add stage** button in the visual representations section:

   ![Pipeline visual representation, with only a config added](/images/overview/your-first-pipeline/pipeline-config-only.png)

1. Select Bake from the different Types category.

   ![The stage type menu, selecting "Bake"](/images/overview/your-first-pipeline/add-bake-stage.png)

1. Select Amazon from the Provider list (if multiple providers are configured), then the region you want to bake in. Enter the name of the package that was archived by the Jenkins job.

   - The package name should not include any version numbers. (e.g.: If your build produces a deb file named “myapp_1.27-h343”, you would want to enter “myapp” here.)
   - If you would like to configure your own Base AMI under the Advanced Options, the Base OS configuration will be ignored.

   ![Bake configuration for an AMI image](/images/overview/your-first-pipeline/bake-ami-config.png)

### Add a Deploy stage

1. Now add a Deploy stage by clicking **{{< icon "plus-circle" >}} Add stage** again. In the Type category select Deploy. Deploy’s configuration settings should pop up on the screen.

   ![Add a Deploy stage to the Pipeline](/images/overview/your-first-pipeline/add-deploy-stage.png)

   **Note:** If we want to reorganize the order that the stages execute in the pipeline, we can add or remove precursor stages in the Depends On category.

1. In the Deploy Configuration, click on the “Add server group” button. Pick your provider, if more than one is configured. For our example it will be AWS.

1. Because this is a new application we will not choose to copy a configuration from a template. Select “Continue without a template”.

   ![Template selection for deployment server group](/images/overview/your-first-pipeline/continue-without-template.png)

1. It's important to set up the correct Deploy Strategy for your use case. We will use the Highlander strategy for this example, which will ensure that only one server group for our application exists at a time.

   ![The Highlander method under Strategy](/images/overview/your-first-pipeline/deploy-strategy.png)

1. From the Load Balancer list, select one that we’ve created beforehand.

1. Select a security group that you are comfortable with, which will define the access rights to your resource.

1. Select Instance Type as Micro Utility, then set the size as “small”.

1. For Capacity, select how many instances you want in your server group. For our example, we will set it at 1.

   ![Capacity options](/images/overview/your-first-pipeline/deploy-capacity.png)

1. Click “add”. You will be brought back to your Application and see a new Deploy Configuration. Press “Save Changes” at the bottom right of your window.

   ![An overview of a newly configured Deployment stage](/images/overview/your-first-pipeline/new-deployment-overview.png)

## Execute the Pipeline

1. Click on the Pipelines option. You should see your new pipeline. Click on **{{< icon "play" >}} Start Manual Execution**.

   ![Highlighting the Start Manual Execution option](/images/overview/your-first-pipeline/start-manual-execution.png)

1. You will be able to select a Build for your Jenkins job from a drop down menu. By default, Spinnaker will not recreate an AMI unless the underlying package has changed. If you would like to force it, you may use the checkbox for “Rebake”.

   ![Selecting a build for manual deployment](/images/overview/your-first-pipeline/select-build.png)

1. Press “Run”, and you should see a progress bar where blue represents running and green represents complete. Gray represents not ran or canceled, which is not in our example picture.

   ![A manual execution in progress](/images/overview/your-first-pipeline/job-in-progress.png)

   If your pipeline does not succeed, refer to one of the troubleshooting sections in the [pipelines]({{< ref "pipelines#troubleshooting" >}}), [baking]({{< ref "aws-baking-images#troubleshooting" >}}), or [deploying]({{< ref "aws-deploy#common-errors-and-troubleshooting" >}}) guides.

> Note: Always remember to save your changes by clicking the button in the bottom right of the window.
