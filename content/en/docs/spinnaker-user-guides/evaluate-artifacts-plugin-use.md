---
title: Use the Evaluate Artifacts Stage Plugin
description: >
  Use the Evaluate Artifacts Stage to evaluate SpEL expressions inside of Spinnaker™ artifacts.
---

![Proprietary](/images/proprietary.svg)

## {{% heading "prereq" %}}

The Evaluate Artifacts Stage is a plugin to Armory Enterprise. You must have the plugin enabled. For more information, see [Enable the Evaluate Artifacts Stage Plugin]({{< ref "evaluate-artifacts-plugin-enable.md" >}}).

## Using the stage

To use the stage, perform the following steps:

1. In the Armory Enterprise UI, navigate to the pipeline you want to modify.
2. Add the stage called **Evaluate Artifacts** stage to your pipeline.
3. Add an artifact to the stage.
4. Enter your artifact definition. When entering the definition, you can use a SpEL expression to parameterize it. 

## Examples

This example reads the parameter `moduleConfig` and parses it as JSON. Within that JSON, it reads the variable named `variable1` and injects it into the bucket.

```json
bucket  = "${#readJson(parameters['moduleConfig'])['variable1']}"
key     = "terraformer/tests/basic/terraform.tfstate"
region  = "us-west-2"
encrypt = false
profile = "prod"
```

If you run this pipeline and give the `moduleConfig` parameter the value `{ "variable1": "myBucketName"}`,
the stage evaluates to the following and stores the result as a base64 encoded artifact:

```json
bucket  = "myBucketName"
key     = "terraformer/tests/basic/terraform.tfstate"
region  = "us-west-2"
encrypt = false
profile = "prod"
```

## Known issues

### Problem saving artifacts

You may run into an issue where it seems like artifacts (or changes to them) are not being saved even though you click **Save Changes**. This issue occurs because of how the UI handles updates to artifacts in relation to changes to other configurations.

To avoid this issue, use the following workflow when you want to modify artifacts in a stage:

1. Save any changes you have made to the pipeline before you modify artifacts.
2. Make changes to the artifacts for the stage.
3. Wait for the status in the bottom right of the UI to change from **In sync to the server** to the action buttons.
   This wait period is important. If you make other changes before the artifact is ready, the artifact will not be saved.
4. Save your changes.
5. Continue making other changes.