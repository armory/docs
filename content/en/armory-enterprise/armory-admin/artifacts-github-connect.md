---
title: Connect GitHub as an Artifact Source in Spinnaker
linkTitle: Connecting to GitHub
aliases:
  - /spinnaker_install_admin_guides/github/
  - /docs/spinnaker-install-admin-guides/github
description: >
  Configure Spinnaker to access a GitHub repo as a source of artifacts.  
---

## Configure a GitHub trigger in Spinnaker

Spinnaker<sup>TM</sup> pipelines can be configured to trigger when a change is committed to a GitHub repository.  This doesn't require any configuration of Spinnaker other than [adding a GitHub trigger]({{< ref "artifacts-github-use" >}}) but does require administration of the GitHub repositories to configure the webhook.

The open source Spinnaker documentation
[has concise instructions for configuring GitHub webhooks.](https://www.spinnaker.io/setup/triggers/github/)

## Configure GitHub as an artifact source

If you actually want to use a file from the GitHub commit in your pipeline,
you'll need to configure GitHub as an artifact source in Spinnaker.

Many of the commands below have additional options that may be useful (or
possibly required).

### Enable GitHub artifacts

If you haven't done this yet (for example, if you've just installed Armory
Spinnaker fresh), you need to enable GitHub as an artifact source:

Add the following snippet to `SpinnakerService` manifest:

```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:  
    config:
      features:
        artifacts: true
      artifacts:
        github:
          enabled: true
```



### Add a GitHub credential

To access private GitHub repositories, you need a GitHu b**Personal Access
Token**.  See the [GitHub docs](https://docs.github.com/en/enterprise-server@3.4/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) for instructions. The token
needs the `repo` scope.

Once you have a token, you should provide that token for Spinnaker's Igor service
as a credential to use to access GitHub.  

>Replace the account name `github_user` with the string you want to use to identify this GitHub credential.

Add the following snippet to `SpinnakerService` manifest:

```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:  
    config:
      features:
        artifacts: true
      artifacts:
        github:
          enabled: true
          accounts:
          - name: github_user
            token: abc  # GitHub's personal access token. This fields supports `encrypted` references to secrets.
            # username: abc # GitHub username
            # password: abc # GitHub password. This fields supports `encryptedreferences` to secrets.
            # usernamePasswordFile: creds.txt # File containing "username:password" to use for GitHub authentication. This fields supports `encryptedFilereferences` to secrets.
            # tokenFile: token.txt # File containing a GitHub authentication token. This fields supports `encryptedFile` references to secrets.
```

If you have a GitHub Personal Access Token, you only need that to authenticate against GitHub, but there are other authentication options like username/password, or specifying credentials in a `file` entry.

Apply your changes:

```bash
kubectl -n >spinnaker namespace> apply -f <SpinnakerService manifest>
```


## Using the GitHub credential

You may note that the above GitHub "account" doesn't actually have an endpoint for
your GitHub. This account is basically just the credential used by Spinnaker
artifacts to access GitHub.  The actual GitHub API endpoint is specified in the
artifact reference.  The following is an example of how to use this credential.

**Pulling a Kubernetes Manifest from Github**

1. Under **Expected Artifacts** in your pipeline, create an artifact of type **GitHub**.

1. Specify the **file path** as the path within the repository to your file.  For example, if your manifest is at `demo/manifests/deployment.yml` in the Github repository `orgname/reponame` , specify `demo/manifests/deployment.yml`.

1. Check the **Use Default Artifact** checkbox.

1. In the **Content URL**, provide the full path to the *API URI* for your manifest.  Here are some examples of this:

    * If you're using SaaS GitHub, the URI is generally formatted like this: `https://api.github.com/repos/<ORG>/<REPO>/contents/<PATH-TO-FILE>`.
      * For example: `https://api.github.com/repos/armory/demo/contents/manifests/deployment.yml`

    * If you have on-prem Github Enterprise, then the URI may be formatted like this: `https://<GITHUB_URL>/api/v3/repos/<ORG>/<REPO>/contents/<PATH-TO-FILE>`.
      * For example: `http://github.customername.com/api/v3/repos/armory/spinnaker-pipelines/contents/manifests/deployment.yml`

1. Create a **Deploy (Manifest)** stage.  Rather than specifying the manifest directly in the UI, under the **Manifest Source** specify **Artifact**, and in the **Expected Artifact** field, select the artifact you created above.

1. If you have multiple Github Accounts (credentials) added to your Spinnaker cluster, there should be a dropdown to select which one to use.


## Troubleshooting credentials and URIs

To verify that your token and URI are correct, you can run a `curl` command to
test authentication (the `user` field doesn't matter):

```bash
curl https://api.github.com/repos/armory/demo/contents/manifests/deployment.yml \
  -u nobody:abcdef0123456789abcdef0123456789abcdef01
```

If you receive metadata about your file, the credential and URI are correct.
