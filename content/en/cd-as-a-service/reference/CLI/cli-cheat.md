---
title: CLI Cheatsheet
linktitle: CLI Cheatsheet
description: >
  This page contains a list of commonly used CLI commands and flags.

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

## Configure CD-as-a-Service

Apply configuration. See {{< linkWithTitle "cd-as-a-service/tasks/tenants/add-tenants.md" >}}, {{< linkWithTitle "cd-as-a-service/tasks/iam/create-role.md" >}}.

**Usage**

`armory config apply -f <path-to-config.yaml>`

### View configuration

**Usage**

`armory config get`

## Deploy an application

**Usage**

`armory deploy start [flags]`

**Flags**

- `--add-context`: (Optional) Comma-delimited list of new context variables in  `name=value` format. These are added to your canary analysis and webhook triggers. Default: `[]`.
- `-n, --application`: (Optional) The app name for deployment.
- `-a, --authToken`: (Optional) The authentication token to use rather than `clientId` and `clientSecret` or user login.
- `-c, --clientId`: (Optional) The Client ID for connecting to Armory CD-as-a-Service.
- `-s, --clientSecret`: (Optional) The Client Secret for connecting to Armory CD-as-a-Service.
- `-f, --file`: (Required) The path to the deployment file.
- `-w, --watch`: (Optional) This blocks the `deploy start` command execution from completing until the deployment has transitioned to its final state (FAILED, SUCCEEDED, CANCELLED, or UNKNOWNin case of an error). Use this flag when you want to see deployment status reported in your terminal or process.
   
   When you run the `deploy start` command with the `-w` flag, you should see output similar to this:

   ```bash
   Waiting for deployment to complete. Status UI: https://console.cloud.armory.io/deployments/pipeline/e6980646-923a-496b-ad87-ad81804187e3?environmentId=437b09db-b6d9-4198-84c2-8aef69f4fd07
   .
   Deployment status changed: RUNNING
   Deployment ID: e6980646-923a-496b-ad87-ad81804187e3
   .
   Deployment status changed: SUCCEEDED
   Deployment e6980646-923a-496b-ad87-ad81804187e3 completed with status: SUCCEEDED
   See the deployment status UI: https://console.cloud.armory.io/deployments/pipeline/e6980646-923a-496b-ad87-ad81804187e3?environmentId=437b09db-b6d9-4198-84c2-8aef69f4fd07
   ```


Use only one of the following ways to authenticate your deployment: `armory login` **or** `--clientId` and `--clientSecret` **or** `--authToken`.


**Examples**

You are in the directory where your deployment file `deploy.yaml` is located. To deploy your app, execute:

`armory deploy start -f deploy.yaml`

To deploy your app with new context variables:

`armory deploy start -f deploy.yml --add-context=pr=myprnumber,jira=myjiranumber`

To deploy your app without first manually logging into CD-as-a-Service, pass your Client ID and Client Secret:

`armory deploy start -c <your-client-id> -s <your-client-secret> -f deploy.yml`


## Download and deploy a sample app

Download a sample app from an Armory repo. Then deploy that sample app.

**Usage**

`armory quick-start`

## Generate deployment templates

### Blue/green

Generate a customizable Kubernetes blue/green deployment template.

**Usage**

`armory template kubernetes bluegreen`

**Example**

To generate a template and save the output to a file:

`armory template kubernetes bluegreen > deploy-bluegreen.yaml`

### Canary

Generate a customizable Kubernetes canary deployment template.

**Usage**

`armory template kubernetes canary -f automated`

**Example**

To generate a canary template and save the output to a file:

`armory template kubernetes canary -f automated > deploy-canary-traffic.yaml`

## Get the CLI version

**Usage**

`armory version`

## Log into Armory CD-as-a-Service

**Usage**

`armory login [flags]`

**Flags**
- `-e, --envName`: (Optional) The name of your Armory CD-as-a-Service environment. Names with spaces must be enclosed in single or double quotes.

**Example**

If your environment is named `dev`, execute:

`armory login -e dev`

If your environment is named `dev team`, execute:

`armory login -e 'dev team'`

If you don't include your environment, the command returns with a list of environments. You must select one to continue.

## Log out of Armory CD-as-a-Service

**Usage**

`armory logout [envName]`

`envName` is optional.

When you execute the `armory logout` command, a prompt appears for user confirmation.



</br>
</br>