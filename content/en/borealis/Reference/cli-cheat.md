---
title: CLI Cheatsheet
linktitle: CLI Cheatsheet
description: >
  This page contains a list of commonly used CLI commands and flags.
exclude_search: true
---

## CLI usage

The CLI binary is `armory`. Usage is `armory [command]`. Run `armory help` to see a list of commands.

**Global Flags**

- `-h, --help`: Help
- `-o, --output`: Set the output type. Available options are `json` and `yaml`. The default is plain text.
- `-v, --verbose`: Verbose output

## CLI autocomplete

Generate the autocompletion script for `armory` for the specified shell.

**Usage**

`armory completion [command]`

**Available Commands**

- `bash`
- `fish`
- `powershell`
- `zsh`

See each available command's help for details on how to use the generated script.

## CLI help

Lists the usage and available commands.

**Usage**

`armory help`

## Log into Project Borealis

**Usage**

`armory login [flags]`

**Flags**
- `-e, --envName`: (Optional) The name of your Borealis environment. Names with spaces must be enclosed in single or double quotes.

**Example**

If your environment is named `dev`, execute:

`armory login -e dev`

If your environment is named `dev team`, execute:

`armory login -e 'dev team'`

If you don't include your environment, the command returns with a list of environments. You must select one to continue.

## Log out of Project Borealis

**Usage**

`armory logout [envName]`

`envName` is optional.

When you execute the `armory logout` command, a prompt appears for user confirmation.

## Deploy an application

**Usage**

`armory deploy start [flags]`

**Flags**
- `-a, --authToken`: (Optional) The authentication token to use rather than `clientId` and `clientSecret` or user login.
- `-c, --clientId`: (Optional) The Client ID for connecting to Project Borealis.
- `-f, --file`: (Required) The path to the deployment file.
- `-n, --application`: (Optional) The app name for deployment.
- `-s, --clientSecret`: (Optional) The Client Secret for connecting to Project Borealis.

Use only one of the following ways to authenticate your deployment: `armory login` **or** `--clientId` and `--clientSecret` **or** `--authToken`.


**Example**

You are in the directory where your deployment file is located. To deploy your app, execute:

`armory deploy start -f deploy.yaml`

## Generate a blue/green deployment template

Generate a customizable Kubernetes blue/green deployment template.

**Usage**

`armory template kubernetes bluegreen`

**Example**

To generate a template and save the output to a file:

`armory template kubernetes bluegreen > deploy-bluegreen.yaml`

## Generate a canary deployment template

Generate a customizable Kubernetes canary deployment template.

**Usage**

`armory template kubernetes canary [flags]`

**Flags**

- `-f, --features`: Features to include in the template. Available options are `manual`, `automated`, and `traffic`.

**Example**

To generate a canary traffic template and save the output to a file:

`armory template kubernetes canary -f traffic > deploy-canary-traffic.yaml`

## Get the CLI version

**Usage**

`armory version`

</br>
</br>