Once you have configured your patch files, you can deploy Armory Continuous Deployment.

1. Create the `spinnaker` namespace:

   ```bash
   kubectl create ns spinnaker
   ```

   If you want to use a different namespace, you must update the `namespace` value in your `kustomization.yml` file.

1. (Optional) Verify the Kustomize build output:

   ```bash
   kubectl kustomize <path-to-kustomization.yml>
   ```

   This prints out the contents of the manifest file that Kustomize built based on your `kustomization.yml` file.

1. Apply the manifest:

   ```yaml
   kubectl apply -k <path-to-kustomization.yml>
   ```

1. Watch the install progress and see the pods being created:

   ```bash
   kubectl -n spinnaker get spinsvc spinnaker -w
   ```