#### When Auth Z is enabled, Access Denied on deployments using accounts that have empty permissions

Users report that when attempting to use FIAT-defined User Accounts/Service Accounts/Service Principals that have empty permissions or roles, they receive an `Exception: Access denied to account ***` message. For example, `Exception: Access denied to account aws`. This is contrary to expected behavior in Spinnaker/Armory Continuous Deployment.

**Workaround**:

Users can add roles to the accounts in FIAT that are affected, even "dummy" roles.

See the [How to Audit for Empty Roles in FIAT using Redis/MySQL](https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010748) KB article for how to locate affected user accounts, service accounts, or service principals.

Customers can also now [upgrade to Armory CD 2.28.4](https://docs.armory.io/continuous-deployment/release-notes/rn-armory-spinnaker/armoryspinnaker_v2-28-4/#fixed-issues), which resolves this known issue

**Affected versions**: Armory CD 2.28.0-2.28.3