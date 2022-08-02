---
title: v1.0.2 Armory Agent Service (2022-01-12)
toc_hide: true
version: 01.00.02

---

## Improvements

The Agent Service now returns the status code from the Kubernetes REST API when an error occurs while it performs an operation. Previously, the Armory Agent returned a 500 error code no matter what the error was. For example, if the error was a permissions issue (403 status code), the Armory Agent still returned a 500 error.
