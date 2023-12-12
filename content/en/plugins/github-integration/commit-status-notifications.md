---
title: Enable GitHub Commit Status Echo notifications
linkTitle: Enable Notifications
weight: 10
description: >
  Learn how to enable an enhanced Echo notification type which can be configured to send notifications for pipelines and/or stages statuses with custom context and description linking to the Spinnaker UI as a target URL. 
---

![Proprietary](/images/proprietary.svg) ![Beta](/images/beta.svg)


## Configure GitHub Commit Status Echo notifications

Echo is the microservice in Spinnaker which (among other functionalities) manages notifications for Spinnaker pipelines and stages.

Using the GitHub Integration plugin you can configure Echo to create [GitHub Commit Statuses](https://docs.github.com/en/rest/commits/statuses?apiVersion=2022-11-28#create-a-commit-status)
in a repository by authenticating using the GitHub App accounts configured in the plugin.

By using the GitHub Integration's plugin GitHub Commit Status notifications, you can link the deployment pipeline statuses to GitHub status checks. This feature provides clear and immediate feedback to developers about the deployment pipeline status. 

## How this feature works

GitHub Integration plugin offers an enhanced Echo notification type which can be configured to send notifications
for pipelines and/or stages statuses with custom context and description linking to the Spinnaker UI as a target URL.

## How to enable

GitHub Commit Status notifications can be enabled per GitHub App account by enabling the feature in Echo and Deck services in the `github-integration-plugin.yml` file.

{{< highlight yaml "linenos=table,hl_lines=7-8 14-15" >}}
spec:
  spinnakerConfig:
    profiles:
      spinnaker:
        github:
          plugin:
            github-status:
              enabled: true
            accounts: []
      deck:
        settings-local.js: |
          window.spinnakerSettings = {
            ... (content omitted for brevity)
            feature.githubIntegrationFlags = {
              githubStatus: true
            };  
            ... (content omitted for brevity)
          }
{{< /highlight >}}

## Migrating from Echo's default implementation

Migrating from the default implementation to the GitHub Integration plugin's implementation does not require any changes in your pipelines. The GitHub Integration plugin's implementation is used automatically when the feature is enabled in Echo and Deck services and the default implementation is disabled. To ensure a smooth migration, follow these steps:


1. Disable the default implementation by disabling the `github-status` feature in Echo and Deck services

   {{< highlight yaml "linenos=table,hl_lines=6 13" >}}
   spec:
     spinnakerConfig:
       profiles:
         echo:
           github-status:
             enabled: false
             token: <PAT>
             endpoint: https://api.github.com
         deck:
           settings-local.js: |
             window.spinnakerSettings = {
               ... (content omitted for brevity)
               notifications.githubStatus.enabled = false;
               ... (content omitted for brevity)
             }
   {{< /highlight >}}

1. Enable the GitHub Integration plugin. See the [Get Started]({{< ref "plugins/github-integration/install/_index.md" >}}) section for instructions.

1. Ensure that you have configured the appropriate GitHub App accounts for every GitHub organization that you want to send notifications to.

1. Verify that the Deck UI is showing the plugin's Commit Status notification type in the notification settings for 
your pipelines and the Commit Statuses are being created in GitHub.

