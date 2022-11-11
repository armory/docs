---
title: Work with Secrets in Spinnaker
linkTitle: "Work with Secrets"
description: >
  This section contains guides for using secrets stored outside of Spinnaker in products such as Hashicorp Vault, Google Cloud Storage, AWS S3, and the AWS Secrets Manager.
aliases:
  - /docs/spinnaker-install-admin-guides/secrets/
  - /docs/spinnaker-install-admin-guides/secrets/secrets/
---

## Overview of storing secrets

Storing Spinnaker<sup>TM</sup> configs in a git repository is a great solution for maintaining versions of your configurations, but storing secrets in plain text is a bad security practice. If you're using the Operator to deploy Spinnaker, separating your secrets from your configs through end-to-end secrets management is already supported. All you need to do is replace secrets in the configuration files with the syntax described here, and Spinnaker will decrypt them as needed.

We can now store secrets (tokens, passwords, sensitive files) separately from the Spinnaker configurations. We'll provide references to these secrets to services that need them.

- Spinnaker services that support decryption will decrypt these secrets upon startup.
- Operator can decrypt these secrets when it needs to use them (e.g. when validating resources).
- Operator can send secret references to the services that support decryption or send decrypted secrets if the service does not support it.


## Using secrets

### Secret format

When referencing string secrets (passwords, tokens) in configs, use the following general format:

```yaml
encrypted:<secret engine>!<key1>:<value1>!<key2>:<value2>!...
```

When referencing files, the same parameters are used but with the `encryptedFile` prefix:

```yaml
encryptedFile:<secret engine>!<key1>:<value1>!<key2>:<value2>!...
```


The keys and values making up the string vary with each secret engine. Refer to the specific documentation for each engine for more information.

### In main configuration

This applies to section `spec.spinnakerConfig.config` of the `SpinnakerService` manifest when using the Operator.

Operator can understand the secrets you provide. If the service you are deploying is able to decrypt secrets, Operator will pass the reference directly. Otherwise it will decrypt the configuration before sending it.

For instance, after replacing the GitHub token in our main config with the encrypted syntax:

```yaml
...
  github:
    enabled: true
    accounts:
    - name: github
      token: encrypted:s3!r:us-west-2!b:mybucket!f:spinnaker-secrets.yml!k:github.token
...
```


You find the following in `/opt/spinnaker/config/clouddriver.yml` inside clouddriver pod:

```yaml
...
  github:
    enabled: true
    accounts:
    - name: github
      token: encrypted:s3!r:us-west-2!b:mybucket!f:spinnaker-secrets.yml!k:github.token
...
```

And for an older release of Clouddriver that does not support decryption:

```yaml
...
  github:
    enabled: true
    accounts:
    - name: github
      token: <TOKEN>
...
```

### In other configuration

You can also provide secret references directly in `SpinnakerService` manifest under section `spec.spinnakerConfig.profiles` when using the Operator as well as directly in Spinnaker services.


### Supported secret engines

Is there a secret engine you'd like us to support? Submit a feature request [here](mailto:hello@armory.io)!
