### Errors after a restart

After Clouddriver restarts, the following intermittent errors may happen when running pipelines:

* `Timeout exceeded for operation`: The cause of this instance of the error is different from the issue fixed in this release.
* `Credentials not found`

Both of these issues resolve themselves after a few minutes.

**Affected versions**: 0.8.39/0.9.31/0.10.15