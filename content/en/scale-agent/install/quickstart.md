---
title: "Quick Start: Spinnaker and the Armory Scale Agent"
linkTitle: Quick Start
description: >
  This guide shows you how to use the Spinnaker Operator to install Spinnaker and the Scale Agent in the same Kubernetes cluster for testing the Scale Agent's features.
weight: 1
draft: true
---

<!--
spinnaker-kustomize-patches repo

"spinnaker mode" -> install the service in the same cluster as spinnaker

should enable dynamic account feature in plugin because seriously, who'd want to try out the Scale Agent without delving into the dynamic account migration features?

quick spin?

https://armory.zoom.us/rec/share/aaavlB1E3jRFDi3C7resW4GOwNOZp6F_luKTHLrjbIGvtJZXXDCeiQGbVUMI0RMe.mKcmpqwLSIax4J4B

-->

## Objectives

* install the spinnaker operator and use it to install a complete spinnaker 1.28 instance with the latest scale agent plugin and service  into a clean Kubernetes cluster
* single cluster (spinnaker mode)
* clouddriver uses sql database
* clouddriver account management enabled in plugin file
* dynamic accounts automatically enabled in plugin

we are assuming the user has in-depth Spinnaker knowledge and has kubernetes accounts to migrate???

* clone repo
* configure k8s accounts (optional)
* install

Need to provide a cleanup script - can't just delete spinnaker namespace - need to delete ClusterRole and ClusterRoleBinding

ClusterRoleBinding: spinnaker-operator-binding-my-suffix-changeme `kubectl delete clusterrolebinding spinnaker-operator-binding-my-suffix-changeme`

ClusterRole: spinnaker-operator-role-my-suffix-changeme  `kubectl delete clusterrole spinnaker-operator-role-my-suffix-changeme`

ServiceAccount `kubectl delete serviceaccount spinnaker-operator-my-suffix-changeme` (should be deleted when namespace is deleted)

`kubectl delete namespace spinnaker`

Tested with AWS EKS running Kubernetes v1.23


serviceaccount/spinnaker-operator-my-suffix-changeme created
clusterrole.rbac.authorization.k8s.io/spinnaker-operator-role-my-suffix-changeme created
clusterrolebinding.rbac.authorization.k8s.io/spinnaker-operator-binding-my-suffix-changeme created

## {{% heading "prereq" %}}

* You have admin access to a Kubernetes cluster running 1.23, 1.22 (not 1.24)
* `kubernetes-cli` is version ???

<!-- too much text -  put in a collapsible pane if we decide to include it
### Why use Kustomize patches for Spinnaker configuration

{{< include "armory-operator/why-use-kustomize.md" >}}

### How Kustomize works

{{< include "armory-operator/how-kustomize-works.md" >}}

### Kustomize resources

* Kustomize [Glossary](https://kubectl.docs.kubernetes.io/references/kustomize/glossary/)
* Kustomize [introduction](https://kubectl.docs.kubernetes.io/guides/introduction/kustomize/)
* [Kustomization file overview](https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/)

### Kubernetes requirements

{{< include "armory-operator/k8s-reqs.md" >}}

## Spinnaker Kustomize patches repo

{{< include "armory-operator/spin-kust-repo.md" >}}

-->

## Clone the repo

Clone the [spinnaker-kustomize-patches](https://github.com/aimeeu/spinnaker-kustomize-patches):

Navigate to the `spinnaker-kustomize-patches/targets/kubernetes/scale-agent/` directory.

Note: the files in the repo don't enable the Clouddriver Account Management API or have all the dynamic accounts settings in the plugin config

explain what each file we use is for 

user needs to update the password values in 



kubectl -n spinnaker get spinsvc && echo && kubectl -n spinnaker get pods

## {{% heading "nextSteps" %}}

- migrate 