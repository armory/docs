`kubernetes.activeService`: (Required if configuring a `kubernetes` block) the name of a Kubernetes `Service`. Its service selector should target a Kubernetes `Deployment` resource in your deployment's manifests. The `Service` should exist at the time of deployment.

`kubernetes.previewService`: (Optional) the name of a Kubernetes `Service`. Its service selector should target a Kubernetes `Deployment` resource in your deployment's manifests. The `Service` should exist at the time of deployment.
