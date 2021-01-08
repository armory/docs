#### Zombie Executions

Starting in Spinnaker 2.23.0, ManifestForceCacheRefreshTask was removed, as Kubernetes manifest related stages now do live lookups. When upgrading to Spinnaker 2.23.0, if there is a running pipeline that contains a Kubernetes manifest related stage, it will become a [zombie execution](https://spinnaker.io/guides/runbooks/orca-zombie-executions/) and Orca will not be able to complete any Kubernetes manifest related stage in that pipeline.

**Workarounds**:

In order to fix the issue, the zombie exectuions must be cancelled. Please see our [orca zombie execution runbook](https://spinnaker.io/guides/runbooks/orca-zombie-executions/#cancel-the-execution) for instructions to cancel the zombie executions.

**Affected versions**: 2.23.0 and later