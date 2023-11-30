---
title: Install the AWS Event Cache Plugin in Armory Continuous Deployment
linkTitle: Armory CD
weight: 1
description: >
  Learn how to install the AWS Event Cache Plugin in Armory Continuous Deployment.
---

![Proprietary](/images/proprietary.svg) ![Beta](/images/beta.svg)

## Installation overview

Enabling the AWS Event Cache plugin consists of the following steps:


## {{% heading "prereq" %}}

* You are running Armory Continuous Deployment.
* You manage your instance using the Armory Operator and the `spinnaker-kustomize-patches` [repo](https://github.com/armory/spinnaker-kustomize-patches). 

## Compatibility

{{< include "plugins/aws-event-cache/compat-matrix.md" >}}


## Configure the plugin

Create an `aws-event-cache-plugin.yml` file with the following contents: 

```yaml
apiVersion: spinnaker.armory.io/v1alpha2
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

Replace `<version>` with the plugin version compatible with your Armory CD version.

Save the file to your `spinnaker-kustomize-patches/plugins` directory.

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
     - plugins/aws-event-cache-plugin.yml
   
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