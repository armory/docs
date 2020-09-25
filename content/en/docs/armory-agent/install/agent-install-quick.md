---
title: Quick Start Installation
weight: 3
description: >
  Quick start for experienced K8s and Spinnaker users
---

## Quick start installation

>These quick start options are for users with a good working knowledge of Kubernetes and Spinnaker.

This guide covers how to quickly install the Armory Agent for Kubernetes and connect to an Armory platform.  You can have hundreds or thousands of Kubernetes agents connected to a single Armory platform, whether self-hosted or SaaS.  This deployment is Kubernetes native via YAML files and can be automated for onboarding of new or existing Kubernetes clusters.


## Agent Installation Options:


1. **Native Kubernetes Installation** - Here is how you install Armory Agent with yaml files to the kubernetes API.


    kubectl -n <namespace> apply -f https://armory.jfrog.io/artifactory/manifests/kubesvc/kubesvc-<KUBESVC_VERSION>.yaml

**Note** - You’ll want to download the manifests and edit the “kubesvc.yaml” to connect to your clouddriver plugin FQDN and to configure the Kubernetes Service Account for Agent access to the cluster.





2. **Kustomize templated install** - With this option you can leverage a Kustomization.yml file to “build” a kustomize deployment.


    kustomization.yml


    namespace: spinnaker
    bases:
      - https://armory.jfrog.io/artifactory/manifests/kubesvc/kubesvc-<KUBESVC_VERSION>-kustomize.tar.gz  

    configMapGenerator:
    - name: kubesvc-config
      behavior: merge
      files:
      - patches/kubesvc.yaml

    secretGenerator:
    - name: kubeconfigs-secret
      files:
      - patches/kubecfg-test.yml


3. **HELM Chart installation** - HELM templating is also an option for deploying Armory Agent into a kubernetes.  


    kubesvc.yml


    kubernetes:
      accounts:
      - kubeconfigFile: /kubeconfigfiles/kubecfg-test.yml
        permissions: {}
        name: account1
        ... # See options further down

This next section is to add the clouddriver plugin to Spinnaker.  This will create the gRPC endpoint for all Armory Agents to connect to.  


## Clouddriver Plugin Installation:


    namespace: spinnaker

    resources:
    - spinsvc.yaml

    patchesStrategicMerge:
      - https://armory.jfrog.io/artifactory/manifests/kubesvc-plugin/clouddriver-plugin-<KUBESVC_VERSION>.yaml
      - https://armory.jfrog.io/artifactory/manifests/kubesvc-plugin/kubesvc-plugin-config-<KUBESVC_VERSION>.yaml
# Armory Agent Installation Validation

Overview
Here we’ll cover some different commands and ways you can validate you have a properly running Kube Agent.  If needed for troubleshooting this will be a good reference.  

Agent Validation Commands:


    kubectl -n <namespace> get pods
    kubectl -n <namespace> describe pod -l app.kubernetes.io/name=kubesvc
    kubectl -n <namespace> logs -l app.kubernetes.io/name=kubesvc -n kubesvc | grep connect
    kubectl -n <namespace> logs -f -l app.kubernetes.io/name=kubesvc -n kubesvc | grep connect
    kubectl -n <namespace> get deployment spin-kubesvc -n kubesvc -o yaml

Clouddriver plugin validation commands


    kubectl -n <namespace> logs -l app.kubernetes.io/name=clouddriver
    kubectl -n <namespace> describe pod -l app.kubernetes.io/name=clouddriver
    kubectl -n <namespace> get svc spin-clouddriver
    NAME               TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)             AGE
    spin-clouddriver   ClusterIP   172.20.216.142   <none>        7002/TCP,9091/TCP   89d

#Note - the gRPC port 9091 has been opened for Agent Connections once plug-in is installed

Additional Tools for troubleshooting:
gRPCurl - Test Connection to clouddriver to ensure proper traffic routing and ports are open.  
