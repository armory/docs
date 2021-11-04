---
title: Deployment File Template
linktitle: Deployment File
description: 
exclude_search: true
---

The deployment file is what you use to define how and where your app gets deployed to.

You can see what a blank deployment file looks like in the [Tempalte file](#template-file) section. To see a filled out example, see [Example file](#example-file).

## `application`

Provide a descriptive name for your application so that you can identify it when viewing the status of your deployment in the Status UI and other locations.

## `targets.`

This config block is where you define where and how you want to deploy an app.

### `targets.name`

The name of the environment you want to deploy to, such as `dev`.

#### `targets.name.account`

The account name that a target Kubernetes cluster got assigned when you installed the Remote Network Agent (RNA) on it. Specifically, it is the value for the `agent-k8s.accountName` parameter.

This name must match an existing cluster because Borealis uses the account name to determine which cluster to deploy to. 

#### `targets.name.namespace`

(Optional) The namespace on the target Kubernetes cluster that you want to deploy to. If you don't specify a namespace, Borealis will use the namespace defined in the manifest.

#### `targets.name.strategy`

This is the name of the strategy that you want to use to deploy your app. You define the strategy and its behavior in the `strategies` block.

## `manifests.`

### `manifests.path`

The path to a manifest file that you want to deploy or the directory where your manifests are stored. If you specify a directory, such as `/deployments/manifests/configmaps`, Borealis reads all the YAML files in the directory and deploys the manifests to the target you specified in `targets`.

## `strategies.`

This config block is where you define behavior and the actual steps to a deployment strategy.

### `strategies.<strategyName>`

The name you assign to the strategy. Use this name for `targets.name.strategy`.

### `stragies.<strategyName>.<strategy>`

What kind of deployment strategy this strategy uses. Borealis supports `canary`.

### `stragies.<strategyName>.<strategy>.steps`

Borealis progresses through all the steps you define as part of the deployment process. The process is sequential. For the most part, you want to configure `weight` portion and `pause` although you can start with a `pause` that has no corresponding weight. That is read as `0` weight, so the pause action is taken before any of the app is deployed. You can add as many steps as you want but do not need to add a final step that deploys the app to 100% of the cluster. Borealis automatically does that after completing the final step you define.

### `stragies.<strategyName>.<strategy>.steps.setWeight.weight`

This is an integer value and determines how much of the cluster the app gets be deployed to. The value must be between 0 and 100. After hitting this threshold, Borealis  pauses the deployment based on the behavior you set for `stragies.<strategyName>.<strategy>.steps.pause`.

### `stragies.<strategyName>.<strategy>.steps.pause`

There are two base behaviors you can set for pause, either a specific duration or until a manual judgment is 

#### Pause for a set amount of time

If you want the deployment to pause for a certain amount of time after a weight is met, you must provide both the amount of time (duration) and the unit of time (unit).

`stragies.<strategyName>.<strategy>.steps.pause.duration`

Integer value for the amount of time to pause.

`stragies.<strategyName>.<strategy>.steps.pause.unit`

Unit of time for the pause:

- `seconds`
- `minutes`
- `hours`

#### Pause until a manual judgment

When you configure a manual judgment, the deployment waits when it hits the corresponding weight threshold. At that point, you can either approve the deployment so far and let it continue or roll the deployment back if something doesn't look right.

`stragies.<strategyName>.<strategy>.steps.pause.untilApproved`

Set this to true.

## Blank template

You can see this tempalte file by running the following command with the Borealis CLI:

```bash
armory template kubernetes canary
```

Or you can output the template to a file and modify it to suit your needs:

```bash
armory template kubernetes canary > deployment-template.yaml
```

<details><summary>Show me the template</summary>

```yaml

```

</details>

## Example

<details><summary>Show me a completed deployment file</summary>

```yaml
version: v1
kind: kubernetes
application: ivan-nginx
# Map of deployment target
targets:
  # Name of the environment you want to deploy to
  dev-west:
    # The account name that a deployment target cluster got assigned when you installed the Remote Network Agent (RNA) on it.
    account: cdf-dev
    # Optionally, override the namespaces that are in the manifests
    namespace: cdf-dev-agent
    # This is the key that references a strategy you define under the strategies section of the file.
    strategy: canary-wait-til-approved
# The list of manifests sources
manifests:
  # A directory containing multiple manifests. Instructs Borealis to read all yaml|yml files in the directory and deploy all manifests to the target defined in    `targets`.
  - path: /deployments/manifests/configmaps
  # A specific manifest file that gets deployed to the target defined in `targets`.
  - path: /deployments/manifests/deployment.yaml
# The map of strategies that you can use to deploy your app.
strategies:
  # The name for a strategy, which you use for the `strategy` key to select one to use.
  canary-wait-til-approved:
    # The deployment strategy type. As part of the early access program, Borealis supports `canary`.
    canary:
      # List of canary steps
      steps:
      # The map key is the step type. First configure `setWeight` for the weight (how much of the cluster the app should deploy to for a step).
        - setWeight:
            weight: 33 # Deploy the app to 33% of the cluster.
        - pause: 
            duration: 60 # Wait 60 seconds before starting the next step.
            unit: seconds
        - setWeight:
            weight: 66 # Deploy the app to 66% of the cluster.
        - pause:
            untilApproved: true # Wait until approval is given through the Borealis CLI or Status UI.
```

    </details><br>