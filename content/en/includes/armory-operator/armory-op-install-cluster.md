<!-- this file does not contain H2 etc headings
Hugo does not render headings in included files
-->
You need Kubernetes `ClusterRole` authority to install the Armory Operator in [cluster mode]({{< ref "continuous-deployment/installation/armory-operator#operator-installation-modes" >}}).

You can find the Armory Operator's deployment configuration in `spinnaker-operator/deploy/operator/cluster` after you download and unpack the archive. You don't need to update any configuration values.

1. Download the Armory Operator.

   In the following example, replace `<release-version>` with a specific release version or `latest`.

   ```bash
   mkdir -p spinnaker-operator && cd spinnaker-operator
   bash -c 'curl -L https://github.com/armory-io/spinnaker-operator/releases/<release-version>/download/manifests.tgz | tar -xz'
   ```

1. Install or update CRDs across the cluster.

   ```bash
   kubectl apply -f deploy/crds/
   ```

1. Create the namespace for the Armory Operator.

   In cluster mode, if you want to use a namespace other than `spinnaker-operator`, you need to edit the namespace in `deploy/operator/cluster/role_binding.yaml`.

   ```bash
   kubectl create ns spinnaker-operator
   ```

1. Install the Armory Operator.

   ```bash
   kubectl -n spinnaker-operator apply -f deploy/operator/cluster
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
