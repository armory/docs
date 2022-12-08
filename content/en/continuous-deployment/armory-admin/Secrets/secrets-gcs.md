---
title: Secrets with Google Cloud Storage
linkTitle: Secrets with GCS
weight: 50
aliases:
  - /docs/spinnaker-install-admin-guides/secrets-gcs/
  - /docs/spinnaker-install-admin-guides/secrets/secrets-gcs/
description: >
  Learn how to set up Spinnaker secrets in an encrypted GCS bucket.
---

>This example uses a bucket (`mybucket`) to store GitHub credentials and a kubeconfig file.

## Authorize Spinnaker to access the GCS bucket

Since you're storing sensitive information, make sure to protect the bucket by restricting access and [enabling encryption](https://cloud.google.com/storage/docs/encryption/).

Remember to run the Operator deployment and Spinnaker services with permissions to read that content.

## Storing secrets
Store your GitHub credentials in `mybucket/spinnaker-secrets.yml`:

```yaml
github:
  password: <PASSWORD>
  token: <TOKEN>
```

**Note**: You can store the password under different keys than `github.password` and `github.token`. To do so, change how you reference the secret.


## Referencing secrets
Now that secrets are securely stored in the bucket, you reference them in your config files with the following format:

```yaml
encrypted:gcs!b:<bucket>!f:<path to file>!k:<optional yaml key>
```


For example, to reference `github.password` from the file above, use:

```yaml
encrypted:gcs!b:mybucket!f:spinnaker-secrets.yml!k:github.password
```

To reference the content of our kubeconfig file:

```yaml
encrypted:gcs!f:mykubeconfig!b:mybucket
```
