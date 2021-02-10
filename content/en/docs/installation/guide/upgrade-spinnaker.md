---
title: Upgrading or Downgrading the Armory Enterprise Platform for Spinnaker Version
aliases:
  - /docs/spinnaker-install-admin-guides/upgrade-spinnaker/
description: >
  Update or rollback your Armory Enterprise Platform for Spinnaker version installed with Armory-extended Halyard.
---

## Determining the target version

First, determine which version of Armory you want to use. You can get this list by running `hal version list`.

The command returns information similar to the following:

```bash
+ Get current deployment
  Success
+ Get Spinnaker version
  Success
+ Get released versions
  Success
+ You are on version "1.14.209", and the following are available:
 - 1.14.209 (OSS Spinnaker v1.8.6):
   Changelog: https://docs.armory.io/release-notes/armoryspinnaker_v1.14.209/
   Published: Thu Sep 13 18:42:49 EDT 2018
   (Requires Halyard >= 1.0.0)
 - 2.0.0 (OSS Release 1.9.5):
   Changelog: https://docs.armory.io/release-notes/armoryspinnaker_v2.0.0/
   Published: Fri Nov 02 19:42:47 EDT 2018
   (Requires Halyard >= 1.2.0)

```


## Performing an upgrade

Once you know what version you want to upgrade (or downgrade) to, run the following command:

```bash
hal config version edit --version <target_version>
```

The command returns information similar to the following:

```bash
+ Get current deployment
  Success
+ Edit Spinnaker version
  Success
+ Spinnaker has been configured to update/install version
  "2.19.6". Deploy this version of Spinnaker with `hal deploy apply`.
```

Then, apply your upgrade with `hal deploy apply`.

## Rolling back an upgrade

Rolling an upgrade back is similar to upgrading Armory:

1. Select the version you want to rollback to:
   ```bash
   hal config version edit --version <target_version>
   ```
2. Apply the rollback:
   ```bash
   hal deploy apply
   ```   
