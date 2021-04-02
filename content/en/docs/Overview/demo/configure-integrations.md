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

1. From the Minnaker host CLI, temporarily set the user, token, and host name as envirnment variables:

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
    sed -i -e 's/jenkins-token=xxx/jenkins-token='"$JENKINSTOKEN"'/g' /home/ubuntu/minnaker-0.1.*/spinsvc/secrets/secrets-example.env
    sed -i -e 's/jenkins.mycompany.com/'"$JENKINSHOST"'/g' /home/ubuntu/minnaker-0.1.*/spinsvc/accounts/ci/patch-jenkins.yml
    sed -i -e 's/john.doe/'"$JENKINSUSER"'/g' /home/ubuntu/minnaker-0.1.*/spinsvc/accounts/ci/patch-jenkins.yml
    #Optional:
    sed -i -e 's/mymaster/'"$JENKINSLABEL"'/g' /home/ubuntu/minnaker-0.1.*/spinsvc/accounts/ci/patch-jenkins.yml
    ```

1.  Unset the environment variables:

    ```bash
    unset JENKINSUSER
    unset JENKINSTOKEN
    unset JENKINSHOST
    unset JENKINSLABEL
    ```


### Apply changes

1. From the `minnaker-0.1.*` directory, open `spinsvc/kustomization.yml`. Under `#Artifacts & Accounts`, uncomment the `patch-jenkins.yml` line:

    ```yaml data-line=8
      # Artifacts & Accounts
      - accounts/kubernetes/patch-kube.yml      # Kubernetes accounts
      - accounts/docker/patch-dockerhub.yml     # Docker accounts
      - accounts/http/patch-http.yml            # HTTP accounts
      - accounts/git/patch-github.yml           # Public GitHub Repos
      - accounts/git/patch-gitrepo.yml          # Public Git Repos
      # - accounts/notifications/patch-slack.yml # Slack Notifications
      - accounts/ci/patch-jenkins.yml          # Jenkins CI Integration
      # - accounts/canary/prometheus.yml        # TODO - need to add CONFIG STORE

    ```

1. Invoke `deploy.sh` to apply the changes:

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

    ![Automated Trigger configuration](/images/overview/demo/AutomatedTrigger.png)

    Click **{{< icon "check-circle" >}} Save Changes**.

1. The next time the selected Jenkins job completes successfully, it will trigger the pipeline:

    ![Example Build triggered by the Jenkins integration](/images/overview/demo/TriggeredBuild.png)

## GitHub


#2. Github - Create a “Personal Access Token” in your github account to allow Armory to authenticate to github repos.  The Token will be stored as a Kubernetes secret and username will be stored in a yaml patch file to be added to your SpinnakerService.yaml which will enable the integration.

Secret:

    /home/ubuntu/spinnaker/spinsvc/secrets/sed -i -e 's/github-token=xxx/github-token=11de90c538b0c2c07b68432iu4h32u434/g' secrets-example.env

User / Hostname patch location:

    /home/ubuntu/spinnaker/spinsvc/accounts/git/patch-github.yml
    /home/ubuntu/spinnaker/spinsvc/accounts/git/patch-gitrepo.yml

Apply Patch with Kustomize:
**uncomment** to add patch in kustomization.yml file

     # Artifacts & Accounts
      - accounts/git/patch-github.yml           
      - accounts/git/patch-gitrepo.yml          

Apply Patch (Note -k instead of -f to use Kustomize in Kubectl):

    /home/ubuntu/spinnaker/spinsvc/kubectl apply -k .

Guided Walkthrough!  Here is a video showing the GitHub Integration. → LINK

**Bonus:** Add Github webhook pointing back to Armory API Gateway for immediate triggering of pipelines.  https://spinnaker.io/setup/triggers/github/

https://docs.armory.io/docs/spinnaker-user-guides/github/

#3. Slack - Create a Slack Application with a Bot and Authentication token.  The token will be stored as a Kubernetes secret and the Bot will be configured in a Slack Channel within your organization.  This allows Armory to send notifications to Slack at any point in the software delivery pipeline including approval for software promotion to next environment (i.e. QA to Stage, Stage to Production).

https://docs.armory.io/docs/armory-admin/notifications-slack-configure/
#1. Create Slack App in your workspace
#2. Create Bot in Slack App with “channel:write” permissions.  Then click “Install Workspace” to generate a Bot auth token.

#3. Input App and Token to Armory Patch files.

    /home/ubuntu/spinnaker/spinsvc/secrets/sed -i -e 's/slack-token=xxx/slack-token=xoxb-16939015395-1777101633666-niXpFiW8aUXgNjBMrqFz4qRL/g' secrets-example.env

#4. Add Slack Patch to SpinnakerService.yml

    

#4. Run Deploy.sh script to create Kubernetes secrets and apply new patch.



## {{% heading "nextSteps" %}}

This demo aims to easily demonstrate the value Armory can provide. Contact Armory to discuss how a full implementation can be configured to your use cases.