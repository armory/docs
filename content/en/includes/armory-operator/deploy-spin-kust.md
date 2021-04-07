Once you have configured your patch files, you can deploy Spinnaker.

Create the `spinnaker` namespace. If you want to use a different namespace, you must update the `namespace` value in your `kustomization.yml` file.

```bash
kubectl create ns spinnaker
```

If you have Kustomize installed, run the following command from the `spinnaker-kustomize-patches` directory:

```bash
# If you have `kustomize` installed:
kustomize build | kubectl apply -f -
```

Otherwise, run:

```yaml
# If you only have `kubectl` installed
kubectl apply -k .
```

Watch the install progress and see the pods being created:

```bash
kubectl -n spinnaker get spinsvc spinnaker -w
```