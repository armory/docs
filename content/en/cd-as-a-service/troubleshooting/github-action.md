---
title: Troubleshoot Using the Armory CD-as-a-Service GitHub Action
linkTitle: GitHub Action
description: >
  Solutions for issues you might encounter while using the Armory Continuous Deployment-as-a-Service GitHub Action.
---

## GitHub resources

GitHub Actions [docs](https://docs.github.com/en/actions)

  - [Using workflows](https://docs.github.com/en/actions/using-workflows/about-workflows)
  - [Troubleshooting and monitoring GitHub Actions](https://docs.github.com/en/actions/monitoring-and-troubleshooting-workflows/about-monitoring-and-troubleshooting)

## Failed to fetch access token

Check the syntax and spelling of your GitHub secrets in your workflow file. For example, if you named your GitHub secrets **CDAAS_CLIENT_ID** and **CDAAS_CLIENT_SECRET**, your config should look like: 

```yaml
clientId: ${{ secrets.CDAAS_CLIENT_ID }}
clientSecret: ${{ secrets.CDAAS_CLIENT_SECRET }}
```

## Status code 422

When you don't have a publicly accessible Remote Network Agent (RNA) running in your target deployment cluster, you see a message similar to this:

```bash
Error: request returned an error: status code(422), thrown error: {"error_id":"c0b7c916-e28f-4f65-b29f-7343c899c168","errors":[{"message":"account 'aimeeu-local' does not exist","code":"42"}]}
```

`account` is the name of the RNA that you configured in your CD-as-a-Service deployment file. You can check your RNA status in the **Configuration** > **Networking** > **Agents** screen of the Armory Cloud Console.

