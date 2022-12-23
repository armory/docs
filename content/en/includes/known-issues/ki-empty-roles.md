### When Auth Z is enabled, Access Denied on deployments using accounts that have empty permissions 2.28.x+

Users report that when attempting to use FIAT defined User Accounts/Service Accounts/Service Principals that have empty permissions or roles, they receive an `Exception: Access denied to account ***` message. (For example, `Exception: Access denied to account aws'.) This is contrary to expected behavior in Spinnaker/Armory CDSH.

To work around this issue, Customers can add roles to the accounts in FIAT that are affected, even "dummy" roles. Armory will be adding changes to the code beginning in 2.28.2 to address this issue 
