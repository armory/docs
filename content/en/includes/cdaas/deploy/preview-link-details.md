This step enables exposing deployed `service` resources via a temporary, internet-facing, randomly generated link for testing purposes. 
The services must reside within the `namespace` addressed by a given deployment. The exposed services must define a single HTTP(S) port. 
The link automatically expires after a predefined amount of time. The exposed links are not secure.  

{{< prism lang="yaml"  line-numbers="true" >}}
...
steps:
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

The `ttl` section is optional and if not provided, defaults to 5 minutes. Minimum value is 1 minute, maximum is 24 hours.
The `service` name must not contain namespace information and in order to succeed, it must exist at the moment the step is executed.  

In this example, the snippet instructs Armory CD-as-a-Service to create a public URL to the deployed services SVC1 and SVC2. Both automatically expire after 2 hours.

{{< prism lang="yaml"  line-numbers="true" >}}
...
steps:
...
- exposeServices:
  services:
  - SVC1
  - SVC2
  ttl:
    duration: 2
    unit: hours
{{< /prism >}}