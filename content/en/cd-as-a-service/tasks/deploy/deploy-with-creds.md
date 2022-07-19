---
title: Deploy an App Using Credentials
linkTitle: Deploy with Credentials
description: >
  Use the CLI to deploy an app using CD-as-a-Service machine to machine credentials.
---

## Deploy your app using a Client ID and Client Secret

When you want to script a CLI deployment, you can pass your Client ID and Client Secret to the `deploy` command instead of separately logging into CD-as-a-Service using the CLI.  

## {{% heading "prereq" %}}

You have [created machine to machine client credentials]({{< ref "cd-as-a-service/tasks/iam/client-creds" >}}).

## Deploy your app

```bash
armory deploy start  -c <clientID> -s <clientSecret> -f <deploy.yaml>
```

