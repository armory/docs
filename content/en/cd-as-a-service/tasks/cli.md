---
title: Install and Upgrade the CD-as-a-Service CLI
linkTitle: Install/Upgrade CLI
description: >
  Install the Armory Continuous Deployment-as-a-Service CLI natively on Linux or Mac or use a Docker image. 
categories: ["CD-as-a-Service"]
tags: ["Guides", "Tools", "CLI", "Setup"]
---

## CLI overview

You can install the CLI (`armory`) on your Mac, Linux, or Windows workstation. Additionally, you can run the CLI in Docker. 

On Mac, you can also download, install, and update the CLI using the Armory Version Manager (AVM). The AVM includes additional features such as the ability to list installed CLI versions and to declare which version of the CLI to use.



{{< tabpane text=true right=true >}}
{{% tab header="**Method**:" disabled=true /%}}

{{% tab header="Homebrew" %}}
```bash
brew tap armory-io/armory
brew install armory-cli
```
{{% /tab %}}
{{% tab header="Script Mac/Linux" %}}

You can install the CLI with a one-line script that does the following:

1. Fetches the correct Armory Version Manager binary (`avm`) for your operating system
1. Installs the AVM binary
1. Uses the AVM to install the CLI binary (`armory`)
1. Adds the AVM and the CLI to the path in your bash or zsh profile

Execute the following script on the machine that has access to your Kubernetes cluster:

```bash
curl -sL go.armory.io/get-cli | bash
```

After installation completes, you should start a new terminal session or source your profile.

{{% /tab %}}


{{% tab header="Manual Mac/Linux" %}}
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

{{% /tab %}}

{{% tab header="Docker" %}}
Armory provides the CD-as-a-Service CLI as a [Docker image](https://hub.docker.com/r/armory/armory-cli).

```bash
docker pull armory/armory-cli
```
{{% /tab %}}

{{% tab header="Windows" %}}
Download the latest `armory-cli` Windows executable from the [repo Releases page](https://github.com/armory-io/armory-cli/releases). Install on the machine that has access to your Kubernetes cluster.
{{% /tab %}}

{{< /tabpane >}}


## Upgrade the CLI

{{< tabpane text=true right=true >}}
{{% tab header="**Method**:" disabled=true /%}}
{{% tab header="Homebrew" %}}
```bash
brew upgrade armory-cli
```
{{% /tab %}}
{{% tab header="AVM" %}}
```bash
avm install
```
{{% /tab %}}

{{< /tabpane >}}