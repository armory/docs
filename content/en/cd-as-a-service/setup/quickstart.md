---
title: Armory CD-as-a-Service Quickstart - Hello Armory!
linktitle: Quickstart
description: >
  Deploy an example app to your Kubernetes cluster using Armory Continuous Deployment-as-a-Service.
weight: 1
---

## Learning objectives

1. Install the CD-as-as-Service CLI on your Mac or Linux workstation.
1. Connect your Kubernetes cluster to CD-as-a-Service.
1. Deploy Armory's sample application `potato-facts` to two environments: `staging` and `prod`.
1. Use Armory's Cloud Console to approve an environment promotion.
1. Observe a traffic split between two application versions.
1. Learn CD-as-a-Service deployment YAML syntax.

## {{% heading "prereq" %}}

* You are familiar with CD-as-a-Service's [key components]({{< ref "cd-as-a-service/concepts/architecture/key-components.md" >}}) and [system requirements]({{< ref "cd-as-a-service/concepts/architecture/system-requirements.md" >}}).
* You have access to a Kubernetes cluster. If you do not have access to a Kubernetes cluster, consider installing a local [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/) or [Minikube](https://minikube.sigs.k8s.io/docs/start/) cluster.  Your cluster's API endpoint does not need to be publicly accessible to use CD-as-a-Service. 

## Install the CD-as-as-Service CLI.

Install `armory` on Mac OS using [Homebrew](https://brew.sh/):

```shell
brew install armory-io/armory/armory-cli
```

To install `armory` on Linux, run the following command:

```shell
curl -sL go.armory.io/get-cli | bash
```

   The script will install `armory` and `avm`. You can use `avm` (**A**rmory **V**ersion **M**anager) to manage your `armory` version.

## Log in with the CLI.
    
If you've arrived at this tutorial without an Armory CD-as-a-Service account, that's OK! You can sign up for a free account when you run `armory login`.

```shell
armory login
```

Confirm the device code in your browser when prompted. Then return to this guide.    

## Connect your cluster

CD-as-a-Service uses an agent to execute deployments in your Kubernetes cluster. The installation process uses credentials from your `~/.kube/config` file to install the CD-as-a-Service agent.

Run the following command to install an agent in your Kubernetes cluster:

```shell
armory agent create
```

You name your agent during the installation process. This tutorial references that name as `<my-agent-identifier>` throughout this tutorial.

## First deployment

Armory's sample application `potato-facts` is a [simple web application](https://github.com/armory-io/potato-facts-go). 
The UI polls the API backend for facts about potatoes and renders them for users.

Your first deployment will deploy the following resources into your Kubernetes cluster:
- Two namespaces: `potato-facts-staging` and `potato-facts-prod`.
- In each namespace, the `potato-facts` application and a Kubernetes `Service`.

**Deploy**

Run the following command:

```shell
armory deploy start -f https://go.armory.io/hello-armory-first-deployment --account <my-agent-identifier>
```

Congratulations, you've just started your first deployment with CD-as-a-Service! 

You can use the link provided by the CLI to observe your deployment's progression in [Cloud Console](https://console.cloud.armory.io/deployments). 
Your resources will be deployed to `staging`. Once those resources have deployed successfully, CD-as-a-Service will deploy to `prod`.

## Second deployment

CD-as-a-Service is designed to help you build safety into your application deployment process. It does so by giving you 
declarative levers to control the scope of your deployment. 

CD-as-a-Service has four kinds of constraints that you can use to control your deployment:

- Manual Approvals
- Timed Pauses
- [Webhooks](https://docs.armory.io/cd-as-a-service/tasks/webhook-approval/)
- [Automated Canary Analysis](https://docs.armory.io/cd-as-a-service/setup/canary/)

You can use these constraints _between_ environments and _within_ environments:

- During your next deployment, you will need to issue a manual approval between `staging` and `prod`. 
- Within the `prod` deployment, CD-as-a-Service will create a 25/75% traffic split between your application versions. CD-as-a-Service will wait for your approval before continuing the deployment.

**Deploy**

Start your second deployment:

```shell
armory deploy start -f https://go.armory.io/hello-armory-second-deployment --account <my-agent-identifier>
```

Use the link provided by the CLI to navigate to your deployment in Cloud Console. Once the `staging` deployment has completed, click "Approve" to allow the `prod` deployment to begin.

Click on the `prod` deployment, then click on the `potato-facts` link under "Resources":

![Screenshot of preview link](./assets/preview.png)

This will open a preview of `potato-facts`. The app's graph plots the ratio of facts served by a given Kubernetes `ReplicaSet`.

CD-as-a-Service has deployed a new `ReplicaSet` with only one pod to achieve a 25/75% traffic split between application versions. The ratio of facts served by `ReplicaSet` backends in the graph 
should roughly match this 25/75% split.

Once you're ready to continue, return to Cloud Console to approve the `prod` deployment. CD-as-a-Service will fully shift traffic to the new
application version and tear down the previous application version.

## Deployment YAML

Now that you've used CD-as-a-Service to deploy to two environments, let's break down CD-as-a-Service's deployment YAML. You can find 
the [full specification on our docs site](https://docs.armory.io/cd-as-a-service/reference/ref-deployment-file/#sections).

### `targets`

In CD-as-a-Service, a `target` is an `(account, namespace)` pair where `account` is the name of your agent identifier.

When deploying to multiple targets, you can specify dependencies between targets
using the `constraints.dependsOn` field. In the case of this tutorial, the `prod` deployment will start only when the `staging`
deployment has completed successfully.

```yaml
targets:
  staging:
    # Account is optional when passed as a CLI flag (--account).
    # It's also required if you'd like to deploy to multiple Kubernetes clusters.
    # account: <my-agent-identifier> 
    namespace: potato-facts-staging
    strategy: rolling
  prod:
    namespace: potato-facts-prod
    strategy: trafficSplit
    constraints:
      dependsOn: ["staging"]
      beforeDeployment:
        - pause:
            untilApproved: true
```

### `manifests`

CD-as-a-Service can deploy any Kubernetes manifest. You do not need to alter your manifests or apply any special annotations to use CD-as-a-Service.

By default, the manifests defined in `path` will be deployed to all of your `targets`. If you want to restrict the targets where a manifest
should be deployed, use the `manifests.targets` field.

A `path` can be a path to an individual file or a directory. Each file can contain one or more Kubernetes manifests.

```yaml
manifests:
  - path: ./manifests/potato-facts-v1.yaml
  - path: ./manifests/potato-facts-service.yaml
  - path: ./manifests/staging-namespace.yaml
    targets: ["staging"]
  - path: ./manifests/prod-namespace.yaml
    targets: ["prod"]
```

### `strategies`

A `strategy` defines how manifests are deployed to a target.

A `canary`-type strategy is a linear sequence of steps. The `setWeight` step defines the ratio of traffic
between application versions. This tutorial will introduce other step types later on.

CD-as-a-Service integrates with service meshes like [Istio](https://docs.armory.io/cd-as-a-service/tasks/deploy/traffic-management/istio/) 
and [Linkerd](https://docs.armory.io/cd-as-a-service/tasks/deploy/traffic-management/linkerd/), 
but you do not need to use a service mesh to use a CD-as-a-Service `canary` strategy.

```yaml
strategies:
  rolling:
    canary:
      steps:
        # This strategy immediately flips all traffic to the new application version.
        - setWeight:
            weight: 100
  trafficSplit:
    canary:
      steps:
        - setWeight:
            weight: 25
        - exposeServices:
            services:
              - potato-facts
            ttl:
              duration: 2
              unit: hours
        - pause:
            untilApproved: true
        - setWeight:
            weight: 100
```

## Clean Up

You can clean up the resources created by this tutorial with `kubectl`:

```shell
kubectl delete ns potato-facts-staging potato-facts-prod
```
