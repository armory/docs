---
title: Deployment Registration
exclude_search: true
---

:wave:

<!--Several shortlinks point to this page from Deck:
- go.armory.io/UIdocs-deploy-reg points to the top of this page
- go.armory.io/UIdocs-deploy-reg-troubleshooting points to Troubleshooting
- go.armory.io/UIdocs-deploy-reg-manual-id points to the Operator fails to generate an instance ID section
-->

<!--
## Overview

As part of the configuration process for Armory Enterprise, you need to register your instance with Armory. Registration helps ensure that your usage of Armory's features is in compliance with Armory's licensing terms and allows Armory Support Engineers to help you troubleshoot more effectively.

You will be prompted to do this when you launch the Armory Enterprise UI.

## Register your instance

1. Follow the instructions in the Armory Enterprise UI. The UI provides the following information that you need to continue:
  - Instance ID
  - Client ID
  - Secret
  > This is the only time you are shown the secret value. Store it somewhere safe.
2. In your Operator config, such as `spinnakerService.yml`, configure the following parameters:
  - spec.spinnakerConfig.profiles.spinnaker.”armory.cloud”.iam.tokenIssueUrl: Set this value to `https://auth.cloud.armory.io/oauth/token`.
  - spec.spinnakerConfig.profiles.spinnaker.”armory.cloud”.iam.clientID: Set this value to **Client ID** from step 1.
  - spec.spinnakerConfig.profiles.spinnaker.”armory.cloud”.iam.clientSecret: Set this value to the **Secret** from step 1.
3. Save the file and apply the file.
   Applying the config changes redeploys Armory Enterprise.

## Troubleshooting

### Operator fails to generate an instance ID

The Armory Operator generates an instance ID and applies it to your Armory Enterprise instance. If it fails to do so, you can deploy Armory Enterprise to let the Operator attempt to do so again, or you can manually configure an instance ID.



-->