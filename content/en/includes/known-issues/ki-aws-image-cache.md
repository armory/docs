#### AWS image caching

There is an issue where Clouddriver fails to cache images that belong to the first account (alphabetically) for each region. For example, in a region with accounts named Edith, Milton, and Pixel, Edith's images do not get cached.

**Affected versions**: 2.23.3 and earlier

**Fixed versions**: 2.24.0, 2.23.4

**Workaround**: 

Two workarounds exist for this issue:

- **Option 1**: Add an account with a name that comes first alphabetically. Then, turn off the agents for that account using the `sql.agent.disabledAgents` parameter in `clouddriver-local.yml` or the equivalent section of your Operator config file. Use regex for the value instead of attempting to create a list manually.

- **Option 2**: In `clouddriver-local.yml` or the equivalent section of your Operator config file, disable public image caching with the following parameter: `aws.defaults.publicImages.enabled: false`.