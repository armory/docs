---
title: frag-helm-agent-mode
toc_hide: true
exclude_search: true
---

Base command:

{{< prism lang="bash" line="2" >}}
helm install armory-agent armory-charts/agent-k8s-full \
--namespace=<agent-namespace>
{{< /prism >}}

L2: `agent-namespace` is the namespace where you install the Agent; it is also the deployment target where you install your app .

If you haven't created the namespace, you can do it with the [`--create-namespace`](https://helm.sh/docs/helm/helm_install/#options) flag, which creates the namespace if not present.

{{< prism lang="bash" line="3" >}}
helm install armory-agent armory-charts/agent-k8s-full \
--namespace=<agent-namespace> \
--create-namespace
{{< /prism >}}

Connecting to Armory Cloud services is enabled by default. Include your credentials if you want to connect to Armory Cloud services:

{{< prism lang="bash" line="4" >}}
helm install armory-agent armory-charts/agent-k8s-full \
--namespace=<agent-namespace> \
--create-namespace \
--set hub.auth.armory.clientId=<your-client-ID>,hub.auth.armory.secret=<your-client-secret>
{{< /prism >}}

If you don't want to connect to Armory Cloud services, include your gPRC endpoint:

{{< prism lang="bash" line="4" >}}
helm install armory-agent armory-charts/agent-k8s-full \
--namespace=<agent-namespace> \
--create-namespace \
--set config.clouddriver.grpc=localhost:9090
{{< /prism >}}
