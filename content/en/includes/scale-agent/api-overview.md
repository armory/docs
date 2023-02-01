The Dynamic Accounts REST API provides endpoints to create, delete, get, migrate, and update Kubernetes accounts. You can't access these endpoints through Gate.

* If you have `kubectl` access to your Spinnaker cluster, you need to `port-forward` before you can call the API.

   ```bash
   kubectl port-forward deployment/spin-clouddriver 7002:7002 -n spinnaker 
   ```

   You can then access endpoints via `http://localhost:7002`.

* If you don't have direct access to your cluster, you should create an [external load balancer](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/) that exposes Clouddriver port 7002. You can then call the API using the public `https://<clouddriver-loadbalancer-url>:<clouddriver-port>`. 