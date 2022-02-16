---
linkTitle: Configure Monitoring using the Observability Plugin
title: Configure Monitoring
description: >
   Configure monitoring using the Observability Plugin
---

## Configure monitoring using the Observability Plugin

{{% alert title="Caution" color=warning %}} Before configuring monitoring, read and understand the following information about the security implications.
If any of your services, typically Gate, are exposed to the open internet, there is a risk that you can publicly expose information. Armory recommends that you filter these paths at your edge layer in some manner. Be aware of any endpoints you expose. Spring boot exposes the health endpoint by default though with some restrictions on what information is exposed. When auth is enabled, Gate restricts access to the endpoints other than `/health`, preventing access to metric data.

For more information on Spring actuators, see the [Monitoring and Management](https://docs.spring.io/spring-boot/docs/current/reference/html/production-ready-features.html#production-ready-monitoring).  

<!-- Spinnaker issue discussing management endpoints: https://github.com/spinnaker/spinnaker/issues/3883-->
{{% /alert %}}

Armory recommends that you monitor your systems by using the [Armory Observabililty Plugin](https://github.com/armory-plugins/armory-observability-plugin/). This is an open source solution for monitoring Armory Enterprise. The plugin supports the following:

* Adding Prometheus (OpenMetrics) endpoints to Armory Enterprise pods.
* Sending data to NewRelic (see the [plugin's README](https://github.com/armory-plugins/armory-observability-plugin)).

The Observability Plugin removes the service name from the metric. This is incompatible with the behavior of the open source Spinnaker monitoring daemon system, which was the default monitoring solution in versions earlier than 2.20 and is now deprecated.

### Install the plugin

To install the Observability plugin, add a plugin configuration to the profiles for your services:

* Add it for all services in `spinnaker-local.yml` (Halyard installs) or the `spinnaker` profile section (Operator installs).  
* Add it to the services you want to monitor.

  For example, your local profile should contain the following to enable Prometheus in the Observability Plugin:

  {{< prism lang="yaml" >}}
  # These lines are spring-boot configuration to allow access to the metrics
  # endpoints.  This plugin adds the "aop-prometheus" endpoint on the
  # "<service>:<port>/aop-prometheus" path.

  management:
    endpoints:
      web:
        # Read the security warning at the start of this section about what gets exposed!!
        exposure.include: health,info,aop-prometheus
  spinnaker:
    extensibility:
      plugins:
        Armory.ObservabilityPlugin:
          enabled: true
          version: <VERSION>
          # This is the basic configuration for prometheus to be enabled
          config.metrics:
            prometheus:
              enabled: true
      repositories:
        armory-observability-plugin-releases:
          url: https://raw.githubusercontent.com/armory-plugins/armory-observability-plugin-releases/master/repositories.json
  {{< /prism >}}

More options for management endpoints and the plugin are available in the [plugin's README](https://github.com/armory-plugins/armory-observability-plugin).
