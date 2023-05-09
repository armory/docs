---
title: v1.0.55 Armory Agent Service (2023-05-08)
toc_hide: true
version: 01.00.55
date: 2023-05-08
---

Changes:
- add the following properties to configure grpc connection backoff configuration:
  - `clouddriver.backoff.baseDelay` the amount of time to backoff after the first failure
  - `clouddriver.backoff.multiplier` the factor with which to multiply backoffs after a failed retry. Should ideally be greater than 1.
  - `clouddriver.backoff.jitter` the factor with which backoffs are randomized.
  - `clouddriver.backoff.maxDelay` is the upper bound of backoff delay.

Could find more details on https://github.com/grpc/grpc/blob/master/doc/connection-backoff.md, also check default values on https://pkg.go.dev/google.golang.org/grpc/backoff
