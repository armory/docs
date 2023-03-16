---
title: Errors and Troubleshooting
weight: 99
description: "This guide shows which errors are OK to ignore, how to troubleshoot Operator installation and manifest deployment, and where to ask for help."
---

## Reconciler error

You may see this error even though Operator successfully applies your manifest.
This error may be normal depending on the frequency of the error. Controllers work with a local cache that can be out of sync. The issue should resolve itself via repeated synchronization. One error may be fine since it's in the design of the reconciler. Too many means something is wrong.

```json
{
  "level": "error",
  "ts": 1592879777.6785922,
  "logger": "controller-runtime.controller",
  "msg": "Reconciler error",
  "controller": "spinnakerservice-controller",
  "request": "spinnaker-migration/spinnaker",
  "error": "Operation cannot be fulfilled on spinnakerservices.spinnaker.armory.io
   \"spinnaker\": the object has been modified; please apply your changes to the latest version and try again",
  "stacktrace": "github.com/go-logr/zapr.(*zapLogger).Error
    /opt/spinnaker-operator/build/vendor/github.com/go-logr/zapr/zapr.go:128
  sigs.k8s.io/controller-runtime/pkg/internal/controller.(*Controller).reconcileHandler
    /opt/spinnaker-operator/build/vendor/sigs.k8s.io/controller-runtime/pkg/internal/controller/controller.go:218
  sigs.k8s.io/controller-runtime/pkg/internal/controller.(*Controller).processNextWorkItem
    /opt/spinnaker-operator/build/vendor/sigs.k8s.io/controller-runtime/pkg/internal/controller/controller.go:192
  sigs.k8s.io/controller-runtime/pkg/internal/controller.(*Controller).worker
    /opt/spinnaker-operator/build/vendor/sigs.k8s.io/controller-runtime/pkg/internal/controller/controller.go:171
  k8s.io/apimachinery/pkg/util/wait.JitterUntil.func1
    /opt/spinnaker-operator/build/vendor/k8s.io/apimachinery/pkg/util/wait/wait.go:152
  k8s.io/apimachinery/pkg/util/wait.JitterUntil
    /opt/spinnaker-operator/build/vendor/k8s.io/apimachinery/pkg/util/wait/wait.go:153
  k8s.io/apimachinery/pkg/util/wait.Until
    /opt/spinnaker-operator/build/vendor/k8s.io/apimachinery/pkg/util/wait/wait.go:88"
}
```

## Kustomize `panic` error

If you installed Kustomize standalone, Kustomize v4.0+ `kustomize build` throws a `panic` error when it tries to parse and build using the patch files in the `spinnaker-kustomize-patches` repo. For example:

```bash
panic: runtime error: index out of range [145] with length 145 [recovered]
 panic: runtime error: index out of range [145] with length 145
```

Starting with `kubectl` v1.21 , the bundled Kustomize version is v4.0.5, so if you execute `kubectl kustomize .`, you also see this error.

Solution:

* Downgrade standalone Kustomize to v3.8.10.
* Downgrade to `kubectl` v1.19.

## Help resources

* Armory Operator: contact [Armory Support](https://support.armory.io/) or use the [Spinnaker Slack](https://join.spinnaker.io/) `#armory` channel.
* Spinnaker Operator: [Spinnaker Slack](https://join.spinnaker.io/) `#kubernetes-operator` channel.
