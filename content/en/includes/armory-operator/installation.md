<!-- this file does not contain H2 etc headings
Hugo does not render headings in included files
-->
The Armory Operator has two distinct modes:

- **Basic**: Installs Armory into a single namespace. This mode does not
  perform pre-flight checks before applying a manifest.
- **Cluster**: Installs Armory across namespaces with pre-flight checks to
  prevent common misconfigurations. This mode requires a `ClusterRole`.

Get the latest release from
[https://github.com/armory-io/spinnaker-operator/releases](https://github.com/armory-io/spinnaker-operator/releases):

```bash
mkdir -p spinnaker-operator && cd spinnaker-operator
bash -c 'curl -L https://github.com/armory-io/spinnaker-operator/releases/latest/download/manifests.tgz | tar -xz'

# Install or update CRDs cluster wide
kubectl apply -f deploy/crds/

# We'll install in the spinnaker-operator namespace
kubectl create ns spinnaker-operator
```

Next, install Operator in either `cluster` or `basic` mode:

```bash
# Install Operator cluster mode
kubectl -n spinnaker-operator apply -f deploy/operator/cluster
```

```bash
# OR install Operator in basic mode
# kubectl -n spinnaker-operator apply -f deploy/operator/basic
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

> If you want to use a namespace other than `spinnaker-operator` in cluster
> mode, you'll also need to edit the namespace in
> `deploy/operator/cluster/role_binding.yaml`.
