---
---

{{< prism lang="yaml"  line-numbers="true" >}}
trafficManagement:
  - targets: ["<target-name>"]
    istio:
    - virtualService:
        name: <VirtualService-metadata-name>
        httpRouteName: <VirtualService-http-route-name>
      destinationRule:
        name: <DestinationRule-metadata-name>               
        activeSubsetName: <VirtualService-http-route-destination-subset-name>
        canarySubsetName: <canary-subset-name>     
{{< /prism >}}

* `targets`: (Optional) comma-delimited list of deployment targets; if omitted, CD-as-a-Service applies the traffic management configuration to all targets.
* `istio.virtualService`: (Required)

   * `istio.virtualService.name`: The name of your VirtualService
   * `istio.virtualService.httpRouteName`: The name of the HTTPRoute defined in your VirtualService. This field is optional if you define only one HTTPRoute.

* `istio.destinationRule`:  Optional if you only define only one DestinationRule.

   * `istio.destinationRule.name`: The name of your DestinationRule
   * `istio.destinationRule.activeSubsetName`: The name of the subset configured in your VirtualService HTTPRoute destination. This subset is running the current version of your app. `activeSubsetName` is optional if you define only one active subset.
   * `istio.destinationRule.canarySubsetName`: (Optional)  The name of the canary subset defined in your DestinationRule.

<!--  top of file must have the two lines of --- followed by a blank line or Hugo throws a compile error due to the embedded Prism shortcode -->
<!-- Do not "include" using the "%" version! -->