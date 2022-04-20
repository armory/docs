---
title: Armory Version Manager Cheatsheet
linktitle: AVM Cheatsheet
description: >
  This page contains a list of commonly used AVM commands and flags.
exclude_search: true
---

## Armory Version Manager usage

The Armory Version Manager (AVM) binary is `avm`. Usage is `avm [command]`. Run `avm help` to see a list of commands.

**Global Flags**

- `-h, --help`: Help.
- `-v, --verbose`: Verbose output.

## AVM autocomplete

Generate the autocompletion script for `avm` for the specified shell.

**Usage**

`avm completion [command]`

**Available Commands**

- bash
- fish
- powershell
- zsh

Use `avm completion [command] --help` for more information about a command.

## AVM help

Lists the usage and available commands.

**Usage**

`avm help`

## List CLI versions

### list

Lists the installed CLI versions.

**Usage**

`avm list [flags]`

### listall

Lists the available CLI versions.

`avm listall [flags]`

## Install or update the CLI

Install an Armory CLI version. If the version is omitted, the AVM installs the latest version and links to it as default.

**Usage**

`avm install [version] [flags]`

**Flags**

- ` -d, --default`: Set version as default

## Use the specified CLI version

Set the specified CLI version as default. This changes the symlink but does not update your path.

**Usage**

`avm use [version] [flags]`


## Get the AVM version

**Usage**

`avm version [flags]`
