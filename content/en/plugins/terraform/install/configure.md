---
title: Configure Terraform Integration Optional Features
linkTitle: Configure Features
weight: 10
description: >
  Learn how to configure optional Terraform Integration features in your Spinnaker or Armory CD instance.
---

## Where to configure the Terraform Integration service


* Spinnaker (Spinnaker Operator): `spinnaker-kustomize-patches/plugins/oss/pipelines-as-code/terraformer.yml`; use `spinnaker-kustomize-patches/plugins/oss/pipelines-as-code/terraformer-local.yml` for [Named Profiles](#named-profiles)
* Spinnaker (Halyard): `terraformer.yml` section of your ConfigMap; create a new `terraformer-local.yml` section to configure [Named Profiles](#named-profiles)
* Armory CD: `spinnaker-kustomize-patches/armory/features/patch-terraformer.yml`


## Cloud provider

Terraform Integration is cloud provider agnostic. Terraform commands execute against the terraform binary. All methods of configuring authentication are supported as per Terraform's compatibility and capabilities.

You can also configure a [Named Profile](#named-profiles) that grants access to resources such as AWS.

## Logging and metrics

> If the logging URL is not responsive, Terraform Integration may not process deploys until the URL can be reached.

You can enable logging and metrics for Prometheus by adding the following configuration to the `spec.spinnakerConfig.profiles.terraformer.logging.remote` block in your `SpinnakerService` manifest:

{{< tabpane text=true right=true >}}
{{% tab header="Spinnaker"  %}}
Add the following to your `terraformer.yml` config:

```yaml
logging:
  remote:
    enabled: true
    endpoint: <TheLoggingEndPoint> # For example, https://debug.armory.io
    version: 1.2.3
    customerId: someCustomer123 # Your Armory Customer ID
  metrics:
    enabled: true
    frequency: <Seconds> # Replace with an integer value for seconds based on how frequently you want metrics to be scraped
    prometheus:
      enabled: true
      commonTags: # The following tags are examples. Use tags that are relevant for your environment
        # env: dev
        # nf_app: exampleApp
        # nf_region: us-west-1
```

{{% /tab %}}
{{% tab header="Armory CD"  %}}

```yaml
spec:
  spinnakerConfig:
    profiles:
      terraformer:
        logging:
          remote:
            enabled: true
            endpoint: <TheLoggingEndPoint> # For example, https://debug.armory.io
            version: 1.2.3
            customerId: someCustomer123 # Your Armory Customer ID
          metrics:
            enabled: true
            frequency: <Seconds> # Replace with an integer value for seconds based on how frequently you want metrics to be scraped
            prometheus:
              enabled: true
              commonTags: # The following tags are examples. Use tags that are relevant for your environment
                # env: dev
                # nf_app: exampleApp
                # nf_region: us-west-1
```
{{% /tab %}}
{{< /tabpane >}}


## Named Profiles

When creating pipelines, a Named Profile gives you the ability to reference certain kinds of external sources, such as a private remote repository. The supported credentials are described in [Types of credentials](#types-of-credentials).

### Configure a Named Profile

Configure profiles that you can select when creating a Terraform Integration stage.

{{< tabpane text=true right=true >}}
{{% tab header="Spinnaker (Operator)"  %}}

Add profiles to the  `terraformer-local.yml` file. The following example adds a profile named `pixel-git` for an SSH key secured in Vault. You can find additional profile examples at [Types of credentials](#types-of-credentials).

```yaml
- name: pixel-git # Unique profile name displayed in Deck
  variables:
  - kind: git-ssh
    options:
      sshPrivateKey: encrypted:vault!e:<secret engine>!p:<path to secret>!k:<key>!b:<is base64 encoded?>
```

{{% /tab %}}
{{% tab header="Spinnaker (Halyard)"  %}}

Add profiles to the  `terraformer-local.yml` section of your ConfigMap. The following example adds a profile named `pixel-git` for an SSH key secured in Vault. You can find additional profile examples at [Types of credentials](#types-of-credentials).

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: spin-terraformer-config
  namespace: spinnaker
data:
  terraformer-local.yml |
    profiles:
      - name: pixel-git # Unique profile name displayed in Deck
        variables:
        - kind: git-ssh
          options:
            sshPrivateKey: encrypted:vault!e:<secret engine>!p:<path to secret>!k:<key>!b:<is base64 encoded?>
```

{{% /tab %}}
{{% tab header="Armory CD"  %}}

Add profiles to the  `spec.spinnakerConfig.profiles.terraformer.profiles` section. The following example adds a profile named `pixel-git` for an SSH key secured in Vault. You can find additional profile examples at [Types of credentials](#types-of-credentials).

```yaml
- name: pixel-git # Unique profile name displayed in Deck
  variables:
  - kind: git-ssh
    options:
      sshPrivateKey: encrypted:vault!e:<secret engine>!p:<path to secret>!k:<key>!b:<is base64 encoded?>
```

{{% /tab %}}
{{< /tabpane >}}


Keep in mind:

1. When you create or edit a Terraform Integration stage in the UI, you can select the profile `pixel-git` from a dropdown.
1. When adding profiles:

   * You can add multiple profiles under the `profiles` section.
   * As a best practice, do not commit plain text secrets to `spec.spinnakerConfig.profiles.terraformer`. Instead, use a [secret store]({{< ref "continuous-deployment/armory-admin/Secrets/_index.md" >}}): [Vault]({{< ref "continuous-deployment/armory-admin/Secrets/secrets-vault" >}}), an [encrypted S3 bucket]({{< ref "continuous-deployment/armory-admin/Secrets/secrets-s3" >}}), an [AWS Secrets Manager]({{< ref "continuous-deployment/armory-admin/Secrets/secrets-aws-sm" >}}), or an [encrypted GCS bucket]({{< ref "continuous-deployment/armory-admin/Secrets/secrets-gcs" >}}).
   * For SSH keys, each profile supports only one option parameter at a time. This means that you can use a private key file (`sshPrivateKeyFilePath`) or the key (`sshPrivateKey`) as the option. To use the key file path, use `sshPrivateKeyFilePath` for the option and provide the path to the key file. You can also encrypt the path using a secret store such as Vault. The following `option` example uses `sshPrivateKeyFilePath`:

      ```yaml
      options:
      sshPrivateKeyFilePath: encryptedFile:<secret_store>!e:...
      ```

      For more information, see the documentation for your secret store.

### Add authz to Named Profiles

Armory recommends that you enable authorization for your Named Profiles to provide more granular control and give App Developers better guardrails. When you configure authz for Named Profiles, you need to explicitly grant permission to the roles you want to have access to the profile. Users who do not have permission to use a certain Named Profile do not see it as an option in the UI. Also, any stage that uses a Named Profile that a user is not authorized for fails.

{{% alert color=warning title="Note" %}}
Before you start, make sure you enable Fiat. For more information about Fiat, see [Fiat Overview]({{< ref "fiat-permissions-overview" >}}) and [Authorization (RBAC)](https://spinnaker.io/setup/security/authorization/).
{{% /alert %}}

This example does the following:

* Grants access to the resources and accounts that you need, such as permissions to deploy to AWS via FIAT in Cloud
* Enables FIAT authz to work with Terraformer

```yaml
spec:
  spinnakerConfig:
    profiles:
      terraformer:
        profiles:
          fiat:
            enabled: true
            baseUrl: https://spin-fiat:7003     # ${services.fiat.baseUrl}
```

### Types of credentials

The Terraform integration supports multiple types of credentials for Named Profiles:

* AWS
* SSH
* Static
* Terraform remote backend

If you’re not using AWS, you should configure one of the other credential types in your Named Profile. 

**AWS**

Use the `aws` credential type to provide authentication to AWS. There are two methods you can use to provide authentication - by defining a static key pair or a role that should be assumed before a Terraform action is executed.

For defining a static key pair, supply an `accessKeyId` and a `secretAccessKey`:

```yaml
- name: devops # Unique name for the profile. Shows up in Deck.
  variables:
  - kind: aws # Type of credential
    options:
      accessKeyId: AKIAIOWQXTLW36DV7IEA
      secretAccessKey: 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
```

For assuming a role instead of defining a static set of credentials, supply the ARN of the role to assume:

```yaml
- name: devops # Unique name for the profile. Shows up in Deck.
  variables:
  - kind: aws # Type of credential
    options:
      assumeRole: arn:aws:iam::012345567:role/roleAssume
```

*When assuming a role, if `accessKeyId` and `secretAccessKey` are supplied, the Terraform integration uses these credentials to assume the role. Otherwise, the environment gets used for authentication, such as a machine role or a shared credentials file.*

**SSH Key**

Use the `git-ssh` credential kind to provide authentication to private Git repositories used as modules within your Terraform actions. The supplied SSH key will be available to Terraform for the duration of your execution, allowing it to fetch any modules it needs:

```yaml
- name: pixel-git # Unique name for the profile. Shows up in Deck.
  variables:
  - kind: git-ssh  # Type of credential
    options:
      sshPrivateKey: encrypted:vault!e:<secret engine>!p:<path to secret>!k:<key>!b:<is base64 encoded?>
```

**Static**

Use the `static` credential kind to provide any arbitrary key/value pair that isn't supported by any of the other credential kinds. For example, if you want all users of the `devops` profile to execute against the `AWS_REGION=us-west-2`, use the following `static` credential configuration.

```yaml
- name: devops # Unique name for the profile. Shows up in Deck.
  variables:
  - kind: static # Type of credential
    options:
      name: AWS_REGION
      value: us-west-2
```

**Terraform remote backend**

Use the `tfc` credential kind to provide authentication to remote Terraform backends.

```yaml
- name: milton-tfc # Unique name for the profile. Shows up in Deck.
  variables:
  - kind: tfc
    options:
      domain: app.terraform.io # or Terraform Enterprise URL
      token: <authentication-token> # Replace with your token
```

## Remote backends

The Terraform Integration feature supports using remote backends provided by Terraform Cloud and Terraform Enterprise.

When using remote backends, keep the following in mind:

* The Terraform stage must use the same Terraform version that your Terraform Cloud/Enterprise workspace is configured to run.
* The minimum supported Terraform version is 0.12.0.
* In the Terraform Cloud/Enterprise UI, the type of `plan` action that the Terraform Integration stage performs is a "speculative plan." For more information, see [Speculative Plans](https://www.terraform.io/docs/cloud/run/index.html#speculative-plans) in the Terraform docs.
* You cannot save and apply a plan file.

#### Enable remote backend support

You can use remote backends by configuring the Terraform Integration stage with the following parameters:

* A Terraform version that is 0.12.0 or later and matches the version that your Terraform Cloud/Enterprise runs.
* Reference a remote backend in your Terraform code.

To enable support, add the following config to your `terraformer-local.yml` file in the `.hal/default/profiles` directory:

```bash
terraform:
  remoteBackendSupport: true
```


## Retries

The Terraformer service can retry connections if it fails to fetch artifacts from Clouddriver. Configure the retry behavior in your `terraformer-local.yml` file by adding the following snippet:

```yaml
# terraformer-local.yml
clouddriver:
  retry:
    enabled: true
    minWait: 4s # must be a duration, such as 4s for 4 seconds
    maxWait: 8s # must be a duration, such as 8s for 8 seconds
    maxRetries: 5
```

The preceding example enables retries and sets the minimum wait between attempts to 4 seconds, the maximum wait between attempts to 8s, and the maximum number of retries to 5.

## {{% heading "nextSteps" %}}

* [Use the Terraform Integration stage]({{< ref "plugins/terraform/use.md" >}})