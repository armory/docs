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