---
title: App Name Plugin
toc_hide: true
---
<!-- this is a private plugin German created for JPMC. This unlisted page is to satisfy an auditing requirement they have. It is also hidden via robots.txt. -->

## Overview
Plugin for making spinnaker application name rules configurable.

## Requirements

This plugin requires Armory 2.20.x or later, or Spinnaker 1.20.x or later.

## Limitations

The following characters cannot be part of the application name:

1. `:` Is used as a separator in database identifiers.
1. `/` Is used as path separator in some requests from deck to gate.
1. `appStackDetailSeparator` Is used as separator in server group names deployed with spinnaker.

Prior to Spinnaker `1.23` or Armory `2.23`, changing `appStackDetailSeparator` from its default value of `-` has known issues in cloudfoundry deployments.

## Setup

The plugin can be delivered using two different methods:
1. Docker image as an init container on each affected service
1. Using a remote plugin repository

### Docker image as init container

#### Spinnaker operator

This is a sample configuration to use with spinnaker operator:

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

#### Halyard

Content for `profiles/spinnaker-local.yml`:
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

Content for `profiles/gate-local.yml`:
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

Content for `profiles/orca-local.yml` and `profiles/clouddriver-local.yml`:
```yaml
spinnaker:
  extensibility:
    repositories:
      appname:
        enabled: true
        url: file:///opt/spinnaker/lib/local-plugins/appname/plugins.json
```

Content for `service-settings/gate.yml`, `service-settings/orca.yml` and `service-settings/clouddriver.yml`:
```yaml
kubernetes:
  volumes:
  - id: appname-plugin-vol
    type: emptyDir
    mountPath: /opt/spinnaker/lib/local-plugins
```

Content for `.hal/config`:
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

### Remote plugin repository

The configuration is mostly the same as with the docker image method, but omitting all volumes and init container configurations, and replacing all occurrences of 

```yaml
url: file:///opt/spinnaker/lib/local-plugins/appname/plugins.json
``` 

 with:
 
```yaml
url: https://armory.jfrog.io/artifactory/plugins/appname/plugins.json
``` 

## Usage

The plugin allows to configure different application name regex patterns and constraints for each cloud provider. For example:
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

The above configuration allows to have different rules for kubernetes and cloudfoundry providers, and the rest of providers will use Spinnaker default rules.

The `appStackDetailSeparator` is a separator character used to build server group names in VM type deployments, like AWS or Cloudfoundry. This separator character is not allowed to be part of the application name.


## Release Notes

* v0.1.0 Initial plugin release - 10/09/2020
