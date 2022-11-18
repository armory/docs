### Google App Engine account authentication

Spinnaker 1.28 introduced a new API to allow adding accounts to Spinnaker.  This change required all existing providers to register themselves with the credentials repo system.  Several cloud providers were missed as part of the migration, including Google and AppEngine providers. It’s possible other non-supported providers may also be broken.  The result of this is that users cannot see any Google or App Engine accounts listed in the UI, and non-admin users get an Access Denied error when trying to run pipelines as no permissions are granted.  Admins can still deploy to these accounts since they bypass any permissions restrictions.

**Workaround**:

2.28.X or later: Replace the Clouddriver image in 2.28 with the Armory Clouddriver 2.27 image

1.28.X or later: Replace the Clouddriver image in 1.28 with the OSS Clouddriver 1.27 image
