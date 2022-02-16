---
title: Use Amazon Secure Storage Service (S3) Artifacts in Spinnaker
linkTitle: Use S3 Artifacts
aliases:
  - /docs/spinnaker-user-guides/s3/
  - /docs/spinnaker-user-guides/artifacts-s3-use/
  - /docs/spinnaker-user-guides/s3-artifacts-use/
description: >
  Configure an S3 file as an artifact in Spinnaker.
---

> Before you start, you need to [configure an S3 artifact account]({{<
ref "artifacts-s3-configure" >}}). If you don't see an S3 option for Expected
Artifacts "Match against" in the UI, you'll need to double-check your
installation is configured with the S3 account.

## Identifying an S3 file as an artifact

On a pipeline's Configuration, you'll want to "Add Artifact".  If S3 has been
configured, you should be able to select "S3" to "Match against".  Now all
you should need to do is enter the object path as an S3 URL
 (ie. `s3://mybucket/myfolder/myfile.yaml`).  You will want to select "Default
Artifact" so that, if the pipeline is run manually, it knows what file to pull
(because the artifact won't be present in the trigger otherwise).  Note that
you can choose a completely different path -- or even a complete different
artifact source -- for your default artifact.

## Referencing the new image

Depending on what you're using the file for, the artifact should show up as
a possible selection in later stages.  For example, if you wanted to use the
S3 file as a deployment manifest, you could reference it in the "Deploy
(Manifest)" stage:

![Example of S3 Manifest Artifact](/images/s3-user-guide-1.gif)
