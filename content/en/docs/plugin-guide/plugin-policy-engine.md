---
title: Policy Engine Plugin
toc_hide: true
exclude_search: true
description: >
  The Policy Engine plugin is the next iteration of Armory's Policy Engine for Spinnaker.
---
<!-- This plugin is the next iteration of our Policy Engine extension and is not ready for public consumption. This unlisted page is to satisfy an auditing requirement that one of our customers has. It is also hidden via robots.txt and the netlify sitemap plugin. -->


## About

Armory's Policy Engine plugin is the next iteration of the Policy Engine feature that ships with our Armory distribution. Not only does it include support for exsting features like applying policy to pipelines as they're being saved, it also introduces policy hooks into other services like Gate and Orca. 

## Requirements

This plugin requires either:

- Armory 2.23.x or later
- Spinnaker 1.23.x or later
- Open Policy Agent >= 0.12.x 

## Limitations

TODO - figure out if there are any limitations


## Setup

The plugin can be delivered using two different methods:

1. Docker image as an init container on each affected service
1. Using a remote plugin repository

In addition to the plugin, you'll also need access to an Open Policy Agent (OPA) deployment. If you haven't deployed OPA before, you can checkout our [documentation](https://docs.armory.io/docs/armory-admin/policy-engine-enable/#deploy-an-opa-server).

### Docker image as init container

{{< tabs name="enable-plugin" >}}
{{% tab name="Operator" %}}

This is a sample configuration to use with the Spinnaker operator:

```yaml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      # the spinnaker profile will be applied to all services
      spinnaker:
        armory:
          policyEngine:
            opa:
              # this should be replaced with the actual URL to your Open Policy Agent deployment
              baseUrl: https://opa.url:8181/v1/data

        spinnaker:
          extensibility:
            repositories:
              policyEngine:
                enabled: true
                # the init container will install plugins.json to this path.
                url: file:///opt/spinnaker/lib/local-plugins/policy-engine/plugins.json
      gate:
        spinnaker:
          extensibility:
            plugins:
              Armory.PolicyEngine:
                enabled: true

      orca:
        spinnaker:
          extensibility:
            plugins:
              Armory.PolicyEngine:
                enabled: true

      front50:
        spinnaker:
          extensibility:
            plugins:
              Armory.PolicyEngine:
                enabled: true

      clouddriver:
        spinnaker:
          extensibility:
            plugins:
              Armory.PolicyEngine:
                enabled: true
  kustomize:
    front50:
      deployment:
        patchesStrategicMerge:
          - |
            spec:
              template:
                spec:
                  initContainers:
                    - name: policy-engine-install
                      image: armory/policy-engine-plugin:<PLUGIN_VERSION>
                      imagePullPolicy: Always
                      args:
                        - -install-path
                        - /opt/policy-engine-plugin/target
                      volumeMounts:
                        - mountPath: /opt/policy-engine-plugin/target
                          name: policy-engine-plugin-vol
                    containers:
                      - name: front50
                        volumeMounts:
                          - mountPath: /opt/spinnaker/lib/local-plugins
                            name: policy-engine-plugin-vol
                    volumes:
                      - name: policy-engine-plugin-vol
                        emptyDir: {}
    orca:
      deployment:
        patchesStrategicMerge:
          - |
            spec:
              template:
                spec:
                  initContainers:
                    - name: policy-engine-install
                      image: armory/policy-engine-plugin:<PLUGIN_VERSION>
                      imagePullPolicy: Always
                      args:
                        - -install-path
                        - /opt/policy-engine-plugin/target
                      volumeMounts:
                        - mountPath: /opt/policy-engine-plugin/target
                          name: policy-engine-plugin-vol
                    containers:
                      - name: orca
                        volumeMounts:
                          - mountPath: /opt/spinnaker/lib/local-plugins
                            name: policy-engine-plugin-vol
                    volumes:
                      - name: policy-engine-plugin-vol
                        emptyDir: {}
    gate:
      deployment:
        patchesStrategicMerge:
          - |
            spec:
              template:
                spec:
                  initContainers:
                    - name: policy-engine-install
                      image: armory/policy-engine-plugin:<PLUGIN_VERSION>
                      imagePullPolicy: Always
                      args:
                        - -install-path
                        - /opt/policy-engine-plugin/target
                      volumeMounts:
                        - mountPath: /opt/policy-engine-plugin/target
                          name: policy-engine-plugin-vol
                    containers:
                      - name: gate
                        volumeMounts:
                          - mountPath: /opt/spinnaker/lib/local-plugins
                            name: policy-engine-plugin-vol
                    volumes:
                      - name: policy-engine-plugin-vol
                        emptyDir: {}
    clouddriver:
      deployment:
        patchesStrategicMerge:
          - |
            spec:
              template:
                spec:
                  initContainers:
                    - name: policy-engine-install
                      image: armory/policy-engine-plugin:<PLUGIN_VERSION>
                      imagePullPolicy: Always
                      args:
                        - -install-path
                        - /opt/policy-engine-plugin/target
                      volumeMounts:
                        - mountPath: /opt/policy-engine-plugin/target
                          name: policy-engine-plugin-vol
                    containers:
                      - name: clouddriver
                        volumeMounts:
                          - mountPath: /opt/spinnaker/lib/local-plugins
                            name: policy-engine-plugin-vol
                    volumes:
                      - name: policy-engine-plugin-vol
                        emptyDir: {}
```

{{% /tab %}}

{{% tab name="Halyard" %}}

Add the following to `profiles/spinnaker-local.yml`:
```yaml
armory:
  policyEngine:
    opa:
      # should be replaced with the correct URL to your OPA deployment   
      baseUrl: http://opa.server:8181/v1/data
spinnaker:
  extensibility:
    repositories:
      policyEngine:
        enabled: true
        url: file:///opt/spinnaker/lib/local-plugins/policy-engine/plugins.json
```

For each service you'd like to enable the plugin for, it's respective local profile. For example, for Gate you'd add it to the file `profiles/gate-local.yml`.
```yaml
spinnaker:
  extensibility:
    plugins:
        Armory.PolicyEngine:
            enabled: true
```

Add the following to `service-settings/gate.yml`, `service-settings/orca.yml`, `service-settings/clouddriver.yml` and `service-settings/clouddriver.yml`:
```yaml
kubernetes:
  volumes:
  - id: policy-engine-install
    type: emptyDir
    mountPath: /opt/spinnaker/lib/local-plugins
```

Add the following to  `.hal/config`:
```yaml
deploymentConfigurations:
  - name: default
    deploymentEnvironment:
      initContainers:
        front50:
         - name: policy-engine-install
            image: docker.io/armory/policy-engine-plugin:<PLUGIN VERSION>
            volumeMounts:
              - mountPath: /opt/policy-engine/target
                name: policy-engine-install
        clouddriver:
          - name: policy-engine-install
            image: docker.io/armory/policy-engine-plugin:<PLUGIN VERSION>
            volumeMounts:
              - mountPath: /opt/policy-engine/target
                name: policy-engine-install
        gate:
          - name: policy-engine-install
            image: docker.io/armory/policy-engine-plugin:<PLUGIN VERSION>
            volumeMounts:
              - mountPath: /opt/policy-engine/target
                name: policy-engine-install
        orca:
          - name: policy-engine-install
            image: docker.io/armory/policy-engine-plugin:<PLUGIN VERSION>
            volumeMounts:
              - mountPath: /opt/policy-engine/target
                name: policy-engine-install
```

{{% /tab %}}
{{< /tabs >}}

### Remote plugin repository

The configuration is mostly identical to the Docker image method but omits all volumes and init container configurations. Additionally, replace all occurrences of the following:

```yaml
url: file:///opt/spinnaker/lib/local-plugins/policy-engine/plugins.json
```

with:

```yaml
url: https://raw.githubusercontent.com/armory-plugins/policy-engine-releases/master/repositories.json
```

## Usage

This plugin enables you to apply policy to various actions and tasks within Spinnaker. In the sections below, we'll document examples and possible use cases for Policy Engine. If you'd like to see more example policies, check out our [examples repo](https://github.com/armory-io/policy-engine-examples/).

The Policy Engine provides various hooks within Spinnaker through which you can apply policy. 

### Pipeline save

Many users begin using Policy Engine to apply policy to all pipelines before they're saved. This ensures that no pipeline that violates policy can be saved. A common use case that we've seen is requiring that all pipelines have a certain stage present. Below is an example for how you might implement such a policy.

```
package spinnaker.persistence.pipelines.before

deny["pipelines must contain a pre-flight check stage"] {
    input.pipeline.stages[_].name == "preFlightCheck"
}
```

### Deployment

Another common use case among users of Policy Engine is applying policy to deployments. This prevents any deployments from happening that may violate policy. 

```
package spinnaker.deployment.tasks.deployManifest

deny["LoadBalancer Services must not have port 22 open"] {
    manifests := input.deploy.manifests
    manifest := manifests[_]

    manifest.kind == "Service"
    manifest.spec.type == "LoadBalancer"

    port := manifest.spec.ports[_]
    port.port == 22
}
```

The above example can be used to ensure that no Kubernetes Services are deployed/created that expose port 22, the port commonly used for SSH. The policy package (`spinnaker.deployment.tasks.deployManifest` used above) is different for deployment to various cloud providers and tasks. For example, if you'd like to use policy to disable the deletion of Kubernetes manifest, you should include a policy with the package name of `spinnaker.deployment.tasks.deleteManifest`.

### Pipeline execution

Not only can policy be applied to pipelines before they're saved, it can also be applied to pipeline before and during execution. 

Before a pipeline is executed, Policy Engine will use the package `spinnaker.execution.pipelines.before` to determine if the pipeline execution can even be started. This is can be useful for a variety of use cases. One example from our customers is using policy to ensure that all pipeline executions triggered by a push even in Github include a secret.

```
package spinnaker.execution.pipelines.before

deny["Every pipeline Github trigger must have a secret"] {
	some i
    trigger := input.pipeline.triggers[i]
	trigger.type == "git"
    trigger.source == "github"
    object.get(trigger, "secret", "") == ""
}

response := {
	"allowed": count(deny) == 0,
	"errors": deny,
}
```

If you'd like to do some type of of policy application to all pipelines before they're executed, this is the hook for you.

The other execution hook provided by Policy Engine is more granular. It can apply policy before and after any stage task is executed. In Spinnaker, every stage is made up of a task. Tasks are the individual steps taken to carry out a stage. You can see the various tasks for a stage in the execution details panel of the UI. 

Unlike our deployment hooks, this execution hook can apply policy to any Task in a pipeline. Additionally, task policies can use the rest of a pipeline's execution to make policy decisions. For example, if you'd like to implement a policy that only allows deployments to Kubernetes _after_ a particular stage has been completed successfully you can do so using this hook. 

```
package spinnaker.execution.task.before.deployManifest

deny["deployManifest cannot be run without requisite canDeploy stage"] {
    canDeployStages := [s | s = input.pipeline.stages[_]; s.type == "customCanDeployStage"]
    stage := canDeployStages[_]
    not stage.context.canDeploy == true
}
```

### API Authorization

*Note: API Authorization is a beta feature and should not be used in production.*

While Spinnaker provides a level of Role Based Access Control (RBAC) out of the box, it's often necessary to inspect and block certain actions within Spinnaker that aren't necessarily covered by existing featured. Our Policy Engine is able to intercept all calls to the API and apply policy to them. Each request for a policy decision includes the acting user, their roles and admin status. 

This policy hook is a bit different from the hooks described above. By default, API authorization takes a deny-all stance to policy decisions. In order for an API call to be allowed, it must match an `allow` rule in the `spinnaker.http.authz` package. For example, if you'd like to lock down every action to admins only, you can simply implement a policy that looks like this:

```
package spinnaker.http.authz

default allow = false

allow {
    input.user.isAdmin == true
}
```

All requests made to the `spinnaker.http.authz` package include the following:

1. The requesting user, their role information and admin status 
2. The HTTP request method - ex. `PUT` or `GET`
3. The URI of the API call being made (as an array or list) - ex. `/api/v1/tasks` would be `["api", "v1", "tasks"]`
4. For `PUT` or `POST` request, the entire request body.

These attributes are included in the `input` sent to policies and can be used to make policy decisions.

The below snippet represents a single POST request the the Tasks API. You can see that we include all the relevant information needed when making a policy decision.

```
{
    "user": {
        "username": "richard.hendricks@piedpiper.net"
        "roles": ["ceo", "middleout-eng"],
        "isAdmin": true
    },
    "method": "POST",
    "path": ["tasks"],
    "body": {
        "jobs": [{
            "type": "deployManifest",
            "account": "middleout-development"
        }]
    }
}
```

Let's imagine you only want to allow members of the `middleout-eng` team to deploy Kubernetes manifests to the `middleout-development` account. That policy might look like this:

```
package spinnaker.http.authz

default allow = false

# other HTTP authz rules omitted for brevity 

allow {
    input.method = "POST"
    input.path[0] = "tasks"

    job := input.body.job[0]

    # have to make a list of all actions you can take from the infra tab here
    ["scaleManifest", "deployManifest"][_] = job.type
    
    
    job.account = "middleout-development"
    input.user.roles[_] = "middleout-eng"
}
```

*API Authorization depends on having access to a user's identity and role information. Because of this dependency, you must be using Authentication and Authorization (Fiat).*

## Release Notes

* v0.0.17 - Initial plugin release
