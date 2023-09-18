---
title: Install the GitHub API Plugin in Spinnaker (Halyard)
linkTitle: Spinnaker - Halyard
weight: 3
description: >
  Learn how to install Armory's GitHub API Plugin in a Spinnaker instance managed by Halyard. The GitHub API enables your app developers to trigger a Spinnaker pipeline from a GitHub workflow.
---

## {{% heading "prereq" %}}

* You are running open source Spinnaker.
* You manage your instance using Halyard. If you are using the Spinnaker Operator, see {{< linkWithTitle "plugins/github-api/install/spinnaker-operator.md" >}}.

{{< include "plugins/github/install-reqs.md" >}}


{{% alert color="warning" title="A note about installing plugins in Spinnaker" %}}
When Halyard adds a plugin to a Spinnaker installation, it adds the plugin repository information to all services, not just the ones the plugin is for. This means that when you restart Spinnaker, each service restarts, downloads the plugin, and checks if an extension exists for that service. Each service restarting is not ideal for large Spinnaker installations due to service restart times. Clouddriver can take an hour or more to restart if you have many accounts configured.

The GitHub API plugin extends Deck, Echo, Gate, Igor, and Orca. To avoid every Spinnaker service restarting and downloading the plugin, do not add the plugin using Halyard. Instead, follow the local config installation method, in which you configure the plugin in each extended service’s local profile.

{{% /alert %}}

## Compatibility

{{< include "plugins/github/compat-matrix.md" >}}


## Add the plugin to local config files

### settings-local.js

Add `github` to the `triggerTypes` array: 

```js
window.spinnakerSettings = {
...
triggerTypes: [
    'artifactory',
    'concourse',
    'cron',
    'docker',
    'git',
    'github',
    'helm',
    'jenkins',
    'nexus',
    'pipeline',
    'plugin',
    'pubsub',
    'travis',
    'webhook',
    'wercker',
  ]
...
}
```

### Service config files

Update `echo-local.yml`, `gate-local.yml`, `igor-local.yml`, and `orca-local.yml` config files with the following:

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.GithubApi:
        id: Armory.GithubApi
        enabled: true
        version: <version>
    repositories:
      githubApi:
        enabled: true
        url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
github:
  plugin:
    accounts: []
```


{{< include "plugins/github/plugin-config.md" >}}


#### Accounts config example

{{< include "plugins/github/accounts-config-example.md" >}}


### Deck plugin

Configure the Deck plugin in your `gate-local.yml` config file:

{{< highlight yaml "linenos=table,hl_lines=12-17" >}}
spinnaker:
  extensibility:
    plugins:
      Armory.GithubApi:
        id: Armory.GithubApi
        enabled: true
        version: <version>
    repositories:
      githubApi:
        enabled: true
        url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json  
    deck-proxy:
      enabled: true
      plugins:
         Armory.GithubApi:
            enabled: true
            version: <version>
github:
  plugin:
    accounts: []   
{{< /highlight >}}

## Install the plugin

Apply your changes:

```bash
hal deploy apply
```

## {{% heading "nextSteps" %}}

[Learn how to use the GitHub API plugin]({{< ref "plugins/github-api/use" >}}).