#### Orca Plugins Using Plugin-SDK

If you use a plugin that is deployed on Orca and utilizes the plugins sdk, do not upgrade to 2.22. There is a known issue where Orca cannot process messages in its queue and pipelines will not start, due to the following error:

```
com.fasterxml.jackson.databind.exc.InvalidTypeIdException: Could not resolve type id 'startExecution' as a subtype of `com.netflix.spinnaker.q.Message`: known type ids = []
...
```

No workaround exists, the V2 Plugin framework will fix this issue in 2.23.

**Affected versions**: 2.22.0
**Fixed versions**:
