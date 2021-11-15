---
title: Use AWS Lambda in Armory Enterprise
linkTitle: Use AWS Lambda
description: >
  Learn how to use AWS Lambda in a Spinnaker pipeline.
---

## {{% heading "prereq" %}}

This guide explores a pipeline that tests the various Lambda stages.  To deploy the pipeline in your own Armory Enterprise instance, make sure you complete the following:

- [Configure Armory Enterprise for AWS Lambda]({{< ref "aws-lambda">}})
- [Create a Lambda execution role](https://docs.aws.amazon.com/lambda/latest/dg/lambda-intro-execution-role.html)
- [Create a Lambda deployment package](https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-package.html)
- Create a Lambda sample payload JSON file
- Upload the Lambda deployment package and the Lambda sample payload JSON to an S3 bucket that Armory Enterprise can access
- Make sure the `SpinnakerManaged` role has permission to work with Lambda


## AWS Lambda pipeline example

This pipeline is based on the one defined in [Enhancing Spinnaker deployment experience of AWS Lambda functions with the Lambda plugin](https://aws.amazon.com/blogs/opensource/enhancing-spinnaker-deployment-experience-of-aws-lambda-functions-with-the-lambda-plugin/).

{{< figure src="/images/user-guides/aws/lambda/lamba-pipeline-definition.jpg" caption="<i>Example Lambda Pipeline Definition</i>" alt="Example Lambda Pipeline Definition" >}}



### Deployment stage

This stage creates a new Lambda function, or updates a Lambda function, and sets various Lambda configurations. If you want a simple update to the code of an existing Lambda function, you should use the Update Code stage instead.

{{< figure src="/images/user-guides/aws/lambda/lambda-deployment.jpg" caption="<i>Example of Lambda Deployment Stage</i>" alt="Example of  Lambda Deployment Stage" >}}


### Update Code stage

This stage updates the code of an existing Lambda function.

{{< figure src="/images/user-guides/aws/lambda/lambda-update-code.jpg" caption="<i>Example of Lambda Update Code Stage</i>" alt="Example of  Lambda Update Code Stage" >}}

### Invoke stage

This stage executes a Lambda function. The results of this stage are stored in the stage output, which you can access via SpEL with something like the following:

```
#stage('AWS Lambda Update Invoke').outputs.invokeResultsList
```

{{< figure src="/images/user-guides/aws/lambda/lambda-invoke.jpg" caption="<i>Example of Lambda Revoke Stage</i>" alt="Example of  Lambda Revoke Stage" >}}

### Route stage

This stage routes traffic across various versions of the Lambda function.

#### Simple strategy

Routes 100% of the traffic to the chosen **Target Version** of the Lambda function. This example config routes 100% of the traffic to the new Lambda version.

{{< figure src="/images/user-guides/aws/lambda/lambda-route-simple.jpg" caption="<i>Example of Lambda Route Stage - Simple Strategy</i>" alt="Example of Lambda Route Stage - Simple Strategy" >}}

#### Weighted Deployment strategy

Routes some percentage of the traffic to he chosen **Target Version** of the Lambda function. This example config routes 40% of the traffic to the new Lambda version.

{{< figure src="/images/user-guides/aws/lambda/lambda-route-weighted.jpg" caption="<i>Example of Lambda Route Stage - Weighted Deployment Strategy</i>" alt="Example of Lambda Route Stage - Weighted Deployment Strategy" >}}

#### Blue/Green strategy

Deploys a new version and includes health check configuration to test whether the newly deployed Lambda function is working as expected before routing 100% of traffic to the new version. In case of a health check mismatch, this stage deletes the new version based on the value of the **On Fail** field.

{{< figure src="/images/user-guides/aws/lambda/lambda-route-blue-green.jpg" caption="<i>Example of Lambda Route Stage - Blue/Green Strategy</i>" alt="Example of Lambda Route Stage - Blue/Green Strategy" >}}

### Delete stage

This stage deletes versions of your Lambda function.

#### Newest Function Version

Deletes the most recently deployed function version when this stage starts.

{{< figure src="/images/user-guides/aws/lambda/lambda-delete-newest-function-version.jpg" caption="<i>Example of Lambda Delete Stage - Newest Function Version</i>" alt="Example of Lambda Delete Stage - Newest Function Version" >}}

#### Previous Function Version

Deletes the second-most recently deployed function version when this stage starts.

{{< figure src="/images/user-guides/aws/lambda/lambda-delete-prev-function-version.jpg" caption="<i>Example of Lambda Delete Stage - Previous Function Version</i>" alt="Example of Lambda Delete Stage Previous Function Version configuration" >}}

#### Older Than N

Deletes all versions except for the number of most recent versions configured in the **Prior Versions to Retain** field.

{{< figure src="/images/user-guides/aws/lambda/lambda-delete-older-than-n.jpg" caption="<i>Example of Lambda Delete Stage - Older Than N</i>" alt="Example of Lambda Delete Stage Older Than N configuration" >}}

#### Provide Version Number

Deletes the specific version specified in the **Version Number** field.

{{< figure src="/images/user-guides/aws/lambda/lambda-delete-version-number.jpg" caption="<i>Example of Lambda Delete Stage - Provide Version Number</i>" alt="Example of Lambda Delete Stage Provide Version Number configuration" >}}

#### All Function Versions

Completely deletes all versions of the Lambda function and its infrastructure.

{{< figure src="/images/user-guides/aws/lambda/lambda-delete-all-function-versions.jpg" caption="<i>Example of Lambda Delete Stage - All Function Versions</i>" alt="Example of Lambda Delete Stage All Function Versions configuration" >}}
