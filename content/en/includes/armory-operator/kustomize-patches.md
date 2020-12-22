## Install Armory

We provide many common configuration options for Armory and Spinnaker through
the [`spinnaker-kustomize-patches`](https://github.com/armory/spinnaker-kustomize-patches)
repository. This gives you a reliable starting point when adding and removing
Armory or Spinnaker features to your cluster.

To start, create your own copy of the `spinnaker-kustomize-patches` repository
by clicking the `Use this template` button:

![button](/images/kustomize-patches-repo-clone.png)

Once created, clone this repository to your local machine.

If you installed Operator in `basic` mode, you must set the `namespace` field
in your `kustomization.yml` file to the `spinnaker-operator` namespace.  The
permissions in `basic` mode are scoped to a single namespace so it doesn't see
anything in other namespaces.

Once configured, run the following command to install:

```bash
# If you have `kustomize` installed:
kustomize build | kubectl apply -f -


# If you only have `kubectl` installed:
kubectl apply -k .
```

Watch the install progress and check out the pods being created:

```bash
kubectl -n spinnaker get spinsvc spinnaker -w
```

### How it works

Armory's configuration is found in a `spinnakerservices.spinnaker.armory.io`
Custom Resource Definition (CRD) that you can store in version control. After
you install the Armory Operator, you can use `kubectl` to manage the lifecycle
of your deployment.

```yaml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      version: 2.21.0
```

See [the full format]({{< ref "operator-reference" >}}) for more configuration
options.
