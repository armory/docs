#### Orca Plugins using Plugin SDK

If you use or are developing a plugin that is deployed on Orca and injects the `PluginSdks` interface, do not upgrade to 2.22. There is a known issue where Orca cannot process messages in its queue, and the following error occurs:

```
com.fasterxml.jackson.databind.exc.InvalidTypeIdException: Could not resolve type id 'startExecution' as a subtype of `com.netflix.spinnaker.q.Message`: known type ids = []
...
```

This results in pipelines not starting.

No workaround exists for plugin consumers. The V2 Plugins Framework will address this issue and be available in a later Armory version.

Plugin developers targeting 2.22 have a few options. The `PluginSdks`
interface allows developers to inject common utilities, like an HTTP client, into their plugins.
Developers can supply their own implementations of these utilities instead of
using `PluginSdks`. Alternatively, they can build a Spring-based plugin using Kork's `kork-plugins-spring-api` package that relies
on the parent Spinnaker service to inject these utilities.

**Affected versions**: 2.22.x
