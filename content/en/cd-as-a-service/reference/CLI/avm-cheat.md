---
title: Armory Version Manager Cheatsheet
linktitle: AVM Cheatsheet
description: >
  This page contains a list of commonly used AVM commands and flags.

---

## Armory Version Manager usage

The Armory Version Manager (AVM) binary is `avm`. Usage is `avm [command]`. Run `avm help` to see a list of commands.

**Global Flags**

- `-h, --help`: Help
- `-v, --verbose`: Verbose output

## AVM autocomplete

Generate the autocompletion script for `avm` for the specified shell.

**Usage**

`avm completion [command]`

**Available Commands**

- `bash`
- `fish`
- `powershell`
- `zsh`

See each available command's help for details on how to use the generated script.

## AVM help

Lists the usage and available commands.

**Usage**

`avm help`

## List CLI versions

### `list`

Lists the installed CLI versions.

**Usage**

`avm list [flags]`

### `listall`

Lists the available CLI versions.

`avm listall [flags]`

## Install or update the CLI

Install an Armory CLI version and create a symlink. If the version is omitted, the AVM installs the latest version.

**Usage**

`avm install [version] [flags]`

**Flags**

- ` -d, --default`: Set version as default

**Examples**

To upgrade to a specific version:

```bash
avm install v0.24.0
```

To upgrade to the latest version:

```bash
avm install
```

## Set the default CLI version

Set the specified CLI version as default. This command first checks to make sure the specified version has been installed. Then it updates the symlink.

**Usage**

`avm use [version] [flags]`

**Example**

Get a list of installed versions:

```bash
avm list
```

Output is similar to:

```bash
v0.19.0
v0.19.1
v0.25.1 [default]
```

Set version "v0.19.1" as default:

```bash
avm use v0.19.1
```

Output is similar to:

```bash
using version: v0.19.1
```

## Get the AVM version

This command returns the Armory Version Manager version. Use [`armory version`]({{< ref "cli-cheat#get-the-cli-version">}}) to determine the CLI version you are using.

**Usage**

`avm version [flags]`

</br>
</br>
