---
title: Install the Scale Agent Plugin Using a Docker Image
linkTitle: Install Plugin - Docker
weight: 20
description: >
  Learn how to install the Armory Scale Agent plugin using a Docker image. 
---


## Halyard

{{% alert title="Warning" color="warning" %}}
The Scale Agent plugin extends Clouddriver. When Halyard adds a plugin to a Spinnaker installation, it adds the plugin repository information to each service. This means that when you restart Spinnaker, each service restarts, downloads the plugin, and checks if an extension exists for that service. Each service restarting is not ideal for large Spinnaker installations due to service restart times. To avoid each service restarting and downloading the plugin, configure the plugin in Clouddriver’s local profile.
{{% /alert %}}

1. Create a [custom service setting](https://spinnaker.io/docs/reference/halyard/custom/) that mounts an empty volume inside Clouddriver for the plugin image. Add the following to your `.hal/default/service-settings/clouddriver.yml` file:

   ```yaml
   kubernetes:
     volumes:
     - id: kubesvc-plugin-vol
       type: emptyDir
       mountPath: /opt/clouddriver/lib/plugins
    ```

1. Define an init container for the plugin. In the `deploymentConfigurations.name.deploymentEnvironment.initContainers` section of your `.hal/config`, add the following:

   ```yaml
   spin-cloudriver:
   - name: kubesvc-plugin
     image: docker.io/armory/kubesvc-plugin:<version>
     volumeMounts:
     - mountPath: /opt/plugin/target
       name: kubesvc-plugin-vol
   ```

   Be sure to use the plugin version compatible with your Spinnaker version.

1. Add the plugin to your `clouddriver-local.yml`.

   ```yaml
   spinnaker:
    extensibility:
      plugins:
        Armory.Kubesvc:
          enabled: true
          extensions:
            armory.kubesvc:
              enabled: true
      pluginsRootPath: /opt/clouddriver/lib/plugins
   kubesvc:
     cluster: kubernetes
   kubernetes:
     enabled: true
    # enable Clouddriver Account Management if you are using Spinnaker 1.28+
    account:
      storage:
        enabled: true
   ```

1. Apply your changes by running `hal deploy apply`.


## Armory Operator

{{< readfile file="/includes/scale-agent/install/plugin-docker-armory-op.yaml" code="true" lang="yaml" >}}