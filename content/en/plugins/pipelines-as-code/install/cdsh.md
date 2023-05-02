---
title: Enable Pipelines-as-Code in Armory Continuous Deployment
linkTitle: Armory CD
weight: 1
description: >
  Learn how to enable Armory's Pipelines and Code feature in Armory Continuous Deployment.
---

## {{% heading "prereq" %}}


## Enable Pipelines-as-Code

_Dinghy_ is the microservice you need to enable to use Pipelines-as-Code. Add the following to your `SpinnakerService` manifest:

{{< prism lang="yaml" line="9-10" >}}
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      armory:
        dinghy:
          enabled: true
{{< /prism >}}

- `dinghy.enabled`: `true`; required to enable Pipelines-as-Code.

**Apply your changes**

Assuming Armory CD lives in the `spinnaker` namespace, execute the following to update your instance:

{{< prism lang="bash"  >}}
kubectl -n spinnaker apply -f spinnakerservice.yml
{{< /prism >}}


## {{% heading "nextSteps" %}}

* {{< linkWithTitle "plugins/pipelines-as-code/install/configure.md" >}}