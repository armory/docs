---
title: Troubleshoot CD-as-a-Service Tools
linkTitle: Tools
description: >
  Solutions for issues you might encounter while using the Armory Continuous Deployment-as-a-Service AVM, CLI, or GitHub Action.
---

## Troubleshooting overview

The CLI and GitHub Action (GHA) both call the same API, so you should see similar error reporting in both tools.

## Common CLI and GHA error messages

## Status code 422

When you don't have a publicly accessible Remote Network Agent (RNA) running in your target deployment cluster, you see a message similar to this:

```bash
Error: request returned an error: status code(422), thrown error: {"error_id":"c0b7c916-e28f-4f65-b29f-7343c899c168","errors":[{"message":"account 'aimeeu-local' does not exist","code":"42"}]}
```

`account` is the name of the RNA that you configured in your CD-as-a-Service deployment file. You can check your RNA status in the **Configuration** > **Networking** > **Agents** screen of the Armory Cloud Console.


## CLI

### Error writing credentials file

`error: Error: there was an error writing the credentials file. `

This issue occurs because the directory the CLI stores your credentials in after you run `armory login` does not exist. You can create the directory by running the following command:

```bash
mkdir ~/.armory/credentials
```

Make sure you are running the latest version of the CLI.


## GitHub Action

GitHub Actions [docs](https://docs.github.com/en/actions)

  - [Using workflows](https://docs.github.com/en/actions/using-workflows/about-workflows)
  - [Troubleshooting and monitoring GitHub Actions](https://docs.github.com/en/actions/monitoring-and-troubleshooting-workflows/about-monitoring-and-troubleshooting)

### Failed to fetch access token

Check the syntax and spelling of your GitHub secrets in your workflow file. For example, if you named your GitHub secrets **CDAAS_CLIENT_ID** and **CDAAS_CLIENT_SECRET**, your config should look like: 

```yaml
clientId: ${{ secrets.CDAAS_CLIENT_ID }}
clientSecret: ${{ secrets.CDAAS_CLIENT_SECRET }}
```

## Armory Version Manager (AVM)

### Developer cannot be verified error when trying to run AVM

Depending on your operating system settings, you may need to allow apps from an unidentified developer in order to use AVM. For macOS, go to **System Preferences > Security & Privacy > General** and click **Allow Anyway**. For more information, see the macOS documentation about [how to open a Mac app from an unidentified developer](https://support.apple.com/guide/mac-help/open-a-mac-app-from-an-unidentified-developer-mh40616/mac).

### Bad CPU type

`bad CPU type in executable`

This issue occurs if the AVM version you downloaded does not match your CPU architecture. For example, if you try to run an `arm64` build on a system that is not ARM based. Verify that you downloaded the correct AVM version for your system.