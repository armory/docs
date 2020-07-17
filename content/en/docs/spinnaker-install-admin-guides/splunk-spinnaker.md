___
  title: Configure the Armory Splunk App for Spinnaker
---


If you would like more information about the data exposed by this application you can see the [video walkthrough](#aws-quickstart-step-2-video) at the bottom of this page.

## Install the Armory Splunk App for Spinnaker

1. Go to the Splunk App store "Splunkbase" and download the "Armory Splunk App for Spinnaker".  https://splunkbase.splunk.com/
2. Search for "Armory" or "Spinnaker"
3. Install the "Armory Splunk App for Spinnaker" on the Search Head, Indexer, or in the "/etc/master-apps/" directory on the master for Search Head Clustering.
4. The TA can be installed on the Indexers, Heavy Forwarders, or all in one Splunk.  It's the data input, so install based on your Splunk architecture.



## Configure Splunk HTTP Event Collector Endpoint to recieve data from Spinnaker

To start we'll configured Splunk to recieve authenticated data flow from Spinnaker.  This is no different than any other HTTP Event Collector configuration which can be found here.  

1. Configure Splunk to have a new Data Input.  In the top right of the Splunk UI click #Settings > Data Inputs
![No CREATE Permission](data-inputs.png)
2. Located the "HTTP Event Collector" and click the "+ Add New"
![No CREATE Permission](http-event-collector.png)
3. Under the "Name" Field give the input a name such as "Spinnaker".  Click the "Next" button at the top.
![No CREATE Permission](select-source.png)
4. Leave the "Source type" as "Automatic given the data source is JSON and parsed by default.  For the "App context" select "Armory (TA-armory)".  Lastly, select "armory" as the index for storing the data in Splunk.  Click the "Review" button at the top.
![No CREATE Permission](input-settings.png)
5. Finally to configure the HTTP Event Collector Data Input for Spinnaker click the "Submit" button.
![No CREATE Permission](token.png)

You will see that Splunk has "Successfully" created the new data input, and the authentication token for the HTTP event collector is generated.  You can keep this and store it for the Spinnaker configuration.  If you didn't happen to save the token don't worry.  You can always view the HTTP Event Collector Data Inputs and find the authentication token there.

## Configure Spinnaker to forward data to Splunk HTTP Event Collector - Halyard Configuration 

1. Login to your Halyard pod.  This can be running standalone, in your kubernetes cluster, or as a part of Minnaker (Spinnaker in a VM)
2. Navigate to the ~/.hal/default/profiles directory inside of Halyard file system.
3. Create a "echo-local.yml" file to apply configuration to the Spinnaker "Echo" service.  This can be done with any text editor such as VI.
4. Insert this JSON block replacing the endpoint hostname with the IP or Hostname of your configured HTTP Event Collector.  Also, replace the TOKEN section with the token generated from the Splunk HTTP Event Collector configuration in Step 2.  Save file.
5. Run a "hal deploy apply" within the Halyard container to apply the new Echo configuration.  Once the Spinnaker services that need the configuration change restart you'll see Spinnaker data starting to flow to the HTTP Event Collector and indexed in the "armory" index.  Validate by running a search "index=armory" in the Splunk search bar.

## Operator Configuration. Insert this yaml into your SpinnakerService.yml file or used as a Patch file if using kustomize to build SpinnakerService.yml
 ---
 ```bash
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
            url: "https://[HTTP-Event-Collector-Endpoint]:8088/services/collector/event?"
          headers:
            Authorization: "Splunk [Your-HTTP-Event-Collector-Token]"
          template: '{"event":{{event}} }'
          insecure: true
  ```
---
## Halyard Configuration.  Place this yaml into the ~/.hal/default/profile/echo-local.yml

```bash
rest:
  enabled: true
  endpoints:
    - wrap: true
      url: "https://[HTTP-Event-Collector-Endpoint]:8088/services/collector/event?"
      headers:
        Authorization: "Splunk [Your-HTTP-Event-Collector-Token]"
      template: '{"event":{{event}} }'
      insecure: true
  ```

For Halyard install, once you have created the echo-local.yml file with the above contents runs "hal deploy apply" to apply changes.

## Validate in Splunk by searching index for Spinnaker Events

![No CREATE Permission](validate-splunk-search.png)

## Configure Automated Rollback with Splunk and Spinnaker

The Armory Splunk App for Spinnaker includes a Splunk webhook for data driven automated rollback.  You can configure this webhook to the Spinnaker API.

1. In Splunk while in the Spinnaker App, Click on "Settings > Searches Reports & Alerts" and locate the "Rollback" Alert.
![No CREATE Permission](settings-alert.png)
2. Under "Action" click "Edit" then "Edit Alert"
![No CREATE Permission](edit-rollback.png)
3. Scroll down to "Trigger Actions" and replace the "[YOUR-GATE-HOSTNAME]" with the FQDN or IP of your Spinnaker Gate service.
![No CREATE Permission](gate-rollback.png)
4. Next on the same URL replace the "[YOUR-SPINNAKER-APP]" with the Spinnaker Application you'd like to Rollback based on Errors, Exceptions, or KPI's from Splunk.
![No CREATE Permission](gate-spinnaker-app.png)

## Armory Splunk App for Spinnaker - Video Walkthrough
{{< youtube y8Dm6k7c94Q >}}