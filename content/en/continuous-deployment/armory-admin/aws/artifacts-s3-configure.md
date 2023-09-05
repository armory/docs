---
title: Configure Amazon Simple Storage Service (S3) Artifacts
linkTitle: "Configure S3 Artifacts"
aliases:
  - /spinnaker_install_admin_guides/s3/
  - /docs/spinnaker-install-admin-guides/s3/
  - /docs/armory-admin/artifacts-s3-configure/
  - /armory-admin/artifacts-s3-configure/
description: >
  Learn how to configure Spinnaker to use Amazon S3 as an artifact source.
---

## S3 artifact configuration

The example on this page describes how to reference a Helm chart tarball for
later use during deployment.

This is a quick walkthrough of how to configure Spinnaker<sup>TM</sup> and
Armory to access an
[S3](https://docs.aws.amazon.com/AmazonS3/latest/gsg/GetStartedWithS3.html)
bucket as a source of artifacts.  Many of the configurations below have
additional options that may be useful (or possibly required).

## Enable S3 artifacts

If you've just installed Spinnaker or Armory, you need to enable S3 as an artifact source.

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

## Add S3 account

You only need to configure the S3 credentials as an account -- all buckets
that account has access to can be referenced after that.

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
            awsSecretAccessKey: abc        # Your AWS Secret Key. This field supports "encrypted" secret references
```

Apply your changes with `kubectl -n <spinnaker namespace> apply -f <SpinnakerService manifest>`.
