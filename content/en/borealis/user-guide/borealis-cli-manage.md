---
title: Manage the Borealis CLI
linkTitle: Manage the CLI
exclude_search: true
---

## Upgrade your Borealis CLI

Version management for the CLI is done through Armory Version Manager (AVM). 

You can run the following command to upgrade to the latest CLI version:

```bash
avm install
```

Optionally, you can include a version number such as `v0.11.2` to install a specific version. To see what versions are available, run the following command:

```bash
avm listall
```

### Change the active Borealis CLI version

You can change the active version of the Borealis CLI using AVM:

```bash
avm use <version>
```

To see what versions you have installed, run the following command:

```bash
avm list
```

## Uninstall AVM and the Borealis CLI

Run the following commands to uninstall AVM and the Borealis CLI:

```bash
sudo rm -rf <borealis-CLI location> # Delete the Borealis CLI. Run `which armory` to find the location
sudo rm /usr/local/bin/avm # Delete AVM
```

For example:

```bash
sudo rm -rf  rm -rf /Users/milton/.avm/
sudo rm /usr/local/bin/avm
```