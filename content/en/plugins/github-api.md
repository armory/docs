---
title: GitHub API Plugin
linkTitle: GitHub API
description: >
  The GitHub API plugin for Spinnaker streamlines integration with GitHub Actions, filling the native support gap. It enables easy triggering of GitHub workflows, dynamic control of Spinnaker pipelines based on workflow outcomes, and seamless synchronization of GitHub Deployment statuses with Spinnaker pipeline conclusions. This integration leverages the versatility of GitHub Apps for precise permissions and streamlined automation, enhancing your CI/CD workflows.
---

![Proprietary](/images/proprietary.svg) ![Early Access](/images/ea.svg)

## What the GitHub API plugin does

GitHub API plugin offers you multiple integration points between GitHub and Spinnaker:

1. Spinnaker stages to trigger GitHub workflows using **workflow_dispatch** or **repo_dispatch** events.
2. Monitor GitHub workflow and finish the pipeline execution based on the Github workflow conclusion.
3. Trigger a Spinnaker pipeline automatically when a GitHub workflow finishes successfully.
4. Trigger a Spinnaker pipeline when a new GitHub Deployment is created.
5. Update GitHub deployment status based on Spinnaker pipeline conclusion.
6. View GitHub Action Logs in Spinnaker, meaning there is no need to navigate to GitHub to view the logs.

All the integration points mentioned above use the concept of GitHub Apps.

## Compatibility matrix

| Spinnaker Version | Armory Version | GitHub API Plugin Version |
|-------------------|----------------|---------------------------|
| >= 1.28.x         | >= 2.28.x      | 0.0.6                     |

## GitHub's application creation

1. In the upper-right corner of any page on GitHub, click your profile photo.
2. Navigate to your account settings.
  - For a GitHub App owned by a personal account, click **Settings**.
  - For a GitHub App owned by an organization:
    1. Click **Your organizations**.
    2. To the right of the organization, click **Settings**.
3. In the left sidebar, click **Developer settings**.
4. In the left sidebar, click **GitHub Apps**.
5. Click **New GitHub App**.
6. Under "GitHub App name", enter a name for your app.
7. Under "Homepage URL", type the full URL to your app's website in this case Spinnaker. If you don’t have a dedicated URL and your app's code is stored in a public repository, you can use that repository URL. Or, you can use the URL of the organization or user that owns the app.
8. Under "Permissions", choose the permissions that your app needs. Select the dropdown menu for each permission and click **Read-only**, **Read & write**, or **No access**. You should select the minimum permissions necessary for your app. For more information, see "[Choosing permissions for a GitHub App](https://docs.github.com/en/apps/creating-github-apps/setting-up-a-github-app/choosing-permissions-for-a-github-app)."
9. Under "Where can this GitHub App be installed?", select **Only on this account** or **Any account**. For more information on installation options, see "[Making a GitHub App public or private](https://docs.github.com/en/apps/creating-github-apps/setting-up-a-github-app/making-a-github-app-public-or-private)."
10. Click **Create GitHub App**.
11. Download the **private key** and save the **application id** that we will use later to configure the Spinnaker GiHub API plugin.

## GitHub application installation

1. In the upper-right corner of any page on GitHub, click your profile photo.
2. Navigate to your account settings.
  - For a GitHub App owned by a personal account, click **Settings**.
  - For a GitHub App owned by an organization:
    1. Click **Your organizations**.
    2. To the right of the organization, click **Settings**.
3. In the left sidebar, click **Developer settings**.
4. In the left sidebar, click **GitHub Apps**.
5. Next to the GitHub App that you want to install, click **Edit**.
6. Click **Install App**.
7. Click **Install** next to the location where you want to install the GitHub App.
8. If the app requires repository permissions, select **All repositories** or **Only select repositories**. The app will always have at least read-only access to all public repositories on GitHub. If the app does not require repository permissions, these options will be omitted.
9. If you selected **Only select repositories** in the previous step, under the **Select repositories** dropdown, select the repositories that you want the app to access. If the app creates any repositories, the app will automatically be granted access to those repositories as well.
10. Click **Install**.

## Spinnaker Plugin Installation - Halyard

1. Add plugin repository.

```shell
hal plugins repository add githubapi \
    --url=https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
```

2. Add the plugin.

```shell
hal plugins add Armory.GithubApi --version=1.0.0 --enabled=true
```

3. Update settings-local.js by adding the `github` entry in the `triggerTypes` array

```
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

4. Update echo-local.yml, gate-local.yml igor-local.yml, and orca-local.yml files with the following configuration if you have an organization-wide GitHub application installation

```yaml
github:
  plugin:
    accounts:
      - name: orgwide # GitHub app organization level installation
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
      - name: account1 # GitHub app repo installation
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
      - name: account1 # GitHub app repo installation
        organization:  <github_organization>
        repository: <github_repository>
        defaultBranch: <default_github_branch>
        githubAppId: <github_app_id>
        githubAppPrivateKey: <your_github_private_key>
      - name: account2 # GitHub app repo installation
        organization:  <another_github_organization>
        repository: <another_github_repository>
        defaultBranch: <another_default_github_branch>
        githubAppId: <another_github_app_id>
        githubAppPrivateKey: <another_github_private_key>
      - name: orgwide # GitHub app organization level installation
        organization: <github_organization>
        orgWide: true
        defaultBranch: <default_github_branch>
        githubAppId: <github_app_id>
        githubAppPrivateKey: <your_github_private_key>
```

## Spinnaker Plugin Installation - Spinnaker Operator

You can enable GitHub API Plugin using the [Spinnaker Operator](https://github.com/armory/spinnaker-operator). There’s a sample configuration you can use directly as is or adjust to your needs. Remember to specify the correct desired plugin version.

```yaml
#------------------------------------------------------------------------------
# Example configuration for enabling the GitHub API plugin
#------------------------------------------------------------------------------
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      plugin:
        accounts:
          - name: account1 # GitHub app repo installation
            organization:  <github_organization>
            repository: <github_repository>
            defaultBranch: <default_github_branch>
            githubAppId: <github_app_id>
            githubAppPrivateKey: <your_github_private_key>
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
            repositories:
              repository:
                enabled: true
                url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
      orca:
        spinnaker:
          extensibility:
            plugins:
              Armory.GithubApi:
                enabled: true
                version: 1.0.0
            repositories:
              repository:
                enabled: true
                url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
      igor:
        spinnaker:
          extensibility:
            plugins:
              Armory.GithubApi:
                enabled: true
                version: 1.0.0
            repositories:
              repository:
                enabled: true
                url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
      echo:
        spinnaker:
          extensibility:
            plugins:
              Armory.GithubApi:
                enabled: true
                version: 1.0.0
            repositories:
              repository:
                enabled: true
                url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
```

## How to use?

### Trigger GitHub Workflow using workflow_dispatch

To trigger a GitHub Workflow from Spinnaker using the **workflow_dispatch** event, we will use the new **GitHub API Workflow Trigger Stage** configured like in the screenshot below. We will have to select the GitHub account, the organization, the repository, the workflow name, and the branch where the workflow should be triggered.

![GitHub API Workflow Trigger Stage](/images/plugins/github-api/github-api-workflow-trigger-stage.png)

### Trigger GitHub Workflow using repo_dispatch

To trigger a GitHub Workflow from Spinnaker using the **repo_dispatch** event, we will use the new **GitHub API Repository Dispatch Event Stage** configured like in the screenshot below. We will have to select the GitHub account, the organization, the repository, and the event type that should be used to trigger the workflow.

![Github API Repository Dispatch Event Stage](/images/plugins/github-api/github-api-repository-dispatch-event-stage.png)

### Trigger Spinnaker pipeline when a GitHub workflow is finished successfully

To trigger a Spinnaker pipeline when a GitHub workflow is finished successfully we can select the new **GitHub Event Trigger** type from the dropdown. We must select the GitHub account, the organization, the repository, and the workflow Spinnaker should monitor.

![GitHub Event Trigger by Workflow](/images/plugins/github-api/github-event-trigger-by-workflow.png)

### Trigger Spinnaker pipeline when a new GitHub deployment was created

To trigger a Spinnaker pipeline when a new GitHub deployment is created, we can select the new **GitHub Event Trigger** type from the dropdown. We must select the GitHub account, the organization, and the repository. Optionally, but strongly recommended to provide a secret when creating the deployment event webhook in GitHub.

![GitHub Deployment Webhook](/images/plugins/github-api/github-deployment-webhook.png)

The same secret we will use to verify the message received is hashed with the same secret. If not, we will not process the request.

![GitHub Event Trigger by Event](/images/plugins/github-api/github-event-trigger-by-event.png)

#### Update GitHub deployment when Spinnaker pipeline is finished

When the pipeline triggered by a deployment event is finished, Spinnaker will automatically update the status of the GitHub deployment based on the conclusion of the Spinnaker pipeline.

### Fetch release and pre-release information

The **GitHub API Releases Get Details** stage can be configured with the retrieve action "Get Latest Release" to fetch the latest release information.

![Get Latest Release](/images/plugins/github-api/get-latest-release.png)

To fetch the latest pre-release the retrieve action should be "Get Latest Pre-Release".

![Get Latest Pre-Release](/images/plugins/github-api/get-latest-pre-release.png)

## Release notes

- 0.0.6: Initial release
