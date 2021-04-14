---
title: Configure Integrations
linkTitle: "Configure Integrations"
description: "Configure your Armory Spinnaker demo to integrate with common tools like Slack, GitHub, and Jenkins."
weight: 4
---


Now we’ll connect your Armory PoC to other tools in your CI/CD toolchain.  The integrations will be applied to Armory through Kustomize patch files to a larger SpinnakerService.yaml.  Here are the specific platforms you can connect to through this guide.  

- [Jenkins](https://www.jenkins.io/) - Continuous integration 
- [GitHub](https://github.com/) - Source Control
- [Slack](https://slack.com/) - Chat Ops

## {{% heading "prereq" %}}

This guide assumes you have an implementation of or access to these systems. The demo does not provide a Jenkins instance, for example.

## Jenkins

These steps will let Armory Spinnaker use a Jenkins build as a trigger for deployment. 

### Set variables

1. In your Jenkins instance, create a new user and API token to authenticate to your Jenkins with. The Token will be stored as a Kubernetes secret, The user and host name will be stored in a yaml patch file to be added to `SpinnakerService.yaml`, which will enable the integration.

1. From the Minnaker host CLI, temporarily set the user, token, and host name as environment variables:

    ```bash
    export JENKINSUSER=<username>
    export JENKINSTOKEN=<API-token>
    export JENKINSHOST=<jenkins-domain-name-or-IP>
    ```

    You can optionally set a `$JENKINSLABEL` variable, used to identify this instance of Jenkins in Spinnaker. Otherwise, the default controller label will be "mymaster":

    ```bash
    export JENKINSLABEL=<controller-identifier>
    ```

1. With these variables in place, the following commands will insert the token into `secrets-example.env` and the other values into `patch-jenkins.yml`:

    ```bash
    sed -i -e 's/jenkins-token=xxx/jenkins-token='"$JENKINSTOKEN"'/g' /home/ubuntu/minnaker/spinsvc/secrets/secrets-example.env
    sed -i -e 's/jenkins.mycompany.com/'"$JENKINSHOST"'/g' /home/ubuntu/minnaker/spinsvc/accounts/ci/patch-jenkins.yml
    sed -i -e 's/john.doe/'"$JENKINSUSER"'/g' /home/ubuntu/minnaker/spinsvc/accounts/ci/patch-jenkins.yml
    #Optional:
    sed -i -e 's/mymaster/'"$JENKINSLABEL"'/g' /home/ubuntu/minnaker/spinsvc/accounts/ci/patch-jenkins.yml
    ```

1.  Unset the environment variables:

    ```bash
    unset JENKINSUSER
    unset JENKINSTOKEN
    unset JENKINSHOST
    unset JENKINSLABEL
    ```


### Apply changes

1. From the `minnaker` directory, open `spinsvc/kustomization.yml`. Under `#Artifacts & Accounts`, uncomment the `patch-jenkins.yml` line:

    {{< prism lang=yaml line=8 >}}
      # Artifacts & Accounts
      - accounts/kubernetes/patch-kube.yml      # Kubernetes accounts
      - accounts/docker/patch-dockerhub.yml     # Docker accounts
      - accounts/http/patch-http.yml            # HTTP accounts
      - accounts/git/patch-github.yml           # Public GitHub Repos
      - accounts/git/patch-gitrepo.yml          # Public Git Repos
      # - accounts/notifications/patch-slack.yml # Slack Notifications
      - accounts/ci/patch-jenkins.yml          # Jenkins CI Integration
      # - accounts/canary/prometheus.yml        # TODO - need to add CONFIG STORE
    {{< /prism >}}

1. Run `create-secrets.sh` in `spinsvc/secrets` to update the [Kubernetes Secrets](https://kubernetes.io/docs/concepts/configuration/secret/) with the new token.

1. Run `deploy.sh` to apply the changes to the cluster:

    ```bash
    ./spinsvc/deploy.sh
    ```

    You can use `watch kubectl get pods,spinsvc -n spinnaker` from the host shell to monitor the status of the redeployment.

### Set up the trigger

1. From the Armory Spinnaker UI, navigate back to the "basic-deploy-to-kubernetes" pipeline and select **{{< icon "cog" >}} Configure**, then **Configuration**.

1. Under **Automated Triggers**, click **{{< icon "plus-circle" >}} Add Trigger**. Apply the following values:

    - **Type**: Jenkins
    - **Controller**: The value supplied to `$JENKINSLABEL`, or "mymaster" otherwise.
    - **Job**: Choose a job in from your Jenkins instance. If there is a job you can run arbitrarily with no adverse effects, choose that one.

    ![Jenkins Automated Trigger configuration](/images/overview/demo/JenkinsTrigger.png)

    Click **{{< icon "check-circle" >}} Save Changes**.

1. The next time the selected Jenkins job completes successfully, it will trigger the pipeline:

    ![Example Build triggered by the Jenkins integration](/images/overview/demo/JenkinsTriggeredBuild.png)

## GitHub

Now let's set up a webhook to trigger a pipeline from a push to a GitHub repository.

### Set variables

1. Create a [Personal Access Token](https://github.com/settings/tokens) in your GitHub account to allow Armory to authenticate to your GitHub repos. The Token will be stored as a Kubernetes secret.

1. From your Minnaker host, edit the file `spinsvc/secrets/secrets-example.env` to apply your token to the `github-token` key. You can also use `sed`:

    ```bash
    cd ~/minnaker
    sed -i -e 's/github-token=xxx/github-token=<github-token>/g' spinsvc/secrets/secrets-example.env
    ```

1. Run `create-secrets.sh` in `spinsvc/secrets` to update the generated [Kubernetes Secret](https://kubernetes.io/docs/concepts/configuration/secret/) with the new token.

1. Under `spinsvc/accounts/git/`, open the files `patch-github.yml` and `patch-gitrepo.yml`. Uncomment the `token` key, and confirm that it's using the `github-token` secret:

    ```yaml
                token: encrypted:k8s!n:spin-secrets!k:github-token             # (Secret). GitHub # token.
    ```

1. Invoke `deploy.sh` to apply the changes:

    ```bash
    ./spinsvc/deploy.sh
    ```

   You can use `watch kubectl get pods,spinsvc -n spinnaker` from the host shell to monitor the status of the redeployment.

### Define the webhook

1. From your GitHub account, choose a repository you can use as a test. Ideally, this is a project in which you can commit arbitrary changes to the `main` or `master` branch with no adverse effects.

1. From the repository, click **{{< icon "cog" >}} Settings**, then **Webhooks**. Click **Add webhook** and provide the following values:

    - **Payload URL**: `https://<ip-address>/api/webhooks/git/github`, where `ip-address` is your Minnaker host address. It should be the same value in your browser when viewing the Armory UI.
    - **Content type**: application/json
    - **Secret**: This is used as a handshake between GitHub and Spinnaker. Create a new secret, and save it to provide to Spinnaker in the next section.
    - **SSL Verification**: Disable. As GitHub will tell you, this is not recommended for production environments, but our Minnaker demo does not have a trusted certificate.

    Leave the remaining values at default and click **Add webhook**.

### Set up the trigger

1. From the Armory Spinnaker UI, navigate back to the "basic-deploy-to-kubernetes" pipeline and select **{{< icon "cog" >}} Configure**, then **Configuration**.

1. Under **Automated Triggers**, click **{{< icon "plus-circle" >}} Add Trigger**. Apply the following values:

    - **Type**: Git
    - **Repo Type**: github
    - **Organizatoin or User**: Your GitHub user name.
    - **Project**: Use the repository in which you configured the webhook.
    - **Branch**: The branch to trigger builds on change. Usually `master` or `main`, but if the project is in production, you can use a different branch name in which to make your arbitrary changes.
    - **Secret**: The value provided to GitHub web defining the webhook.

    ![GitHub Automated Trigger configuration](/images/overview/demo/GitHubTrigger.png)

    Click **{{< icon "check-circle" >}} Save Changes**.

1. The next time the selected Jenkins job completes successfully, it will trigger the pipeline:

    ![Example Build triggered by the Jenkins integration](/images/overview/demo/GitHubTriggeredBuild.png)


## Slack

By now you should be getting familiar with how to modify the configuration files needed to enable new features. In this case, read [Configure Slack Notifications in Spinnaker]({{< ref "notifications-slack-configure" >}}) but keep in mind the differences created by our Minnaker deployment:

 - Instead of directly modifying the `SpinnakerService` manifest, uncomment the reference to `patch-slack.yml` in `kustomization.yml`.
 - Instead of storing your token in the patch file direclty, add it to `secrets-example.yml`.
 - Instead of applying the changes with `kubectl apply -f`, re-run `deploy.sh` to add update the Kubernetes Secrets and Kustomization configuration.


## {{% heading "nextSteps" %}}

This demo aims to easily demonstrate the value Armory can provide. Contact Armory to discuss how a full implementation can be configured to your use cases.
