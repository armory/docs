---
title: Migrate from Halyard to the Operator
linkTitle: Migrate from Halyard
weight: 20
description: >
  Migrate your Armory Enterprise or Spinnaker installation from Halyard to the Operator.
---

{{< include "armory-operator/os-operator-blurb.md">}}

## {{% heading "prereq" %}}

You need to decide if you want to overwrite the current Halyard deployment of Armory Enterprise or create a test instance.

If you choose to overwrite your current instance, you need to take downtime to clean up the namespace that the Halyard-deployed Armory Enterprise is in so Operator can deploy Armory Enterprise without collision.

Alternately, you can use Operator to deploy Armory Enterprise to a different namespace to test out the migration. You need to create a separate data store as well as separate Gate and Deck URLs for your test instance of Armory Enterprise. Once you've verified that Operator has deployed your test configuration as you expected, decommission the Halyard-deployed instance of Armory Enterprise. Change the data store config and URLs in the manifest that Operator used to deploy your test instance to match what your decommissioned instance used. Then redeploy.

The second method is preferred as it allows you to test everything before decommissioning Armory Enterprise that you deployed using Halyard.

## Migrate to Operator

This guide assumes you want to deploy Armory Enterprise using a single `SpinnakerSerivce.yml` manifest file rather than Kustomize patches.

The migration process from Halyard to Operator can be completed in 7 steps:

1. [Install the Operator]({{< ref "op-quickstart" >}}).
1. Export configuration.

   Copy the desired profile's content from the `config` file

   For example, if you want to migrate the `default` hal profile, use the following `SpinnakerService` manifest structure:

   ```yaml
   currentDeployment: default
   deploymentConfigurations:
   - name: default
     <CONTENT>
   ```

   Add `<CONTENT>` in the `spec.spinnakerConfig.config` section in the `SpinnakerService` manifest as follows:

   ```yaml
   spec:
     spinnakerConfig:
       config:
         <<CONTENT>>
   ```

   Note: `config` is under `~/.hal`

   You can see more details in [`spec.spinnakerConfig.config`]({{< ref "op-config-manifest#specspinnakerconfig" >}}).

1. Export Armory Enterprise profiles.

   If you have configured Armory Enterprise profiles, you need to migrate these profiles to the `SpinnakerService` manifest.

   First, identify the current profiles under  `~/.hal/default/profiles`.

   For each file, create an entry under `spec.spinnakerConfig.profiles`.

   For example, you have the following profile:

   ```bash
   $ ls -a ~/.hal/default/profiles | sort
   echo-local.yml
   ```

   Create a new entry with the name of the file without `-local.yaml` as follows:

   ```yaml
   spec:
     spinnakerConfig:
       profiles:
         echo:
           <CONTENT>
   ```

   You can see more details in [`spec.spinnakerConfig.profiles`]({{< ref "op-config-manifest#specspinnakerconfigprofiles" >}}).

1. Export Armory Enterprise settings.

   If you configured Armory settings, you need to migrate these settings to the `SpinnakerService` manifest also.

   First, identify the current settings under  `~/.hal/default/service-settings`.

   For each file, create an entry under `spec.spinnakerConfig.service-settings`.

   For example, you have the following settings:

   ```bash
   $ ls -a ~/.hal/default/service-settings | sort
   echo.yml
   ```

   Create a new entry with the name of the file without `.yaml` as follows:

   ```yaml
   spec:
     spinnakerConfig:
       service-settings:
         echo:
           <CONTENT>
   ```

   You can see more details in [spec.spinnakerConfig.service-settings]({{< ref "op-config-manifest#specspinnakerconfigservice-settings" >}}).

1. Export local file references.

   If you have references to local files in any part of the config, like `kubeconfigFile`, service account JSON files or others, you need to migrate these files to the `SpinnakerService` manifest.

   For each file, create an entry under `spec.spinnakerConfig.files`.

   For example, you have a Kubernetes account configured like this:

   ```yaml
   kubernetes:
     enabled: true
     accounts:
     - name: prod
       requiredGroupMembership: []
       providerVersion: V2
       permissions: {}
       dockerRegistries: []
       configureImagePullSecrets: true
       cacheThreads: 1
       namespaces: []
       omitNamespaces: []
       kinds: []
       omitKinds: []
       customResources: []
       cachingPolicies: []
       oAuthScopes: []
       onlySpinnakerManaged: false
       kubeconfigFile: /home/spinnaker/.hal/secrets/kubeconfig-prod
     primaryAccount: prod
   ```

   The `kubeconfigFile` field is a reference to a physical file on the machine running Halyard. You need to create a new entry in `files` section like this:

   ```yaml
   spec:
     spinnakerConfig:
       files:
         kubeconfig-prod: |
           <CONTENT>
   ```

   Then replace the path in the config to match the key in the `files` section:

   ```yaml
   kubernetes:
     enabled: true
     accounts:
     - name: prod
       requiredGroupMembership: []
       providerVersion: V2
       permissions: {}
       dockerRegistries: []
       configureImagePullSecrets: true
       cacheThreads: 1
       namespaces: []
       omitNamespaces: []
       kinds: []
       omitKinds: []
       customResources: []
       cachingPolicies: []
       oAuthScopes: []
       onlySpinnakerManaged: false
       kubeconfigFile: kubeconfig-prod  # File name must match "files" key
     primaryAccount: prod
   ```

   You can see more details in [spec.spinnakerConfig.files]({{< ref "op-config-manifest#specspinnakerconfigfiles" >}}).

1. Export Packer template files (if used).

   If you are using custom Packer templates for baking images, you need to migrate these files to the `SpinnakerService` manifest.

   First, identify the current templates under  `~/.hal/default/profiles/rosco/packer`.

   For each file, create an entry under `spec.spinnakerConfig.files`.

   For example, you have the following `example-packer-config` file:

   ```bash
   $ tree -v ~/.hal/default/profiles
   ├── echo-local.yml
   └── rosco
       └── packer
           └── example-packer-config.json

   2 directories, 2 files
   ```

   You need to create a new entry with the name of the file following these instructions:

   - For each file, list the folder name starting with `profiles`, followed by double underscores (`__`) and at the very end the name of the file.

   ```yaml
   spec:
     spinnakerConfig:
       files:
         profiles__rosco__packer__example-packer-config.json: |
           <CONTENT>
   ```

   You can see more details in [`spec.spinnakerConfig.files`]({{< ref "op-config-manifest#specspinnakerconfigfiles" >}}).

1. Validate your Armory configuration if you plan to run the Operator in cluster mode:

   ```bash
   kubectl -n <namespace> apply -f <spinnaker service manifest> --dry-run=server
   ```

   The validation service throws an error when something is wrong with your manifest.

1. Apply your SpinnakerService:

   ```bash
   kubectl -n <namespace> apply -f <spinnaker service>
   ```

## Help resources

{{% include "armory-operator/help-resources.md" %}}
