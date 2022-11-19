### Kubernetes deployment namespace 

Upgrading to 2.20x or later introduces a breaking change in the Kubernetes provider for Spinnaker. Spinnaker now correctly interprets the namespace declared in your kubeconfig file and uses that namespace. Previously, Spinnaker deployed to the default namespace called `default` because of an error in how Spinnaker interpreted the namespace in the Kubernetes context.

**Solutions**

Armory recommends using one of the following methods, which involve explicitly setting the namespace:

* In your deployment manifests, declare the namespace you want to deploy to. Set to `default` if you want to maintain the previous behavior:
  
   ```yaml
   apiVersion: batch/v1
   kind: Job
   metadata:
    generateName: <someName>
    # Set namespace to default if you want to maintain the previous behavior.
    namespace: <targetNamespace> 
* In your kubeconfig, declare the namespace you want to deploy to. Set to `default` if you want to maintain the previous behavior:
   ```yaml
   contexts:
   - context:
     cluster: <someCluster>
     # Set namespace to default if you want to maintain the previous behavior.
     namespace: <targetNamespace>
   ```

For more information, see the following links:
* OSS Spinnaker issue [#5731](https://github.com/spinnaker/spinnaker/issues/5731)
* Armory KB [article](https://kb.armory.io/s/article/Upgrade-to-Spinnaker-Causes-Errors-as-Pipelines-Deploy-to-Unavailable-Namespace)

**Introduced in**: Armory 2.20
