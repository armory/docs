---
---

{{< tabs name="k8s-op-product-compat-matrix" >}}

{{% tabbody name="Armory Continuous Deployment"%}}
| Kubernetes Version         | Armory Operator Version        | Armory CD Version  | 
| :------------------------- | :----------------------------- | :----------------- |
| < 1.21                     | <= 1.6.x                       |  <= 2.28.0          | 
| >= 1.21                    | >= 1.7.x                       | All supported versions | 
{{% /tabbody %}}
{{% tabbody name="Open Source Spinnaker"%}}
| Kubernetes Version         | Spinnaker Operator Version | Spinnaker Version |
| :------------------------- | :------------------------ | :----------------- |
| < 1.21                     | <= 1.2.5                 | >= 1.27.3 |
| >= 1.21                    | >= 1.3.x    |  >= 1.27.3 |
{{% /tabbody %}}
{{< /tabs >}}
Consult the {{< linkWithTitle "op-manage-operator.md" >}} guide for how to upgrade your Operator version.
