From the `workstation machine` where `kubectl` is installed:

If you are using Kubernetes version 1.14 or later, install the NGINX ingress controller components:

```bash
kubectl --kubeconfig kubeconfig-gke apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.35.0/deploy/static/provider/cloud/deploy.yaml
```

If you are using a Kubernetes version earlier than 1.14, perform the following steps:

1. Download this NGINX file: [mandatory.yaml](https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.30.0/deploy/static/mandatory.yaml)
2. Change `kubernetes.io/os` to `beta.kubernetes.io/os` on line 217 of `mandatory.yaml`.
   <!--- See the [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/) documentation for more details. --->
3. Run `kubectl apply -f` using the file you modified:

   ```bash
   kubectl apply -f <modified-mandatory-file>.yaml
   ```