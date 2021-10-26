---
title: Get Started with the CLI to Deploy Apps
linktitle: Get Started - CLI
description: >
  The Borealis CLI is a CLI for interacting with Project Borealis. With the CLI, you can integrate Borealis into your existing CI/CD tooling. Start by familiarizing yourself with the Borealis CLI and its workflow.
exlcude_search: true
---

## {{% heading "prereq" %}}

Before you start, make sure that someone at your organization has completed the [Get Started with Project Borealis]({{< ref "borealis-org-get-started" >}}). That guide describes how to prepare your deployment target so that you can use the Borealis CLI to deploy apps to it.

## Register for Armory's hosted cloud services

{{< include "aurora-borealis/borealis-login-creds" >}}

## Install the Borealis CLI

The automated install involves installing an Armory Version Manager (AVM) that handles downloading, installing, and updating the Borealis CLI. Using this install method gives you  to way to keep the Borealis CLI updated as well as the ability to switch versions from the command line. The manual installation method involves downloading a specific release from GitHub and installing that release.

> Depending on your operating system, you may need to allow applications from unknown developers to install the CLI. See the documentation for your operating system, such as [macOS](https://support.apple.com/guide/mac-help/open-a-mac-app-from-an-unidentified-developer-mh40616/mac).

{{< tabs name="borealis-cli-install" >}}

{{% tab name="Automated" %}}

1. Download the [AVM](https://github.com/armory/avm/releases/) for your operating system. 
2. Give AVM execute permissions. For example (on macOS):
   
   ```bash
   chmod +x avm-darwin-amd64
   ```

3. Move AVM to a directory on your `PATH`. For example (on macOS):
   
   ```bash
   mv avm-darwin-amd64 /usr/local/bin/avm
   ```

5. Confirm that AVM is on your `PATH`:
   
   ```bash
   echo $PATH
   ```

   The command returns your `PATH`, which should now include `/usr/local/bin/avm`.

6. Run the following command to install the Borealis CLI:
   
   ```bash
   avm install
   ```

   The command installs the Borealis CLI and provides a directory that you need to add to your path, such as `/Users/milton/.avm/bin`. For information about the commands available as part of AVM, run `avm --help`.

7. Run the following command to verify that the Borealis CLI is installed:
   
   ```bash
   armory
   ```

   The command returns basic information about the  Borealis CLI, including available commands.

{{% /tab %}}

{{% tab name="Manual" %}}

1. Download the [latest release](https://github.com/armory/armory-cli/releases) for your operating system.
2. Save the file in a directory that is on your `PATH`, such as `/usr/local/bin`.
3. Rename the downloaded file to `armory`.
4. Give the file execute permission:

   ```bash
   chmod +x /usr/local/bin/armory
   ```

5. Verify that you can run the Borealis CLI:

   ```bash
   armory 
   ```

   The command returns basic information about the CLI, including available commands.

{{% /tab %}}

{{< /tabs >}}

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
   <details><summary>Show me an empty template</summary>
   
   ```yaml
   version: v1
   kind: kubernetes
   application: <appName>
   # Map of Deployment target
   targets:
     # Name of the deployment.
     <name>:
       # The account name that a deployment target cluster got assigned when you installed the Remote Network Agent (RNA) on it.
       account: <accountName>
       # Optionally, override the namespaces that are in the manifests
       namespace:
       # This is the key that references a strategy you define under the strategies section of the file.
       strategy: <strategyName>
   # The list of manifests sources
   manifests:
     # A directory containing multiple manifests. Instructs Borealis to read all yaml|yml files in the directory and deploy all manifests to the target defined in    `targets`.
     - path: /path/to/manifest/directory
     # This specifies a specific manifest file
     - path: /path/to/specific/manifest.yaml
   # The map of strategies that you can use to deploy your app.
   strategies:
     # The name for a strategy, which you use for the `strategy` key to select one to use.
     <strategyName>:
       # The deployment strategy type. As part of the early access program, Borealis supports `canary`.
       canary:
         # List of canary steps
         steps:
           # The map key is the step type. First configure `setWeight` for the weight (how much of the cluster the app should deploy to for a step).
           - setWeight:
               weight: <integer> # Deploy the app to <integer> percent of the cluster as part of the first step. `setWeight` is followed by a `pause`.
           - pause: # `pause` can be set to a be a specific amount of time or to a manual judgment.
               duration: <integer> # How long to wait before proceeding to the next step.
               unit: seconds # Unit for duration. Can be seconds, minutes, or hours.
           - setWeight:
               weight: <integer> # Deploy the app to <integer> percent of the cluster as part of the second step
           - pause:
               untilApproved: true # Pause the deployment until a manual approval is given. You can approve the step through the CLI or Status UI.
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
       - canary # The type of deployment strategy to use. Borealis supports `canary`.
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

   <details><summary>Show me a completed deployment file</summary>

   ```yaml
   version: v1
   kind: kubernetes
   application: ivan-nginx
   # Map of deployment target
   targets:
     # Name of the deployment.
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

    </details><br>

4. Start the deployment:
   
   ```bash
   armory deploy -c <clientID-for-target-cluster> -s <secret-for-target-cluster>  -f canary.yaml
   ```

   The command starts your deployment and progresses until the first weight you set. It also returns a deployment ID that you can use to check the status of your deployment and a link to the Status UI page for your deployment.

## Monitor your deployment

You can monitor the progress of any deployment and approve the steps either through the Borealis CLI itself or from the Status UI. The Status UI gives you a visual representation of a deployment's health and progress in addition to controls.

Run the following command to monitor your deployment through the Borealis CLI:

```bash
armory deploy status -i <deployment-ID>
```

<!-- In addition to monitoring the deployment in the CLI, you can view the status and approve the deployment in the [Status UI]({{< ref "borealis-status-ui" >}}). -->

## Advanced use cases

You can integrate Borealis with your existing tools, such as Jenkins or GitHub Actions, to automate your deployment process with Borealis. To get started, create [service accounts]({{< ref "borealis-automate" >}}).