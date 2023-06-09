---
title: Armory Pipelines-as-Code Release Notes
linkTitle: Release Notes
weight: 99
description: >
  Armory Pipelines-as-Code plugin for Spinnaker and Armory Continuous Deployment release notes.
---

## Release notes

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![Proprietary](/images/proprietary.svg)

## 2.30



## 2.27

### Multi-branch enhancement

Now you can configure Pipelines-as-Code to pull Dinghy files from multiple branches in the same repo. Cut out the tedious task of managing multiple repos; have a single repo for Spinnaker application pipelines. See [Multiple branches]({{< ref "plugins/pipelines-as-code/install/configure#multiple-branches" >}}) for how to enable and configure this feature.

## 2.24

### MySQL as backing store

Pipelines-as-Code now supports using MySQL as the backing store, which can provide more durability and scalability than Redis. This feature is currently in early access.

For information about how to configure the backing store for Pipelines-as-Code, see [Configuring SQL]({{< ref "plugins/pipelines-as-code/install/configure#configuring-redis" >}}).

## 2.21

### GitHub pull request validation

Pipelines-as-Code now supports pull request (PR) validation for GitHub. When a PR is submitted, you can ensure that the `dinghyfile` is valid by enabling this feature.

For more information, see [Pull Request Validation]({{< ref "plugins/pipelines-as-code/install/configure#pull-request-validations" >}}).

## Known issues

### Failed to load configuration

If Pipelines-as-Code crashes on start up and you encounter an error similar to:

{{< prism lang="bash" >}}
time="2020-03-06T22:35:54Z"
level=fatal
msg="failed to load configuration: 1 error(s) decoding:\n\n* 'Logging.Level' expected type 'string', got unconvertible type 'map[string]interface {}'"
{{< /prism >}}

You probably configured global logging levels with `spinnaker-local.yml`. The workaround is to override Dinghy's logging levels:

{{< prism lang="yaml" line="9-10" >}}
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      dinghy:
        Logging:
          Level: INFO
{{< /prism >}}
