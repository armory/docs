This PR isn't ready until this file is gone, it's the source content from which the pages are being built

If you like what you have setup you can push the internal git clone to your repository for future use.


## Part 2

Now we’ll connect your Armory PoC to other tools in your CI/CD toolchain.  The integrations will be applied to Armory through Kustomize patch files to a larger SpinnakerService.yaml.  Here are the specific platforms you can connect to through this guide.  


- Jenkins CI 
- Github - Source Control
- Slack Chat Ops

#1. Jenkins - Create “User” and “Token” to authenticate to your Jenkins Cluster’s hostname.  The Token will be stored as a Kubernetes secret, The Username and Hostname will be stored in a yaml patch file to be added to your SpinnakerService.yaml which will enable the integration.

Secret:

    /home/ubuntu/spinnaker/spinsvc/secrets/sed -i -e 's/jenkins-token=xxx/jenkins-token=11de90c538b0c2c07b6827783ccebb7859/g' secrets-example.env

Username / Hostname patch location:

    /home/ubuntu/spinnaker/spinsvc/accounts/ci/patch-jenkins.yml

Apply Patch with Kustomize:
**uncomment** to add patch in kustomization.yml file

    # Artifacts & Accounts
    - accounts/ci/patch-jenkins.yml

Apply Patch (Note -k instead of -f to use Kustomize in Kubectl):

    /home/ubuntu/spinnaker/spinsvc/kubectl apply -k .

Guided Walkthrough!  Here is a video showing the Jenkins Integration. → LINK

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




DONE!  Kick the tires and contact Armory if you’d like to enhance your PoC to your use cases!