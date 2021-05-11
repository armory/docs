---
title: "deleteManifest"
linkTitle: "deleteManifest"
description: "fill me with delicious data, Stephen!"
weight: 15
---

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

| Key                                 | Type    | Description                                              |
|-------------------------------------|---------|----------------------------------------------------------|
| `deploy.account`                    | string  |
| `deploy.allCoordinates`             | array   |
| `deploy.credentials`                | string  |
| `deploy.events`                     | array   |
| `deploy.kinds`                      | array   |
| `deploy.labelSelectors.empty`       | boolean |
| `deploy.labelSelectors.notEmpty`    | boolean |
| `deploy.labelSelectors.selectors`   | array   |
| `deploy.location`                   | string  |
| `deploy.manifestName`               | string  |
| `deploy.options.apiVersion`         | ?       |
| `deploy.options.dryRun`             | ?       |
| `deploy.options.gracePeriodSeconds` | number  |
| `deploy.options.kind`               | ?       |
| `deploy.options.orphanDependents`   | ?       |
| `deploy.options.preconditions`      | ?       |
| `deploy.options.propagationPolicy`  | ?       |
