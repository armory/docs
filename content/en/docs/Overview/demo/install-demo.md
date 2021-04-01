---
title: Deploy an EC2 Instance and Install Minnaker
linkTitle: "Deploy & Install"
description: "Deploy an EC2 (or other) host and install Minnaker."
weight: 2
---

## Create your environment

Provision an instance that meets the minimum requirements outlined previously.

You can do this through the AWS Console or the AWS CLI:

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
* `30080` for the demo app

> The example above assume an EC2 instance in AWS, but you can use any similar virtual machine from your preferred cloud provider (GCP, Azure, OCI, etc.).

## Install Minnaker

1. Log into the instance created above and run the following commands.

    ```bash
    # Download the latest release of Minnaker:
    curl -LO https://github.com/armory/minnaker/releases/latest/download/minnaker.tgz
    # Extract Minnaker from the archive:
    tar -xzvf minnaker.tgz
    # Execute the installation script:
    ./minnaker/scripts/install.sh
    ```

    The commands above declaratively deploy Armory using `git clone`, [Kustomize](https://kustomize.io/), and [Armory Operator]({{< ref "operator" >}}).  The entire configuration is GitOps enabled for you so you can ‘git push’ your configurations to your own source control. 

1. The creating of namespaces, loading for CRD and Operator takes around 3 minutes to get Spinnaker fully installed with all services in a “Running” state. The script ends by running a `watch` command to monitor the state of deployment. The environment is ready when the `spinnakerservice` service reads an "OK" status:

    ![Excerpt of the output of kubectl when the service is stood up.](/images/overview/demo/SpinnakerServiceStatus.png)

1. Exit from the `watch` command (Ctrl+C) to see the address, username, and password. You can view this again in the future by running `spin_endpoint`:


    ```bash
    https://198.51.100.5
    username: 'admin'
    password: 'Xx04dLTZjvVZqPg7D4nZPU6Z0DeRmmvye2ptSBaydK3tJFZj'
    ```

1. Using the information above, you can go to your new Spinnaker instance in your browser and log in. You should get a pretty sparse welcome:

    ![Screenshot of the default Spinnaker landing page](/images/overview/demo/SpinnakerFirstView.png)

## {{% heading "nextSteps" %}}

In the [next section]({{< ref "configure-deployment" >}}), we'll use the pre-installed sample application to configure some common pipelines.
