Armory CD-as-a-Service has the following constraints when deploying a manifest:

- The manifest must contain exactly 1 `Kubernetes Deployment` object within a single deployment file.
- Deploying ReplicaSets is not  supported.
- Deploying Pods is not supported.