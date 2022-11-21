### Update Kubernetes v2 provider accounts that use the `aws-iam-authenticator`

**Impact**

With 2.28 of Spinnaker, we’ve updated the aws-iam-authenticator binary to a 0.5.5 release. Due to the fact that the default value of the apiVersion for the aws-iam-authenticator has changed strictly to client.authentication.k8s.io/v1beta1, you may experience failures for the Kubernetes V2 provider accounts that still use client.authentication.k8s.io/v1alpha1. To mitigate the authentication failures, update your relevant kubeconfigs to use client.authentication.k8s.io/v1beta1.

**Introduced in**: Armory CD 2.28.0
