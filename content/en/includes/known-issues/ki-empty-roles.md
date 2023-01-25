#### When Auth Z is enabled, Access Denied on deployments using accounts that have empty permissions

Users report that when attempting to use FIAT-defined User Accounts/Service Accounts/Service Principals that have empty permissions or roles, they receive an `Exception: Access denied to account ***` message. For example, `Exception: Access denied to account aws`. This is contrary to expected behavior in Spinnaker/Armory Continuous Deployment.

**Workaround**:

Users can add roles to the accounts in FIAT that are affected, even "dummy" roles. 
Customers can use the following KB article to locate the user accounts, service accounts, or service principals, affected  https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010748

**Affected versions**: Armory CD 2.28.x