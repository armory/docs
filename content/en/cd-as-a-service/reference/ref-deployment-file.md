---
title: Deployment Config File Reference for CD-as-a-Service
linkTitle: Deployment Config File
description: >
  The deployment (deploy) file is where you configure your app for deployment by Armory CD-as-a-Service. This config file includes deployment artifact, target, strategy, and traffic management definitions.
aliases:
  - /cd-as-a-service/reference/deployfile/
  - /cd-as-a-service/reference/deployfile/ref-deployment-file/
---

## Deployment config file reference overview

The deployment config file is what you use to define how and where Armory CD-as-a-Service deploys your app.

## Templates

You can generate a template file by running the following command with the CLI:

Basic template:

```bash
armory template kubernetes [command]
```
where `command` is the type of template.
</br>

Automated canary analysis template:

```bash
armory template kubernetes canary -f automated
```

Blue/green deployment template:

```bash
armory template kubernetes bluegreen
```

To use a template, output it to a file and modify it to suit your needs:

```bash
armory template kubernetes [template-type] > deployment-template.yaml
```

<details><summary>Show me an example deployment file</summary>
This file is in the <a href="https://github.com/armory/docs-cdaas-sample" target="_blank">armory/docs-cdaas-sample repo</a>.

{{< github repo="armory/docs-cdaas-sample" file="/deploy.yml" lang="yaml" options="" >}}
</details><br>

## Sections

### `application`

Provide a descriptive name for your application so that you can identify it when viewing the status of your deployment in the Deployments UI and other locations.

### `deploymentConfig.`

This config block is optional. If included, this configuration applies to all targets.

A deployment times out if the pods for your application fail to be in ready state in 30 minutes. If you want to change the default, include this section.


{{< prism lang="yaml"  line-numbers="true" >}}
deploymentConfig:
  timeout:
    unit: <seconds|minutes|hours>
    duration: <integer>
{{< /prism >}}

- `timeout`: (Required is section is included) The section specifies the amount of time to wait for pods to be ready before cancelling the deployment.
   - `unit`: (Required) Set to `seconds`, `minutes` or `hours` to indicate what `duration` refers to.
   - `duration`: (Required) Integer amount of time to wait

>The minimum timeout you can specify is 60 seconds (1 minute).

### `targets.`

This config block is where you define where and how you want to deploy an app. You can specify multiple targets. Provide unique descriptive names for each environment to which you are deploying.

{{< prism lang="yaml"  line-numbers="true" >}}
targets:
  <targetName>:
    account: <accountName>
    namespace: <namespaceOverride>
    strategy: <strategyName>
    constraints: <mapOfConstraints>
{{< /prism >}}



#### `targets.<targetName>`

A descriptive name for this deployment, such as the name of the environment you want to deploy to.

For example, this snippet configures a deployment target with the name `prod`:

{{< prism lang="yaml"  line-numbers="true" >}}
targets:
  prod:
...
{{< /prism >}}

#### `targets.<targetName>.account`

The account name that a target Kubernetes cluster got assigned when you installed the Remote Network Agent (RNA) on it. Specifically, it is the value for the `agentIdentifier` parameter. Note that older versions of the RNA used the `agent-k8s.accountName` parameter.

This name must match an existing cluster because Armory CD-as-a-Service uses the identifier to determine which cluster to deploy to.

For example, this snippet configures a deployment to an environment named `prod` that is hosted on a cluster named `prod-cluster-west`:

{{< prism lang="yaml"  line-numbers="true" >}}
targets:
  prod:
    account: prod-cluster-west
...
{{< /prism >}}

#### `targets.<targetName>.namespace`

(Recommended) The namespace on the target Kubernetes cluster that you want to deploy to. This field overrides any namespaces defined in your manifests.

For example, this snippet overrides the namespace in your manifest and deploys the app to a namespace called `overflow`:

{{< prism lang="yaml"  line-numbers="true" >}}
targets:
  prod:
    account: prod-cluster-west
    namespace: overflow
{{< /prism >}}

#### `targets.<targetName>.strategy`

This is the name of the strategy that you want to use to deploy your app. You define the strategy and its behavior in the `strategies` block.

For example, this snippet configures a deployment to use the `canary-wait-til-approved` strategy:

{{< prism lang="yaml"  line-numbers="true" >}}
targets:
  prod:
    account: prod-cluster-west
    namespace: overflow
    strategy: canary-wait-til-approved
{{< /prism >}}

Read more about how this config is defined and used in the [strategies.<strategyName>](#strategies.<strategyName>) section.

#### `targets.<targetName>.constraints`

`constraints` is a map of conditions that must be met before a deployment starts. The constraints can be dependencies on previous deployments, such as requiring deployments to a test environment before staging, or a pause. If you omit the constraints section, the deployment starts immediately when it gets triggered.

> Constraints are evaluated in parallel.

{{< prism lang="yaml"  line-numbers="true" >}}
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
{{< /prism >}}

##### `targets.<targetName>.constraints.dependsOn`

A comma-separated list of deployments that must finish before this deployment can start. You can use this option to sequence deployments. Deployments with the same `dependsOn` criteria execute in parallel. For example, you can make it so that a deployment to prod cannot happen until a staging deployment finishes successfully.

The following example shows a deployment to `prod-west` that cannot start until the `dev-west` target finishes:

{{< prism lang="yaml"  line-numbers="true" >}}
targets:
  prod:
    account: prod-west
    namespace: overflow
    strategy: canary-wait-til-approved
    constraints:
      dependsOn: ["dev-west"]
{{< /prism >}}

##### `targets.<targetName>.constraints.beforeDeployment`

Conditions that must be met before the deployment can start. These are in addition to the deployments you define in `dependsOn` that must finish.

You can specify a pause that waits for a manual approval or a certain amount of time before starting.

**Pause until manual approval**

Use the following configs to configure this deployment to wait until a manual approval before starting:

- `targets.<targetName>.constraints.beforeDeployment.pause.untilApproved` set to true
- `targets.<targetName>.constraints.beforeDeployment.pause.requiresRole` (Optional) list of RBAC roles that can issue a manual approval

{{< prism lang="yaml"  line-numbers="true" >}}
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
            requiresRole: []
{{< /prism >}}

**Pause for a certain amount of time**

- `targets.<targetName>.constraints.beforeDeployment.pause.duration` set to an integer value for the amount of time to wait before starting after the `dependsOn` condition is met.
- `targets.<targetName>.constraints.beforeDeployment.pause.unit` set to `seconds`, `minutes` or `hours` to indicate the unit of time to wait.

{{< prism lang="yaml"  line-numbers="true" >}}
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
{{< /prism >}}

### `manifests.`

{{< prism lang="yaml"  line-numbers="true" >}}
manifests:
  # Directory containing manifests
  - path: /path/to/manifest/directory
    targets: ["<targetName1>", "<targetName2>"]
  # Specific manifest file
  - path: /path/to/specific/manifest.yaml
    targets: ["<targetName3>", "<targetName4>"]
{{< /prism >}}  

#### `manifests.path`

The path to a manifest file that you want to deploy or the directory where your manifests are stored. If you specify a directory, such as `/deployments/manifests/configmaps`, Armory CD-as-a-Service reads all the YAML files in the directory and deploys the manifests to the target you specified in `targets`.

#### `manifests.path.targets`

(Optional). If you omit this option, the manifests are deployed to all targets listed in the deployment file. A comma-separated list of deployment targets that you want to deploy the manifests to. Make sure to enclose each target in quotes. Use the name you defined in `targets.<targetName>` to refer to a deployment target.

### `strategies.`

This config block is where you define behavior and the actual steps to a deployment strategy.

{{< prism lang="yaml"  line-numbers="true" >}}
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
        - exposeServices:
            services:
              - <service-1>
              - <service-2>
              - <service-qn>
            ttl:
              duration: <integer>
              unit: <seconds|minutes|hours>
        - pause:
            untilApproved: true
        - analysis:
            context:
              keyName: <value>
              keyName: <value>
            interval: <integer>
            units: <seconds|minutes|hours>
            numberOfJudgmentRuns: <integer>
            rollBackMode: <manual|automatic>
            rollForwardMode: <manual|automatic>
            queries:
              - <queryName>
              - <queryName>
        - setWeight:
            weight: <integer>
  <strategyName>
    blueGreen:
      activeService: <active-service>
      previewService: <preview-service>
      redirectTrafficAfter:
        - pause:
            duration: <integer>
            unit: <seconds|minutes|hours>
      shutDownOldVersionAfter:
        - pause:
            untilApproved: true
{{< /prism >}}

#### `strategies.<strategyName>`

The name you assign to the strategy. Use this name for `targets.<targetName>.strategy`. You can define multiple strategies, so make sure to use a unique descriptive name for each.

For example, this snippet names the strategy `canary-wait-til-approved`:

{{< prism lang="yaml"  line-numbers="true" >}}
strategies:
  canary-wait-til-approved:
{{< /prism >}}

You would use `canary-wait-til-approved` as the value for `targets.<targetName>.strategy` that is at the start of the file:

{{< prism lang="yaml"  line-numbers="true" >}}
...
targets:
  someName:
    ...
    strategy: canary-wait-till-approved
...
{{< /prism >}}

#### `strategies.<strategyName>.<strategy>`

The kind of deployment strategy this strategy uses. Armory CD-as-a-Service supports `canary` and `blueGreen`.

{{< prism lang="yaml"  line-numbers="true" >}}
strategies:
  <strategyName>
    canary:
{{< /prism >}}

#### Canary fields

##### `strategies.<strategyName>.canary.steps`

Armory CD-as-a-Service progresses through all the steps you define as part of the deployment process. The process is sequential and steps can be of the types, `analysis`, `setWeight` or `pause`.

Generally, you want to configure a `setWeight` step and have a `analysis` or `pause` step follow it although this is not necessarily required. This gives you the opportunity to see how the deployment is doing either manually or automatically before the deployment progresses.

Some scenarios where this pairing sequence might not be used would be the following:

- You can start the sequence of steps with a `pause` that has no corresponding weight. Armory CD-as-a-Service recognizes this as a weight of `0` since it is as the start of the deployment. This causes the deployment to pause at the start before any of the app is deployed.
- You want to have two `pause` steps in a row, such as a `pause` for a set amount of time followed by a `pause` for a manual judgment.

You can add as many steps as you need but do not need to add a final step that deploys the app to 100% of the cluster. Armory CD-as-a-Service automatically does that after completing the final step you define.

##### `strategies.<strategyName>.canary.steps.setWeight.weight`

This is an integer value and determines how much of the cluster the app gets deployed to. The value must be between 0 and 100 and the the `weight` for each `setWeight` step should increase as the deployment progresses. After hitting this threshold, Armory CD-as-a-Service pauses the deployment based on the behavior you set for  the `strategies.<strategyName>.<strategy>.steps.pause` that follows.


For example, this snippet instructs Armory CD-as-a-Service to deploy the app to 33% of the cluster:

{{< prism lang="yaml"  line-numbers="true" >}}
...
steps:
  - setWeight:
      weight: 33
{{< /prism >}}

##### `strategies.<strategyName>.canary.steps.pause`

There are two base behaviors you can set for `pause`, either a set amount of time or until a manual judgment is made.

{{< prism lang="yaml"  line-numbers="true" >}}
steps:
...
  - pause:
      duration: <integer>
      unit: <seconds|minutes|hours>
...
  - pause:
      untilApproved: true
{{< /prism >}}

**Pause for a set amount of time**

If you want the deployment to pause for a certain amount of time after a weight is met, you must provide both the amount of time (duration) and the unit of time (unit).

- `strategies.<strategyName>.canary.steps.pause.duration`
  - Use an integer value for the amount of time.
- `strategies.<strategyName>.canary.steps.pause.unit`
  - Use `seconds`, `minutes` or `hours` for unit of time.

For example, this snippet instructs Armory CD-as-a-Service to wait for 30 seconds:

{{< prism lang="yaml"  line-numbers="true" >}}
steps:
...
  - pause:
      duration: 30
      unit: seconds
{{< /prism >}}

**Pause until a manual judgment**

When you configure a manual judgment, the deployment waits when it hits the corresponding weight threshold. At that point, you can either approve the deployment so far and let it continue or roll the deployment back if something doesn't look right.

- `strategies.<strategyName>.canary.steps.pause.untilApproved: true`
- `strategies.<strategyName>.canary.steps.pause.requiresRole` (Optional) list of RBAC roles that can issue a manual approval

For example:

{{< prism lang="yaml"  line-numbers="true" >}}
steps:
...
  - pause:
      untilApproved: true
      requiresRoles: []
{{< /prism >}}

##### `strategies.<strategyName>.canary.steps.analysis`

The `analysis` step is used to run a set of queries against your deployment. Based on the results of the queries, the deployment can automatically or manually roll forward or roll back.

{{< prism lang="yaml"  line-numbers="true" >}}
steps:
...
        - analysis:
            metricProviderName: <metricProviderName>
            context:
              keyName: <value>
              keyName: <value>
            interval: <integer>
            units: <seconds|minutes|hours>
            numberOfJudgmentRuns: <integer>
            rollBackMode: <manual|automatic>
            rollForwardMode: <manual|automatic>
            queries:
              - <queryName>
              - <queryName>
{{< /prism >}}

###### `strategies.<strategyName>.canary.steps.analysis.metricProviderName`

Optional. The name of a configured metric provider. If you do not provide a metric provider name, Armory CD-as-a-Service uses the default metric provider defined in the `analysis.defaultMetricProviderName`. Use the **Configuration UI** to add a metric provider.

###### `strategies.<strategyName>.canary.steps.analysis.context`

Custom key/value pairs that are passed as substitutions for variables to the queries.

Armory supports the following variables out of the box:

- `armory.startTimeIso8601`
- `armory.startTimeEpochSeconds`
- `armory.startTimeEpochMillis`
- `armory.endTimeIso8601`
- `armory.endTimeEpochSeconds`
- `armory.endTimeEpochMillis`
- `armory.intervalMillis`
- `armory.intervalSeconds`
- `armory.promQlStepInterval`
- `armory.deploymentId`
- `armory.applicationName`
- `armory.environmentName`
- `armory.replicaSetName`

You can supply your own variables by adding them to this section. When you use them in your query, include the `context` prefix. For example, if you create a variable named `owner`, you would use `context.owner` in your query.

For information about writing queries, see the [Query Reference Guide]({{< ref "ref-queries.md" >}}).

###### `strategies.<strategyName>.canary.steps.analysis.interval`

{{< prism lang="yaml"  line-numbers="true" >}}
steps:
...
        - analysis:
            interval: <integer>
            units: <seconds|minutes|hours>
{{< /prism >}}

How long each sample of the query gets summarized over.

For example, the following snippet sets the interval to 30 seconds:

{{< prism lang="yaml"  line-numbers="true" >}}
steps:
...
        - analysis:
            interval: 30
            units: seconds

{{< /prism >}}

###### `strategies.<strategyName>.canary.steps.analysis.units`

The unit of time for the interval. Use `seconds`, `minutes` or `hours`. See `strategies.<strategyName>.<strategy>.steps.analysis.interval` for more information.

###### `strategies.<strategyName>.canary.steps.analysis.numberOfJudgmentRuns`

{{< prism lang="yaml"  line-numbers="true" >}}
steps:
...
        - analysis:
            ...
            numberOfJudgmentRuns: <integer>
            ...
{{< /prism >}}

The number of times that each query runs as part of the analysis. Armory CD-as-a-Service takes the average of all the results of the judgment runs to determine whether the deployment falls within the acceptable range.

###### `strategies.<strategyName>.canary.steps.analysis.rollBackMode`

{{< prism lang="yaml"  line-numbers="true" >}}
steps:
...
        - analysis:
            ...
            rollBackMode: <manual|automatic>
            ...
{{< /prism >}}

Optional. Can either be `manual` or `automatic`. Defaults to `automatic` if omitted.

How a rollback is approved if the analysis step determines that the deployment should be rolled back. The thresholds for a rollback are set in `lowerLimit` and `upperLimit` in the `analysis` block of the deployment file. This block is separate from the `analysis` step that this parameter is part of.

###### `strategies.<strategyName>.canary.steps.analysis.rollForwardMode`

{{< prism lang="yaml"  line-numbers="true" >}}
steps:
...
        - analysis:
            ...
            rollForwardMode: <manual|automatic>
            ...
{{< /prism >}}

Optional. Can either be `manual` or `automatic`. Defaults to `automatic` if omitted.

How a rollback is approved if the analysis step determines that the deployment should proceed (or roll forward). The thresholds for a roll forward are any values that fall within the range you create when you set the `lowerLimit` and `upperLimit`values in the `analysis` block of the deployment file. This block is separate from the `analysis` step that this parameter is part of.

###### `strategies.<strategyName>.canary.steps.analysis.queries`

{{< prism lang="yaml"  line-numbers="true" >}}
steps:
...
        - analysis:
            ...
            queries:
              - <queryName>
              - <queryName>
{{< /prism >}}

A list of queries that you want to use as part of this `analysis` step. Provide the name of the query, which is set in the `analysis.queries.name` parameter. Note that thee `analysis` block is separate from the `analysis` step.

All the queries must pass for the step as a whole to be considered a success.

##### `strategies.<strategyName>.canary.steps.exposeServices`

This step enables exposing deployed `Service` resources via a temporary, internet-facing, randomly generated link for testing purposes. 
The services must reside within the `Namespace` addressed by a given deployment. The exposed services must define a single HTTP(S) port. 
The link automatically expires after a predefined amount of time. The exposed links are not secure.  

{{< prism lang="yaml"  line-numbers="true" >}}
...
steps:
...
- exposeServices:
  services:
    - <service-name-1>
    - <service-name-2>
    - <service-name-n>
  ttl:
    duration: <integer>
    unit: <seconds|minutes|hours>
{{< /prism >}}

The `ttl` section is optional and if not provided, defaults to 5 minutes. Minimum value is 1 minute, maximum is 24 hours.
The `service` name must not contain namespace information and in order to succeed, it must exist at the moment the step is executed.  

In this example, the snippet instructs Armory CD-as-a-Service to create a public URL to the deployed services SVC1 and SVC2. Both automatically expire after 2 hours.

{{< prism lang="yaml"  line-numbers="true" >}}
...
steps:
...
- exposeServices:
  services:
  - SVC1
  - SVC2
  ttl:
    duration: 2
    unit: hours
{{< /prism >}}

#### Blue/green fields

##### `strategies.<strategyName>.blueGreen.activeService`

The name of a [Kubernetes Service object](https://kubernetes.io/docs/concepts/services-networking/service/) that you created to route traffic to your application.

{{< prism lang="yaml"  line-numbers="true" >}}
strategies:
  <strategy>:
    blueGreen:
      activeService: <active-service>
{{< /prism >}}

##### `strategies.<strategyName>.blueGreen.previewService`

(Optional) The name of a [Kubernetes Service object](https://kubernetes.io/docs/concepts/services-networking/service/) you created to route traffic to the new version of your application so you can preview your updates.

{{< prism lang="yaml"  line-numbers="true" >}}
strategies:
  <strategy>:
    blueGreen:
      previewService: <preview-service>
{{< /prism >}}

##### `strategies.<strategyName>.blueGreen.redirectTrafficAfter`

The `redirectTrafficAfter` steps are conditions for exposing the new version to the `activeService`. The steps are executed in parallel.After each step completes, Armory CD-as-a-Service exposes the new version to the `activeService`.

###### `strategies.<strategyName>.blueGreen.redirectTrafficAfter.pause`

There are two base behaviors you can set for `pause`, either a set amount of time or until a manual judgment is made.

{{< prism lang="yaml"  line-numbers="true" >}}
redirectTrafficAfter:
  - pause:
      duration: <integer>
      unit: <seconds|minutes|hours>
{{< /prism >}}

{{< prism lang="yaml"  line-numbers="true" >}}
redirectTrafficAfter:
  - pause:
      untilApproved: true
{{< /prism >}}

**Pause for a set amount of time**

If you want the deployment to pause for a certain amount of time, you must provide both the amount of time (duration) and the unit of time (unit).

- `strategies.<strategyName>.blueGreen.redirectTrafficAfter.pause.duration`
  - Use an integer value for the amount of time.
- `strategies.<strategyName>.blueGreen.redirectTrafficAfter.pause.unit`
  - Use `seconds`, `minutes` or `hours` for unit of time.

For example, this snippet instructs Armory CD-as-a-Service to wait for 30 minutes:

{{< prism lang="yaml"  line-numbers="true" >}}
redirectTrafficAfter:
  - pause:
      duration: 30
      unit: minutes
{{< /prism >}}

**Pause until a manual judgment**

When you configure a manual judgment, the deployment waits for manual approval through the UI. You can either approve the deployment or roll the deployment back if something doesn't look right. Do not provide a `duration` or `unit` value when defining a judgment-based pause.

- `strategies.<strategyName>.blueGreen.redirectTrafficAfter.pause.untilApproved: true`
- `strategies.<strategyName>.blueGreen.redirectTrafficAfter.pause.requiresRole` (Optional) list of RBAC roles that can issue a manual approval

For example:

{{< prism lang="yaml"  line-numbers="true" >}}
redirectTrafficAfter:
  - pause:
      untilApproved: true
      requiresRoles: []
{{< /prism >}}

###### `strategies.<strategyName>.blueGreen.redirectTrafficAfter.analysis`

The `analysis` step is used to run a set of queries against your deployment. Based on the results of the queries, the deployment can (automatically or manually) roll forward or roll back.

{{< prism lang="yaml"  line-numbers="true" >}}
redirectTrafficAfter:
  - analysis:
      metricProviderName: <metricProviderName>
      context:
        keyName: <value>
        keyName: <value>
      interval: <integer>
      unit: <seconds|minutes|hours>
      numberOfJudgmentRuns: <integer>
      rollBackMode: <manual|automatic>
      rollForwardMode: <manual|automatic>
      queries:
        - <queryName>
        - <queryName>
{{< /prism >}}

##### `strategies.<strategyName>.blueGreen.shutdownOldVersionAfter`

This step is a condition for deleting the old version of your software. Armory CD-as-a-Service executes the `shutDownOldVersion` steps in parallel. After each step completes, Armory CD-as-a-Service deletes the old version.

{{< prism lang="yaml"  line-numbers="true" >}}
shutdownOldVersionAfter:
  - pause:
      untilApproved: true
{{< /prism >}}

###### `strategies.<strategyName>.blueGreen.shutdownOldVersionAfter.analysis`

The `analysis` step is used to run a set of queries against your deployment. Based on the results of the queries, the deployment can (automatically or manually) roll forward or roll back.

{{< prism lang="yaml"  line-numbers="true" >}}
shutdownOldVersionAfter:
  - analysis:
      metricProviderName: <metricProviderName>
      context:
        keyName: <value>
        keyName: <value>
      interval: <integer>
      units: <seconds|minutes|hours>
      numberOfJudgmentRuns: <integer>
      rollBackMode: <manual|automatic>
      rollForwardMode: <manual|automatic>
      queries:
        - <queryName>
        - <queryName>
{{< /prism >}}

##### `strategies.<strategyName>.blueGreen.redirectTrafficAfter.exposeServices`

This step allows exposing deployed `Service` resources via temporary, internet facing, randomly generated link for testing purposes.
The services must reside within the `Namespace` addressed by given deployment. The exposes services must define a single HTTP(S) port.
The link will automatically expire after predefined lifetime. There are no any security measures applied on the exposed links.

For example, this snippet instructs Armory CD-as-a-Service to create a public URL to the deployed service SVC1 and SVC2 and automatically expire both of them after 2 hours:

{{< prism lang="yaml"  line-numbers="true" >}}
...
redirectTrafficAfter:
...
- exposeServices:
  services:
  - SVC1
  - SVC2
  ttl:
    duration: 2
    unit: hours
{{< /prism >}}

Section `ttl` is optional and if not provided it will default to 5 minutes. Minimum value is 1 minute, maximum is 24 hours.
The `Service` name must not contain namespace information and in order to succeed, it must exist at the moment step is executed.

### `analysis.`

This block defines the queries used to analyze a deployment for any `analysis` steps. In addition, you set upper and lower limits for the queries that define what is considered a failed deployment step or a successful deployment step.

You can provide multiple queries in this block.  The following snippet includes a sample Prometheus query. Note that the example requires the following:

- `kube-state-metrics.metricAnnotationsAllowList[0]=pods=[*]` must be set
- Your applications pods need to have the annotation `"prometheus.io/scrape": "true"`

{{< prism lang="yaml"  line-numbers="true" >}}
analysis: # Define queries and thresholds used for automated analysis
  defaultMetricProviderName: <providerName> # The name that you assigned a metrics provider in the Configuration UI.
  queries:
    - name: <queryName>
      upperLimit: <integer> # If the metric exceeds this value, the automated analysis fails.
      lowerLimit: <integer> # If the metric goes below this value, the automated analysis fails.
      queryTemplate: >-
        <some-metrics-query>
     - name: avgCPUUsage
        upperLimit: 100
        lowerLimit: 1
        queryTemplate: >-
          avg (avg_over_time(container_cpu_system_seconds_total{job="kubelet"}[{{armory.promQlStepInterval}}]) * on (pod)  group_left (annotation_app)
                  sum(kube_pod_annotations{job="kube-state-metrics",annotation_deploy_armory_io_replica_set_name="{{armory.replicaSetName}}"})
                  by (annotation_app, pod)) by (annotation_app)
                #,annotation_deploy_armory_io_replica_set_name="${canaryReplicaSetName}"})
                #${ARMORY_REPLICA_SET_NAME}
                #,annotation_deploy_armory_io_replica_set_name="${ARMORY_REPLICA_SET_NAME}"
                #${replicaSetName}
                #${applicationName}
                # note the time should actually be set to ${promQlStepInterval}
{{< /prism >}}

You can insert variables into your queries. Variables are inserted using the format `{{key}}`. The example query includes the variable `armory.replicaSetName`. Variables that Armory supports can be referenced by `{{armory.VariableName}}`. Custom defined variables can be referenced by `{{context.VariableName}}`.

For more information, see the [`analysis.context` section](#strategiesstrategynamestrategystepsanalysiscontext).

#### `analysis.defaultMetricProviderName`

The name that you assigned to a metrics provider in the **Configuration UI**. If the analysis step does not specify a metrics provider, the default metrics provider is used.

#### `analysis.queries`

This block is how you define the queries that you want to run.

##### `analysis.queries.name`

Used in `analysis` steps to specify the query that you want to use for the step. Specifically it's used for the list in `steps.analysis.queries`.

Provide a unique and descriptive name for the query, such as `containerCPUSeconds` or `avgMemoryUsage`.

##### `analysis.queries.upperLimit`

The upper limit for the query. If the analysis returns a value that is above this range, the deployment is considered a failure, and a rollback is triggered. The rollback can happen either manually or automatically depending on how you configured `strategies.<strategyName>.<strategy>.steps.analysis.rollBackMode`.

If the query returns a value that falls within the range between the `upperLimit` and `lowerLimit` after all the runs of the query complete, the query is considered a success.

##### `analysis.queries.lowerLimit`

The lower limit for the query. If the analysis returns a value that is below this range, the deployment is considered a failure, and a rollback is triggered. The rollback can happen either manually or automatically depending on how you configured `strategies.<strategyName>.<strategy>.steps.analysis.rollBackMode`.

If the query returns a value that falls within the range between the `upperLimit` and `lowerLimit` after all the runs of the query, the query is considered a success.

##### `analysis.queries.queryTemplate`

{{< prism lang="yaml"  line-numbers="true" >}}
analysis: # Define queries and thresholds used for automated analysis
  queries:
    - name: <queryName>
      upperLimit: <integer> # If the metric exceeds this value, the automated analysis fails.
      lowerLimit: <integer> # If the metric goes below this value, the automated analysis fails.
      queryTemplate: >-
        <some-metrics-query>
     - name: avgCPUUsage # example query
        upperLimit: 100
        lowerLimit: 1
        queryTemplate: >-
          avg (avg_over_time(container_cpu_system_seconds_total{job="kubelet"}[{{armory.promQlStepInterval}}]) * on (pod)  group_left (annotation_app)
                  sum(kube_pod_annotations{job="kube-state-metrics",annotation_deploy_armory_io_replica_set_name="{{armory.replicaSetName}}"})
                  by (annotation_app, pod)) by (annotation_app)
                #,annotation_deploy_armory_io_replica_set_name="${canaryReplicaSetName}"})
                #${ARMORY_REPLICA_SET_NAME}
                #,annotation_deploy_armory_io_replica_set_name="${ARMORY_REPLICA_SET_NAME}"
                #${replicaSetName}
                #${applicationName}
                # note the time should actually be set to ${promQlStepInterval}
{{< /prism >}}

The query you want to run. See the {{< linkWithTitle "cd-as-a-service/tasks/canary/retro-analysis.md" >}} guide for details on how to build and test queries using the UI.

For information about writing queries, see {{< linkWithTitle "ref-queries.md" >}}.

When writing queries, you can use key/value pairs that are passed as substitutions for variables to the queries.

Armory supports the following variables out of the box:

- `armory.startTimeIso8601`
- `armory.startTimeEpochSeconds`
- `armory.startTimeEpochMillis`
- `armory.endTimeIso8601`
- `armory.endTimeEpochSeconds`
- `armory.endTimeEpochMillis`
- `armory.intervalMillis`
- `armory.intervalSeconds`
- `armory.promQlStepInterval`
- `armory.deploymentId`
- `armory.applicationName`
- `armory.environmentName`
- `armory.replicaSetName`

You can supply your own variables by adding them to the `strategies.<strategyName>.<strategy>.steps.analysis.context`. When you use them in your query, include the `context` prefix. For example, if you create a variable named `owner`, you would use `{{context.owner}}` in your query.


### `webhooks.`

See {{< linkWithTitle "cd-as-a-service/tasks/webhook-approval.md" >}} for a detailed example.

{{< include "cdaas/dep-file/webhooks-config.md" >}}

### `trafficManagement.`

You configure your service mesh per target in this section. If you omit the `target` entry, CD-as-a-Service applies the config to all targets.

{{< prism lang="yaml"  line-numbers="true" >}}
trafficManagement:
  - targets: ["<target-name>"]
{{< /prism >}}

#### `trafficManagement.targets.smi`

{{< include "cdaas/dep-file/tm-smi-config.md" >}}


#### `trafficManagment.targets.istio`

See {{< linkWithTitle "cd-as-a-service/tasks/deploy/traffic-management/istio.md" >}} for a detailed example.

{{< include "cdaas/dep-file/tm-istio-config.md" >}}


