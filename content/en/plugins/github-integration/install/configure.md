---
title: Configure GitHub Integration Features
linkTitle: Configure Features
weight: 10
description: >
  Learn how to configure advanced GitHub Integration features in your Spinnaker or Armory CD instance.
---

![Proprietary](/images/proprietary.svg) ![Beta](/images/beta.svg)

## Authorization (AuthZ)

This feature enables AuthZ support for GitHub App accounts.

Fiat is the Spinnaker microservice responsible for authorization (authz) for the other Spinnaker services. It is not enabled by default, so users are able to perform any action in Spinnaker. When enabled, Fiat checks the user's permissions before allowing the action to proceed.

The GitHub Integration plugin supports Fiat authz for GitHub App accounts configured to determine whether a role or group can perform the following actions:

- `READ`: A user can view the GitHub App account's configuration and/or use it as a trigger source.
- `WRITE`: A user can use the GitHub App account as the target account for the GitHub integration plugin stages.

### How this feature works

```mermaid
sequenceDiagram
	participant user as User
	participant gate as Gate
	participant orca as Orca
	participant igor as Igor
	participant fiat as Fiat
	participant gh as GitHub

user ->> gate: Start execution for pipeline (includes plugin stage)
gate ->> orca: Submit execution for pipeline (includes plugin stage)
orca ->> igor: Submit the task operations of plugin stage
igor ->> fiat: Check hasPermissions
alt Unauthorized
	fiat ->> igor: hasPermissions=false 
	igor ->> orca: Fail with Forbidden
	orca ->> gate: TERMINAL
else Authorized
	fiat ->> igor: hasPermissions=true
	igor ->> orca: IN_PROGRESS
	igor ->> gh: API calls
	orca ->> gate: IN_PROGRESS
end
```

### {{% heading "prereq" %}}

- You are familiar with how Spinnaker's [AuthZ]({{< ref "continuous-deployment/overview/fiat-permissions-overview" >}}) works.
- You have read the GitHub Integration Plugin [overview]({{< ref "plugins/github-integration/_index.md" >}}).
- You have enabled Fiat in your Spinnaker or Armory CD instance integrated with an external identity provider (IDP).

### How to enable AuthZ support

You can enable AuthZ support per GitHub App account by setting the `permissions` block in the `github-integration-plugin.yml` file. For example:

{{< highlight yaml "linenos=table,hl_lines=10-17 32-37" >}}
github:
  plugin:
    accounts:
      - name: FirstAppRepo
        organization:  company-public
        repository: first-app-repo
        defaultBranch: master
        githubAppId: 9753
        githubAppPrivateKey: encrypted:k8s!n:spin-secrets!k:github-app-9753-privatekey
        permissions:
          READ: 
            - "read-only-role"
            - "dev-role"
            - "ops-role"
          EXECUTE:
            - "dev-role"
            - "ops-role"
      - name: SecondAppRepo
        organization:  company-public
        repository: second-app-repo
        defaultBranch: main
        githubAppId: 9753
        githubAppPrivateKey: encrypted:k8s!n:spin-secrets!k:github-app-9753-privatekey
        permissions: []
      - name: CompanyPrivateOrgAllRepos
        organization: company-private
        orgWideInstallation: true
        includePublicRepositories: false
        defaultBranch: main
        githubAppId: 1357
        githubAppPrivateKey: encrypted:k8s!n:spin-secrets!k:github-app-1357-privatekey
        permissions:
          READ:
            - "read-only-role"
            - "ops-role"
          EXECUTE:
            - "ops-role"
{{< /highlight >}}

## Validate GitHub access

This feature validates GitHub access based on configuration assigned to a GitHub App account.

Using the `impersonateGitHubTeam` feature, you can validate and enforce GitHub App account access to repositories based on the GitHub team's assigned configuration.

### How this feature works

Before performing any action in a pipeline stage, the plugin validates that the GitHub teams configured using the `impersonateGitHubTeam` feature are assigned with one of the following roles in GitHub:

- `Admin`: Full access to the repository
- `Write`: Read and write access to the repository
- `Maintain`: Read and write access to the repository, including managing issues and pull requests

If the GitHub team does not have appropriate access to the repository, the pipeline stage fails with an error message.

```mermaid
sequenceDiagram
	participant user as User
	participant gate as Gate
	participant orca as Orca
	participant igor as Igor
	participant fiat as Fiat
	participant gh as GitHub

user ->> gate: Start execution for pipeline (includes plugin stage)
gate ->> orca: Submit execution for pipeline (includes plugin stage)
orca ->> igor: Submit the task operations of plugin stage
igor ->> fiat: Check hasPermissions
alt Unauthorized
	fiat ->> igor: hasPermissions=false 
	igor ->> orca: Fail with Forbidden
	orca ->> gate: TERMINAL
else Authorized
	fiat ->> igor: hasPermissions=true
	igor ->> gh: Check permissions on Repository
	gh ->> igor: Permissions
	igor ->> igor: Evaluate Repo permissions
	alt Unauthorized_onRepo
	igor ->> orca: Fail with Forbidden on Repo Access
	else Authorized_onRepo
	orca ->> gate: IN_PROGRESS
	end
end
```

### How to enable

You enable the `impersonateGitHubTeam` feature per GitHub App account by setting the `impersonateGitHubTeam` block in the `github-integration-plugin.yml` file. For example:

{{< highlight yaml "linenos=table,hl_lines=26-28 36-37" >}}
github:
  plugin:
    accounts:
      - name: FirstAppRepo
        organization:  company-public
        repository: first-app-repo
        defaultBranch: master
        githubAppId: 9753
        githubAppPrivateKey: encrypted:k8s!n:spin-secrets!k:github-app-9753-privatekey
        permissions:
          READ: 
            - "read-only-role"
            - "dev-role"
            - "ops-role"
          EXECUTE:
            - "dev-role"
            - "ops-role"
        impersonateGitHubTeam: []
      - name: SecondAppRepo
        organization:  company-public
        repository: second-app-repo
        defaultBranch: main
        githubAppId: 9753
        githubAppPrivateKey: encrypted:k8s!n:spin-secrets!k:github-app-9753-privatekey
        permissions: []
        impersonateGitHubTeam:
          - "dev-github-team"
          - "ops-github-team"
      - name: CompanyPrivateOrgAllRepos
        organization: company-private
        orgWideInstallation: true
        includePublicRepositories: false
        defaultBranch: main
        githubAppId: 1357
        githubAppPrivateKey: encrypted:k8s!n:spin-secrets!k:github-app-1357-privatekey
        impersonateGitHubTeam:
          - "admin-github-team"
        permissions:
          READ:
            - "read-only-role"
            - "ops-role"
          EXECUTE:
            - "ops-role"
{{< /highlight >}}

## Configure GitHub Commit Status Echo notifications

### How this feature works

### How to enable

### Migrate from Spinnaker's default implementation

## GitHub Commit Status pipeline stage

### How this feature works

### How to enable

### Migrate from a Orca preconfigured webhook implementation