---
linkTitle: Enabling the Terraform Integration Stage
title: Enabling the Terraform Integration Stage in the Armory Platform
aliases:
  - /spinnaker/terraform_integration/
  - /spinnaker/terraform-configure-integration/
  - /docs/spinnaker/terraform-enable-integration/
description: >
  Learn how to configure the Terraform Integration and an artifact provider to support either GitHub or BitBucket.
---

## Overview of Terraform Integration in Spinnaker

The examples on this page describe how to configure the Terraform Integration and an artifact provider to support either GitHub or BitBucket. Note that the Terraform Integration also requires a `git/repo` artifact account. For information about how to use the stage, see [Using the Terraform Integration]({{< ref "terraform-use-integration" >}}).

Armory's Terraform Integration integrates your infrastructure-as-code Terraform workflow into your SDLC. The integration interacts with a source repository you specify to deploy your infrastructure as part of a Spinnaker pipeline.

## Supported Terraform versions

Armory ships several versions of Terraform as part of the Terraform Integration feature. The Terraform binaries are verified by checksum and with Hashicorp's GPG key before being installed into an Armory release.

When creating a Terraform Integration stage, pipeline creators select a specific available version from a list of available versions:

![Terraform version to use](/images/terraform_version.png)

Note that all Terraform stages within a Pipeline that affect state must use the same Terraform version.


## Requirements

* Credentials (in the form of basic auth) for the Git repository where your Terraform scripts are stored. The Terraform Integration needs access to credentials to download directories that house your Terraform templates.
  * Git Repo can be configured with any of the following:
    * a Personal Access Token (potentially associated with a service account). For more information, see [Generating a Github Personal Access Token (PAT)](#generating-a-github-personal-access-token-pat).
    * SSH protocol in the form of an SSH key or an SSH key file
    * basic auth in the form of a user and password, or a user-password file
* A source for Terraform Input Variable Files (`tfvar`) or a backend config. You must have a separate artifact provider that can pull your `tfvar` file(s). The Terraform Integration supports the following artifact providers for `tfvar` files and backend configs:
  * GitHub
  * BitBucket
  * HTTP artifact

Although not required, Armory recommends an external Redis instance for the Terraform Integration. For more information, see [Redis](#redis).

### Redis

The Terraform Integration uses Redis to store Terraform logs and plans. An external Redis instance is highly recommended for production use.

**Note:** The Terraform Integration can only be configured to use a password with the default Redis user.

To set/override the Spinnaker Redis settings do the following:

**Operator**

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

**Halyard**

Edit the `~/.hal/default/profiles/terraformer-local.yml` file and add the following:

```yaml
redis:
  baseUrl: "redis://spin-redis:6379"
  password: "password"
```

Then run `hal deploy apply` to deploy the changes.

### Generating a GitHub Personal Access Token (PAT)

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

**Operator**

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

**Halyard**

1. Enable Git Repo as an artifact provider:

   ```bash
   hal config artifact gitrepo enable
   ```

2. Add the Git Repo account:

   ```bash
   hal config artifact gitrepo account add gitrepo-for-terraform --token
   ```

   The command prompts you for your Git Repo PAT.

For more configuration options, see [Git Repo](https://spinnaker.io/setup/artifacts/gitrepo/).

## Configure the Terraform Integration for GitHub *(optional)*

These steps describe how to configure GitHub as an artifact provider for the Terraform Integration. For information about BitBucket, see [Configuring the Terraform Integration with BitBucket](#configuring-the-terraform-integration-with-bitbucket).


#### Enabling and configuring the GitHub Artifact Provider

Spinnaker uses the Github Artifact Provider to download any referenced `tfvar`
files.

If you already have a GitHub artifact account configured in Spinnaker,
skip this section.

{{% alert title="Note" %}}The following examples use `github-for-terraform` as a unique identifier for the artifact account. Replace it with your own identifier.
{{% /alert %}}

**Operator**

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
            token: <Your GitHub PAT> # GitHub personal access token # PAT GitHub token. This field supports "encrypted" field references (https://docs.armory.io/spinnaker-install-admin-guides/secrets/)
          enabled: true
```

**Halyard**

1. Enable GitHub as an artifact provider:

   ```bash
   hal config artifact github enable
   ```
2. Add the GitHub account:
   ```bash
   hal config artifact github account add github-for-terraform --token
   ```
   The command prompts you for your GitHub PAT.


## Configure the Terraform Integration for BitBucket *(optional)*

### Enabling and configuring the BitBucket Artifact Provider

Spinnaker uses the BitBucket Artifact Provider to download any referenced `tfvar`
files, so it must be configured with the BitBucket token to pull these files.

If you already have a BitBucket artifact account configured in Spinnaker, skip this step.

Replace `bitbucket-for-terraform` with any unique identifier to
identify the artifact account.

**Operator**

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
            password: <Your Bitbucket password> # This field supports "encrypted" field references (https://docs.armory.io/spinnaker-install-admin-guides/secrets/)
```

**Halyard**

```bash
hal config artifact bitbucket enable

# This will prompt for the password
hal config artifact bitbucket account add bitbucket-for-terraform \
  --username <USERNAME> \
  --password
```


## Enabling the Terraform Integration


Enable the Terraform Integration:

**Operator**

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

**Halyard**

```bash
hal armory terraform enable
```

### Remote backends

{{< include "early-access-feature.html" >}}

The Terraform Integration supports using remote backends provided by Terraform Cloud and Terraform Enterprise.

When using remote backends, keep the following in mind:

* The Terraform stage must use the same Terraform version that your Terraform Cloud/Enterprise workspace is configured to run.
* The minimum supported Terraform version is 0.12.0.
* In the Terraform Cloud/Enterprise UI, the type of `plan` action that the Terraform Integration performs is a "speculative plan." For more information, see [Speculative Plans](https://www.terraform.io/docs/cloud/run/index.html#speculative-plans).
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

## Enabling the Terraform Integration UI

If you previously used the Terraform Integration stage by editing the JSON representation of the stage, those stages are automatically converted to use the UI.

Manually enable the stage UI for Deck:

**Operator**

See the example manifest in [Enabling the Terraform Integration](#enabling-the-terraform-integration).

**Halyard**

Edit `~/.hal/default/profiles/settings-local.js` and add the following:

```js
window.spinnakerSettings.feature.terraform = true;
```

## Completing the installation

After you finish your Terraform integration configuration, perform the following steps:

1. Apply the changes:

   **Operator**

   Assuming that Spinnaker lives in the namespace `spinnaker` and the `SpinnakerService` manifest is named `spinnakerservice.yml`:

   ```bash
   kubectl -n spinnaker apply -f spinnakerservice.yml
   ```

   **Halyard**

   ```bash
   hal deploy apply
   ```

2. Confirm that the Terraform Integration service (Terraformer) is deployed with your Spinnaker deployment:

   ```bash
   kubectl get pods -n <your-spinnaker-namespace>
   ```

   In the command output, look for a line similar to the following:

   ```bash
   spin-terraformer-d4334g795-sv4vz    2/2     Running            0          0d
   ```

## Configure Terraform for your cloud provider

Since the Terraform Integration executes all Terraform commands against the `terraform` binary, all methods of configuring authentication are supported for your desired cloud provider. This section describes how to accomplish this for various cloud providers.

You can also configure a profile that grants access to resources, like AWS.

## Named Profiles

{{% alert title="New feature" %}}Named Profiles is a new feature in Armory 2.20. Previously, you needed to mount a sidecar that contained your credentials. If you are on an earlier version, see the v.2.0-2.19 version of this [page](https://archive.docs.armory.io/docs/spinnaker/terraform-enable-integration/#configure-terraform-for-your-cloud-provider) to learn more about mounting a sidecar. {{% /alert %}}

A Named Profile gives users the ability to reference certain kinds of external sources, such as a private remote repository, when creating pipelines. The supported credentials are described in [Types of credentials](#types-of-credentials).

### Types of credentials

The Terraform integration supports multiple types of credentials for Named Profiles to handle the various use cases that you can use the Terraform integration for:

* AWS
* SSH
* Static
* Terraform remote backend

If you don't see a credential that suits your use case, [let us know](https://feedback.armory.io/feature-requests)!

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

### Configuring a Named Profile

Configure profiles that users can select when creating a Terraform Integration stage:

1. In the `.hal/default/profiles` directory, create or edit `terraformer-local.yml`.
2. Add the values for the profile(s) you want to add under the `profiles` section. The following example adds a profile named `pixel-git` for an SSH key secured in Vault.

   ```yaml
   - name: pixel-git # Unique profile name displayed in Deck
     variables:
     - kind: git-ssh
       options:
         sshPrivateKey: encrypted:vault!e:<secret engine>!p:<path to secret>!k:<key>!b:<is base64 encoded?>
   ```

   When a user creates or edits a Terraform Integration stage in Deck, they can select the profile `pixel-git` from a dropdown.

   Keep the following in mind when adding profiles:

   * You can add multiple profiles under the `profiles` section.
   * Do not commit plain text secrets to `terraformer-local.yml`. Instead, use a secret store: [Vault]({{< ref "secrets-vault" >}}), an [encrypted S3 bucket]({{< ref "secrets-s3" >}}), or an [encrypted GCS bucket]({{< ref "secrets-gcs" >}}).
   * For SSH keys, one option parameter at a time is supported for each Profile. This means that you can use a private key file (`sshPrivateKeyFilePath`) or the key (`sshPrivateKey`) as the option. To use the key file path, use `sshPrivateKeyFilePath` for the option and provide the path to the key file. The path can also be encrypted using a secret store such as Vault. The following `option` example uses `sshPrivateKeyFilePath`:

     ```yaml
     options:
       sshPrivateKeyFilePath: encryptedFile:<secret_store>!e:...
     ```

     For more information, see the documentation for your secret store.
3. Save the file.
4. Apply your changes:

   ```bash
   hal deploy apply
   ```

### Adding authz to Named Profiles

Armory recommends that you enable authorization for your Named Profiles to provide more granular control and give App Developers better guardrails. When you configure authz for Named Profiles, you need to explicitly grant permission to the role(s) you want to have access to the profile. Users who do not have permission to use a certain Named Profile do not see it as an option in Deck. And any stage with that uses a Named Profile that a user is not authorized for fails.

You can see a demo here: [Named Profiles for the Terraform Integration](https://www.youtube.com/watch?v=RYO-b1kyEU0).

{{% alert color=note title="Note" %}}Before you start, make sure you enable Fiat. For more information about Fiat, see [Fiat Overview]({{< ref "fiat-permissions-overview" >}}) and [Authorization (RBAC)](https://spinnaker.io/setup/security/authorization/).{{% /alert %}}

#### Halyard
To start, edit `~/.hal/default/profiles/terraformer-local.yml` and add the following config:

```yaml
fiat:
  enabled: true
  baseUrL: ${services.fiat.baseUrl} # If you are using a custom URL for Fiat, replace with your Fiat URL.
```

Now, you can specify permissions for any profiles you have:

```yaml
profiles:
  ...
  ...
  ...
  permissions:
    - <role that should have access>
    - <role that should have access>
    - ...
```

This is what a Named Profile for a team named `dev-team` looks like for AWS credentials:

```yaml
profiles:
  - name: dev-team
    variables:
      - kind: aws
        options:
          assumeRole: my-role
    permissions:
      - dev
      - ops
```
In the example, only users who belong to the `dev` or `ops` groups can use the credentials that correspond to this profile.

Don't forget to run `hal deploy apply` once you finish making changes!

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

## Submit feedback

Let us know what you think at [go.armory.io/ideas](https://go.armory.io/ideas) or [feedback.armory.io](https://feedback.armory.io). We're constantly iterating on customer feedback to ensure that the features we build make your life easier!