---
title: Install the GiHub API Plugin
linkTitle: Install
description: >
  TBD
---




# GitHub Application Setup

## GitHub application creation

1. In the upper-right corner of any page on GitHub, click your profile photo.
2. Navigate to your account settings.
    - For a GitHub App owned by a personal account, click **Settings**.
    - For a GitHub App owned by an organization:
        1. Click **Your organizations**.
        2. To the right of the organization, click **Settings**.
3. In the left sidebar, click  **Developer settings**.
4. In the left sidebar, click **GitHub Apps**.
5. Click **New GitHub App**.
6. Under "GitHub App name", enter a name for your app.
7. Under "Homepage URL", type the full URL to your app's website. If you don’t have a dedicated URL and your app's code is stored in a public repository, you can use that repository URL. Or, you can use the URL of the organization or user that owns the app.
8. Under "Permissions", choose the permissions that your app needs. Select the dropdown menu for each permission and click **Read-only**, **Read & write**, or **No access**. You should select the minimum permissions necessary for your app. For more information, see "[Choosing permissions for a GitHub App](https://docs.github.com/en/apps/creating-github-apps/setting-up-a-github-app/choosing-permissions-for-a-github-app)."
9. Under "Where can this GitHub App be installed?", select **Only on this account** or **Any account**. For more information on installation options, see "[Making a GitHub App public or private](https://docs.github.com/en/apps/creating-github-apps/setting-up-a-github-app/making-a-github-app-public-or-private)."
10. Click **Create GitHub App**.
11. Download the **private key** and save the **application id** that we will use later to configure the Spinnaker GiHub API plugin

## GitHub application installation

1. In the upper-right corner of any page on GitHub, click your profile photo.
2. Navigate to your account settings.
    - For a GitHub App owned by a personal account, click **Settings**.
    - For a GitHub App owned by an organization:
        1. Click **Your organizations**.
        2. To the right of the organization, click **Settings**.
3. In the left sidebar, click  **Developer settings**.
4. In the left sidebar, click **GitHub Apps**.
5. Next to the GitHub App that you want to install, click **Edit**.
6. Click **Install App**.
7. Click **Install** next to the location where you want to install the GitHub App.
8. If the app requires repository permissions, select **All repositories** or **Only select repositories**. The app will always have at least read-only access to all public repositories on GitHub.
    
    If the app does not require repository permissions, these options will be omitted.
    
9. If you selected **Only select repositories** in the previous step, under the **Select repositories** dropdown, select the repositories that you want the app to access.
    
    If the app creates any repositories, the app will automatically be granted access to those repositories as well.
    
10. Click **Install**.

# Spinnaker Plugin Installation

## Halyard

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

## Operator

You can enable Github API Plugin using the [Spinnaker Operator.](https://github.com/armory/spinnaker-operator) There’s a sample configuration you can use directly as is or adjust to your needs. Remember to specify the correct desired plugin version.

```yaml
#------------------------------------------------------------------------------
# Example configuration for enabling the Github API plugin
#------------------------------------------------------------------------------
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
				    accounts:
				      - name: account1 # github app repo installation
				        organization:  <github_organization>
				        repository: <github_repository>
				        defaultBranch: <default_github_branch>
				        githubAppId: <github_app_id>
				        githubAppPrivateKey: <your_github_private_key>
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
                version: 1.0.0
            deck-proxy:
              enabled: true
              plugins:
                Armory.GithubApi:
                  enabled: true
                  version: 1.0.0     
			orca:
        spinnaker:
          extensibility:
            plugins:
              Armory.GithubApi:
                enabled: true
                version: 1.0.0
			igor:
        spinnaker:
          extensibility:
            plugins:
              Armory.GithubApi:
                enabled: true
                version: 1.0.0
			echo:
        spinnaker:
          extensibility:
            plugins:
              Armory.GithubApi:
                enabled: true
                version: 1.0.0
```