---
title: Secrets with AWS Secrets Manager
aliases:
  - /docs/spinnaker-install-admin-guides/secrets/secrets-aws-sm/
---

You can configure AWS Secrets Manager as a secrets engine for Spinnaker.  See the AWS Secrets Manager [User Guide](https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html) for how to set up AWS Secrets Manager,

## Authorization
Remember to run the Operator (or Halyard's daemon) and Spinnaker services with IAM roles that allow them to read that content. An example of a policy that can be applied to the role is to allow for access to the SecretsManger and the KMS store
```json
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "kms:ListKeys",
                "kms:ListAliases",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "secretsmanager:GetSecretValue",
                "secretsmanager:ListSecretVersionIds",
                "secretsmanager:ListSecrets"
            ],
            "Resource": "*",
            "Condition": {
                "ForAnyValue:StringEquals": {
                    "secretsmanager:VersionStage": "AWSCURRENT"
                }
            }
        }
    ]
}
```

## Referencing secrets stored in AWS Secrets Manager

You can reference a KeyStore or KeyStore password stored in AWS Secrets Manager. Based on which type of secret you want to reference, use one of the following formats:

**Keystore**

```yaml
  keyStore: encryptedFile:secrets-manager!r:<some region>!s:<secret name>
```

**Keystore password**

```yaml
  keyStorePassword: encrypted:secrets-manager!r:<some region>!s:<secret name>!k:some-key
```

* `encryptedFile` or `encrypted` - **Required**. Indicates that this is an encrypted file or an encrypted string, respectively.
* `secrets-manager` - **Required**. Indicates that secrets are stored in AWS Secrets Manager
* `!` - **Required**. Delimiter between parameters.
* `r:<AWS region>` - **Required**. The AWS region your secret is stored in. For example, use `r:us-west-2` for a secret stored in the `us-west-2` region.
* `s:<Secret name>` - **Required**. The name of the secret stored in AWS Secrets Manager
* `k<some-key>` - **Required** for encrypted strings. The Secret key. Omit for KeyStores.

For example, the following example references a KeyStore stored in `us-west-2`:

```yaml
encryptedFile:secrets-manager!r:us-west-2!s:dev--cert
```
