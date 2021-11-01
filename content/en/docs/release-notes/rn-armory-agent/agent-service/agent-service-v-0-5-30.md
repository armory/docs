---
title: v0.5.30 Armory Agent Service (2021-10-13)
toc_hide: true
version: 00.05.30

---

## Feature

Sending operation results back to Clouddriver is now more resilient. A retry mechanism (enabled by default) can be configured in case errors occur:

```yaml
clouddriver:
  responseRetries:
    enabled: true     # (Optional, boolean, default: true). Enables or disable retries.
    maxRetries: 1200  # (Optional, integer, default: 1200): How many times to retry sending the response to Clouddriver.
    backOffMs: 3000   # (Optional, integer, default: 3000): How much time to wait between retries in milliseconds.
```

Note that the `kubesvc.cache.operationWaitMs` config for the Agent Plugin should be set so that it does not time out before the retries are complete.

## Known Issues

{{< include "release-notes/agent/ki-permissions-whitespace.md" >}}