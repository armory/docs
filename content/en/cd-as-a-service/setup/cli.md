---
title: Get Started with the CLI to Deploy Apps
linktitle: CLI
description: >
  Use the CLI to interact with Armory CD-as-a-Service. You can integrate Armory CD-as-a-Service into your existing CI/CD tooling. Start by familiarizing yourself with the CLI and its workflow.

weight: 20
---

## {{% heading "prereq" %}}

* Make sure that your organization has completed the onboarding steps in {{< linkWithTitle "get-started.md" >}}. That guide describes how to prepare your deployment target so that you can use the CLI to deploy apps to it.
* You have login credentials for Armory CD-as-a-Service.

{{% alert title="Supported Operating Systems" color="warning" %}}
The Armory Version Manager and CLI are only supported on Linux and Mac OSX.<br>
They do not run on Windows.
{{% /alert %}}

## Install the Armory CD-as-a-Service CLI

### Docker image

Armory provides the CD-as-a-Service CLI as a [Docker image](https://hub.docker.com/r/armory/armory-cli).

```bash
docker pull armory/armory-cli
```

### Local installation

You can install the Armory Version Manager (AVM) and CLI using a one-line command or you can download the AVM manually.

The AVM enables you to quickly and easily download, install, and update the CLI. The AVM includes additional features such as the ability to list installed CLI versions and to declare which version of the CLI to use.

{{< tabs name="cdaas-cli-install" >}}

{{% tabbody name="Automated" %}}

You can install the CLI with a one-line script that does the following:

1. Fetches the correct Armory Version Manager binary (`avm`) for your Linux or Mac OSX operating system
1. Installs the AVM binary
1. Uses the AVM to install the CLI binary (`armory`)
1. Adds the AVM and the CLI to the path in your bash or zsh profile

Execute the following script on the machine that has access to your Kubernetes cluster:

```bash
curl -sL go.armory.io/get-cli | bash
```

After installation completes, you should start a new terminal session or source your profile.

{{% /tabbody %}}

{{% tabbody name="Manual" %}}

1. Download the AVM for your operating system and CPU architecture. You can manually download it from the [repo](https://github.com/armory/avm/releases/) or use the following command:

   ```bash
   curl -LO https://github.com/armory/avm/releases/latest/download/avm-<os>-<architecture>
   ```

   For example, the following command downloads the latest version for macOS (Darwin):

   ```bash
   curl -LO https://github.com/armory/avm/releases/latest/download/avm-darwin-amd64
   ```

   You can see the full list of available releases in the [repo](https://github.com/armory/avm/releases/).
2. Give AVM execute permissions. For example (on macOS):

   ```bash
   chmod +x avm-darwin-amd64
   ```

4. Confirm that `/usr/local/bin` is on your `PATH`:

   ```bash
   echo $PATH
   ```
   The command returns your `PATH`, which should now include `/usr/local/bin/`.

5. Rename the AVM binary to `avm` and move it to `/usr/local/bin`, which is on your `PATH`. For example (on macOS):

   ```bash
   mv avm-darwin-amd64 /usr/local/bin/avm
   ```

6. Run the following command to install the CLI:

   ```bash
   avm install
   ```

   The command installs the CLI and returns a directory that you need to add to your path, such as `/Users/milton/.avm/bin`.

   If you get an `developer  cannot be identified error` when trying to run AVM, you must allow AVM to run.

   <details><summary>Show me how to allow AVM to run.</summary>

   On macOS, go to **System Preferences > Security & Privacy > General** and click **Allow Anyway**.

   For more information, see the macOS documentation about [how to open a Mac app from an unidentified developer](https://support.apple.com/guide/mac-help/open-a-mac-app-from-an-unidentified-developer-mh40616/mac).

   </details></br>

7. Add the directory that AVM returned when you ran `avm install` to your path.

   <details><summary>Show me how to add the directory.</summary>

   You can either add the path directly to `/etc/paths` or add it to your shell profile. The following steps describe how to add it to your shell profile:
   1. Edit the resource file for your shell, such as `.bashrc`, `.bash_profile`, or .`zshrc`. For example:

      ```bash
      vi ~/.bashrc
      ```

    1. In the file, find the line for the `PATH` that your resource file exports. They follow the format `export PATH=$HOME/bin:/usr/local/bin:$PATH`.
    2. Insert the path provided by AVM (such as `/Users/brianle/.avm/bin`) before the ending `$PATH`. The line should look similar to this:

       ```bash
       export PATH=$HOME/bin:/usr/local/bin::/Users/milton/.avm/bin:$PATH
       ```

    3. Save the file.
    4. Reload your terminal, open a new session, or `source` your terminal profile file (for example, `source .bash_profile`).

   </details></br>

8. Run the following command to verify that the CLI is installed:

   ```bash
   armory
   ```

   The command returns basic information about the  CLI, including available commands.

For the AVM or the CLI, you can use the `-h` flag for more information about specific commands.

{{% /tabbody %}}

{{< /tabs >}}


See the {{< linkWithTitle "avm-cheat.md" >}} and {{< linkWithTitle "cli-cheat.md" >}} pages for more information on AVM and CLI commands.


## Manually deploy apps using the CLI

>Armory CD-as-a-Service manages your Kubernetes deployments using ReplicaSet resources. During the initial deployment of your application using Armory CD-as-a-Service, the underlying Kubernetes deployment object is deleted in a way that it leaves behind the ReplicaSet and pods so that there is no actual downtime for your application. These are later deleted when the deployment succeeds.

Before you can deploy, make sure that you have the Client ID and Client Secret for your deployment target available. These are used to authenticate Armory's hosted deployment services with the target cluster. The credentials were created and tied to your deployment target as part of the {{< linkWithTitle "get-started.md" >}} guide.

Since you are using the CLI, you do not need to have service account credentials for authenticating your CLI to the deployment services. Instead, you log in manually with your user account.

**If this is the first deployment of your app, Armory CD-as-a-Service automatically deploys the app to 100% of the cluster since there is no previous version.** Subsequent deployments of this app follow the steps defined in your deployment file.

1. Log in to Armory's hosted deployment services from the CLI.

   ```bash
   armory login
   ```

   The CLI returns a `Device Code` and opens your default browser. To complete the log in process, confirm the code in your browser.

   After you successfully authenticate, the CLI returns a list of tenants if you have access to more than one. Select the tenant you want to access. Note that most users only have access to one tenant. If you have access to several tenants, you can can [log in directly to your desired tenant]({{< ref "cd-as-a-service/reference/cli/cli-cheat#log-into-armory-cd-as-a-service" >}}) with `armory login -e '<tenant>'`.


1. Generate your deployment template and output it to a file.

   For example, this command generates a deployment template for canary deployments and saves it to a file named `canary.yaml`:

   ```bash
   armory template kubernetes canary > canary.yaml
   ```

1. Customize your deployment file by setting the following minimum set of parameters:

   - `application`: The name of your app.
   - `targets.<deploymentName>`: A descriptive name for your deployment. Armory recommends using the environment name.
   - `targets.<deploymentName>.account`: This is the name of your RNA. If you installed the RNA manually, it is the value that you assigned to the `agentIdentifier` parameter.
   - `targets.<deploymentName>.strategy`: the name of the deployment strategy you want to use. You define the strategy in `strategies.<strategy-name>`.
   - `manifests`: a map of manifest locations. This can be a directory of `yaml (yml)` files or a specific manifest. Each entry must use the following convention:  `- path: /path/to/directory-or-file`
   - `strategies.<strategy-name>`: the list of your deployment strategies. Use one of these for `targets.<target-cluster>.strategy`. If you are using a canary strategy, each strategy in this section consists of a map of steps for your deployment strategy in the following format:

     ```yaml
     strategies:
       my-demo-strat: # Name that you use for `targets.<deploymentName>.strategy
       - canary # The type of deployment strategy to use.
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

   Each step can have the same or different pause behaviors. Additionally, you can configure as many steps  as you want for the deployment strategy, but you do not need to create a step with a weight set to 100. Once Armory CD-as-a-Service completes the last step you configure, the manifest gets deployed to the whole cluster automatically.

   A deployment times out if the pods for your application fail to be in ready state in 30 minutes. You can optionally configure a [deployment timeout]({{< ref "cd-as-a-service/reference/deployfile/ref-deployment-file#deploymentconfig" >}}) by adding a `deploymentConfig` top-level section:

   ```yaml
   deploymentConfig:
     timeout:
       unit: <seconds|minutes|hours>
       duration: <integer>
   ```

   Note that the minimum timeout you can specify is 60 seconds (1 minute).

   <details><summary>Show me a completed deployment file</summary>

   {{< codefile file="cdaas/deploy/deploy.yaml" >}}

    </details><br>

1. (Optional) Ensure there are no YAML issues with your deployment file.

   Since a hidden tab in your YAML can cause your deployment to fail, it's a good idea to validate the structure and syntax in your deployment file. There are several online linters, IDE-based linters, and command line linters such as `yamllint` that you can use to validate your deployment file.

1. Start the deployment.

   ```bash
   armory deploy start  -f canary.yaml
   ```

   The command starts your deployment and progresses until the first weight and pause you set. It also returns a deployment ID that you can use to check the status of your deployment and a link to the Deployments UI page for your deployment.

   Note that you can deploy an app without manually logging into CD-as-a-Service. See the {{< linkWithTitle "cd-as-a-service/tasks/deploy/deploy-with-creds.md" >}} page for details.


## Monitor your deployment

You can monitor the progress of any deployment through the CLI itself or from the Deployments UI. The Deployments UI gives you a visual representation of a deployment's health and progress in addition to controls. If your deployment strategy includes a manual approval step, use the Deployments UI to approve the step and continue.

Run the following command to get a direct link to monitor your deployment using the Deployments UI:

```bash
armory deploy status -i <deployment-ID>
```

### Initial deployment failure

If the initial deployment of your app using Armory CD-as-a-Service fails or is manually rolled back, the ReplicaSet is orphaned rather than deleted. In this situation, you should manually delete the orphaned ReplicaSet _only after the initial deployment runs successfully_.

To delete the orphaned ReplicaSet:
1. Get a list of ReplicaSet objects

   ```bash
   kubectl get rs -n <namespace>
   ```

1. Identify the ReplicaSet with the old version of your application. This is typically the ReplicaSet with the greater age.
1. Delete the orphaned ReplicaSet:

   ```bash
   kubectl delete rs <ReplicaSet_name> -n <namespace>
   ```

## Upgrade the CLI

Run the following command to upgrade your existing CLI:

```bash
avm install
```

## Troubleshooting

### Developer cannot be verified error when trying to run AVM

Depending on your operating system settings, you may need to allow apps from an unidentified developer in order to use AVM. For macOS, go to **System Preferences > Security & Privacy > General** and click **Allow Anyway**. For more information, see the macOS documentation about [how to open a Mac app from an unidentified developer](https://support.apple.com/guide/mac-help/open-a-mac-app-from-an-unidentified-developer-mh40616/mac).

### Bad CPU type

`bad CPU type in executable`

This issue occurs if the AVM version you downloaded does not match your CPU architecture. For example, if you try to run an `arm64` build on a system that is not ARM based. Verify that you downloaded the correct AVM version for your system.

### Error writing credentials file

`error: Error: there was an error writing the credentials file. `

This issue occurs because the the directory where the CLI stores your credentials after you run `armory login` does not exist. You can create the directory by running the following command:

```bash
mkdir ~/.armory/credentials
```

Make sure you are running the lastest version of the CLI.

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "gh-action.md" >}}
* {{< linkWithTitle "add-context-variable.md" >}}
* {{< linkWithTitle "deploy-demo-app.md" >}}



