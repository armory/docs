---
title: Install the AWS Event Cache Plugin in Spinnaker (Operator)
linkTitle: Spinnaker - Operator
weight: 2
description: >
  Learn how to install the AWS Event Cache Plugin in a Spinnaker instance managed by the Spinnaker Operator.
---

![Proprietary](/images/proprietary.svg) ![Beta](/images/beta.svg)

## Installation overview

Enabling the AWS Event Cache plugin consists of the following steps:

1. [Meet the prerequisites](#before-you-begin)
1. [Configure the plugin](#configure-the-plugin)
1. [Install the plugin](#install-the-plugin)
1. [Configure the provider infrastructure](#configure-infra)

## {{% heading "prereq" %}}

* You are running open source Spinnaker.
* You manage your instance using the Spinnaker Operator and the `spinnaker-kustomize-patches` [repo](https://github.com/armory/spinnaker-kustomize-patches). If you are using Halyard, see {{< linkWithTitle "plugins/aws-event-cache/install/spinnaker-halyard.md" >}}.

## Compatibility

{{< include "plugins/aws-event-cache/compat-matrix.md" >}}


## Configure the plugin

Create an `aws-event-cache-plugin.yml` file with the following contents: 

```yaml
apiVersion: spinnaker.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      spinnaker:
        spinnaker:
          extensibility:
            repositories:
              awscatsOnEvent:
                version: <version>
                enabled: true
                url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
      clouddriver: &clouddriver-cats
        spinnaker:
          extensibility:
            plugins:
              Armory.AWSCATsOnEvent:
                enabled: true
      clouddriver-ro:
        *clouddriver-cats
      clouddriver-rw:
        *clouddriver-cats
      clouddriver-caching:
        *clouddriver-cats
      gate:
        spinnaker:
          extensibility:
            plugins:
              Armory.AWSCATsOnEvent:
                enabled: true

```


Replace `<version>` with the plugin version compatible with your Spinnaker version.

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
     - plugins/oss/aws-event-cache-plugin.yml
   
   patches:
     - target:
         kind: SpinnakerService
       path: utilities/switch-to-oss.yml
   {{< /highlight >}}

1. Apply the updates to your Kustomization recipe.

   ```bash
   kubectl apply -k <kustomization-directory-path>
   ```

## Create an AWS SNS topic and subscription

{{< include "plugins/aws-event-cache/create-aws-sns-subscription.md" >}}