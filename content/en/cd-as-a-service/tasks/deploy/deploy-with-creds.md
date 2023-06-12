---
title: Deploy an App Using Credentials
linkTitle: Deploy with Credentials
description: >
  Use the CLI to deploy an app using CD-as-a-Service machine to machine credentials.
categories: ["Guides"]
tags: ["Deployment", "Deploy Config", "Credentials", "Automation", "CLI"]
---

## Deploy your app using a Client ID and Client Secret

When you want to script a CLI deployment, you can pass your Client ID and Client Secret to the `deploy` command instead of separately logging into CD-as-a-Service using the CLI.  

## {{% heading "prereq" %}}

You have [created machine to machine client credentials]({{< ref "cd-as-a-service/tasks/iam/client-creds" >}}) and have access to your Client ID and Client Secret values.

## Deploy your app

{{< prism lang="bash" >}}
armory deploy start  -c <your-client-id> -s <your-client-secret> -f <your-deploy.yaml>
{{< /prism >}}