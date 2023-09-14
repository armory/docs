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


### Add plugin.json

```json
hal plugins repository add githubapi \
    --url=https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
```

The entry will create the following entry in halconfig:

```jsx
spinnaker:
    extensibility:
      plugins: {}
      repositories:
        githubapi:
          id: githubapi
          url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
```

### Add the plugin

Run the following hal command

```json
hal plugins add Armory.GithubApi  --version=1.0.0 --enabled=true
```

Halyard adds the plugin configuration to the `.hal/config` file.

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.GithubApi:
        id: Armory.GithubApi
        enabled: true
        version: 1.0.
```

Additionally, the gate-local.yml should contain a deck proxy entry to load the Deck plugin.

```yaml
spinnaker:
  extensibility:
    deck-proxy:
      enabled: true
      plugins:
         Armory.GithubApi:
            enabled: true
            version: 1.0.0 
```

Update settings-local.js by adding the ************github************ entry in the ********triggerTypes******** array

```yaml
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

Update echo-local.yml, gate-local.yml igor-local.yml, and  orcal-local.yml files with the following configuration if you have an organization-wide GitHub application installation

```yaml
github:
  plugin:
    accounts:
      - name: orgwide # github app organization level installation
        organization: <github_organization>
        orgWide: true
        defaultBranch: <default_github_branch>
        githubAppId: <github_app_id>
        githubAppPrivateKey: <your_github_private_key>
```

or with the following if you installed the GitHub application only in one repository

```yaml
github:
  plugin:
    accounts:
      - name: account1 # github app repo installation
        organization:  <github_organization>
        repository: <github_repository>
        defaultBranch: <default_github_branch>
        githubAppId: <github_app_id>
        githubAppPrivateKey: <your_github_private_key>
```

You can define multiple accounts using different Github applications like below

```yaml
github:
  plugin:
    accounts:
      - name: account1 # github app repo installation
        organization:  <github_organization>
        repository: <github_repository>
        defaultBranch: <default_github_branch>
        githubAppId: <github_app_id>
        githubAppPrivateKey: <your_github_private_key>
      - name: account2 # github app repo installation
        organization:  <another_github_organization>
        repository: <another_github_repository>
        defaultBranch: <another_default_github_branch>
        githubAppId: <another_github_app_id>
        githubAppPrivateKey: <another_github_private_key>
      - name: orgwide # github app organization level installation
        organization: <github_organization>
        orgWide: true
        defaultBranch: <default_github_branch>
        githubAppId: <github_app_id>
        githubAppPrivateKey: <your_github_private_key>
```

## {{% heading "nextSteps" %}}

[Learn how to use the GitHub API plugin]({{< ref "plugins/github-api/use" >}}).