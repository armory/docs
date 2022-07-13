---
title: Configure Slack Notifications in Spinnaker
linkTitle: Configure Slack Notifications
aliases:
  - /docs/spinnaker-install-admin-guides/slack-notifcations
description: >
  Learn how to configure Spinnaker to send Slack notifications.
---

## Create a Slack application

Go to the [Apps Management URL](https://api.slack.com/apps) and click on the “Create New App” button. Once done, you will get access to the basic configuration pane. You might want to customize some settings, like the color or the logo of your application at the bottom of it.

![Github Webhook](/images/slack-notifications-1.png)

## Create a bot

Create a bot after your Slack application has been created. Next, select the “Add features and functionality” menu and then select “Bots”.

Enter the following fields:

- The Bot Display Name
- The Bot Username
- The “Always Show My Bot as Online” to On

##  Deploy the bot

Select the “OAuth & Permissions” menu, copy the *Bot User OAuth Access Token* this is the token needed in Spinnaker configuration, also on the *Bot Token Scopes* section add a scope of type `chat:write` like in the screenshot below:

![Github Webhook](/images/slack-bot-credentials.png)

Select the “Install your app to your workspace” from the Bot “Basic Information” page and deploy it.

## Invite the bot to a channel

Spinnaker only requires publishing on a channel to interact with Slack. All you have to do is connect to a channel or create a new channel and name the bot you’ve just created. Slack will propose to invite the bot. Accept the invitation.

## Register the Slack token with Spinnaker

You are now ready to configure Spinnaker with the bot you’ve just registered.

{{< tabs name="register" >}}
{{% tabbody name="Operator" %}}

Add the following snippet to the `SpinnakerService` manifest:

```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:  
    config:
      notifications:
        slack:
          enabled: true
          botName: spinnaker                                         # The name of your slack bot.
          token: xoxb-xxxxxxxx-xxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxx # Your slack bot token. This field supports "encrypted" secret references 
```

Apply the changes:

```bash
kubectl -n <spinnaker namespace> apply -f <SpinnakerService manifest>
```

{{% /tabbody %}}
{{% tabbody name="Halyard" %}}

Start by setting the variables below:

```bash
export TOKEN_FROM_SLACK="xoxb-xxxxxxxx-xxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxx"
export SLACK_BOT=spinnaker
```

Register the token and bot name in the configuration:

```bash
$ echo $TOKEN_FROM_SLACK | hal config notification slack edit --bot-name \
   $SLACK_BOT --token
```

Set the configuration that enables Slack:

```bash
$ hal config notification slack enable
```

Redeploy the configuration:

```bash
$ hal deploy apply
```

{{% /tabbody %}}
{{< /tabs >}}

## Test Spinnaker

You should then make sure Spinnaker can send the notifications as expected. You can configure a notification within a channel you have invited your bot in and test by running a test pipeline. See example below:

![Github Webhook](/images/slack-notifications-3.png)
