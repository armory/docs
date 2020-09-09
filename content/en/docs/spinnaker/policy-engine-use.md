---
title: Using the Policy Engine
weight: 143
summary: "Add policies to your OPA instance for Spinnaker to use when it performs validation to make sure your pipelines meet your policy requirements.."
---

## Overview

The Armory Policy Engine is designed to allow enterprises more complete control of their software delivery process by providing them with the hooks necessary to perform more extensive verification of their pipelines and processes in Spinnaker. This policy engine is backed by [Open Policy Agent](https://www.openpolicyagent.org/)(OPA) and uses input style documents to perform validation of pipelines during save time and runtime:

* **Save time validation** - Validate pipelines as they're created/modified. This validation operates on all pipelines using a fail closed model. This means that if you have the Policy Engine enabled but no policies configured, the Policy Engine prevents you from creating or updating any pipeline.
* **Runtime validation** - Validate deployments as a pipeline is executing. This validation only operates on tasks that you have explicitly created policies for. Tasks with no policies are not validated.

For information about how to set up the Policy Engine, see [Enabling the Policy Engine]({{< ref "policy-engine-enable" >}}).

## Before you start

Using the Policy Engine requires understanding OPA's [rego syntax](https://www.openpolicyagent.org/docs/latest/policy-language/). 

## Using the Policy Engine to validate pipeline configurations

The Policy Engine uses [OPA's Data API](https://www.openpolicyagent.org/docs/latest/rest-api/#data-api) to check pipeline configurations against OPA policies that you set.

In general, the only requirement for the Policy Engine in Rego syntax is the following:

```
package opa.pipelines

deny["some text"] {
  condition
}
```

Blocks of rules must be in a denial statement and the package must be `opa.pipelines`.

At a high level, adding policies for the Policy Engine to use is a two-step process:
1. Create the policies and save them to a `.rego` file.
2. Add the policies to the OPA server with a ConfigMap or API request.

### Sample OPA Policy

#### Step 1. Create Policies


The following OPA policy enforces one requirement on all pipelines:

* Any pipeline with more than one stage must have a manual judgement stage.


```rego
# manual-judgment.rego. Notice the package. The opa.pipelines package is used for policies that get checked when a pipeline is saved.
package opa.pipelines

deny["Every pipeline must have a Manual Judgment stage"] {
  manual_judgment_stages = [d | d = input.pipeline.stages[_].type; d == "manualJudgment"]
  count(input.pipeline.stages[_]) > 0
  count(manual_judgment_stages) == 0
}

```

Add the the policy to a file named `manual-judgment.rego`

#### Step 2. Add Policies to OPA

After you create a policy, you can add it to OPA with an API request or with a ConfigMap. The following examples use  a `.rego` file named `manual-judgment.rego`.

**ConfigMap Example**

Armory recommends using ConfigMaps to add OPA policies instead of the API for OPA deployments in Kubernetes.

If you have configured OPA to look for a ConfigMap, you can create the ConfigMap for `manual-judgement.rego` with this command:

```
kubectl -n <opaServerNamespace> create configmap manual-judgment --from-file=manual-judgment.rego
```

After you create the policy ConfigMap, apply a label to it:

```
kubectl -n <opaServerNamespace> label configmap manual-judgment openpolicyagent.org/policy=rego -n opa
```

This label corresponds to the label you add in the [example manifest]({{< ref "policy-engine-enable#using-configmaps-for-opa-policies" >}}. The example ConfigMap creates an OPA server and, by extension, the Policy Engine that only checks ConfigMaps with the correct label. This improves performance.

**API Example**

Replace the endpoint with your OPA endpoint:

```
curl -X PUT \
-H 'content-type:text/plain' \
-v \
--data-binary @manual-judgment.rego \
http://opa.spinnaker:8181/v1/policies/policy-01
```

Note that you must use the `--data-binary` flag, not the `-d` flag.

## Using the Policy Engine to validate deployments

While simple cases can be validated by the Policy Engine during a pipeline's configuration, there are a number of cases that can only be addressed at runtime. By nature, Spinnaker's pipelines can be dynamic, resolving things like SpEL and Artifacts just in time for them. This means there are external influences on a pipeline that are not known at save time. To solve for this issue, the Policy Engine can validate pipelines when they run to but before deployments make it to your cloud provider.

As an example, let's use Policy Engine to prevent Kubernetes LoadBalancer Services being deployed with open SSH ports.

### Writing a policy

Deployment validation works by mapping an OPA policy package to a Spinnaker deployment task. For example, deploying a Kubernetes Service is done using the Deploy (Manifest) stage, so we'll write a policy that applies to that task.

```
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

* The policy tests a set of manifests which the `deployManifest` stage will deploy to Kubernetes. This is part of the tasks configuration, which is passed into the policy in it's entirety under `input.deploy`.

* The policy isn't limited to any particular Kubernetes account. If you'd like to only apply policies to, say, your Production account, use `input.deploy.account` to narrow down policies to specific accounts. This is useful when you want more or less restrictive policies across your infrastructure.

Once you've written your policy, push it to your OPA server using a ConfigMap or the API. The Policy Engine begins enforcing the policy immediately.


### Validating a deployment

Now that the policy has been uploaded to the OPA server, the policy gets enforced on any deployment to Kubernetes without additional input from the end user. Error messages returned by the policy will be surfaced in the UI immediately following a halted deployment.


![](/images/runtime-policy-validation.png)


### Disabling an OPA policy

You can disable a `deny` policy by adding a false statement to the policy body.  For example, you can add `0 == 1` as a false statement to the manual judgement policy we used previously:

```
package opa.pipelines

deny["Every pipeline must have a Manual Judgment stage"] {
  manual_judgment_stages = [d | d = input.pipeline.stages[_].type; d == "manualJudgment"]
  count(input.pipeline.stages[_]) > 0
  count(manual_judgment_stages) == 0
  0 == 1
}
```


