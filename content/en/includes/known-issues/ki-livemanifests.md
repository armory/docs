#### Spinnaker liveManifestCalls set to `true` can cause major pipeline errors

Enabling `liveManifestCalls: true` causes the environment to exhibit odd behaviors.  Resources that have been deployed/changed in previous stages are not being taken in to consideration in current stages, leading to errors and issues in the pipeline deployment.

This can be especially detrimental to any pipelines that use a rollout strategy along with a `strategy.spinnaker.io/max-version-history` annotation, which causes inconsistent deployment target state as well as pipeline failures.

**Workaround**

Consult the [KB Article detailing solutions on this issue](https://support.armory.io/support?sys_kb_id=b1f16c701b3ca05013d4fe6fdc4bcb9f&id=kb_article_view&sysparm_rank=1&sysparm_tsqueryId=5365bbeb1b701510ec88b8c2cc4bcb90) for how to work around this issue.

**Impact**

This issue has existed for a while, but has only been documented recently.  [A fix has been added to OSS 1.23](https://github.com/spinnaker/spinnaker/issues/5607) and will be available in Armory 2.23.x once it is released.

Armory Support recommends turning off `lifeManifestCalls` by setting `liveManifestCalls: false` if you have any dynamic lookups in your pipelines.

**Introduced In**: OSS 1.12