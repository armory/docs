---
title: Enable Logging in Armory Enterprise
linkTitle: Enable Logging
description: >
   Log data about what individual accounts and functions are doing within Armory Enterprise. Push data to the your chosen aggregator. Includes how to configure Armory Enterprise to send data to Splunk and contains example dashboards.
---

## Metrics and logging overview

Metrics allow you to investigate the health of your Armory Enterprise system. Armory's [Observability Plugin]({{< ref "observability-configure.md" >}}) provides a good overview of data over time about what is happening in particular services. You can monitor data points such as overall load, number of errors, and connection speeds.

Logging, on the other hand, is more useful to trace data about what individual accounts and functions are doing within Armory Enterprise. This data provides an overview on applications and errors and is primarily for auditing purposes. Armory Enterprise captures logging data in Echo, so you can configure Echo to send logging data to your data aggregator.

## {{% heading "prereq" %}}

You have set up a data aggregator with a unique endpoint. You need the endpoint and an authorization token when you enable logging in Armory Enterprise. Documentation for some popular data aggregators:

* [Create an HTTP Event Collector in Splunk](https://docs.splunk.com/Documentation/Splunk/8.2.4/Data/UsetheHTTPEventCollector)
* [Datadog Log Collection](https://docs.datadoghq.com/logs/log_collection/?tab=tcp)
* [Cloudwatch REST API Logging](https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-logging.html)

## Enable application logging data

The following configuration example shows how to configure Echo to send data to Splunk.  

{{< tabs name="enable-logging" >}}
{{< tabbody name="Operator" >}}

Add the <b>rest</b> block to the <b>spec.spinnakerConfig.profiles.echo</b> section of your Operator manifest.

{{< prism lang="yaml" >}}
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      echo:
        rest:
          enabled: true
          endpoints:
          - wrap: true
            url: "http://<HOSTNAME>:<PORT>/services/collector/event?"
            headers:
              Authorization: "<TOKEN>"
            template: '{"event":{{event}} }'
          insecure: true
{{< /prism  >}}

{{< /tabbody >}}
{{< tabbody name="Halyard" >}}

Add the <b>rest</b> block to the <b>echo-local.yml</b> section in your <b>~/.hal/default/profiles/</b> directory.

{{< prism lang="yaml" >}}
rest:
  enabled: true
  endpoints:
  - wrap: true
    url: "http://<HOSTNAME>:<PORT>/services/collector/event?"
    headers:
      Authorization: "<TOKEN>"
    template: '{"event":{{event}} }'
  insecure: true
{{< /prism  >}}

{{< /tabbody >}}
{{< /tabs >}}

The `HOSTNAME` and `PORT` should be the same as the TCP listener port available in your aggregator. `TOKEN` is the authorization token for your aggregator.

The `HOSTNAME:PORT` can be HTTPS, which would remove the need for the insecure TOKEN. You should consult your specific data aggregator provider's documentation for how to configure an HTTPS endpoint.

## Verify data flow to your aggregator

You can either wait for events to flow or run a new pipeline to test that Echo is sending logging details to your aggregator. You should now be able to search the Armory Enterprise index and see events coming in. If you don't see any data, Echo's logs should point to the source of the problem.

## Creating dashboards

After data is sent to your aggregator, you can set up dashboards to display useful data. Consult your data aggregator's documentation for details on creating dashboards.

## Splunk dashboard examples

If you are using Splunk, you can create a dashboard and then define the dashboard characteristics using a JSON file. The following examples show different dashboards created from logging data. Each example includes the JSON file that defines the dashboard characteristics.

### Developer insights

{{< figure src="/images/armory-admin/metrics/dash-developer-insights.png"  alt="Developer insights dashboard" >}}

<details><summary>Show me the JSON</summary>

{{< github repo="armory/logging-dashboards" file="json/armory-admin/metrics/developerInsights.json" lang="json" options="" >}}

</details>

### Software deployments

{{< figure src="/images/armory-admin/metrics/dash-software-deployments.png"  alt="Developer insights dashboard" >}}

<details><summary>Show me the JSON</summary>

{{< github repo="armory/logging-dashboards" file="json/armory-admin/metrics/softwareDeployments.json" lang="json" options="" >}}

</details>