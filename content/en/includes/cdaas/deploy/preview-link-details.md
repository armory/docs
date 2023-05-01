The section enables exposing deployed `service` resources via a temporary, internet-facing, randomly generated link for testing purposes.  

{{< prism lang="yaml"  line-numbers="true" >}}
...
- exposeServices:
    services:
      - <service-name-1>
      - <service-name-2>
      - <service-name-n>
    ttl:
      duration: <integer>
      unit: <seconds|minutes|hours>
{{< /prism >}}

* `services`: List of one-to-many services to expose
  * Each service name must match an existing service deployed in the target cluster.
  * Each service must be in the same namespace as the app you are deploying.
  * Each service must define a single HTTP port.
* `ttl`: (Optional) The lifetime of the exposed service preview
  * Minimum: 1 minute (60 seconds)
  * Maximum: 24 hours
  * Default: 5 minutes

Each link automatically expires after the configured amount of time. The exposed link is not secure.  

You can configure multiple `exposeServices` entries, each having a different expiration time.

You can use exposed service links elsewhere in your deploy config, such as in your webhook definitions. The naming convention is `armory.preview.<service-name>`.

**Example**

In this example, the snippet instructs Armory CD-as-a-Service to create a public URL to the deployed services service-name-1 and service-name-2. Both automatically expire after 2 hours.

{{< prism lang="yaml"  line-numbers="true" >}}
...
- exposeServices:
    services:
      - service-name-1
      - service-name-2
    ttl:
      duration: 2
      unit: hours
{{< /prism >}}
