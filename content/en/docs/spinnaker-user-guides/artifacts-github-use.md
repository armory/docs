---
title: Use GitHub Artifacts in Spinnaker Pipelines
linkTitle: Use GitHub Artifacts
description: >
  Configure Spinnaker to use GitHub artifacts in your pipelines.
---

## Pulling a Kubernetes Manifest from Github

1. Under "Expected Artifacts" in your pipeline, create an artifact of type "Github".

1. Specify the "file path" as the path within the repository to your file.  For example, if your manifest is at `demo/manifests/deployment.yml` in the Github repository `orgname/reponame` , specify `demo/manifests/deployment.yml`.

1. Check the "Use Default Artifact" checkbox.

1. In the "Content URL", provide the full path to the *API URI* for your manifest.  Here are some examples of this:

    * If you're using SaaS Github (www.github.com), the URI is generally formatted like this: `https://api.github.com/repos/<ORG>/<REPO>/contents/<PATH-TO-FILE>`.
      * For example: `https://api.github.com/repos/armory/demo/contents/manifests/deployment.yml`

    * If you have an on-prem Github Enterprise, then the URI may be formatted like this: `https://<GITHUB_URL>/api/v3/repos/<ORG>/<REPO>/contents/<PATH-TO-FILE>`.
      * For example: `http://github.customername.com/api/v3/repos/armory/spinnaker-pipelines/contents/manifests/deployment.yml`

1. Create a "Deploy (Manifest)" stage.  Rather than specifying the manifest directly in the UI, under the "Manifest Source" specify "Artifact", and in the "Expected Artifact" field, select the artifact you created above.

1. If you have multiple Github Accounts (credentials) added to your Spinnaker cluster, there should be a dropdown to select which one to use.

