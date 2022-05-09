`targets`: (Optional) comma-delimited list of deployment targets; if omitted, CDaaS applies traffic management to all targets.

`smi.rootServiceName`: (Required) the name of a Kubernetes `Service` pointing to the deployment object; the SMI `TrafficSplit` spec defines a root service as the fully qualified domain name (FQDN) used by apps to communicate with your service. The FQDN should exist at the time of deployment. Its service selector should target a Kubernetes `Deployment` resource in your deployment's manifests.

`smi.canaryServiceName`: (Optional) the name of a Kubernetes `Service` pointing to the canary deployment object
- If you provide a `canaryServiceName`, CDaaS assumes the `Service` already exists and uses it for deployment.
- If you don't provide a `canaryServiceName`, CDaaS creates the name by adding "-canary" to the `rootServiceName`.<br>

`smi.trafficSplitName`: (Optional) CDaaS uses the provided name when creating an SMI `TrafficSplit`.
