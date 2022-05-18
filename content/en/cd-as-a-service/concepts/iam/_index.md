---
title: Identity and Access Management Concepts
linkTitle: IAM
description: >
  Learn about Identity and Access Management in Armory Continuous Deployment-as-a-Service.
exclude_search: true
---

## Armory CD-as-a-Service Identity and Access Management (IAM)

Armory CD-as-a-Service uses OIDC to authenticate both user and machine principals and issue short-lived access tokens, which are signed JSON web tokens (JWTs).

The Armory CD-as-a-Service API consumes these access tokens in order to validate that a request has authorization for a given tenant’s resources and operations.

Use the the [CD-as-a-Service Console](https://console.cloud.armory.io/) to manage the following:

- Create credentials for machines and scope them for specific permissions and use cases.
- Invite and manage users.
- Enable OIDC based external identity providers (IdP), such as Okta, Auth0, or OneLogin.

The following concepts can help you when configuring access in the CD-as-a-Service Console:

- **Environment**

  A collection of accounts and their associated resources that you explicitly define. Environments are useful for separation and isolation, such as when you want to have distinct non-production and production environments. Accounts added to one environment are not accessible by machine credentials scoped to another environment.

- **Tenant**

  The combination of an Organization and Environment.

- **Principals**

  There are two types of principals:  a Machine or a User.

  *Machine principals* are credentials that are created within the CD-as-a-Service Console with specific scopes. They are used by service accounts, such as for allowing Spinnaker to connect to Armory CD-as-a-Service.

  *User principals* are users that are invited to an organization, either by being invited or logging in through a configured external (IdP) such as Okta or Auth0.

- **Scopes**

  Scopes are individual permissions that grant access to certain actions. They can be assigned to machine-to-machine credentials. For example, the scope `read:infrastructure:data` allows a machine credential to fetch cached data about infrastructure and list accounts that are registered with the RNA.

- **Groups**

  Groups are attached to user principals and sourced from an external Identity Provider like Okta or LDAP. Note that they are not currently being used by the Armory CD-as-a-Service API.

  ## {{% heading "nextSteps" %}}

  {{< linkWithTitle "cd-as-a-service/tasks/iam/invite-users.md" >}}