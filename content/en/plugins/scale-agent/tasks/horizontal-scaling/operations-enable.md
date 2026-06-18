---
title: Enable and Configure Operations Horizontal Scaling in the Armory Scale Agent
linkTitle: Enable Operations Horizontal Scaling
description: >
  Learn how to enable and configure the Operations Horizontal Scaling feature in Armory Scale Agent for Spinnaker and Kubernetes.
---

## {{% heading "prereq" %}}

* You are familiar with {{< linkWithTitle "plugins/scale-agent/concepts/horizontal-scaling" >}}.

## Scale Agent plugin

> Operations Horizontal Scaling was introduce starting with plugin versions v0.13.20/0.12.21/0.11.56.

You should enable Operations Horizontal Scaling by setting `kubesvc.cluster: database` in your plugin configuration. For example:

{{< highlight bash "linenos=table,hl_lines=27-28">}}
spec:
  spinnakerConfig:
    profiles:
      clouddriver:
        spinnaker:
          extensibility:
            repositories:
              armory-agent-k8s-spinplug-releases:
                enabled: true
                url: https://raw.githubusercontent.com/armory-io/agent-k8s-spinplug-releases/master/repositories.json
            plugins:
              Armory.Kubesvc:
                enabled: true
                version: 0.13.20  # Replace with a version compatible with your Armory CD version
                extensions:
                  armory.kubesvc:
                    enabled: true
        # Plugin config
        kubesvc:  
          cluster: database
         	operations:
             database:
              scan:
                batchSize: <int> # (Optional) # requires kubesvc.cluster: database be enable
                initialDelay:<int> # (Optional) # requires kubesvc.cluster: database be enable
                maxDelay:<int> # (Optional) # requires kubesvc.cluster: database be enable
{{< /highlight >}}

`operations.database.scan`:

* **batchSize**: (Optional) default: 5; The max number of operations that could be assigned to an Scale Agent instance per cycle
* **initialDelay**: (Optional) default: 250; Milliseconds to wait per cycle, when there are pending operations
* **maxDelay**: (Optional) default: 2000; Milliseconds to wait per cycle, when there are not pending operations
