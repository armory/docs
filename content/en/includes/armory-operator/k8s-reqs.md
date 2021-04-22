* You are familiar with [Kubernetes Operators](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/), which use custom resources to manage applications and their components.
* You understand the concept of [managing Kubernetes resources using manifests](https://kubernetes.io/docs/concepts/cluster-administration/manage-deployment/).
* Your Kubernetes environment meets the following:
  * Minimum version: 1.13; `kubectl` 1.13.
  * Maximum version: 1.19; `kubectl` 1.19.4.

  If you do not have a cluster already, consult guides for [Amazon EKS](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-console.html).
* You have administrator rights to install the Custom Resource Definition (CRD) for Operator.
* If you are managing your own Kubernetes cluster (**not** EKS or OpenShift), be sure:
   * You have enabled admission controllers in Kubernetes (`-enable-admission-plugins`).
   * You have `ValidatingAdmissionWebhook` enabled in `kube-apiserver`. Alternatively, you can pass the `--disable-admission-controller` parameter to the to the `deployment.yaml` file that deploys the Operator.
* You have created a persistent storage source for Armory Enterprise to use to store app settings and configured pipelines.
   * You can find a list of supported external storage providers for Armory Enterprise in the in the Compatibility Matrix's [External storage section]({{< ref "armory-enterprise-matrix#external-storage">}}).
   * You can find a list of supported external storage providers for Spinnaker in the open source Spinnaker [About External Storage](https://spinnaker.io/setup/install/storage/#about-external-storage) documentation.