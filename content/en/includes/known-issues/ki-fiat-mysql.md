### MySQL Permission Repository error in 2.28.1+

Armory is currently investingating an issue with FIAT when using MySQL as the backend permission repository.  When it is enabled, unexpected authorization errors will appear in logs across Clouddriver/Orca/Front50 for users and Service Accounts.  Admins appear unaffected

The issue does not exist for 2.28.0 and lower, and environments using the default Redis backend will not encounter these errors

**Workaround**: Use Redis backend or 2.28.0 