```yaml
version: v1
kind: kubernetes
application: <appName>
# Map of deployment targets
targets:
  # You can specify multiple targets. This example has space for 3. Provide a descriptive name for the deployment, such as the environment name, so you can tell them apart.
  <targetName1>:
    # The agent identifier that a deployment target cluster got assigned when you installed the Remote Network Agent (RNA) on it.
    account: <accountName>
   #  (Recommended) Set the namespace that the app gets deployed to. Overrides the namespaces that are in your manifests.
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