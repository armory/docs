---
title: Self Service Demo with Armory Enterprise for Spinnaker
linkTitle: "Armory Demo"
description: "This demo is a fully featured proof of concept for Armory Enterprise for Spinnaker™. Walk through installing, configuring, and deploying using sample applications. "
aliases:
  - /spinnaker-install-admin-guides/architecture/
---

## Overview

What is included in Armory Easy Poc? 

Armory Enterprise 

1. IaC using gitops and terraform 
2. Policy Driven Deployment (PDD) - for security and compliance (Security as Code)
3. Declarative Spinnaker Application and Pipelines for (Pipelines as Code)
4. Automatic EKS Provisioning through gitops
5. Armory Agent for Kubernetes (delegate for kubernetes)
6. Enterprise Armory Platform powered by Spinnaker
7. Built in Kubernetes deployment namespace for testing (QA, Stage, Prod)
8. Extension points through yaml (Jenkins, Git, JIRA, Docker hub)

These simple instructions will quickly install the Armory Platform with all features enabled.

This Easy PoC uses K3s as the kubernetes server.  If you already have a kubernetes cluster for testing you can start at Step 2.

## Requirements

Here are the requirements for completing this demo:

* You need to be able to provision instances in your cloud environment.
* The provisioned instance needs to meet the following minimum requirements
  * Ubuntu 18.04
  * 4 vCPUs
  * 16 GB of memory
  * 50 GB of storage


## Step 1. Create your environment

Provision an instance that meets the minimum requirements outlined previously.

You can do this through the AWS Console or the AWS CLI. For the AWS CLI, use a c

```bash
aws ec2 run-instances --image-id `ami-<xxxxxxxx>` --count 1 --instance-type t3.xlarge --key-name `<MyKeyPair>`
```

* Replace `ami-<xxxxxxxx>` with an Ubuntu 18.04 AMI
* Replace `<MyKeyPair>` with your key pair name

As best practice, make sure to configure the Security Group to only allow access from your trusted source IPs.  This ensures that only engineers from your company can access the Armory demo.

For this instance, make sure the following ports are open:

* `22` for SSH 
* `80` for redirects
* `443` for the GUI and API

Note!  - The example above is in AWS.  This can be done in any cloud (GCP, Azure, OCI, etc.)



Step 2. Log into the instance created above and run the following commands.


    curl -LO https://github.com/armory/minnaker/releases/latest/download/minnaker.tgz


    tar -xzvf minnaker.tgz

 

    ./minnaker/scripts/install.sh

The above commands will declaratively deploy Armory using git clone, kustomize, and Armory Operator.  The entire configuration is gitops enabled for you so you can ‘git push’ your configurations to your own source control. 

The creating of namespaces, loading for CRD and Operator takes around 3 minutes to get Spinnaker fully installed with all services in a “Running” state.



Step 3. Access the Armory UI to review first application and pipeline


     http://spinnaker.44.234.x.x.nip.io
    username: 'admin'
    password: 'Xx04dLTZjvVZqPg7D4nZPU6Z0DeRmmvye2ptSBaydK3tJFZj'

If you ever need to get your password for Armory you can run this command at the CLI.


    cat /etc/spinnaker/.hal/.secret/spinnaker_password

Step 4. Run Populate pipeline to get sample apps and deployments for Spinnaker

DONE!  Kick the tires and contact Armory if you’d like to enhance your PoC to your use cases!

If you like what you have setup you can push the internal git clone to your repository for future use.


# Part 2

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




