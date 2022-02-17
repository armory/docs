```yaml
version: v1
kind: kubernetes
application: tv-app # The name of the application to deploy.
targets: # Map of your deployment targets. Provide a descriptive name for the deployments, such as the environment name, so you can tell them apart.
    dev-west: # Name for your deployment. Use a descriptive value such as the environment name.
        account: dev-acccount01 #  The agent identifier that a deployment target cluster got assigned when you installed the Remote Network Agent (RNA) on it.
        namespace: us-west-dev # (Recommended) Set the namespace that the app gets deployed to. Overrides the namespaces that are in your manifests.
        strategy: strategy1 # This is the key that references a strategy you define under the strategies section of the file.
        constraints:
            # Constraints are conditions that need to be satisfied before deployment to this target begins. Omitting constraints causes a deployment to start immediately. You can specify multiple conditions.
            beforeDeployment:
                - pause: # The map key is the step type
                    # The duration of the pause before the deployment continues. If duration is not zero, set untilApproved to false.
                    duration: 1
                    unit: SECONDS
                    # If set to true, the deployment waits until a manual approval to continue. Only set this to true if duration and unit are not set.
                    untilApproved: false
            # Defines the deployments that must reach a successful state (defined as status == SUCCEEDED) before this deployment can start.Deployments with the same dependsOn criteria will execute in parallel.
            dependsOn: []
# The list of manifest sources. Can be a directory or file.
manifests:
    - path: src/tv-app/manifests # Read all yaml|yml files in the directory and deploy all the manifests found.
      targets: [dev-west] # Optional, if specified this manifest will only be deployed to the specified target.
strategies: # A map of named strategies that can be assigned to deployment targets in the targets block.
    strategy1: # Name for a strategy that you use to refer to it. Used in the target block. This example uses strategy1 as the name.
        canary: # The deployment strategy type. Use canary.
            # The steps for your deployment strategy.
            steps:
                - setWeight:
                    # The percentage of pods that should be running the canary version for this step. Set it to an integer between 0 and 100, inclusive.
                    weight: 33
                - analysis:
                    interval: 7 # How long each sample of the query gets summarized over
                    units: seconds # The unit for the interval: 'seconds', 'minutes' or 'hours'.
                    numberOfJudgmentRuns: 1 # How many times the queries get run.
                    # rollBackMode: manual # Optional Defaults to 'automatic' if omitted. Uncomment to require a manual review before rolling back if automated analysis detects an issue.
                    # rollForwardMode: manual # Optional. Defaults to 'automatic' if omitted. Uncomment to require a manual review before continuing deployment if automated analysis determines the application is healthy.
                    queries: # Specify a list of queries to run. Reference them by the name you assign in analysis.queries.
                    - containerCPUSeconds
                    - avgMemoryUsage
                - setWeight:
                  # The percentage of pods that should be running the canary version for this step. Set it to an integer between 0 and 100, inclusive.
                  weight: 100


analysis: # Define queries and thresholds used for automated analysis
  # Note that the example queries require Prometheus to have 
  # "kube-state-metrics.metricAnnotationsAllowList[0]=pods=[*]" set and for your applications pods to have the annotation "prometheus.io/scrape": "true"
  queries:
    - name: containerCPUSeconds
      upperLimit: 100 # If the metric exceeds this value, the automated analysis fails.
      lowerLimit: 0 # If the metric goes below this value, the automated analysis fails.
      queryTemplate: >-
        avg (avg_over_time(container_cpu_system_seconds_total{job="kubelet"}[{{armory.promQlStepInterval}}]) * on (pod)  group_left (annotation_app)
        sum(kube_pod_annotations{job="kube-state-metrics",annotation_deploy_armory_io_replica_set_name="{{armory.replicaSetName}}"})
        by (annotation_app, pod)) by (annotation_app)
    - name: avgMemoryUsage 
      upperLimit: 1  # If the metric exceeds this value, the automated analysis fails.
      lowerLimit: 0 # If the metric goes below this value, the automated analysis fails.
      queryTemplate: >-
        avg (avg_over_time(container_memory_working_set_bytes{job="kubelet"}[{{armory.promQlStepInterval}}]) * on (pod)  group_left (annotation_app)
        sum(kube_pod_annotations{job="kube-state-metrics",annotation_deploy_armory_io_replica_set_name="{{armory.replicaSetName}}"})
        by (annotation_app, pod)) by (annotation_app)
```