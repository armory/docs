---
linkTitle: Integrate Splunk with Armory Enterprise
title: Integrate Splunk with Armory Enterprise
description: >
  (Legacy) Learn how to configure the Armory Splunk application so you can display your SDLC data in Splunk dashboards.
draft: true
---

{{% alert title="Limited Support" color="warning" %}}
The Armory Splunk App is no longer under active development. Support is limited. Customers interested in Splunk integration should contact their Technical Account Manager to discuss requirements and next steps.
{{% /alert %}}

## Overview of Splunk integration

The Armory Splunk App brings all the SDLC information your organization has into a digestible and familiar format, Splunk dashboards. Connect Splunk to Armory Enterprise with the Armory Splunk App. See information like your top deployment artifacts and user information in Splunk. If you would like more information about the data that Armory Enterprise feeds into Splunk, watch the [video walkthrough](#video-walkthrough) at the bottom of this page.

## Install the Armory Splunk App for Spinnaker

1. Go to the [Splunk App store (Splunkbase)](https://splunkbase.splunk.com/) and download the "Armory Splunk App for Spinnaker"
2. Search for "Armory" or "Spinnaker."
3. Install the "Armory Splunk App for Spinnaker" on the Search Head, Indexer, or in the "/etc/master-apps/" directory on the master for Search Head Clustering.
4. The TA can be installed on the Indexers, Heavy Forwarders, or all in one Splunk.  It's the data input, so install based on your Splunk architecture.

## Configure Splunk HTTP Event Collector Endpoint to receive data from Spinnaker

To start, configure Splunk to receive authenticated data flow from Spinnaker.  This configuration is similar to any other HTTP Event Collector.

Perform the following steps:

1. Configure Splunk to have a new Data Input. In the top right of the Splunk UI, select **Settings > Data Inputs**.
{{< figure src="/images/splunk-data-inputs.png" alt="New Data Input" >}}
1. Locate the **HTTP Event Collector** and click the **+ Add New**.
{{< figure src="/images/splunk-http-event-collector.png" alt="Add new HTTP Event Collector." >}}
3. Under the **Name** field, give the input a name, such as "Spinnaker" and click **Next**.
{{< figure src="/images/splunk-select-source.png" alt="Name it Spinnaker.">}}
4. Select the following configurations:
   * **Source type**: Select **Automatic** since given the data source is JSON and parsed by default.  
   * **App context**: Select **Armory (TA-armory)**.  
   * **Index**: Select "armory" as the index for storing the data in Splunk.  Click the "Review" button at the top.
{{< figure src="/images/splunk-input-settings.png" alt="Configure the event collector." >}}
1. Configure the HTTP Event Collector Data Input for Spinnaker and click **Submit**.
{{< figure src="/images/splunk-token.png" alt="Save a copy of the generated token." >}}

You will see that Splunk  successfully created the new data input, and the authentication token for the HTTP event collector is generated.  Keep this token and store it for the Spinnaker configuration.  You can always view the HTTP Event Collector Data Inputs and find the authentication token there..

## Forward data to the Splunk HTTP Event Collector

This section describes how to forward data to Splunk so that you can see data from Spinnaker in your Splunk dashboard.

### Operator configuration

Insert this YAML into your `SpinnakerService.yml` file, or use it as a patch file if you use Kustomize to build `SpinnakerService.yml`:

 ```yaml
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
          url: "https://<Your-HTTP-Event-Collector-Hostname>:8088/services/collector/event?"
          headers:
            Authorization: "Splunk <Your-HTTP-Event-Collector-Token>"
          template: '{"event":{{event}} }'
          insecure: true
  ```
Make the following changes:
* **`url`**: Replace `<Your-HTTP-Event-Collector-Hostname>` with the IP or Hostname of your configured HTTP Event Collector.  
* **`Authorization`**: Replace `<Your-HTTP-Event-Collector-Token>` with the token generated from the Splunk HTTP Event Collector

Once the Spinnaker services that need the configuration change restart, Spinnaker data starts to flow to the HTTP Event Collector and indexed in the "armory" index.

## Verify the connection

You can verify that events are flowing from Spinnaker to Splunk by performing a search for `index=armory` in the Spunk UI.

{{< figure src="/images/splunk-validate-search.png" >}}

## Configure Automated Rollback with Splunk and Spinnaker

The Armory Splunk App for Spinnaker includes a Splunk webhook for data driven automated rollback.  You can configure this webhook to the Spinnaker API.

1. Select the Spinnaker App in the Splunk UI.
2. Click on **Settings > Searches, reports and alerts** and locate the **Rollback** Alert.
{{< figure src="/images/splunk-settings-alert.png" alt="Go to the Searches, reports, and alerts page." >}}
2. Select **Action > Edit > Edit Alert**.
{{< figure src="/images/splunk-edit-rollback.png" >}}
3. Find the **Trigger Actions** section.
4. Under **Webhook** > **URL**, insert the following URL:

   `https://<YOUR-GATE-HOSTNAME>/api/v1/webhook/<YOUR-SPINNAKER-APP>`
   * Replace the `<YOUR-GATE-HOSTNAME>` with the fully qualified domain name or IP of your Spinnaker Gate service.
   {{< figure src="/images/splunk-gate-rollback.png" >}}
   * Replace the "[YOUR-SPINNAKER-APP]" with the Spinnaker Application you'd like to Rollback based on Errors, Exceptions, or KPI's from Splunk.
   {{< figure src="/images/splunk-gate-spinnaker-app.png" >}}

## Video Walkthrough
{{< youtube y8Dm6k7c94Q >}}
