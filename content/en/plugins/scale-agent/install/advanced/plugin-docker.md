---
title: Install the Scale Agent Plugin Using a Docker Image
linkTitle: Install Plugin - Docker
weight: 20
description: >
  Learn how to install the Armory Scale Agent plugin using a Docker image. 
---


## Halyard local config

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

### Validate plugin installation

1. Confirm the plugin Docker image exists locally.

   ```bash
   docker images | grep kubesvc
   ```

   Output is similar to:

   ```bash
   armory/kubesvc-plugin     0.11.32
   ```

1. Find the name of the new Clouddriver pod.

   ```bash
   kubectl -n spinnaker get pods
   ```

1. Confirm the Clouddriver service is using the Docker image.

   ```bash
   kubectl -n spinnaker describe pod <clouddriver-pod-name> | grep Image:
   ```

   Output is similar to:

   ```bash
   Image:    docker.io/armory/kubesvc-plugin:0.11.32
   ```

1. View the Clouddriver log to verify that the plugin has started.

   ```bash
   kubectl -n spinnaker logs deployments/spin-clouddriver | grep "Plugin"
   ```

   Output is similar to:

   ```bash
   org.pf4j.AbstractPluginManager      :  Plugin 'Armory.Kubesvc@0.11.32' resolved
   org.pf4j.AbstractPluginManager      :  Start plugin 'Armory.Kubesvc@0.11.32'
   io.armory.kubesvc.KubesvcPlugin     :  Starting Kubesvc  plugin...
   ```


## Armory Operator or Spinnaker Operator

You can find the Kustomize file `plugin-container-patch.yml` in the `spinnaker-patches-kustomize` [repo](https://github.com/armory/spinnaker-kustomize-patches/tree/master/targets/kubernetes/scale-agent). 

Change the value for `metadata.name` if your Armory CD service is called something other than “spinnaker”.





Then include the file under the `patchesStrategicMerge` section of your kustomization file.

```yaml
patchesStrategicMerge:
  - <path>/plugin-container-patch.yml
```

Apply your changes.