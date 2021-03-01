---
title: Using the ARM CLI to Render Pipline JSON
linkTitle: Using the ARM CLI
description: >
  The Armory (ARM) CLI is a standalone tool that renders dinghyfiles for you to use with Armory's Pipelines as Code feature.
---

This guide assumes that you are familiar with the Pipelines as Code feature. If you are not, see {{< linkWithTitle using-dinghy.md >}}.

## Requirements

Before you start, make sure Pipelines as Code is enabled for your Armory instance. For information about how to do that, see {{< linkWithTitle dinghy-enable.md >}}. 

Additionally, the `dinghyfile` and module repo must be available locally so that the ARM CLI can reference them.

## Installing the ARM CLI

You can either run the ARM CLI in a Docker container or install and run it locally.

### Docker container

The ARM CLI is available on [Docker Hub](https://hub.docker.com/r/armory/arm-cli). To download and run the ARMO CLI, use the following commands:

```bash
# Pull the latest container for the CLI
docker pull armory/arm-cli:latest
# Run the container
docker run -it armory/arm-cli /bin/sh
``` 

You can use the CLI by running the `arm` command in the container. For example, `arm help`

### Download and install

To install the ARM CLI, perform the following steps:

1. Download the latest for your operating system: https://github.com/armory-io/arm/releases.
2. Unzip the package.
3. Add the ARM CLI to your $PATH by creating a symbolic link:
   
   For example, the following command adds `arm-2.1.1-darwin-amd64` in the root directory of the user `milton` to the $PATH:
   
   ```bash
   ln -sf /Users/milton/arm-2.1.1-darwin-amd64 /usr/local/bin/arm
   ```

   Adjust the example for your environment and version.

You can now run the CLI by using the `arm` command. For example: `arm help`

> MacOS: The first time you run the ARM CLI, you may encounter several warning messages depending on your security settings. These messages appear because the ARM CLI is not signed. To resolve the issue, open your **Security & Privacy > General > Allow apps downladed from:** and select **Allow Anyway** for the ARM CLI.


## Integrating with IntelliJ

Optionally, you can integrate the ARM CLI with IntelliJ. This integration allows you to edit and then validate pipeline JSON directly in IntelliJ instead of having to switch to the command line. This process involves adding the CLI as an external tool to IntelliJ:

1. Open IntelliJ and go to **Preferences > Tools > External Tools**.
2. Add an External Tool.
3. Complete the **Create Tool** wizard using the following values for **Tool Settings**:
   
   - **Name:** Name it something descriptive, such as "ARM"
   - **Program:** Use the path to where the CLI is installed
   - **Arguments:** Use the following snippet and substitute the value for your `module` directory: `dinghy render $FilePathRelativeToProjectRoot$ --modules <directory where templates repository checked out locally>`
   - **Working directory:**: Use the following value: `$ProjectFileDir$`

4. Add a keyboard shortcut for the ARM CLI.
   1. Go to **Preferences > Keymap > External Tools > Tool_Name > Add Keyboard Shortcut**.
   2. Map the CLI to a shortcut.

You can now run the CLI on open any `dinghyfile` you have open in IntelliJ.

## Using the ARM CLI

You can watch a video walk through of how to use the ARM CLI:

{{< youtube 08scfRSneq8 >}}
<br>

There is an example folder build in the release zip file. 

The command you run changes slightly based on whether the `dinghyfile` uses modules (or other templating files) or rawdata (`git push` information). You can execute `dinghy render --help` anytime to get current supported parameters.

JSON Example files:

| Filename                                    | Module             | RawData            | Local Module       | Parameters                                                                                                                      |
|---------------------------------------------|--------------------|--------------------|--------------------|---------------------------------------------------------------------------------------------------------------------------------|
| dinghyfile_basic                            | No                | No                | No                | dinghy render ./examples/json/dinghyfile_basic                                                                                       |
| dinghyfile_rawdata                          | No                | Yes | No                | dinghy render ./examples/json/dinghyfile_rawdata --rawdata ./examples/RawData.json                                                   |
| dinghyfile_conditionals                     | No                | No                | No                | dinghy render ./examples/json/dinghyfile_conditionals                                                                                |
| dinghyfile_globals                          | Yes | No                | No                | dinghy render ./examples/json/dinghyfile_globals --modules ./examples/json/modules                                                        |
| dinghyfile_makeSlice                        | Yes | No                | No                | dinghy render ./examples/json/dinghyfile_makeSlice --modules ./examples/json/modules                                                      |
| dinghyfile_makeSlice_conditional_rawdata    | Yes | Yes | No                | dinghy render ./examples/json/dinghyfile_makeSlice_conditional_rawdata --modules ./examples/json/modules --rawdata ./examples/RawData.json|
| dinghyfile_localmodule                      | Yes | No                | No                | dinghy render ./examples/json/dinghyfile_localmodule --modules ./examples/json/modules                                                    |
| dinghyfile_pipelineID                       | No                | No                | No                | dinghy render ./examples/json/dinghyfile_pipelineID                                                                                  |
| dinghyfile_localmodule_parameter            | Yes | No                | Yes | dinghy render ./examples/json/dinghyfile_localmodule_parameter --modules ./examples/json/modules --local_modules ./                       |


YAML Example files:

| Filename                                    | Module             | RawData            | Local Module       | Parameters                                                                                                                      |
|---------------------------------------------|--------------------|--------------------|--------------------|---------------------------------------------------------------------------------------------------------------------------------|
| dinghyfile_basic                            | No                | No                | No                | dinghy render ./examples/yaml/dinghyfile_basic --type yaml                                                                                       |
| dinghyfile_rawdata                          | No                | Yes | No                | dinghy render ./examples/yaml/dinghyfile_rawdata --rawdata ./examples/RawData.json --type yaml                                                  |
| dinghyfile_conditionals                     | No                | No                | No                | dinghy render ./examples/yaml/dinghyfile_conditionals --type yaml                                                                               |
| dinghyfile_globals                          | Yes | No                | No                | dinghy render ./examples/yaml/dinghyfile_globals --modules ./examples/yaml/modules --type yaml                                                        |
| dinghyfile_makeSlice                        | Yes | No                | No                | dinghy render ./examples/yaml/dinghyfile_makeSlice --modules ./examples/yaml/modules --type yaml                                                      |
| dinghyfile_makeSlice_conditional_rawdata    | Yes | Yes | No                | dinghy render ./examples/yaml/dinghyfile_makeSlice_conditional_rawdata --modules ./examples/yaml/modules --rawdata ./examples/RawData.json --type yaml|
| dinghyfile_localmodule                      | Yes | No                | No                | dinghy render ./examples/yaml/dinghyfile_localmodule --modules ./examples/yaml/modules --type yaml                                                   |
| dinghyfile_pipelineID                       | No                | No                | No                | dinghy render ./examples/yaml/dinghyfile_pipelineID --type yaml                                                                                  |
| dinghyfile_localmodule_parameter            | Yes | No                | Yes | dinghy render ./examples/yaml/dinghyfile_localmodule_parameter --modules ./examples/yaml/modules --local_modules ./ --type yaml                       |


### Example

The zip file that you downloaded for the ARM CLI includes several example `dinghyfiles` that you can modify to meet your needs. The following example shows what happens when you render the `dinghyfile_globals` example file:

```bash
$ arm dinghy render ./examples/dinghyfile_globals --modules ./examples/modules --rawdata ./examples/RawData.json --output ./testing
INFO[2020-05-08 15:49:29] Checking dinghyfile                          
INFO[2020-05-08 15:49:29] Reading rawdata file                         
INFO[2020-05-08 15:49:29] Parsing rawdata json                         
INFO[2020-05-08 15:49:29] Parsing dinghyfile                           
INFO[2020-05-08 15:49:29] Parsed dinghyfile                            
INFO[2020-05-08 15:49:29] Output:                                      
{
  "application": "global_vars",
  "globals": {
    "waitTime": "42",
    "waitname": "default-name"
  },
  "pipelines": [
    {
      "application": "global_vars",
      "name": "Made By Armory Pipeline Templates",
      "stages": [
        {
          "name": "default-name",
          "waitTime": "42",
          "type": "wait"
        },
        {
          "name": "overwrite-name",
          "waitTime": "100",
          "type": "wait"
        }
      ]
    }
  ]
}
INFO[2020-05-08 15:49:29] Final dinghyfile is a valid JSON Object. 
```

If the final JSON file is valid, the following message appears: `Final dinghyfile is a valid JSON Object.`
