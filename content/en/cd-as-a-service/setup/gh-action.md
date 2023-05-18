---
title: Get Started with the GitHub Action to Deploy Apps
linkTitle: Deploy Using GitHub Action
weight: 30
description: >
  Use the Armory CD-as-a-Service Deployment Action to integrate your GitHub repo with Armory CD-as-a-Service.
---

## Overview of the Armory Continuous Deployment-as-a-Service GitHub Action

This Action enables deploying your app based on a specific GitHub trigger, such as a push to the main branch of your repo. You can configure the action to return immediately or wait for a final deployment state before exiting. 

You can find the Action in the [GitHub Action Marketplace](https://github.com/marketplace/actions/armory-continuous-deployment-as-a-service).

## {{% heading "prereq" %}}

If you have previously configured Armory CD-as-a-Service for your deployment target, you can skip to step 3.

1. Review the CD-as-a-Service [system requirements]({{< ref "cd-as-a-service/concepts/architecture/system-requirements" >}}).
1. If you have already prepared a deployment target for Armory CD-as-a-Service, skip this step. If you have not, complete the the following:

   - [Register for Armory CD-as-a-Service](https://go.armory.io/signup/).
   - [Create machine-to-machine client credentials]({{< ref "cd-as-a-service/tasks/iam/client-creds" >}}) for the Remote Network Agent (RNA), which you install on your deployment target cluster.
   - Connect your Kubernetes cluster by [installing the RNA]({{< ref "cd-as-a-service/tasks/networking/install-agent" >}}).

1. (Optional) [Install the CD-as-a-Service CLI]({{< ref "cd-as-a-service/setup/cli#local-installation" >}}) on your workstation. You can use the CLI to generate a deployment file template. You can also create a deployment file manually. See {{< linkWithTitle "cd-as-a-service/reference/ref-deployment-file.md" >}}.
1. If you are new to using GitHub Actions, see GitHub's [Quickstart for GitHub Actions](https://docs.github.com/en/actions/quickstart) guide for information about setting up GitHub Actions.
1. [Create a CD-as-a-Service Client Credential]({{< ref "cd-as-a-service/tasks/iam/client-creds" >}}) for your GitHub Action to use to connect to CD-as-a-Service. Assign the `Deployments Full Access` role to your credential.
1. Create GitHub [secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets) for the Client ID and a Client Secret so you don't expose them in plain text in your GitHub workflow file. Use descriptive name for these two values. You reference these secrets when you configure the CD-as-a-Service GitHub Action.

## Use the GitHub Action

Configuring the GitHub Action is a multi-part process:

1. [Determine your manifest path](#determine-your-manifest-path)
1. [Create a deployment file](#create-a-deployment-file)
1. [Configure the action](#configure-the-action)

### Determine your manifest path

Decide where you are going to store the app manifest(s) you want to deploy to CD-as-a-Service. You need to know this path when you create your deployment file. 

Note that the path is relative to where the GitHub Action YAML is stored (`.github/workflows`). For example, if your repo looks like this:

```
.github
--workflows
---cdaas-deploy-workflow.yaml
deployments
--deployment.yaml
--manifests
---sample-app.yaml
```

Then the value you use for `manifests.path` in your `deployment.yaml` would be `/deployments/manifests/sample-app.yaml`.

### Create a deployment file

{{< include "cdaas/create-config.md" >}}

Save your deployment file to a directory in your repo. You use this path later when you configure the GitHub Action's `path-to-file` parameter.

### Configure the action

Create a file in the `.github/workflows` directory.  The content format is:

```yaml
name: <descriptive-name> # This name appears in the Actions screen in the GitHub UI.

on:
  push: # What triggers a deployment. For example, `push`.
    branches:
      - <branchName> # What branch triggers a deployment. For example, `main`.

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Armory CD-as-a-Service Deployment
        id: deploy
        uses: armory/cli-deploy-action@main
        with:
          clientId: "<github-secret-name-for-client-id>" 
          clientSecret:  "<github-secret-name-for-client-secret>" 
          path-to-file: "<path-to-deployment-file>" 
          waitForDeployment: <true-or-false>
```

**Armory  CD-as-a-Service Deployment job**

* `clientId`: GitHub secret that you created for your CD-as-a-Service Client ID. For example, if you named your secret **CDAAS_CLIENT_ID**, the value for `clientId` would be `"${{ secrets.CDAAS_CLIENT_ID }}"`.
* `clientSecret`: GitHub secret that you created for your CD-as-a-Service Client ID. For example, if you named your secret **CDAAS_CLIENT_SECRET**, the value for `clientSecret` would be `"${{ secrets.CDAAS_CLIENT_SECRET }}"`.
* `path-to-file`: Relative path to your deployment file. The path you provide for the `path-to-file` parameter is relative to where your GitHub Action YAML is stored (`.github/workflows`). 

   For example, if your repo looks like this:

   ```
   .github
   --workflows
   ---cdaas-deploy.yaml
   deployments
   --deployment.yaml
   --manifests
   ---sample-app.yaml
   ```

   Then `path-to-file` would be `/deployments/deployment.yaml`.
   
* `waitForDeployment`: (Optional); Default: false; this blocks the GitHub Action from completing until the deployment has transitioned to its final state (FAILED, SUCCEEDED, CANCELLED).

When the Action is done running, it prints out the Deployment ID, a link to the Deployments UI, and optionally the deployment's final state. It also returns that information in output parameters that you can use elsewhere in your workflow:

* `DEPLOYMENT_ID`: This is the unique deployment identifier, which you can use to query the status of the deployment in UI.
* `LINK`: This is the link to the UI, where you can check the state of the workflow and advance it to the next stages if you have manual judgments.
* `RUN_RESULT`: If you configured 'waitForDeployment=true', this variable contains the final state of the deployment (FAILED, SUCCEEDED, CANCELLED).

You could, as a simplistic example, add a job step that prints out the values of the output parameters:

```yaml
steps:
...
   - name: Print Armory CD-as-a-Service Deployment Output
     id: output
     run: echo -e 'DeploymentID ${{steps.deploy.outputs.DEPLOYMENT_ID}}\nLink ${{steps.deploy.outputs.LINK}}\n${{steps.deploy.outputs.RUN_RESULT}}'
```

See GitHub's [Using workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows) content for more information.

### Example configuration

For this scenario:

1. You created secrets called `CDAAS_CLIENT_ID` AND `CDAAS_CLIENT_SECRET`.
1. Your `deployment.yaml` file is in the `deployments` directory of your repo.
1. You want to deploy when a pull request is merged to the `main` branch.
1. You want the Armory GitHub Action to run until it receives a final deployment status from CD-as-a-Service.
1. You want to print the output from the Armory GitHub Action in a separate job step.

Your workflow file contents looks like this:

```yaml
name: Deploy to CD-as-a-Service

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Deploy app
        id: deploy
        uses: armory/cli-deploy-action@main
        with:
          clientId: ${{ secrets.CDAAS_CLIENT_ID }}
          clientSecret: ${{ secrets.CDAAS_CLIENT_SECRET }}
          path-to-file: "/deployments/deployment.yaml"
          waitForDeployment: true

      - name: Print deploy output
        id: output
        run: echo -e 'DeploymentID ${{steps.deploy.outputs.DEPLOYMENT_ID}}\nLink ${{steps.deploy.outputs.LINK}}\n${{steps.deploy.outputs.RUN_RESULT}}'
```


## Trigger a deployment

After you have created your deployment file and configured your workflow, you can trigger a CD-as-a-Service deployment based on the trigger you defined in your workflow. 

You can monitor your deployment's progress in the GitHub UI or in the CD-as-a-Service UI. Be sure to you know how to access a GitHub Action [workflow run log](https://docs.github.com/en/act##ions/monitoring-and-troubleshooting-workflows/about-monitoring-and-troubleshooting) before you begin.

1. **GitHub workflow run log**: Use `waitForDeployment: true` in your job and watch the Action output in the workflow run log.

   Output is similar to:

   ```bash
   Waiting for deployment to complete. Status UI: https://console.cloud.armory.io/deployments/pipeline/f4e1fbfe-641f-4613-aff3-0699698d5aed?environmentId=82431eae-1244-4855-81bd-9a4bc165f90b
   .
   Deployment status changed: RUNNING
   .....
   Deployment status changed: PAUSED
   ..
   Deployment status changed: RUNNING
   ...
   Deployment status changed: PAUSED
   ..
   Deployment status changed: RUNNING
   Deployment ID: f4e1fbfe-641f-4613-aff3-0699698d5aed
   .....
   Deployment status changed: SUCCEEDED
   Deployment f4e1fbfe-641f-4613-aff3-0699698d5aed completed with status: SUCCEEDED
   See the deployment status UI: https://console.cloud.armory.io/deployments/pipeline/f4e1fbfe-641f-4613-aff3-0699698d5aed?environmentId=82431eae-1244-4855-81bd-9a4bc165f90b
   ```

1. **CD-as-a-Service Deployments UI**: Obtain the **Deployments** UI direct link from the Action output.

   When you configure `waitForDeployment: false`, the Action immediately prints out the Deployment ID and a link to the **Deployments** UI and then exits. Output is similar to:

   ```bash
   Deployment ID: 065e9c2c-5e3e-4e6a-a591-bdd756a497c2
   See the deployment status UI: https://console.cloud.armory.io/deployments/pipeline/065e9c2c-5e3e-4e6a-a591-bdd756a497c2?environmentId=82431eae-1244-4855-81bd-9a4bc165f90b
   ```

>Note: if you configured a manual approval in your strategy, you must use the CD-as-a-Service Deployments UI to issue that approval.

## {{%  heading "nextSteps" %}}

* {{< linkWithTitle "cd-as-a-service/troubleshooting/tools.md" >}}
* {{< linkWithTitle "cd-as-a-service/reference/ref-deployment-file.md" >}}
* {{< linkWithTitle "add-context-variable.md" >}}
