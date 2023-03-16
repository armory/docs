<!-- this file does not contain H2 etc headings
Hugo does not render headings in included files
-->
Operator in `basic` mode has permissions scoped to a single namespace, so the Operator can't see anything in other namespaces. You must deploy Armory Continuous Deployment to the same namespace as the Armory Operator.

You can find the Armory Operator's deployment configuration in `spinnaker-operator/deploy/operator/basic` after you download and unpack the archive. You don't need to update any configuration values.

1. Download the Armory Operator.

   In the following example, replace `<release-version>` with a specific release version or `latest`.

   ```bash
   mkdir -p spinnaker-operator && cd spinnaker-operator
   bash -c 'curl -L https://github.com/armory-io/spinnaker-operator/releases/latest/download/manifests.tgz | tar -xz'
   ```

1. Install or update CRDs across the cluster.

   ```bash
   kubectl apply -f deploy/crds/
   ```

1. Create the namespace for the Armory Operator.

   In `basic` mode, the namespace must be `spinnaker-operator`.

   ```bash
   kubectl create ns spinnaker-operator
   ```

1. Install the Armory Operator.

   ```bash
   kubectl -n spinnaker-operator apply -f deploy/operator/basic
   ```


1. Verify that the Armory Operator is running.

   ```bash
   kubectl get pods -n spinnaker-operator | grep operator
   ```

   The command returns output similar to the following if the pod for the Operator is running:

   ```
   NAMESPACE                             READY         STATUS       RESTARTS      AGE
   spinnaker-operator-7cd659654b-4vktl   2/2           Running      0             6s
   ```
