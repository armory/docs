The Dynamic Accounts REST API provides endpoints to create, delete, get, migrate, and update Kubernetes accounts. You can't access these endpoints through Gate. You should have `kubectl` access to your Spinnaker cluster and `port-forward` to be able to call the API.

```bash
kubectl port-forward deployment/spin-clouddriver 7002:7002 -n spinnaker 
```

You can then access endpoints via `http://localhost:7002`.
