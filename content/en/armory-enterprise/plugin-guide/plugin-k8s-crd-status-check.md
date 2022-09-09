---
title: K8s CRD Status Check Plugin
toc_hide: true
exclude_search: true
description: >
This plugin helps to determinate if a kubernetes CRD is stable or not.
---
<!-- this is a private plugin. It is also hidden via robots.txt and the netlify sitemap plugin. -->
![Proprietary](/images/proprietary.svg)

## Version Compatibility

| Plugin | Spinnaker Platform | Armory Spinnaker Platform |
|:-------|:-------------------|:--------------------------|
| 1.0.0  | 1.27.x, 1.28.x     | 2.27.x, 2.28.x            |

## Configuration

Example configuration using the Spinnaker Operator for `clouddriver` service:

```yaml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      clouddriver:
        spinnaker:
          extensibility:
            plugins:
              Armory.K8sCRDStatusCheck:
                enabled: true
                version: 1.0.0
              repositories:
                pluginRepository:
                  url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
```

## Usage

The CRD needs to have the annotation `crd.armory.io/status` under `metadata.annotations`.

Example CRD with annotation:

```yaml
kind: MyCRD
metadata:
  annotations:
    crd.armory.io/status: status:Ready
  name: my-crd
spec:
  ...
```

### Syntax

`<field1>:<value1.1,value1.2>;<field2>:<value2.1>`

* `;` is used as a delimiter between fields.
* `:` is used to separate a field from its values.
* `,` is used as a separator between values.

Accepted field formats:

* Simple: `field`
* Nested: `field1.field2.field3`
* Indexed: `field[index]`
* Mapped: `field(key)`
* Combined: `field1.field2[index].field3(key)`

## Release Notes

* v1.0.0 Initial release - 09/09/2022
