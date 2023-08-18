---
title: frag-helm-agent-mode
---

Run one of the following commands:

1. If you want to connect to Armory Cloud services:

   You must include your Armory Cloud **clientId** and **clientSecret** credentials.

   ```bash
   helm install armory-agent armory-charts/agent-k8s-full \
   --create-namespace \
   --namespace=<agent-namespace> \
   --set hub.auth.armory.clientId=<your-clientID>,hub.auth.armory.secret=<your-clientSecret>
   ```


1. If you don't want to connect to Armory Cloud services:

   You must include your gPRC endpoint, such as `localhost:9090`.
   
   ```bash
   helm install armory-agent armory-charts/agent-k8s-full \
   --create-namespace \
   --namespace=<agent-namespace> \
   --set config.clouddriver.grpc=<endpoint>
   ```


Command options:

- `--create-namespace`: (Optional) Creates the namespace if not present. See the [Helm install docs](https://helm.sh/docs/helm/helm_install/#options).
- `--namespace=<agent-namespace>`: (Required) The namespace where you install the Armory Scale Agent, which is also the deployment target for your app.


