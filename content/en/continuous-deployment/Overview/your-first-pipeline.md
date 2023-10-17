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

## {{% heading "prereq" %}}

This page assumes your application stack includes:

- A Jenkins Master configured by your administrator
- A Jenkins job that archives a Debian package
- A security group within AWS with appropriate permissions
- A [Load Balancer]({{< ref "load-balancers" >}})

## How to create a pipeline

This example creates a pipeline that takes the Debian package produced by a Jenkins job and uses it to create an [Amazon Machine Image (AMI)](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html) before deploying that image to a server group.

1. After selecting your Application, click the Pipelines category.

   {{< figure src="/images/overview/your-first-pipeline/empty-pipelines.png" >}}

1. On this page, click **Configure a new pipeline**.

1. Provide a name for your new pipeline and click **{{< icon "check-circle" >}} Create**.

1. On the Pipeline page you should see:

   - A visual representation of your pipeline and its stages (you should only have configurations at the beginning)
   - Execution Options
   - Automated Triggers
   - Parameters
   - Notifications
   - Description

   {{< figure src="/images/overview/your-first-pipeline/first-pipeline-view.png" >}}

### Add a trigger

1. Define how your pipeline is triggered. Scroll down to the **Automated Triggers** section and click **{{< icon "plus-circle" >}} Add Trigger**. This section enables you to select a **Type**:

   {{< figure src="/images/overview/your-first-pipeline/automated-trigger-types.png" >}}

1. For this example, select Jenkins. By adding a trigger, you are defining how your pipeline is initialized.

   {{< figure src="/images/overview/your-first-pipeline/jenkins-trigger.png" >}}

   **Note:** **Property File** is an important topic that will be covered in a [separate guide]({{< ref "working-with-jenkins#property-file" >}}).

1. Before you test your pipeline, you may want to consider enabling or disabling the trigger via the checkbox at the bottom.

### Add a Bake stage

1. Now add your first stage: Baking an AMI. Click the **{{< icon "plus-circle" >}} Add stage** button in the visual representations section:

   {{< figure src="/images/overview/your-first-pipeline/pipeline-config-only.png" >}}

1. Select **Bake** from the **Types** drop down list.

   {{< figure src="/images/overview/your-first-pipeline/add-bake-stage.png" >}}

1. If you have multiple providers configured, select **Amazon** from the **Provider** drop down list. Next select the region or regions you want to bake in. In the **Package** field, enter the name of the package that your Jenkins job archived.

   - The package name should not include any version numbers. For example, if your build produces a deb file named “myapp_1.27-h343”, you would enter “myapp” here.
   - If you configure your own Base AMI under the Advanced Options, the Base OS configuration is ignored.

   {{< figure src="/images/overview/your-first-pipeline/bake-ami-config.png" >}}

### Add a Deploy stage

1. Now add a Deploy stage by clicking **{{< icon "plus-circle" >}} Add stage** again. Select **Deploy** In the **Type** drop down list. Deploy’s configuration settings should pop up on the screen.

   {{< figure src="/images/overview/your-first-pipeline/add-deploy-stage.png" >}}

   **Note:** If you want to reorganize the order that the stages execute in the pipeline, you can add or remove precursor stages in the **Depends On** field.

1. In the **Deploy Configuration** section, click on the “Add server group” button. Pick your provider, if more than one is configured. This example uses AWS.

1. Because this is a new application, do not choose to copy a configuration from a template. Press the **Continue without a template** button.

   {{< figure src="/images/overview/your-first-pipeline/continue-without-template.png" >}}

1. It's important to set up the correct Deploy Strategy for your use case. Use the Highlander strategy for this example, which will ensure that only one server group for your application exists at a time.

   {{< figure src="/images/overview/your-first-pipeline/deploy-strategy.png" >}}

1. In the **Load Balancers** section, select the load balancer you created before you began this tutorial.

1. Select a security group that you are comfortable with, which will define the access rights to your resource.

1. Select Instance Type as Micro Utility, then set the size as “small”.

1. For Capacity, select how many instances you want in your server group. For our example, we will set it at 1.

   {{< figure src="/images/overview/your-first-pipeline/deploy-capacity.png" >}}

1. Click “add”. You will be brought back to your Application and see a new Deploy Configuration. Press “Save Changes” at the bottom right of your window.

   {{< figure src="/images/overview/your-first-pipeline/new-deployment-overview.png" >}}

## Execute the Pipeline

1. Click on the Pipelines option. You should see your new pipeline. Click on **{{< icon "play" >}} Start Manual Execution**.

   {{< figure src="/images/overview/your-first-pipeline/start-manual-execution.png" >}}

1. You will be able to select a Build for your Jenkins job from a drop down menu. By default, Spinnaker will not recreate an AMI unless the underlying package has changed. If you would like to force it, you may use the checkbox for “Rebake”.

   {{< figure src="/images/overview/your-first-pipeline/select-build.png" >}}

1. Press “Run”, and you should see a progress bar where blue represents running and green represents complete. Gray represents not ran or canceled, which is not in our example picture.

   {{< figure src="/images/overview/your-first-pipeline/job-in-progress.png" >}}

   If your pipeline does not succeed, refer to one of the troubleshooting sections in the [pipelines]({{< ref "spin-pipelines#troubleshooting" >}}), [baking]({{< ref "aws-baking-images#troubleshooting" >}}), or [deploying]({{< ref "aws-deploy#common-errors-and-troubleshooting" >}}) guides.

> Note: Always remember to save your changes by clicking the button in the bottom right of the window.
