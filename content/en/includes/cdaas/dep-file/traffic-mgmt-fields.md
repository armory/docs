`targets`: (Optional) comma-delimited list of deployment targets; if omitted, CD-as-a-Service applies traffic management to all targets.

`smi.rootServiceName`: (Required) the name of a Kubernetes `Service` pointing to the deployment object; the SMI `TrafficSplit` spec defines a root service as the fully qualified domain name (FQDN) used by apps to communicate with your service. The `Service` should exist at the time of deployment. Its service selector should target a Kubernetes `Deployment` resource in your deployment's manifests.

`smi.canaryServiceName`: (Optional) the name of a Kubernetes `Service` pointing to the canary deployment object
- If you provide a `canaryServiceName`, CD-as-a-Service assumes the `Service` already exists and uses it for deployment.
- If you don't provide a `canaryServiceName`, CD-as-a-Service creates a `Service` object and gives it the name of the root service with "-canary" appended to it. For example, if your root service is "myRootService", then the canary service name would be "myRootService-canary".

`smi.trafficSplitName`: (Optional) CD-as-a-Service uses the provided name when creating an SMI `TrafficSplit`.
