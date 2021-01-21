---
title: Working with Jenkins in Spinnaker
linkTitle: Working with Jenkins
aliases:
  - /user-guides/working-with-jenkins/
  - /user-guides/working_with_jenkins/
  - /user_guides/working-with-jenkins/
  - /user_guides/working_with_jenkins/
  - /spinnaker_user_guides/working_with_jenkins/
  - /spinnaker_user_guides/working-with-jenkins/
  - /spinnaker-user-guides/working_with_jenkins/
description: >
  Learn how to use Jenkins in your Spinnaker pipelines.
---

## Triggering a pipeline with Jenkins

> Before you start, you'll need to [configure
Jenkins](/docs/spinnaker-install-admin-guides/jenkins/). If you don't see
Jenkins as an option, or you're not seeing the correct master/job combination
in the UI, you'll need to double-check your Spinnaker is configured to use
that resource.

To add a Jenkins trigger to your pipeline, go to your configurations stage and select "add trigger", then select "Jenkins" from the Type dropdown menu. Select a Master from the Master category list and then select a Job to trigger from the pipeline.

![](/images/Image-2017-03-27-at-4.47.35-PM.png)

Note: Make sure you archive your package files and your properties file in Jenkins.

### Property File

The property file is a way to transfer information about your build from Jenkins to Spinnaker. The file needs to be archived by the Jenkins job and should contain key value pairs.

As an example, if you had your Jenkins job create and archive a file named `build.properties` which looks like:

```bash
COMMITER_NAME=andrew
BRANCH_NAME=mybranch
CONFIG=config-3059cad.tar.gz
```

Then in the property files field in the Spinnaker Jenkins trigger, fill it in with `build.properties`.


Now that those variables are in Spinnaker, we can access them elsewhere in our pipeline by using the built-in Spinnaker expression language.


In any given stage we can use the expression `${ trigger.properties['BRANCH_NAME']}` to access the property value of the variable named `BRANCH_NAME`.


Note: For more elaborate instructions on expression language, please refer to the [Spinnaker Expression Language Guide]({{< ref "expression-language" >}}).


## How to trigger a Jenkins job through Spinnaker


Step 1: In pipelines, click on 'Add stage'.


Step 2: Select 'Jenkins' from Type. Name the Stage Name and Depends On if you need it.


Step 3: Configure your Master and Job. If your Job is parameterized then Spinnaker will display a Parameters form for your input.


Step 4: The Property File input works the same way as above - however you **cannot** use the same expression above to access it. Instead, you would access it with `${ #stage('Jenkins')['context']['BRANCH_NAME'] }`, supposing you wanted to access the `BRANCH_NAME` variable.


### Example


In this example, we will create a pipeline with a Jenkin's job stage and a manual judgement that repeats back the value of a property in a properties file from the Jenkins' job.

First we navigate to my Jenkins Master and create a new Jenkins 2.0 Pipeline Job. As you can see in the image below, this job creates and archives a file named `build.properties` which contains the key value pair `KEY=VAL`.

![](/images/Image-2017-03-27-at-5.20.02-PM.png)

Then we go back to Spinnaker and create a new pipeline. We will skip over the Jenkins trigger for this example and create a Jenkins stage. Make sure to name the stage `Jenkins`. Make sure to type `build.properties` into the Properties field so that Spinnaker know where to source the property values.

![](/images/Image-2017-03-27-at-5.21.05-PM.png)

To demonstrate accessing our properties file, let's create a new `Manual Judgement` stage. In the Instructions text box input:

```bash
{ #stage('Jenkins')['context']['KEY'] }
```

Spinnaker has added the key value pairs from `build.properties` in the Jenkins' job to the context of the Jenkins stage. The above expression allows us to access that information.

Don't forget to press the save button in the lower right corner. Your pipeline configuration should look like:

![](/images/Image-2017-03-28-at-2.04.43-PM.png)

Finally, navigate back to the pipeline execution screen an start a manual execution of the pipeline you just configured.

When the execution gets to the manual judgement stage, you should see the word `VAL` in the intructions text area.

![](/images/Image-2017-03-28-at-2.06.45-PM.png)

## Running scripts on Spinnaker

You can also run arbitrary scripts on Spinnaker (behind the scenes it is pushing this work off to a Jenkins master). Simply select the `Script` type stage while configuring a pipeline. You should see a screen like:

![](/images/Image-2017-03-28-at-2.10.26-PM.png)
