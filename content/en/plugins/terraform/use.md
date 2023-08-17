---
linkTitle: Use
title: Use the Terraform Integration Stage in Spinnaker or Armory Continuous Deployment
weight: 20
description: >
  Learn how to use the Terraform Integration pipeline stage to execute tasks against your Terraform projects.
---
![Proprietary](/images/proprietary.svg)

## Overview of Terraform integration

At the core of Terraform Integration is the Terraformer service, which fetches your Terraform projects from source and executes various Terraform commands against them. When a `terraform` stage starts, Orca submits the task to Terraformer and monitors it until completion. Once a task is submitted, Terraformer fetches your target project, runs `terraform init` to initialize the project, and then runs your desired `action` (`plan` or `apply`). If the task is successful, the stage gets marked successful as well. If the task fails, the stage gets marked as a failure, and the pipeline stops.

A Terraform Integration stage performs the following actions when it runs:

1. Authenticates to your repo using basic authentication credentials you provide. This can be a GitHub token or a BitBucket username/password combination.
1. Pulls a full directory from your Git repository.
1. Optionally uses a Spinnaker artifact provider (Github, BitBucket, or HTTP) to pull in a `tfvars`-formatted variable file.
1. Runs the Terraform action you select.

## {{% heading "prereq" %}}

* You have read the [Terraform Integration Overview]({{< ref "plugins/terraform/_index.md" >}}).
* If you are using Armory CD, you have [enabled Terraform Integration]({{< ref "plugins/terraform/install/armory-cd.md" >}}).
* If you are using Spinnaker, you have installed the Terraform Integration service and plugin ([Spinnaker Operator]({{< ref "plugins/terraform/install/spinnaker-operator.md" >}}), [Halyard]({{< ref "plugins/terraform/install/spinnaker-halyard.md" >}}))

## Example Terraform Integration stage

The following example describes a basic pipeline that performs the `plan` and `apply` Terraform actions.

The pipeline consists of these stages:

1. [Plan stage](#plan-stage)
1. [Show stage](#show-stage)
1. [Manual Judgment stage](#manual-judgment-stage)
1. [Apply stage](#apply-stage)

### Plan stage

A Plan stage in a pipeline performs the same action as running the `terraform plan` command. Although a Plan stage is not strictly required since an Apply stage performs a `terraform plan` if no plan file exists, it's a good idea to have one. You'll understand why during the Manual Judgment stage.

For this stage, configure the following:

- For the **Terraform version**, pick any version, such as `0.13.3`.
- For the **Action**, choose **Plan**.
- **Main Terraform Artifact**
  - Select **Expected Artifact > Define a new artifact**
    - Select **Account > <YourGitRepo>**. This is the Git repo that was configured when you enabled the Terraform Integration and houses your Terraform code.
    - In **URL**, add the URL to the Git repo that houses your Terraform code.
- Under **Produces Artifacts**
  1. Select **Define artifact**. A window appears.
  2. Optionally, provide a descriptive display name.
  3. For **Match Artifact > Account** , select **embedded-artifact** .
  4. Name the artifact `planfile`.

The output of this stage, the embedded artifact named `planfile`, can be consumed by subsequent stages in this pipeline. In this example, this occurs during the final stage of the pipeline. Additionally, more complex use cases that involve parent-child pipelines can also use plan files.

### Show stage

The Show stage performs the same action as running the `terraform show` command.
You can then use the JSON output from your `planfile` in subsequent stages.

The Show stage depends on the Plan stage. For the Show stage, configure the following:

- For the **Terraform version**, pick the same version as you did you for the Plan stage.
- For the **Action**, choose **Show**.
- For **Main Terraform Artifact**
  - Select **Expected Artifact > Artifact from execution context**
    - Select **Account > <YourGitRepo>**. This is the Git repo that was configured when you enabled the Terraform Integration and houses your Terraform code.
    - In **URL**, add the URL to the Git repo that houses your Terraform code.
    - In **Branch**, add the branch your code is in.
- For **Terraform Plan**, add the `planfile` from the dropdown. This is the artifact you created in the Plan stage.
- All other fields can be left blank or with their default values for this example.

You can add an Evaluate Variables stage to get the output from the `planfile` JSON created by the Show stage and use it in subsequent stages.

- **Variable Name**: `planfile_json`
- **Variable Value**: `${#stage('Show').outputs.status.outputs.show.planfile_json}`

### Manual Judgment stage

You can use the default values for this stage. Manual judgment stages ask the user to approve or fail a pipeline. Having a Manual Judgment stage between a Plan and Apply stage gives you a chance to confirm that the Terraform code is doing what you expect it to do.

### Apply stage

The Apply stage performs the same action as running the `terraform apply` command. For this stage, configure the following:

- For the **Terraform version**, pick the same version as you did you for the Plan stage.
- For the **Action**, choose **Apply**.
- For **Main Terraform Artifact**
  - Select **Expected Artifact > Define a new artifact**
    - Select **Account > <YourGitRepo>**. This is the Git repo that was configured when you enabled the Terraform Integration and houses your Terraform code.
    - In **URL**, add the URL to the Git repo that houses your Terraform code.
- For **Terraform Artifacts**, add a new file and select the `planfile` from the dropdown. This is the file that you created during the Plan stage and verified during the Manual Judgment stage.
- All other fields can be left blank or with their default values for this example.

Run the pipeline.

## Create a Terraform Integration stage

![Terraform Stage in Deck](/images/plugins/terraform/terraform_stage_ui.png)

{{< include "rdbms-utf8-required.md" >}}

 {{% alert title="Warning" color=warning %}}
If the Clouddriver MySQL schema is not configured correctly, the Terraform Integration stage fails.
 {{% /alert %}}
To create a new Terraform stage, perform the following steps:

1. In Deck, select the Application and pipeline you want to add the Terraform Integration stage to.
2. Configure the Pipeline and add a stage.
3. For **Type**, select **Terraform**.
4. Add a **Stage Name**.
5. Configure the Terraform Integration stage.
    The available fields may vary slightly depending on what you configure for the stage:
    * **Basic Settings**
      * **Terraform Version**:  Terraform version to use. All Terraform stages within a pipeline that modify state (apply, output, destroy) must use the same version. If you want to use the remote backend, the minimum supported version is 0.12.0 and you must select the same Terraform version that your Terraform Cloud/Enterprise is configured to use.
      * **Action**: Terraform action to perform. You can select any of the following actions:
        * **Plan**: The output of the plan command is saved to a base64-encoded Spinnaker artifact and is injected into context.  You can use this artifact with a webhook to send the plan data to an external system or to use it in an `apply` stage. Optionally, you can select **Plan for Destroy** to view what Terraform destroys if you run the Destroy action.
          * For remote backends, if you view a `plan` action in the Terraform Cloud/Enterprise UI, the type of `plan` action that the Terraform Integration performs is a "speculative plan." For more information, see [Speculative Plans](https://www.terraform.io/docs/cloud/run/index.html#speculative-plans).
        * **Apply**: Run `terraform apply`. Optionally, you can ignore state locking. Armory recommends you do not ignore state locking because it can lead to state corruption. Only ignore state locking if you understand the consequences.
        * **Destroy**: Run `terraform destroy`. Optionally, you can ignore state locking. Armory recommends you do not ignore state locking because it can lead to state corruption.  Only ignore state locking if you understand the consequences.
        * **Output**: Run `terraform output`.
        * **Show**: Run `terraform show`. This creates human-readable JSON output from your `planfile`.
      * **Targets**: Scope execution to a certain subset of resources.
      * **Workspace**: [Terraform workspace](https://www.terraform.io/docs/state/workspaces.html) to use. The workspace gets created if it does not already exist. For remote backends, the workspace must be explicit or prefixed. For more information about what that means, see the Terraform documentation about [remote backends](https://www.terraform.io/docs/backends/types/remote.html)
    * **Main Terraform Artifact**
      * **Expected Artifact**: Required. Select or define only one `git/repo` type artifact.
        ![Terraform git repo artifact](/images/plugins/terraform/terraform-git-repo.png)
        * **Account**: The account to use for your artifact.
        * **URL**: If you use a GitHub artifact, make sure you supply the _API_ URL of the file, not the URL from the `Raw` GitHub page. Use the following examples as a reference for the API URL:

          Regular GitHub:

          ```bash
          https://api.github.com/repos/{org}/{repo}/contents/{file path}
          ```

          Github Enterprise:

          ```bash
          https://{host}/api/v3/repos/{org}/{repo}/contents/{file path}
          ```
        * **Checkout subpath**: Enable this option to specify a **Subpath** within a Git repo. Useful if you have a large repo and the Terraform files are located in a specific directory.
        * **Branch**: The Git branch or commit to use.

      * **Subdirectory**: Subdirectory within a repo where the `terraform` command runs. Use `./` if the command should run at the root level.
    * **Variable Files**: Optional. Variable files that get appended to the Terraform command. Equivalent to running terraform apply with the `-var-file` option.
      * If you want to use the output of a **Plan** stage for an **Apply** stage, select the **Plan** stage output as an **Expected Artifact**
    * **Variable Overrides**: Optional. Key/value pairs used as variables in the Terraform command. Equivalent to running terraform apply with the `-var` option. You can use a GitHub or BitBucket
    * **Backend Artifact**: Optional. Configuration stored outside of the primary repo that gets used for authenticating to a state backend. For example, if you want to use an S3 artifact for your backend state, specify it in this section.

      For the `backendArtifact` and other artifacts, you can replace `github/file` with some other artifact type. For example, if you're using the BitBucket artifact provider, specify `bitbucket/file` and the corresponding artifact account.

      The Terraform Integration supports remote backends as a feature. Select a Terraform version that is 0.12.0 or higher when configuring the stage. Then, you can use Terraform code that references a remote backend.



## Custom plugins

Terraform Integration supports the use of custom Terraform providers and plugins. Terraform Integration downloads the plugins and injects them into each stage dynamically as needed to ensure the Terraform code can run.

Any plugin you want to use must meet the following requirements:
* Be a zip, tar, gzip, tar-gzip or executable
* If compressed, be at the root of the archive
* Be x86-64 (amd64) Linux binaries
* Have a SHA256 Sum
* Follow the Terraform plugin naming [conventions](https://www.terraform.io/docs/extend/how-terraform-works.html#discovery)

**Note**: If any Terraform Integration stage in a pipeline defines a custom plugin, all Terraform Integration stages must then define that same plugin in the pipeline.

**Configuring Terraform plugins**:

```yaml
{
  "action": "plan",
  "artifacts": [
    {
      "reference": "https://github.com/someorg/terraformer",
      "type": "git/repo",
      "version": "refs/heads/branch-testing"
    },
    {
      "metadata": {
        "sha256sum": "fda6273f803c540ba8771534247db54817603b46784628e63eff1ce7890994e4"
      },
      "name": "terraform-provider-foo",
      "reference": "https://github.com/armory/terraform-provider-foo/releases/download/v0.1.19/terraform-provider-foo_0.1.19_linux_amd64.zip",
      "type": "terraform/custom",
      "version": "v0.1.19"
    }
  ],
 ...
}
```

Terraform Integration caches all the defined plugins by default and does not redownload them.  To configure the Terraform Integration to redownload a plugin, add the following JSON under the metadata key in the artifact object:

```yaml
"metadata": {
    "sha256sum": "longString",
    "forceDownload": true,
}
```

## View Terraform log output

![Terraform Integration logs](/images/plugins/terraform/terraformer-ui-logs.png)

Terraform provides logs that describe the status of your Terraform action. When you run Terraform actions on your workstation, the log output is streamed to `stdout`. For Armory's Terraform Integration, Spinnaker captures the log output and makes it available on the **Pipelines** page of Deck as part of the **Execution Details**. Exit codes in the log represent the following states:

```
0 = Succeeded with empty diff (no changes)
1 = Error
2 = Succeeded with non-empty diff (changes present)
```

For more information about Terraform logs, see the [Terraform documentation](https://www.terraform.io/docs/commands/plan.html#detailed-exitcode).

## Consume Terraform output using SpEL

If you have a Terraform template configured with [Output Values](https://www.terraform.io/docs/configuration/outputs.html), then you can use the `Output` stage to parse the output and add it to your pipeline execution context.

For example, if you have a Terraform template that has this:

```hcl
output "bucket_arn" {
    value = "${aws_s3_bucket.my_bucket.arn}"
}
```

Then you can set up an `Output` stage that exposes this in the pipeline execution context.  If you have an `Output` stage with the stage name `My Output Stage`, then after running the `Output` stage, access the bucket ARN with this:

```hcl
${#stage('My Output Stage')["context"]["status"]["outputs"]["bucket_arn"]["value"]}
```

