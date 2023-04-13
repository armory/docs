---
title: Armory Pipelines as Code Release Notes
linkTitle: Release Notes
weight: 99
description: >
  Armory Pipelines as Code plugin for Spinnaker and Armory Continuous Deployment release notes.
---

## Release notes

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![Proprietary](/images/proprietary.svg)

## Known issues

If Dinghy crashes on start up and you encounter an error in Dinghy similar to:

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





