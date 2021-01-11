---
title: Policy Engine Plugin
toc_hide: true
exclude_search: true
description: >
  The Policy Engine plugin is the next iteration of Armory's Policy Engine for Spinnaker™.
---
<!-- This plugin is the next iteration of our Policy Engine extension and is not ready for public consumption. This unlisted page is to satisfy an auditing requirement that one of our customers has. It is also hidden via robots.txt and the netlify sitemap plugin. -->

## Overview

Armory's Policy Engine plugin is the next iteration of the Policy Engine feature that ships with our Armory distribution. Not only does it include support for existing features like applying policy to pipelines as they're being saved, it also introduces policy hooks into other services like Gate and Orca. 

## Requirements

This plugin requires:

- Armory 2.23.x or later (OSS Spinnaker 1.23.x or later)
- Open Policy Agent 0.12.x or later

<!--## Limitations

TODO - figure out if there are any limitations
-->

## Setup

The plugin can be delivered using two different methods:

1. Docker image as an init container on each affected service
2. Using a remote plugin repository

In addition to the plugin, you need access to an Open Policy Agent (OPA) deployment. If you have not deployed OPA before, see [Deploy an OPA server](https://docs.armory.io/docs/armory-admin/policy-engine-enable/#deploy-an-opa-server).

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

1. Add the following to `profiles/spinnaker-local.yml`:

   ```yaml
   armory:
     policyEngine:
       opa:
         # Should be replaced with the  URL to your OPA deployment   
         baseUrl: http://opa.server:8181/v1/data
   spinnaker:
     extensibility:
       repositories:
         policyEngine:
           enabled: true
           url: file:///opt/spinnaker/lib/local-plugins/policy-engine/plugins.json
   ```

2. For each service you want to enable the plugin for, add the following snippet to its local profile. For example, add it to the file `profiles/gate-local.yml` for Gate.

   ```yaml
   spinnaker:
     extensibility:
       plugins:
           Armory.PolicyEngine:
               enabled: true
   ```

3. Add the following to `service-settings/gate.yml`, `service-settings/orca.yml`, `service-settings/clouddriver.yml` and `service-settings/front50.yml`:

   ```yaml
   kubernetes:
     volumes:
     - id: policy-engine-install
       type: emptyDir
       mountPath: /opt/spinnaker/lib/local-plugins
   ```

4. Add the following to  `.hal/config`:

   ```yaml
   deploymentConfigurations:
     - name: default
       deploymentEnvironment:
         initContainers:
           front50:
             - name: policy-engine-install
               image: docker.io/armory/policy-engine-plugin:<PLUGIN VERSION>
               args:
                 - -install-path
                 - /opt/policy-engine-plugin/target
               volumeMounts:
                 - mountPath: /opt/policy-engine/target
                   name: policy-engine-install
           clouddriver:
             - name: policy-engine-install
               image: docker.io/armory/policy-engine-plugin:<PLUGIN VERSION>
               args:
                 - -install-path
                 - /opt/policy-engine-plugin/target
               volumeMounts:
                 - mountPath: /opt/policy-engine/target
                   name: policy-engine-install
           gate:
             - name: policy-engine-install
               image: docker.io/armory/policy-engine-plugin:<PLUGIN VERSION>
               args:
                 - -install-path
                 - /opt/policy-engine-plugin/target
               volumeMounts:
                 - mountPath: /opt/policy-engine/target
                   name: policy-engine-install
           orca:
             - name: policy-engine-install
               image: docker.io/armory/policy-engine-plugin:<PLUGIN VERSION>
               args:
                 - -install-path
                 - /opt/policy-engine-plugin/target
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

The Policy Engine Plugin enables you to enforce policies on various actions and tasks in the Armory platform. It does this by providing hooks within the platform. The sections below include examples and possible use cases for the Policy Engine. To see more example policies, see the [examples repo](https://github.com/armory-io/policy-engine-examples/).

You can add policies to the Policy Engine through the OPA API or with a ConfigMap. For information about how to add policies, see [Using the Policy Engine]({{< ref "policy-engine-use#step-2-add-policies-to-opa" >}}). 

### API authorization

> Note: API Authorization is an early access feature and should not be used in production.

While Spinnaker provides a level of Role Based Access Control (RBAC) out of the box, it is often necessary to inspect and block certain actions within Spinnaker that aren't necessarily covered by existing features. The Policy Engine is able to intercept all calls to the API and enforce policies to them. Each request for a policy decision includes the acting user, their roles, and admin status.

This policy hook is a different from the other example hooks described. By default, API authorization takes a deny-all stance to policy decisions. In order for an API call to be allowed, it must match an `allow` rule in the `spinnaker.http.authz` package. For example, to lock down every action to admins only, you can implement a policy that looks like this:

```opa
package spinnaker.http.authz

default allow = false

allow {
    input.user.isAdmin == true
}
```

#### Creating a policy for the API

All requests made to the `spinnaker.http.authz` package include the following:

1. The requesting user, their role information and admin status. 
2. The HTTP request method, such as `PUT` or `GET`.
3. The URI of the API call being made (as an array or list). For example, `/api/v1/tasks` would be `["api", "v1", "tasks"]`.
4. For `PUT` or `POST` requests, the entire request body.

These attributes are included in the `input` sent to policies and can be used to make policy decisions.

The following snippet represents a single POST request to the Tasks API. You can see the relevant information needed when making a policy decision:

```opa
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

Imagine you only want to allow members of the `middleout-eng` team to deploy Kubernetes manifests to the `middleout-development` account. That policy might look like this:

```opa
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

*API Authorization depends on having access to a user's identity and role information. Because of this dependency, you must be using Authentication and Authorization, which requires configuring the Fiat service.*

### Deployment

Another common use case is applying policy to deployments. This prevents any deployments from happening that may violate a policy.

The policy package (`spinnaker.deployment.tasks.<taskType>` ) is different for deployment to various cloud providers and tasks. For example, if you'd like to use policy to disable the deletion of Kubernetes manifest, you should include a policy with the package name of `spinnaker.deployment.tasks.deleteManifest`.

The following example shows the `rego` syntax for an OPA policy that ensures no Kubernetes Services are deployed or created that expose port 22, the port commonly used for SSH:

```opa
package spinnaker.deployment.tasks.deployManifest

deny["LoadBalancer Services must not have port 22 open."] {
    manifests := input.deploy.manifests
    manifest := manifests[_]

    manifest.kind == "Service"
    manifest.spec.type == "LoadBalancer"

    port := manifest.spec.ports[_]
    port.port == 22
}
```

Note the `deployManifest` part of the package, which indicates what tasks this policy should get enforced on.

### Pipeline execution

Not only can policies be enforced on pipelines before they are saved, they can also be applied to pipeline before and during execution. 

Before a pipeline is executed, Policy Engine uses the package `spinnaker.execution.pipelines.before` to determine if the pipeline execution can even be started. This is can be useful for a variety of use cases. 

The following example shows the `rego` syntax for a policy that requires all pipeline executions include a secret when triggered by a push in Github:

```opa
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

Build off this example if you want to create policies that get enforced on all pipelines before they execute.

The other execution hook provided by Policy Engine is more granular. It can enforce policy before and after any stage task is executed. In Spinnaker, every stage is made up of a task. Tasks are the individual steps taken to carry out a stage. You can see the various tasks for a stage in the execution details panel of the UI. 

Unlike the deployment hooks, this execution hook can apply policy to any task in a pipeline. Additionally, task policies can use the rest of a pipeline's execution to make policy decisions. For example, if you want to implement a policy that only allows deployments to Kubernetes _after_ a particular stage has been completed successfully, you can do so using this hook. 

The following example shows the `rego` syntax for a policy that requires a `canDeploy` type stage to run before a `deployManifest` type stage:

```opa
package spinnaker.execution.task.before.deployManifest

deny["deployManifest cannot be run without requisite canDeploy stage"] {
    canDeployStages := [s | s = input.pipeline.stages[_]; s.type == "customCanDeployStage"]
    stage := canDeployStages[_]
    not stage.context.canDeploy == true
}
```

### Pipeline save

This is the simplest use case for Policy Engine and where many users begin. You can enforce policies on all pipelines when they get saved. This ensures that any pipeline that violates a policy cannot be saved. A common use case for this kind of policy is requiring all pipelines to have a certain stage. 

The following example shows the `rego` syntax for a policy that requires all pipelines to have a `preFlightCheck` type stage:

```opa
package spinnaker.persistence.pipelines.before

deny["Pipelines must contain a pre-flight check stage."] {
    input.pipeline.stages[_].name == "preFlightCheck"
}
```

## Additional configuration

### Allow API routes by default

When using the API authorization extension, certain API paths are allowed by default. This is because these paths are unauthenticated by default
and are required for Spinnaker to operate normally. These paths include:

```yaml
/auth/user
/auth/loggedOut
/webhooks/**
/notifications/callbacks/**
/health
/plugins/deck/**
```

Any API request to these paths is not subject to authorization requests by the plugin. To add additional paths to this list, add the following to the plugin configuration to your Gate profile in the Operator config or `profiles/gate-local.yml` for Halyard:

```yaml
armory:
  policyEngine:
    allow:
      - path: "/additional/api/one"
      - path: "/additional/api/two"
      # wildcards are allowed
      - path: "/api/**"
```

*Note the `path` key in the above configuration. This is required.*

### Enable identity-based policies for webhook endpoints

The Policy Engine Plugin can apply identity-based policies to the `/webhooks/**` endpoint. Because the `/webhooks/**` endpoint is unauthenticated by default, additional configuration is needed to enable this capability. You must enable forced authentication on the `/webhooks/**` endpoints to ensure that all webhooks go through the authentication flow before triggering their associated pipelines.

Add the following to the plugin configuration to your Gate profile in the Operator config or `profiles/gate-local.yml` for Halyard:

```yaml
armory:
  policyEngine:
    forceAuthentication:
      - path: /webhooks/**
        method: POST
```

The example configuration forces all webhook calls to provide authentication . If you depend on unauthenticated webhook calls,
be more specific about the paths you want to force authentication on. 

## Release Notes

* v0.0.17 - Initial plugin release
