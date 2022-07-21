---
title: Secrets with S3
weight: 50
aliases:
  - /docs/spinnaker-install-admin-guides/secrets-s3/
  - /docs/spinnaker-install-admin-guides/secrets/secrets-s3/
description: >
  Learn how to set up Spinnaker secrets in an encrypted S3 bucket.
---

>See the S3 [Getting Started Guide](https://docs.aws.amazon.com/AmazonS3/latest/gsg/GetStartedWithS3.html) for more information on encryption in S3.
This example uses a bucket (`mybucket`) in the `us-west-2` region to store GitHub credentials and a kubeconfig file. You reference the bucket by its URL `mybucket.us-west-2.amazonaws.com`.

## Authorize Spinnaker to access the S3 bucket
Since you're storing sensitive information, make sure to protect the bucket by restricting access and [enabling encryption](https://docs.aws.amazon.com/AmazonS3/latest/user-guide/default-bucket-encryption.html).

Remember to run the Operator and Spinnaker<sup>TM</sup> services with IAM roles that allow them to read the keys stored in the AWS S3 Bucket.

## Storing secrets
### Storing credentials
Store your GitHub credentials in `mybucket/spinnaker-secrets.yml`:

```yaml
github:
  password: <PASSWORD>
  token: <TOKEN>
```

Note: *You could choose to store the password under different keys than `github.password` and `github.token`. You’d just need to change how to reference the secret further down.*

### Storing sensitive files
Some Spinnaker configuration uses information stored as files. For example, upload the `kubeconfig` file of your Kubernetes account directly to `mybucket/mykubeconfig`:

```yaml
aws s3 cp /path/to/mykubeconfig s3://mybucket/mykubeconfig
```

## Referencing secrets
Now that secrets are safely stored in the bucket, you reference them from your config files with the following format. The S3 specific parameters (`r:<region>`, `b:<bucket>`, etc) can be in any order:

```yaml
encrypted:s3!r:<region>!b:<bucket>!f:<path to file>!k:<optional yaml key>
```


For example, to reference `github.password` from the file above, we'll use:
```yaml
encrypted:s3!r:us-west-2!b:mybucket!f:spinnaker-secrets.yml!k:github.password
```

And to reference the content of our kubeconfig file:
```yaml
encryptedFile:s3!r:us-west-2!b:mybucket!f:mykubeconfig
```
