```yaml
version: v1
kind: kubernetes
application: <AppName> # The name of the application to deploy.
targets: # Map of your deployment target, Borealis supports deploying to one target cluster.
    <deploymentName>: # Name for your deployment. Use a descriptive value such as the environment name.
        account: <agentIdentifier> # The agent identifier name that was assigned to the deployment target when you installed the RNA.
        namespace: <namespace> # (Recommended) Set the namespace that the app gets deployed to. Overrides the namespaces that are in your manifests
        strategy: <strategyName> # This is the key that references a strategy you define under the strategies section of the file.
        constraints: # Constraints are conditions that need to be satisfied before deployment to this target begins. Omitting constraints causes a deployment to start immediately. You can specify multiple conditions.
            beforeDeployment:
                - pause: # The map key is the step type
                    # The duration of the pause before the deployment continues. If duration is not zero, set untilApproved to false.
                    duration: <integer>
                    unit: <seconds|minutes|hours>
                    # If set to true, the deployment waits until a manual approval to continue. Only set this to true if duration and unit are not set.
                    # untilApproved: true
            # The deployment that must finish before this deployment can begin. Targets with the same dependsOn value execute in parallel.
            dependsOn: []
# The list of manifest sources. Can be a directory or file.
manifests:
    - path: path/to/manifests # Read all yaml|yml files in the directory and deploy all the manifests found.
      #targets: [dev-west] # optional, if specified this manifest will only be deployed to the specified target.
    - path: path/to/manifest.yaml # Deploy this specific manifest.
      # targets: [dev-west] # optional, if specified this manifest will only be deployed to the specified target.
strategies: # A map of named strategies that can be assigned to deployment targets in the targets block.
    <strategyName>: # Name for a strategy that you use to refer to it. Used in the target block. This example uses strategy1 as the name.
        canary: # The deployment strategy type. Use canary.
            # The steps for your deployment strategy.
            steps:
                - setWeight:
                    # The percentage of pods that should be running the canary version for this step. Set it to an integer between 0 and 100, inclusive.
                    weight: <integer>
                - analysis:
                    interval: 7 # How long each sample of the query gets summarized over
                    units: <seconds|minutes|hours> # The unit for the interval: 'seconds', 'minutes' or 'hours'.
                    numberOfJudgmentRuns: <integer> # How many times the queries get run.
                    # rollBackMode: manual # Optional. Defaults to 'automatic' if omitted. Uncomment to require a manual review before rolling back if automated analysis detects an issue.
                    # rollForwardMode: manual # Optional. Defaults to 'automatic' if omitted. Uncomment to require a manual review before continuing deployment if automated analysis determines the application is healthy.
                    queries: # Specify a list of queries to run. Reference them by the name you assign in analysis.queries.
                    - <queryName>
                    - <queryName>
                - setWeight:
                  # The percentage of pods that should be running the canary version for this step. Set it to an integer between 0 and 100, inclusive.
                  weight: <integer>
analysis: # Define queries and thresholds used for automated analysis.
  # Note that the example queries require Prometheus to have 
  # "kube-state-metrics.metricAnnotationsAllowList[0]=pods=[*]" set and for your applications pods to have the annotation "prometheus.io/scrape": "true"
  queries:
    - name: <queryName> # Used in `strategies.<strategyName>.carny.steps.analysis` section to reference this particular query.
      upperLimit: <integer> # If the metric exceeds this value, the automated analysis fails.
      lowerLimit: <integer> # If the metric goes below this value, the automated analysis fails.
      queryTemplate: >- # Example query.
        avg (avg_over_time(container_cpu_system_seconds_total{job="kubelet"}[{{armory.promQlStepInterval}}]) * on (pod)  group_left (annotation_app)
        sum(kube_pod_annotations{job="kube-state-metrics",annotation_deploy_armory_io_replica_set_name="{{armory.replicaSetName}}"})
        by (annotation_app, pod)) by (annotation_app)
    - name: avgMemoryUsage 
      upperLimit: 1  # If the metric exceeds this value, the automated analysis fails.
      lowerLimit: 0 # If the metric goes below this value, the automated analysis fails.
      queryTemplate: >- # Example query.
        avg (avg_over_time(container_memory_working_set_bytes{job="kubelet"}[{{armory.promQlStepInterval}}]) * on (pod)  group_left (annotation_app)
        sum(kube_pod_annotations{job="kube-state-metrics",annotation_deploy_armory_io_replica_set_name="{{armory.replicaSetName}}"})
        by (annotation_app, pod)) by (annotation_app)
```