---
title: "Connect Spinnaker to Amazon Elastic Container Registry"
linkTitle: "Connect to AWS ECR"
aliases:
  - /spinnaker_install_admin_guides/ecr_registry/
  - /spinnaker_install_admin_guides/ecr-registry/
  - /spinnaker-install-admin-guides/ecr_registry/
  - /docs/spinnaker-install-admin-guides/ecr-registry/
  - /docs/armory-admin/artifacts-ecr-connect/
  - /armory-admin/artifacts-ecr-connect/
description: >
  Learn how to configure Spinnaker to connect to AWS ECR.
---

## Adding ECR as a Docker registry

When configuring a registry, you normally use standard `SpinnakerService` configuration if using the Operator, or the `hal` command for [adding a Docker Registry](https://www.spinnaker.io/reference/halyard/commands/#hal-config-provider-docker-registry-account-add) if using Halyard.

Starting Halyard version v1.10 and later , the ECR token refresh is supported by the docker registry provider by default. Hence you are not required to have the side car container alongside clouddriver to refresh the token. In these later versions, use the `--password-command` option to pass the command to update your access token through halyard as shown under [ECR Docker Registry](https://spinnaker.io/docs/setup/install/providers/docker-registry/#amazon-elastic-container-registry-ecr) or use `passwordCommand:` under dockerRegistry account configuration for operator.



### Update your Spinnaker installation

{{< tabs name="update" >}}
{{% tabbody name="Operator" %}}

```bash
dockerRegistry:
  enabled: true
  primaryAccount: dockerhub
  accounts:
  - name: dockerhub
    requiredGroupMembership:
    providerVersion: V1
    address: 012345678910.dkr.ecr.us-east-1.amazonaws.com
    username: AWS 
    passwordCommand: "aws --region ue-east-2ecr get-authorization-token --output text --query 'authorizationData[].authorizationToken' | base64 -d | sed 's/^AWS://"
```

{{% /tabbody %}}

{{% tabbody name="Halyard" %}}

```bash
hal config provider docker-registry account add my-ecr-registry \
 --address $ADDRESS \
 --username AWS \
 --password-command "aws --region $REGION ecr get-authorization-token --output text --query 'authorizationData[].authorizationToken' | base64 -d | sed 's/^AWS://'"

```

{{% /tabbody %}}
{{< /tabs >}}

Success! Now you will be able to use ECR as a Docker registry in the configuration stage.

![](/images/armory-admin/artifacts/ecr-test.png)
