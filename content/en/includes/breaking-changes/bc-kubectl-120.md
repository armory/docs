#### Update kubectl to 1.20

**Impact**

With 2.28 of spinnaker, we’ve updated the kubectl binary to a 1.20 release.  You may have potential caching issues as a result due to certain resources in K8s being removed and/or no longer supported.  It’s recommended to look for failures in your log files and exclude resources that don’t match your target cluster.  For example, adding “PodPreset” to the “omitKinds” on your K8s account configs would cause spinnaker to skip trying to cache resources that no longer be able to be cached in newer kubernetes releases.


**Introduced in**: Armory 2.28.0