`smi.rootServiceName`: (Required if configuring an `smi` block) the name of a Kubernetes `Service`. Its service selector should target a Kubernetes `Deployment` resource in your deployment's manifests. The SMI `TrafficSplit` spec defines a root service as the fully qualified domain name (FQDN) used by clients to communicate with your application. The `Service` should exist at the time of deployment. 

`smi.canaryServiceName`: (Optional) the name of a Kubernetes `Service`. Its service selector should target a Kubernetes `Deployment` resource in your deployment's manifests.
- If you provide a `canaryServiceName`, CD-as-a-Service assumes the `Service` already exists and uses it for deployment.
- If you don't provide a `canaryServiceName`, CD-as-a-Service creates a `Service` object and gives it the name of the root service with "-canary" appended to it. For example, if your root service is "myRootService", then the canary service name would be "myRootService-canary".

`smi.trafficSplitName`: (Optional) CD-as-a-Service uses the provided name when creating an SMI `TrafficSplit`.
