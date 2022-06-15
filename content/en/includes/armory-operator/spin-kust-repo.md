Armory maintains the `spinnakaker-kustomize-patches` [repo](https://github.com/armory/spinnaker-kustomize-patches), which contains common configuration options for Armory Enterprise or Spinnaker as well as helper scripts. The patches in this repo give you a reliable starting point when adding and removing features.

>Configuration in this repository is meant for Armory Continuous Delivery. To
>make it compatible with Spinnaker instead, apply the
>`utilities/switch-to-oss.yml` patch.

To start, create your own copy of the `spinnaker-kustomize-patches` repository
by clicking the `Use this template` button:

![button](/images/kustomize-patches-repo-clone.png)

>If you intend to update your copy from upstream, use **Fork** instead. See [Creating a repository from a template](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-repository-from-a-template) for the difference between **Use this template** and **Fork**.

Once created, clone this repository to your local machine.
