<!-- this file does not contain H2 etc headings
Hugo does not render headings in included files
-->
Operator in `basic` mode has limited permissions. You must deploy Spinnaker to the same namespace as the Operator. You can find Operator deployment configuration in `spinnaker-operator/deploy/operator/basic` after you download and unpack the archive.

1. Get the latest Operator release.

   **Spinnaker Operator**

   ```bash
   mkdir -p spinnaker-operator && cd spinnaker-operator
   bash -c 'curl -L https://github.com/armory/spinnaker-operator/releases/latest/download/manifests.tgz | tar -xz'
   ```

   **Armory Operator**

   ```bash
   mkdir -p spinnaker-operator && cd spinnaker-operator
   bash -c 'curl -L https://github.com/armory-io/spinnaker-operator/releases/latest/download/manifests.tgz | tar -xz'
   ```

1. Install or update CRDs across the cluster.

   ```bash
   kubectl apply -f deploy/crds/
   ```

1. Create the namespace for the Operator.

   In `basic` mode, the namespace must be `spinnaker-operator`.

   ```bash
   kubectl create ns spinnaker-operator
   ```

1. Install the Operator.

   ```bash
   kubectl -n spinnaker-operator apply -f deploy/operator/basic
   ```

After installation, you can verify that the Operator is running with the
following command:

```bash
kubectl -n spinnaker-operator get pods
```

The command returns output similar to the following if the pod for the Operator
is running:

```
NAMESPACE                             READY         STATUS       RESTARTS      AGE
spinnaker-operator-7cd659654b-4vktl   2/2           Running      0             6s
```
