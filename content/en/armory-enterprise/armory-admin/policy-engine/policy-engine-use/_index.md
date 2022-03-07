---
title: Introduction to Using the Policy Engine
linkTitle: Use Policy Engine
description: >
  Learn how to add policies to your Open Policy Agent (OPA) server for Armory Enterprise to use when it performs validations to make sure your pipelines and users follow policy requirements. This page includes information about what goes into a policy and some basic policies for you to try. There are examples for save time validation, runtime validation, and entitlements.
aliases:
  - /docs/spinnaker/policy-engine-use/
  - /docs/spinnaker-user-guides/policy-engine-use/
---
![Proprietary](/images/proprietary.svg)

> For information about how to set up the Policy Engine, see [Enabling the Policy Engine]({{< ref "policy-engine-enable" >}}).


## Before you start

Knowing the following information will help you use the Policy Engine:

* Policies are written using OPA's [rego syntax](https://www.openpolicyagent.org/docs/latest/policy-language/). Although Armory provides some example policies, becoming more familiar with the syntax will help you write policies tailored to your requirements.
* Whether your OPA server is configured to receive policies through config maps. If the server is configured to use config maps, you need to know the namespace where the server lives and if the OPA server is configured to look for a specific label. Alternatively, policies can be added to the server through the OPA API.

If you do not have an OPA server configured for the Policy Engine, you can find information about how to deploy an OPA server [here]({{< ref "policy-engine-enable" >}}).

## Tutorial using save time validation

The following steps walk you through the two-step process described previously with a basic save time validation that applies to all pipelines in your instance when they are saved.

### Step 1. Create a policy

Generally, the only requirement for the Policy Engine in Rego syntax is the following:

```json
package some.package

deny[msg] {
  condition
}
```

Blocks of rules must be in a denial statement (or allow for some packages) and there must be a package of some type that corresponds to what action you are trying to write policies against. For more information about what goes into a policy, see [Understanding a policy](#understanding-the-policy).

The following OPA policy enforces one requirement on all pipelines:

* Any pipeline with more than one stage must have a manual judgement stage.


```json
# manual-judgment.rego. Notice the package. The opa.pipelines package is used for policies that get checked when a pipeline is saved.
package opa.pipelines

deny["Every pipeline must have a Manual Judgment stage"] {
  manual_judgment_stages = [d | d = input.pipeline.stages[_].type; d == "manualJudgment"]
  count(input.pipeline.stages[_]) > 0
  count(manual_judgment_stages) == 0
}

```

Add the the policy to a file named `manual-judgment.rego`.

### Step 2. Add the policy to your OPA server

After you create a policy, you can add it to OPA with an API request or with a ConfigMap. The following examples use  a `.rego` file named `manual-judgment.rego`.

**ConfigMap Example**

Armory recommends using ConfigMaps to add OPA policies instead of the API for OPA deployments in Kubernetes.

If you have configured OPA to look for a ConfigMap, you can create the ConfigMap for `manual-judgement.rego` with this command:

```bash
kubectl -n <opaServerNamespace> create configmap manual-judgment --from-file=manual-judgment.rego
```

After you create the policy ConfigMap, apply a label to it:

```bash
kubectl -n <opaServerNamespace> label configmap manual-judgment openpolicyagent.org/policy=rego
```

This label corresponds to the label you add in the [example manifest]({{< ref "policy-engine-enable#using-configmaps-for-opa-policies" >}}). The example ConfigMap creates an OPA server and, by extension, the Policy Engine that only checks ConfigMaps with the correct label. This improves performance.

**API Example**

Replace the endpoint with your OPA endpoint:

```bash
curl -X PUT \
-H 'content-type:text/plain' \
-v \
--data-binary @manual-judgment.rego \
http://opa.spinnaker:8181/v1/policies/policy-01
```

Note that you must use the `--data-binary` flag, not the `-d` flag.

## Runtime validation

While simple cases can be validated by the Policy Engine during a pipeline's configuration, there are a number of cases that can only be addressed at runtime. Pipelines can be dynamic, resolving things like SpEL and Artifacts just in time for them. This means there are external influences on a pipeline that are not known at save time. To solve for this issue, the Policy Engine can validate pipelines when they run but before deployments make it to your cloud provider.

The following example shows a use case where you can use Policy Engine to prevent Kubernetes LoadBalancer Services from being deployed with open SSH ports.

### Understanding the policy

Deployment validation works by mapping an OPA policy package to a Spinnaker deployment task. For example, deploying a Kubernetes Service is done using the Deploy (Manifest) stage, so we'll write a policy that applies to that task.

```json
# Notice the package. The package maps to the task you want to create a policy for.
package spinnaker.deployment.tasks.deployManifest

deny[msg] {
    msg := "LoadBalancer Services must not have port 22 open."
    manifests := input.deploy.manifests
    manifest := manifests[_]

    manifest.kind == "Service"
    manifest.spec.type == "LoadBalancer"

    port := manifest.spec.ports[_]
    port.port == 22
}
```

Using the example policy, Policy Engine tests for the following criteria when a pipeline runs:

* Check any manifest where the `kind` is `Service` and `type` is `LoadBalancer`. Manifests that don't meet these criteria are not be evaluated by subsequent rules in the policy.

* Check all of the ports to ensure that port `22` isn't open. If the Policy Engine finds port `22`, the `deny` rule evaluates to true. This results in the deployment failing and the message from the `msg` parameter is shown to the user.

You'll notice a few things about this policy:

* The package name is explicit, which means that this policy only applies to the `deployManifest` stage. You can write policies for other tasks by replacing `deployManifest` with your task name. Generally, the task name maps to a stage name.

* The policy tests a set of manifests that the `deployManifest` stage will deploy to Kubernetes. This is part of the tasks configuration, which is passed into the policy in it's entirety under `input.deploy`.

* The policy isn't limited to any particular Kubernetes account. If you'd like to only apply policies to your Production account, use `input.deploy.account` to narrow down policies to specific accounts. This is useful when you want more or less restrictive policies across your infrastructure.

For list of packages that you can write policies against, see [Policy Engine Packages]({{< ref "packages.md" >}}), and for example policies that use those packages, see [Example Policies]({{< ref "example-policies.md" >}})

Once you've written your policy, push it to your OPA server using a ConfigMap or the API. The Policy Engine begins enforcing the policy immediately.


### Validating a deployment

Now that the policy has been uploaded to the OPA server, the policy gets enforced on any deployment to Kubernetes without additional input from the end user. Error messages returned by the policy are surfaced in the UI immediately following a halted deployment.


![](/images/runtime-policy-validation.png)


## Entitlements using API authorization

> Requires Policy Engine Plugin

While Spinnaker provides a level of Role Based Access Control (RBAC) out of the box, it is often necessary to inspect and block certain actions within Spinnaker that aren't necessarily covered by existing features. The Policy Engine is able to intercept all calls to the API and enforce policies to them. Each request for a policy decision includes the acting user, their roles, and admin status.

This policy hook is a different from the other example hooks described. By default, API authorization takes a deny-all stance to policy decisions. In order for an API call to be allowed, it must match an `allow` rule in the `spinnaker.http.authz` package. For example, to lock down every action to admins only, you can implement a policy that looks like this:

```opa
package spinnaker.http.authz

default allow = false

allow {
    input.user.isAdmin == true
}
```

### Create a policy for the API

All requests made to the `spinnaker.http.authz` package include the following:

1. The requesting user, their role information and admin status.
2. The HTTP request method, such as `PUT` or `GET`.
3. The URI of the API call being made (as an array or list). For example, `/api/v1/tasks` would be `["api", "v1", "tasks"]`.
4. For `PUT` or `POST` requests, the entire request body.

These attributes are included in the `input` sent to policies and can be used to make policy decisions.

The following snippet represents a single POST request to the Tasks API. You can see the relevant information needed when making a policy decision:

```rego
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

You only want to allow members of the `middleout-eng` team to deploy Kubernetes manifests to the `middleout-development` account. That policy might look like this:

```rego
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

### Return a custom message

> Providing a custom message for the `spinnaker.http.authz` package requires Armory Enterprise 2.26.0 or later.

The Policy Engine allows you to return a custom message when an action violates a policy and is blocked. For most packages that you want to enforce policies on, this is done by specifying the message as part of the `deny` block. You can see this in the examples for other policy types on this page.

Returning a custom message works slightly differently for the `spinnaker.http.authz` package because it is based on the `allow` rules rather than `deny` rules.

If a user attempts to perform an action that they are not allowed to, a window appears and displays the custom message you specify. If you are running an Armory Enterprise version earlier than 2.26.0, you cannot specify a custom message. Instead, a generic server error message appears.

The following example policy prevents the user `milton` from taking specific actions in the UI. Specifically, the user cannot use the  **Edit** or **Delete** buttons on the **Clusters** tab.

**Example policy:**
{{< prism lang="rego" line="2-8" >}}
package spinnaker.http.authz
    default allow=false
    allow {
      not isInfraDeploy
      not isDeleteManifest
    }
    message = "This action has been blocked by your company's policy. This message is configurable in your policy."{
    	not allow
    }
    default isInfraDeploy=false
    isInfraDeploy{
          # Policy that prevents the user milton from manually deploying infrastructure
          input.method="POST"
          input.path[_]="tasks"
          input.body.job[_].type="deployManifest"
          input.user.username="milton"
    }
    isDeleteManifest{
      # Policy that prevents the user milton from manually deleting infrastructure
      input.method="POST"
      input.path[_]="tasks"
      input.body.job[_].type="deleteManifest"
      input.user.username="milton"
    }
{{< /prism >}}

Note the highlighted lines. This is where defining and returning a custom message for the `spinnaker.http.authz` package differs from other packages.

When the policy prevents an action, the following window appears in the UI and displays the message:

{{< figure src="/images/pe-plugin/pe-plugin-http-authz-msg.jpg" alt="This is the window that appears and displays the message specified in the policy. Users can cancel the action or attempt to resolve the issue." >}}

## Deployment

Another common use case is applying a policy to deployments. This prevents any deployments from happening that may violate a policy.

The policy package (`spinnaker.deployment.tasks.<taskType>` ) is different for deployment to various cloud providers and tasks. For example, if you'd like to use policy to disable the deletion of Kubernetes manifest, you should include a policy with the package name of `spinnaker.deployment.tasks.deleteManifest`.

The following example shows the `rego` syntax for an OPA policy that ensures no Kubernetes Services are deployed or created that expose port 22, the port commonly used for SSH:

```rego
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

## Policies for pipeline execution

Policies can be applied to pipeline before and during execution.

Before a pipeline is executed, Policy Engine uses the package `spinnaker.execution.pipelines.before` to determine if the pipeline execution can even be started. This is can be useful for a variety of use cases.

The following example shows the `rego` syntax for a policy that requires all pipeline executions include a secret when triggered by a push in GitHub:

```rego
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

```rego
package spinnaker.execution.task.before.deployManifest

deny["deployManifest cannot be run without requisite canDeploy stage"] {
    canDeployStages := [s | s = input.pipeline.stages[_]; s.type == "customCanDeployStage"]
    stage := canDeployStages[_]
    not stage.context.canDeploy == true
}
```

## Verify that policies are evaluated

The Policy Engine requires Armory and the OPA server to be connected. Once you have one or more policies added, you can verify that the policies are being applied and enforced by either performing an action expressly disallowed by a policy or checking the OPA logs. You can check the OPA logs with the following steps:

1. Log in to the Armory UI.
2. Check the OPA pod logs:

   ```bash
   kubectl -n <opaServerNamespace> logs <pod-name>
   ```
   In the logs, you should see `POST` requests if Armory and the OPA server are connected and policies are being evaluated.


## Additional configuration

### Ignore directories, files, or file types

Pipelines as Code supports using an ignore file for GitHub repos to ignore certain files in a repo that it watches. To use this feature, create a file named `.dinghyignore` in the root directory of the repo.

You can add specific filenames, file paths, or glob-style paths. For example, the following `.dinghyignore` file ignores the file named `README.md`, all the files in the `milton` directory, and all `.pdf` files:

```
README.md
milton/
*.pdf
```

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

*Note the `path` key in the preceding configuration. This is required.*

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

## Disabling an OPA policy

You can disable a `deny` policy by adding a false statement to the policy body.  For example, you can add `0 == 1` as a false statement to the manual judgement policy we used previously:

```json
package opa.pipelines

deny["Every pipeline must have a Manual Judgment stage"] {
  manual_judgment_stages = [d | d = input.pipeline.stages[_].type; d == "manualJudgment"]
  count(input.pipeline.stages[_]) > 0
  count(manual_judgment_stages) == 0
  0 == 1
}
```


## Troubleshooting

**Spring configured release version not found error**

Problem:

You encounter the following error:
```
2021-02-17 16:53:26.842  INFO 1 --- [    scheduler-6] .k.p.u.r.s.SpringPluginInfoReleaseSource : Spring configured release version not found for plugin 'Armory.PolicyEngine'
2021-02-17 16:53:26.843  INFO 1 --- [    scheduler-6] .k.p.u.r.s.LatestPluginInfoReleaseSource : Latest release version '0.0.16' for plugin 'Armory.PolicyEngine`
```

Solution:

This may be due to an incorrect container name for a service in the init container patch. Verify that the `patchesStrategicMerge` for each service is accurate when configuring [Docker image as init container](#docker-image-as-init-container).

**UI not loading after you enable Policy Engine**

Problem:

The Armory (or Spinnaker) UI fails to load after you enable Policy Engine. This may be due to an SSL exception.

Solution:

Open your browser's console and see if there are SSL exceptions. If there are, check what the `baseUrl` value for the OPA server is in `profiles/spinnaker-local.yml` (Halyard-based deployments) or your operator config. Specifically, using HTTPS for an HTTP server can cause SSL exceptions.
