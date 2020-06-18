---
weight: 60
title: Working with S3 Artifacts
aliases:
  - /spinnaker_user_guides/s3/
  - /spinnaker-user-guides/s3/

---

> Before you start, you'll need to [configure an S3 artifact account]({{< ref "s3" >}}).  If
> you don't see an S3 option for Expected Artifacts "Match against" in the UI,
> you'll need to double-check your Spinnaker is configured with the S3 account.

## Identifying an S3 file as an artifact

On a pipeline's Configuration, you'll want to "Add Artifact".  If S3 has been
configured, you should be able to select "S3" to "Match against".  Now all
you should need to do is enter the object path as an S3 URL
 (ie. "s3://mybucket/myfolder/myfile.yaml").  You will want to select "Default
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
