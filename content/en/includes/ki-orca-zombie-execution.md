#### Zombie Executions

Starting in Spinnaker 2.23.0, ManifestForceCacheRefreshTask was removed, as Kubernetes manifest related stages now do live lookups.  While upgrading to Spinnaker 2.23.0 or later, if there is a running pipeline that contains a Kubernetes manifest related stage, it becomes a [zombie execution](https://spinnaker.io/guides/runbooks/orca-zombie-executions/). This causes Orca, Spinnaker's orchestration service, to fail to complete any Kubernetes manifest related stage in that pipeline.

**Workarounds**:

To resolve the issue, cancel any zombie executions. For information about how to cancel them, see the [Orca Zombie Execution runbook](https://spinnaker.io/guides/runbooks/orca-zombie-executions/#cancel-the-execution).

**Affected versions**: 2.23.0 and later
