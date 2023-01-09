---
title: Get Started with the GitHub Action to Deploy Apps
linkTitle: GitHub Action
weight: 30
description: >
  Use the Armory CD-as-a-Service Deployment Action to integrate your GitHub repo with Armory CD-as-a-Service.
---

## Overview of the Armory Continuous Deployment-as-a-Service GitHub Action

This Action enables deploying your app based on a specific GitHub trigger, such as a push to the main branch of your repo. You can configure the action to return immediately or wait for a final deployment state before exiting. 

You can find the Action in the [GitHub Action Marketplace](https://github.com/marketplace/actions/armory-continuous-deployment-as-a-service).

## {{% heading "prereq" %}}

If you have previously configured Armory CD-as-a-Service for your deployment target, you can skip to step 3.

1. Review the full set of requirements for Armory CD-as-a-Service at [System Requirements]({{< ref "requirements" >}}).
1. If you have already prepared a deployment target for Armory CD-as-a-Service, skip this step. If you have not, complete the {{< linkWithTitle "get-started.md" >}} tasks, which include the following:

   - [Register for Armory CD-as-a-Service]({{< ref "cd-as-a-service/setup/get-started" >}}).
   - [Create machine-to-machine client credentials]({{< ref "client-creds" >}}) for the Remote Network Agent (RNA), which you install on your deployment target cluster.
   - Add a Kubernetes Cluster by installing the RNA.

1. (Optional) [Install the CD-as-a-Service CLI]({{< ref "cd-as-a-service/setup/cli#local-installation" >}}) on your workstation. You can use the CLI to generate a deployment file template. You can also create a deployment file manually. See {{< linkWithTitle "cd-as-a-service/reference/ref-deployment-file.md" >}}.
1. If you are new to using GitHub Actions, see GitHub's [Quickstart for GitHub Actions](https://docs.github.com/en/actions/quickstart) guide for information about setting up GitHub Actions.
1. [Create a CD-as-a-Service Client Credential]({{< ref "cd-as-a-service/tasks/iam/client-creds" >}}) for your GitHub Action to use to connect to CD-as-a-Service. Assign the `Deployments Full Access` role to your credential.
1. Create GitHub secrets for the Client ID and a Client Secret so you don't expose them in plain text in your GitHub workflow file. Use descriptive name for these two values. You use the name to reference them in the GitHub Action. For more information, see GitHub's [Encrypted secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets) guide.

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
name: <descriptive-name> # This name appears on the Actions tab in the GitHub UI.

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
   
* `waitForDeployment`: (Optional); Default: false; this blocks the GitHub Action from completing until the deployment has transitioned to its final state (FAILED, SUCCEEDED, CANCELLED, or UNKNOWN if there is an error).

When the Action is done running, it prints out the Deployment ID, a link to the Deployments UI, and optionally the deployment's final state. It also returns that information in output parameters that you can use elsewhere in your workflow:

* `DEPLOYMENT_ID`: This is the unique deployment identifier, which you can use to query the status of the deployment in UI.
* `LINK`: This is the link to the UI, where you can check the state of the workflow and advance it to the next stages if you have manual judgments.
* `RUN_RESULT`: If you configured 'waitForDeployment=true', this variable contains final state of the deployment (FAILED, SUCCEEDED, CANCELLED, or UNKNOWN if there is an error).

You could, as a simplistic example, add a step that prints out the values of the output parameters:

```yaml
- name: Print Armory CD-as-a-Service Deployment Output
  id: output
  run: echo -e 'DeploymentID ${{steps.deploy.outputs.DEPLOYMENT_ID}}\nLink ${{steps.deploy.outputs.LINK}}\n${{steps.deploy.outputs.RUN_RESULT}}'
```

See GitHub's [Using workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows) content for more information.

### Example configuration

For this scenario:

1. You created secrets called `CDAAS_CLIENT_ID` AND `CDAAS_CLIENT_SECRET`.
1. Your `deployment.yaml` file is in the root of your repo.
1. You want to deploy when a pull request is merged to the `main` branch.
1. You want the Armory GitHub Action to run until it receives a final deployment status from CD-as-a-Service.
1. You want to print the output from the Armory GitHub Action in a separate step.

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

Now you can trigger a deployment based on what you defined in the workflow, such as a push to the main branch.

When the Action runs, Armory CD-as-a-Service starts your deployment, and it progresses to the first weight you set. After completing the first step, what Armory CD-as-a-Service does next depends on the steps you defined in your deployment file. Armory CD-as-a-Service either waits a set amount of time or until you provide a manual approval.

You can monitor the progress by using the Deployments UI. The GitHub Action provides both the deployment ID and a URL to the Deployments UI page for the deployment.

To see the deployment ID and the Deployments UI link, perform the following steps:

1. In your repo, go to the **Actions** tab.
2. Select the workflow run that corresponds to the deployment.
3. Select the GitHub Action. This is the `name` parameter you used in the `jobs` block.
4. In the **Deployment** section, you can find the **Deployment ID** and a link to the **deployment status UI**.

{{< figure src="/images/cdaas/gha-statusUI.jpg" alt="" >}}

## {{%  heading "nextSteps" %}}

* {{< linkWithTitle "cd-as-a-service/reference/ref-deployment-file.md" >}}
* {{< linkWithTitle "add-context-variable.md" >}}
