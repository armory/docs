1. Generate your deployment config template and output it to a file.

   For example, this command generates a deployment template for canary deployments and saves it to a file named `canary.yaml`:

   ```bash
   armory template kubernetes canary > canary.yaml
   ```

1. Customize your deployment file by setting the following minimum set of parameters:

   - `application`: The name of your app.
   - `targets.<deploymentName>`: A descriptive name for your deployment. Armory recommends using the environment name.
   - `targets.<deploymentName>.account`: This is the name of your RNA. If you installed the RNA manually, it is the value that you assigned to the `agentIdentifier` parameter.
   - `targets.<deploymentName>.strategy`: the name of the deployment strategy you want to use. You define the strategy in `strategies.<strategy-name>`.
   - `manifests`: a map of manifest locations. This can be a directory of `yaml (yml)` files or a specific manifest. Each entry must use the following convention:  `- path: /path/to/directory-or-file`
   - `strategies.<strategy-name>`: the list of your deployment strategies. Use one of these for `targets.<target-cluster>.strategy`.
  
      If you are using a canary strategy, the strategy section consists of a map of steps for your canary strategy in the following format:

      ```yaml
      strategies:
        my-demo-strategy: # Name that you use for `targets.<deploymentName>.strategy
        - canary # The type of deployment strategy to use.
            steps:
              - setWeight:
                  weight: <integer> # What percentage of the cluster to roll out the manifest to before pausing.
              - pause:
                  duration: <integer> # How long to pause before deploying the manifest to the next threshold.
                  unit: <seconds|minutes|hours> # The unit of time for the duration.
              - setWeight:
                  weight: <integer> # The next percentage threshold the manifest should get deployed to before pausing.
              - pause:
                  untilApproved: true # Wait until a user provides a manual approval before deploying the manifest
      ```

      Each step can have the same or different pause behaviors. Additionally, you can configure as many steps  as you want for the deployment strategy, but you do not need to create a step with a weight set to 100. Once CD-as-a-Service completes the last step you configure, the manifest is deployed to the whole cluster automatically. 
      See the [Canary fields]({{< ref "cd-as-a-service/reference/ref-deployment-file#canary-fields" >}}) section of the deployment file reference for more information. 

1. (Optional) Configure a deployment timeout.

    A deployment times out if the pods for your application fail to be in ready state in 30 minutes. You can optionally configure a deployment timeout by adding a `deploymentConfig` top-level section:

    ```yaml
    deploymentConfig:
      timeout:
        unit: <seconds|minutes|hours>
        duration: <integer>
    ```

    Note that the minimum timeout you can specify is 60 seconds (1 minute). See the [Deployment config]({{< ref "cd-as-a-service/reference/ref-deployment-file#deploymentconfig" >}}) section of the deployment file reference for more information. 

1. (Optional) Ensure there are no YAML issues with your deployment file.

   Since a hidden tab in your YAML can cause your deployment to fail, it's a good idea to validate the structure and syntax in your deployment file. There are several online linters, IDE-based linters, and command line linters such as `yamllint` that you can use to validate your deployment file.

> You can view detailed configuration options on the {{< linkWithTitle "cd-as-a-service/reference/ref-deployment-file.md" >}} page.
