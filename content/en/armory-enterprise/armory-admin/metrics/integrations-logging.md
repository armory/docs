---
linkTitle: Logging in Armory Enterprise
title: Logging
description: >
   Log data about what individual accounts and functions are doing within Armory Enterprise. Push data to the your chosen aggregator.
---

## Why logging can be necessary and different from metrics

Metrics allow SysOps and personnel to investigate the health of the overall Spinnaker system.  They are meant to provide a good overview of the data over time about what is happening in particular services in Spinnaker, for example, overall load, # of errors, and connection speeds, using the Observability Plugin
Logging on the other hand is more useful to trace data about what individual accounts and functions are happening within Spinnaker.  They will provide more overview on Applications data and Error details.  Data in this sense is more for auditing purposes.

## Enabling application logging data

Armory is providing the following documentation to enable your Application Logging data into your Data Aggregator of choice.  The information provided can be used to push Application Logging data to any number of big data aggregators. As an example, we'll show how this data can be sent to Splunk.  

## Where you can find logging data

Logging data for Armory Enterprise can be found in Echo, and can be sent to the aggregator of choice. Customers will need to set up their Aggregator beforehand before setting up this portion below, if they have not done so already, so that a token and endpoint can be defined in Spinnaker.  
Please note that if possible, it is recommended that a unique port is defined when declaring/setting up the end point in your provider.
Please refer to your Aggregator's documentation on how to do so.  
Below are links to documentation from some of the most popular providers

Create a HEC in Splunk
Datadog Log Collection
Cloudwatch REST API Logging

### Enable logging

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

The `HOSTNAME:PORT` can be HTTPS, which would remove the need for the insecure TOKEN. You should consult your specific data aggregator provider's documentation.

## Verify data flow in your aggregator

Customers can then either wait for events to flow, or kick off a new pipeline to test that logging details are being sent.
If everything was configured correctly, you should now be able to search the Spinnaker index and see events coming in. If you don't see any data, Echo's logs will often point out to the source of the problem.

## Creating dashboards

Customers can then set up dashboards according to data that they may feel is useful.
As per our examples for Splunk, Customers can create a dashboard as per Splunk's documentation, and then define the dashboard characteristics as a JSON

## Dashboard examples

Armory provides the following Dashboard JSON examples to show how some of the data values from a customer's Spinnaker logs can be used within their aggregator. They are meant to be examples of what can be done with the data, but customers are encouraged to make their own adjustments to suit their needs.

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