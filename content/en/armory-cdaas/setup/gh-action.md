---
title: Get Started with the GitHub Action
linktitle: GitHub Action
exclude_search: true
weight: 30
description: >
  Use the Borealis Deployment Action to integrate your GitHub repo with Armory's Project Borealis.
---

## Overview of Project Borealis deployment

You can also learn about this GitHub Action by viewing the [repo](https://github.com/armory/cli-deploy-action).

## {{% heading "prereq" %}}

If you have previously configured Borealis for your deployment target, you can skip to step 3.

1. Review the full set of requirements for Borealis at [System Requirements]({{< ref "requirements" >}}).
2. If you have already prepared a deployment target for Borealis, skip this step. If you have not, complete the [Get Started with Project Borealis]({{< ref "get-started" >}}) tasks, which include the following:

   - Register for an Armory hosted cloud services account. This is the account that you use to log in  to the Armory Cloud Console and the Status UI.
   - [Create machine-to-machine client credentials]({{< ref "client-creds" >}}) for the Remote Network Agent (RNA), which you install on your deployment target cluster.
   - Prepare your deployment target by installing the RNA.

3. In the Cloud Console, create machine-to-machine client credentials to use for your GitHub Action service account. You can select the pre-configured scope group **Deployments using Spinnaker** or manually select the following:

   - `manage:deploy`
   - `read:infra:data`
   - `exec:infra:op`
   - `read:artifacts:data`

4. Encrypt the GitHub Action service account credentials so that you can use them securely in the action. Create a secret for the Client ID and a separate secret for the Client Secret.

   Use descriptive name for these two values. You use the name to reference them in the GitHub Action.

   For more information, see GitHub's [Encrypted secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets) guide.

## Configure the GitHub Action

Configuring the GitHub Action is a multi-part process:

1. [Get your manifest path](#get-your-manifest-path)
1. [Create a deployment file](#create-a-deployment-file)
1. [Configure the action](#configure-the-action)

### Get your manifest path

You need the path to the manifests you want to deploy when you create a deployment file. The value is used for the `path` parameter in the `manifests` block.

Note that the path you provide for the `manifests` block is relative to where the GitHub Action YAML is stored (`.github/workflows`). For example, if your repo looks like this:

```
.github/workflows
deployments
--manifests
----sample-app.yaml
```

Then, the value you use for `path` in the deployment file should be `/deployments/manifests/sample-app.yaml`.

### Create a deployment file

The [deployment file]({{< ref "ref-deployment-file" >}}) is a YAML file that defines what app you want to deploy and how Borealis should deploy it. You can use the [Borealis CLI]({{< ref "cli#manually-deploy-apps-using-the-cli" >}}) to generate a deployment file template.

Save your deployment file to a directory in your repo. You use this path later when you create the GitHub Action for the `path-to-file` parameter.

### Configure the action

> If you are new to using GitHub Actions, see [Quickstart for GitHub Actions](https://docs.github.com/en/actions/quickstart) guide for information about setting up GitHub Actions.

Before you start, you need the path to the deployment file you created earlier. This value is used for the `path-to-file` parameter.

Note that the path you provide for the `path-to-file` parameter is relative to where your GitHub Action YAML is stored (`.github/workflows`). For example, if your repo looks like this:

```
.github/workflows
deployments
--deployment.yaml
```
Then `path-to-file` should be `/deployments/deployment.yaml`.

Save the following YAML file to your `.github/workflows` directory:

```yaml
name: <Descriptive Name>

on:
  push: # What triggers a deployment. For example, `push`.
    branches:
      - <branchName> # What branch triggers a deployment. For example, `main`.

jobs:
  build:
    name: <Descriptive Name> # This name appears on the Actions tab in the GitHub UI.
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Deployment
        uses: armory/cli-deploy-action@main
        with:
          clientId: "${{ secrets.<CLIENTID> }}" # Encrypted client ID that you created in the Armory Cloud Console that has been encrypted with GitHub's encrypted secrets. Replace <CLIENTD> with the name you gave your encrypted secret.
          clientSecret:  "${{ secrets.<CLIENTSECRET> }}" # Client secret that you created in the Armory Cloud Console that has been encrypted with GitHub's encrypted secrets. Replace <CLIENTSECRET> with the name you gave your encrypted secret.
          path-to-file: "/path/to/deployment.yaml" # Path to the deployment file. For more information, see the Create a deployment file section.
```

## Deploy

Now you can trigger a deployment based on what you defined in the action workflow, such as a `push` to the `main` branch.

When the action runs, Borealis starts your deployment, and it progresses to the first weight you set. After completing the first step, what Borealis does next depends on the steps you defined in your deployment file. Borealis either waits a set amount of time or until you provide a manual approval.

You can monitor the progress through the Borealis CLI or the Status UI by using the deployment ID. The GitHub Action provides both the deployment ID and a URL to the Status UI page for the deployment.

To see the deployment ID and the Status UI link, perform the following steps:

1. In your repo, go to the **Actions** tab.
2. Select the workflow run that corresponds to the deployment.
3. Select the GitHub Action. This is the `name` parameter you used in the `jobs` block.
4. In the **Deployment** section, you can find the **Deployment ID** and a link to the **deployment status UI**.

{{< figure src="/images/cdaas/gha-statusUI.jpg" alt="" >}}

### Borealis CLI

```bash
armory deploy status -i <deployment-ID>
```

### Status UI

You need login credentials to access the Status UI, which is part of Armory's hosted cloud services. For the early access program, contact Armory for registration information.


## {{%  heading "nextSteps" %}}
* {{< linkWithTitle "add-context-variables" >}}