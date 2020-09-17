---
title: Secrets with AWS Secrets Manager
aliases:
  - /spinnaker-install-admin-guides/secrets/secrets-aws-sm/
---

You can configure AWS Secrets Manager as a secrets engine for Spinnaker. For information about how to set up AWS Secrets Manager, see the [AWS documentation](https://docs.aws.amazon.com/secretsmanager/index.html).


## Referencing secrets stored in AWS Secrets Manager

You can reference a KeyStore or KeyStore password stored in AWS Secrets Manager. Based on which type of secret you want to reference, use one of the following formats:

**Keystore**

```
  keyStore: encryptedFile:secrets-manager!r:<some region>!s:<secret name>
```

**Keystore password**

```
  keyStorePassword: encrypted:secrets-manager!r:<some region>!s:<secret name>!k:some-key
```

* `encryptedFile` or `encrypted` - **Required**. Indicates that this is an encrypted file or an encrypted string, respectively.
* `secrets-manager` - **Required**. Indicates that secrets are stored in AWS Secrets Manager
* `!` - **Required**. Delimiter between parameters.
* `r:<AWS region>` - **Required**. The AWS region your secret is stored in. For example, use `r:us-west-2` for a secret stored in the `us-west-2` region.
* `s:<Secret name>` - **Required**. The name of the secret stored in AWS Secrets Manager
* `k<some-key>` - **Required** for encrypted strings. The Secret key. Omit for KeyStores.

For example, the following example references a KeyStore stored in `us-west-2`:

```
encryptedFile:secrets-manager!r:us-west-2!s:dev--cert
```
