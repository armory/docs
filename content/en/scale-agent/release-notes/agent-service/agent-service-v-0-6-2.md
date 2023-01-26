---
title: v0.6.2 Armory Agent Service (2021-09-22)
toc_hide: true
version: 00.06.02
date: 2021-09-22
---

## New features and improvements

* You can now install the Armory Agent service with Helm:

```
helm repo add armory-charts http://armory.jfrog.io/artifactory/charts
helm install armory-agent armory-charts/agent-k8s-full \
    --set config.clouddriver.grpc=${CLOUDDRIVER_HOST_AND_PORT}
```

All configuration options available in the `armory-agent.yml` config file can be passed as values to Helm under the `config` section.

For more information, see {{< linkWithTitle "service-helm.md" >}}.

## Known Issues

{{< include "release-notes/agent/ki-permissions-whitespace.md" >}}