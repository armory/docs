```yaml
version: v1
kind: kubernetes

# The name of the application to deploy.
application: <application>

# Targets is a map of deployment environments, keyed by name.
# A named target is an (account, namespace) tuple; the tuple must be unique
# within a deployment. You can deploy to one or more targets within
# a deployment pipeline.
targets:

  # Target name. Use a descriptive value (e.g., prod or staging).
  <target>:

      # An account corresponds to a Kubernetes cluster.
      # You can create and configure accounts inside Cloud Console
      # or by installing Armory RNA inside a cluster.
      account: <accountName>

      # If provided, namespace overrides the "namespace" value
      # in all manifests deployed to this target. Recommended.
      namespace: <namespace>

      # A named strategy from the "strategies" block, configured below.
      # This strategy is used when deploying manifests to this target.
      strategy: <strategy>

# The list of manifest sources. Each entry can be a directory or file.
manifests:

  # Read all yaml|yml files in the directory and deploy all the manifests found.
  - path: path/to/manifests

    # The deployment targets that should use the manifest. Used for all targets if omitted.
    targets: ["<target>"]

  # Deploy this specific manifest.
  - path: path/to/manifest.yaml

# A map of deployment strategies, keyed by name.
strategies:

  # Strategy name. Use a descriptive name (e.g., "prod-strategy").
  # Use a strategy by assigning it to a deployment target above.
  <strategy>:

    # Define a blue/green deployment strategy.
    #
    # When using a blue/green strategy, only one version of your software
    # gets exposed to users at a time.
    #
    # First, Armory CDaaS deploys the new version without
    # exposing it to the activeService defined below. The new version is
    # then accessible using the previewService (if defined).
    #
    # Second, Armory CDaaS executes the "redirectTrafficAfter" steps in parallel.
    # After each step completes, Armory CDaaS exposes the new version
    # to the activeService.
    #
    # Finally, Armory CDaaS executes the "shutDownOldVersion" steps in parallel.
    # After each step completes, Armory CDaaS deletes the old version.
    blueGreen:

      # The name of a Kubernetes Service resource.
      # The activeService must be deployed out-of-band and should be configured
      # to direct traffic to your application.
      activeService: active-service

      # The name of a Kubernetes Service resource. Optional.
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
            unit: seconds

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
      shutdownOldVersionAfter:
        - pause:
            untilApproved: true
```