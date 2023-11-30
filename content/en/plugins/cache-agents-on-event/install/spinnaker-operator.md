---
title: Install the Cache Agents On Event Plugin in Spinnaker (Operator)
linkTitle: Spinnaker - Operator
weight: 2
description: >
  Learn how to install Armory's Cache Agents On Event Plugin in a Spinnaker instance managed by the Spinnaker Operator.
---

![Proprietary](/images/proprietary.svg) ![Beta](/images/beta.svg)

## Installation overview

Enabling the Cache Agents On Event plugin consists of the following steps:

1. [Meet the prerequisites](#before-you-begin)
1. [Configure the plugin](#configure-the-plugin)
1. [Install the plugin](#install-the-plugin)
1. [Configure the provider infrastructure](#configure-infra)

## {{% heading "prereq" %}}

{{< include "plugins/github/install-reqs.md" >}}
* You are running open source Spinnaker.
* You manage your instance using the Spinnaker Operator and the `spinnaker-kustomize-patches` [repo](https://github.com/armory/spinnaker-kustomize-patches). If you are using Halyard, see {{< linkWithTitle "plugins/github-integration/install/spinnaker-halyard.md" >}}.

## Compatibility

{{< include "plugins/cats/compat-matrix.md" >}}


## Configure the plugin

Create a `cats-plugin.yml` file with the following contents: 

{{< readfile file="/includes/plugins/cats/spinnaker-operator.yaml" code="true" lang="yaml" >}}

Save the file to your `spinnaker-kustomize-patches/plugins/oss` directory.



## Install the plugin

1. Add the plugin patch to your Kustomize recipe's `patchesStrategicMerge` section. For example:

   {{< highlight yaml "linenos=table,hl_lines=13" >}}
   apiVersion: kustomize.config.k8s.io/v1beta1
   kind: Kustomization
   
   namespace: spinnaker
   
   components:
     - core/base
     - core/persistence/in-cluster
     - targets/kubernetes/default
   
   patchesStrategicMerge:
     - core/patches/oss-version.yml
     - plugins/oss/cats-plugin.yml
   
   patches:
     - target:
         kind: SpinnakerService
       path: utilities/switch-to-oss.yml
   {{< /highlight >}}

1. Apply the updates to your Kustomization recipe.

   ```bash
   kubectl apply -k <kustomization-directory-path>
   ```
1. Configure the provider infrastructure
After our plugin installation we gonna have able the endpoint ‘aws/notify’  in our gate service. So next step is create a subscription in SNS AWS service following next steps:
- First go to our AWS Console → Simple Notification Service

  {{< figure src="sns-step1.png" height="80%" weight="80%" >}}

- Now, we gonna go to Topics section, and click if you have one already created:

  {{< figure src="sns-step1.1.png" height="80%" weight="80%" >}}

If we do not have any topic created, them press in Create topic, in the next window follow:
1. Choose **Standard**.
2. In the **Details** section, enter a **Name** for the topic, such as **MyTopic**.
3. Go to Access Policy and click on Advanced and add or paste the next policy:
```
   {
     "Version": "2008-10-17",
     "Statement": [
       {
         "Sid": "AWSConfigSNSPolicy",
         "Effect": "Allow",
         "Principal": {
            "Service": "config.amazonaws.com"
         },
         "Action": "sns:Publish",
         "Resource": "arn:aws:sns:us-west-2:568975057762:config-topic-568975057762"
         }
     ]
   }
```
4. Scroll to the end of the form and choose **Create topic**.
    
  Note: You can test adding a subscription to your email, and validate agent events sent to your email, then we can destroy the subscription, and continue adding plugin subscription

- Now click in the Config Topic, and click on Create subscription

  {{< figure src="sns-step2.png" height="80%" weight="80%" >}}
- Fill the fields with the desired information, just select the correct protocol (HTTP, HTTPS) depending in your gate exposed endpoint

  {{< figure src="sns-step3.png" height="80%" weight="80%" >}}
- And click in Create Subscription

Now you will be redirected to subscriptions lists, your recently subscription created will appear, and will be confirmed automatically for the CATS Plugin

{{< figure src="sns-step4.png" height="80%" weight="80%" >}}

If you don’t see the confirmed check after 1 or 2 minutes, check your service, and validate if your endpoint and plugin installation is working as expected.