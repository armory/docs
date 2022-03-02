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
    strategy: prod-blue-green
    # Note that there is no constraints block. This is the initial deployment to the dev environment.
  prod-west:
    # The account name that a deployment target cluster got assigned when you installed the Remote Network Agent (RNA) on it.
    account: cdf-prod
    # Optionally, override the namespaces that are in the manifests
    namespace: cdf-prod-agent
    # This is the key that references a strategy you define under the strategies section of the file.
    strategy: prod-blue-green
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
  prod-blue-green:
    # The deployment strategy type.
    blueGreen:
      # The name of a Kubernetes Service "activeService" resource.
      # The activeService must be deployed out-of-band and should be configured
      # to direct traffic to your application.
      activeService: active-service
      # The name of a Kubernetes Service "previewService" resource. Optional.
      # The previewService must be deployed out-of-band and should be configured
      # to direct traffic to your application. You can use this service to
      # preview the new version of your application before it is exposed to users.
      previewService: preview-service
      # The redirectTrafficAfter steps are pre-conditions for exposing the new
      # version to the activeService. The steps are executed
      # in parallel.
      redirectTrafficAfter:
        # A pause step type.
        # The deployment stops until the pause behavior is complete.
        # The pause type defined below is a duration-based pause.
        - pause:
            # Pause the deployment for <duration> <unit> (e.g., pause for 5 minutes).
            # A duration-based pause should omit the "untilApproved" flag.
            duration: 1
            # The pause's time unit. One of seconds, minutes, or hours.
            # Required if duration is set.
            unit: hour
        # A pause step type.
        # The pause type defined below is a judgment-based pause.
        - pause:
            # Pause the deployment until manual approval.
            # You can approve or rollback a deployment in the Cloud Console.
            # Do not provide a "duration" or "unit" value when defining
            # a judgment-based pause.
            untilApproved: true
      # The shutDownOldVersionAfter steps are pre-conditions for deleting the old
      # version of your software. The steps are executed in parallel.
      shutDownOldVersionAfter:
        - pause:
            untilApproved: true
```