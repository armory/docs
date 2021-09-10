---
title: Configure Armory Halyard
weight: 10
aliases:
  - /docs/spinnaker-install-admin-guides/configure-halyard/
description: >
  Configure Armory-extended Halyard profiles and storage.
categories: ["install", "config"]
tags: ["Halyard"]
---

## Overview of Armory Halyard

Armory-extended Halyard extends open source [Halyard]().

Armory-extended Halyard can be configured via `/opt/spinnaker/config/halyard.yml`. If you run the Docker image, you can provide your own configuration by mounting the file or directory to the container. If you're running the Armory Operator, you can also configure the behavior of the internal Halyard by creating a Kubernetes ConfigMap and mounting it to the Halyard container.

```yaml
halyard:
  halconfig:
    directory: <user's home directory>/.hal

spinnaker:
  artifacts:
    debianRepository:
    dockerRegistry:
    googleImageProject:
  config:
    input:
      bucket: halconfig
      region: us-west-2
```

## Profiles
You can choose a different location for your Armory configuration by changing `halyard.halconfig.directory`. The Halyard daemon needs to be able to read and write to that location.


## Versions
Armory-extended Halyard stores all the versions in a public s3 bucket (`halconfig`). Sometimes, clients prefer to store the versions in a storage under their control.

### Using a different s3 bucket
To use a different s3 bucket, you just need to change these two properties to point to your own bucket:
```yaml
spinnaker:
  config:
    input:
      bucket: mybucket
      region: us-west-1
```

### Using a private s3 bucket
By default Armory-extended Halyard will access version definitions and bills of materials without using the host's s3 credentials. You can force it to sign the s3 requests by adding:

```yaml
spinnaker.config.input.anonymousAccess: false
```

With that change, you'll need to pass AWS credentials to Halyard's daemon - for instance by specifying environment variables:
```bash
docker run --name armory-halyard --rm \
    -e AWS_ACCESS_KEY_ID=<AWS account key> \
    -e AWS_SECRET_ACCESS_KEY=<AWS secret key> \
    -v ~/.hal:/home/spinnaker/.hal \
    -v ~/.kube:/home/spinnaker/.kube \
    -it docker.io/armory/halyard-armory:{{< param halyard-armory-version >}}
```

### Using a private s3 bucket with assume role

Armory-extended Halyard can be configured to assume a specified role when accessing the bucket:
```yaml
spinnaker.config.input.assumeRoleArn: <role arn to assume>
```

### Using an s3 compatible storage
If you're using an s3 compatible storage such as minio, you can override the endpoint:

```yaml
spinnaker.config.input.endpoint: http://192.168.1.1:9000
```

You can also enable [path-style](https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingBucket.html#access-bucket-intro) access with:

```yaml
spinnaker.config.input.enablePathStyleAccess: true
```
