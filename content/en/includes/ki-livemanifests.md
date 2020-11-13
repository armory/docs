#### Spinnaker lifeManifestCalls set to True can cause Major Pipeline Errors

Enabling `liveManifestCalls: true`, causes environment to exhibit odd behaviors.  Resources that have been deployed/changed in previous stages are not being taken in to consideration in current stages, leading to errors and issues in the Pipeline Deployment

This can be especially detrimental to any pipelines that use a rollout strategy along with a strategy.spinnaker.io/max-version-history annotation, causing inconsistent state of deployment targets, and also pipeline failures

**Workaround**

For more detailed information about working around this issue, please consult with the [KB Article detailing solutions on this issue](https://armoryspinnaker.force.com/s/article/Accounts-with-liveManifestCalls-Set-to-True-Have-In-Correct-Dynamic-Lookup-Results)

**Impact**

This issue has existed for a while, but has only been documented recently.  [A fix has been added to OSS 1.23](https://github.com/spinnaker/spinnaker/issues/5607), and will be available in Armory 2.23.x once it is released

Customers are recommended to turn off lifeManifestCalls by setting `liveManifestCalls: false` if they have any dynamic lookups in their pipelines.

**Introduced in**: OSS 1.12