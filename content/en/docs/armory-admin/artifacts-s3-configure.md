---
title: "Configuring S3 Artifacts"
aliases:
  - /spinnaker_install_admin_guides/s3/
  - /docs/spinnaker-install-admin-guides/s3/
description: To use a file stored in S3 in your pipeline, configure Spinnaker to use S3 as an artifact source.
---

## Overview

The example on this page describes how to reference a Helm chart tarball for later use during
deployment.

This is just a quick walkthrough of how to configure your Spinnaker to access
an S3 bucket as a source of artifacts.  Many of the configurations below have
additional options that may be useful (or possibly required).  If you need
more detailed help, take a look at the
[Halyard command reference](https://www.spinnaker.io/reference/halyard/commands/#hal-config-artifact-s3-account)

## Enable S3 artifacts

If you haven't done this yet (for example, if you've just installed Armory
Spinnaker fresh), you'll need to enable S3 as an artifact source:

**Operator**

Add the following snippet to `SpinnakerService` manifest:

```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:  
    config:
      features:
        artifacts: true
      artifacts:
        s3:
          enabled: true
```

**Halyard**

```bash
hal config features edit --artifacts true
hal config artifact s3 enable
```

## Add S3 Account

You only need to configure the S3 credentials as an account -- all buckets
that account has access to can be referenced after that.

**Operator**

```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:  
    config:
      features:
        artifacts: true
      artifacts:
        s3:
          enabled: true
          accounts:
          - name: my-s3-account
            region: us-west-2 # S3 region
            awsAccessKeyId: ABCDEF01234... # Your AWS Access Key ID. If not provided, Spinnaker will try to find AWS credentials as described at http://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/credentials.html#credentials-default
            awsSecretAccessKey: abc        # Your AWS Secret Key. This field supports "encrypted" secret references (https://docs.armory.io/spinnaker-install-admin-guides/secrets/)
```

**Halyard**

```bash
hal config artifact s3 account add my-s3-account \
    --region us-west-2 \
    --aws-access-key-id ABCDEF01234... \
    --aws-secret-access-key # Will be prompted for this interactively
```

Detailed information on all command line options can be found [here](https://www.spinnaker.io/reference/halyard/commands/#hal-config-artifact-s3-account-add)

Apply your changes with `kubectl -n <spinnaker namespace> apply -f <SpinnakerService manifest>` if using the Operator, or `hal deploy apply` if using Halyard.
