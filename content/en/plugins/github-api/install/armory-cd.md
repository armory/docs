---
linkTitle: Armory CD
title: Install the GitHub API Plugin in Armory Continuous Deployment
weight: 1
description: >
  Learn how to install the GitHub API Plugin in Armory CD so that your app developers can trigger a Spinnaker pipeline from a GitHub workflow.
---
![Proprietary](/images/proprietary.svg)


## {{% heading "prereq" %}}

* You are running Armory Continuous Deployment.
* You manage your instance using the Armory Operator and the `spinnaker-kustomize-patches` [repo](https://github.com/armory/spinnaker-kustomize-patches). 

{{< include "plugins/github/install-reqs.md" >}}

## Compatibility

{{< include "plugins/github/compat-matrix.md" >}}

## Configure the plugin

Create a `github-api.yml` file with the following contents: 

```yaml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      # Configs in the spinnaker profile get applied to all services
      spinnaker:
        github:
          plugin:
            accounts: []
        spinnaker:
          extensibility:
            repositories:
              repository:
                enabled: true
                url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
			deck:
				settings-local.js: |
						window.spinnakerSettings.triggerTypes=['artifactory','concourse','cron','docker','git','github','helm','jenkins','nexus','pipeline','plugin','pubsub','travis','webhook','wercker']
      gate:
        spinnaker:
          extensibility:
            plugins:
              Armory.GithubApi:
                enabled: true
                version: <version>
            deck-proxy:
              enabled: true
              plugins:
                Armory.GithubApi:
                  enabled: true
                  version: <version>    
      orca:
        spinnaker:
          extensibility:
            plugins:
              Armory.GithubApi:
                enabled: true
                version: <version>
      igor:
        spinnaker:
          extensibility:
            plugins:
              Armory.GithubApi:
                enabled: true
                version: <version>
      echo:
        spinnaker:
          extensibility:
            plugins:
              Armory.GithubApi:
                enabled: true
                version: <version>
```


{{< include "plugins/github/plugin-config.md" >}}

Save the file to your `spinnaker-kustomize-patches/plugins` directory.

### Accounts config example

{{< include "plugins/github/accounts-config-example.md" >}}

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
     - plugins/github-api.yml
   
   patches:
     - target:
         kind: SpinnakerService
       path: utilities/switch-to-oss.yml
   {{< /highlight >}}

1. Apply the updates to your Kustomization recipe.

   ```bash
   kubectl apply -k <kustomization-directory-path>
   ```

## {{% heading "nextSteps" %}}

[Learn how to use the GitHub API plugin]({{< ref "plugins/github-api/use" >}}).