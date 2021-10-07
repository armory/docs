---
title: Get Started with the CLI to Deploy Apps
linktitle: Get Started - CLI
description: >
  The Borealis CLI is a CLI for interacting with Project Borealis. With the CLI, you can manually deploy apps directly from your command line.
exlcude_search: true
---

Before you start, make sure that someone at your organization has completed the [Get Started with Project Borealis]({{< ref "borealis-org-get-started" >}}). That guide describes how to prepare your deployment target so that you can use the Borealis CLI to deploy apps to it.

## Register for Armory's hosted cloud services

{{< include "aurora-borealis/borealis-login-creds" >}}

## Install the Borealis CLI

1. Download the latest release for your operating system: https://github.com/armory/armory-cli/releases.
2. Save the file in a directory that is on your `PATH`, such as `/usr/local/bin`.
3. Rename the downloaded file to `armory`.
4. Give the file execute permission:

   ```
   chmod +x /usr/local/bin/armory
   ```

5. Verfiy that you can run the Borealis CLI:

   ```bash
   armory 
   ```

   The command returns basic information about the CLI, including available commands.

## Manually deploy apps using the CLI

Before you can deploy, make sure that you have the client ID and secret for your deployment target available. These are used to authenticate Armory's hosted cloud services to the target cluster. The credentials were created and tied to your deployment target as part of the [Get Started with Project Borealis]({{< ref "borealis-org-get-started" >}}) guide.

Since you are using the Borealis CLI, you do not need to have  service account credentials for authenticating your CLI to the cloud services. Instead, you will log in manually with your user account.

1. Log in to Armory's hosted cloud services from the CLI:
   
   ```bash
   armory login
   ```

   Provide your Armory hosted cloud services username and password as well as two-factor authentication code when prompted.
2. Generate your deployment template and output it to a file:
   
   ```bash
   armory template canary > canary.yaml
   ```

   This command generates a deployment template for canary deployments and saves it to a file named `canary.yaml`.
   <details><summary>Show me the template</summary>
   
   ```yaml
   SOME YAML HERE
   ```
   </details><br>

3. Customize your deployment file by setting the following minimum set of parameters:

   - `targets.<target-cluster>`: the name of the deployment target cluster. This is the name that was assigned using the `agent-k8s.accountName=my-k8s-cluster` parameter when you installed the RNA.
   - `targets.<target-cluster>.strategy`: the name of the deployment strategy you want to use. You define the strategy in `strategies.<strategy-name>`.
   - `manifests`: a map of manifest locations. This can be a directory of `yaml (yml)` files or a specific manifest. Each entry must use the following convention:  `- path: /path/to/directory-or-file`
   - `strategies.<strategy-name>`: the list of your deployment strategies. Use one of these for `targets.<target-cluster>.strategy`. Each strategy in this section consists of a map of steps for your deployment strategy in the following format:

   ```yaml
   strategies:
     my-demo-strat: # Name that you use for `targets.<target-cluster>.strategy
     - canary # The typoe of deployment strategy to use. Borealis supports `canary`.
        steps:
          - setWeight: 
              weight: <integer> # What percentage of the cluster to roll out the manifest to before pausing.
          - pause:
              duration: <integer> # How long to pause before deploying the manifest to the next threshold.
              unit: <seconds|minutes|hours> # The unit of time for the duration.
          - setWeight:
              weight: <integer> # The next percentage threshold the manifest should get deployed to before pausing.
          - pause:
              untilApproved: true # Wait until a user provides a manual approval before deploying the manifest
   ```

   Each step can have the same or different pause behaviors. Additionally, you can configure as many steps  as you want for the deployment strategy, but you do not need to create a step with a weight set to 100. Once Borealis completes the last step you configure, the manifest gets deployed to the whole cluster automatically.

4. Start the deployment:
   
   ```bash
   armory deploy -c <clientID-for-target-cluster> -s <secret-for-target-cluster>  -f canary.yaml
   ```

## Monitor your deployment

You can monitor the progress of your deployment and approve the steps either through the Borealis CLI itself or from the Status UI. The Status UI gives you a visual representation of a deployment's health and progress in addition to controls.

You can monitor the status of your deployment by running the following command:

```bash
armory deploy status -i <deployment-ID>
```

In addition to monitoring the deployment in the CLI, you can view the status and approve the deployment in the [Status UI]({{< ref "borealis-status-ui" >}}).

## Advanced use cases

You can integrate Borealis with your existing tools, such as Jenkins or GitHub Actions, to automate your deployment process with Borealis.