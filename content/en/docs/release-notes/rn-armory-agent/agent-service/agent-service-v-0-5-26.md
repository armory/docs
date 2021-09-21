---
title: v0.5.26 Armory Agent Service (2021-09-10)
toc_hide: true
version: 00.05.26

---

## New features and improvements

* You can now control the Agent's behavior when a failed request to the Kubernetes API server occurs:

   ```yaml
   kubernetes:
     retries:
       enabled: true         # (Optional, boolean, default: true). Enable or disable retries when the Agent makes a failed request to the Kubernetes API server.
       maxRetries: 3         # (Optional, integer, default: 3): The number of times that the Agent will try the same request if it fails.
       backOffMs: 3000       # (Optional, integer, default: 3000): How much time (in milliseconds) to wait between retry attempts.
       retryAnyError: false  # (Optional, boolean, default: false): Optional. If true, Agent will retry when encountering any error from the Kubernetes API server. If false, Agent will only retry if the error contains any item from `retryableErrors.`
       retryableErrors:      # (Optional, list of strings, default: "timeout", "deadline exceeded"): Optional. If the error from the Kubernetes API server contains any item from this list, the request will be retried. Requires `retryAnyError` to be `false`.
       - "timeout"
       - "deadline exceeded"
   ```
