---
title: v0.5.26 Armory Agent Service (2021-09-10)
toc_hide: true
version: 00.05.26

---

## New

* Added retries for failed requests to kubernetes API server. Default configuration:

```
kubernetes:
  retries:
    enabled: true         # (Optional, boolean, default: true). Enables or disables the feature.
    maxRetries: 3         # (Optional, integer, default: 3): How many times to retry the same request to the kubernetes API server.
    backOffMs: 3000       # (Optional, integer, default: 3000): How much time to wait between retries in milliseconds.
    retryAnyError: false  # (Optional, boolean, default: false): If true, agent will retry when receiving any kind of error from the kubernetes API server. If false, agent will only retry if the error contains any item from "retryableErrors".
    retryableErrors:      # (Optional, list of strings, default: "timeout", "deadline exceeded"): If the error from the kubernetes API server contains any item from this list, the request will be retried.
    - "timeout"
    - "deadline exceeded"
```

