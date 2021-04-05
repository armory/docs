---
title: Migrate from Halyard to the Operator
linkTitle: Migrate from Halyard
weight: 20
description: >
  Migrate your Spinnaker or Armory Enterprise installation from Halyard to the  Operator.
---

{{< include "armory-operator/os-operator-blurb.md">}}

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

   More details on [SpinnakerService options]({{< ref "op-config-manifest#specspinnakerconfig" >}}) on `.spec.spinnakerConfig.config` section

1. Export Armory profiles.

   If you have configured Armory profiles, you need to migrate these profiles to the `SpinnakerService` manifest.

   First, identify the current profiles under  `~/.hal/default/profiles`

   For each file, create an entry under `spec.spinnakerConfig.profiles`

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

   More details on [SpinnakerService Options]({{< ref "op-config-manifest#specspinnakerconfigprofiles" >}}) in the `.spec.spinnakerConfig.profiles` section

1. Export Armory settings.

   If you configured Armory settings, you need to migrate these settings to the `SpinnakerService` manifest also.

   First, identify the current settings under  `~/.hal/default/service-settings`

   For each file, create an entry under `spec.spinnakerConfig.service-settings`

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
   More details on [SpinnakerService Options]({{< ref "op-config-manifest#specspinnakerconfigservice-settings" >}}) on `.spec.spinnakerConfig.service-settings` section

1. Export local file references.

   If you have references to local files in any part of the config, like `kubeconfigFile`, service account json files or others, you need to migrate these files to the `SpinnakerService` manifest.

   For each file, create an entry under `spec.spinnakerConfig.files`

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

   Then replace the file path in the config to match the key in the `files` section:

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

   More details on [SpinnakerService Options]({{< ref "op-config-manifest#specspinnakerconfigfiles" >}}) on `.spec.spinnakerConfig.files` section

1. Export Packer template files (if used).

   If you are using custom Packer templates for baking images, you need to migrate these files to the `SpinnakerService` manifest.

   First, identify the current templates under  `~/.hal/default/profiles/rosco/packer`

   For each file, create an entry under `spec.spinnakerConfig.files`

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

   More details on [SpinnakerService Options]({{< ref "op-config-manifest#specspinnakerconfigfiles" >}}) on `.spec.spinnakerConfig.files` section

1. Validate your Armory configuration if you plan to run the Operator in cluster mode.

   ```bash
   kubectl -n <namespace> apply -f <spinnaker service manifest> --dry-run=server
   ```

   The validation service throws an error when something is wrong with your manifest.

1. Apply your SpinnakerService:

   ```bash
   kubectl -n <namespace> apply -f <spinnaker service>
   ```

