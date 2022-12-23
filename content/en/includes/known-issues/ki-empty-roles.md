### Access Denied on Accounts when AuthZ is enabled, and Accounts have Empty Permissions 2.28.x+

Users report that when attempting to use FIAT defined User Accounts/Service Accounts/Service Principals that have empty permissions or roles, they will receive an `Exception: Access denied to account ***` (for example, `Exception: Access denied to account aws') This is contrary to expected behavior in Spinnaker/Armory CDSH.

To work around this issue, Customers can provide add roles to the accounts in FIAT that are affected, even a "dummy" role.  Armory will be adding changes to the code beginning in 2.28.2 to address this issue 