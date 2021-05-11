---
title: "cleanupArtifacts"
linkTitle: "cleanupArtifacts"
description: "fill me with delicious data, Stephen!"
weight: 15
---

The full package name is `spinnaker/deployment/tasks/before/cleanupArtifacts`.

## Example Payload

```json
{
  key: "value",
}
```

## Example Policy

```rego

```

## Keys


| Key                                                          | Type    | Description                                              |
|--------------------------------------------------------------|---------|----------------------------------------------------------|
| `deploy.account`                                             | string  |
| `deploy.credentials`                                         | string  |
| `deploy.events`                                              | array   |
| `deploy.manifests.*`                                         | object  | The entire Kubernetest manifest that is to be removed.   |