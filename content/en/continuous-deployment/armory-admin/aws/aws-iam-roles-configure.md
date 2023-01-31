---
title: "Configure AWS for Spinnaker Using IAM Instance Roles"
linkTitle: Configure AWS (IAM Instance Roles)
aliases:
  - /spinnaker_install_admin_guides/add-aws-account-iam/
  - /spinnaker_install_admin_guides/add_aws_account_iam/
  - /spinnaker-install-admin-guides/add_aws_account_iam/
  - /docs/spinnaker-install-admin-guides/add-aws-account-iam/
  - /docs/armory-admin/aws-iam-roles-configure
  - /armory-admin/aws-iam-roles-configure
description: >
 Learn how to deploy your applications from Spinnaker to Amazon Web Services using IAM Instance Roles.
---

## Overview of deploying applications to AWS

This document will guide you through the following:

* Understanding AWS deployment from Spinnaker<sup>TM</sup>

* Configuring Spinnaker to use AWS IAM Instance Roles (if Spinnaker is running on AWS, either via AWS EKS or installed directly on EC2 instances)
  * Creating a Managed Account IAM Role in each of your target AWS Accounts
  * Creating the default BaseIamRole for use when deploying EC2 instances
  * Creating a Managing Account IAM Policy in your primary AWS Account
  * Adding the Managing Account IAM Policy to the existing IAM Instance Role on the AWS nodes
  * Configuring the Managed Accounts IAM Roles to trust the IAM Instance Role from the AWS nodes
  * Adding the Managed Accounts to Spinnaker
  * Adding/Enabling the AWS Cloud Provider to Spinnaker

## Prerequisites for deploying to AWS

* You installed Spinnaker with Operator.
* You have access to the Spinnaker config files, and a way to apply them (`kubectl` for Operator).
* If you're using Operator, you have a access to run `kubectl` commands against the cluster where Spinnaker is installed.
* You have permissions to create IAM roles using IAM policies and permissions, in all relevant AWS accounts.
  * You should also be able to set up cross-account trust relationships between IAM roles.
* If you want to add the IAM Role to Spinnaker via an Access Key/Secret Access Key, you have permissions to create an IAM User.
* If you want to add the IAM Role to Spinnaker via IAM instance profiles/policies, you have permissions to modify the IAM instance.

>All configuration with AWS in this document will be handled via the browser-based AWS Console.  All configurations could **alternatively** be configured via the `aws` CLI, but this is not currently covered in this document.

Also - you will be granting AWS Power User Access to each of the Managed Account Roles.  You could optionally grant fewer permissions, but those more limited permissions are not covered in this document.

## Background: Understanding AWS Deployment from Spinnaker

Even if Spinnaker is installed in Kubernetes, it can be used to deploy to other cloud environments, such as AWS.  Rather than granting Spinnaker direct access to each of the target AWS accounts, Spinnaker will assume a role in each of the target accounts.

### Deploying to AWS EC2

Spinnaker is able to deploy EC2 instances via Auto Scaling Groups.

* Spinnaker's Clouddriver Pod should be able to assume a **Managed Account Role** in each deployment target AWS account, and use that role to perform any AWS actions.  This may include one or more of the following:
  * Create AWS Launch Configurations and Auto Scaling Groups to deploy AWS EC2 instances
  * Run ECS Containers
  * Run AWS Lambda Actions (alpha/beta as of the time of this document)
  * Create AWS CloudFormation Stacks (alpha/beta as of the time of this document)
* Clouddriver is configured with direct access to a **"Managing Account"** Policy (_it may be helpful to think of this as the **Master** or **Source** Policy_), which is accomplished in one of two ways:
  * If Spinnaker is running in AWS (either in AWS EKS, or with Kubernetes nodes running in AWS EC2), the Managing Account Policy can be made available to Spinnaker by adding it to the AWS nodes (EC2 instances) where the Spinnaker Clouddriver pod(s) are running.
    * _(You can also use Kube2IAM or similar capabilities, but this is not covered in this document)_
  * An IAM User with access to the Managing Account Policy can be passed directly to Spinnaker via an Access Key and Secret Access Key
* For each AWS account that you want Spinnaker to be able to deploy to, Spinnaker needs a **"Managed Account"** Role in that AWS account, with permissions to do the things you want Spinnaker to be able to do (_it may be helpful to think of this as a **Target Role**_)
* The Managing Account Role (Source/Master Role) should be able to assume each of the Managed Account Roles (Target Roles).  This requires two things:
  * The Managing Account Role needs a permission string for each Managed Account it needs to be able to assume.  _It may be helpful to think of this as an outbound permission._
  * Each Managed Account needs to have a trust relationship with the Managing Account User or Role to allow the Managing Account User or Role to assume it.  _It may be helpful to think of this as an inbound permission._

In addition, if you are deploying EC2 instances with AWS, you will need to provide an IAM role for each instance.  If you do not specify a role, Spinnaker will attempt to use a role called `BaseIAMRole`.  So you should create a BaseIAMRole (potentially with no permissions).


### Deployment scenario

Here's an example situation:

* We would like Armory to deploy to three AWS accounts, with account IDs 111111111111, 222222222222, and 333333333333.  Each of these is a *Managed Account*
* Choose one account (111111111111), that Armory will log into directly.  This is the *Managing Account*
* We will end up with four IAM entities:
  * A *Managing Account Policy* in account 111111111111 (`arn:aws:iam::111111111111:user/managingAccount`)
  * A *Managed Account Role* in account 111111111111 (`arn:aws:iam::111111111111:role/spinnakerManaged`)
  * A *Managed Account Role* in account 222222222222 (`arn:aws:iam::222222222222:role/spinnakerManaged`)
  * A *Managed Account Role* in account 333333333333 (`arn:aws:iam::333333333333:role/spinnakerManaged`)
* The *Managing Account Policy* needs these:
  * The `sts:AssumeRole` permission for each of the Managed Account Roles
  * The `ec2:DescribeAvailabilityZones` permission
  * The `ec2:DescribeRegions` permission
  * It should be attached to the IAM Instance Role where Armory is running
* Each *Managed Account Role* needs these:
  * **PowerUserAccess**
  * The `iam:PassRole` permission for roles that will be assigned to EC2 instances that are being deployed
  * A trust relationship with the IAM Instance Role attached to the EC2 instances where Armory is running (to allow Armory to assume the Managed Account Role)

### Spinnaker configuration examples

{{< tabs name="configure" >}}
{{% tabbody name="Operator" %}}

Here's a sample `SpinnakerService` manifest block that supports the above:

   ```yaml
   apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
   kind: SpinnakerService
   metadata:
     name: spinnaker
   spec:
     spinnakerConfig:
       config:
         providers:
           aws:
             enabled: true
             accounts:
             - name: aws-1
               requiredGroupMembership: []
               providerVersion: V1
               permissions: {}
               accountId: '111111111111'
               regions:
               - name: us-east-1
               - name: us-west-2
               assumeRole: role/spinnakerManaged
             - name: aws-2
               requiredGroupMembership: []
               providerVersion: V1
               permissions: {}
               accountId: '222222222222'
               regions:
               - name: us-east-1
               - name: us-west-2
               assumeRole: role/spinnakerManaged
             - name: aws-3
               requiredGroupMembership: []
               providerVersion: V1
               permissions: {}
               accountId: '333333333333'
               regions:
               - name: us-east-1
               - name: us-west-2
               assumeRole: role/spinnakerManaged
             # Because we're baking in 111111111111, this must match the accountName that is associated with 111111111111
             primaryAccount: aws-1
             bakeryDefaults:
               templateFile: aws-ebs-shared.json
               baseImages: []
               awsAssociatePublicIpAddress: true
               defaultVirtualizationType: hvm
             defaultKeyPairTemplate: '{{name}}-keypair'
             defaultRegions:
             - name: us-west-2
             defaults:
               iamRole: BaseIAMRole
   ```

{{% /tabbody %}}
{{< /tabs >}}

## Configuring Armory to use AWS IAM Instance Roles

If you are running Armory on AWS (either via AWS EKS or installed directly on EC2 instances), you can use AWS IAM roles to allow Clouddriver to interact with the various AWS APIs across multiple AWS Accounts.

### Instance Role Part 1: Creating a Managed Account IAM Role in each your target AWS Accounts

In each account that you want Armory to deploy to, you should create an IAM role for Armory to assume.

For each account you want to deploy to, perform the following:

1. Log into the browser-based AWS Console
1. Navigate to the IAM page (click on "Services" at the top, then on "IAM" under "Security, Identity, & Compliance")
1. Click on "Roles" on the left hand side
1. Click on "Create role"
1. For now, for the "Choose the service that will use this role", select "EC2".  We will change this later, because we want to specify an explicit consumer of this role later on.
1. Click on "Next: Permissions"
1. Search for "PowerUserAccess" in the search filter, and select the Policy called "PowerUserAcces"
1. Click "Next: Tags"
1. Optionally, add tags that will identify this role.
1. Click "Next: Review"
1. Enter a Role Name.  For example, "DevSpinnakerManagedRole".  Optionally, add a description, such as "Allows Armory Dev Cluster to perform actions in this account."
1. Click "Create Role"
1. In the list of Roles, click on your new Role (you may have to scroll down or filter for it).
1. Click on "Add inline policy" (on the right).
1. Click on the "JSON" tab, and paste in this:

   ```json
   {
       "Version": "2012-10-17",
       "Statement": [
           {
               "Action": [
                 "iam:ListServerCertificates",
                 "iam:PassRole"
               ],
               "Resource": [
                   "*"
               ],
               "Effect": "Allow"
           }
       ]
   }
   ```

1. Click "Review Policy"
1. Call it "PassRole-and-Certificates", and click "Create Policy"
1. Copy the Role ARN and save it.  It should look something like this: `arn:aws:iam::123456789012:role/DevSpinnakerManagedRole`.  **This will be used in the section "Instance Role Part 3", and in section "Instance Role Part 6"**

You will end up with a Role ARN for each Managed / Target account.  The Role names do not have to be the same (although it is a bit cleaner if they are).  For example, you may end up with roles that look like this:

* `arn:aws:iam::123456789012:role/DevSpinnakerManagedRole`
* `arn:aws:iam::123456789013:role/DevSpinnakerManagedRole`
* `arn:aws:iam::123456789014:role/DevSpinnakerManaged`

### Instance Role Part 2: Creating the BaseIAMRole for EC2 instances

When deploying EC2 instances, Armory currently requires that you attach a role for each instance (even if you don't want to grant the instance any special permissions.  If you do not specify an instance role, Armory will default to a role called `BaseIAMRole`, and it will throw an error if this does not exist.  Therefore, you should at a minimum create an empty role called BaseIAMRole.

1. Log into the browser-based AWS Console
1. Navigate to the IAM page (click on "Services" at the top, then on "IAM" under "Security, Identity, & Compliance")
1. Click on "Roles" on the left side
1. Click "Create role"
1. Select "EC2", and click "Next: Permissions"
1. Click "Next: Tags"
1. Optionally, add tags if required by your organization.  Then, click "Next: Review".
1. Specify the Role Name as "BaseIAMRole"

### Instance Role Part 3: Creating a Managing Account IAM Policy in your primary AWS Account

In the account that Armory lives in (i.e., the AWS account that owns the EKS cluster where Armory is installed), create an IAM Policy with permissions to assume all of your Managed Roles.

1. Log into the AWS account where Armory lives, into the browser-based AWS Console
1. Navigate to the IAM page (click on "Services" at the top, then on "IAM" under "Security, Identity, & Compliance")
1. Click on "Policies" on the left hand side
1. Click on "Create Policy"
1. Click on the "JSON" tab, and paste in this:

   ```json
   {
       "Version": "2012-10-17",
       "Statement": [
           {
               "Effect": "Allow",
               "Action": [
                   "ec2:DescribeAvailabilityZones",
                   "ec2:DescribeRegions"
               ],
               "Resource": [
                   "*"
               ]
           },
           {
               "Action": "sts:AssumeRole",
               "Resource": [
                   "arn:aws:iam::123456789012:role/DevSpinnakerManagedRole",
                   "arn:aws:iam::123456789013:role/spinnakerManaged",
                   "arn:aws:iam::123456789014:role/DevSpinnakerManaged"
               ],
               "Effect": "Allow"
           }
       ]
   }
   ```

1. Update the `sts:AssumeRole` block with the list of Managed Roles you created in **Instance Role Part 1**.
1. Click on "Review Policy"
1. Create a name for your policy, such as "SpinnakerManagingPolicy".  *This policy will be attached to your Armory instance, so give it a name describing your Armory instance.*  Optionally, add a descriptive description.  Copy the name of the policy.  **This will be used in the next section, "Instance Role Part 4"**
1. On the list policies, click your newly-created Policy.

_(This policy could also be attached inline directly to the IAM Instance Role, rather than creating a standalone policy)_

### Instance Role Part 4: Adding the Managing Account IAM Policy to the existing IAM Instance Role on the AWS nodes

1. Log into the AWS account where Armory lives, into the browser-based AWS Console
1. Navigate to the EC2 page (click on "Services" at the top, then on "EC2" under "Compute")
1. Click on "Running Instances"
1. Find one of the nodes which is part of your EKS or other Kubernetes cluster, and select it.
1. In the Instance details section of the screen (in the lower half), find the "IAM Role" and click on it to go to the Role page.
1. Click on "Attach Policies"
1. Search for the Policy that you created, and select it.
1. Click "Attach Policy"
1. Back on the screen for the Role, copy the node role ARN.  It should look something like this: `arn:aws:iam::123456789010:role/node-role`.  **This will be used in the next section, "Instance Role Part 5"**

Note: If your instances do not have an IAM instance profile and role attached to them, you can follow these steps to create and attach one:

1. Log into the AWS account where Armory lives, into the browser-based AWS Console
1. Navigate to the IAM page (click on "Services" at the top, then on "IAM" under "Security, Identity, & Compliance"
1. Click on "Roles"
1. Click on "Create role"
1. Select "EC2" for the service that will use the role, and click "Next: Permissions"
1. In the policy filter, enter the name of the managing policy you created in step 3.  Click "Next: Tags"
1. Add any relevant tags.  Click "Next: Review"
1. Give the role a name, such as "Armory". *This role will be attached to your Armory instance, so give it a name describing your Armory instance.*  Optionally, add a descriptive description.  Copy the name of the role.
1. Navigate to the EC2 page (click on "Services" at the top, then on "EC2" under "Compute")
1. Click on "Running Instances"
1. Find one of the nodes which is part of your EKS or other Kubernetes cluster, and select it.
1. Click "Actions" at the top, then select "Instance Settings" and then "Attach/Replace IAM Role"
1. In the "IAM role" dropdown, select the IAM role that you just created
1. Click "Apply"
1. Repeaat the last four steps for each of the other instances in your EKS or Kubernetes cluster.


### Instance Role Part 5: Configuring the Managed Accounts IAM Roles to trust the IAM Instance Role from the AWS nodes

Now that we know what role will be assuming each of the Managed Roles, we must configure the Managed Roles (Target Roles) to trust and allow the Managing (Assuming) Role to assume them.  This is called a "Trust Relationship" and is configured each of the Managed Roles (Target Roles).

For each account you want to deploy to, perform the following:

1. Log into the browser-based AWS Console
1. Navigate to the IAM page (click on "Services" at the top, then on "IAM" under "Security, Identity, & Compliance")
1. Click on "Roles" on the left hand side
1. Find the Managed Role that you created earlier in this account, and click on the Role Name to edit the role.
1. Click on the "Trust relationships" tab.
1. Click on "Edit trust relationship"
1. Replace the Policy Document with this (Update the ARN with the node role ARN from "Instance Role Part 4")

   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Principal": {
           "AWS": [
             "arn:aws:iam::123456789010:role/node-role"
           ]
         },
         "Action": "sts:AssumeRole"
       }
     ]
   }
   ```

8. Click "Update Trust Policy", in the bottom right.

### Instance Role Part 6: Adding the Managed Accounts to Armory

The Clouddriver pod(s) should be now able to assume each of the Managed Roles (Target Roles) in each of your Deployment Target accounts.  We need to configure Armory to be aware of the accounts and roles its allowed to consume.

{{< tabs name="managed" >}}
{{% tabbody name="Operator" %}}

For each of the Managed (Target) accounts you want to deploy to, add a new entry to the `accounts` array in `SpinnakerService` manifest as follows:

```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
name: spinnaker
spec:
spinnakerConfig:
  config:
    providers:
      aws:
        enabled: true
        accounts:
        - name: aws-dev-1                   # Should be a unique name which is used in the Armory UI and API  to identify the deployment target.  For example, aws-dev-1 or aws-dev-2
          requiredGroupMembership: []
          providerVersion: V1
          permissions: {}
          accountId: '111111111111'         # Should be the account ID for the Managed Role (Target Role) you are  assuming.  For example, if the role ARN is arn:aws:iam::123456789012:role/ DevSpinnakerManagedRole, then ACCOUNT_ID would be 123456789012
          regions:                          # Configure the regions you want to deploy to
          - name: us-east-1
          - name: us-west-2
          assumeRole: role/spinnakerManaged # Should be the full role name within the account, including the type of object (role). For example, if the role ARN is arn:aws:iam::123456789012:role/DevSpinnakerManagedRole, then ROLE_NAME would be role/DevSpinnakerManagedRole
        primaryAccount: aws-dev-1
        bakeryDefaults:
          templateFile: aws-ebs-shared.json
          baseImages: []
          awsAssociatePublicIpAddress: true
          defaultVirtualizationType: hvm
        defaultKeyPairTemplate: '{{name}}-keypair'
        defaultRegions:
        - name: us-west-2
        defaults:
          iamRole: BaseIAMRole

```

{{% /tabbody %}}
{{< /tabs >}}

### Instance Role Part 7: Adding/Enabling the AWS CloudProvider configuration to Armory

{{< tabs name="enable" >}}
{{% tabbody name="Operator" %}}

Apply the changes done in `Spinnakerservice` manifest:

```bash
kubectl -n <spinnaker namespace> apply -f <SpinnakerService manifest file>
```

{{% /tabbody %}}
{{< /tabs >}}
