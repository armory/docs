### MySQL Permission Repository error in 2.28.1-2.28.4

Armory is investigating an issue with FIAT when using MySQL as the backend permission repository.  When it is enabled, unexpected authorization errors appear in logs across Clouddriver/Orca/Front50 for users and Service Accounts.  Admins appear unaffected.

The issue does not exist for 2.28.0 and lower and has since been resolved as of 2.28.5.  Environments using the default Redis backend do not encounter these errors.
For more information about the changes that resolve this fix, [please visit the following PR](https://github.com/spinnaker/fiat/pull/1012)

**Workaround**: Use Redis backend, 2.28.0, 2.28.5+

**Affected versions**: Armory CD 2.28.1-2.28.4