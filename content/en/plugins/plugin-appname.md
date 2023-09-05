---
title: App Name Plugin
toc_hide: true
hide_summary: true
exclude_search: true
description: >
  The app name plugin makes rules for Spinnaker application names configurable.
---
<!-- this is a private plugin German created for a customer. This unlisted page is to satisfy an auditing requirement they have. It is also hidden via robots.txt and the netlify sitemap plugin. -->
![Proprietary](/images/proprietary.svg)
## Requirements

For Armory Continuous Deployment 2.27.x (OSS 1.27.x) and later, you must use version `0.2.0` or later of the plugin.


## Limitations

The following characters cannot be part of the application name:

- `:` is used as a separator in database identifiers.
- `/` is used as path separator in some requests from Deck to Gate.
- `appStackDetailSeparator` is used as separator in server group names deployed with Spinnaker.

For Armory 2.22 (OSS 1.22) and lower, changing `appStackDetailSeparator` from its default value of `-` has known issues in Cloud Foundry deployments.

## Setup

The plugin can be delivered using two different methods:

1. Docker image as an init container on each affected service
1. Using a remote plugin repository

### Docker image as init container

{{< tabpane text=true right=true >}}
{{% tab header="Operator" %}}

This is a sample configuration to use with the Spinnaker operator:

```yaml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      spinnaker:
        armory:
          appnameplugin:
            appStackDetailSeparator: '-' # Default separator used by spinnaker
            providerConstraints:
              cloudfoundry:
                nameRegex: ^[^:\-/]+$    # The regex must exclude the appStackDetailSeparator, as well as ':' and '/' characters, which are reserved
                maxLength: 64
        spinnaker:
          extensibility:
            plugins:
              Armory.AppNamePlugin:
                enabled: true
      gate:
        spinnaker:
          extensibility:
            deck-proxy:
              enabled: true
              plugins-path: /opt/spinnaker/lib/local-plugins
              plugins:
                Armory.AppNamePlugin:
                  enabled: true
            repositories:
              appname:
                enabled: true
                url: file:///opt/spinnaker/lib/local-plugins/appname/plugins.json
      orca:
        spinnaker:
          extensibility:
            repositories:
              appname:
                enabled: true
                url: file:///opt/spinnaker/lib/local-plugins/appname/plugins.json
      clouddriver:
        spinnaker:
          extensibility:
            repositories:
              appname:
                enabled: true
                url: file:///opt/spinnaker/lib/local-plugins/appname/plugins.json
  kustomize:
    orca:
      deployment:
        patchesStrategicMerge:
          - |
            spec:
              template:
                spec:
                  initContainers:
                  - name: appname-plugin
                    image: docker.io/armory/appname-plugin:<PLUGIN VERSION>
                    imagePullPolicy: Always
                    volumeMounts:
                      - mountPath: /opt/appname-plugin/target
                        name: appname-plugin-vol
                  containers:
                  - name: orca
                    volumeMounts:
                      - mountPath: /opt/spinnaker/lib/local-plugins
                        name: appname-plugin-vol
                  volumes:
                  - name: appname-plugin-vol
                    emptyDir: {}
    gate:
      deployment:
        patchesStrategicMerge:
          - |
            spec:
              template:
                spec:
                  initContainers:
                  - name: appname-plugin
                    image: docker.io/armory/appname-plugin:<PLUGIN VERSION>
                    imagePullPolicy: Always
                    volumeMounts:
                      - mountPath: /opt/appname-plugin/target
                        name: appname-plugin-vol
                  containers:
                  - name: gate
                    volumeMounts:
                      - mountPath: /opt/spinnaker/lib/local-plugins
                        name: appname-plugin-vol
                  volumes:
                  - name: appname-plugin-vol
                    emptyDir: {}
    clouddriver:
      deployment:
        patchesStrategicMerge:
          - |
            spec:
              template:
                spec:
                  initContainers:
                  - name: appname-plugin
                    image: docker.io/armory/appname-plugin:<PLUGIN VERSION>
                    imagePullPolicy: Always
                    volumeMounts:
                      - mountPath: /opt/appname-plugin/target
                        name: appname-plugin-vol
                  containers:
                  - name: clouddriver
                    volumeMounts:
                      - mountPath: /opt/spinnaker/lib/local-plugins
                        name: appname-plugin-vol
                  volumes:
                  - name: appname-plugin-vol
                    emptyDir: {}
```

{{% /tab %}}

{{% tab header="Halyard" %}}

Add the following to `profiles/spinnaker-local.yml`:
```yaml
armory:
  appnameplugin:
    appStackDetailSeparator: '-' # Default separator used by spinnaker
    providerConstraints:
      cloudfoundry:
        nameRegex: ^[^:\-/]+$    # The regex must exclude the appStackDetailSeparator, as well as ':' and '/' characters, which are reserved
        maxLength: 64
spinnaker:
  extensibility:
    plugins:
      Armory.AppNamePlugin:
        enabled: true
```

Add the following to `profiles/gate-local.yml`:
```yaml
spinnaker:
  extensibility:
    deck-proxy:
      enabled: true
      plugins-path: /opt/spinnaker/lib/local-plugins
      plugins:
        Armory.AppNamePlugin:
          enabled: true
    repositories:
      appname:
        enabled: true
        url: file:///opt/spinnaker/lib/local-plugins/appname/plugins.json
```

Add the following to `profiles/orca-local.yml` and `profiles/clouddriver-local.yml`:
```yaml
spinnaker:
  extensibility:
    repositories:
      appname:
        enabled: true
        url: file:///opt/spinnaker/lib/local-plugins/appname/plugins.json
```

Add the following to `service-settings/gate.yml`, `service-settings/orca.yml` and `service-settings/clouddriver.yml`:
```yaml
kubernetes:
  volumes:
  - id: appname-plugin-vol
    type: emptyDir
    mountPath: /opt/spinnaker/lib/local-plugins
```

Add the following to  `.hal/config`:
```yaml
deploymentConfigurations:
  - name: default
    deploymentEnvironment:
      initContainers:
        clouddriver:
          - name: appname-plugin
            image: docker.io/armory/appname-plugin:<PLUGIN VERSION>
            volumeMounts:
              - mountPath: /opt/appname-plugin/target
                name: appname-plugin-vol
        gate:
          - name: appname-plugin
            image: docker.io/armory/appname-plugin:<PLUGIN VERSION>
            volumeMounts:
              - mountPath: /opt/appname-plugin/target
                name: appname-plugin-vol
        orca:
          - name: appname-plugin
            image: docker.io/armory/appname-plugin:<PLUGIN VERSION>
            volumeMounts:
              - mountPath: /opt/appname-plugin/target
                name: appname-plugin-vol
```

{{% /tab %}}
{{< /tabpane >}}

### Remote plugin repository

The configuration is mostly identical to the Docker image method but omits all volumes and init container configurations. Additionally, replace all occurrences of the following:

```yaml
url: file:///opt/spinnaker/lib/local-plugins/appname/plugins.json
```

with:

```yaml
url: https://armory.jfrog.io/artifactory/plugins/appname/plugins.json
```

## Usage

The plugin allows you to configure different application name regex patterns and constraints for each cloud provider. For example:

```yaml
armory:
  appnameplugin:
    appStackDetailSeparator: '-'
    providerConstraints:
      kubernetes:
        nameRegex: ^[a-zA-Z0-9.]*$
        maxLength: 64
      cloudfoundry:
        nameRegex: ^app#[a-zA-Z][a-zA-Z0-9]*?$
        maxLength: 64
```

The above configuration sets different rules for applications if they get deployed to Kubernetes or Cloud Foundry. Applications that use other providers continue to use the default Spinnaker rules.

The `appStackDetailSeparator` is a separator character used to build server group names in VM type deployments, like AWS or Cloud Foundry. This separator character is not allowed to be part of the application name.


## Release Notes

* v0.2.0 Update plugin to be compatible with Armory Continuous Deployment 2.27.0 and later - 10/29/2021
* v0.1.0 Initial plugin release - 10/09/2020
