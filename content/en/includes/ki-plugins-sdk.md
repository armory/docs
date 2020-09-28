#### Orca Plugins Using Plugin-SDK

If you use a plugin that is deployed on Orca and utilizes the Plugins SDK, do not upgrade to 2.22. There is a known issue where Orca cannot process messages in its queue, and the following error occurs:

```
com.fasterxml.jackson.databind.exc.InvalidTypeIdException: Could not resolve type id 'startExecution' as a subtype of `com.netflix.spinnaker.q.Message`: known type ids = []
...
```

This results in pipelines not starting.

No workaround exists. The V2 Plugins Framework will address this issue and be available in a later Armory version.

**Affected versions**: 2.22.x
