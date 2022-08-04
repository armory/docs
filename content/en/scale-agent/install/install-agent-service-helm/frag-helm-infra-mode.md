---
title: frag-helm-infra-mode
---

Before you start, make sure:

1. Each account has a **kubeconfig** file that grants access to the deployment target cluster. If you use Amazon EKS, you can run the following command:

   {{< prism lang="bash" >}}
   aws eks update-kubeconfig --name <target-cluster>
   {{< /prism >}}

1. Each account has a **kubeconfig** file and a secret created from that file. For example:

   {{< prism lang="bash" >}}
   kubectl create secret generic kubeconfig --from-file=<path>/.kube/config -n <namespace>
   {{< /prism >}}

   See the `kubectl create secret generic` [docs](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-secret-generic-em-) for command details.


Run one of the following commands:

1. If you want to connect to Armory Cloud services:

   You must set your Armory Cloud **clientId** and **clientSecret** credentials.

   You must set your **kubeconfig** file and secret. `<kubeconfig>` is the name of the file you used when you created the secret. If you used `--from-file=<path>/.kube/config`, the value of `<kubeconfig>` is `config`.

   {{< prism lang="bash" line="4" >}}
   helm install armory-agent armory-charts/agent-k8s-full \
   --create-namespace \
   --namespace=<agent-namespace> \
   --set hub.auth.armory.clientId=<your-clientID> \
   ,hub.auth.armory.secret=<your-clientSecret> \
   ,kubeconfigs.<account-name>.file=<kubeconfig> \
   ,kubeconfigs.<account-name>.secret=<secret>
   {{< /prism >}}


1. If you don't want to connect to Armory Cloud services:

   You must include your gPRC endpoint, such as `localhost:9090`.

   You must set your **kubeconfig** file and secret. `<kubeconfig>` is the name of the file you used when you created the secret. If you used `--from-file=<path>/.kube/config`, the value of `<kubeconfig>` is `config`.

   {{< prism lang="bash" line="4" >}}
   helm install armory-agent armory-charts/agent-k8s-full \
   --create-namespace \
   --namespace=<agent-namespace> \
   --set config.clouddriver.grpc=<endpoint> \
   ,kubeconfigs.<account-name>.file=<kubeconfig> \
   ,kubeconfigs.<account-name>.secret=<secret>
   {{< /prism >}}

Command options:

- `--create-namespace`: (Optional) Creates the namespace if not present. See the [Helm install docs](https://helm.sh/docs/helm/helm_install/#options).
- `--namespace=<agent-namespace>`: (Required) The namespace where you install the Armory Agent, which is also the deployment target for your app.
