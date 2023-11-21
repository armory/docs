---
title: Bake Amazon Machine Images in a Spinnaker Pipeline
linkTitle: Bake an AMI
description: >
  Create a pipeline that bakes an Amazon Machine Image (AMI).
aliases:
  - /spinnaker_user_guides/baking/
  - /user-guides/baking-images/
  - /user-guides/baking_images/
  - /user_guides/baking-images/
  - /user_guides/baking_images/
  - /spinnaker_user_guides/baking_images/
  - /spinnaker_user_guides/baking-images/
  - /spinnaker-user-guides/baking_images/
  - /docs/spinnaker-user-guides/baking-images/
---

>The phrase "baking images" is used within Armory and Spinnaker<sup>TM</sup> to refer to the process of creating machine images.

## Prerequisites for baking AMIs

- You are familiar with creating [applications]({{< ref "your-first-application" >}}) and [pipelines]({{< ref "your-first-pipeline" >}}).
- You are deploying to Amazon Web Services (AWS).
- You have configured Armory to work with Jenkins. See the {{< linkWithTitle working-with-jenkins.md >}} guide for more information.
- You are familiar with Debian packages. See the {{< linkWithTitle debian-packages.md >}} guide for more information.


## Example of how to bake an AMI in a pipeline

In this example, you bake an image containing a Debian package created by a Jenkins job.

First, look at the the Jenkins job that builds our package.

{{< figure src="/images/user-guides/aws/Image-2017-03-29-at-12.43.31-PM.png" >}}

The last run archived a package named `armory-hello-deploy_0.5.0-h5.c4baff4_all.deb`


In Armory, create a new pipeline named `bake-example`.

On the configuration stage, down and add a new Jenkins automated trigger. Select my master, and then select the Jenkins job shown above (`armory/job/armory-hello-deploy/job/master`). For this example, there is no need to worry about setting a properties file.

Next I add a bake stage (add stage -> Type: Bake)

Select the `us-west-2` region. For the Package field, I enter the base name of my package. In my case, the entire package filename is `armory-hello-deploy_0.5.0-h5.c4baff4_all.deb` so I will input `armory-hello-deploy`. Also, I know that my package is created for Ubuntu 14, so I make sure to select the 'trusty (v14.04)' option.

{{< figure src="/images/Image-2017-03-29-at-1.35.13-PM.png" >}}

like:

{{< figure src="/images/Image-2017-03-29-at-1.45.09-PM.png" >}}

At this point if I want to see more details about my bake, I can click the 'View Bakery Details' box. A new window will open up with the bakery logs. In my case, the first few lines look like:

```bash
==> amazon-ebs: Prevalidating AMI Name...
    amazon-ebs: Found Image ID: ami-3d50120d
==> amazon-ebs: Creating temporary keypair: packer_58dc1ccb-b936-7104-ebe0-0984e888ca78
==> amazon-ebs: Creating temporary security group for this instance...
==> amazon-ebs: Authorizing access to port 22 the temporary security group...
==> amazon-ebs: Launching a source AWS instance...
    amazon-ebs: Instance ID: i-08327d863d1911675
==> amazon-ebs: Waiting for instance (i-08327d863d1911675) to become ready...
==> amazon-ebs: Adding tags to source instance
==> amazon-ebs: Waiting for SSH to become available...
==> amazon-ebs: Connected to SSH!
==> amazon-ebs: Pausing 30s before the next provisioner...
==> amazon-ebs: Provisioning with shell script: /opt/spinnaker/config/packer/install_packages_armory.sh
    amazon-ebs: repository=
    amazon-ebs: package_type=deb
    amazon-ebs: packages=armory-hello-deploy=0.5.0-h5.c4baff4
...
```

Under the hood, Spinnaker is leveraging [HashiCorp's Packer](https://www.packer.io/) tool to create images. The above is a Packer log file.

The thing I wanted to point out here is that the correct version of the package is getting passed down to the bakery.


After the bake is successful, I see:

{{< figure src="/images/Image-2017-03-29-at-1.49.44-PM.png" >}}


Notice that the AMI name and ID are shared in the lower right's blue box - in this example it is "armory-hello-deploy-all-20170329204459-trusty (ami-c78410a7)".


If I press 'Start Manual Execution' again, since the package version hasn't changed, it will reuse the same image rather than rebaking. The screen for that looks like:

{{< figure src="/images/Image-2017-03-29-at-1.55.52-PM.png" >}}

Notice the whole pipeline only ran for '00:00' and the UI says 'No changes detected; reused existing bake'

## Advanced options for baking AMIs

You can do additional things like use a specific base AMI, specify your baked AMI's name, use a custom packer script, or pass variables to a packer script.

If you would like to change the name in AWS of your AMI, you can do so by selecting the 'Show Advanced Options' checkbox in the Bake Stage Configuration. Continuing from our example above, when I see:

{{< figure src="/images/Image-2017-03-29-at-2.29.08-PM.png" >}}

What do all of these fields mean? Great question!


### Changing an AMI's name

If I were to instead input 'mycustomname' into the 'AMI Name' field, like:

{{< figure src="/images/Image-2017-03-29-at-2.55.24-PM.png" >}}

After re-running the pipeline, I see that Spinnaker named the AMI `mycustomname-all-20170329220104-trusty`

{{< figure src="/images/Image-2017-03-29-at-3.05.57-PM.png" >}}

Then I add 'mycustomsuffix' to the 'AMI Suffix' field:

{{< figure src="/images/Image-2017-03-29-at-3.14.07-PM.png" >}}

Repeating the bake, I see that Spinnaker named the AMI `mycustomname-all-mycustomsuffix-trusty`

### Base AMIs

Often you will want to specify a base image for use in your bake. In that case you will use the 'Base AMI' field, not to be confused with the 'Base Name' field. As an example, I have specified `ami-4d78c02d`:

{{< figure src="/images/Image-2017-03-29-at-4.06.24-PM.png" >}}


In this situation, the base OS selection (ubuntu/trusty/windows) will be ignored.

You can also select a base AMI more dynamically by combing the 'Bake' stage type with the 'Find Image' stage type. For more details check out the [Find Images Guide]({{< ref "aws-find-images" >}}).


### Adding Debian repositories

It is common practice to use a base image throughout your team or organization. Usually this base image will be kept up to date with security patches and will contain common tools (DataDog, Splunk, etc.). It is also a good place to register your Debian repository's GPG keys.

If you need to add repositories on a per bake basis, you can use the 'Extended Attributes' within the 'Advanced Options' section. You can add a key/value pair where the key is labeled 'repository' and the value is a space separated list of repository URLs. For example:

{{< figure src="/images/Image-2017-04-17-at-10.41.20-AM.png" >}}

This will add Armory's bintray debian repository to the bake.

## Regions

By selecting a region, you are selecting which region the bake will take place. When a bake happens, an instance is spun up, the desired packages are installed, and then a snapshot is taken. The location where the instances spin up is determined by which region you select. Multiple regions may be selected at once.

## Rebaking

When a bake step executes, Spinnaker looks for a previously created image before baking a new one. It uses the set of packages (and their versions) that users specify in the bake stage configuration to determine if the bake is neccessary.

You can force Spinnaker to always bake by selecting the 'Rebake: Rebake image without regard to the status of any existing bake' checkbox on the bake stage configuration screen. You also have the option to force rebaking when manually executing a pipeline.


## Bake and copy vs multi-region bake

There are two options for getting an image to multiple regions in AWS. A common practice outside of Spinnaker is to create your AMI and then copy it to the regions you need. However, Spinnaker by default will do a multi-region bake. This means if you select more than one region it will go through the process of creating an image in each region (spin up an instance, install the packages, etc).

There are trade-offs to each approach. Generally, Spinnaker's default multi-region bake approach is faster than the bake and copy approach. However, if you need to limit all baking activities to one region then there isn't much of a choice.


## Custom bake scripts

If you would like to use a custom Packer script to bake your AMI you will need to contact your Spinnaker Administrator. The script will have to be installed on your Spinnaker instances.

## Caching bakes

Spinnaker will cache bakes and not re-run a bake to save time if it finds the bake key in its cache.
When Spinnaker bakes a package it creates a unique key based on the following components:
Cloud Provider Type, Base OS, Base AMI, AMI Name, Packer Template Filename, Var Filename, Package Name and Package Version. If any of those components change at the time of bake it will rebake otherwise it'll use the cached AMI.

#### Package name and version

By default, Spinnaker looks for an artifact from the Jenkins build that triggered the bake to [parse out version information](https://github.com/spinnaker/rosco/blob/ddd6ed4689b8a769e4b7331acdca2c0ba1b29a66/rosco-core/src/main/groovy/com/netflix/spinnaker/rosco/providers/util/PackageNameConverter.groovy#L54).  Below are valid names to packages:

```
subscriberha-1.0.0-h150
subscriberha-1.0.0-h150.586499
subscriberha-1.0.0-h150.586499/WE-WAPP-subscriberha/150
```

This allows you to just specify `subscriberha` as the `package` in your bake stage and Spinnaker will handle which version to bake based on the Jenkins trigger that was chosen at execution time.

## Troubleshooting
When you have a failing bake step and you do not know why, a good place to start is with the bakery log. You can find a link to the bakery log in the Detail of your bake step on the pipeline execution screen

{{< figure src="/images/Image-2017-03-29-at-1.59.18-PM.png" >}}

Click the link that says 'View Bakery Details'. It can be helpful to track down the last command that the bakery executed.


Another source of information is the pipeline's source link. You can find this link in small writing in the far bottom right of the pipeline execution detail screen. The 'source' is a JSON representation of the data generated by Spinnaker when running your pipeline (not just the bake step).
