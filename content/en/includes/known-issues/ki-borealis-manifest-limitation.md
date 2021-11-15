Project Aurora/Borealis have the following constraints when deploying a manifest:

- The manifest must contain exactly 1 `Kubernetes Deployment` object within a single deployment file (Borealis) or Project Aurora Spinnaker Stage (Aurora).
- Deploying ReplicaSets is not  supported.
- Deploying Pods is not supported.