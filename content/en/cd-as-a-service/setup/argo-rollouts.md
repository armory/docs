---
title: Get Started with Argo Rollouts Deployment
linktitle: Argo Rollouts Deployment
description: >
Use Armory CD-as-a-Service to deploy Argo Rollout Objects across multiple environments.
weight: 40

---


## {{% heading "prereq" %}}

This quick start assumes that you have performed the following steps :-
- [Connected a Kubernetes cluster](https://docs.armory.io/cd-as-a-service/setup/get-started/#connect-your-kubernetes-cluster) with Armory CD-as-a-Service.
- [Deployed an app with the CLI](https://docs.armory.io/cd-as-a-service/setup/cli/).

To complete this quick start, you need the following:

- Access to a Kubernetes cluster where you have installed the Remote Network Agent (RNA). This cluster acts as the deployment target for the sample app.
- One or more Argo Rollout Objects manifests.
- (Optional) You can connect multiple Kubernetes clusters to deploy to multiple environments
   ```yaml
  # rollout.yaml
  apiVersion: argoproj.io/v1alpha1
  kind: Rollout
  metadata:
    name: example
    spec:
      replicas: 5
      ...
   ```
## Create a CD-as-a-Service deployment object

If you don’t already have a CD-as-a-Service deployment yaml, you need to create one.

You can [generate one using the CLI](https://docs.armory.io/cd-as-a-service/setup/cli/#create-a-deployment-config-file) or alternatively use the deployment yaml below

```yaml
#armoryDeployment.yaml
version: v1
kind: kubernetes
application: <Application Name> 
targets:
  staging:
    account: <Cluster Name> # Name of the Cluster you entered when installing the RNA. 
    namespace: default
  production:
    account: <Cluster Name> 
    namespace: default
    constraints:
      dependsOn: [staging]
      beforeDeployment:
        - pause:
            untilApproved: true
		
manifests:
  - path: rollout.yaml
```

   See the [Deployment File Reference]({{< ref "ref-deployment-file#bluegreen-fields" >}}) for an explanation of these fields.
## Configure your CD-as-a-Service deployment

1. In your deploy file, go to the `manifests` section
2. Configure your Argo Rollout Manifests in the `manifests[].path` section of your deployment file:

```yaml
#armoryDeployment.yaml
version: v1
kind: kubernetes
application: my-application
targets:
  staging:
    account: staging
    namespace: default		
    
manifests:
  - path: rollout.yaml
```

3. If you are deploying to more than one environment, across different Kubernetes clusters, add a new environment in the `targets` section:

```yaml
#armoryDeployment.yaml
version: v1
kind: kubernetes
application: my-application
targets:
  staging:
    account: staging
    namespace: default
  production:
    account: production
    namespace: default
    constraints:
      dependsOn: [staging]
      beforeDeployment:
        - pause:
            untilApproved: true
		
manifests:
  - path: rollout.yaml
```

4. Start your deployment using Armory CLI

```yaml
armory deploy start -f armoryDeployment.yaml
```

If you are only deploying Argo Rollout objects, CD-as-a-Service ignores the strategy for the environment. The rollout object follows the strategy defined in the rollout object.
## Extending functionality for rollout deployments

### Run integration tests using webhooks

You can use webhooks in `afterDeployment` constraint to add specific logic for Argo Rollouts to finish deploying before starting integration tests. For example:

```yaml
 #armoryDeployment.yaml
version: v1
kind: kubernetes
application: my-application
targets:
  staging:
    account: staging
    namespace: default
		constraints:
      afterDeployment:
        - runWebhook:
	          name: Refer to Argo Rollouts for status
manifests:
  - path: rollout.yaml
webhooks:
	- name: Refer to Argo Rollouts for status
    method: POST
    uriTemplate: http://cmd-hook.default:8081/cmd
    networkMode: remoteNetworkAgent
    agentIdentifier: demo-prod-west-cluster
    retryCount: 3
    bodyTemplate:
      inline:  >-
        {
        "cmd": "kubectl",
        "arg": "wait -n=default rollout/example --for=condition=Completed --timeout=30m",
        "callbackURL": "{{armory.callbackUri}}/callback"
				}
```

### Deploy multiple Argo Rollout objects

To deploy multiple Argo Rollout objects together, you can add more paths to the `manifests` section of the deployment config file:

```yaml
manifests:
  - path: rollout-1.yaml
  - path: rollout-2.yaml
  - path: rollout-3.yaml
```