---
linkTitle: Armory CD
title: Enable the Terraform Integration Stage in Armory Continuous Deployment
weight: 1
description: >
  Learn how to enable the Terraform Integration stage in Armory CD so that your app developers can provision infrastructure using Terraform as part of their delivery pipelines.
---
![Proprietary](/images/proprietary.svg)


## Overview of enabling Terraform Integration

Enabling the Terraform Integration stage consists of these steps:

1. [Configure Armory CD](#configure-armory-cd)
1. [Enable Terraform Integration](#enable-terraform-integration)
1. [Apply the update](#apply-the-update)

### Compatibility

{{< include "plugins/pac/compat-matrix.md" >}}

## {{% heading "prereq" %}}

* You have read the [Terraform Integration Overview]({{< ref "plugins/terraform/_index.md" >}}).
* You are running Armory Continuous Deployment.
* You manage your instance using the Armory Operator. 

Terraform Integration is a built-in feature of Armory CD.

If you are running open source Spinnaker, see the [Pipelines-as-Code landing page]({{< ref "plugins/pipelines-as-code/#installation" >}}) for installation paths based on whether you are using Halyard or the Spinnaker Operator.

{{< include "plugins/terraform/terraform-prereqs.md" >}}

## Configure Armory CD

### Configure Redis

Terraform Integration uses Redis to store Terraform logs and plans.

>The Terraform Integration feature can only be configured to use a password with the default Redis user.

Configure Redis settings in your configuration and then apply.

{{< tabpane text=true right=true  >}}
{{% tab header="spinnaker-kustomize-patches"  %}}
You need to modify `spinnaker-kustomize-patches/armory/features/patch-terraformer.yml`. Add Redis configuration in the `profiles` section.

```yaml
profiles:
    redis:
      baseUrl: "<your-redis-url>"
      password: "<your-redis-password>"
```

{{% /tab %}}
{{% tab header="spinnakerservice.yml"  %}}

```yaml
spec:
  spinnakerConfig:
    profiles:
      terraformer:
        redis:
          baseUrl: "<your-redis-url>"
          password: "<your-redis-password>"
```

{{% /tab %}}
{{< /tabpane >}}

### Configure your artifact account

The Terraform Integration uses the following artifact accounts:
  * **Git Repo** - To fetch the repo housing your main Terraform files.
  * **GitHub, BitBucket or HTTP** - *Optional*. To fetch single files such as var-files or backend config files.

Spinnaker uses the Git Repo Artifact Provider to download the repo containing your main Terraform templates. For more configuration options, see [Configure a Git Repo Artifact Account](https://spinnaker.io/setup/artifacts/gitrepo/).

{{< tabpane text=true right=true  >}}
{{% tab header="spinnaker-kustomize-patches"  %}}
You need to modify `spinnaker-kustomize-patches/armory/features/patch-terraformer.yml`. Configure artifacts in the `spec.spinnakerConfig.config.artifacts` section.

```yaml
spec:
  spinnakerConfig:
    config:
      armory:
        terraform:
          enabled: true
      artifacts:
        gitrepo:
          enabled: true
          accounts:
            - name: gitrepo
              username: <username> 
              token: <git-token> 
              # password:
              # tokenFile: 
              # usernamePasswordFile: 
              # sshPrivateKeyFilePath:
              # sshPrivateKeyPassphrase:
              # sshKnownHostsFilePath: 
              # sshTrustUnknownHosts: 
```

{{% /tab %}}
{{% tab header="spinnakerservice.yml"  %}}

```yaml
spec:
  spinnakerConfig:
    profiles:
      clouddriver:
        artifacts:
          gitRepo:
            enabled: true
            accounts:
            - name: gitrepo
              token: <your-personal-access-token>
```

{{% /tab %}}
{{< /tabpane >}}


### Configure additional repos

You need to modify `spinnaker-kustomize-patches/armory/features/patch-terraformer.yml`. Configure additional artifacts in the `spec.spinnakerConfig.config.artifacts` section.

{{< include "plugins/terraform/configure-optional-repos.md" >}}

## Enable Terraform Integration

{{< tabpane text=true right=true  >}}
{{% tab header="spinnaker-kustomize-patches"  %}}
You need to modify your Kustomization recipe to include `patch-terraformer.yml`. 

```yaml
patchesStrategicMerge:
  - armory/features/patch-terraformer.yml
```

{{% /tab %}}
{{% tab header="spinnakerservice.yml"  %}}
Add `enabled: true` to your `terraform` section.

```yaml
spec:
  spinnakerConfig:
    config:
      armory:
        terraform:
          enabled: true
```

{{% /tab %}}
{{< /tabpane >}}

## Apply the update

After you finish your Terraform Integration configuration, apply your changes. Confirm that the Terraform Integration service (Terraformer) is deployed with your Armory CD deployment:

```bash
kubectl get pods -n <your-spinnaker-namespace>
```

In the command output, look for a line similar to the following:

```bash
spin-terraformer-d4334g795-sv4vz    2/2     Running            0          0d
```

## {{% heading "nextSteps" %}}

{{< include "plugins/terraform/whats-next.md" >}}