---
title: Borealis Deployment GitHub Action
linktitle: GitHub Action
exclude_search: true
---

## Overview

<!-- update the GHA readme or docs.armory.io page when making changes to one or the other -->

Project Borealis uses Armory's hosted cloud services to deploy Kubernetes applications to your clusters. When the GitHub Action triggers a deployment, the action sends a deployment request to Armory's hosted cloud services. In turn, the cloud services communicate with your Kubernetes cluster using Armory's Remote Network Agent (RNA) to initiate the deployment.

Borealis supports performing a canary deployment to deploy an app progressively to your cluster by setting weights (percentage thresholds) for the deployment and a pause after each weight is met. For example, you can deploy the new version of your app to 25% of your target cluster and then wait for a manual judgement or a configurable amount of time. This pause gives you time to assess the impact of your changes. From there, either continue the deployment to the next threshold you set or roll back the deployment.

All this logic is defined in a deployment file that you create and store in GitHub.

You can also learn about this GitHub Action by viewing the [repo](https://github.com/armory/cli-deploy-action).

## Prerequisites

If you have previously configured Borealis for your deployment target, you can skip to step 3 for the prerequisites.

1. Review the full set of requirements for Borealis at [System Requirements](https://docs.armory.io/borealis/borealis-requirements/).
2. If you have already prepared a deployment target for Borealis, skip this step. If you have not, complete the [Get Started with Project Borealis](hhttps://docs.armory.io/borealis/quick-start/borealis-org-get-started/) tasks, which include the following:

   - Register for an Armory hosted cloud services account. This is the account that you use to log in  to the Armory Cloud Console and the Status UI.
   - Create machine-to-machine client credentials for the Remote Network Agent (RNA), which gets  installed on your deployment target.
   - Prepare your deployment target by installing the RNA.
   

3. In the Cloud Console, create machine-to-machine client credentials to use for your GitHub Action service account. You can select the pre-configured scope group **Deployments using Spinnaker** or manually select the following:

   - `manage:deploy`
   - `read:infra:data`
   - `exec:infra:op`
   - `read:artifacts:data`

   For more information, see [Integrate Borealis & Automate Deployments](https://docs.armory.io/borealis/quick-start/borealis-integrate/).
4. Encrypt the GitHub Action service account credentials so that you can use them securely in the action. Create a secret for the Client ID and a separate secret for the Client Secret.
   
   Use descriptive name for these two values. You use the name to reference them in the GitHub Action.
   
   For more information, see [Encrypted secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets).

## Configure the GitHub Action

Configuring the GitHub Action is a two-part process:

- Get your manifest path
- Define the deployment file
- Create the action

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

The deployment file is a YAML file that defines what to deploy and how Borealis deploys it. Save this file to a directory in your repo. You use this path later when you create the GitHub Action for the `path-to-file` parameter.

You can generate the deployment file with the Borealis CLI if you have it installed or manually create it.

#### Generate using the CLI

Generate a deployment file with the following command:

```
armory template kubernetes canary > deployment.yaml
```

#### Manually create

```yaml
version: v1
kind: kubernetes
application: <appName>
# Map of Deployment target
targets:
 # A name for this deployment.
  <deploymentName>: 
    # The account name that a deployment target cluster got assigned when you installed the Remote Network Agent (RNA) on it.
    account: <accountName>
    # Optionally, override the namespaces that are in the manifests
    namespace:
    # This is the key that references a strategy you define under in the `strategies.<strategyName>` section of the file.
    strategy: <strategyName>
# The list of manifests sources
manifests:
  # A directory containing multiple manifests. Instructs Borealis to read all yaml|yml files in the directory and deploy all manifests to the target defined in    `targets`.
  - path: /path/to/manifest/directory
  # A specific manifest file
  - path: /path/to/specific/manifest.yaml
# The map of strategies that you can use to deploy your app.
strategies:
  # The name for a strategy. You select one to use with the `targets.strategy` key.
  <strategyName>:
    # The deployment strategy type. As part of the early access program, Borealis supports `canary`.
    canary:
      # List of canary steps
      steps:
        # The map key is the step type. First configure `setWeight` for the weight (how much of the cluster the app should deploy to for a step).
        - setWeight:
            weight: <integer> # Deploy the app to <integer> percent of the cluster as part of the first step. `setWeight` is followed by a `pause`.
        - pause: # `pause` can be set to a be a specific amount of time or to a manual approval.
            duration: <integer> # How long to wait before proceeding to the next step.
            unit: seconds # Unit for duration. Can be seconds, minutes, or hours.
        - setWeight:
            weight: <integer> # Deploy the app to <integer> percent of the cluster as part of the second step
        - pause:
            untilApproved: true # Pause the deployment until a manual approval is given. You can approve the step through the CLI or Status UI.

```

Note that you do not need to configure a `setWeight` step for `100`. Borealis automatically rolls out the deployment to the whole cluster after completing the final step you configure.

#### Example deployment file

<details><summary>Show me an example deployment file</summary>

```yaml
version: v1
kind: kubernetes
application: ivan-nginx
# Map of deployment target
targets:
  # A descriptive name for the deployment
  dev-west: 
    # The account name that a deployment target cluster got assigned when you installed the Remote Network Agent (RNA) on it.
    account: cdf-dev
    # Optionally, override the namespaces that are in the manifests
    namespace: cdf-dev-agent
    # This is the key that references a strategy you define under the strategies section of the file.
    strategy: canary-wait-til-approved
# The list of manifests sources
manifests:
  # A directory containing multiple manifests. Instructs Borealis to read all yaml|yml files in the directory and deploy all manifests to the target defined in    `targets`.
  - path: /deployments/manifests/configmaps
  # A specific manifest file that gets deployed to the target defined in `targets`.
  - path: /deployments/manifests/deployment.yaml
# The map of strategies that you can use to deploy your app.
strategies:
  # The name for a strategy, which you use for the `strategy` key to select one to use.
  canary-wait-til-approved:
    # The deployment strategy type. As part of the early access program, Borealis supports `canary`.
    canary:
      # List of canary steps
      steps:
      # The map key is the step type. First configure `setWeight` for the weight (how much of the cluster the app should deploy to for a step).
      - setWeight:
        - setWeight:
            weight: 33 # Deploy the app to 33% of the cluster.
        - pause: 
            duration: 60 # Wait 60 seconds before starting the next step.
            unit: seconds
        - setWeight:
            weight: 66 # Deploy the app to 66% of the cluster.
        - pause:
            untilApproved: true # Wait until approval is given through the Borealis CLI or Status UI.
```

</details>

### Configure the action

> If you are new to using GitHub Actions, see [Quickstart for GitHub Actions](https://docs.github.com/en/actions/quickstart) for information about setting up GitHub Actions.

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

Now, you can trigger a deployment based on what you defined in the action workflow, such as a `push` to the `main` branch.

When the action runs, Borealis starts your deployment, and it progresses to the first weight you set. After completing the first step, what Borealis does next depends on the steps you defined in your deployment file. Borealis either waits a set amount of time or until you provide a manual approval.

You can monitor the progress through the Borealis CLI or the Status UI by using the deployment ID. The GitHub Action provides both the deployment ID and a URL to the Status UI page for the deployment.

To see the deployment ID and the Status UI link, perform the following steps:

1. In your repo, go to the **Actions** tab.
2. Select the workflow run that corresponds to the deployment.
3. Select the GitHub Action. This is the `name` parameter you used in the `jobs` block.
4. In the **Deployment** section, you can find the **Deployment ID** and a link to the **deployment status UI**.

### Borealis CLI

```bash
armory deploy status -i <deployment-ID>
```

### Status UI

You need login credentials to access the Status UI, which is part of Armory's hosted cloud services. For the early access program, contact Armory for registration information.