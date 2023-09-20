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

When configuring a registry, you normally use standard `SpinnakerService`
configuration when using the Operator.

### Update your Spinnaker installation
The configuration below must go under `spinnakerConfig.config.providers`,
as explained in [Connect Docker Registries](https://docs.armory.io/continuous-deployment/armory-admin/artifacts-docker-connect/)

```yaml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      providers:
        dockerRegistry:
          enabled: true
          primaryAccount: dockerhub
          accounts:
          - name: dockerhub
            requiredGroupMembership:
            providerVersion: V1
            address: 012345678910.dkr.ecr.us-east-1.amazonaws.com
            username: AWS
            passwordCommand: "aws --region us-east-2 ecr get-authorization-token --output text --query 'authorizationData[].authorizationToken' | base64 -d | sed 's/^AWS://'"
```

Success! Now you will be able to use ECR as a Docker registry in the configuration stage.

![](/images/armory-admin/artifacts/ecr-test.png)
