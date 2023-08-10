---
linkTitle: Armory CD
title: Enable the Terraform Integration Stage in Armory Continuous Deployment
weight: 1
description: >
  Learn how to configure the Terraform Integration stage so that app developers can provision infrastructure using Terraform as part of their delivery pipelines.
---
![Proprietary](/images/proprietary.svg)



## {{% heading "prereq" %}}

* Basic auth credentials for the Git repository where your store your Terraform scripts. The Terraform Integration plugin needs access to credentials to download directories that house your Terraform templates.
  * You can configure your Git repo with any of the following:
    * A Personal Access Token (potentially associated with a service account). For more information, see [Generating a Github Personal Access Token (PAT)](#generating-a-github-personal-access-token-pat).
    * SSH protocol in the form of an SSH key or an SSH key file
    * Basic auth in the form of a user and password, or a user-password file
* A source for Terraform Input Variable files (`tfvar`) or a backend config. You must have a separate artifact provider that can pull your `tfvar` file(s). The Terraform Integration plugin supports the following artifact providers for `tfvar` files and backend configs:
  * GitHub
  * BitBucket
  * HTTP artifact
* A dedicated external Redis instance
  * Armory requires configuring a dedicated external Redis instance for production usage of the Terraform Integration plugin. This is to ensure that you do not encounter scaling or stability issues in production. For more information see the [Redis](#redis) section.

### Redis

The Terraform Integration plugin uses Redis to store Terraform logs and plans.

>You can only configure the Terraform Integration plugin to use a password with the default Redis user.

To set/override the Armory Continuous Deployment Redis settings do the following:

In `SpinnakerService` manifest:

```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      terraformer:
        redis:
          baseUrl: "redis://spin-redis:6379"
          password: "password"
```

```bash
kubectl -n spinnaker apply -f spinnakerservice.yml
```


### Generate a GitHub Personal Access Token (PAT)

Skip this section if you are using BitBucket, which requires your username and password.

Before you start, you need a GitHub Personal Access Token (PAT). The Terraform Integration authenticates itself using the PAT to interact with your GitHub repositories. You must create and configure a PAT so that the Terraform Integration can pull a directory of Terraform Templates from GitHub. Additionally, the Spinnaker GitHub artifact provider require a PAT for `tfvar` files.

Make sure the PAT you create meets the following requirements:

* The token uses a distinct name and has the **repo** scope.
* If your GitHub organization uses Single Sign-On (SSO), enable
the SSO option for the organizations that host the Terraform template(s) and Terraform `tfvar` files.  

For more information about how to generate a GitHub PAT, see [Creating a Personal Access Token for the Command Line](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line).

## Configure your artifact accounts

The Terraform Integration uses the following artifact accounts:
  * **Git Repo** - To fetch the repo housing your main Terraform files.
  * **GitHub, BitBucket or HTTP** - *Optional*. To fetch single files such as var-files or backend config files.


### Configure the Git Repo artifact

Spinnaker uses the Git Repo Artifact Provider to download the repo containing your main Terraform templates

If you already have a Git Repo artifact account configured in Spinnaker,
skip this section.



Edit the `SpinnakerService` manifest to add the following:

```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      clouddriver:
        artifacts:
          gitRepo:
            enabled: true
            accounts:
            - name: gitrepo
              token: <Your GitHub PAT> # GitHub personal access token
```


For more configuration options, see [Git Repo](https://spinnaker.io/setup/artifacts/gitrepo/).

## Configure Terraform Integration for GitHub

These *(optional)* steps describe how to configure GitHub as an artifact provider for the Terraform Integration. For information about BitBucket, see [Configuring the Terraform Integration with BitBucket](#configuring-the-terraform-integration-with-bitbucket).


#### Enable and configure the GitHub Artifact Provider

Spinnaker uses the Github Artifact Provider to download any referenced `tfvar`
files.

If you already have a GitHub artifact account configured in Spinnaker,
skip this section.

{{% alert title="Note" %}}The following examples use `github-for-terraform` as a unique identifier for the artifact account. Replace it with your own identifier.
{{% /alert %}}



Edit the `SpinnakerService` manifest to add the following:

```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      artifacts:
        github:
          accounts:
          - name: github-for-terraform
            token: <Your GitHub PAT> # GitHub personal access token # PAT GitHub token. This field supports "encrypted" field references
          enabled: true
```


## Configure Terraform Integration for BitBucket

This is *(optional)*.

### Enable and configure the BitBucket Artifact Provider

Spinnaker uses the BitBucket Artifact Provider to download any referenced `tfvar`
files, so it must be configured with the BitBucket token to pull these files.

If you already have a BitBucket artifact account configured in Spinnaker, skip this step.

Replace `bitbucket-for-terraform` with any unique identifier to
identify the artifact account.



```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      artifacts:
        bitbucket:
          enabled: true
          accounts:
          - name: bitbucket-for-terraform
            username: <Your Bitbucket username>
            password: <Your Bitbucket password> # This field supports "encrypted" field references
```



## Enable Terraform Integration

In `SpinnakerService` manifest:

```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      armory:
        terraform:
          enabled: true
    profiles:
      deck:
        # Enables the UI for the Terraform Integration stage
        settings-local.js: |
          window.spinnakerSettings.feature.terraform = true;
```

This example manifest also enables the Terraform Integration UI.


### Remote backends

The Terraform Integration feature supports using remote backends provided by Terraform Cloud and Terraform Enterprise.

When using remote backends, keep the following in mind:

* The Terraform stage must use the same Terraform version that your Terraform Cloud/Enterprise workspace is configured to run.
* The minimum supported Terraform version is 0.12.0.
* In the Terraform Cloud/Enterprise UI, the type of `plan` action that the Terraform Integration stage performs is a "speculative plan." For more information, see [Speculative Plans](https://www.terraform.io/docs/cloud/run/index.html#speculative-plans) in the Terraform docs.
* You cannot save and apply a plan file.

#### Enable remote backend support

End users can use remote backends by configuring the Terraform Integration stage with the following parameters:

* A Terraform version that is 0.12.0 or later and matches the version that your Terraform Cloud/Enterprise runs.
* Reference a remote backend in your Terraform code.

To enable support, add the following config to your `terraformer-local.yml` file in the `.hal/default/profiles` directory:

```bash
terraform:
  remoteBackendSupport: true
```

## Enable the Terraform Integration UI

If you previously used the Terraform Integration stage by editing the JSON representation of the stage, those stages are automatically converted to use the UI.

## Complete the installation

After you finish your Terraform Integration configuration, perform the following steps:

1. Apply the changes:


   Assuming that Spinnaker lives in the namespace `spinnaker` and the `SpinnakerService` manifest is named `spinnakerservice.yml`:

   ```bash
   kubectl -n spinnaker apply -f spinnakerservice.yml
   ```



1. Confirm that the Terraform Integration service (Terraformer) is deployed with your Spinnaker deployment:

   ```bash
   kubectl get pods -n <your-spinnaker-namespace>
   ```

   In the command output, look for a line similar to the following:

   ```bash
   spin-terraformer-d4334g795-sv4vz    2/2     Running            0          0d
   ```

## Configure Terraform for your cloud provider

>The Terraform Integration is cloud provider agnostic. Terraform commands execute against the terraform binary. All methods of configuring authentication are supported as per Terraform's compatibility and capabilities.

You can also configure a profile that grants access to resources such as AWS.

## Named Profiles

When creating pipelines, a Named Profile gives you the ability to reference certain kinds of external sources, such as a private remote repository. The supported credentials are described in [Types of credentials](#types-of-credentials).

### Configure a Named Profile

Configure profiles that you can select when creating a Terraform Integration stage:

1. In your `SpinnakerService`, add the profiles to `spec.spinnakerConfig.profiles.terraformer` that you would like to enable. The following example adds a profile named `pixel-git` for an SSH key secured in Vault. You can find additional profile examples at [Types of credentials](#types-of-credentials).

   ```yaml
   - name: pixel-git # Unique profile name displayed in Deck
     variables:
     - kind: git-ssh
       options:
         sshPrivateKey: encrypted:vault!e:<secret engine>!p:<path to secret>!k:<key>!b:<is base64 encoded?>
   ```

1. Save the file and apply changes:

```bash
kubectl -n spinnaker apply -f spinnakerservice.yml
```

Keep in mind:

1. When you create or edit a Terraform Integration stage in Deck, you can select the profile `pixel-git` from a dropdown.
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

Armory recommends that you enable authorization for your Named Profiles to provide more granular control and give App Developers better guardrails. When you configure authz for Named Profiles, you need to explicitly grant permission to the roles you want to have access to the profile. Users who do not have permission to use a certain Named Profile do not see it as an option in Deck. Also, any stage that uses a Named Profile that a user is not authorized for fails.

{{% alert color=note title="Note" %}}Before you start, make sure you enable Fiat. For more information about Fiat, see [Fiat Overview]({{< ref "fiat-permissions-overview" >}}) and [Authorization (RBAC)](https://spinnaker.io/setup/security/authorization/).{{% /alert %}}

This example does the following:

* Grants access to the resources and accounts that you need, such as permissions to deploy to AWS via FIAT in Cloud
* Enables FIAT authz to work with Terraformer

In your `SpinnakerService` manifest:

```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      profiles:
        terraformer:
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

If you’re not using AWS, you should configure one of the other credential types in your Named Profile. If you don't see a credential that suits your use case, [submit a feature request](https://feedback.armory.io/feature-requests).

For information about how to configure a Profile, see [Configuring a profile](#configuring-a-named-profile).

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

## Logging and metrics

> If the logging URL is not responsive, the Terraform Integration may not process deploys until the URL can be reached.

You can enable logging and metrics for Prometheus by adding the following configuration to the `spec.spinnakerConfig.profiles.terraformer.logging.remote` block in your `SpinnakerService` manifest:


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

