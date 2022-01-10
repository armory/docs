---
title: Get Started with the CLI to Deploy Apps
linktitle: Get Started - CLI
description: >
  The Borealis CLI is a CLI for interacting with Project Borealis. With the CLI, you can integrate Borealis into your existing CI/CD tooling. Start by familiarizing yourself with the Borealis CLI and its workflow.
exclude_search: true
---

## {{% heading "prereq" %}}

Before you start, make sure that someone at your organization has completed the [Get Started with Project Borealis]({{< ref "borealis-org-get-started" >}}). That guide describes how to prepare your deployment target so that you can use the Borealis CLI to deploy apps to it.

## Register for Armory's hosted cloud services

Register for Armory's hosted cloud services by accepting the invitation. You should receive an email invite to Borealis from your organization's administrator.

Note that you need a device that can support OTP two-factor authentication, such as a smartphone with the Google Authenticator app.

## Install the Borealis CLI

The automated install involves installing an Armory Version Manager (AVM) that handles downloading, installing, and updating the Borealis CLI. Using this install method gives you  to way to keep the Borealis CLI updated as well as the ability to switch versions from the command line. The manual installation method involves downloading a specific release from GitHub and installing that release. Armory recommends using the automated install method.

{{< tabs name="borealis-cli-install" >}}

{{% tabbody name="Automated (Recommended)" %}}

1. Download the AVM for your operating system and CPU architecture. You can manually download it from the [repo]((https://github.com/armory/avm/releases/) or use the following command:
   
   ```bash
   wget https://github.com/armory/avm/releases/latest/download/avm-<os>-<architecture>
   ```

   For example, the following command downloads the latest version for macOS (Darwin):

   ```bash
   wget https://github.com/armory/avm/releases/latest/download/avm-darwin-amd64
   ```

   You can see the full list of available releases in the [repo](https://github.com/armory/avm/releases/).
2. Give AVM execute permissions. For example (on macOS):
   
   ```bash
   chmod +x avm-darwin-amd64
   ```

4. Confirm that `/usr/local`/bin is on your `PATH`:
   
   ```bash
   echo $PATH
   ```
   The command returns your `PATH`, which should now include `/usr/local/bin/`.

5. Move AVM to `/usr/local/bin`, which is on your `PATH`. For example (on macOS):
   
   ```bash
   # Moves AVM to /usr/local/bin, which is on your PATH
   mv avm-darwin-amd64 /usr/local/bin/avm
   ```

6. Run the following command to install the Borealis CLI:
   
   ```bash
   avm install
   ```

   The command installs the Borealis CLI and returns a directory that you need to add to your path, such as `/Users/milton/.avm/bin`.

   If you get an `developer  cannot be identified error` when trying to run AVM, you must allow AVM to run.

   <details><summary>Show me how to allow AVM to run.</summary>

   On macOS, go to **System Preferences > Security & Privacy > General** and click **Allow Anyway**. 
   
   For more information, see the macOS documentation about [how to open a Mac app from an unidentified developer](https://support.apple.com/guide/mac-help/open-a-mac-app-from-an-unidentified-developer-mh40616/mac).

   </details></br>

7. Add the directory that AVM returned when you ran `avm install` to your path.
  
   <details><summary>Show me how to add the directory.</summary>

   You can either add the path directly to `/etc/paths` or add it to your shell profile. The following steps describe how to add it to your shell profile: 
   1. Edit the resource file for your shell, such as `.bashrc` or .`zshrc`. For example:
    
      ```bash
      vi ~/.bashrc
      ```
    
    1. In the file, find the line for the `PATH` that your resource file exports. They follow the format `export PATH=$HOME/bin:/usr/local/bin:$PATH`.
    2. Insert the path provided by AVM (such as `/Users/brianle/.avm/bin`)before the ending `$PATH`. The line should look similar to this:
   
       ```bash
       export PATH=$HOME/bin:/usr/local/bin::/Users/milton/.avm/bin:$PATH
       ```

    3. Save the file.
    4. Reload your terminal or open a new session.

   </details></br>

8. Run the following command to verify that the Borealis CLI is installed:
   
   ```bash
   armory
   ```

   The command returns basic information about the  Borealis CLI, including available commands.

For AVM or the Borealis CLI, you can use the `--help` option for more information about specific commands.

{{% /tabbody %}}

{{% tabbody name="Manual" %}}

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

{{% /tabbody %}}

{{< /tabs >}}

## Manually deploy apps using the CLI

Before you can deploy, make sure that you have the client ID and secret for your deployment target available. These are used to authenticate Armory's hosted cloud services to the target cluster. The credentials were created and tied to your deployment target as part of the [Get Started with Project Borealis]({{< ref "borealis-org-get-started" >}}) guide.

Since you are using the Borealis CLI, you do not need to have  service account credentials for authenticating your CLI to the cloud services. Instead, you will log in manually with your user account.

If this is the first deployment of your app, Borealis automatically deploys the app to 100% of the cluster since there is no previous version. Subsequent deployments of this app follow the steps defined in your deployment file.

1. Create the directory where the CLI stores your credentials:

   ```bash
   mkdir ~/.armory
   ```

2. Log in to Armory's hosted cloud services from the CLI:
   
   ```bash
   armory login
   ```

   The CLI returns a `Device Code` and opens your default browser. To complete the log in process, confirm the code in your browser.

   After you successfully authenticate, the CLI returns a list of environments.

3. Select the environment you want to log in to.   
4. Generate your deployment template and output it to a file:
   
   ```bash
   armory template kubernetes canary > canary.yaml
   ```

   This command generates a deployment template for canary deployments and saves it to a file named `canary.yaml`.
   <details><summary>Show me an empty template</summary>
   
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
       # (Recommended) Set the namespace that the app gets deployed to. Overrides the namespaces that are in your manifests
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


   </details><br>

5. Customize your deployment file by setting the following minimum set of parameters:

   - `application`: The name of your app.
   - `targets.<deploymentName>`: A descriptive name for your deployment. Armory recommends using the environment name.
   - `targets.<deploymentName>.account`: The name of the deployment target cluster. This is the name that was assigned to the cluster using the `agent-k8s.accountName` parameter when you installed the RNA.
   - `targets.<deploymentName>.strategy`: the name of the deployment strategy you want to use. You define the strategy in `strategies.<strategy-name>`.
   - `manifests`: a map of manifest locations. This can be a directory of `yaml (yml)` files or a specific manifest. Each entry must use the following convention:  `- path: /path/to/directory-or-file`
   - `strategies.<strategy-name>`: the list of your deployment strategies. Use one of these for `targets.<target-cluster>.strategy`. Each strategy in this section consists of a map of steps for your deployment strategy in the following format:

     ```yaml
     strategies:
       my-demo-strat: # Name that you use for `targets.<deploymentName>.strategy
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
     # A descriptive name for the deployment
     dev-west: 
       # The account name that a deployment target cluster got assigned when you installed the Remote Network Agent (RNA) on it.
       account: cdf-dev
       # (Recommended) Set the namespace that the app gets deployed to. Overrides the namespaces that are in your manifests
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

6. Start the deployment:
   
   ```bash
   armory deploy start  -f canary.yaml
   ```

   The command starts your deployment and progresses until the first weight and pause you set. It also returns a deployment ID that you can use to check the status of your deployment and a link to the Status UI page for your deployment.


## Monitor your deployment

You can monitor the progress of any deployment through the Borealis CLI itself or from the Status UI. The Status UI gives you a visual representation of a deployment's health and progress in addition to controls. If your deployment strategy includes a manual approval step, use the Status UI to approve the step and continue.

Run the following command to monitor your deployment through the Borealis CLI:

```bash
armory deploy status -i <deployment-ID>
```

## Advanced use cases

You can integrate Borealis with your existing tools, such as Jenkins or GitHub Actions, to automate your deployment process with Borealis. To get started, create [service accounts]({{< ref "borealis-automate" >}}).

## Troubleshooting

### Developer cannot be verified error when trying to run AVM

Depending on your operating system settings, you may need to allow apps from an unidentified developer in order to use AVM. For macOS, go to **System Preferences > Security & Privacy > General** and click **Allow Anyway**. For more information, see the macOS documentation about [how to open a Mac app from an unidentified developer](https://support.apple.com/guide/mac-help/open-a-mac-app-from-an-unidentified-developer-mh40616/mac).

### `bad CPU type in executable` error

This issue occurs if the AVM version you downloaded does not match your CPU architecture. For example, if you try to run an `arm64` build on a system that is not ARM based. Verify that you downloaded the correct AVM version for your system.

### `error: Error: there was an error writing the credentials file. ` 

This issue occurs because the the directory where the Borealis CLI stores your credentials after you run `armory login` does not exist. You can create the directory by running the following command:

```bash
mkdir ~/.armory/credentials
```
