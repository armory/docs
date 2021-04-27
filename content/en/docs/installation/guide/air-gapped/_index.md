---
title: Install Armory Enterprise for Spinnaker in Air-Gapped Environments
linkTitle: Air-Gapped Environments
weight: 1
description: >
  Options for deploying Armory Enterprise in an environment that is isolated from the internet.
aliases:
  - /spinnaker-user-guides/plugin-creators/
  - /docs/spinnaker-user-guides/plugin-creators/
---

{{< include "armory-license.md" >}}

## Overview of air-gapped environments

An air-gapped environment is one where any combination of the following conditions are true:

- No access to Armory Bill Of Materials (BOM), which are published on S3
- No ability to pull images from docker.io/armory
- No ability for engineers to deploy with Halyard or the Armory Operator from their machines

If your environment is air-gapped, you have several options for deploying Armory.  



## Host Armory's Bill Of Materials (BOM)

Armory's BOMs are stored in the following bucket and are publicly available: `s3://halconfig`.

If you are unable to access this bucket from the machine running Halyard, host the BOM in either a GCS or S3 compatible storage, such as MinIO.

### Using a custom bucket and BOM

Your GCS or S3 compatible bucket needs to contain a `versions.yml` at the root of the bucket with the following information:

```yaml
latestHalyard: {{< param halyard-armory-version >}}
latestSpinnaker: {{< param armory-version >}}
versions:
- version: {{< param armory-version >}}
  alias: OSS Release <ossVersion> # The corresponding OSS version can be found in the Release Notes
  changelog: <Link to Armory Release Notes for this version>
  minimumHalyardVersion: 1.2.0
  lastUpdate: "1568853000000"
```

`latestHalyard` and `latestSpinnaker` are used to notify users of new version of Halyard and Armory. You can optionally update them with newer versions. `versions` is a list of available versions. It is optional if you don't intend to show new versions when `hal version list` is run.



