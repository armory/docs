Once you have configured your patch files, you can deploy Armory Enterprise.

1. Create the `spinnaker` namespace:

   ```bash
   kubectl create ns spinnaker
   ```

   If you want to use a different namespace, you must update the `namespace` value in your `kustomization.yml` file.

1. Apply the manifest:

   Run the command from the `spinnaker-kustomize-patches` directory.

   If you have Kustomize installed:

   ```bash
   kustomize build | kubectl apply -f -
   ```

   Otherwise:

   ```yaml
   kubectl apply -k .
   ```

1. Watch the install progress and see the pods being created:

   ```bash
   kubectl -n spinnaker get spinsvc spinnaker -w
   ```