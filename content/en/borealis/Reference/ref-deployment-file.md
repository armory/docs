---
title: Deployment File Reference
linktitle: Deployment File
description: 
exclude_search: true
---



The deployment file is what you use to define how and where your app gets deployed to.

You can see what a blank deployment file looks like in the [Tempalte file](#template-file) section. To see a filled out example, see [Example file](#example-file).

## Blank template

You can see this template file by running the following command with the Borealis CLI:

```bash
armory template kubernetes canary
```

Or you can output the template to a file and modify it to suit your needs:

```bash
armory template kubernetes canary > deployment-template.yaml
```

<details><summary>Show me the template</summary>

```yaml
version: v1
kind: kubernetes
application: <appName>
# Map of deployment targets
targets:
  # You can specify multiple targets. This example has space for 3. Provide a descriptive name for the deployment, such as the environment name, so you can tell them apart.
  <targetName1>:
    # The account name that a deployment target cluster got assigned when you installed the Remote Network Agent (RNA) on it.
    account: <accountName>
    # Optionally, override the namespaces that are in the manifests
    namespace:
    # This is the key that references a strategy you define under the strategies section of the file.
    strategy: <strategyName>
    # This first entry is the initial deployment. It does not have a constraint block, so it runs immediately when triggered. See the next deployment target for an example of constraints.
  <targetName2>:
    # The account name that a deployment target cluster got assigned when you installed the Remote Network Agent (RNA) on it.
    account: <accountName>
    # Optionally, override the namespaces that are in the manifests
    namespace:
    # This is the key that references a strategy you define under the strategies section of the file.
    strategy: <strategyName>
    # Constraints are conditions that need to be satisfied before deployment to this target begins. Omitting constraints causes a deployment to start immediately. You can specify multiple conditions.
    constraints:
      # The deployment that must finish before this deployment can begin.
      dependsOn:["<targetName1>"]
      beforeDeployment:
        - <action>: # action to take before this deployment starts, such as pause
          - <resolution> # How the <action> resolves. For example if it's a pause, this is the duration of the pause or setting untilApproved to true for manual judgments
  <targetName3>:
    # The account name that a deployment target cluster got assigned when you installed the Remote Network Agent (RNA) on it.
    account: <accountName>
    # Optionally, override the namespaces that are in the manifests
    namespace:
    # This is the key that references a strategy you define under the strategies section of the file.
    strategy: <strategyName>
    # Constraints are conditions that need to be satisfied before deployment to this target begins. Omitting constraints causes a deployment to start immediately. You can specify multiple conditions.
    constraints:
      # The deployment that must finish before this deployment can begin.
      dependsOn:["<targetName2>"]
      beforeDeployment:
        - <action>: # action to take before this deployment starts, such as pause
          - <resolution> # How the <action> resolves. For example if it's a pause, this is the duration of the pause or setting untilApproved to true for manual judgments
# The list of manifests sources
manifests:
  # A directory containing multiple manifests. Borealis reads all yaml|yml files in the directory and deploys the manifests to the target defined in `targets`.
  - path: /path/to/manifest/directory
    # Comma separated list of deployment targets to use for this manifest directory. Enclose each target in quotes.
    targets :["<targetName1>", "<targetName2>"]
  # This specifies a specific manifest file
  - path: /path/to/specific/manifest.yaml
    # Comma separated list of deployment targets to use for this manifest directory. Enclose each target in quotes.
    targets :["<targetName3>"]  
# The map of strategies that you can use to deploy your app. You can create more than one strategy that can be used for different deployment targets.
strategies:
  # The name for a strategy, which you use for the `strategy` key to select one to use.
  <strategyName1>:
    # The deployment strategy type. Borealis supports `canary`.
    canary:
      # List of canary steps
      steps:
        # The map key is the step type. First configure `setWeight` for the weight (how much of the cluster the app should deploy to for a step).
        - setWeight:
            weight: <integer> # Deploy the app to <integer> percent of the cluster as part of the first step. `setWeight` is followed by a `pause`.
        - pause: # `pause` can be set to a be a specific amount of time or to a manual judgment.
            duration: <integer> # How long to wait before proceeding to the next step.
            unit: seconds # Unit for duration. Can be seconds, minutes, or hours.
        - setWeight:
            weight: <integer> # Deploy the app to <integer> percent of the cluster as part of the second step
        - pause:
            untilApproved: true # Pause the deployment until a manual approval is given. You can approve the step through the CLI or Status UI.

```

</details>

## Example

<details><summary>Show me a completed deployment file</summary>

```yaml
version: v1
kind: kubernetes
application: stream-app
# Map of deployment target
targets:
  # Provide a descriptive name for the deployment, such as the environment name.
  dev-west:
    # The account name that a deployment target cluster got assigned when you installed the Remote Network Agent (RNA) on it.
    account: cdf-dev
    # Optionally, override the namespaces that are in the manifests
    namespace: cdf-dev-agent
    # This is the key that references a strategy you define under the strategies section of the file.
    strategy: canary-wait-til-approved
    # Note that there is no constraints block. This is the initial deployment to the dev environment.
  prod-west:
    # The account name that a deployment target cluster got assigned when you installed the Remote Network Agent (RNA) on it.
    account: cdf-prod
    # Optionally, override the namespaces that are in the manifests
    namespace: cdf-prod-agent
    # This is the key that references a strategy you define under the strategies section of the file.
    strategy: prod-canary
    # Constraints are conditions that need to be satisfied before deployment to this target begins. Omitting constraints causes a deployment to start immediately. You can specify multiple conditions.
    constraints:
      # The deployment that must finish before this deployment can begin.
      dependsOn:["dev-west"]
      beforeDeployment:
        - pause: # Wait until the child action is taken.
            untilApproved: true # Wait for a manual judgment to start deploying to this target.
# The list of manifests sources
manifests:
  # A directory containing multiple manifests. Borealis reads all yaml|yml files in the directory and deploy all manifests to the target defined in`targets`.
  - path: /deployments/manifests/configmaps
    targets: ["dev-west"]
  # A specific manifest file that gets deployed to the target defined in `targets`.
  - path: /deployments/manifests/deployment.yaml
    targets: ["prod-west"]
# The map of strategies that you can use to deploy your app.
strategies:
  # The name for a strategy, which you use for the `strategy` key to select one to use.
  canary-wait-til-approved:
    # The deployment strategy type. Borealis supports `canary`.
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
  prod-canary:
    # The deployment strategy type. Borealis supports `canary`.
    canary:
      # List of canary steps
      steps:
      # The map key is the step type. First configure `setWeight` for the weight (how much of the cluster the app should deploy to for a step).
        - setWeight:
            weight: 50 # Deploy the app to 50% of the cluster.
        - pause:
            untilApproved: true # Wait until approval is given through the Borealis CLI or Status UI.
            unit: seconds

```

</details><br>


## `application`

Provide a descriptive name for your application so that you can identify it when viewing the status of your deployment in the Status UI and other locations.

## `targets.`

This config block is where you define where and how you want to deploy an app. You can specify multiple targets. Provide unique descriptive names for them.

```yaml
targets:
  <targetName>:
    account: <accountName>
    namespace: <namespaceOverride>
    strategy: <strategyName>
    constraints: <mapOfConstraints>
```



### `targets.<targetName>`

A descriptive name for this deployment, such as the name of the environment you want to deploy to. 

For example, this snippet configures a deployment target with the name `prod`:

```yaml
targets:
  prod:
...
```

### `targets.<targetName>.account`

The account name that a target Kubernetes cluster got assigned when you installed the Remote Network Agent (RNA) on it. Specifically, it is the value for the `agent-k8s.accountName` parameter.

This name must match an existing cluster because Borealis uses the account name to determine which cluster to deploy to.

For example, this snippet configures a deployment to a cluster named `prod-cluster-west` in the deployment named `prod`:

```yaml
targets:
  prod:
    account: prod-cluster-west
...
```

### `targets.<targetName>.namespace`

(Recommended) The namespace on the target Kubernetes cluster that you want to deploy to. This field overrides any namespaces defined in your manifests.

For example, this snippet overrides the namespace in your manifest and deploys the app to a namespace called `overflow`:

```yaml
targets:
  prod:
    account: prod-cluster-west
    namespace: overflow
```

### `targets.<targetName>.strategy`

This is the name of the strategy that you want to use to deploy your app. You define the strategy and its behavior in the `strategies` block.

For example, this snippet configures a deployment to use the `canary-wait-til-approved` strategy:

```yaml
targets:
  prod:
    account: prod-cluster-west
    namespace: overflow
    strategy: canary-wait-til-approved
```

Read more about how this config is defined and used in the [strategies.<strategyName>](#strategies.<strategyName>) section.

### `targets.<targetName>.constraints`

A map of conditions that must be met before a deployment starts. The constraints can be dependencies on previous deployments, such as requiring deployments to a test environment before staging, or a pause. If you omit the constraints section, the deployment starts immediately when it gets triggered.

> Constraints are evaluated in parallel.

```yaml
targets:
  prod:
    account: prod-cluster-west
    namespace: overflow
    strategy: canary-wait-til-approved
    constraints:
      dependsOn: ["<targetName>"]
      beforeDeployment:
        - pause:
            untilApproved: true
        - pause: 
            duration: <integer>
            unit: <seconds|minutes|hours>
```

#### `targets.<targetName>.constraints.dependsOn`

A comma-separated list of deployments that must finish before this deployment can start. You can use this option to sequence deployments. For example, you cna make it so that a deployment to prod cannot happen until a staging deployment finishes successfully.

The following example shows a deployment to `prod-west` that cannot start until the `dev-west` target finishes:

```yaml
targets:
  prod:
    account: prod-west
    namespace: overflow
    strategy: canary-wait-til-approved
    constraints:
      dependsOn: ["dev-west"]
```

#### `targets.<targetName>.constraints.beforeDeployment`

Conditions that must be met before the deployment can start. These are in addition to the deployments you define in `dependsOn` that must finish.

You can specify a pause that waits for a manual approval or a certain amount of time before starting.

Pause until manual approval

Use the following configs to configure this deployment to wait until a manual approval before starting:

- `targets.<targetName>.constraints.beforeDeployment.pause.untilApproved` set to true

```yaml
targets:
  prod:
    account: prod-cluster-west
    namespace: overflow
    strategy: canary-wait-til-approved
    constraints:
      dependsOn: ["dev-west"]
      beforeDeployment:
        - pause:
            untilApproved: true
```

Pause for a certain amount of time

- `targets.<targetName>.constraints.beforeDeployment.pause.duration` set to an integer value for the amount of time to wait before starting after the `dependsOn` condition is met. 
- `targets.<targetName>.constraints.beforeDeployment.pause.unit` set to `seconds`, `minutes` or `hours` to indicate the unit of time to wait.

```yaml
targets:
  prod:
    account: prod-cluster-west
    namespace: overflow
    strategy: canary-wait-til-approved
    constraints:
      dependsOn: ["dev-west"]
      beforeDeployment:
        - pause:
            duration: 60
            unit: seconds
```

## `manifests.`

```yaml
manifests:
  # Directory containing manifests
  - path: /path/to/manifest/directory
    targets: ["<targetName1>", "<targetName2>"]
  # Specific manifest file
  - path: /path/to/specific/manifest.yaml
    targets: ["<targetName3>", "<targetName4>"]
```  

### `manifests.path`

The path to a manifest file that you want to deploy or the directory where your manifests are stored. If you specify a directory, such as `/deployments/manifests/configmaps`, Borealis reads all the YAML files in the directory and deploys the manifests to the target you specified in `targets`.

### `manifests.path.targets`

A comma-separated list of deployment targets that you want to deploy the manifests to. Make sure to enclose each target in quotes. Use the name you defined in `targets.<targetName>` to refer to a deployment target.

## `strategies.`

This config block is where you define behavior and the actual steps to a deployment strategy.

```yaml
strategies:
  <strategyName>
    canary:
      steps:
        - setWeight:
            weight: <integer>
        - pause:
            duration: <integer>
            unit: <seconds|minutes|hours>
        - setWeight:
            weight: <integer>
        - pause:
            untilApproved: true
```

### `strategies.<strategyName>`

The name you assign to the strategy. Use this name for `targets.<targetName>.strategy`. You can define multiple stragies, so make sure to use a unique descriptive name for each.

For example, this snippet names the strategy `canary-wait-til-approved`:

```yaml
strategies:
  canary-wait-til-approved:
```

You would use `canary-wait-til-approved` as the value for `targets.<targetName>.strategy` that is at the start of the file:

```yaml
...
targets:
  someName:
    ...
    strategy: canary-wait-till-approved
...
```

### `strategies.<strategyName>.<strategy>`

The kind of deployment strategy this strategy uses. Borealis supports `canary`.

```yaml
strategies:
  <strategyName>
    canary:
```

### `strategies.<strategyName>.<strategy>.steps`

Borealis progresses through all the steps you define as part of the deployment process. The process is sequential and steps can either be of the type `setWeight` or `pause`.

Generally, you want to configure a `setWeight` step and have a `pause` step follow it although this is not necessarily required.

Some scenarios where this pairing sequence might not be used would be the following:

- You can start the sequence of steps with a `pause` that has no corresponding weight. Borealis recognizes this as a weight of `0` since it is as the start of the deployment. This causes the deployment to pause at the start before any of the app is deployed.
- You want to have two `pause` steps in a row, such as a `pause` for a set amount of time followed by a `pause` for a manual judgment.

You can add as many steps as you need but do not need to add a final step that deploys the app to 100% of the cluster. Borealis automatically does that after completing the final step you define.

### `strategies.<strategyName>.<strategy>.steps.setWeight.weight`

This is an integer value and determines how much of the cluster the app gets deployed to. The value must be between 0 and 100 and the the `weight` for each `setWeight` step should increase as the deployment progresses. After hitting this threshold, Borealis pauses the deployment based on the behavior you set for  the `strategies.<strategyName>.<strategy>.steps.pause` that follows.


For example, this snippet instructs Borealis to deploy the app to 33% of the cluster:

```yaml
...
steps:
  - setWeight:
      weight: 33
```

### `strategies.<strategyName>.<strategy>.steps.pause`

There are two base behaviors you can set for `pause`, either a set amount of time or until a manual judgment is made.

```yaml
steps:
...
  - pause: 
      duration: <integer>
      unit: <seconds|minutes|hours>
...
  - pause:
      untilApproved: true 
```

### Pause for a set amount of time

If you want the deployment to pause for a certain amount of time after a weight is met, you must provide both the amount of time (duration) and the unit of time (unit).

- `strategies.<strategyName>.<strategy>.steps.pause.duration`
  - Use an integer value for the amount of time. 
- `strategies.<strategyName>.<strategy>.steps.pause.unit`
  - Use `seconds`, `minutes` or `hours` for unit of time.

For example, this snippet instructs Borealis to wait for 30 seconds:

```yaml
steps:
...
  - pause: 
      duration: 30
      unit: seconds
```

### Pause until a manual judgment

When you configure a manual judgment, the deployment waits when it hits the corresponding weight threshold. At that point, you can either approve the deployment so far and let it continue or roll the deployment back if something doesn't look right.

`strategies.<strategyName>.<strategy>.steps.pause.untilApproved: true`

For example: 

```yaml
steps:
...
  - pause:
      untilApproved: true 
```